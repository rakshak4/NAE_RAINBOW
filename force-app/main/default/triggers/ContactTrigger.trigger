trigger ContactTrigger on Contact (after delete, before insert, after insert, before update, after update) {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Modifier      : akaCRM
-- - Description   : Trigger on Contact
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 18-MAY-2018  RRAJ    1.0     Initial version
-- 21-SEPT-2018 YGO     1.1     Added after Update
-- 15-JULY-2021 FJO     1.1     akaCRM Added after update for ReEnrolment
-- 04-AUG-2021  FJO     1.1     akaCRM Added before update block ISAMS update if promoted year
--------------------------------------------------------------------------------------
**************************************************************************************/ 
    ContactTriggerHandler handler = new ContactTriggerHandler(Trigger.isExecuting, Trigger.size);

    if(Trigger.isBefore && Trigger.isInsert) {
        handler.handleBeforeInsert(Trigger.new);
    }
    else if(Trigger.isBefore && Trigger.isUpdate) {
        BF_ContactTriggerHandler bfHandler = new BF_ContactTriggerHandler();
        bfHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
        handler.handleBeforeUpdate(Trigger.old, Trigger.new);
    }    
    else if(Trigger.isAfter && Trigger.isInsert){
        handler.handleAfterInsert(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isUpdate){
        BF_ContactTriggerHandler bfHandler = new BF_ContactTriggerHandler();
        handler.handleAfterUpdate(Trigger.old, Trigger.new);
        bfHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
    else if(Trigger.isAfter && Trigger.isDelete) {
        handler.handleAfterDelete(Trigger.old);     
    }    
}