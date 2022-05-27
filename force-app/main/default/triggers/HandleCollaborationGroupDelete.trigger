//deletes reference of chatter group id on Group__c
trigger HandleCollaborationGroupDelete on CollaborationGroup (after delete) {
	set<Id> deletedGroups = new set<Id>();
	for(CollaborationGroup g:trigger.old){
		deletedGroups.add(g.Id);
	}
	//check in chatter groups
	list<Group__c> studentGroups =  new list<Group__c>();
	for(Group__c studentGroup:[select Id, Chatter_Group_Id__c from Group__c where Chatter_Group_Id__c IN: deletedGroups]){
		studentGroup.Chatter_Group_Id__c = null;
		studentGroups.add(studentGroup);
	}
	if(studentGroups.size() > 0){
		update studentGroups;
	}
}