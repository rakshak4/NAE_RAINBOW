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
-- 14-JAN-2019  CRA    1.1     w-344 - Send Aknowledgement Email to Parent
-- 27-MAI-2020  CRA    1.2     Case 00002414
-- 03-NOV-2020	FKH	   1.3     Added updatePickListOrigin in  beforeUpdate
-- 18-01-2021   VJA    1.6     ###NDM_1 Bypass with lead record types
-- 16-FEB-2021  VJA    1.4     Case 00002813 - Enable automatic marketing fields check if child last name is filled
-- 30-AUG-2021  FKH    1.5     Prevent merging of Baidu Leads
--------------------------------------------------------------------------------------
**************************************************************************************/
    
    //public boolean isExecuting = false;
    //public integer BatchSize = 0;
    
    private CS_Bypass__c userBypass;
    private static Map<String,Id> mapRecordType;     //VJA20210118 1.6 ###NDM_1

    public LeadTriggerHandler(boolean isExecuting, integer size) {
        //this.isExecuting = isExecuting;
        //BatchSize = size;
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject});
    }
    
    public void handleBeforeInsert(List<Lead> lstNewLead){
        System.debug('#### lstNewLead:'+JSON.serialize(lstNewLead));
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP02')){
            AP02_LeadRules.populateFields(lstNewLead);
            AP02_LeadRules.setChildrenMarketingFields(lstNewLead, lstNewLead, true); //VJA20210216 - Case 00002813 One function for before insert & before update
        }
    }

    public void handleAfterInsert(List<Lead> lstNewLead){
        Map<String, Lead> mapExtIdToLead = new Map<String, Lead>();
        List<Lead> lstLeadMailchimp = new List<Lead>();
        List<Lead> lstAutoConvLed = new List<Lead>();
       
        for(Integer i=0; i<lstNewLead.size(); i++){
            if((userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP03') ) && 
                ( //VJA20210118 1.6 ###NDM_1
                    lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) ||
                    lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeEnrolment)
                )
            ){ //build map of external id to lead of leads with having source 'Online' - FKH Prevent merging for Baidu Leads 
                if(((lstNewLead[i].LeadSource == AP_Constant.ledSrcOnline && lstNewLead[i].Lead_Origin__c != AP_Constant.ledBaiduPPC)|| lstNewLead[i].LeadSource == AP_Constant.ledSrcWebform)){
                    if(lstNewLead[i].WeChatUserId__c == null){
                        mapExtIdToLead.put(lstNewLead[i].ExternalId__c, lstNewLead[i]);
                    }
                }
            }

            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP05')){
                if(lstNewLead[i].SchoolOfInterest__c != null) {
                    lstLeadMailchimp.add(lstNewLead[i]);
                }
            }

            if((userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP12')) && 
                ( //VJA20210118 1.6 ###NDM_1
                    lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) ||
                    lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeEnrolment)
                )
            ){
                if(lstNewLead[i].AutoConvert__c && (lstNewLead[i].LeadSource != AP_Constant.ledSrcOnline || lstNewLead[i].LeadSource != AP_Constant.ledSrcWebform)) {
                    lstAutoConvLed.add(lstNewLead[i]);
                }
            }
        }

        if(lstLeadMailchimp.size() > 0) {
            AP05_SendLeadToMailChimp.sendToMailChimp(lstLeadMailchimp);
        }

        if(mapExtIdToLead.size()>0){
            system.debug('mapExtIdToLead ' +mapExtIdToLead);

            // instantiate a new instance of the Queueable clas
            AP03_MergeDuplicateLeads mergeJob = new AP03_MergeDuplicateLeads(mapExtIdToLead);
            //enqueue the job for processing
            ID jobID = System.enqueueJob(mergeJob);
        }

        if(lstAutoConvLed.size()>0){
            AP12_AutoConvertLead.convertLeads(lstAutoConvLed);
        }
    }

    public void handleBeforeUpdate(List<Lead> lstOldLead, List<Lead> lstNewLead){
        List<Lead> lstUpdatedLead = new List<Lead>();
        List<Lead> lstLeadToUpdate = new List<Lead>();
        List<Lead> lstLeadToOriginUpdateNew = new List<Lead>();
        List<Lead> lstLeadToOriginUpdateOld = new List<Lead>();
        Set<id> setOwnerId = new Set<id>();
        List<Lead> lstOldLeadMarketing = new List<Lead>();
        List<Lead> lstNewLeadMarketing = new List<Lead>();

		
        for(Integer i = 0; i < lstNewLead.size(); i++){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP02')){
                if( (lstNewLead[i].Parent1Title__c != lstOldLead[i].Parent1Title__c || 
                    lstNewLead[i].Parent1LastName__c != lstOldLead[i].Parent1LastName__c ||
                    lstNewLead[i].Parent1FirstName__c != lstOldLead[i].Parent1FirstName__c || 
                    lstNewLead[i].Parent1PrimaryEmail__c != lstOldLead[i].Parent1PrimaryEmail__c ||
                    lstNewLead[i].Parent1Nationality__c != lstOldLead[i].Parent1Nationality__c || 
                    lstNewLead[i].Parent1CountryOfResidence__c != lstOldLead[i].Parent1CountryOfResidence__c ||
                    lstNewLead[i].Parent1HomePhone__c != lstOldLead[i].Parent1HomePhone__c) && 
                    ( //VJA20210118 1.6 ###NDM_1
                        lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) ||
                        lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeEnrolment)
                    )
                ) {
                    lstUpdatedLead.add(lstNewLead[i]);
                }
                System.debug('lstNewLead[i].ownerid '+ lstNewLead[i].ownerid);
                System.debug('lstOldLead[i].ownerid '+ lstOldLead[i].ownerid);

                if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP02')){ //00001264
                    if(lstNewLead[i].ownerid != lstOldLead[i].ownerid){
                        lstLeadToUpdate.add(lstNewLead[i]);
                        setOwnerId.add(lstNewLead[i].ownerid);
                        System.debug('IN HERE ');

                    }
                }

                if (lstNewLead[i].Lead_Origin__c != lstOldLead[i].Lead_Origin__c){
                    lstLeadToOriginUpdateNew.add(lstNewLead[i]);
                    lstLeadToOriginUpdateOld.add(lstOldLead[i]);
                }

                //VJA20210216 - Case 00002813
                if(
                    (lstNewLead[i].LastNameFirstChild__c != lstOldLead[i].LastNameFirstChild__c) ||
                    (lstNewLead[i].LastNameSecondChild__c != lstOldLead[i].LastNameSecondChild__c) ||
                    (lstNewLead[i].LastNameThirdChild__c != lstOldLead[i].LastNameThirdChild__c) ||
                    (lstNewLead[i].LastNameFourthChild__c != lstOldLead[i].LastNameFourthChild__c) ||
                    (lstNewLead[i].LastNameFifthChild__c != lstOldLead[i].LastNameFifthChild__c)
                ){
                    lstOldLeadMarketing.add(lstOldLead[i]);
                    lstNewLeadMarketing.add(lstNewLead[i]);
                }
            }
        }

        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP02')){
            AP02_LeadRules.populateFields(lstNewLead);
        }

        if(lstUpdatedLead.size() > 0) {
            AP02_LeadRules.updateFields(lstUpdatedLead);
        }
        
        if(lstLeadToUpdate.size() > 0){ //00001264
            AP02_LeadRules.updateSchool(lstLeadToUpdate, setOwnerId);
        }

        if(lstLeadToOriginUpdateNew.size() > 0 &&  lstLeadToOriginUpdateOld.size()>0 ){ 
            AP02_LeadRules.updatePickListOrigin(lstLeadToOriginUpdateOld,lstLeadToOriginUpdateNew);
        }   

        if(lstNewLeadMarketing.size() > 0){  //VJA20210216 - Case 00002813
            AP02_LeadRules.setChildrenMarketingFields(lstOldLeadMarketing, lstNewLeadMarketing, false);
        }
    }
    public void handleAfterUpdate(List<Lead> lstOldLead, List<Lead> lstNewLead){
        System.debug('#### handleAfterUpdate');
        Map<Id, Lead> mapConvertedLead = new Map<Id, Lead>();
        Map<Id, Id> mapContactIdToLeadId = new Map<Id, Id>();
        Map<Id, Lead> mapLeadAcc = new Map<Id, Lead>();
        List<Lead> lstAutoConvLed = new List<Lead>();
        
        for(Integer i = 0; i < lstNewLead.size(); i++){ //filtering for only newly converted leads
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP01')){
                if(lstOldLead[i].IsConverted == false && lstNewLead[i].IsConverted == true && lstNewLead[i].TECH_IsNDM__c == false &&
                    ( //VJA20210118 1.6 ###NDM_1
                        lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) ||
                        lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeEnrolment)
                    )
                ){
                    System.debug('###mapConvertedLead: ' + mapConvertedLead.size());
                    mapConvertedLead.put(lstNewLead[i].Id, lstNewLead[i]);
                }
                                 
                if(lstOldLead[i].OwnerId != lstNewLead[i].OwnerId 
                    && lstNewLead[i].OwnerId != null 
                    && lstNewLead[i].ConvertedAccountId != null 
                    && (lstNewLead[i].Lead_Origin__c == AP_Constant.ledOriginApplication)
                    && lstNewLead[i].IsConverted == true) { //CRA20190222 - w-344 -set owner id lead to account, contact, opportunity       
                        System.debug('###setting ownership');
                        System.debug('###owner'+lstNewLead[i].OwnerId);
                        mapLeadAcc.put(lstNewLead[i].ConvertedAccountId, lstNewLead[i]);
                } //End CRA
            }
            
            if((userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP12')) &&
                    ( //VJA20210118 1.6 ###NDM_1
                        lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) ||
                        lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeEnrolment)
                    )
            ){ //CRA20200109 - Case 2179
                if(lstNewLead[i].AutoConvert__c 
                   && lstNewLead[i].Lead_Origin__c != AP_Constant.ledOriginApplication //CRA20200527 - Case 2414
                   && lstNewLead[i].Lead_Origin__c != AP_Constant.ledOriginAdmissionsStage1
                   && lstNewLead[i].Lead_Origin__c != AP_Constant.ledOriginAdmissionsStage2 
                   && lstNewLead[i].Lead_Origin__c != AP_Constant.ledOriginWeChat 
                   && !lstNewLead[i].isConverted) {
                    System.debug('### autoconvert');
                    lstAutoConvLed.add(lstNewLead[i]);
                }
            }

            //VJA20210118 1.6 ###NDM_1
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP29')){
                if(lstOldLead[i].IsConverted == false && lstNewLead[i].IsConverted == true && lstNewLead[i].RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeIndividualChildEnrolmentLead) && lstNewLead[i].ConvertedContactId != null){
                    System.debug('## ledRecordTypeIndividualChildEnrolmentLead');
                    mapContactIdToLeadId.put(lstNewLead[i].ConvertedContactId, lstNewLead[i].Id);
                }
            }
        }
        
        if(mapConvertedLead.size() > 0 && AP_Constant.allowCreateFamily == 0){ //pass map of converted leads to Apex class containing logic
            try{//ANA20181218: Case 1533 - Graceful error handling
                AP01_LeadConvert.createFamily(mapConvertedLead);
            }catch(exception e){
                for(Lead led : mapConvertedLead.values()){
                    led.addError(e.getDmlMessage(0));
                }
            }
            
            AP_Constant.allowCreateFamily = AP_Constant.allowCreateFamily  + 1; //ANA20181218: Case 1410 (To prevent callout to execut conversion twice)
        }

        if(mapContactIdToLeadId.size() > 0){
            System.debug('### mapContactIdToLeadId.size(): ' + mapContactIdToLeadId.size());
            AP29_LeadConvertTransposeRules.updateConvertedLeadContacts(mapContactIdToLeadId);
        }

        if(mapLeadAcc.size() > 0) { //CRA20190222 - w344 - Lead ownership, Send Acknowledgment Email to parent
            try {
                System.debug('###mapLeadAcc'+mapLeadAcc);
                AP01_LeadConvert.updateOwnership(mapLeadAcc);
            }
            catch(exception e){}
        } //End CRA
        
        if(lstAutoConvLed.size()>0){
            AP12_AutoConvertLead.convertLeads(lstAutoConvLed);
        }
    }
}