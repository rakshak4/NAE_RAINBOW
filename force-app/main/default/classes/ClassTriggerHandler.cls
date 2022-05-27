/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Account Trigger Handler Class
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 30-MAR-2021  FKH    1.0     Initial version
-- 20-APR-2021  VJA    1.1     Added After Update
--------------------------------------------------------------------------------------
**************************************************************************************/
public with sharing class ClassTriggerHandler {
    private CS_Bypass__c userBypass;

    public ClassTriggerHandler() {
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }

    public void OnAfterInsert(List<Class__c> lstNewClass){
        Set<id> setClassId = new Set<id>();

        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP31')){
            for (Class__c cl:lstNewClass){
                setClassId.add(cl.id);
            }           
        }

        if(setClassId.size()>0){
            AP31_ClassRules.createClassCapacity(setClassId);
        }
    }

    public void OnAfterUpdate(List<Class__c> lstOldClass, List<Class__c> lstNewClass){
        Set<id> setClassId = new Set<id>();

        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP31')){
            for(Integer i = 0; i < lstOldClass.size(); i++){
                if(lstOldClass[i].SchoolName__c == null && lstNewClass[i].SchoolName__c != null){
                    setClassId.add(lstNewClass[i].id);
               }
            }           
        }

        if(setClassId.size()>0){
            AP31_ClassRules.createClassCapacity(setClassId);
        }
    }
}