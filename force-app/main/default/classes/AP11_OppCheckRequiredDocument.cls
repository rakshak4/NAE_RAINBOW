public with sharing class AP11_OppCheckRequiredDocument {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Trigger to check if required document have been submitted before changing stage
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 15-JUN-2018  RRAJ   1.0     Initial Version
-- 08-AUG-2018   KZE   1.1     Added Functionality
-- 15-FEB-2019   ANA   1.2     Bypass CheckRequirement if Opp is deferred
-- 10-JUN-2021  VJA    1.3     checkReqDocChecklist modified 
--------------------------------------------------------------------------------------
**************************************************************************************/
    
    /**
     * Method to check if required document has been submitted before advancing to next stage on opportunity
     * @param mapOldOpp Map of old opportunities
     * @param lstNewOpp List of new opportunities
     */
    public static void checkReqDocChecklist(Map<Id, Opportunity> mapOldOpp, List<Opportunity> lstNewOpp){
        Set<Id> setOppToQuery = new Set<Id>();
        Map<Id, Opportunity> mapNewOpp = new Map<Id, Opportunity>(lstNewOpp);
        List<String> lstoppStagesOrdered = getStages();
        Map<Id, String> mapOppYearGradeNum= new Map<Id, String>();

        List<String> lstDocChecklistStage = new List<String>();
        Map<String, List<String>> mapOppStageToDocChecklistStage = new Map<String, List<String>>();

        //***1.3***MAP to store the document checklists to display wrt the opportunity stage.*****// 
        //1. Enquiry
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameEnquiry, new List<String>{AP_Constant.oppStageNameEnquiry});
        //2. Visit
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameVisit, new List<String>{AP_Constant.oppStageNameEnquiry});
        //3. Application
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameApplication, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit});
        //4. Offer Out
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameOfferOut, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit,AP_Constant.oppStageNameApplication});
        //5. Acceptance
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameAcceptance, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit,AP_Constant.oppStageNameApplication});
        //6. Enrolled
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameEnrolled, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit,AP_Constant.oppStageNameApplication, AP_Constant.oppStageNameOfferOut, AP_Constant.oppStageNameAcceptance});
        //7. Started
        mapOppStageToDocChecklistStage.put(AP_Constant.oppStageNameStarted, new List<String>{AP_Constant.oppStageNameEnquiry, AP_Constant.oppStageNameVisit,AP_Constant.oppStageNameApplication, AP_Constant.oppStageNameOfferOut, AP_Constant.oppStageNameAcceptance, AP_Constant.oppStageNameEnrolled});

        Map<String, String> mapOppStageToDocType = new Map<String, String>{
            AP_Constant.oppStageNameEnquiry => AP_Constant.oppStageNameEnquiry,
            AP_Constant.oppStageNameVisit => AP_Constant.docChklstStageVisit,
            AP_Constant.oppStageNameApplication => AP_Constant.docChklstStageApplication,
            AP_Constant.oppStageNameOfferOut => AP_Constant.docChklstStageAcceptance,
            AP_Constant.oppStageNameAcceptance => AP_Constant.docChklstStageAcceptance,
            AP_Constant.oppStageNameEnrolled => AP_Constant.docChklstStageEnrolled,
            AP_Constant.oppStageNameStarted => AP_Constant.oppStageNameStarted
        };

        for(Opportunity opp : mapOldOpp.values()){
            //check if new stage != 'Lost' or 'Denied' [ or 'Deferred' ANA20190215 ] 
            if(mapNewOpp.get(opp.Id).StageName != AP_Constant.oppStageNameLost && mapNewOpp.get(opp.Id).StageName != AP_Constant.oppStageNameDenied   && mapNewOpp.get(opp.Id).StageName != AP_Constant.oppStageNameDeferred){
                //check old stage
                if(isAdvance(opp.StageName, mapNewOpp.get(opp.Id).StageName, lstoppStagesOrdered)){
                    if(mapOppStageToDocType.containsKey(opp.StageName)){
                        setOppToQuery.add(opp.Id);
                    }
                }
            }
        }
        
        //Retrieve Opportunities & Document Checklists 
        for(Opportunity opp : [Select YearGrade__c, id, YearGrade__r.TECH_Year_Grade_Number__c, StageName, (SELECT Id, Name, Stage__c, Required__c, yeargrade__c, Status__c, Opportunity__c FROM DocumentChecklists__r) from opportunity where ID IN : setOppToQuery]){

            Set<String> oppStagesDocRequired = new Set<String>();
            List<DocumentChecklist__c> lstDocChecklist = opp.DocumentChecklists__r;
            String oppNewStage = mapNewOpp.get(opp.Id).StageName;

            //Get Doc Checklist Stages to check wrt to new Opp Stage
            if(mapOppStageToDocChecklistStage.containsKey(oppNewStage)){
                lstDocChecklistStage = mapOppStageToDocChecklistStage.get(oppNewStage);
            }

            if(opp.YearGrade__c != null && opp.YearGrade__r.TECH_Year_Grade_Number__c != null){
                mapOppYearGradeNum.put(opp.id,opp.YearGrade__r.TECH_Year_Grade_Number__c);
            }

            if(!lstDocChecklist.isEmpty()){
                for(DocumentChecklist__c docChk : lstDocChecklist){

                    Boolean stageDocumentFound = lstDocChecklistStage.contains(docChk.Stage__c);
                    String yearGrade = docChk.YearGrade__c;
                    String[] YG;
                    String stage = mapOldOpp.get(docChk.Opportunity__c).StageName;

                    if(yearGrade != null){YG = yearGrade.split(';');}

                    if(stageDocumentFound 
                        && docChk.Required__c 
                        && docChk.Status__c != AP_Constant.docChklstStatusSubmitted
                        && (docChk.YearGrade__c == null || YG.contains(mapOppYearGradeNum.get(docChk.Opportunity__c)) )
                    ){
                        oppStagesDocRequired.add(docChk.Stage__c);
                    }
                }
                if(oppStagesDocRequired.size() > 0){
                    //String manipulation to remove [, ], "
                    String strOppStagesDocRequired =  JSON.serialize(oppStagesDocRequired);
                    strOppStagesDocRequired = strOppStagesDocRequired.replaceAll('\\[', '');
                    strOppStagesDocRequired = strOppStagesDocRequired.replaceAll('\\]', '');
                    strOppStagesDocRequired = strOppStagesDocRequired.replaceAll('\\"', '');
                    strOppStagesDocRequired = strOppStagesDocRequired.replaceAll('\\,', '\\, ');

                    String errorMessage = 'Required documents at ' + strOppStagesDocRequired + ' stage(s) should be submitted before advancing to the ' + oppNewStage + ' stage';
                    mapNewOpp.get(opp.Id).addError(errorMessage);
                    break;
                }

            }
        }
    }

    /**
     * Method to retrieve opportunity stages in order
     * @return List of opportunity stages in order configured
     */
    private static List<String> getStages(){
        Schema.DescribeFieldResult oppStageFldRes = Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> lstPle = oppStageFldRes.getPicklistValues();
        List<String> lstStages = new List<String>();

        for(Schema.PicklistEntry pVal : lstPle){
            lstStages.add(pVal.getValue());  
        }
        return lstStages;
    }

    /**
     * Method to determine if opportunity has advanced stages
     * @param  oldStage previous value of stage
     * @param  newStage new value of stage
     * @return          Returns true if opportunity has advanced stages.
     *                  Returns false if opportunity has gone to previous stage.
     */
    private static boolean isAdvance(String oldStage, String newStage, List<String> lstoppStagesOrdered){
        Integer oldIndex = 0;
        Integer newIndex = 0;
        for(integer i=0; i<lstoppStagesOrdered.size(); i++){
            if(lstoppStagesOrdered[i] == oldStage){
                oldIndex = i;
            }
            if(lstoppStagesOrdered[i] == newStage){
                newIndex = i;
            }
        }
        return oldIndex < newIndex;
    }
}