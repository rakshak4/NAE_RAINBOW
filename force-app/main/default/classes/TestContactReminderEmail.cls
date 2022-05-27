@isTest
private class TestContactReminderEmail{
	//test method for weekly attendance page
    static testMethod void BatchContactReminderEmail_1(){
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
        //create additional paremts
        Id additionalParentTypeId = [select Id from RecordType where SObjectType='Contact' AND DeveloperName='Additional_Parent'].Id;
        Contact con = new Contact();
        con.FirstName = 'Test';
        con.LastName = 'Test';
        con.AccountId = companyAccount.Id;
        con.RecordTypeId = additionalParentTypeId;
        con.Email  = 'test@test.com1';
        con.Main_Parent_File__c = parentAccount.Id;
        insert con;
        //create custom setting
        School_Logo_Mapping__c mapping = new School_Logo_Mapping__c();
        mapping.Name = 'Test';
        mapping.School_Full_Name__c = [select School__c from User where Id=:UserInfo.getUserId()].School__c;
        mapping.Logo_URL__c = 'Test';
        mapping.Send_Sunday_Calendar_Reminder_Email__c = true;
        insert mapping;
        Test.startTest();
        	BatchContactReminderEmail b = new BatchContactReminderEmail();
        	Database.executeBatch(b, 100);
        Test.stopTest();
    }
}