trigger OpportunityTrigger on Opportunity (after update, after insert, before update, before insert, before delete) {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Trigger on Opportunity
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 04-JAN-2018  RRAJ    1.0     Initial version
-- 10-FEB-2021  VJA     2.0     Added Before Delete
-- 04-AUG-2021  FJO     2.0     akaCRM Added Before Insert
-- 11-OCT-2021  FJO    	2.1     Static variable added
--------------------------------------------------------------------------------------
**************************************************************************************/ 
    OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
    BF_OpportunityTriggerHandler bfHandler = new BF_OpportunityTriggerHandler();

    if(Trigger.isAfter && Trigger.isInsert) {
        handler.handleAfterInsert(Trigger.new);   
    }

    if(Trigger.isBefore && Trigger.isInsert) {
        handler.handleBeforeInsert(Trigger.new);
    }

    if(Trigger.isAfter && Trigger.isUpdate) {
        if(BF_OpportunityTriggerHandler.run){
            bfHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    	handler.handleAfterUpdate(Trigger.new, Trigger.old);
    }

    if(Trigger.isBefore && Trigger.isUpdate) {
        handler.handleBeforeUpdate(Trigger.new, Trigger.old);
    }

    if(Trigger.isBefore && Trigger.isDelete) {
        handler.handleBeforeDelete(Trigger.old);
    }
}