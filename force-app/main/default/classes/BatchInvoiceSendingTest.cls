@isTest
private with sharing class BatchInvoiceSendingTest {
    
    static testMethod void testInvoiceNoLineItems() {
        //setup the model 
        Account payer = new Account(Name = 'Test');
        insert payer;
        payer = [Select Id From Account Where Id =: payer.Id];
        
        //create a Xero Key
        Xero_Key__c testKey = new Xero_Key__c(
            Name = 'Kuala Lumpur',
            Consumer_Key__c = '...'
        );
        insert testKey;
        
        //create an invoice
        Invoice_Statement__c invoice = new Invoice_Statement__c();
        invoice.payer__c = payer.Id;
        invoice.Reference__c = 'James,Miller';
        invoice.Invoice_Date__c = System.today().addDays(2);
        invoice.Generated_Date__c = System.today();
        invoice.Currency__c = 'USD';
        invoice.School__c = 'Kuala Lumpur';
        invoice.Xero_Key__c = testKey.Id;
        invoice.Xero_Id__c = 'testKey2unique';
        insert invoice;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(invoice);
        SendSingleInvoiceController cont = new SendSingleInvoiceController(sc);
        cont.sendToXero();
        
        PageReference pageRef = Page.SendSingleInvoice;
        pageRef.getParameters().put('id', String.valueOf(invoice.Id));
        Test.setCurrentPage(pageRef);
        
        
        
        //run the batch test
        BatchInvoiceSending batch = new BatchInvoiceSending();
        
        List<Invoice_Statement__c> invoices = new List<Invoice_Statement__c>();
        invoices.add(invoice);
        batch.sendInvoices(invoices);
        
        //make the assertions
        invoice = [
            SELECT Id, Error_Message__c
              FROM Invoice_Statement__c
             WHERE Id =: invoice.Id
        ];
        System.assertEquals('No line items found.', invoice.Error_Message__c);
    }

    static testMethod void testNoXeroKey() {
        //setup the model 
        Account payer = new Account(Name = 'Test');
        insert payer;
        payer = [Select Id From Account Where Id =: payer.Id];

        Opportunity studentOne = new Opportunity(Name = 'Student', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                    Student_Name__c = 'Morgan', //Payer__c = payer.Id,
                                                    Leaving_date__c = System.today().addYears(1), Reason_Leaving__c = 'Relocation (out of city)');
        insert studentOne;
        studentOne.StageName = 'Enrolled';
        update studentOne;
        
        //create a Xero Key
        Xero_Key__c testKey = new Xero_Key__c(
            Name = 'Kuala Lumpur',
            Consumer_Key__c = '...'
        );
        insert testKey;
        
        //create an invoice
        Invoice_Statement__c invoice = new Invoice_Statement__c();
        invoice.payer__c = payer.Id;
        invoice.Reference__c = 'James,Miller';
        invoice.Invoice_Date__c = System.today().addDays(2);
        invoice.Generated_Date__c = System.today();
        invoice.Currency__c = 'USD';
        invoice.School__c = 'Kuala Lumpur';
        invoice.Xero_Key__c = testKey.Id;
        invoice.Xero_Id__c = 'testKey2unique';
        insert invoice;
        
        Line_Item__c lineItem = new Line_Item__c(
            Invoice_Statement__c = invoice.Id,
            Student__c = studentOne.Id,
            Description__c = 'Monthly, Termly or Yearly '     
        );
        insert lineItem;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(invoice);
        SendSingleInvoiceController cont = new SendSingleInvoiceController(sc);
        cont.sendToXero();
        
        PageReference pageRef = Page.SendSingleInvoice;
        pageRef.getParameters().put('id', String.valueOf(invoice.Id));
        Test.setCurrentPage(pageRef);
        
        //run the batch test
        BatchInvoiceSending batch = new BatchInvoiceSending();
        
        List<Invoice_Statement__c> invoices = new List<Invoice_Statement__c>();
        invoices.add(invoice);
        batch.sendInvoices(invoices);
        
        //make the assertions
        invoice = [
            SELECT Id, Error_Message__c
              FROM Invoice_Statement__c
             WHERE Id =: invoice.Id
        ];
        //System.assertEquals('Xero Credentials not found for ', invoice.Error_Message__c);
    }
    
    static testMethod void testInvoiceSendingFirstPrimary() {
        
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //setup the model 
        Account payer = new Account(FirstName = 'Test', LastName = 'Name');
        payer.RecordTypeId = [select Id from RecordType where SObjectType = 'Account' AND DeveloperName = 'PersonAccount'].Id;
        payer.Email_Addresses_to_Include_in_Xero__c ='Parent 1 Main Email;Parent 1 Alternate Email;Parent 2 Main Email;Parent 2 Alternate Email';
        payer.PersonEmail = 'test1@test.com';
        payer.Contact_Alternate_Email__pc = 'test2@test.com';
        
        payer.Primary_Invoicing_Contact__c = 'First Parent'; 
        insert payer;
        
        //create contact
        Contact con =  new Contact();
        con.FirstName = 'test2';
        con.LastName = 'name 2';
        con.Email = 'test23@test.com';
        con.RecordTypeId = [select Id from RecordType where Name = 'Additional Parent' AND SObjectType = 'Contact'].Id;
        con.Contact_Alternate_Email__c = 'tet@vgfhf.com';
        con.AccountId = companyAccount.Id;
        con.Main_Parent_File__c = payer.Id;
        insert con;
        payer.Related_Contact_Record_P2__c = con.Id;
        update payer;
        
        
        payer = [Select Id From Account Where Id =: payer.Id];
        
        Opportunity studentOne = new Opportunity(Name = 'Student', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                    Student_Name__c = 'Morgan', //Payer__c = payer.Id,
                                                    Leaving_date__c = System.today().addYears(1), Reason_Leaving__c = 'Relocation (out of city)');
        insert studentOne;
        studentOne.StageName = 'Enrolled';
        update studentOne;
        
         //create a Xero Key
        Xero_Key__c testKey = new Xero_Key__c(
            Name = 'Kuala Lumpur',
            Consumer_Key__c = '...'
        );
        insert testKey;
        
        //create an invoice and some line items
        Invoice_Statement__c invoice = new Invoice_Statement__c();
        invoice.payer__c = payer.Id;
        invoice.Reference__c = 'James,Miller';
        invoice.Invoice_Date__c = System.today().addDays(2);
        invoice.Generated_Date__c = System.today();
        invoice.Currency__c = 'USD';
        invoice.School__c = 'Kuala Lumpur';
        invoice.Xero_Key__c = testKey.Id;
        insert invoice;
        
        Line_Item__c lineItem = new Line_Item__c(
            Invoice_Statement__c = invoice.Id,
            Student__c = studentOne.Id,
            Description__c = 'Monthly, Termly or Yearly '         
        );
        insert lineItem;
        
        //run the batch test
        BatchInvoiceSending batch = new BatchInvoiceSending();
        
        List<Invoice_Statement__c> invoices = new List<Invoice_Statement__c>();
        invoices.add(invoice);
        batch.sendInvoices(invoices);
        
        //make the assertions
        invoice = [
            SELECT Id, Error_Message__c
              FROM Invoice_Statement__c
             WHERE Id =: invoice.Id
        ];
        System.assertEquals('Test Pass', invoice.Error_Message__c);
    }

    static testMethod void testInvoiceSendingSecondPrimary() {
        
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //setup the model 
        Account acc = new Account(FirstName = 'Test', LastName = 'Name');
        acc.RecordTypeId = [select Id from RecordType where SObjectType = 'Account' AND DeveloperName = 'PersonAccount'].Id;
        acc.Email_Addresses_to_Include_in_Xero__c ='Parent 1 Main Email;Parent 1 Alternate Email;Parent 2 Main Email;Parent 2 Alternate Email';
        acc.PersonEmail = 'test1@test.com';
        acc.Contact_Alternate_Email__pc = 'test2@test.com';        
        insert acc;
        
        //create contact
        Contact payer =  new Contact();
        payer.FirstName = 'test2';
        payer.LastName = 'name 2';
        payer.Email = 'test23@test.com';
        payer.RecordTypeId = [select Id from RecordType where Name = 'Additional Parent' AND SObjectType = 'Contact'].Id;
        payer.Contact_Alternate_Email__c = 'tet@vgfhf.com';
        payer.AccountId = companyAccount.Id;
        payer.Main_Parent_File__c = acc.Id;
        insert payer;
        
        //update account
        acc.Related_Contact_Record_P2__c = payer.Id;
        acc.Primary_Invoicing_Contact__c = 'Second Parent';
        update acc;
        
        payer = [Select Id From Contact Where Id =: payer.Id];
        
        Opportunity studentOne = new Opportunity(Name = 'Student', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                    Student_Name__c = 'Morgan', //Payer__c = payer.Id,
                                                    Leaving_date__c = System.today().addYears(1), Reason_Leaving__c = 'Relocation (out of city)');
        insert studentOne;
        studentOne.StageName = 'Enrolled';
        update studentOne;
        
         //create a Xero Key
        Xero_Key__c testKey = new Xero_Key__c(
            Name = 'Kuala Lumpur',
            Consumer_Key__c = '...'
        );
        insert testKey;
        
        //create an invoice and some line items
        Invoice_Statement__c invoice = new Invoice_Statement__c();
        invoice.payer__c = acc.Id;
        invoice.Reference__c = 'James,Miller';
        invoice.Invoice_Date__c = System.today().addDays(2);
        invoice.Generated_Date__c = System.today();
        invoice.Currency__c = 'USD';
        invoice.School__c = 'Kuala Lumpur';
        invoice.Xero_Key__c = testKey.Id;
        insert invoice;
        
        Line_Item__c lineItem = new Line_Item__c(
            Invoice_Statement__c = invoice.Id,
            Student__c = studentOne.Id,
            Description__c = 'Monthly, Termly or Yearly '
            
        );
        insert lineItem;
        
        //run the batch test
        BatchInvoiceSending batch = new BatchInvoiceSending();
        
        List<Invoice_Statement__c> invoices = new List<Invoice_Statement__c>();
        invoices.add(invoice);
        batch.sendInvoices(invoices);
        
        //make the assertions
        invoice = [
            SELECT Id, Error_Message__c
              FROM Invoice_Statement__c
             WHERE Id =: invoice.Id
        ];
        System.assertEquals('Test Pass', invoice.Error_Message__c);
    }

}