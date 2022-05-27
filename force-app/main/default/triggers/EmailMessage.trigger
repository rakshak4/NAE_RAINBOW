trigger EmailMessage on EmailMessage (before insert, after insert, after update) {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Trigger on Account
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 21-June-2019  AFO    1.0     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/ 
    EmailMessageTriggerHandler handler = new EmailMessageTriggerHandler();
    
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