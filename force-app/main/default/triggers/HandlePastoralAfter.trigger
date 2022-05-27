//to sum up pastoral info on pastoral folder
trigger HandlePastoralAfter on Conduct__c (after insert, after update, after delete) {
	set<Id> folderIds = new set<Id>();
	if(trigger.isInsert || trigger.isUpdate){
		for(Conduct__c c:trigger.new){
			if(c.Folder__c != null){
				folderIds.add(c.Folder__c);
			}
		}
	}
	if(trigger.isDelete){
		for(Conduct__c c:trigger.old){
			if(c.Folder__c != null){
				folderIds.add(c.Folder__c);
			}
		}
	}
	if(folderIds.size() > 0){
		list<Conduct__c> folders = new list<Conduct__c>();
		for(Conduct__c c:[select Id, Name, (Select Id, Name, Is_Approved__c, RecordType.Name, Pastoral_Date__c from Pastorals__r where RecordType.DeveloperName != 'Pastoral_Folder') from Conduct__c where Id IN:folderIds AND RecordType.DeveloperName = 'Pastoral_Folder']){
			Conduct__c folder = new Conduct__c(Id=c.Id);
			integer approvedRecords = 0 ;
			integer totalRecords = 0;
			for(Conduct__c pastoral:c.Pastorals__r){
				if(pastoral.Is_Approved__c){
					approvedRecords++;
				}
				totalRecords++;
			}
			folder.Number_of_Approved_Pastorals_in_Folder__c = approvedRecords;
			folder.Number_of_Pastorals_in_Folder__c = totalRecords;
			folders.add(folder);
		}
		if(folders.size() > 0){
			update folders;
		}
	}
}