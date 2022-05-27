public class AP03_MergeDuplicateLeads implements Queueable {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for merging duplicate leads upon creation of lead
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 24-JAN-2018  RRAJ    1.0     Initial version
-- 09-JUN-2020  CRA     1.1     Case 2340
--------------------------------------------------------------------------------------
***************************************************************************************/
 
    private List<Lead> lstLeadToUpdt = new List<Lead>();
    private List<Lead> lstLeadToDel = new List<Lead>();
    Map<String, Lead> mapExtIdToLead = new Map<String, Lead>(); 
    public AP03_MergeDuplicateLeads(Map<String, Lead> mapExtIdToLd){
        this.mapExtIdToLead = mapExtIdToLd;
    }
    
    public void execute(QueueableContext context) {
        System.debug('##Merge');
        System.debug(mapExtIdToLead);
        //loop through existing leads and overwrite existing leads with new lead
        List<Lead> lstExistingLeads = [SELECT Id, ExternalId__c, 
                                       Send_to_ISAMS__c,
                                       Interested_in_boarding_school__c,
                                       sent_to_ISAMS__c,
                                       is_Junk__c,
                                       MarketingPermissionEmail__c,
                                       MarketingPermissionPhone__c,
                                       MarketingPermissionPost__c,
                                       MarketingPermissionSkype__c,
                                       MarketingPermissionSMS__c,
                                       Personal_Info_Collection_Statement__c,
                                       Request_Visit__c,
                                       Send_Acknowledgement__c,
                                       Permission_to_send_you_information__c,
                                       Status
                                       FROM Lead WHERE ExternalId__c IN :mapExtIdToLead.keySet() AND Id NOT IN :mapExtIdToLead.values() order by createddate DESC];
        
        //System.debug('#### lstExistingLeads: '+lstExistingLeads);
        
        for(Lead existingLed : lstExistingLeads){
            if(mapExtIdToLead.containsKey(existingLed.ExternalId__c)){
                Lead mergeLed = mapExtIdToLead.get(existingLed.ExternalId__c).clone(false, false, false, false);
                mergeLed.Id = existingLed.Id;
                System.debug('@@@@@@@1');
                System.debug(mergeLed);
                
                System.debug('@@@@@@@2');
                System.debug(existingLed);
                
                System.debug('@@@@@@@3');
                System.debug(mapExtIdToLead.get(existingLed.ExternalId__c));
                
                // list down all checkboxes and check if they are set to true in one of the existing duplicate record, set the new merged record to true
                if (existingLed.Send_to_ISAMS__c==true)                         mergeLed.Send_to_ISAMS__c = true;
                if (existingLed.Interested_in_boarding_school__c==true)         mergeLed.Interested_in_Boarding_School__c = true;
                if (existingLed.sent_to_ISAMS__c==true)                         mergeLed.sent_to_ISAMS__c = true;
                if (existingLed.is_Junk__c==true)                               mergeLed.is_Junk__c = true;
                if (existingLed.MarketingPermissionEmail__c==true)              mergeLed.MarketingPermissionEmail__c = true;
                if (existingLed.MarketingPermissionPhone__c==true)              mergeLed.MarketingPermissionPhone__c = true;
                if (existingLed.MarketingPermissionPost__c==true)               mergeLed.MarketingPermissionPost__c = true;
                if (existingLed.MarketingPermissionSkype__c==true)              mergeLed.MarketingPermissionSkype__c = true;
                if (existingLed.MarketingPermissionSMS__c==true)                mergeLed.MarketingPermissionSMS__c = true;
                if (existingLed.Personal_Info_Collection_Statement__c==true)    mergeLed.Personal_Info_Collection_Statement__c = true;
                if (existingLed.Request_Visit__c==true)                         mergeLed.Request_Visit__c = true;
                if (existingLed.Permission_to_send_you_information__c==true)    mergeLed.Permission_to_send_you_information__c = true;
                if (existingLed.Send_Acknowledgement__c){//rraj added to fire workflow 
                    mergeLed.Send_Acknowledgement__c = true;
                    mergeLed.APIModifiedDate__c = DateTime.now();
                } 

                mergeLed.Status = existingLed.Status == 'Qualified' ? mergeLed.Status : existingLed.Status;   //CRA20200609 - Preserve Status value              
                
                this.lstLeadToUpdt.add(mergeLed);
                if(!this.lstLeadToDel.contains(mapExtIdToLead.get(existingLed.ExternalId__c))) this.lstLeadToDel.add(mapExtIdToLead.get(existingLed.ExternalId__c)); //RRAJ Modified to prevent duplicate record in list
            }
        }
        
        System.debug('@@@@@@@4');
        System.debug(lstLeadToUpdt);
        System.debug('@@@@@@@5');
        System.debug(lstLeadToDel);
        
        if (lstLeadToUpdt.size()>0) update lstLeadToUpdt;
        if (lstLeadToDel.size()>0)  delete lstLeadToDel;
        
    }


}