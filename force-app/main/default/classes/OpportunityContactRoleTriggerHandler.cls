/**
 * @File Name          : OpportunityContactRoleTriggerHandler.cls
 * @Description        : OpportunityContactRoleTriggerHandler
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 23-09-2021 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    23-09-2021 10:00 am         VJA         Initial Version
**/
public with sharing class OpportunityContactRoleTriggerHandler {

    private CS_Bypass__c userBypass;

    public OpportunityContactRoleTriggerHandler(){
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }

    public void handleBeforeInsert(List<OpportunityContactRole> lstNewOppConRole){

        List<OpportunityContactRole> lstOppConRole = new List<OpportunityContactRole>();
        Set<Id> setConId = new Set<Id>();

        for(Integer i = 0; i < lstNewOppConRole.size(); i++){
            if (userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP28')) {
                if(lstNewOppConRole[i].Role == null){
                    lstOppConRole.add(lstNewOppConRole[i]);
                    setConId.add(lstNewOppConRole[i].ContactId);
                }
            }
        }

        if(lstOppConRole.size() > 0){
            AP28_OppConRoleRules.assignRoles(lstOppConRole, setConId);
        }

    }
}