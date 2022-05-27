global without sharing class EventEmailReminderBatchErrorHandling implements Database.Batchable<Id>,Database.Stateful{
   
    global Id neId {get;set;}
    global Id groupId {get;set;}
    global string eventNotificatiionText {get;set;}
    global string errorMessage ;
    global string errorIdsString ;
    
    global EventEmailReminderBatchErrorHandling(Id nId, Id gId, string messageText, string eIds_str){ 
        neId = nId;
        groupId = gId;
        eventNotificatiionText = messageText;
        errorIdsString = eIds_str;
        errorMessage = '';
    }
    
    global Iterable<Id> start(Database.BatchableContext BC) {
        if(errorIdsString != null){
        	set<Id> errorIds = new set<Id>();
        	list<String> elist = errorIdsString.split(',');
        	for(string s:elist){
        		try{
	        		Id sid = s;
	        		errorIds.add(sid);
        		}catch(Exception e){
        			
        		}
        	}
        	if(errorIds.size() > 0){
        		//create list of error ids
        		list<Id> errorIdList = new list<Id>();
        		for(Id eid:errorIds){
        			errorIdList.add(eid);
        		}
        		return errorIdList;
        		//handleEventEmailNotificationError(errorIds);	
        	}
        }
        return new list<Id>();
    }
    
    public void handleEventEmailNotificationError(set<Id> errorIdsForEvent){
   		set<Id> errorIds = new set<Id>();
   	
   		if(errorIdsForEvent.size() > 0){
   			News_Events__c neObj ;
   			set<Id> parentIds = new set<Id>();
   			set<Id> contactIds = new set<Id>();
   			for(Id sid:errorIdsForEvent){
   				string sid_str = sid;
   				if(sid_str.startsWith('001')){
   					parentIds.add(sid);
   				}else if(sid_str.startsWith('003')){
   					contactIds.add(sid);
   				}
   			}
   			list<Account> personAccountList = new list<Account>();
	        list<Contact> additionalParentList = new list<Contact>();
   			for(Id pid:parentIds){
   				Account personAccount = new Account(Id=pid);
                personAccount.Related_Event_for_Email__pc = neId;
                personAccount.Related_Event_Text_for_Email__pc = eventNotificatiionText; 
                personAccount.Related_Event_Trigger_First_Email_Send__pc = true;
                personAccountList.add(personAccount);
   			}
   			for(Id cid:contactIds){
   				Contact additionalParent = new Contact(Id=cid);
                additionalParent.Related_Event_for_Email__c = neId;
                additionalParent.Related_Event_Text_for_Email__c = eventNotificatiionText;   
                additionalParent.Related_Event_Trigger_First_Email_Send__c = true;
                additionalParentList.add(additionalParent);
   			}
   			neObj = new News_Events__c(Id=neId,Automated_Reminder_Email_Sent__c=datetime.now(),Send_Automated_Reminder_Email__c=false);
   			//try inserting data
   			//update records
	            if(personAccountList.size() >0){
	                //update personAccountList;
	                
			        list<Database.SaveResult> srList = Database.update(personAccountList,false);
			        integer i = 0;
			        for(Database.Saveresult sr:srlist){
			            if(!sr.isSuccess()){
			            	errorIds.add(personAccountList[i].Id);
			                if(errorMessage == ''){
			                    errorMessage += '<br/>'+'EventEmailReminderBatch - Error(s) Occured while updating parent accounts for sending calendar reminder email. ';
			                }
			                errorMessage += '<br/>'+'Error Occured updating parent record = '+personAccountList[i]+'. Error Message: '+sr.getErrors();
			            }
			            i++;
			        }
	            }   
	            if(additionalParentList.size() > 0){
	                //update additionalParentList;
	                list<Database.SaveResult> srList = Database.update(additionalParentList,false);
			        integer i = 0;
			        for(Database.Saveresult sr:srlist){
			            if(!sr.isSuccess()){
			                errorIds.add(additionalParentList[i].Id);
			                if(errorMessage == ''){
			                    errorMessage += '<br/>'+'EventEmailReminderBatch - Error(s) Occured while updating parent accounts for sending calendar reminder email. ';
			                }
			                errorMessage += '<br/>'+'Error Occured updating additional parent record = '+additionalParentList[i]+'. Error Message: '+sr.getErrors();
			            }
			            i++;
			        }
	            }
	            //update event
	            if(neObj != null){
	            	if(errorIds.size() > 0){
	            		string errorIdsStr = '';
	            		for(Id eid:errorIds){
	            			if(errorIdsStr == ''){
	            				errorIdsStr = eid;
	            			}else{
	            				errorIdsStr += ','+eid;
	            			}
	            		}
	            		neObj.Error_Ids__c = errorIdsStr;
	            		//neObj.Retry_Sending_Email__c = true;
	            	}else{
	            		neObj.Error_Ids__c = null;
	            		//neObj.Retry_Sending_Email__c = false;
	            	}
	            	neObj.Retry_Sending_Email__c = false;
	                //update neObj;
	                list<News_Events__c> tempList = new list<News_Events__c>();
	                tempList.add(neObj);
	                list<Database.SaveResult> srList = Database.update(tempList,false);
			        integer i = 0;
			        for(Database.Saveresult sr:srlist){
			            if(!sr.isSuccess()){
			                if(errorMessage == ''){
			                    errorMessage += '<br/>'+'EventEmailReminderBatch - Error(s) Occured while updating parent accounts for sending calendar reminder email. ';
			                }
			                errorMessage += '<br/>'+'Error Occured updating calendar event record = '+tempList[i]+'. Error Message: '+sr.getErrors();
			            }
			            i++;
			        }
	            }
   		}
    }
    
    global void execute(Database.BatchableContext BC, List<Id> scope) {
    	list<Id> errorIdList = scope;
    	set<Id> errorIdsSet = new set<Id>();
    	for(Id eid:errorIdList){
    		errorIdsSet.add(eid);
    	}
    	if(errorIdsSet.size() > 0){
    		handleEventEmailNotificationError(errorIdsSet);
    	}
    }
    
    global void finish(Database.BatchableContext BC) {
    	if(errorMessage != ''){
            //send email to Ben, Kunal
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           list<String> toAddresses =  new list<String>();
           toAddresses.add('ben.hails@britishschools.co.uk');
           toAddresses.add('kunal.sharma@britishschools.co.uk');
           toAddresses.add('anton.simanikhin@britishschools.co.uk');
           //String[] toAddresses = new String[] {'ben.hails@britishschools.co.uk','kunal.sharma@britishschools.co.uk'};
           mail.setToAddresses(toAddresses);
           mail.setSubject('Email Reminder Notification (Handing Error Records)-  Error occured');
           string emailText = 'There were errors processing parent/contact records while trying to reupdate to send email related to news/event record. Find error message below:';
           emailText += '<br/>';
           emailText += errorMessage;
           mail.setHtmlBody(emailText);
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        }
    }
}