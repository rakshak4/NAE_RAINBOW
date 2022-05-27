trigger HandleEventBefore on Event (before insert, before update) {
    for(Event event:trigger.new){
    	if(event.RT_Developer_Name__c == 'Attendance'){
    		if(event.Student__c != event.WhoId){
    			event.Student__c = event.WhoId;
    		}
    		if(event.Student_Group__c != event.WhatId){
    			event.Student_Group__c = event.WhatId;
    		}
    	}
    }
}