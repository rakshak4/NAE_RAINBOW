trigger ApplicationDocumentTrigger on ApplicationDocument__c (after insert, after update) {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Trigger on Application Document
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 03-JAN-2018  RRAJ    1.0     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/ 
    ApplicationDocumentTriggerHandler handler = new ApplicationDocumentTriggerHandler();

    if(Trigger.isAfter && Trigger.isInsert) {
        handler.handleAfterInsert(Trigger.new);     
    }
}