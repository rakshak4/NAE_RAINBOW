//create student registration record for school student group
trigger HandleStudentInsert on Contact (after insert,before insert) {
	if(trigger.isAfter){
		/*
		Map<String,String> schoolStudentGroupMap =  new Map<String,String>();
		//fetch student group created for school from custom settings
		for(School_Logo_Mapping__c schoolMapping : School_Logo_Mapping__c.getall().values()){	
			if(schoolMapping.All_Student_Group_Id__c != null){
				schoolStudentGroupMap.put(schoolMapping.School_Full_Name__c,schoolMapping.All_Student_Group_Id__c);
			}
		}
		Id studentRecordTypeId  = [Select Id from RecordType where SobjectType='Contact' AND DeveloperName='Student' limit 1].Id;
		List<Registration__c> newRegistrations =  new List<Registration__c>();
		set<Id> studentIdsforRegistration =  new set<Id>();
		for(Contact student:trigger.new){
			if(student.RecordTypeId == studentRecordTypeId){
				//fetch student group at school level
				if(schoolStudentGroupMap.get(student.School__c) != null){
					Registration__c registration = new Registration__c();
	    			registration.Student__c = student.Id;
	    			studentIdsforRegistration.add(student.Id);
	    			registration.Group__c =  schoolStudentGroupMap.get(student.School__c);
	    			registration.Active__c =  false;
	    			
	    			newRegistrations.add(registration);
				}
			}
		}
		if(newRegistrations.size()  > 0){
			list<Contact> forUpdation =  new list<Contact>();
			try{
				insert newRegistrations;
				//check for students for which registration was not created
				for(Contact student:trigger.new){
					if(!studentIdsforRegistration.contains(student.Id)){
						student.Auto_Registration_Error__c = 'YES';
						forUpdation.add(student);
					}
				}
			}catch(Exception e){
				//mark error on all records
				for(Contact student:trigger.new){
					student.Auto_Registration_Error__c = 'YES';
					forUpdation.add(student);
				}
			}
			if(forUpdation.size() > 0){
				update forUpdation;
			}
		}
		*/
	}
	//for account secondary contact population
	if(trigger.isAfter){
		//fetch contact additional parent recordtype id
		Id additionalParentId =  [select Id from RecordType where SObjectTYpe='Contact' AND DeveloperName='Additional_Parent'].Id;
		set<Id> parentIds =  new set<Id>();
		for(Contact c:trigger.new){
			if(c.RecordTypeId == additionalParentId && c.Main_Parent_File__c != null){
				parentIds.add(c.Main_Parent_File__c);
			}
		}
		//fetch account
		if(parentIds.size() > 0){
			Map<Id,Account> parentsMap = new Map<Id,Account>([select Id,Related_Contact_Record_P2__c from Account where Id IN:parentIds]);
			list<Account> accList =  new list<Account>();
			for(Contact c:trigger.new){
				Account parent = parentsMap.get(c.Main_Parent_File__c);
				if(parent != null){
					if(parentsMap.get(c.Main_Parent_File__c).Related_Contact_Record_P2__c == null){
						parentsMap.get(c.Main_Parent_File__c).Related_Contact_Record_P2__c = c.Id;
						accList.add(parentsMap.get(c.Main_Parent_File__c));
					}
				}
			}
			if(accList.size() > 0){
				update accList;
			}
		}
	}
}