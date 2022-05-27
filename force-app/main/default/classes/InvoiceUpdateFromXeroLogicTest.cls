@isTest
private class InvoiceUpdateFromXeroLogicTest {

    @isTest private static void testPositive() {

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
        inv.Xero_Key__c = key.Id;
        insert inv;

        sfXero.XeroApi.startTesting();

        InvoiceUpdateFromXeroLogic.updateSingleInvoice(inv.Id);

        sfXero.XeroApi.stopTesting();

        inv = [
            SELECT Xero_Value__c, Xero_Invoice_Date__c, Xero_Status__c,
            ( SELECT Id FROM Payments__r )
            FROM Invoice_Statement__c
            WHERE Id = :inv.Id
        ];

        system.assertNotEquals(null, inv.Xero_Value__c);
        system.assertNotEquals(null, inv.Xero_Invoice_Date__c);
        system.assertNotEquals(null, inv.Xero_Status__c);
    }

    @isTest private static void testNullInvoiceId() {

        sfXero.XeroApi.startTesting();

        Boolean exceptionThrown = false;
        try {
            // Use a valid id, that doesn't exist
            InvoiceUpdateFromXeroLogic.updateSingleInvoice('a0dM00000029Qz5');
        }
        catch (InvoiceUpdateFromXeroLogic.UpdateFromXeroException e) {
            // Ensure it's our own exception that was caught
            exceptionThrown = true;
        }
        system.assert(exceptionThrown);

        sfXero.XeroApi.stopTesting();
    }

    @isTest private static void testNoMatchingKey() {

        Xero_Key__c key = new Xero_Key__c();
        key.Name = 'Unmatched';
        key.Consumer_Key__c = 'test';
        insert key;

        Account payerAcc = new Account(name='acc');
        insert payerAcc;

        Invoice_Statement__c inv = new Invoice_Statement__c();
        inv.Currency__c = 'EUR';
        inv.School__c = 'Kuala Lumpur';
        inv.Payer__c = payerAcc.Id;
        inv.Xero_Key__c = key.Id;
        insert inv;

        sfXero.XeroApi.startTesting();

        Boolean exceptionThrown = false;
        try {
            // Use a valid id, that doesn't exist
            InvoiceUpdateFromXeroLogic.updateSingleInvoice('a0dM00000029Qz5');
        }
        catch (InvoiceUpdateFromXeroLogic.UpdateFromXeroException e) {
            // Ensure it's our own exception that was caught
            exceptionThrown = true;
        }
        system.assert(exceptionThrown);

        sfXero.XeroApi.stopTesting();
    }
}