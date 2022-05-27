global without sharing class EventEmailReminderBatch implements Database.Batchable<sObject>,Database.Stateful{
    
    public string query; 
    public set<Id> nIds;
    global Id neId {get;set;}
    global Id groupId {get;set;}
    global string eventNotificatiionText {get;set;}
    global string errorMessage ;
    global set<Id> errorIds ;
    global boolean executeCalled ;
    /* 
    global EventEmailReminderBatch(set<Id> neIds){ 
        nIds = neIds;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        system.debug('****EventEmailReminderBatch***start***nIds='+nIds);
        if(nIds != null){
        	query = 'select Id from News_Events__c where Id IN:nIds';
        	system.debug('****EventEmailReminderBatch***start***query='+query);
        }
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<News_Events__c> scope) {
         set<Id> neIds = new set<Id>();
         for(News_Events__c ne:scope){
         	neIds.add(ne.Id);
         }
         system.debug('****EventEmailReminderBatch***execute***query='+neIds);
         sendReminder(neIds);
         system.debug('****EventEmailReminderBatch***execute***complete');
    }
   
    global void SendReminder(set<Id> neIds){
        set<Id> groupIds = new set<Id>();
        list<News_Events__c> scope = new list<News_Events__c>();
        for(News_Events__c ne:[select Id,Student_Group__c,Fst_Email_Notification_Text__c from News_Events__c where Id IN:neIds]){
            groupIds.add(ne.Student_Group__c);
            scope.add(ne);
        }
        //fetch group parent person account
        set<Id> personAccountIds_all = new set<Id>();
        map<Id,set<Id>> personAccountIdMap = new  map<Id,set<Id>>(); //key = group Id, value = set of person account ids
        for(Registration__c r:[Select Student__r.Main_Parent_File__c, Student__r.Stage__c, r.Student__c, r.Student__r.Student_Name__c ,r.Student__r.Student_Full_Name__c,  r.Student__r.Name, r.Name, r.Id, r.Group__c, r.Active__c From Registration__c r where r.Group__c IN:groupIds AND r.Parents_Included_in_Community_Group__c = true  order by r.Student__r.Student_Name__c asc]){
            if(r.Student__r.Main_Parent_File__c != null){
                if(personAccountIdMap.containsKey(r.Group__c)){
                    personAccountIdMap.get(r.Group__c).add(r.Student__r.Main_Parent_File__c);
                }else{
                    set<Id> temp = new set<Id>();
                    temp.add(r.Student__r.Main_Parent_File__c);
                    personAccountIdMap.put(r.Group__c,temp);
                }
                personAccountIds_all.add(r.Student__r.Main_Parent_File__c);
            }
        }
        //fetch all additional parent records with fetched person accounts
        map<Id,set<Id>> additionalParentIdMap = new map<Id,set<Id>>(); // key = person account id, value = set of contact ids
        for(Contact c:[Select Id,Main_Parent_File__c,Email, HasOptedOutOfEmail From Contact where  HasOptedOutOfEmail = false AND RecordType.DeveloperName = 'Additional_Parent' AND Main_Parent_File__c IN:personAccountIds_all]){
            if(c.Main_Parent_File__c != null){
                if(additionalParentIdMap.containsKey(c.Main_Parent_File__c)){
                   additionalParentIdMap.get(c.Main_Parent_File__c).add(c.Id);
                }else{
                    set<Id> temp = new set<Id>();
                    temp.add(c.Id);
                    additionalParentIdMap.put(c.Main_Parent_File__c,temp);
                }
            }
        }
        
        list<Account> personAccountList = new list<Account>();
        list<Contact> additionalParentList = new list<Contact>();
        list<News_Events__c> neList = new list<News_Events__c>();
        for(News_Events__c ne:scope){
            //fetch group parent person account
            set<Id> personAccountIds = personAccountIdMap.get(ne.Student_Group__c);
            if(personAccountIds == null){personAccountIds = new set<Id>();}
            
            //fetch all additional parent records with fetched person accounts
            set<Id> additionalParentIds = new set<Id>();
            
            for(Id pid:personAccountIds){
                if(additionalParentIdMap.get(pid) != null){
                    additionalParentIds.addAll(additionalParentIdMap.get(pid));
                }
            }
            //update with event data
            
            for(Id personAccountId:personAccountIds){
                Account personAccount = new Account(Id=personAccountId);
                personAccount.Related_Event_for_Email__pc = ne.Id;
                //if(ne.Send_First_Reminder_Email__c == true){
                    personAccount.Related_Event_Text_for_Email__pc = ne.Fst_Email_Notification_Text__c; 
                    personAccount.Related_Event_Trigger_First_Email_Send__pc = true;
                //}
               
                personAccountList.add(personAccount);
            }
            
            for(Id additionalParentId:additionalParentIds){
                Contact additionalParent = new Contact(Id=additionalParentId);
                additionalParent.Related_Event_for_Email__c = ne.Id;
                //if(ne.Send_First_Reminder_Email__c == true){
                    additionalParent.Related_Event_Text_for_Email__c = ne.Fst_Email_Notification_Text__c;   
                    additionalParent.Related_Event_Trigger_First_Email_Send__c = true;
                //}
                
                additionalParentList.add(additionalParent);
            }
            //if(ne.Send_First_Reminder_Email__c == true){
                //ne.First_Reminder_Email_Sent__c = true;
                neList.add(new News_Events__c(Id=ne.Id,Automated_Reminder_Email_Sent__c=datetime.now(),Send_Automated_Reminder_Email__c=false));
            //}
           
        }
        
        
        //update records
            if(personAccountList.size() >0){
                update personAccountList;
            }   
            if(additionalParentList.size() > 0){
                update additionalParentList;
            }
            //update event
            if(neList.size() > 0){
                update neList;
            }
        
    }*/
    
 
    
    global EventEmailReminderBatch(Id nId, Id gId, string messageText){ 
        neId = nId;
        groupId = gId;
        eventNotificatiionText = messageText;
        errorIds = new set<Id>();
        errorMessage = '';
        executeCalled = false;
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        system.debug('****EventEmailReminderBatch***start***neId='+neId);
        system.debug('****EventEmailReminderBatch***start***groupId='+groupId);
        system.debug('****EventEmailReminderBatch***start***eventNotificatiionText='+eventNotificatiionText);
        
    	query = 'Select Student__r.Main_Parent_File__c, Student__r.Stage__c, r.Student__c, r.Student__r.Student_Name__c ,r.Student__r.Student_Full_Name__c,  r.Student__r.Name, r.Name, r.Id, r.Group__c, r.Active__c From Registration__c r where r.Group__c =:groupId AND r.Parents_Included_in_Community_Group__c = true  order by r.Student__r.Student_Name__c asc';
    	system.debug('****EventEmailReminderBatch***start***query='+query);
       
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Registration__c> scope) {
        try{
        	executeCalled = true;
	        News_Events__c neObj ;
	        list<Registration__c> registrationList = scope;
	        //fetch group parent person account
	        set<Id> personAccountIds_all = new set<Id>();
	        map<Id,set<Id>> personAccountIdMap = new  map<Id,set<Id>>(); //key = group Id, value = set of person account ids
	        for(Registration__c r:registrationList){
	            if(r.Student__r.Main_Parent_File__c != null){
	                if(personAccountIdMap.containsKey(r.Group__c)){
	                    personAccountIdMap.get(r.Group__c).add(r.Student__r.Main_Parent_File__c);
	                }else{
	                    set<Id> temp = new set<Id>();
	                    temp.add(r.Student__r.Main_Parent_File__c);
	                    personAccountIdMap.put(r.Group__c,temp);
	                }
	                personAccountIds_all.add(r.Student__r.Main_Parent_File__c);
	            }
	        }
	        //fetch all additional parent records with fetched person accounts
	        map<Id,set<Id>> additionalParentIdMap = new map<Id,set<Id>>(); // key = person account id, value = set of contact ids
	        for(Contact c:[Select Id,Main_Parent_File__c,Email, HasOptedOutOfEmail From Contact where  HasOptedOutOfEmail = false AND RecordType.DeveloperName = 'Additional_Parent' AND Main_Parent_File__c IN:personAccountIds_all]){
	            if(c.Main_Parent_File__c != null){
	                if(additionalParentIdMap.containsKey(c.Main_Parent_File__c)){
	                   additionalParentIdMap.get(c.Main_Parent_File__c).add(c.Id);
	                }else{
	                    set<Id> temp = new set<Id>();
	                    temp.add(c.Id);
	                    additionalParentIdMap.put(c.Main_Parent_File__c,temp);
	                }
	            }
	        }
	        list<Account> personAccountList = new list<Account>();
	        list<Contact> additionalParentList = new list<Contact>();
	       //update data
	            //fetch group parent person account
	            set<Id> personAccountIds = personAccountIdMap.get(groupId);
	            if(personAccountIds == null){personAccountIds = new set<Id>();}
	            
	            //fetch all additional parent records with fetched person accounts
	            set<Id> additionalParentIds = new set<Id>();
	            
	            for(Id pid:personAccountIds){
	                if(additionalParentIdMap.get(pid) != null){
	                    additionalParentIds.addAll(additionalParentIdMap.get(pid));
	                }
	            }
	            //update with event data
	            
	            for(Id personAccountId:personAccountIds){
	                Account personAccount = new Account(Id=personAccountId);
	                personAccount.Related_Event_for_Email__pc = neId;
	                //if(ne.Send_First_Reminder_Email__c == true){
	                    personAccount.Related_Event_Text_for_Email__pc = eventNotificatiionText; 
	                    personAccount.Related_Event_Trigger_First_Email_Send__pc = true;
	                //}
	               
	                personAccountList.add(personAccount);
	            }
	            
	            for(Id additionalParentId:additionalParentIds){
	                Contact additionalParent = new Contact(Id=additionalParentId);
	                additionalParent.Related_Event_for_Email__c = neId;
	                //if(ne.Send_First_Reminder_Email__c == true){
	                    additionalParent.Related_Event_Text_for_Email__c = eventNotificatiionText;   
	                    additionalParent.Related_Event_Trigger_First_Email_Send__c = true;
	                //}
	                
	                additionalParentList.add(additionalParent);
	            }
	           
	            //update ne record
	            neObj = new News_Events__c(Id=neId,Automated_Reminder_Email_Sent__c=datetime.now(),Send_Automated_Reminder_Email__c=false);
	           
	        //}
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
        }catch(Exception e){
        	errorMessage = e.getMessage();
        }
        
    }
    
    global void finish(Database.BatchableContext BC) {
    	if(!executeCalled){
    		News_Events__c neObj = new News_Events__c(Id=neId,Send_Automated_Reminder_Email__c=false);
    		update neObj;
    	}
        if(errorMessage != ''){
            //send email to Ben, Kunal
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           list<String> toAddresses =  new list<String>();
           toAddresses.add('ben.hails@britishschools.co.uk');
           toAddresses.add('kunal.sharma@britishschools.co.uk');
           toAddresses.add('anton.simanikhin@britishschools.co.uk');
           //String[] toAddresses = new String[] {'ben.hails@britishschools.co.uk','kunal.sharma@britishschools.co.uk'};
           mail.setToAddresses(toAddresses);
           mail.setSubject('Email Reminder Notification -  Error occured');
           string emailText = 'There were errors processing parent/contact records while updating sending email related to news/event record. Find error message below:';
           emailText += '<br/>';
           emailText += errorMessage;
           mail.setHtmlBody(emailText);
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        }
    }

}