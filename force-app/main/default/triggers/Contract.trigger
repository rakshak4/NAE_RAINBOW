/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Account Trigger Handler Class
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 30-MAR-2021  FKH    1.0     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/
trigger Contract on Contract (after update,after delete) {
	ContractTriggerHandler handler = new ContractTriggerHandler();
	
	if(Trigger.isUpdate && Trigger.isAfter){ 
		handler.OnAfterUpdate(Trigger.old, Trigger.new);
	}

	if(Trigger.isDelete && Trigger.isAfter){ 
		handler.OnAfterDelete(Trigger.old);
	}

}