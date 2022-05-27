@isTest
private class Test_KompanionDataRequestHandler{
    //test method for KompanionDataRequestHandler
    static testMethod void testKompanionDataRequestHandler1(){
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
        for(integer i=1;i<2;i++){
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
            string dataXML = '<process object="Opportunity" token="unique token" id="'+oppList[0].Id+'">';
            dataXML += '<data name="Name">test</data>';
            dataXML += '</process>';
            string encodedString = EncodingUtil.base64Encode(Blob.valueOf(dataXML));
            Test.setCurrentPage(Page.KompanionDataRequestHandler);
            system.currentPageReference().getParameters().put('data',encodedString);
            KompanionDataRequestHandler handler =  new KompanionDataRequestHandler();
            handler.processRequest();
        Test.stopTest();
        
    }   
    
    //test method for KompanionDataRequestHandler
    static testMethod void testKompanionDataRequestHandler2(){
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
        
        
        
        Test.startTest();
            string dataXML = '<process object="Contact" token="unique token" id="'+additionalParent.Id+'">';
            dataXML += '<data name="FirstName1">test</data>';
            dataXML += '</process>';
            string encodedString = EncodingUtil.base64Encode(Blob.valueOf(dataXML));
            Test.setCurrentPage(Page.KompanionDataRequestHandler);
            KompanionDataRequestHandler handler =  new KompanionDataRequestHandler();
            system.currentPageReference().getParameters().put('data',encodedString);
            KompanionDataRequestHandler handler2 =  new KompanionDataRequestHandler();
            handler2.processRequest();
        Test.stopTest();
        
    }   
}