global class BatchFixInvoices implements Database.Batchable<sObject> {
	
	String query;
	
	global BatchFixInvoices() {
		query = 'SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, '
			+ 'Currency__c, Error_Message__c, Payer__c, Reference__c, Reference_Short__c, Starting_Date__c, Xero_Id__c, School__c, Generated_Date__c, Invoice_Date__c, '
			+ 'Total_Invoice_Value_Calculated__c, Total_Invoice_Value__c, Xero_Invoice_Number__c, Single_Invoice__c, Owner_School__c, Xero_Invoice_Date__c, '
			+ 'Xero_Status__c, Xero_Value__c, Xero_Invoice_Currency__c, Xero_Invoice_Status__c, Total_Xero_Payments_Calculated__c, Total_Xero_Payments__c, '
			+ 'Xero_Invoice_Value__c, Link_to_Xero_Invoice__c, Payer__r.Name '
			+ 'FROM Invoice_Statement__c '
			+ 'WHERE Xero_Invoice_Number__c = null AND Invoice_Export_Fixed__c = false AND Invoice_Export__c = null';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<Invoice_Statement__c> scope) {

		Invoice_Statement__c invoice = scope[0];

		List<Invoice_Export__c> queryMatches = [
			SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp,
				Status__c, LineAmountTypes__c, School__c, Reference__c, Date__c, DueDate__c, Type__c, SubTotal__c, Total__c,
				AmountDue__c, AmountPaid__c, InvoiceNumber__c, FullyPaidOnDate__c, CurrencyCode__c, ContactID__c, ContactName__c,
				Reference_Short__c, (
					SELECT Id FROM Invoices__r
				)
			FROM Invoice_Export__c
			WHERE Type__c = 'ACCREC'
			AND LineAmountTypes__c = 'Inclusive'
			//AND Status__c != 'DELETED'
			//AND Reference_Short__c = :invoice.Reference_Short__c
			AND ContactName__c = :invoice.Payer__r.Name
			//AND CurrencyCode__c = :invoice.Currency__c
			AND Date__c = :invoice.Invoice_Date__c
			//AND DueDate__c = :invoice.Generated_Date__c
			//AND InvoiceNumber__c = :invoice.Xero_Invoice_Number__c
			//AND School__c = :invoice.School__c
			AND School__c = :invoice.School__c
			//AND Total__c = :invoice.Total_Invoice_Value_Calculated__c
			AND IsMatched__c = false
			//AND UpdatedDate__c >= :invoice.CreatedDate
		];

		List<Invoice_Export__c> exactMatches = new List<Invoice_Export__c>();
		for(Invoice_Export__c exp : queryMatches) {
			if (exp.Invoices__r.size() == 0) {
				exactMatches.add(exp);
			}
		}
		if (exactMatches.size() == 1) {
			invoice.Invoice_Export__c = exactMatches[0].Id;
			invoice.Invoice_Export_Error__c = '';
		}
		else if (exactMatches.size() > 1) {
			invoice.Invoice_Export_Error__c = '';
			for (Invoice_Export__c exp : exactMatches) {
				if (invoice.Invoice_Export_Error__c != '') {
					invoice.Invoice_Export_Error__c += '\n';
				}
				invoice.Invoice_Export_Error__c += exp.Id;
			}
			if (invoice.Invoice_Export_Error__c.length() > 255) {
				invoice.Invoice_Export_Error__c = invoice.Invoice_Export_Error__c.left(255);
			}
		}
		else {
			invoice.Invoice_Export__c = null;
			invoice.Invoice_Export_Error__c = 'No Matches';
		}

		update invoice;

		/*List<Invoice_Export__c> fuzzyQuery = [
			SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp,
				Status__c, LineAmountTypes__c, School__c, Reference__c, Date__c, DueDate__c, Type__c, SubTotal__c, Total__c,
				AmountDue__c, AmountPaid__c, InvoiceNumber__c, FullyPaidOnDate__c, CurrencyCode__c, ContactID__c, ContactName__c,
				Reference_Short__c,
			(
				SELECT Id FROM Invoices__r
			)
			FROM Invoice_Export__c
			WHERE Type__c = 'ACCREC'
			//AND Status__c != 'DELETED'
			AND Reference_Short__c = :invoice.Reference_Short__c
			AND CurrencyCode__c = :invoice.Currency__c
			AND Date__c = :invoice.Invoice_Date__c
			AND School__c = :invoice.School__c
			AND Total__c = :invoice.Total_Invoice_Value_Calculated__c
		];

		List<Invoice_Export__c> fuzzyMatches = new List<Invoice_Export__c>();
		for (Invoice_Export__c exp : fuzzyQuery) {
			if (exp.Invoice_Statements__r.size() == 0) {
				fuzzyMatches.add(exp);
			}
		}

		if (exactMatches.size() == 1) {
			invoice.Invoice_Export__c = exactMatches[0].Id;
			invoice.Invoice_Export_Error__c = '';
		}
		else if (exactMatches.size() > 1) {
			invoice.Invoice_Export_Error__c = 'Multiple possible exact matches';
		}
		else if (fuzzyMatches.size() == 1) {
			invoice.Invoice_Export__c = fuzzyMatches[0].Id;
			invoice.Invoice_Export_Error__c = '';
		}
		else if (fuzzyMatches.size() > 1) {

			invoice.Invoice_Export_Error__c = 'Multiple possible fuzzy matches';
		}
		else if (fuzzyMatches.size() == 0) {
			invoice.Invoice_Export_Error__c = 'No fuzzy or exact matches';
		}*/

		//update invoice;

		//School -> Date -> Value -> Invoices

		/*List<String> schoolNames = new List<String>();
		List<String> invoiceNumbers = new List<String>();
		for (Invoice_Statement__c inv : scope) {
			schoolNames.add(inv.School__c);
			invoiceNumbers.add(inv.Xero_Invoice_Number__c);
		}

		List<Invoice_Export__c> matches = [
			SELECT Id, Name, School__c, InvoiceNumber__c, Reference__c
			FROM Invoice_Export__c
			WHERE School__c IN :schoolNames
			AND InvoiceNumber__c IN :invoiceNumbers
		];

		Map<String, Map<String, Map<String, List<Invoice_Export__c>>>> matchMap = new Map<String, Map<String, Map<String, List<Invoice_Export__c>>>>();
		for (Invoice_Export__c exp : matches) {
			Map<String, Map<String, List<Invoice_Export__c>>> schoolPart = matchMap.containsKey(exp.School__c) ? matchMap.get(exp.School__c) : new Map<String, Map<String, List<Invoice_Export__c>>>();
			Map<String, List<Invoice_Export__c>> referencePart = schoolPart.containsKey(exp.InvoiceNumber__c) ? schoolPart.get(exp.InvoiceNumber__c) : new Map<String, List<Invoice_Export__c>>();
			List<Invoice_Export__c> invoicePart = referencePart.containsKey(exp.Reference__c) ? referencePart.get(exp.Reference__c) : new List<Invoice_Export__c>();
			invoicePart.add(exp);
			referencePart.put(exp.Reference__c, invoicePart);
			schoolPart.put(exp.InvoiceNumber__c, referencePart);
			matchMap.put(exp.School__c, schoolPart);
		}

		List<Invoice_Statement__c> invoicesToUpdate = new List<Invoice_Statement__c>();

		for (Invoice_Statement__c inv : scope) {
			if (matchMap.containsKey(inv.School__c)) {
				Map<String, Map<String, List<Invoice_Export__c>>> schoolPart = matchMap.get(inv.School__c);
				if (schoolPart.containsKey(inv.Xero_Invoice_Number__c)) {
					Map<String, List<Invoice_Export__c>> referencePart = schoolPart.get(inv.Xero_Invoice_Number__c);
					if (referencePart.containsKey(inv.Reference__c)) {
						List<Invoice_Export__c> invoicePart = referencePart.get(inv.Reference__c);
						if (invoicePart != null) {
							if (invoicePart.size() == 1) {
								inv.Invoice_Export__c = invoicePart[0].Id;
								inv.Invoice_Export_Error__c = null;
								invoicesToUpdate.add(inv);
							}
							else if (invoicePart.size() > 1) {
								inv.Invoice_Export_Error__c = 'multiple possible matches;';
								for (Invoice_Export__c exp : invoicePart) {
									inv.Invoice_Export_Error__c += '\n' + exp.Id;
								}
								invoicesToUpdate.add(inv);
							}
						}
					}
				}
			}
		}

		if (invoicesToUpdate.size() > 0) {
			update invoicesToUpdate;
		}*/
		
		// Make direct matches... found none
		/*List<String> xeroIds = new List<String>();
		for (Invoice_Statement__c inv : scope) {
			xeroIds.add(inv.Xero_ID__c);
		}

		List<Invoice_Export__c> directMatches = [
			SELECT Id, Name
			FROM Invoice_Export__c
			WHERE Name IN :xeroIds
		];

		Map<String,Invoice_Export__c> exportMap = new Map<String,Invoice_Export__c>();
		for (Invoice_Export__c exp : directMatches) {
			exportMap.put(exp.Name, exp);
		}

		List<Invoice_Statement__c> invoicesToUpdate = new List<Invoice_Statement__c>();
		for (Invoice_Statement__c inv : scope) {
			if (exportMap.containsKey(inv.Xero_ID__c)) {
				inv.Invoice_Export__c = exportMap.get(inv.Xero_ID__c).Id;
				invoicesToUpdate.add(inv);
			}
		}

		if (invoicesToUpdate.size() > 0) {
			update invoicesToUpdate;
		}*/
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
	global static void run() {
		BatchFixInvoices batch = new BatchFixInvoices();
		ID batchprocessid = Database.executeBatch(batch, 1);
	}
}