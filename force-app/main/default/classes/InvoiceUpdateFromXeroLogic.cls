/**
 * Logic to update an invoice from Xero. This code is run by clicking a button on the invoice view,
 * or by a batch job that updates many invoices.
 * 
 * @author Logan moore
 * @created July 2013
 * @modified July 2013
 * @testclass InvoiceUpdateFromXeroLogicTest
 */
public with sharing class InvoiceUpdateFromXeroLogic {

	/** Custom exception class for throwing nice error messages */
	public class UpdateFromXeroException extends Exception {}

	/**
	 * Fetches the related invoice from Xero, and updates information in the local record
	 * to reflect what's stored in Xero. Also updates a list of related payment records.
	 * 
	 * @param invoiceRecordId the id of an Invoice_Statement__c to be updated from Xero
	 * @return true if successfull, else false
	 */
	public static void updateSingleInvoice(Id invoiceRecordId) {

		// Get invoice record for which an update has been requested
		Invoice_Statement__c invoice = queryInvoice(invoiceRecordId);

		// Retrieve the Xero Credentials which depend on the school being used
		Xero_Key__c xeroKey = queryXeroKey(invoice.School__c);

		// Setup the Xero Credentials
		sfXero.XeroCredentials xeroCreds = xeroKeyToCredentials(xeroKey);

		// Fetch the invoice from Xero
		sfXero.XeroInvoiceResponse invoiceResponse = sfXero.XeroAPI.getInvoiceById(xeroCreds, invoice.Xero_Id__c);

		// If no invoices are returned from Xero
		if (invoiceResponse.invoices.size() == 0) {
			throw new UpdateFromXeroException('Invoice not found in xero with id ' + invoice.Xero_Id__c);
		}

		// Pull the invoice into it's own variable
		sfXero.XeroInvoice xeroInvoice = invoiceResponse.invoices[0];

		// Write the xero invoice details to the salesforce invoice record
		invoice.Xero_Id__c = xeroInvoice.invoiceId;
		invoice.Xero_Invoice_Number__c = xeroInvoice.invoiceNumber;
		invoice.Xero_Value__c = xeroInvoice.total;
		invoice.Xero_Status__c = String.valueOf(xeroInvoice.status);
		invoice.Xero_Invoice_Date__c = xeroInvoice.issuedDate;
		invoice.Xero_Invoice_Currency__c = xeroInvoice.currencyCode;
		
		if (invoice.Payments__r.size() == 0 && xeroInvoice.payments.size() == 0) { // There are no payments in SF or Xero... just update the invoice

			try {
				update invoice;
			}
			catch (Exception e) {
				throw new UpdateFromXeroException('Failed to update invoice with reason: ' + e.getMessage());
			}
		}
		else { // There are payments, so sync the payments as well

			// Fetch the payments related to the invoice
			sfXero.XeroPaymentResponse paymentsResponse = sfXero.XeroAPI.getPaymentsAll(
				xeroCreds,
				null,
				'Invoice.InvoiceID = Guid("' + xeroInvoice.invoiceID + '")',
				null
			);

			// Pull the payments into their own list
			List<sfXero.XeroPayment> xeroPayments = paymentsResponse.payments;
			system.debug(xeroPayments);

			// Lists of records to perform DML on
			List<Xero_Payment__c> paymentsToDelete = new List<Xero_Payment__c>();
			List<Xero_Payment__c> paymentsToUpsert = new List<Xero_Payment__c>();
			Set<String> xeroPaymentIds = new Set<String>();

			// Build a map of account ids to account names for assigning to payment records
			sfXero.XeroAccountResponse accountsResponse = sfXero.XeroAPI.getAccountsAll(xeroCreds,null,null,null);
			Map<String,sfXero.XeroAccount> accountsById = new Map<String,sfXero.XeroAccount>();
			for (sfXero.XeroAccount acc : accountsResponse.accounts) {
				accountsById.put(acc.accountID, acc);
			}

			// Add each payment from xero to the paymentsToUpsert list
			for (sfXero.XeroPayment xp : xeroPayments) {

				system.debug(xp);

				// Store the xero id in the xeroPaymentIds map to detect deleted payments later
				xeroPaymentIds.add(xp.paymentId);

				// Make a new payment record from the XeroPayment
				Xero_Payment__c payment = new Xero_Payment__c();
				payment.Invoice_Statement__c = invoice.Id;
				payment.Xero_Id__c = xp.paymentId;
				payment.Payment_Amount__c = xp.amount;
				payment.Payment_Date__c = xp.paymentDate;
				payment.Account_Id__c = xp.acc.accountId;
				payment.Reference__c = xp.reference;
				payment.Currency_Rate__c = xp.currencyrate;
				payment.Status__c = xp.status;
				if (xp.acc.accountId != null && accountsById.containsKey(xp.acc.accountId)) {
					payment.Xero_Account_Name__c = accountsById.get(xp.acc.accountId).name;
					payment.Payment_Currency__c = accountsById.get(xp.acc.accountId).currencyCode;
				}
				paymentsToUpsert.add(payment);
			}

			// Add any payments that don't exist in Xero to the paymentsToDelete list
			for (Xero_Payment__c sp : invoice.Payments__r) {
				if (!xeroPaymentIds.contains(sp.Xero_Id__c)) {
					paymentsToDelete.add(sp);
				}
			}

			try{
				// Perform DML
				update invoice;
				delete paymentsToDelete; // Delete records that don't exist in Xero
				upsert paymentsToUpsert Xero_Id__c; // Merge records on the Xero_Id__c
			}
			catch (Exception e) {
				throw new UpdateFromXeroException('Failed to sync xero payments for "' + invoice.Id + '" with reason: ' + e.getMessage());
			}
		}
	}

	/**
	 * Attempts to query an invoice for a given an invoice Id, along with all required fields.
	 * 
	 * @param invoiceRecordId
	 * @return the queried Invoice_Statement__c record, null if error or not found
	 */
	private static Invoice_Statement__c queryInvoice(Id invoiceRecordId) {

		List<Invoice_Statement__c> invoices = null;

		try {
			invoices = [
				SELECT School__c, Xero_Id__c, Xero_Invoice_Number__c,
				(
					SELECT Xero_Id__c, Payment_Amount__c, Payment_Date__c 
					FROM Payments__r 
				)
				FROM Invoice_Statement__c
				WHERE Id = :invoiceRecordId
			];
		}
		catch(DMLException e) {
			throw new UpdateFromXeroException('Failed to query Invoice_Statement__c record for "' + invoiceRecordId + '" with reason: ' + e.getMessage());
		}

		if (invoices == null || invoices.size() != 1) { // Invoice not found
			throw new UpdateFromXeroException('Invoice not found for record id ' + invoiceRecordId);
		}

		return invoices[0];
	}

	/**
	 * Attempts to query a Xero Key record for a given school name.
	 * 
	 * @param school The name of a school for which we need to find a xero key
	 * @return the matching xero key for the school, null if error or not found
	 */
	private static Xero_Key__c queryXeroKey(String school) {

		List<Xero_Key__c> xeroKeys = null;

		// The school Pamplona uses the same xero org as Navarra
		if (school == 'Pamplona') {
			school =  'Navarra';
		}

		// Get the Xero key for the given school
		try {
			xeroKeys = [
				SELECT Id, Name, Private_Key__c, Consumer_Key__c, Consumer_Secret__c, 
					AccCode_Tuition__c, AccCode_Lunch__c, AccCode_Bus__c, AccCode_Other__c, 
					AccCode_Enrolment__c, AccCode_Application__c, AccCode_EAL__c 
				FROM Xero_Key__c 
				WHERE Name =: school
			];
		}
		catch(Exception e) {
			throw new UpdateFromXeroException('Failed to query Xero_Key__c records for "' + school + '" with reason: ' + e.getMessage());
		}	

		if(xeroKeys == null || xeroKeys.size() == 0) { // Xero key not found
			throw new UpdateFromXeroException('Xero Credentials not found for ' + school);
		}

		return xeroKeys[0];
	}

	/**
	 * Converts a Xero Key record to a XeroCredentials object.
	 * 
	 * @param xeroKey A Xero_Key__c record for a Xero instance
	 * @return A XeroCredentials object created from the passed in xero key details, null if error or not found
	 */
	private static sfXero.XeroCredentials xeroKeyToCredentials(Xero_Key__c xeroKey) {

		String consumerSecret = (xeroKey.Consumer_Secret__c == null) ? '' : xeroKey.Consumer_Secret__c;
		sfXero.XeroCredentials xeroCreds = new sfXero.XeroCredentials(xeroKey.Consumer_Key__c, consumerSecret, xeroKey.Private_Key__c);
		return xeroCreds;
	}
}