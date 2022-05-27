//batch process to update user profile image
global with sharing class Batch_UserPhotoUpdate implements Database.Batchable<sObject>,Database.Stateful{
    String query; 
    
    global string errorMessage ; 
    global Batch_UserPhotoUpdate() {
        errorMessage = '';
        query = 'Select Id, Name, Photo_Attachment_Id__c from User where  Photo_Attachment_Id__c != null'; 
    
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<User> scope) {
    	
	    	/*for(Account acc:scope){
		    	if(acc.Photo_Attachment_Id__c != null && acc.User__pc != null){
					//fetch attachment 
					Attachment photo = [select Id, Name, ContentType, Body from Attachment where Id=:acc.Photo_Attachment_Id__c];
					ConnectApi.BinaryInput bi =  new ConnectApi.BinaryInput(photo.body,photo.ContentType,photo.Name);
					ConnectApi.Photo cPhoto = ConnectApi.ChatterUsers.setPhoto(null, acc.User__pc , bi);
					
					acc.Photo_Attachment_Id__c = null;
					update acc;
				}
	    	}*/
	    	for(User u:scope){
		    	try{
					//fetch attachment 
					Attachment photo = [select Id, Name, ContentType, Body from Attachment where Id=:u.Photo_Attachment_Id__c];
					ConnectApi.BinaryInput bi =  new ConnectApi.BinaryInput(photo.body,photo.ContentType,photo.Name);
					ConnectApi.Photo cPhoto = ConnectApi.ChatterUsers.setPhoto(null, u.Id , bi);
					
					u.Photo_Attachment_Id__c = null;
					update u;
				}catch(Exception e){
		    		errorMessage += '<br/>Photo Update failed for User = '+u.Id+'. Error Message = '+e.getMessage()+'<br/>';
		    	}
	    	}
    	
    }
    
    global void finish(Database.BatchableContext BC) {
         if(errorMessage != '' || Test.isRunningTest()){
            //send email to Ben, Kunal
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           list<String> toAddresses =  new list<String>();
           toAddresses.add('ben.hails@britishschools.co.uk');
           toAddresses.add('kunal.sharma@britishschools.co.uk');
           
           //String[] toAddresses = new String[] {'ben.hails@britishschools.co.uk','kunal.sharma@britishschools.co.uk'};
           mail.setToAddresses(toAddresses);
           mail.setSubject('Error while updating user photo.');
           string emailText = 'There were errors while updating user photo. Find error message below:';
           emailText += '<br/>';
           emailText += errorMessage;
           mail.setHtmlBody(emailText);
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        }
    }
}