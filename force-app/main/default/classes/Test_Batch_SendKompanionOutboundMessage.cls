@isTest
private class Test_Batch_SendKompanionOutboundMessage{
    //test method for Batch_SendKompanionOutboundMessage
    static testMethod void testBatch_SendKompanionOutboundMessage1(){
       //create test data 
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name1';
        parentAccount.LastName =  'Last Name2';
        parentAccount.PersonEmail = 'testunique1@test.com';
        parentAccount.Contact_Alternate_Email__pc = 'testunique2@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        parentAccount.Primary_Contact__c = 'First Parent';
        insert parentAccount;
        
        //create additional parent
        Contact additionalParent = new Contact();
        additionalParent.Main_Parent_File__c = parentAccount.Id;
        additionalParent.AccountId = companyAccount.Id;
        additionalParent.FirstName = 'Test';
        additionalParent.LastName = 'Additional Parent';
        additionalParent.Email = 'testhgg@test.com';
        additionalParent.RecordTypeId = [Select Id from RecordType where SObjectType='Contact' AND DeveloperName='Additional_Parent'].Id;
        insert additionalParent;
        
        //create custom setting values
        Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
        mapping.Account_Id__c = companyAccount.Id;
        mapping.Name =  UserInfo.getName();
        mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
        insert mapping;
        
        //create student opportunities
        List<Opportunity> oppList =  new List<Opportunity>();
        for(integer i=1;i<5;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today().addMonths(-3);
            o.Starting_Date__c =  Date.today().addMonths(-3);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today();
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        
        insert oppList;
        
        
        Test.startTest();
            Batch_SendKompanionOutboundMessage b = new Batch_SendKompanionOutboundMessage();
            database.executeBatch(b,1);
        Test.stopTest();
        
    }   
    
    //test method for Batch_SendKompanionOutboundMessage
    static testMethod void testBatch_SendKompanionOutboundMessage2(){
       //create test data 
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name1';
        parentAccount.LastName =  'Last Name2';
        parentAccount.PersonEmail = 'testunique1@test.com';
        parentAccount.Contact_Alternate_Email__pc = 'testunique2@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        parentAccount.Primary_Contact__c = 'First Parent';
        insert parentAccount;
        
        //create additional parent
        Contact additionalParent = new Contact();
        additionalParent.Main_Parent_File__c = parentAccount.Id;
        additionalParent.AccountId = companyAccount.Id;
        additionalParent.FirstName = 'Test';
        additionalParent.LastName = 'Additional Parent';
        additionalParent.Email = 'testhgg@test.com';
        additionalParent.RecordTypeId = [Select Id from RecordType where SObjectType='Contact' AND DeveloperName='Additional_Parent'].Id;
        insert additionalParent;
        
        //create custom setting values
        Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
        mapping.Account_Id__c = companyAccount.Id;
        mapping.Name =  UserInfo.getName();
        mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
        insert mapping;
        
        //create student opportunities
        List<Opportunity> oppList =  new List<Opportunity>();
        for(integer i=1;i<5;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today().addMonths(-3);
            o.Starting_Date__c =  Date.today().addMonths(-3);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today();
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        
        insert oppList;
        
        
        Test.startTest();
            list<Id> temp = new list<Id>();
            temp.add(oppList[0].Id);
            Batch_SendKompanionOutboundMessage.sendStudentToKompanion(temp) ;
            
        Test.stopTest();
        
    }   
    
    //test method for Schedule_SendKompanionOutboundMessage
    static testMethod void testSchedule_SendKompanionOutboundMessage(){
       
        Test.startTest();
            Schedule_SendKompanionOutboundMessage      sh1 = new Schedule_SendKompanionOutboundMessage();
            String sch = '0 0 23 * * ?'; 
            system.schedule('Test', sch, sh1); 
            
        Test.stopTest();
        
    }   
    
    
}