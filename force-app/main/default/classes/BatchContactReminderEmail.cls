//batch class to update parent records on every sunday
global class BatchContactReminderEmail implements Database.Batchable<sObject>,Database.Stateful{   
  global string errorMessage {get;set;}
  global list<ProcessRunSummary> processSummary {get;set;}
  //Batch Interface Methods
  global Database.QueryLocator start(Database.BatchableContext BC) {
	processSummary = new list<ProcessRunSummary>();
	errorMessage = '';
	//fetch school settings 
    set<String> schools = new set<String>();
	for(School_Logo_Mapping__c schoolMapping : School_Logo_Mapping__c.getall().values()){
		if(schoolMapping.School_Full_Name__c != null){
			if(schoolMapping.Send_Sunday_Calendar_Reminder_Email__c == true){
				schools.add(schoolMapping.School_Full_Name__c);
			} 
		}
	}
    String q = 'Select Id,Primary_Contact__c, School__c, No_Calendar_View_Last_7_Days__pc from Account where RecordType.DeveloperName = \'PersonAccount\' AND School__c IN:schools AND Family_Qualifies_for_Calendar_Rem_Email__c = TRUE order by School__c '; 
    return Database.getQueryLocator(q);
    
  }
  
  global void execute(Database.BatchableContext BC, List<sObject> scope) {
	list<Account> accList = scope;
	set<Id> parentAccountIds = new set<Id>();
	list<Account> parentsToBeUpdated = new list<Account>();
	map<Id,Account> personAccountMap = new map<Id,Account>();
	for(Account parent:accList){
		parentAccountIds.add(parent.Id);
		if(parent.No_Calendar_View_Last_7_Days__pc == true){
			parentsToBeUpdated.add(new Account(Id=parent.Id, Send_Calendar_View_Reminder_Email__pc=true));
			personAccountMap.put(parent.Id,parent);
		}
	}
	//fetch additional parents
	list<Contact> contactsTobeUpdated = new list<Contact>();
	map<Id,Contact> additionalContactMap = new map<Id,Contact>();
	for(Contact con:[select Id, Main_Parent_File__r.Primary_Contact__c, Main_Parent_File__r.School__c from Contact where RecordType.DeveloperName = 'Additional_Parent' AND Main_Parent_File__c IN:parentAccountIds AND No_Calendar_View_Last_7_Days__c = true]){
			contactsTobeUpdated.add(new Contact(Id=con.Id,Send_Calendar_View_Reminder_Email__c =true));	
			additionalContactMap.put(con.Id,con);
	}
	if(parentsToBeUpdated.size() > 0){ 
		//update parentsToBeUpdated;
		//update contactsToBeUpdated;
        list<Database.SaveResult> srList = Database.update(parentsToBeUpdated,false);
        integer i = 0;
        for(Database.Saveresult sr:srlist){
            Account parent = personAccountMap.get(parentsToBeUpdated[i].Id);
            ProcessRunSummary summary = getRunSummary(parent.School__c);
            if(summary == null){
            	summary = new ProcessRunSummary(parent.School__c);
            	processSummary.add(summary);
            }
            if(!sr.isSuccess()){
                if(errorMessage == ''){
                    errorMessage += '<br/>'+'BatchContactReminderEmail - Error Occured while updating parent accounts for send calendar view email. ';
                }
                errorMessage += '<br/>'+'Error Occured updating parent record = '+parentsToBeUpdated[i]+'. Error Message: '+sr.getErrors();
            }else{
            	summary.successAccounts ++;
            	if(parent.Primary_Contact__c == 'First Parent'){
            		summary.successAccounts_primary ++;
            	}
            }
            i++;
        }
	}
	if(contactsToBeUpdated.size() > 0){
        //update contactsToBeUpdated;
        list<Database.SaveResult> srList = Database.update(contactsToBeUpdated,false);
        integer i = 0;
        for(Database.Saveresult sr:srlist){
        	Contact con = additionalContactMap.get(contactsToBeUpdated[i].Id);
            ProcessRunSummary summary = getRunSummary(con.Main_Parent_File__r.School__c);
            if(summary == null){
            	summary = new ProcessRunSummary(con.Main_Parent_File__r.School__c);
            	processSummary.add(summary);
            }
            if(!sr.isSuccess()){
                if(errorMessage == ''){
                    errorMessage += '<br/>'+'BatchContactReminderEmail - Error Occured while updating additional parents for send calendar view email. ';
                }
                errorMessage += '<br/>'+'Error Occured updating contact record = '+contactsToBeUpdated[i]+'. Error Message: '+sr.getErrors();
            }else{
            	summary.successContacts ++;
            	if(con.Main_Parent_File__r.Primary_Contact__c != 'First Parent'){
            		summary.successContacts_primary ++;
            	}
            }
            i++;
        }
    }
    //now update Send_Calendar_View_Reminder_Email__c to false
    if(parentsToBeUpdated.size() > 0){
		list<Account> parentToBeUpdated2 = new list<Account>();
		for(Account a:parentsToBeUpdated){
			parentToBeUpdated2.add(new Account(Id=a.Id, Send_Calendar_View_Reminder_Email__pc = false));
		}
		
		//update contactsToBeUpdated;
        list<Database.SaveResult> srList = Database.update(parentToBeUpdated2,false);
        integer i = 0;
        for(Database.Saveresult sr:srlist){
            if(!sr.isSuccess()){
                if(errorMessage == ''){
                    errorMessage += '<br/>'+'BatchContactReminderEmail - Error Occured while updating parent accounts for send calendar view email to false. ';
                }
                errorMessage += '<br/>'+'Error Occured updating contact record = '+parentToBeUpdated2[i]+'. Error Message: '+sr.getErrors();
            }
            i++;
        }
	}
	if(contactsToBeUpdated.size() > 0){
		list<Contact> contactToBeUpdated2 = new list<Contact>();
		for(Contact a:contactsToBeUpdated){
			contactToBeUpdated2.add(new Contact(Id=a.Id, Send_Calendar_View_Reminder_Email__c = false));
		}
        //update contactsToBeUpdated;
        list<Database.SaveResult> srList = Database.update(contactToBeUpdated2,false);
        integer i = 0;
        for(Database.Saveresult sr:srlist){
            if(!sr.isSuccess()){
                if(errorMessage == ''){
                    errorMessage += '<br/>'+'BatchContactReminderEmail - Error Occured while updating additional parents for send calendar view email to false. ';
                }
                errorMessage += '<br/>'+'Error Occured updating contact record = '+contactToBeUpdated2[i]+'. Error Message: '+sr.getErrors();
            }
            i++;
        }
    }            
    
  }
  
  global void finish(Database.BatchableContext BC){
  	   if(errorMessage != ''){
            //send email to Ben, Kunal
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           list<String> toAddresses =  new list<String>();
           toAddresses.add('ben.hails@britishschools.co.uk');
           toAddresses.add('kunal.sharma@britishschools.co.uk');
           
           //String[] toAddresses = new String[] {'ben.hails@britishschools.co.uk','kunal.sharma@britishschools.co.uk'};
           mail.setToAddresses(toAddresses);
           mail.setSubject('BatchContactReminderEmail -  Error occured');
           string emailText = 'There were errors processing parent/contact records while updating send calendar view email field. Find error message below:';
           emailText += '<br/>';
           emailText += errorMessage;
           mail.setHtmlBody(emailText);
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        }
        if(true){
            //send email to Ben, Kunal
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           list<String> toAddresses =  new list<String>();
           toAddresses.add('ben.hails@britishschools.co.uk');
           toAddresses.add('kunal.sharma@britishschools.co.uk');
           toAddresses.add('anton.simanikhin@britishschools.co.uk');
     
           mail.setToAddresses(toAddresses);
           mail.setSubject('BatchContactReminderEmail -  Run Report - '+date.today());
           string emailText = '';
           for(ProcessRunSummary summary:processSummary){
           	  emailText += '<br/>';
           	  emailText += '*********** '+summary.school+' ***********<br/>';
           	  emailText += 'Total emails sent to first parent (account) = '+summary.successAccounts +' ('+summary.successAccounts_primary+' of which are primary contacts)';
           	  emailText += '<br/>';
           	  emailText += 'Total emails sent to second parent (contact) = '+summary.successContacts+' ('+summary.successContacts_primary+' of which are primary contacts)';
           	  emailText += '<br/>';
           }
          
           mail.setHtmlBody(emailText);
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        }
        
  }
  
  public ProcessRunSummary getRunSummary(string school){
  	 for(ProcessRunSummary s:processSummary){
  	 	if(s.school == school){
  	 		return s;
  	 	}
  	 }
  	 return null;
  }
  
  public class ProcessRunSummary{
  	public string school {get;set;}
  	public Integer successAccounts ;
  	public Integer successAccounts_primary ;
   	public Integer successContacts ;
   	public Integer successContacts_primary ;
   	public ProcessRunSummary(string s){
   		school = s;
   		successAccounts = 0;
   		successAccounts_primary = 0;
   		successContacts = 0;
   		successContacts_primary = 0;
   	}
  	
  }
  
}