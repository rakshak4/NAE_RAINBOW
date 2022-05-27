/***
	Desc: to handle account email checkbox fields once "additional parent email" is inserted or updated
	Change Log:
	21 March 2014 - logic added to create additional parent email is contact is of type "additional parent"	
***/
trigger HandleContactAfterInsertUpdate on Contact (after insert, after update, after delete, after undelete) {
	system.debug('***HandleContactAfterInsertUpdate***start:'+trigger.newMap);  
	set<Id> accountIdsToBeUpDated =  new set<Id>();
	Id massEmailTypeId =  [select Id from RecordType where SObjectType='Contact' AND DeveloperName = 'Mass_Email' limit 1].Id;
	if(trigger.isUpdate || trigger.isInsert || trigger.isUnDelete){
		for(Contact c:trigger.new){
			if(c.RecordTypeId == massEmailTypeId){
				if((trigger.isInsert || trigger.isUnDelete) && c.Email != null && c.HasOptedOutOfEmail == false){
					accountIdsToBeUpDated.add(c.Main_Parent_File__c);
				}else if(trigger.isUpdate){
					if(c.Email !=  trigger.oldMap.get(c.Id).Email || c.HasOptedOutOfEmail !=  trigger.oldMap.get(c.Id).HasOptedOutOfEmail ){
						accountIdsToBeUpDated.add(c.Main_Parent_File__c);
					}
				}
			}
		} 
	}else if(trigger.isDelete){
		for(Contact c:trigger.old){
			if(c.RecordTypeId == massEmailTypeId){
				accountIdsToBeUpDated.add(c.Main_Parent_File__c);
			}
		}
	}
	system.debug('***HandleContactAfterInsertUpdate***accountIdsToBeUpDated:'+accountIdsToBeUpDated);
	List<Account> accountsToBeUpdated = new List<Account>();
	if(accountIdsToBeUpDated.size() >  0){
		for(Id aid:accountIdsToBeUpDated){
			if(aid != null){
				accountsToBeUpdated.add(new Account(Id=aid));
			}
		}
	}
	if(accountsToBeUpdated.size() > 0){
		update accountsToBeUpdated;
	}
	
	/**** changes begin - 12 March 2014 - to create additional parent email record for contact of type "additional parent" ***/
    //fetch additional parent record type id
	Id additionalParentTypeId =  [select Id from RecordType where SObjectType='Contact' AND DeveloperName = 'Additional_Parent' limit 1].Id;	
	list<Contact> newMassEmailContacts =  new list<Contact>();
	set<Id> updatedAdditionalParents =  new set<Id>();
	set<Id> deletedAdditionalParents =  new set<Id>();
	if(trigger.isInsert || trigger.isUnDelete || trigger.isUpdate){
		for(Contact con:trigger.new){
			if((trigger.isInsert || trigger.isUnDelete) && con.RecordTypeId == additionalParentTypeId){
				Contact massEmail =  new Contact();
				massEmail.Additional_Parent__c = con.Id;
				massEmail.Email  = con.Contact_Alternate_Email__c;
				massEmail.Main_Parent_File__c = con.Main_Parent_File__c;
				massEmail.AccountId = con.AccountId;
				massEmail.RecordTypeId = massEmailTypeId;
				massEmail.FirstName = con.FirstName;
				massEmail.LastName  =  con.LastName;
				massEmail.HasOptedOutOfEmail = con.Contact_Alternate_Email_Opt_Out__c;
				massEmail.Salutation = con.Salutation;
				newMassEmailContacts.add(massEmail);
			}else if(trigger.isUpdate && con.RecordTypeId == additionalParentTypeId && (con.Contact_Alternate_Email__c !=  trigger.oldMap.get(con.Id).Contact_Alternate_Email__c || con.FirstName != trigger.oldMap.get(con.Id).FirstName || con.LastName != trigger.oldMap.get(con.Id).LastName || con.Salutation != trigger.oldMap.get(con.Id).Salutation || con.Contact_Alternate_Email_Opt_Out__c != trigger.oldMap.get(con.Id).Contact_Alternate_Email_Opt_Out__c)){
				updatedAdditionalParents.add(con.Id);
			}		
		}
	}else if(trigger.isDelete){
		for(Contact con:trigger.old){
			if(con.RecordTypeId == additionalParentTypeId){
				deletedAdditionalParents.add(con.Id);
			}
		}
	}
	system.debug('***HandleContactAfterInsertUpdate***newMassEmailContacts='+newMassEmailContacts);
	system.debug('***HandleContactAfterInsertUpdate***updatedAdditionalParents='+updatedAdditionalParents);
	system.debug('***HandleContactAfterInsertUpdate***deletedAdditionalParents='+deletedAdditionalParents);
	//for new additional parents
	if(newMassEmailContacts.size()  > 0){
		insert newMassEmailContacts;
	}
	//for updated additional parents
	if(updatedAdditionalParents.size() > 0){
		list<Contact> massEmailContacts =  new list<Contact>();
		for(Contact massEmail:[select Id,Contact_Alternate_Email__c,Email,Additional_Parent__c from Contact where RecordTypeId=:massEmailTypeId AND Additional_Parent__c IN:updatedAdditionalParents]){
			massEmail.Email  = trigger.newMap.get(massEmail.Additional_Parent__c).Contact_Alternate_Email__c;
			massEmail.FirstName = trigger.newMap.get(massEmail.Additional_Parent__c).FirstName;
			massEmail.LastName = trigger.newMap.get(massEmail.Additional_Parent__c).LastName;
			massEmail.Salutation = trigger.newMap.get(massEmail.Additional_Parent__c).Salutation;
			massEmail.HasOptedOutOfEmail = trigger.newMap.get(massEmail.Additional_Parent__c).Contact_Alternate_Email_Opt_Out__c;
			massEmailContacts.add(massEmail);
		}
		if(massEmailContacts.size() > 0){
			update massEmailContacts;
		}
	}
	//for deleted additional parents
	if(deletedAdditionalParents.size() > 0){
		list<Contact> massEmailContacts =  new list<Contact>();
		for(Contact massEmail:[select Id,Email,Additional_Parent__c from Contact where RecordTypeId=:massEmailTypeId AND Additional_Parent__c IN:updatedAdditionalParents]){
			massEmailContacts.add(massEmail);
		}
		if(massEmailContacts.size() > 0){
			delete massEmailContacts;
		}
	}
	/**** changes end - 12 March 2014 - to create additional parent email record for contact of type "additional parent" ***/
	system.debug('***HandleContactAfterInsertUpdate***end:'+trigger.newMap);
}