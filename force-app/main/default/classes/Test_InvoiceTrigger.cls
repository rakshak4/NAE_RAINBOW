/***
    Author: Kunal
    Dated: 11 Oct 2013
    Desc: test class for trigger on invoice
***/
@isTest
private class Test_InvoiceTrigger{
    
    static testMethod void test_HandleInvoiceAfterUpdate(){
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        
        //create student opportunities
        
        Opportunity o =  new Opportunity();
        o.Student_Surname__c =  'Surname';
        o.Name_in_Local_Language__c = 'Test';
        o.Name = 'First Name';
        o.Gender__c = 'Male';
        o.Year_Group__c = 'PN1';
        o.Birth_Date__c =  Date.today().addYears(-10);
        o.Application_Date__c = Date.today();
        o.Starting_Date__c =  Date.today();
        o.StageName = 'A/ Testing';
        o.AccountId = parentAccount.Id;
        //o.Payer__c = companyAccount.Id;
        //o.Email_1__c = 'test@test.com';
        o.CloseDate =  Date.today();
        o.Student_Name__c = 'SN';
        o.Class__c = 'A';
        insert o;
        o.StageName = 'Enrolled';
        update o;
        Xero_Key__c xero_key = new Xero_Key__c();
        xero_key.Name = 'Test';
        xero_key.Consumer_Key__c = 'Test';
        insert xero_key;
        User u = [Select Id, School__c from User where Id=:UserInfo.getUserId()];
        //create invoice
        Invoice_Statement__c statement = new Invoice_Statement__c();
        statement.Payer__c = parentAccount.Id;
        statement.School__c = 'Kuala Lumpur';
        statement.Invoice_Date__c =  Date.today();
        statement.Xero_Key__c = xero_key.Id;
        insert statement;
        //create invoice line items
        Line_Item__c line =  new Line_Item__c();
        line.Invoice_Statement__c = statement.Id;
        line.Student__c = o.Id;
        line.Description__c = 'Monthly, Termly or Yearly ';
        insert line; 
        
        Test.startTest();
            //change invoice date on statement
            statement.Invoice_Date__c = Date.today().addDays(-5);
            update statement;
        Test.stopTest();
        
    } 
}