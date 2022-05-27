trigger Opp_update_on_acc_edit on Account(after insert, after update){
	system.debug('******Opp_update_on_acc_edit*****start='+trigger.newMap);
	boolean invoke = false;
	for(Account acc:trigger.new){
		if(trigger.isInsert){
			if(acc.F_Info_Bus_Service__c == true){
				invoke = true;
			}
		}else if(trigger.isUpdate){
			if(acc.F_Info_Bus_Service__c != trigger.oldMap.get(acc.Id).F_Info_Bus_Service__c){
				invoke = true;
			}
		}
	}
	if(invoke){
		ASPIRAX.RelationHandler.invoke();
	}
	system.debug('******Opp_update_on_acc_edit*****end='+trigger.newMap);
}