public class OpportunityTriggerHandler {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Opportunity Trigger Handler Class
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 03-JAN-2018  RRAJ   1.0     Initial Version
-- 24-MAY-2018  AMU    1.1     Handling after trigger to update contacts
-- 13-JUL-2018  SHU    1.2     Implement W-000356/ W-000319
-- 28-SEP-2018  KZE    1.3     Handling BEFORE UPDATE trigger to update TECH_StageLastModifiedDate__c
-- 10-DEC-2018  ANA    1.4     Implement C-00001492  
-- 25-MAI-2019  CRA    1.5     Implement C-00001811   
-- 24-JUIN-2019 AFO    1.6     Update LastActivityDateAccount  
-- 10-JUL-2019  CRA    1.7     Implement W-000556
-- 18-JUL-2019  CRA    1.8     Implement Case 00001862
-- 02-MAR-2020  CRA    1.9     Implement Case 00002205: Create Document Checklist after SchoolOfInterest update
-- 09-MAR-2021	VJA    2.0     Case 00002782	
-- 15-MAR-2021  VJA    2.1     Update Class Capacity. NOTE: for stage filtering, change in AfterInsert & BeforeDelete.
-- 20-JUL-2021	VJA    2.2	   Case 3865: StageName Check
-- 23-SEP-2021  VJA    2.3     AP28
-- 24-SEP-2021  FKH	   2.2	   Case 00004164: BigFoot requirement
-- 22-OCT-2021  VJA    2.3     Case Original Opportunity
-- 07-DEC-2021  FKH    2.4     Case Original Opportunity - Case 4446 comment codes
--------------------------------------------------------------------------------------
**************************************************************************************/
    private CS_Bypass__c userBypass;

    public OpportunityTriggerHandler() {
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }
    
    public void handleBeforeInsert(List<Opportunity> lstNewOpp){
    	Map<Opportunity, String> mapOppToPreviousStage = new Map<Opportunity, String>();
        Map<Id, Opportunity> mapOppToSendToISAMS = new Map<Id, Opportunity>();
        Set<Id> setAccIdToSendToISAMS = new Set<Id>();
        List<Opportunity> lstOppNDM = new List<Opportunity>();
            
        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP09')){
        	for(Opportunity opp : lstNewOpp){
                
        		mapOppToPreviousStage.put(opp, '');
                
                if(opp.LeadOrigin__c != AP_Constant.ledOriginApplication){
                    if(opp.StageName == null || opp.StageName == ''){
                        opp.StageName = AP_Constant.oppStageEnquiry;
                    }
                }else{
                    if(opp.StageName == null || opp.StageName == ''){
    					opp.StageName = AP_Constant.oppStageNameApplication; //VJA20210721 - Case3865
					}
                    if(opp.LeadSubmissionDate__c != null) {
                        opp.EnquiryStartDate__c = opp.EnquiryStartDate__c == null ? opp.LeadSubmissionDate__c.date() : opp.EnquiryStartDate__c; //CRA20190523 - Case 00001811
                    }
                }

                //CRA 04/04/2019 Send enrolled to iSAMS 
                if(opp.StageName == AP_Constant.oppStageNameEnrolled){
                    mapOppToSendToISAMS.put(opp.Id, opp);
                    setAccIdToSendToISAMS.add(opp.AccountId);
                }

                //VJA 22/10/2021 - Case Original Opportunity
                // if(opp.TECH_IsFromAgentLead__c == true){ Case 4446 - FKH Commented
                    if(opp.OriginalOwner__c == null){
                        opp.OriginalOwner__c = opp.OwnerId;
                   // }
                }
        	}
        } 
        
        if(mapOppToPreviousStage.size()>0){
            //VJA20210309 - Case 00002782
            AP09_OpportunityRules.captureStageChanges(mapOppToPreviousStage, true);
            AP09_OpportunityRules.setLeadSubmissionDate(lstNewOpp);  //ANA20181012: Case 1492
        }

        //CRA20190718 - Case 00001862
        System.debug('### mapOppToSendToISAMS ' +mapOppToSendToISAMS);
        if (mapOppToSendToISAMS.size() > 0) {
            AP09_OpportunityRules.sendEnrolledOppToISAMS(mapOppToSendToISAMS, setAccIdToSendToISAMS);
        }

    }    

    public void handleAfterInsert(List<Opportunity> lstNewOpp){
        List<Opportunity> lstOppCreateDoc = new List<Opportunity>();
        List<Opportunity> lstOpp = new List<Opportunity>();
        Set<Id> setAccId = new Set<id>(); //1.6
        Set<Id> setAccIdRole = new Set<id>();
        Set<Id> setClassId = new Set<Id>();
        List<Opportunity> lstOpportunityToReassign= new List<Opportunity>();
        Set<ID> setSchoolIDToReassign = new Set<ID>();

        for(Integer i = 0; i < lstNewOpp.size(); i++) {
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP04')){
                if(!lstNewOpp[i].isClone()){
                    lstOppCreateDoc.add(lstNewOpp[i]);
                }
            }
            
            if(lstNewOpp[i].AccountId != null && (userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP21'))){
                setAccId.add(lstNewOpp[i].AccountId); //1.6
            }

            if (userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP28')) { //CRA20200710 - Case 2403
                lstOpp.add(lstNewOpp[i]); //VJA 23-09-2021 - 2.2
            }

            //VJA20210315 - 2.0 Update class capacity
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP31')){
                if(lstNewOpp[i].Class__c != null && (
                    lstNewOpp[i].StageName == AP_Constant.oppStageNameEnrolled ||
                    lstNewOpp[i].StageName == AP_Constant.oppStageNameStarted ||
                    lstNewOpp[i].StageName == AP_Constant.oppStageNameAcceptance
                    //lstNewOpp[i].StageName == AP_Constant.oppStageNameApplication
                )){
                    setClassId.add(lstNewOpp[i].Class__c);
                }
            }
            
           if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP25')) { // FKH Case 00004164
                lstOpportunityToReassign.add(lstNewOpp[i]);
                setSchoolIDToReassign.add(lstNewOpp[i].schoolofinterest__c);
            }
        }  

        if(lstOppCreateDoc.size() > 0) {
            AP04_CreateDocumentChecklist.createOppDocumentChecklists(lstOppCreateDoc);      
        }   
        
        if(setAccId.size() > 0){
            AP21_UpdateAccLastActivityDate.updateLastActivityDate(setAccId);
        }

        //VJA 23-09-2021 - 2.2
        if(lstOpp.size() > 0){
            AP28_OppConRoleRules.createRoles(lstOpp);
        }

        if(setClassId.size() > 0 ) {
            System.debug('###handleAfterInsert: AP31');
            AP31_ClassRules.updateClassCapacity(setClassId);
        } 
        
        if(lstOpportunityToReassign.size()>0){ // FKH Case 00004164
            AP25_AccountRules.assignRecordToCoordinator(lstOpportunityToReassign, setSchoolIDToReassign);
        }
    }

    public void handleAfterUpdate(List<Opportunity> lstNewOpp, List<Opportunity> lstOldOpp){
        List<Opportunity> lstOppUpdContact = new List<Opportunity>();
        List<Opportunity> lstcheckdate = new List<Opportunity>();
        Map<Opportunity, Opportunity> mapOldToNewOpp = new Map<Opportunity, Opportunity>();
        Set<id> setOppId       = new Set<id>();
        Set<Id> setAccId = new Set<id>(); //1.6
        Map<Id, Opportunity> mapOppUpdated = new Map<Id, Opportunity>();
        Set<Id> setSchoolId = new Set<Id>();
        Set<Id> setClassId = new Set<Id>();
        
        for(Integer i = 0; i < lstNewOpp.size(); i++) {
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP07')) {
                if(lstNewOpp[i].StageName != lstOldOpp[i].StageName || lstNewOpp[i].RecordTypeId != lstOldOpp[i].RecordTypeId
                   || lstNewOpp[i].LostDeniedOnHoldReason__c != lstOldOpp[i].LostDeniedOnHoldReason__c || lstNewOpp[i].Waitlisted__c != lstOldOpp[i].Waitlisted__c){
                       lstOppUpdContact.add(lstNewOpp[i]);
                   }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP10')) {
                if(lstNewOpp[i].Class__c != lstOldOpp[i].Class__c) {
                    mapOldToNewOpp.put(lstOldOpp[i], lstNewOpp[i]);
                }
            }
            //handler for checkdate
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP09')) {
                if(lstNewOpp[i].ActualRegistrationFeePaymentDate__c != NULL &&
                   lstNewOpp[i].ActualRegistrationFeePaymentDate__c != lstOldOpp[i].ActualRegistrationFeePaymentDate__c  && 
                   lstNewOpp[i].SchoolOfInterest__c != NULL && lstNewOpp[i].TECH_SchoolCode__c == 'NDB') {
                       lstcheckdate.add(lstNewOpp[i]);
                       setOppId.add(lstNewOpp[i].id);
                   }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP21')){
                setAccId.add(lstNewOpp[i].AccountId); //1.6
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP04')){ //CRA20200302 - Case 00002205
                if(!lstNewOpp[i].isClone() && lstNewOpp[i].SchoolOfInterest__c != lstOldOpp[i].SchoolOfInterest__c
                   && lstNewOpp[i].SchoolOfInterest__c != null){
                    mapOppUpdated.put(lstNewOpp[i].Id, lstNewOpp[i]);
                    setSchoolId.add(lstNewOpp[i].SchoolOfInterest__c);
                }
            }

            //VJA20210315 - 2.0 Update class capacity
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP31')){
                //Year grade capacity to increment if NewYG AND Stage is Enrolled OR same YG AND stage is changed to Enrolled
                if((lstNewOpp[i].Class__c != null && lstOldOpp[i].Class__c == null ) ||
                   (lstNewOpp[i].Class__c == null && lstOldOpp[i].Class__c != null) || 
                   (lstNewOpp[i].Class__c != null && lstNewOpp[i].StageName != lstOldOpp[i].StageName) ||
                   (lstNewOpp[i].Class__c != null && lstNewOpp[i].Class__c != lstOldOpp[i].Class__c) ||
                   (lstNewOpp[i].Class__c != null && lstNewOpp[i].CloseDate != lstOldOpp[i].CloseDate)
                ){
                    if(lstNewOpp[i].Class__c != null){
                        setClassId.add(lstNewOpp[i].Class__c);
                    }
                    if(lstOldOpp[i].Class__c != null){
                        setClassId.add(lstOldOpp[i].Class__c);
                    }
                }
            }

        }
        
        if(setAccId.size() > 0){
            AP21_UpdateAccLastActivityDate.updateLastActivityDate(setAccId);
        }
        
        if(lstOppUpdContact.size() > 0) {
            AP07_UpdateContactStatus.updateContact(lstOppUpdContact);
        }
        
        if(mapOldToNewOpp.size() > 0) {
            AP10_UpdateClass.updateClass(mapOldToNewOpp);
        }
        //checksize
        if(lstcheckdate.size() > 0) {
            System.debug('##AcceptancePaymentDate');
            //case 1712
            //AP09_OpportunityRules.sendEnrolmentPack(lstcheckdate, setOppId);
        }

        if(mapOppUpdated.size() > 0 && setSchoolId.size() > 0) {
            AP04_CreateDocumentChecklist.createOppDocumentChecklistsAfterUpdate(mapOppUpdated, setSchoolId);      
        } 
        
        if(setClassId.size() > 0 ) {
            System.debug('###handleAfterUpdate: AP31');
            AP31_ClassRules.updateClassCapacity(setClassId);
        }  

    }

    public void handleBeforeUpdate(List<Opportunity> lstNewOpp, List<Opportunity> lstOldOpp){
        Map<Opportunity, String> mapOppToPreviousStage = new Map<Opportunity, String>();
        Map<Id, Opportunity> mapOppStageChanged = new Map<Id, Opportunity>();
        List<Opportunity> lstOppStageChanged = new List<Opportunity>();
        List<Opportunity> lstOppToUpdate = new List<Opportunity>();
        List<Opportunity> lstOppUpdStageLastModified = new List<Opportunity>();
        Map<Id, Opportunity> mapOppToSendToISAMS = new Map<Id, Opportunity>();
        Set<Id> SetAccIdToSendToISAMS = new Set<Id>();

        Set<id> setOwnerId = new Set<id>();

        for(Integer i=0; i<lstNewOpp.size(); i++){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP09')) {
            	if(lstNewOpp[i].StageName != lstOldOpp[i].StageName){
	                mapOppToPreviousStage.put(lstNewOpp[i], lstOldOpp[i].StageName);
                    if (lstNewOpp[i].StageName == AP_Constant.oppStageNameEnrolled) { //CRA20190718 - Case 00001862
                        mapOppToSendToISAMS.put(lstNewOpp[i].Id, lstNewOpp[i]);
                        setAccIdToSendToISAMS.add(lstNewOpp[i].AccountId);
                    }
            	}

                if(lstNewOpp[i].ownerid != lstOldOpp[i].ownerid){ //00001264
                    lstOppToUpdate.add(lstNewOpp[i]);
                    setOwnerId.add(lstNewOpp[i].ownerid);
                }

                //afo set closedate time
                if(lstOldOpp[i].isClosed == false && lstOldOpp[i].isClosed == true ){
                   lstOldOpp[i].Tech_CloseDate__c  = System.today();
                }
            }

            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP11')) {
                if(lstNewOpp[i].StageName != lstOldOpp[i].StageName){
                    mapOppStageChanged.put(lstOldOpp[i].Id, lstOldOpp[i]);
                    lstOppStageChanged.add(lstNewOpp[i]);
                }
            }

            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP07')) {
                if(lstNewOpp[i].StageName != lstOldOpp[i].StageName){
                    lstOppUpdStageLastModified.add(lstNewOpp[i]);
                }
            }

            // //VJA 22/10/2021 - Case Original Opportunity
            // if(lstNewOpp[i].TECH_IsFromAgentLead__c == true && (lstNewOpp[i].TECH_IsFromAgentLead__c != lstOldOpp[i].TECH_IsFromAgentLead__c)){
            //     if(lstNewOpp[i].OriginalOwner__c == null) {
            //         lstNewOpp[i].OriginalOwner__c = lstNewOpp[i].OwnerId;
            //     }
            // } Case 4446 - FKH Commented
            
        }

        if(mapOppToPreviousStage.size()>0){
            //VJA20210309 - Case 00002782
            AP09_OpportunityRules.captureStageChanges(mapOppToPreviousStage, false);
        }

        if(mapOppStageChanged.size()>0){
            AP11_OppCheckRequiredDocument.checkReqDocChecklist(mapOppStageChanged, lstOppStageChanged);
        }
        
        //00001264
        if(lstOppToUpdate.size() > 0){
            AP09_OpportunityRules.updateSchool(lstOppToUpdate, setOwnerId);
        }
        if(lstOppUpdStageLastModified.size() > 0) {
            AP09_OpportunityRules.updateStageLastModifiedDate(lstOppUpdStageLastModified);
        }

        //CRA20190718 - Case 00001862
        System.debug('### mapOppToSendToISAMS ' +mapOppToSendToISAMS);
        if (mapOppToSendToISAMS.size() > 0) {
            AP09_OpportunityRules.sendEnrolledOppToISAMS(mapOppToSendToISAMS, setAccIdToSendToISAMS);
        }
    }

    public void handleBeforeDelete(List<Opportunity> lstOldOpp){
        System.debug('### Opportunity Trigger Handler : handleBeforeDelete');
        Set<Id> setClassId = new Set<Id>();
        
        for(Integer i = 0; i < lstOldOpp.size(); i++) {
            //VJA20210315 - 2.0 Update class capacity
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP31')){
                if(lstOldOpp[i].Class__c != null && (
                    lstOldOpp[i].StageName == AP_Constant.oppStageNameEnrolled ||
                    lstOldOpp[i].StageName == AP_Constant.oppStageNameStarted ||
                    lstOldOpp[i].StageName == AP_Constant.oppStageNameAcceptance
                    //lstOldOpp[i].StageName == AP_Constant.oppStageNameApplication
                )){
                    setClassId.add(lstOldOpp[i].Class__c);
                }
            }
        }

        if(setClassId.size() > 0 ) {
            System.debug('###handleBeforeDelete: AP31');
            AP31_ClassRules.updateClassCapacity(setClassId);
        } 
    }

}