public without sharing class LC04_DocumentChecklist {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Controller for lightning component LC04_DocumentChecklist
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 21-DEC-2017  RRAJ    1.0     Initial version
-- 10-JUN-2021  VJA     1.1     fetchDocumentCheklists modified 
--------------------------------------------------------------------------------------
***************************************************************************************/
    /**
     * Method to query Document Checklists related to opportunity
     * @param  oppId Opportunity Id
     * @return       List of Document checklist corresponding to opportunity and opportunity stage
     */
    @AuraEnabled
    public static List<DocumentChecklist__c> fetchDocumentCheklists (String oppId){ 
        Opportunity opp = [SELECT StageName, TECH_SchoolCode__c, YearGrade__r.TECH_Year_Grade_Number__c, RecordTypeId FROM Opportunity WHERE Id =: oppId limit 1];
        List<String> lstDocChecklistStage = new List<String>();
        Map<String, List<String>> mapOppStageToDocChecklistStage = new Map<String, List<String>>();

        //***1.1***MAP to store the document checklists to display wrt the opportunity stage.*****// 
        //1. Enquiry
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameEnquiry, new List<String>{AP_Constant.oppStageNameEnquiry});
        //2. Visit
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameVisit, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit});
        //3. Application
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameApplication, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit,AP_Constant.oppStageNameApplication});
        //4. Offer Out
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameOfferOut, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit,AP_Constant.oppStageNameApplication, AP_Constant.oppStageNameOfferOut, AP_Constant.oppStageNameAcceptance});
        //5. Acceptance
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameAcceptance, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit,AP_Constant.oppStageNameApplication, AP_Constant.oppStageNameOfferOut, AP_Constant.oppStageNameAcceptance});
        //6. Enrolled
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameEnrolled, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit,AP_Constant.oppStageNameApplication, AP_Constant.oppStageNameOfferOut, AP_Constant.oppStageNameAcceptance,AP_Constant.oppStageNameEnrolled});

        if(mapOppStageToDocChecklistStage.containsKey(opp.StageName)){
            lstDocChecklistStage = mapOppStageToDocChecklistStage.get(opp.StageName);
        }
        
        if(Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.RecordTypeId).getName() == AP_Constant.oppRecordTypeJulliardSummerArtsLabel
           && opp.TECH_SchoolCode__c == 'CBS'){
            return [SELECT Id, Name, Status__c, DateReceived__c, yeargrade__c, Required__c FROM DocumentChecklist__c WHERE Opportunity__c = :oppId 
                           AND (Stage__c in: lstDocChecklistStage OR Stage__c =: null) 
                           AND (yeargrade__c includes  (:opp.YearGrade__r.TECH_Year_Grade_Number__c ) OR yeargrade__c = '')
                           AND recordtype__c = :AP_Constant.oppRecordTypeJulliardSummerArtsLabel ORDER BY Name ASC];
        }else{
            return [SELECT Id, Name, Status__c, DateReceived__c, yeargrade__c, Required__c FROM DocumentChecklist__c WHERE Opportunity__c = :oppId 
                        AND (Stage__c in: lstDocChecklistStage  OR Stage__c =: null) 
                        AND (yeargrade__c includes  (:opp.YearGrade__r.TECH_Year_Grade_Number__c ) OR yeargrade__c = '' )
                        AND recordtype__c != :AP_Constant.oppRecordTypeJulliardSummerArtsLabel ORDER BY Name ASC];
        } 
    }

    /**
     * [saveDocumentCheckList description]
     * @param  strJSONDocChk [description]
     * @return               [description]
     */
    @AuraEnabled
    public static void saveDocumentCheckList (String strJSONDocChk){
        try{
            DocumentChecklist__c docChecklist = (DocumentChecklist__c)System.JSON.deserialize(strJSONDocChk, DocumentChecklist__c.class); //deserialise list of docuent from JSON input
            //update document checklist
            update docChecklist;
        }catch(exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
    }

    /**
     * controller method to save list of document checklist from JSON string
     * @param  strJSONlstDocChk Serialised list of document checklists
     * @return                  Map of update results
     */
    @AuraEnabled
    public static Map<String, String> saveDocumentCheckLists (String strJSONlstDocChk){ 
        Map<String, String> result = new Map<String, String>();
        try{
        	List<DocumentChecklist__c> lstDocChecklist = (List<DocumentChecklist__c>)System.JSON.deserialize(strJSONlstDocChk, List<DocumentChecklist__c>.class); //deserialise list of docuent from JSON input
            //update document checklists
            if(lstDocChecklist.size()>0){
                update lstDocChecklist;
                result.put('SUCCESS', Label.RecordUpdateSuccessMessage);
            }
        }catch(exception ex){
            System.debug('### Error: ' + ex.getMessage() + '\nStack Trace: ' + ex.getStackTraceString());
            result.put('ERROR', ex.getMessage() + '\nStack Trace: ' + ex.getStackTraceString());
        }
        return result;
    }
}