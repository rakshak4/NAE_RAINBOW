/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : 
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 30-May-2019  AFO    1.0     Initial version
-- 06-Jul-2021  FKH    1.1     Populate Lead FirstActivityDate field
--------------------------------------------------------------------------------------
***************************************************************************************/
public class TaskTriggerHandler {
    private CS_Bypass__c userBypass;
    
    public TaskTriggerHandler(){
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }
    
    public void handleAfterUpdate(List<Task> lstNewTask){
        Set<Id> setAccId = new Set<id>(); 
        
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP21')){
            for(Integer i = 0; i < lstNewTask.size(); i++){
                if(lstNewTask[i].WhatId != null){
                    String objectType = String.valueOf(lstNewTask[i].WhatId.getSObjectType());
                    if(objectType == 'Account'){
                        setAccId.add(lstNewTask[i].WhatId);
                    }
                }
            }
        }
        
        if(setAccId.size()>0){
            AP21_UpdateAccLastActivityDate.updateLastActivityDate(setAccId);
        }
    }
    
    public void handleAfterInsert(List<Task> lstNewTask){
        Set<Id> setAccId = new Set<id>();
        Set<Id> setLeadId = new Set<id>();  
        List<Task> lstTskInserted = new List<Task>();  
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP21')){
            for(Integer i = 0; i < lstNewTask.size(); i++){
                if(lstNewTask[i].WhatId != null){
                    String objectType = String.valueOf(lstNewTask[i].WhatId.getSObjectType());
                    if(objectType == 'Account'){
                        setAccId.add(lstNewTask[i].WhatId);
                    }
                }
            }
        }
        //Populate Lead FirstActivityDate field FKH Case 3782
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP33')){
            for(Integer i = 0; i < lstNewTask.size(); i++){
                if(lstNewTask[i].WhoId != null){
                    String objectType = String.valueOf(lstNewTask[i].WhoId.getSObjectType());
                    if(objectType == 'Lead'){
                        setLeadId.add(lstNewTask[i].WhoId); //lead ID added into set
                        lstTskInserted.add(lstNewTask[i]); //get all tasks recently inserted
                    }
                }
            }
        }

        
        if(setAccId.size()>0){
            AP21_UpdateAccLastActivityDate.updateLastActivityDate(setAccId);
        }

        if(setLeadId.size()>0){
            AP33_LeadTaskActivityDate.updateFirstActivityDate(setLeadId,lstTskInserted);
        }
    }
    
    public void handleBeforeInsert(List<Task> lstNewTask){
        Map<Id, Task> mapAccIdTask = new Map<Id, Task>();
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP17')){
            for(Integer i = 0; i < lstNewTask.size(); i++){
                if(lstNewTask[i].WhatId != null){
                    String objectType = String.valueOf(lstNewTask[i].WhatId.getSObjectType());
                    if(objectType == 'Account'){
                        mapAccIdTask.put(lstNewTask[i].WhatId, lstNewTask[i]);
                    }
                }
            } 
        }
        
        if(mapAccIdTask.size()>0){
            AP17_TaskRules.updateExpectedStartDate(mapAccIdTask);
        }
    }
    
    
}