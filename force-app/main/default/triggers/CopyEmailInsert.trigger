/***
	change log:
	29 Nov 2013 : Kunal: logic added for handling email checkbox fields
	Kunal on 11 July 2016: Logic added for email duplication check
***/
trigger CopyEmailInsert on Account (before insert, before update, before delete)  
{  
	if(trigger.isDelete){
		//check for mass email account
		Id systemAdminProfileId  =  [select Id from Profile where Name = 'System Administrator'].Id;
		for(Account a:trigger.old){
			if(a.Is_Mass_Email_Company__c == true && UserInfo.getProfileId() != systemAdminProfileId){
				a.addError('You can not delete mass email company account');
			}
		}
	}
	/*
	if(trigger.isInsert || trigger.isUpdate){
		for(Account a:trigger.new){
			a.Person_Contact_Id__c = a.PersonContactId;
		}
	}*/
	
	/* //logic added for handling email checkbox fields -  commented on 25 March 2014
	system.debug('***CopyEmailInsert***start:'+trigger.new);
	
	Account myAccount = trigger.new[0];
 	{
		myAccount.Email_1__c = myAccount.PersonEmail;
	}// else nothing
    
	//Start -- > 29 Nov 2013 : Kunal: logic added for handling email checkbox fields
	if(trigger.isUpdate){
		set<Id> accountIds =  new set<Id>();
		for(Account a:trigger.new){
			accountIds.add(a.Id);
		}
		//fetch account and mass email contacts 
		Map<Id,Account> accountMap =  new Map<Id,Account>([Select a.Email_2__c, a.Second_Parent_Email_1__c, a.PersonEmail, a.Has_Additional_Mass_Email_Record_P2_E2__c, a.Has_Additional_Mass_Email_Record_P2_E1__c, a.Has_Additional_Mass_Email_Record_P1_E2__c, a.Has_Additional_Mass_Email_Record_P1_E1__c, a.First_Parent_Email_2__c, a.First_Parent_Email_1__c, (Select Email, HasOptedOutOfEmail  From  Emails__r where (RecordType.DeveloperName = 'Mass_Email' OR RecordType.DeveloperName = 'Additional_Parent')  ) From Account a where a.Id IN:accountIds]);
		for(Account a:trigger.new){
			//fetch account map
			Account fromMap = accountMap.get(a.Id);
			if(fromMap != null){
				string p1email1 = a.PersonEmail;
				string p1email2 = a.First_Parent_Email_1__c;
				string p2email1 = a.Email_2__c;
				string p2email2 = a.Second_Parent_Email_1__c;
				//create set of email under mass email records
				set<string> massEmails =  new set<string>();
				for(Contact c:fromMap.Emails__r){
					if(c.Email != null && c.HasOptedOutOfEmail == false){
						massEmails.add(c.Email);
					}
				}
				//check for parent 1 email 1
				if(p1email1 != null && massEmails.contains(p1email1)){
					a.Has_Additional_Mass_Email_Record_P1_E1__c = true;
				}else{
					a.Has_Additional_Mass_Email_Record_P1_E1__c = false;
				}
				//check for parent 1 email 2
				if(p1email2 != null && massEmails.contains(p1email2)){
					a.Has_Additional_Mass_Email_Record_P1_E2__c = true;
				}else{
					a.Has_Additional_Mass_Email_Record_P1_E2__c = false;
				}
				//check for parent 2 email 1
				if(p2email1 != null && massEmails.contains(p2email1)){
					a.Has_Additional_Mass_Email_Record_P2_E1__c = true;
				}else{
					a.Has_Additional_Mass_Email_Record_P2_E1__c = false;
				}
				//check for parent 2 email 2
				if(p2email2 != null && massEmails.contains(p2email2)){
					a.Has_Additional_Mass_Email_Record_P2_E2__c = true;
				}else{
					a.Has_Additional_Mass_Email_Record_P2_E2__c = false;
				}
				
			}
		}
	}
	//End -- > 29 Nov 2013 : Kunal: logic added for handling email checkbox fields
	*/
	
	/* logic for email duplication check */
    	if(trigger.isUpdate && trigger.isBefore){
    		set<Id> accountsForEmailChange =  new set<Id>();
    		for(Account acc:trigger.new){
    			if(acc.RT_Developer_Name__pc == 'PersonAccount'){
    				if((acc.PersonEmail != trigger.oldMap.get(acc.Id).PersonEmail && acc.PersonEmail != null) || (acc.Contact_Alternate_Email__pc != trigger.oldMap.get(acc.Id).Contact_Alternate_Email__pc && acc.Contact_Alternate_Email__pc != null)){
    					accountsForEmailChange.add(acc.Id);
    				}
    			}
    		}
    		if(accountsForEmailChange.size() > 0){
    			//fetch additional parets details 
    			map<Id,Account> accountMap =  new map<Id,Account>([Select a.Id, PersonEmail,Contact_Alternate_Email__pc,  (Select Id, Email, Contact_Alternate_Email__c  From Emails__r where RecordType.DeveloperName = 'Additional_Parent') From Account a where Id IN:accountsForEmailChange]);
    			//check for duplicate
    			for(Account acc:trigger.new){
    				if(accountsForEmailChange.contains(acc.Id)){
    					//check for all addtional parents
    					for(Contact additionalParent:accountMap.get(acc.Id).Emails__r){
    						if((acc.PersonEmail != null && (acc.PersonEmail == additionalParent.Email || acc.PersonEmail == additionalParent.Contact_Alternate_Email__c)) || (acc.Contact_Alternate_Email__pc != null && (acc.Contact_Alternate_Email__pc == additionalParent.Email || acc.Contact_Alternate_Email__pc == additionalParent.Contact_Alternate_Email__c))){
    							acc.Has_Duplicate_Email__pc = true;
    							break;
    						}else{
    							acc.Has_Duplicate_Email__pc = false;
    						}
    					}
    				}
    			}
    		}
    	}
    
    /* end logic for email duplication check */
}