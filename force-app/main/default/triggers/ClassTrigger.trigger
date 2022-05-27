/*************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Trigger on Account
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 30-MAR-2021  FKH    1.0     Initial version
-- 20-APR-2021  VJA    1.1     Added After Update
--------------------------------------------------------------------------------------
**************************************************************************************/ 
trigger ClassTrigger on Class__c (before insert, before update, after insert, before delete, after update) {
    
    ClassTriggerHandler handler = new ClassTriggerHandler();

    if(Trigger.isInsert && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new);
    }

    if(Trigger.isUpdate && Trigger.isAfter){
        handler.OnAfterUpdate(Trigger.old, Trigger.new);
    }
    
}