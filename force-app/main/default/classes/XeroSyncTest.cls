/**
 * Tests for XeroSyncLogic and XeroSyncSchedule
 *
 * @author Logan Moore
 * @created August 2013
 */
@isTest
private class XeroSyncTest {
	
	@isTest static void testSync() {

		sfXero.XeroAPI.startTesting();

		Account payerAcc = new Account(name='acc');
		insert payerAcc;
		
		Xero_Key__c xeroKey = new Xero_Key__c();
		xeroKey.Name = 'TestSchool';
		xeroKey.Private_Key__c = ''
			+ 'MIICXAIBAAKBgQCv2NPOk4/UfpMPsOl9DOWoKSS+EDh/g/nFQ+JIHePe2T1wOsrn'
			+ '9ywuh/QLrl984OeHMvJMYg8YDpRr15XCcgbQ66br0WjuJMldt4LbxPj6nta7tyDx'
			+ 't4SLg+38IO5MRDzvf73/BJvoKyNAQRJeJL1YO/JIsp7vLYmdDlsYXNlWSQIDAQAB'
			+ 'AoGADa/VxJVts39qmOUPN2GCmpUhO/3tN9eg4D7JZQ2Wh+jmxE5/LpDpinGgiCw5'
			+ 'WHH082v+uf1D6X5xBPfRu0G+z/EOyeUk36RBLhUZQgrXRwOFGQ3eSWn2n0i+3ghz'
			+ 'uG9fMjX4hiPpPj2+NB1euhCWUOIrr3wxAm8quulihouhtzUCQQDYIjZ5fkDMTyrl'
			+ '4AM4bgXw1pGCKd1No6nWzSG3w8BXUzTyjd7pozxRA1OFMByYCfIgpZcsa8INK+c/'
			+ 'KUF5HKejAkEA0EhJWJSrLmFKCoe8/eW//otAl3awbhefT8Y6WdJTKQEi7jYXjUbA'
			+ '4XrRtHbV7z9YOxbPirEcwcG6OFAa7yqZIwJBAMJk2zwhCyT326yP9DWP97XrN0qs'
			+ 'XsiS+JIjRD1lSh0A0LGMWr8nO3veEwPLBxzUbTth1Ht2nD1+jGnpsGK/HCMCQHXj'
			+ 'VFBk5Xb87hGDvr7emYsTel3Aeh/2Et/uTPymBRfCYuj9iNsX3vhAsg047eHasq/P'
			+ 'O20+zg4E/sf83yHbtI0CQCAQZCz+H9tbfP8NCegkH0shgrm1Ic3qHgEAt3Sm7kRH'
			+ 'Fm4JU0LB/BMdoo3mqJZtN4N16WN68DoC0g8/3mtfTUE=';
		xeroKey.Consumer_Key__c = 'HPED7CKJXLMDO1TR15A5MPF12G4ORH';
		xeroKey.Consumer_Secret__c = 'XFAFUUMMXA58IESPKDP3PG8KADL2DL';
		insert xeroKey;
		
		Invoice_Statement__c invoice = new Invoice_Statement__c();
		invoice.Xero_Id__c = 'DEC9A69C-E6F1-4E66-B925-F5FDCD204F7E';
		invoice.Currency__c = 'USD';
		invoice.School__c = 'Kuala Lumpur';
		invoice.Xero_Key__c = xeroKey.Id;
		invoice.Payer__c = payerAcc.Id;
		insert invoice;

		Xero_Payment__c payment = new Xero_Payment__c();
		payment.Invoice_Statement__c = invoice.Id;
		payment.Xero_Id__c = '6af48534-c0cd-40bb-ba0a-ad2039895fba';
		insert payment;
		
		//Test.setMock(HttpCalloutMock.class, new ServiceMock());
		
		Test.startTest();
		XeroSyncLogic.sync(xeroKey.Id);
		Test.stopTest();

		invoice = [
			SELECT Id, Xero_Invoice_Number__c, Xero_Value__c, Xero_Status__c, Xero_Invoice_Date__c, Xero_Invoice_Currency__c, Reference__c,
			(
				SELECT Id, Xero_Id__c, Payment_Amount__c, Payment_Date__c, Account_Id__c, Reference__c, Currency_Rate__c, Status__c, Xero_Account_Name__c, Payment_Currency__c
				FROM Payments__r
			)
			FROM Invoice_Statement__c
			WHERE Id = :invoice.Id
		];

		System.debug(invoice.Xero_Invoice_Number__c);
		System.debug(invoice.Xero_Value__c);
		System.debug(invoice.Xero_Status__c);
		System.debug(invoice.Xero_Invoice_Date__c);
		System.debug(invoice.Xero_Invoice_Currency__c);
		System.debug(invoice.Reference__c);
		System.debug(invoice.Payments__r.size());

		System.debug(invoice.Payments__r[0].Xero_Id__c);
		System.debug(invoice.Payments__r[0].Payment_Amount__c);
		System.debug(invoice.Payments__r[0].Payment_Date__c);
		System.debug(invoice.Payments__r[0].Account_Id__c);
		System.debug(invoice.Payments__r[0].Reference__c);
		System.debug(invoice.Payments__r[0].Currency_Rate__c);
		System.debug(invoice.Payments__r[0].Status__c);
		System.debug(invoice.Payments__r[0].Xero_Account_Name__c);
		System.debug(invoice.Payments__r[0].Payment_Currency__c);

		sfXero.XeroAPI.stopTesting();
	}

	@isTest static void testSchedule() {

		sfXero.XeroAPI.startTesting();

		Xero_Key__c xeroKey = new Xero_Key__c();
		xeroKey.Name = 'TestSchool';
		xeroKey.Private_Key__c = ''
			+ 'MIICXAIBAAKBgQCv2NPOk4/UfpMPsOl9DOWoKSS+EDh/g/nFQ+JIHePe2T1wOsrn'
			+ '9ywuh/QLrl984OeHMvJMYg8YDpRr15XCcgbQ66br0WjuJMldt4LbxPj6nta7tyDx'
			+ 't4SLg+38IO5MRDzvf73/BJvoKyNAQRJeJL1YO/JIsp7vLYmdDlsYXNlWSQIDAQAB'
			+ 'AoGADa/VxJVts39qmOUPN2GCmpUhO/3tN9eg4D7JZQ2Wh+jmxE5/LpDpinGgiCw5'
			+ 'WHH082v+uf1D6X5xBPfRu0G+z/EOyeUk36RBLhUZQgrXRwOFGQ3eSWn2n0i+3ghz'
			+ 'uG9fMjX4hiPpPj2+NB1euhCWUOIrr3wxAm8quulihouhtzUCQQDYIjZ5fkDMTyrl'
			+ '4AM4bgXw1pGCKd1No6nWzSG3w8BXUzTyjd7pozxRA1OFMByYCfIgpZcsa8INK+c/'
			+ 'KUF5HKejAkEA0EhJWJSrLmFKCoe8/eW//otAl3awbhefT8Y6WdJTKQEi7jYXjUbA'
			+ '4XrRtHbV7z9YOxbPirEcwcG6OFAa7yqZIwJBAMJk2zwhCyT326yP9DWP97XrN0qs'
			+ 'XsiS+JIjRD1lSh0A0LGMWr8nO3veEwPLBxzUbTth1Ht2nD1+jGnpsGK/HCMCQHXj'
			+ 'VFBk5Xb87hGDvr7emYsTel3Aeh/2Et/uTPymBRfCYuj9iNsX3vhAsg047eHasq/P'
			+ 'O20+zg4E/sf83yHbtI0CQCAQZCz+H9tbfP8NCegkH0shgrm1Ic3qHgEAt3Sm7kRH'
			+ 'Fm4JU0LB/BMdoo3mqJZtN4N16WN68DoC0g8/3mtfTUE=';
		xeroKey.Consumer_Key__c = 'HPED7CKJXLMDO1TR15A5MPF12G4ORH';
		xeroKey.Consumer_Secret__c = 'XFAFUUMMXA58IESPKDP3PG8KADL2DL';
		insert xeroKey;

		
		Test.startTest();
		XeroSyncSchedule.schedule();
		Test.stopTest();

		sfXero.XeroAPI.stopTesting();
	}
}