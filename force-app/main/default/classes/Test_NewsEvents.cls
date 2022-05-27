@IsTest(SeeAllData=true)
private class Test_NewsEvents{
    //test method for portal user creation and chatter group membership
    static testMethod void testBlogPostCreation(){
        
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        System.debug('***Test_NewsEvents***testBlogPostCreation***1=');
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name1';
        parentAccount.LastName =  'Last Name2';
        parentAccount.PersonEmail = 'testunique1@test.com';
        parentAccount.Contact_Alternate_Email__pc = 'testunique2@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        parentAccount.Primary_Contact__c = 'First Parent';
        insert parentAccount;
        System.debug('***Test_NewsEvents***testBlogPostCreation***2=');
        //create custom setting values
        Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
        mapping.Account_Id__c = companyAccount.Id;
        mapping.Name =  UserInfo.getName();
        mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
        insert mapping;
        System.debug('***Test_NewsEvents***testBlogPostCreation***3=');
        Id networkId;
        for(Network n:[Select Id,Name from Network limit 1]){
            networkId = n.Id;
        }
      
        
        //create setting
        User u = [select School__c,Id from User where Id=:UserInfo.getUserId()];
        School_Logo_Mapping__c portal =  new School_Logo_Mapping__c();
        portal.Name = 'Test';
        portal.School_Full_Name__c = u.School__c;
        portal.Auto_Portal_User_Creation__c = true;
        portal.Logo_URL__c = 'test';
        portal.Auto_Portal_User_Creation__c = true;
        portal.Community_Id__c = networkId;
        portal.Automated_Calendar_Emails_On__c = true;
        insert portal;
        System.debug('***Test_NewsEvents***testBlogPostCreation***4=');
        
        System.debug('***Test_NewsEvents***testBlogPostCreation***5=');
        //create portal chatter group
        CollaborationGroup chatterGroup =  new CollaborationGroup();
        chatterGroup.Name = 'Test Group 99999';
        chatterGroup.NetworkId = networkId;
        chatterGroup.CollaborationType = 'Private'; 
        chatterGroup.OwnerId = UserInfo.getUserId();
        insert chatterGroup;
        System.debug('***Test_NewsEvents***testBlogPostCreation***6=');
        //create student group
        Group__c grp  =  new Group__c();
        grp.Name = 'Test Group';
        grp.Group_Type__c = 'Tutor Group';
        grp.Chatter_Group_Id__c = chatterGroup.Id;
        grp.Year_Group_Control__c = 'Tutor Group UK';
        grp.Year_Group__c = 'Year 1';
        insert grp;
        System.debug('***Test_NewsEvents***testBlogPostCreation***7=');
        Test.startTest();
            News_Events__c newsEvent = new News_Events__c();
            newsEvent.RecordTypeId = [select Id from RecordType where SObjectType='News_Events__c' AND DeveloperName='Event'].Id;
            newsEvent.Name = 'Test Event';
            newsEvent.Student_Group__c = grp.Id;
            newsEvent.Event_Start_Date__c = date.today();
            newsEvent.Publish_in_Portal_School_Hub__c = true;
            newsEvent.Post_Entry_in_Related_Blog__c = 'Yes - And tag as Essential Communication'; 
            newsEvent.Subtitle__c = 'Teaser Text';          
            insert newsEvent;
        Test.stopTest();
        
        
    }
}