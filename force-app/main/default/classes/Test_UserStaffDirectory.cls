@isTest
private class Test_UserStaffDirectory{
     private static testmethod void TestUserStaffDirectoryInterface(){
         Test.setCurrentPage(Page.UserStaffDirectory);
         	User u = new User(Id=UserInfo.getUserId());
             u.Manage_Chatter_Free_Users__c = 'As Admin';
             update u;
             //create parent account account
	        Account parentAccount =  new Account();
	        parentAccount.FirstName =  'First Name';
	        parentAccount.LastName =  'Last Name';
	        parentAccount.PersonEmail = 'test@test.com';
	        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
	        parentAccount.User__pc = u.Id;
	        insert parentAccount;
         Test.startTest();
             system.currentPageReference().getParameters().put('sfdc.userId',UserInfo.getUserId());
             ApexPages.StandardController c = new ApexPages.StandardController(u);
             UserStaffDirectory_Controller controller = new UserStaffDirectory_Controller(c);
             controller.showEditMode();
             controller.saveUser();
             controller.photo.body = Blob.valueOf('Test');
             controller.photo.ContentType = 'Test';
             controller.photo.Name = 'Test';
             controller.saveUser();
             controller.cancel();
             boolean flag = controller.showDefaultView;
             flag = controller.showOverriddenView;
         Test.stopTest();
     } 
     
     private static testmethod void TestUserStaffDirectoryInterface2(){
         Test.setCurrentPage(Page.UserStaffDirectory);
         	User u = [select Id from User where Profile.Name = 'Teacher' AND IsActive = true limit 1];
             u.Manage_Chatter_Free_Users__c = 'As Admin';
             update u;
             //create parent account account
	        Account parentAccount =  new Account();
	        parentAccount.FirstName =  'First Name';
	        parentAccount.LastName =  'Last Name';
	        parentAccount.PersonEmail = 'test@test.com';
	        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
	        parentAccount.User__pc = u.Id;
	        insert parentAccount;
         Test.startTest();
         System.runAs(u){
             User u1 = [select Id from User where Is_Chatter_Free_User__c = true AND IsActive = true AND Id !=:u.Id limit 1];
             system.currentPageReference().getParameters().put('sfdc.userId',u1.Id);
             ApexPages.StandardController c = new ApexPages.StandardController(u);
             UserStaffDirectory_Controller controller = new UserStaffDirectory_Controller(c);
             controller.showEditMode();
             controller.saveUser();
             controller.photo.body = Blob.valueOf('Test');
             controller.photo.ContentType = 'Test';
             controller.photo.Name = 'Test';
             controller.saveUser();
             controller.cancel();
             boolean flag = controller.showDefaultView;
             flag = controller.showOverriddenView;
         }    
         Test.stopTest();
     } 
     
     private static testmethod void TestUserStaffDirectoryInterface3(){
         Test.setCurrentPage(Page.UserStaffDirectory);
         	User u = [select Id from User where Profile.Name = 'Teacher' AND IsActive = true limit 1];
             u.Manage_Chatter_Free_Users__c = 'As Academic';
             update u;
             //create parent account account
	        Account parentAccount =  new Account();
	        parentAccount.FirstName =  'First Name';
	        parentAccount.LastName =  'Last Name';
	        parentAccount.PersonEmail = 'test@test.com';
	        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
	        parentAccount.User__pc = u.Id;
	        insert parentAccount;
         Test.startTest();
         System.runAs(u){
             User u1 = [select Id from User where Is_Chatter_Free_User__c = true AND IsActive = true AND Id !=:u.Id limit 1];
             system.currentPageReference().getParameters().put('sfdc.userId',u1.Id);
             ApexPages.StandardController c = new ApexPages.StandardController(u);
             UserStaffDirectory_Controller controller = new UserStaffDirectory_Controller(c);
             controller.showEditMode();
             controller.saveUser();
             controller.photo.body = Blob.valueOf('Test');
             controller.photo.ContentType = 'Test';
             controller.photo.Name = 'Test';
             controller.saveUser();
             controller.cancel();
             boolean flag = controller.showDefaultView;
             flag = controller.showOverriddenView;
         }    
         Test.stopTest();
     } 
     
     private static testmethod void TestUserPhotoUpdate(){
         Test.setCurrentPage(Page.UserStaffDirectory);
         //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
         //create attachement
         Attachment photo = new Attachment();
         photo.body = Blob.valueOf('Test');
         photo.ContentType = 'image/png';
         photo.Name = 'Test';
         photo.ParentId = companyAccount.Id;
         User u = new User(Id=UserInfo.getUserId());
         u.Photo_Attachment_Id__c = photo.Id;
         update u;
         Test.startTest();
             try{ScheduleUserPhotoUpdate.setup();}catch(Exception e){}
             
         Test.stopTest();
     } 
     /*
     private static testmethod void TestUserPhotoUpdate2(){
         Test.setCurrentPage(Page.UserStaffDirectory);
         //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
         //create attachement
         Attachment photo = new Attachment();
         photo.body = Blob.valueOf('Test');
         photo.ContentType = 'image/png';
         photo.Name = 'Test';
         photo.ParentId = companyAccount.Id;
         User u = new User(Id=UserInfo.getUserId());
         u.Photo_Attachment_Id__c = photo.Id;
         update u;
         Test.startTest();
             try{
             	Batch_UserPhotoUpdate big = new Batch_UserPhotoUpdate();
	         	Database.executeBatch(big, 1);
             }catch(Exception e){}
             
         Test.stopTest();
     } */
}