@isTest
private class Test_BusService{
    
    static testMethod void testBusServiceDelete(){
        //create test data 
        
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
        
        //create custom setting values
        Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
        mapping.Account_Id__c = companyAccount.Id;
        mapping.Name =  UserInfo.getName();
        mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
        insert mapping;
        
        //create student opportunities
        
        Opportunity o =  new Opportunity();
        o.Student_Surname__c =  'Surname';
        o.Name = 'First Name';
        o.Gender__c = 'Male';
        o.Year_Group__c = 'PN1';
        o.Birth_Date__c =  Date.today().addYears(-10);
        o.Application_Date__c = Date.today();
        o.Starting_Date__c =  Date.today().addDays(-60);
        o.StageName = 'A/ Testing';
        o.AccountId = parentAccount.Id;
        //o.Payer__c = companyAccount.Id;
        //o.Email_1__c = 'test@test.com';
        o.CloseDate =  Date.today().addDays(-60);
        o.Student_Name__c = 'SN';
        o.Class__c = 'A';
            
        insert  o;
        o.StageName = 'Enrolled';
        update o;
        //create bus route
        Bus_Routes__c br = new Bus_Routes__c(Name = 'Test');
        insert br;
        //create bus stop
        Bus_Stops__c bs = new Bus_Stops__c(Name = 'Test');
        insert bs;
        //create bus service
        Bus_Association__c ba = new Bus_Association__c(Bus_Stop__c=bs.Id,First_Date_of_Use__c=date.today(),Student__c=o.Id);
        insert ba;
        
        Test.startTest();
            try{
                delete ba;
            }catch(Exception e){}
        Test.stopTest();
        
    }
}