trigger LeadTrigger on Lead (after update, before insert, before update, after insert) {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Trigger on Lead
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 06-DEC-2017  RRAJ    1.0     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/ 
    LeadTriggerHandler handler = new LeadTriggerHandler(Trigger.isExecuting, Trigger.size);
    
    if(Trigger.isBefore && Trigger.isInsert) {
        handler.handleBeforeInsert(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert) {
        handler.handleAfterInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate) {
        handler.handleBeforeUpdate(Trigger.old, Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate) {
        handler.handleAfterUpdate(Trigger.old, Trigger.new);
    }
}