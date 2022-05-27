trigger AccountContactRelationTrigger on AccountContactRelation (after delete, after update) {
/**
 * @description       : Trigger for AccountContactRelation - Case 00002304
 * @author            : Spoon Consulting
 * @group             : 
 * @last modified on  : 07-10-2020
 * @last modified by  : CRA
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-10-2020   CRA   Initial Version
**/
    AccountContactRelationTriggerHandler handler = new AccountContactRelationTriggerHandler();
    // if(Trigger.isDelete && Trigger.isAfter){
    //     handler.OnAfterDelete(Trigger.old);
    // }

    if(Trigger.isUpdate && Trigger.isAfter){ 
        handler.OnAfterUpdate(Trigger.old, Trigger.new);
    }

}