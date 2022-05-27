trigger TaskTrigger on Task (before insert, after insert, after update) {
    TaskTriggerHandler handler = new TaskTriggerHandler();
    
    if(Trigger.isInsert && Trigger.isBefore){
        handler.handleBeforeInsert(Trigger.new);
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        handler.handleAfterInsert(Trigger.new);
    }
    
    if(Trigger.isupdate && Trigger.isAfter){
        handler.handleAfterUpdate(Trigger.new);
    }
}