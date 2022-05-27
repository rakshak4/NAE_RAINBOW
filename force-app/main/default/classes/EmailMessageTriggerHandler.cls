/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : All email message on Opportunity is re-related to account
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 21-June-2019  AFO    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
public class EmailMessageTriggerHandler {
    private CS_Bypass__c userBypass;
    String opportunity_prefix = Schema.SObjectType.Opportunity.getKeyPrefix();
    List<EmailMessage> lstEMsgToUpdate;
    Set<Id> setOppId;

    public EmailMessageTriggerHandler(){
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }
    
    public void handleBeforeInsert(List<EmailMessage> lstEMsg){
        lstEMsgToUpdate = new List<EmailMessage>();
        Set<Id> setOppId = new Set<Id>();
        
        for(EmailMessage EMsg : lstEMsg){
            
            if(EMsg.relatedToId !=null && ((String)EMsg.relatedToId).startsWith(opportunity_prefix)){
                lstEMsgToUpdate.add(EMsg);
                setOppId.add(EMsg.relatedToId);
            } 
        }
        
        if(lstEMsgToUpdate.size() > 0){
            AP20_EmailMessageRules.updateEmailMessages(lstEMsgToUpdate, setOppId);
        }
        
    }
    
    public void handleAfterUpdate(List<EmailMessage> lstEMsg){
        Set<Id> setAccId = new Set<id>(); 
        
        for(Integer i = 0; i < lstEMsg.size(); i++){
            if(lstEMsg[i].relatedToId != null){
                String objectType = String.valueOf(lstEMsg[i].relatedToId.getSObjectType());
                if(objectType == 'Account'){
                    setAccId.add(lstEMsg[i].relatedToId);
                }
            }
        }
        
        if(setAccId.size()>0){
            AP21_UpdateAccLastActivityDate.updateLastActivityDate(setAccId);
        }
    }
    
    public void handleAfterInsert(List<EmailMessage> lstEMsg){
        Set<Id> setAccId = new Set<id>(); 
        
        for(Integer i = 0; i < lstEMsg.size(); i++){
            if(lstEMsg[i].relatedToId != null){
                String objectType = String.valueOf(lstEMsg[i].relatedToId.getSObjectType());
                if(objectType == 'Account'){
                    setAccId.add(lstEMsg[i].relatedToId);
                }
            }
        }
        
        if(setAccId.size()>0){
            AP21_UpdateAccLastActivityDate.updateLastActivityDate(setAccId);
        }
    }
}