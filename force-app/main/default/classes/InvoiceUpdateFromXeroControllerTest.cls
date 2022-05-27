@isTest
private class InvoiceUpdateFromXeroControllerTest {
    
    @isTest static void testPositive() {
        Xero_Key__c key = new Xero_Key__c();
        key.Name = 'Kuala Lumpur';
        key.Consumer_Key__c = 'test';
        insert key;

        Account payerAcc = new Account(name='acc');
        insert payerAcc;

        Invoice_Statement__c inv = new Invoice_Statement__c();
        inv.Currency__c = 'EUR';
        inv.School__c = key.Name;
        inv.Payer__c = payerAcc.Id;
        insert inv;

        Test.startTest();

        PageReference testPage = Page.InvoiceUpdateFromXero;
        testPage.getParameters().put('id', inv.Id);
        Test.setCurrentPage(testPage);

        ApexPages.StandardController ctl = new ApexPages.StandardController(inv);
        InvoiceUpdateFromXeroController ext = new InvoiceUpdateFromXeroController(ctl);

        sfXero.XeroAPI.startTesting();
        PageReference redirect = ext.doUpdate();
        System.assertNotEquals(null, redirect);
        sfXero.XeroAPI.stopTesting();

        Test.stopTest();
    }

    @isTest static void testException() {
        Xero_Key__c key = new Xero_Key__c();
        key.Name = 'Kuala Lumpur';
        key.Consumer_Key__c = 'test';
        insert key;

        Account payerAcc = new Account(name='acc');
        insert payerAcc;

        Invoice_Statement__c inv = new Invoice_Statement__c();
        inv.Currency__c = 'EUR';
        inv.School__c = key.Name;
        inv.Payer__c = payerAcc.Id;
        insert inv;

        Test.startTest();

        PageReference testPage = Page.InvoiceUpdateFromXero;
        testPage.getParameters().put('id', inv.Id);
        Test.setCurrentPage(testPage);

        ApexPages.StandardController ctl = new ApexPages.StandardController(inv);
        InvoiceUpdateFromXeroController ext = new InvoiceUpdateFromXeroController(ctl);

        // deleting the invoice causes an exception
        delete inv;

        sfXero.XeroAPI.startTesting();
        PageReference redirect = ext.doUpdate();
        system.assertEquals(null, redirect);
        sfXero.XeroAPI.stopTesting();

        Test.stopTest();
    }
}