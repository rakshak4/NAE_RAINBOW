/**
 * @description       : Trigger Handler for AccountContactRelation object - Case 00002403
 * @author            : CRA
 * @group             : 
 * @last modified on  : 07-10-2020
 * @last modified by  : CRA
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-10-2020   CRA   Initial Version
**/
public with sharing class AccountContactRelationTriggerHandler {
    private CS_Bypass__c userBypass;

    public AccountContactRelationTriggerHandler(){
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }

    // public void OnAfterInsert(List<AccountContactRelation> lstNewOppConRole){
    //     if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP28')){
    //         AP28_OppConRoleRules.createRole(lstNewOppConRole);
    //     }
    // }

    public void OnAfterUpdate(List<AccountContactRelation> lstOldOppConRole, List<AccountContactRelation> lstNewOppConRole) {
        Map<Id, List<AccountContactRelation>> mapConToAccConRel = new Map<Id, List<AccountContactRelation>> ();
        for(integer i=0; i<lstNewOppConRole.size(); i++){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP28')){
                if (lstOldOppConRole[i].Roles != lstNewOppConRole[i].Roles) {
                    if (mapConToAccConRel.containsKey(lstNewOppConRole[i].ContactId)) {
                        mapConToAccConRel.get(lstNewOppConRole[i].ContactId).add(lstNewOppConRole[i]);
                    }
                    else {
                        mapConToAccConRel.put(lstNewOppConRole[i].ContactId, new List<AccountContactRelation>{lstNewOppConRole[i]});
                    }
                }
            }
        }

        if (mapConToAccConRel.size() > 0) {
            AP28_OppConRoleRules.updateRole(mapConToAccConRel);
        }
    }
}