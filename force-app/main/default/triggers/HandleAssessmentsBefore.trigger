//validation check for assessment 
trigger HandleAssessmentsBefore on Assesment__c (before insert) {
    set<string> keyset = new set<String>();
    set<Id> studentIds = new set<Id>();
    set<Id> folderIds = new set<Id>();
    for(Assesment__c a:trigger.new){
        if(a.Student__c != null){ studentIds.add(a.Student__c);}
       
        if(a.Assessment_Folder__c != null){folderIds.add(a.Assessment_Folder__c);}
        if(a.Student__c != null && a.Assessment_Folder__c != null){
        	keyset.add(a.Student__c+'-'+a.Assessment_Folder__c);
        }
    	
    }
    set<string> existingKeySet = new set<String>();
    for(Assesment__c existingAssessments:[select Id, Student__c,Assessment_Folder__c from Assesment__c where Student__c IN:studentIds AND Assessment_Folder__c IN:folderIds AND RecordType.DeveloperName = 'Assessment_Record' ]){
            if(existingAssessments.Student__c != null && existingAssessments.Assessment_Folder__c != null){
            	existingKeySet.add(existingAssessments.Student__c+'-'+existingAssessments.Assessment_Folder__c);
            }
    }
    
    //check for duplication
    for(Assesment__c a:trigger.new){
    	if(a.Student__c != null && a.Assessment_Folder__c != null){
	        if(existingKeySet.contains(a.Student__c+'-'+a.Assessment_Folder__c) && a.Assessment_Display_Name__c != 'Summative Comment'){
	            a.addError('Assessment record already exists for student.');
	        }
    	}
    }
}