public class ApplicationDocumentTriggerHandler {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Application Document Trigger Handler Class
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 03-JAN-2018  RRAJ   1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/
    
    private CS_Bypass__c userBypass;
    public ApplicationDocumentTriggerHandler() {
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }

    public void handleAfterInsert(List<ApplicationDocument__c> lstNewAppDoc){
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP04')){
            AP04_CreateDocumentChecklist.createAppDocDocumentChecklists(lstNewAppDoc);
        }
    }

}