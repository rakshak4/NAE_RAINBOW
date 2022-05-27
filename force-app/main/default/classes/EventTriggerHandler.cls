/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : 
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 19-OCT-2018  AFO    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
public class EventTriggerHandler {
    private CS_Bypass__c userBypass;
    
    public EventTriggerHandler(){
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }
    
    public void handleAfterUpdate(List<Event> lstOldEvent, List<Event> lstNewEvent){
        List<Event> lstEvent = new List<Event>();
        Set<id> setAccId = new Set<id>();
        Set<id> setAccId2 = new Set<id>();
        
        for(Integer i = 0; i < lstNewEvent.size(); i++){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP17')){
                if(lstNewEvent[i].Status__c == AP_Constant.tskStatusCompleted && lstOldEvent[i].Status__c != AP_Constant.tskStatusCompleted){
                    String whatid = lstNewEvent[i].whatId;
                    if(whatid != null && whatid.startsWith('001')) {
                        lstEvent.add(lstNewEvent[i]);
                        setAccId.add(lstNewEvent[i].whatid);
                    }
                }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP21')){
                if(lstNewEvent[i].WhatId != null){
                    String objectType = String.valueOf(lstNewEvent[i].WhatId.getSObjectType());
                    if(objectType == 'Account'){
                        setAccId2.add(lstNewEvent[i].WhatId);
                    }
                }
            }
            
        }
        
        if(setAccId2.size()>0){
            AP21_UpdateAccLastActivityDate.updateLastActivityDate(setAccId2);
        }
        
        if(setAccId.size()>0){
            AP17_EventRules.updateLastVisitDate(lstEvent, setAccId);
        }
        
        
    }
    
    public void handleAfterInsert(List<Event> lstNewEvent){
        List<Event> lstEvent = new List<Event>();
        Set<id> setAccId = new Set<id>();
        Set<id> setAccId2 = new Set<id>();
        
        for(Integer i = 0; i < lstNewEvent.size(); i++){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP17')){
                if(lstNewEvent[i].Status__c == AP_Constant.tskStatusCompleted){
                    String whatid = lstNewEvent[i].whatId;
                    if(whatid != null && whatid.startsWith('001')) {
                        lstEvent.add(lstNewEvent[i]);
                        setAccId.add(lstNewEvent[i].whatid);
                        System.debug('##2');
                    }
                }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP21')){
                if(lstNewEvent[i].WhatId != null){
                    String objectType = String.valueOf(lstNewEvent[i].WhatId.getSObjectType());
                    if(objectType == 'Account'){
                        setAccId2.add(lstNewEvent[i].WhatId);
                    }
                }
            }
        }
        
        if(setAccId2.size()>0){
            AP21_UpdateAccLastActivityDate.updateLastActivityDate(setAccId2);
        }
        
        if(setAccId.size()>0){
            AP17_EventRules.updateLastVisitDate(lstEvent, setAccId);
        }
    }
    
}