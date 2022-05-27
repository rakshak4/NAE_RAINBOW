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
public with sharing class ContractTriggerHandler {
    private CS_Bypass__c userBypass;

    public ContractTriggerHandler() {
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }

    public void OnAfterUpdate(List<Contract> lstOldCntrc, List<Contract> lstNewCntrc){
        List <Contract> lstContracts = new List <Contract>();
        
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP33')){
            for(Integer i = 0; i < lstOldCntrc.size(); i++) {
                if((lstOldCntrc[i].Region__c != lstNewCntrc[i].Region__c) || (lstOldCntrc[i].Status != lstNewCntrc[i].Status)){
                    lstContracts.add(lstNewCntrc[i]);
                }
            }      
        }
        
        if(lstContracts.size()>0){
            Ap33_ContractRules.updateAccountSpecificRegions(lstContracts);
        }
    }

    public void OnAfterDelete(List<Contract> lstOldCntrc){
        List <Contract> lstContracts = new List <Contract>();
        
        for(Contract con: lstOldCntrc){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP33')){
                if(con.Status=='Activated') lstContracts.add(con);
            }
        }

        if(lstContracts.size()>0){
            Ap33_ContractRules.updateAccountSpecificRegions(lstContracts);
        }
    }
}