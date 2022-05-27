public class LeadTriggerHandler {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Lead Trigger Handler Class
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 06-DEC-2017  RRAJ   1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/
    
    public boolean m_isExecuting = false;
    public integer BatchSize = 0;
    public static boolean firstRun = true;
    
    private CS_Bypass__c userBypass;
    public LeadTriggerHandler(boolean isExecuting, integer size) {
        m_isExecuting = isExecuting;
        BatchSize = size;
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }
    
    public void handleBeforeInsert(List<Lead> lstNewLead){
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP02')){
            AP02_LeadRules.populateFields(lstNewLead);
        }
    }

    public void handleAfterInsert(List<Lead> lstNewLead){
        Map<String, Lead> mapExtIdToLead = new Map<String, Lead>();

        //loop through all newly created leads
        for(Integer i=0; i<lstNewLead.size(); i++){

            //build map of external id to lead of leads with having source 'Website'
            if(lstNewLead[i].LeadSource != null && lstNewLead[i].LeadSource.contains(AP_Constant.ledSrcOnline)){
                mapExtIdToLead.put(lstNewLead[i].ExternalId__c, lstNewLead[i]);
            }
        }

        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP03')){
            if(mapExtIdToLead.size()>0){
                // instantiate a new instance of the Queueable clas
                AP03_MergeDuplicateLeads mergeJob = new AP03_MergeDuplicateLeads(mapExtIdToLead);

                // enqueue the job for processing
                ID jobID = System.enqueueJob(mergeJob);
            }
        }
    }
    
    public void handleBeforeUpdate(List<Lead> lstOldLead, List<Lead> lstNewLead){
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP02')){
            AP02_LeadRules.populateFields(lstNewLead);
        }
    }

    public void handleAfterUpdate(List<Lead> lstOldLead, List<Lead> lstNewLead){
        
        //if(firstRun){
        //    firstRun = false;

        //Map<Id, Lead> mapConvertedLead = new Map<Id, Lead>();
        ////filtering for only newly converted leads
        //for(Integer i=0; i<lstNewLead.size(); i++){
        //    if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP01')){
        //        if(lstOldLead[i].IsConverted == false && lstNewLead[i].IsConverted == true){
        //            mapConvertedLead.put(lstNewLead[i].Id, lstNewLead[i]);
        //        }
        //    }
        //}
        ////pass map of converted leads to Apex class containing logic
        //if(mapConvertedLead.size()>0){
            //AP01_LeadConvert convert = new AP01_LeadConvert(mapConvertedLead);
        //}
        //}
    }
}