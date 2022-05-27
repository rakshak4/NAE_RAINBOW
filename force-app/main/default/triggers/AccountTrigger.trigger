trigger AccountTrigger on Account (before insert, before update,after update, after insert, before delete, after delete) {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Trigger on Account
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 18-MAY-2018  RRAJ    1.0     Initial version
-- 14-OCT-2019  CRA     1.1     Add Trigger before update
-- 30-MAR-2021  VJA     2.0     NDM: Acc handle before delete (Explicitly delete opps to invoke opp trigger)
-- 24-SEP-2021  FKH     2.2     Case 00004164: BigFoot requirement
-- 22-OCT-2021  FKH     2.3     Case 00004232: Autumn Leaves Enhancement
--------------------------------------------------------------------------------------
**************************************************************************************/ 
  AccountTriggerHandler handler = new AccountTriggerHandler();

    if(Trigger.isInsert && Trigger.isBefore){
        handler.OnBeforeInsert(Trigger.new);
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new); //FKH Case 00004164
    }

    if(Trigger.isUpdate && Trigger.isBefore){ 
        handler.OnBeforeUpdate(Trigger.old, Trigger.new);
    }

    //VJA20210330 -NDM 2.0
    if(Trigger.isDelete && Trigger.isBefore){ 
        handler.handleBeforeDelete(Trigger.old);
    }

    if(Trigger.isUpdate && Trigger.isAfter){    //FKH Case 00004232
        handler.OnAfterUpdate(Trigger.old, Trigger.new);
    }

    //if(Trigger.isDelete && Trigger.isAfter){ // FKH Case 00004232
      //  handler.handleAfterDelete(Trigger.old);
    //}

}