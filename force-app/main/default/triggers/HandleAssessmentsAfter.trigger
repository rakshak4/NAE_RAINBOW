//to manage assessment summary on folder
trigger HandleAssessmentsAfter on Assesment__c (after insert, after update, after delete, after undelete) {
	//Id assessmentRecodTypeRecord = [select Id from RecordType where SObjectType='Assesment__c' AND DeveloperName='Assessment_Record'].Id;
	set<Id> assessmentFolderIds =  new set<Id>();
	if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){
		for(Assesment__c a:trigger.new){
			//if(assessmentRecodTypeRecord == a.RecordTypeId){	
			if(a.Record_Type_Name__c == 'Assessment_Record'){			
				assessmentFolderIds.add(a.Assessment_Folder__c);
			}
		}
	}
	if(trigger.isDelete){
		for(Assesment__c a:trigger.old){
			//if(assessmentRecodTypeRecord == a.RecordTypeId){	
			if(a.Record_Type_Name__c == 'Assessment_Record'){			
				assessmentFolderIds.add(a.Assessment_Folder__c);
			}
		}
	}
	 
	if(assessmentFolderIds.size() > 0){
		list<Assesment__c> foldersToUpdate =  new list<Assesment__c>();
		for(Assesment__c folder:[Select a.Title__c, a.Name, a.Id, (Select Id,Auto_Approve__c From Assessments__r where RecordType.DeveloperName = 'Assessment_Record') From Assesment__c a where a.Id IN:assessmentFolderIds]){
			decimal approved_records = 0;
			decimal total_records = 0;
			for(Assesment__c record:folder.Assessments__r){
				if(record.Auto_Approve__c){
					approved_records++;
				}
				total_records++;
			}
			folder.Number_of_Approved_Assessments_in_Folder__c = approved_records;
			folder.Number_of_Assessments_in_Folder__c = total_records;
			foldersToUpdate.add(folder);
		} 
		if(foldersToUpdate.size() > 0){
			update foldersToUpdate;
		}
	}
	
	
	
}