@isTest
private class Test_EventEmailBatches{  
    //test method for portal user creation and chatter group membership
    static testMethod void testEventEmailReminderBatch(){
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
        for(Opportunity o:oppList){
            o.StageName = 'Enrolled';
        }
        update oppList;
        //create student group
        Group__c grp  =  new Group__c();
        grp.Name = 'Test Group';
        grp.Group_Type__c = 'Tutor Group';
        grp.Year_Group_Control__c = 'Tutor Group UK';
        grp.Year_Group__c = 'Year 1';
        //grp.Combined_Year_Group__c = 'Year 2';
        insert grp;
        
        //create school mapping
        String schoolName = [Select Id, School__c from User where Id=:UserInfo.getUserId()].School__c;
        Id networkId;
        //System.debug('***TestChatterMethods***testStudentGroupChatterMethods***networks='+[Select Id,Name from Network]);
        for(Network n:[Select Id,Name from Network limit 1]){
            networkId = n.Id;
        }
        
        School_Logo_Mapping__c schoolMapping =  new School_Logo_Mapping__c();
        schoolMapping.Name = 'Test Mapping';
        schoolMapping.Logo_URL__c = 'test';
        schoolMapping.School_Full_Name__c = schoolName;
        schoolMapping.All_Student_Group_Id__c = grp.Id;
        schoolMapping.Community_Id__c = networkId;
        schoolMapping.Auto_Portal_User_Creation__c = true;
        schoolMapping.Automated_Calendar_Emails_On__c = true;
        insert schoolMapping;
        
        //create group registrations
        //Id studentRTId  = [Select Id from RecordType where SobjectType='Contact' AND DeveloperName='Student'].Id;
        List<Registration__c> rList  =  new List<Registration__c>();
        for(Contact c : [Select Id from Contact where RecordType.DeveloperName = 'Student' AND Stage__c = 'Enrolled' AND Admissions_File__r.StageName = 'Enrolled'] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        
        News_Events__c newsEvent = new News_Events__c();
        newsEvent.RecordTypeId = [select Id from RecordType where SObjectType='News_Events__c' AND DeveloperName='Event'].Id;
        newsEvent.Name = 'Test Event';
        newsEvent.Student_Group__c = grp.Id;
        newsEvent.Event_Start_Date__c = date.today();
        newsEvent.Publish_in_Portal_School_Hub__c = false;
        //newsEvent.Post_Entry_in_Related_Blog__c = 'Yes - And tag as Essential Communication'; 
        //newsEvent.Subtitle__c = 'Teaser Text';        
        insert newsEvent;
        
        Test.startTest();
            newsEvent.Send_Automated_Reminder_Email__c = true;
            update newsEvent;
            newsEvent.Error_Ids__c = parentAccount.Id+','+additionalParent.Id;
            newsEvent.Retry_Sending_Email__c = true;
            update newsEvent;
        Test.stopTest();
        
    }
}