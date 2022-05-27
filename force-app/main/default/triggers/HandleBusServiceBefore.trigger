trigger HandleBusServiceBefore on Bus_Association__c (before delete) {
    if(trigger.isDelete && trigger.isBefore){
        for(Bus_Association__c bs:trigger.old){
            if(bs.Allow_Delete__c == false){
                bs.addError('You cannot delete this bus service because it is "Current" or has been "Current" at some point in the past. If you need further assistance please contact the group office.');
            }
        }
    }
}