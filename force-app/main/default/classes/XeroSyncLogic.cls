/**
 * Process for querying modified invoices and payments from Xero and merging those updates with Salesforce.
 *
 * @author Logan Moore
 * @created August 2013
 */
public class XeroSyncLogic {
	
	/** Exception thrown by this class */
	public class SyncException extends Exception {}

	/**
	 * When called, looks for all the xero integrations from the Xero_Key__c object, and calls
	 * the syncFuture() for each Xero_Key__c record.
	 */
	public static void syncAll() {

		List<Xero_Key__c> xeroKeys = [SELECT Id FROM Xero_Key__c WHERE Exclude_From_Sync__c = false];

		// Check that there's at least 1 
		if (xeroKeys.size() == 0) {
			throw new SyncException('There are no Xero_Key__c records for syncing');
		}
		else if (xeroKeys.size() > 10) {
			throw new SyncException('XeroInvoiceUpdateLogic can no sync more than 10 Xero orgs');
		}
		
		// For each xero key, fork an asynchronous job to update invoices and payments from the Xero org
		for (Xero_Key__c key : xeroKeys) {
			syncFuture(key.Id);
		}
	}

	/**
	 * Takes a Xero_Key__c Id and passes it to the sync() method, except in an asynchronous context.
	 * It also catches exceptions and passes them to the emailError() method where they get reported.
	 *
	 * @param xeroKeyId the Id of a Xero_Key__c record to sync
	 */
	@future (callout=true)
	public static void syncFuture(Id xeroKeyId) {
		
		sync(xeroKeyId);
	}

	/**
	 * Takes a Xero_Key__c Id and uses it in a sync process with 
	 *
	 * @param xeroKeyId the Id of a Xero_Key__c record to sync
	 */
	public static void sync(Id xeroKeyId) {

		// Get the full Xero_Key__c record with all the data we need for the sync process
		Xero_Key__c xeroKey = xeroKeyById(xeroKeyId);

		// Turn the key into a XeroCredentials object for authorization with the Xero API
		sfXero.XeroCredentials xeroCreds = keyToCreds(xeroKey);

		// Fetch the updated invoices from Xero
		List<Invoice_Statement__c> invoices = syncInvoices(xeroKey, xeroCreds);
		List<Xero_Payment__c> payments = syncPayments(xeroKey, xeroCreds);

		Savepoint sp = Database.setSavepoint();

		try {
			// update the invoices and upsert the payments
			update invoices;
			upsert payments;
			// Update the xero key with the new timestamps ready for the next sync
			update xeroKey;
		}
		catch (Exception e) {
			Database.rollback(sp);
			throw e;
		}
	}

	/**
	 * Queries Xero org for modified payments and then returns a list of Invoice_Statement__c records to be updated.
	 *
	 * @param xeroKey the xeroKey record for the Xero org being synced
	 * @param xeroCreds the XeroCredentials object for authenticating with the Xero API
	 */
	public static List<Invoice_Statement__c> syncInvoices(Xero_Key__c xeroKey, sfXero.XeroCredentials xeroCreds) {

		// Query the modified invoices from Xero
		Datetime modifiedSince = Datetime.newInstance(
			xeroKey.Invoice_Update_Timestamp__c.yearGmt(),
			xeroKey.Invoice_Update_Timestamp__c.monthGmt(), 
			xeroKey.Invoice_Update_Timestamp__c.dayGmt(),
			xeroKey.Invoice_Update_Timestamp__c.hourGmt(),
			xeroKey.Invoice_Update_Timestamp__c.minuteGmt(),
			xeroKey.Invoice_Update_Timestamp__c.secondGmt()
		);
		modifiedSince = modifiedSince.addHours(-12);
		sfXero.XeroInvoiceResponse invoiceResponse = sfXero.XeroAPI.getInvoicesAll(xeroCreds, modifiedSince, null, null);
		List<sfXero.XeroInvoice> xeroInvoices = invoiceResponse.invoices;
		System.debug(xeroInvoices.size() + ' invoices to update');
		
		// Now that the query has been done, set the timestamp for the next query
		xeroKey.Invoice_Update_Timestamp__c = Datetime.valueOfGMT(invoiceResponse.dateUTC.left(19).replace('T', ' '));

		// Make a map of xero invoice id, to xero invoice objects
		Map<String,sfXero.XeroInvoice> xeroInvoiceMap = new Map<String,sfXero.XeroInvoice>();
		for (sfXero.XeroInvoice xinv : xeroInvoices) {
			xeroInvoiceMap.put(xinv.invoiceId, xinv);
		}

		// Query matching invoice ids from Salesforce. Don't worry about checking the school name, since the ids are unique across all xero instances.
		List<Invoice_Statement__c> invoiceChanges = [SELECT Id, Xero_Id__c FROM Invoice_Statement__c WHERE Xero_Id__c IN :xeroInvoiceMap.keySet()];

		// Iterate over the invoices from salesforce, merging in the details from Xero
		for (Invoice_Statement__c sinv : invoiceChanges) {
			sfXero.XeroInvoice xinv = xeroInvoiceMap.get(sinv.Xero_Id__c);
			sinv.Xero_Invoice_Number__c = xinv.invoiceNumber;
			sinv.Xero_Value__c = xinv.total;
			sinv.Xero_Status__c = String.valueOf(xinv.status);
			sinv.Xero_Invoice_Date__c = xinv.issuedDate;
			sinv.Xero_Invoice_Currency__c = xinv.currencyCode;
			sinv.Reference__c = xinv.reference;
		}

		System.debug(invoiceChanges.size() + ' invoice changes');
		return invoiceChanges;
	}

	/**
	 * Queries Xero org for modified invoices and then returns a list of Invoice_Statement__c records to be updated.
	 *
	 * @param xeroKey the xeroKey record for the Xero org being synced
	 * @param xeroCreds the XeroCredentials object for authenticating with the Xero API
	 */
	public static List<Xero_Payment__c> syncPayments(Xero_Key__c xeroKey, sfXero.XeroCredentials xeroCreds) {

		// Query the new and modified payment records from Xero
		Datetime modifiedSince = Datetime.newInstance(
			xeroKey.Payment_Update_Timestamp__c.yearGmt(),
			xeroKey.Payment_Update_Timestamp__c.monthGmt(), 
			xeroKey.Payment_Update_Timestamp__c.dayGmt(),
			xeroKey.Payment_Update_Timestamp__c.hourGmt(),
			xeroKey.Payment_Update_Timestamp__c.minuteGmt(),
			xeroKey.Payment_Update_Timestamp__c.secondGmt()
		);
		modifiedSince = modifiedSince.addHours(-12);
		sfXero.XeroPaymentResponse paymentResponse = sfXero.XeroAPI.getPaymentsAll(xeroCreds, modifiedSince, null, null);
		List<sfXero.XeroPayment> xeroPayments = paymentResponse.payments;
		System.debug(xeroPayments.size() + ' invoices to update');

		// Now that the query has been done, set the timestamp for the next query
		xeroKey.Payment_Update_Timestamp__c = Datetime.valueOfGMT(paymentResponse.dateUTC.left(19).replace('T', ' '));

		// Get the accounts so we can add account details to the payment record
		sfXero.XeroAccountResponse accountsResponse = sfXero.XeroAPI.getAccountsAll(xeroCreds,null,null,null);
		Map<String,sfXero.XeroAccount> accountsById = new Map<String,sfXero.XeroAccount>();
		for (sfXero.XeroAccount acc : accountsResponse.accounts) {
			accountsById.put(acc.accountID, acc);
		}

		// Make lists of ids for querying existing payments and invoices from salesforce
		List<String> paymentIds = new List<String>();
		List<String> invoiceIds = new List<String>();
		for (sfXero.XeroPayment xpay : xeroPayments) {
			paymentIds.add(xpay.paymentId);
			invoiceIds.add(xpay.inv.invoiceId);
		}

		Map<String,Xero_Payment__c> existingPayments = new Map<String,Xero_Payment__c>();
		for (Xero_Payment__c spay : [SELECT Id, Xero_Id__c, Invoice_Statement__c FROM Xero_Payment__c WHERE Xero_Id__c IN :paymentIds]) {
			existingPayments.put(spay.Xero_Id__c, spay);
		}

		Map<String,Invoice_Statement__c> existingInvoices = new Map<String,Invoice_Statement__c>();
		for (Invoice_Statement__c sinv : [SELECT Id, Xero_Id__c FROM Invoice_Statement__c WHERE Xero_Id__c IN :invoiceIds]) {
			existingInvoices.put(sinv.Xero_Id__c, sinv);
		}

		List<Xero_Payment__c> paymentChanges = new List<Xero_Payment__c>();

		for (sfXero.XeroPayment xpay : xeroPayments) {

			Xero_Payment__c spay = existingPayments.containsKey(xpay.paymentId) ? existingPayments.get(xpay.paymentId) : null;
			Invoice_Statement__c sinv = existingInvoices.containsKey(xpay.inv.invoiceId) ? existingInvoices.get(xpay.inv.invoiceId) : null;
			sfXero.XeroAccount xacc = accountsById.containsKey(xpay.acc.accountId) ? accountsById.get(xpay.acc.accountId) : null;

			Xero_Payment__c payment = new Xero_Payment__c();

			// If there's an existing payment, use it's Id to cause an update
			if (spay != null) {
				payment.Id = spay.Id;
			}

			// If there's an existing invoice, use it for the invoice lookup
			else if (spay == null && sinv != null) {
				payment.Invoice_Statement__c = sinv.Id;
			}

			else {
				System.debug('invoice lookup is null, skipping payment');
				continue;
			}

			// Logan testing a date error
			Date fixedDate = Date.newInstance(xpay.paymentDate.year(), xpay.paymentDate.month(), xpay.paymentDate.day());

			// Merge all the simple details
			payment.Xero_Id__c = xpay.paymentId;
			payment.Payment_Amount__c = xpay.amount;
			payment.Payment_Date__c = fixedDate; //xpay.paymentDate;
			payment.Account_Id__c = xpay.acc.accountId;
			payment.Reference__c = xpay.reference;
			payment.Currency_Rate__c = xpay.currencyrate;
			payment.Status__c = xpay.status;

			// Merge details from the xero account
			if (xacc != null) {
				payment.Xero_Account_Name__c = xacc.name;
				payment.Payment_Currency__c = xacc.currencyCode;
			}

			paymentChanges.add(payment);
		}

		System.debug(paymentChanges.size() + ' payment changes');
		return paymentChanges;
	}

	public static Xero_Key__c xeroKeyById(Id xeroKeyId) {

		try {
			Xero_Key__c xeroKey = [
				SELECT Id, Name, Private_Key__c, Consumer_Key__c, Consumer_Secret__c, Invoice_Update_Timestamp__c, Payment_Update_Timestamp__c
				FROM Xero_Key__c 
				WHERE Id =: xeroKeyId
			];

			// If the invoice update timestamp is in the past, set a default value
			if (xeroKey.Invoice_Update_Timestamp__c == null) {
				xeroKey.Invoice_Update_Timestamp__c = Datetime.now().addDays(-1);
			}

			// If the payment update timestamp is in the past, set a default value
			if (xeroKey.Payment_Update_Timestamp__c == null) {
				xeroKey.Payment_Update_Timestamp__c = Datetime.now().addDays(-1);
			}

			return xeroKey;
		}
		catch(Exception e) {
			throw new SyncException('Failed to query Xero_Key__c for Id [' + xeroKeyId + '] with reason: ' + e.getMessage());
		}
	}

	public static sfXero.XeroCredentials keyToCreds(Xero_Key__c xeroKey) {

		String consumerSecret = (xeroKey.Consumer_Secret__c == null) ? '' : xeroKey.Consumer_Secret__c;
		return new sfXero.XeroCredentials(xeroKey.Consumer_Key__c, consumerSecret, xeroKey.Private_Key__c);
	}

	public static void emailError(Exception e) {


	}
}