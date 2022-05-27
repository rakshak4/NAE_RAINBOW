/***
	Author: Kunal Sharma
	Created Date: 04 Feb 2013
	Description: Trigger to create a contact with record type "Student" and associate the same with Oppotunity/
	Audit Date:
	Audited By: 
	
	COMMENTS:
	

***/
trigger CreateStudentFromOppInsert on Opportunity (after insert) {
    system.debug('***CreateStudentFromOppInsert***start:'+trigger.newMap);
	/*
	//fetch record type Id of contact type "Student"
	
	Id studentRecordTypeId =  [select Id from RecordType where DeveloperName = 'Student' AND SObjectType='Contact' limit 1].Id;
 
	//fetch custom settings for mapping between Opp Owner Name and catch all account Id
	
	Map<String,String> settingsMap = new Map<String,String>();
    List<Account_Owner_Mapping__c> settings = Account_Owner_Mapping__c.getall().values(); 
    for(Account_Owner_Mapping__c sttng:settings){
        settingsMap.put(sttng.School_Name__c,sttng.Account_Id__c);
    }
       
	Set<Id> oppIds =  new Set<Id>();
	for(Opportunity o: trigger.new){
		oppIds.add(o.Id);
	}
	
	//fetch owner name of all opportunities
	Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>([Select o.Special_Considerations_Detail__c, o.Owner.Name, o.School__c, o.OwnerId From Opportunity o where o.Id IN:oppIds]);
	
	List<Contact> newContactList  =  new List<Contact>();
	
	for(Opportunity o: trigger.new){
		Contact student =  new Contact();
		student.Admissions_File__c =  o.Id;
		student.Main_Parent_File__c = o.AccountId;
		student.Special_Considerations_Detail__c = o.Special_Considerations_Detail__c;
		//formula to fetch right account id for contact's account
		String matchingCatchallAccId =  settingsMap.get(o.School__c);
		if(matchingCatchallAccId != null){
			student.AccountId = matchingCatchallAccId;
		}
		student.FirstName = o.Student_Name__c;
		student.LastName =  o.Student_Surname__c;
		if(student.LastName == null){
			student.LastName = 'NA';
		}
		//student.Email =  o.Student_Email__c;
		student.RecordTypeId  = studentRecordTypeId;
		newContactList.add(student);
	}
	
	if(newContactList.size() > 0){
		insert newContactList;
	}
	system.debug('***CreateStudentFromOppInsert***end:'+trigger.newMap);
	*/
}