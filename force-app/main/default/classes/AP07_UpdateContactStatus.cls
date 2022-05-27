/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Automate the Child Status based upon the Opportunity outcome
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 24-MAY-2018  AMU   1.0     Initial Version
-- 27-AUG-2021  VJA   1.1     Contact List To Set to avoid duplicates
--------------------------------------------------------------------------------------
**************************************************************************************/
public with sharing class AP07_UpdateContactStatus {

    /**
     * Update contact status based on opportunity stage change.
     * @param      lstOpp  List of opportunity
     */
    public static void updateContact(List<Opportunity> lstOpp) {
        Map<String, String> mapOppCont = new Map<String, String>();
        //List<Contact> lstUpdContact = new List<Contact>();
        Map<Id, Contact> mapIdToCon = new Map<Id, Contact>();

        Map<Id, Opportunity> mapOppIdToOpp = new Map<Id, Opportunity>(lstOpp);
        Map<String,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject}); 

        for(Opportunity opp: lstOpp) {
            if(String.isNotBlank(opp.Child__c)) {
                mapOppCont.put(opp.Id, opp.Child__c);
            }
        }

        for(Id oppId : mapOppCont.keySet()){
            Opportunity opp = mapOppIdToOpp.get(oppId);
            Contact contact = new Contact(Id = mapOppCont.get(opp.Id));

            //Prospect (Enquiry, Visit, Acceptance, Enrolled (RT=Enrolment), Offer Out) 
            if(opp.StageName == AP_Constant.oppStageNameAcceptance || opp.StageName == AP_Constant.oppStageNameEnquiry || 
                opp.StageName == AP_Constant.oppStageNameVisit || (opp.StageName == AP_Constant.oppStageNameEnrolled && 
                opp.RecordTypeId == mapRecordType.get(AP_Constant.oppRecordTypeEnrolment)) || 
                opp.StageName == AP_Constant.oppStageNameOfferOut) {
                contact.Status__c = AP_Constant.conStatusProspect;
            }

            //Student (Enrolled ((RT=Reenrolment), Started) 
            else if ((opp.StageName == AP_Constant.oppStageNameEnrolled && 
                    opp.RecordTypeId == mapRecordType.get(AP_Constant.oppRecordTypeReenrolment)) || 
                    opp.StageName == AP_Constant.oppStageNameStarted) {
                contact.Status__c = AP_Constant.conStatusStudent;
            }

            //Denied (Denied) 
            else if (opp.StageName == AP_Constant.oppStageNameDenied) {
                contact.Status__c = AP_Constant.conStatusDenied;
            }

            //Waitlisted (Application, Waitlisted checkbox = true) 
            else if (opp.StageName == AP_Constant.oppStageNameApplication && opp.Waitlisted__c) {
                contact.Status__c = AP_Constant.conStatusWaitlisted;
            }

            //Lost (Lost, Reason lost IS NOT Waitlisted) 
            //else if (opp.StageName == AP_Constant.oppStageNameLost && 
            //    opp.LostDeniedOnHoldReason__c != AP_Constant.oppDeniedOnHoldReasonWaitingList) {
            //    contact.Status__c = AP_Constant.conStatusLost;
            //}

            else {
                 contact.Status__c = null;
            }

            //lstUpdContact.add(contact);
            mapIdToCon.put(contact.Id, contact);
        }

        // if(lstUpdContact.size() > 0) {
        //     update lstUpdContact;
        // }

        if(mapIdToCon.size() > 0) {
            update mapIdToCon.values();
        }
    }
}