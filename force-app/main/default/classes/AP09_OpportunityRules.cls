public with sharing class AP09_OpportunityRules {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex class for opportunity trigger to implement rules 
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 13-JUL-2018  SHU    1.0     Initial version
-- 16-JUL-2018  AMU    1.1     Initial version
-- 27-SEP-2018  KZE    1.2     Initial version
-- 10-DEC-2018  ANA    1.3     Added method setLeadSubmissionDate() to resolve Case 00001490
-- 10-JUL-2019  CRA    1.4     W-000556
-- 03-JUN-2020  CRA    1.5     Case 00002428
-- 18-JUN-2020  CRA    1.6     Case 00002449
-- 11-OCT-2020	FKO    1.7     Case 00002654
-- 09-MAR-2021	VJA    1.8     Case 00002782
-- 21-MAY-2021  VJA    1.9     Case 00002654
--------------------------------------------------------------------------------------
***************************************************************************************/
 
    /**
     * Update opportunity start date when stage changes
     * @param      mapNewOppToOldStage  Map new opp to old stage
     */
    public static void captureStageChanges( Map<Opportunity, String> mapNewOppToOldStage, Boolean isInsert ){
        for(Opportunity opp : mapNewOppToOldStage.keySet()){
            //VJA20210309 - Case 00002782
            if(opp.TECH_IsClone__c && isInsert){
                continue;
            }

            //W-000319
            if(opp.StageName == AP_Constant.oppStageNameLost || opp.StageName == AP_Constant.oppStageNameDenied){
                opp.PreviousStageBeforeLostDenied__c = mapNewOppToOldStage.get(opp);
            }
            //W-000356
            if(opp.StageName == AP_Constant.oppStageNameActive && opp.ActiveStartDate__c == null){
                opp.ActiveStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameAcceptance && opp.AcceptanceStartDate__c == null){
                opp.AcceptanceStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameApplication && opp.ApplicationStartDate__c == null){
                opp.ApplicationStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameDenied && opp.DeniedStartDate__c == null){
                opp.DeniedStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameReenrolment && opp.EligibleForReenrolmentStartDate__c == null){
                opp.EligibleForReenrolmentStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameEnquiry && opp.EnquiryStartDate__c == null){
                opp.EnquiryStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameEnrolled && opp.EnrolledStartDate__c == null){
                opp.EnrolledStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameInactive && opp.InactiveStartDate__c == null){
                opp.InactiveStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameLost && opp.LostStartDate__c == null){
                opp.LostStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameOfferOut && opp.OfferOutStartDate__c == null){
                opp.OfferOutStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameOnHold && opp.OnHoldStartDate__c == null){
                opp.OnHoldStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameStarted && opp.StartedStartDate__c == null){
                opp.StartedStartDate__c = system.today();
            }

            if(opp.StageName == AP_Constant.oppStageNameVisit && opp.VisitStartDate__c == null){
                opp.VisitStartDate__c = system.today();
            }
        }
    }
    
    public static void updateStageLastModifiedDate(List<Opportunity> lstOppToUpdate){
        for(Opportunity opp : lstOppToUpdate){
            opp.TECH_StageLastModifiedDate__c = System.now();           
        } 
    }
    
    public static void updateSchool(List<Opportunity> lstOppToUpdate, Set<id> setOwnerId){
        map<id, string> mapUid_SchCode = new map<id, string>();
        set<string> setSchCode = new set<string>();
        map<string, id> mapSchId_SchCOde = new map<string, id>();
        
        for(User u : [Select id, SchoolCode__c from user where id in:setOwnerId ]){
            if(u.SchoolCode__c != null){
                mapUid_SchCode.put(u.id, u.SchoolCode__c);
                setSchCode.add(u.SchoolCode__c);
            }
        }
        //System.debug('##setSchCode' + setSchCode);
        //System.debug('##mapUid_SchCode' + mapUid_SchCode);
        
        for(School__c sch : [ Select id, SchoolCode__c from school__c where SchoolCode__c in: setSchCode]){
            if(sch.SchoolCode__c != null){
                mapSchId_SchCOde.put(sch.SchoolCode__c, sch.id);
            }
        }
        //System.debug('##mapSchId_SchCOde' + mapSchId_SchCOde);
        
        for(Opportunity opp : lstOppToUpdate){
            if(mapUid_SchCode.containskey(opp.ownerid) && mapSchId_SchCOde.containskey(mapUid_SchCode.get(opp.ownerid))){
                opp.SchoolOfInterest__c = mapSchId_SchCOde.get(mapUid_SchCode.get(opp.ownerid));
                //System.debug('##set' + mapSchId_SchCOde.get(mapUid_SchCode.get(opp.ownerid)));
            }
        }      
    }
    
    public static void setLeadSubmissionDate(List<Opportunity> lstOppToUpdate){
        for (Opportunity opp : lstOppToUpdate){
            opp.LeadSubmissionDate__c  = opp.LeadSubmissionDate__c ==  null ? opp.EnquiryStartDate__c : opp.LeadSubmissionDate__c;
            opp.StageName = opp.StageName ==  null ? AP_Constant.oppStageEnquiry : opp.StageName;
        }
    }
    
    //fda
    // public static void sendEnrolmentPack(List<Opportunity> lstcheckdate,Set<id> setOppId){
    //     List<task> lstTasks = new List<task>();
    //     map<id, string> mapOppID = new map<id, string>();
    //     for(Opportunity opp : [Select id, Account.name, closedate from opportunity where id in:setOppId ]){
    //         mapOppID.put(opp.id, opp.Account.name);
    //     }
        
    //     //system.debug('## mapOppID' + mapOppID);
    //     for (Opportunity opp : lstcheckdate){
    //         Date activitydate = opp.closedate.addMonths(-2);
    //         task tsk = new task();
    //         tsk.WhatId = Opp.AccountId;
    //         tsk.Subject = mapOppID.get(Opp.id )+' - Reminder for sending the Enrolment Pack';
    //         tsk.priority= 'normal';
    //         tsk.ownerId = opp.ownerId; 
    //         tsk.ActivityDate = activitydate;
    //         tsk.isAutomated__c = true;
    //         tsk.IsReminderSet = true;
    //         tsk.ReminderDateTime = activitydate;
    //         tsk.Status = 'Open';
    //         lstTasks.add(tsk);
    //     }
        
    //     if(lstTasks.size() > 0) {
    //         insert lstTasks;
    //     }
    // }

   /**
    * @description Check if Opportunity has FinancialContact and send to iSAMS - Case 00001862
    * @author CRA | 18/07/2019
    * @param Map<Id, Opportunity> mapOpp
    * @return void
    */
    public static void sendEnrolledOppToISAMS(Map<Id, Opportunity> mapOpp, Set<Id> setAccId) {
        Set<Id> setAccNotValid = new Set<Id>(); //CRA20200603 - Case 2428 - Check required fields
        String OppSchoolCode;
        for (AccountContactRelation accConRel : [SELECT Contact.Gender__c, Contact.RecordType.Name, Roles, AccountId FROM AccountContactRelation WHERE AccountId IN :setAccId]) {
            if ((String.isBlank(accConRel.Contact.Gender__c) 
                && accConRel.Contact.Gender__c != AP_Constant.conGenderMale && accConRel.Contact.Gender__c != AP_Constant.conGenderFemale
                && accConRel.Contact.RecordType.Name == AP_Constant.conRecordTypeDeveloperNameChild)
                || (String.isBlank(accConRel.Roles) && accConRel.Contact.RecordType.Name == AP_Constant.conRecordTypeDeveloperNameParent)) {
                    setAccNotValid.add(accConRel.AccountId);
            }
        }
        //System.debug('### setAccNotValid '+ setAccNotValid);
        for (Opportunity opp : [SELECT Id, Name, AccountId, SchoolOfInterest__c, Account.SchoolOfInterest__c, Account.FinancialContact__c, SchoolOfInterest__r.SchoolCode__c,MidTierOpportunityID__c, RecordType.Name FROM Opportunity 
                                WHERE Id IN :mapOpp.keySet() AND SchoolOfInterest__r.AvailableForIsamsPush__c = true
                                AND (RecordType.Name = :AP_Constant.oppRecordTypeDeveloperNameEnrolment 
                                OR (RecordType.Name = :AP_Constant.oppRecordTypeDeveloperNameJulliardSummerArts AND SchoolOfInterest__r.SchoolCode__c = 'CBS')) ]) {
            if (setAccNotValid.contains(opp.AccountId) || String.isBlank(opp.Account.FinancialContact__c)) { //CRA20200618 - Case 2449
                String strError = Label.AP09_RequiredFieldsMissing;
                if (String.isBlank(opp.Account.FinancialContact__c)) {
                    strError = Label.AP09_FinancialContactMissing;
                }
                mapOpp.get(opp.Id).addError(new AP_Constant.customException(strError));
            }
			//11-OCT-2020 FKO 1.7 Case 00002654 
            if(opp.Account.SchoolOfInterest__c==null)
                mapOpp.get(opp.Id).addError('There is no School of Interest related to the Account.');
            else if (opp.Account.SchoolOfInterest__c!=opp.SchoolOfInterest__c)
                mapOpp.get(opp.Id).addError('The School of Interest on the Opportunity '+ opp.name+' does not match the School of Interest on the Account. Please update the Opportunity to match the Account.');
            else if (opp.Account.SchoolOfInterest__c==opp.SchoolOfInterest__c && opp.MidTierOpportunityID__c!=null){
                OppSchoolCode = opp.MidTierOpportunityID__c;
                if ((OppSchoolCode.indexOf(opp.SchoolOfInterest__r.SchoolCode__c))!=0)
                    mapOpp.get(opp.Id).addError('The Opportunity '+ opp.name+' has already been allocated an ID from a different iSAMS, please raise a case within Salesforce and this will be amended.');                    
            }
            else {
                mapOpp.get(opp.Id).TECH_IsSentToMidtier__c = false;
                mapOpp.get(opp.Id).TECH_ManualPush__c = true;
                mapOpp.get(opp.Id).TECH_IsamsPushDateTime__c = System.now();
            }
        }
    }
}