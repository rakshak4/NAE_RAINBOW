trigger EventTrigger on Event (after insert, after update) {
    EventTriggerHandler handler = new EventTriggerHandler();
    
    if(Trigger.isUpdate && Trigger.isAfter){
        System.debug('##Trigger starts');
        handler.handleAfterUpdate(Trigger.old, Trigger.new);
    }
    
    else if(Trigger.isInsert && Trigger.isAfter){
        System.debug('##Trigger starts');
        handler.handleAfterInsert(Trigger.new);
    }
}