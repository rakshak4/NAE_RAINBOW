@isTest
private class TestContactPhotoUpdate{
	static testMethod void test_ContactPhotoUpload(){
		Account a =  new Account();
        a.LastName = 'Last Name';
        a.RecordTypeId = [select Id from RecordType where SObjectType = 'Account' AND DeveloperName='PersonAccount'].Id;
        a.PersonEmail = 'p1@e1.com';
        a.Contact_Alternate_Email__pc = 'p1@e2.com';
        //a.Email_2__c = 'p2@e1.com';
        //a.Second_Parent_Email_1__c = 'p2@e2.com';
        insert a;
        
        Id massEmailRecordTypeId = [select Id from RecordType where SObjectType='Contact' AND DeveloperName = 'Mass_Email' limit 1].Id;
        Contact massEmail0 =  new Contact();
        massEmail0.LastName = 'LastName';
        massEmail0.Email = 'test@test.com';
        massEmail0.Main_Parent_File__c = a.Id;
        massEmail0.RecordTypeId = massEmailRecordTypeId;
        insert massEmail0;
        
        //insert attachment
        Attachment aobj = new Attachment();
        aobj.ParentId = massEmail0.Id;
        aobj.Body = Blob.valueOf('Tet');
        aobj.Name = 'Test';
        insert aobj;
        
        massEmail0.Photo_Attachment_Id__c = aobj.Id;
        update massEmail0;
        
        Test.startTest();
        	Test.setCurrentPageReference(Page.ContactPhotoUpdate);
        	ApexPages.StandardController s = new ApexPages.StandardController(massEmail0);
        	ContactPhotoUpdateController controller = new ContactPhotoUpdateController(s);
        	controller.saveAttachment();
        	controller.fileName = 'test';
        	controller.contentType = 'test';
        	
        	controller.saveAttachment();
        	controller.fileBody = Blob.valueOf('Test');
        	controller.contentType = 'image/jpeg';
        	controller.saveAttachment();
        	controller.fileSize = 999999999;
        	controller.fileBody = Blob.valueOf('Test');
        	controller.saveAttachment();
        	controller.fileSize = 1;
        	controller.saveAttachment();
        	controller.cancel();
        	controller.deletePhoto();
        Test.stopTest();
	}
}