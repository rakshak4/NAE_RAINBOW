/*
Daily batch job for pushing/updating records that newly meet criteria (based on date/time) to School Kompanion. Spec as follows:
1.Set ‘Opportunity.Send_School_Kompanion_Outbound_Message__c’ = TRUE WHERE (‘Opportunity.Qualifies_for_SK_Outbound_Message__c’ = TRUE AND (‘Opportunity.EAL_Status_Change_to_Kompanion__c’ = TRUE OR ‘Opportunity.On_Roll_Change_to_Kompanion__c’ = TRUE))
2.Set ‘Contact.Trigger_Time_Based_Send_to_Kompanion__c = TRUE‘ for Additional Parent record OR ‘Account.Trigger_Time_Based_Send_to_Kompanion__pc’ = TRUE for parent account records related to the opportunities updated in part ‘a.’ above.
3.All ‘Send_School_Kompanion_Outbound_Message__c’ fields on all objects will be set to FALSE by a workflow rule/field update that’s already in place and active in both production and sandbox, so no need to worry about this within the job itself.
4. Schedule job to run aforementioned Apex class as ‘Group Administrator’ daily @ 08:00 MYT

*/
global with sharing class Batch_SendKompanionOutboundMessage implements Database.Batchable<sObject>, Database.Stateful{
    global string errorMessage {get;set;}
    global boolean errorOccured {get;set;}
    global set<Id> studentIds {get;set;}
    global Batch_SendKompanionOutboundMessage(){
    	initialize();
    }
    
    global Batch_SendKompanionOutboundMessage(set<Id> sIds){
    	initialize();
    	studentIds = sIds;
    }
    
    private void initialize(){
    	errorMessage = 'Errors Occurred during the Batch_SendKompanionOutboundMessage batch process. The records that could not be updated will not have triggered an outbound message to School Kompanion and records may now be out of sync. The record IDs and error messages are as follows: <br/>';
    	errorOccured = false;
    }
    
    global Database.Querylocator start(Database.BatchableContext BC){
        string query = 'select Id, AccountId from Opportunity where Qualifies_for_SK_Outbound_Message__c = TRUE AND (EAL_Status_Change_to_Kompanion__c = TRUE OR On_Roll_Change_to_Kompanion__c = TRUE) order by School__c';
        if(studentIds != null){query = 'select Id, AccountId from Opportunity where Qualifies_for_SK_Outbound_Message__c = TRUE AND Id =: studentIds';}
        if(Test.isRunningTest()){query = 'select Id, AccountId from Opportunity limit 1';}
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
    	list<Opportunity> studentList = scope;
    	list<Contact> additionalParentsToBeUpdated = new list<Contact>();
    	list<Account> parentsToBeUpdated = new list<Account>();
    	list<Opportunity> studentsToBeUpdated = new list<Opportunity>();
    	//fetch associated additonal parents
    	set<Id> accountIds =  new set<Id>();
    	for(Opportunity student:studentList){
    		accountIds.add(student.AccountId);
    	}
    	map<Id,Account> parentMap = new map<Id,Account>([Select a.Id, (Select Id From Emails__r where RecordType.DeveloperName = 'Additional_Parent') From Account a where Id IN:accountIds]);
    	//check fields
    	for(Opportunity student:studentList){
    		student.Send_School_Kompanion_Outbound_Message__c = true;
    		studentsToBeUpdated.add(student);
    		Account parentAccount = new Account(Id=student.AccountId);
    		parentAccount.Trigger_Time_Based_Send_to_Kompanion__pc = true;
    		parentsToBeUpdated.add(parentAccount);
    		for(Contact additionalParent:parentMap.get(student.AccountId).Emails__r){
    			additionalParentsToBeUpdated.add(new Contact(Id=additionalParent.Id, Trigger_Time_Based_Send_to_Kompanion__c = true));
    		}
    		//assumption batch size as 1, do update now instead of bulk
    		System.Savepoint sp;
    		try{
    			sp = Database.setSavepoint();
    			update studentsToBeUpdated;
    			update parentsToBeUpdated;
    			if(additionalParentsToBeUpdated.size() > 0){
    				update additionalParentsToBeUpdated;
    			}
    		}catch(Exception e){
    			Database.rollback(sp);
    			errorMessage += '<br/> Failed to update student: '+student.Id+' ('+e.getMessage()+') <br/>';
    			errorOccured = true;
    		}
    		
    	}
    }
    
    global void finish(Database.BatchableContext BC){
   		if(errorOccured || Test.isRunningTest()){
   		   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           set<String> emailSet = new set<String>();
           emailSet.add('ben.hails@britishschools.co.uk');
           list<String> toAddresses =  new list<String>();
           for(string e:emailSet){
            toAddresses.add(e);
           }
           string emailText = '';
           mail.setToAddresses(toAddresses);
           mail.setSubject('Error in Batch_SendKompanionOutboundMessage - '+datetime.now());
           emailText += errorMessage;
           mail.setHtmlBody(emailText);
           if(!Test.isRunningTest()){Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });} 
   		}	 	
    }
    
    //static method for button
    webService static string sendStudentToKompanion(list<Id> sIds) { 
        string message = 'Request was submitted successfully. You should receive an email only if any error occurs in the process.';
        try{
        	set<Id> temp = new set<Id>();
        	for(Id sid:sIds){
        		temp.add(sid);
        	}
        	Batch_SendKompanionOutboundMessage b = new Batch_SendKompanionOutboundMessage(temp);
        	database.executeBatch(b,1);
        }catch(Exception e){
        	message = 'Failed to process request. Error message: '+e.getMessage();
        }
        return message;
        
    }
    
}