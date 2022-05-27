public with sharing class AP04_CreateDocumentChecklist {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex class for creation on document checklist on insertion of application document
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 03-JAN-2018  RRAJ    1.0     Initial version
-- 03-MAR-2020  CRA     1.1     Implement Case 00002205
--------------------------------------------------------------------------------------
***************************************************************************************/
    
    /**
     * Method to create document checklists for opportunities depending on the school of interest of each opportunity
     * @param lstOpp    List of opportunities for which to create document checklists
     * @param lstAppDoc list of application documents used by school
     */
    public static void createDocChklst(List<Opportunity> lstOpp, List<ApplicationDocument__c> lstAppDoc){
        List<DocumentChecklist__c> lstDocChklstToInsert = new List<DocumentChecklist__c>();
        //build map of school => list of app doc
        Map<Id, List<ApplicationDocument__c>> mapSchoolIdToAppDoc = new Map<Id, List<ApplicationDocument__c>>();
        for(ApplicationDocument__c appDoc : lstAppDoc){
            if(mapSchoolIdToAppDoc.containsKey(appDoc.School__c)){
                mapSchoolIdToAppDoc.get(appDoc.School__c).add(appDoc);
            }else{
                mapSchoolIdToAppDoc.put(appDoc.School__c, new List<ApplicationDocument__c>{appDoc});
            }
        }
        //create document checklist for each opportunity related to shcool
        for(Opportunity opp : lstOpp){
            //if opp = juliart then use 2nd map
            if(mapSchoolIdToAppDoc.containsKey(opp.SchoolOfInterest__c)){
                for(ApplicationDocument__c appDoc : mapSchoolIdToAppDoc.get(opp.SchoolOfInterest__c)){
                    //afo if beau soleil and summer camps
                    if(Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.RecordTypeId).getName() == AP_Constant.oppRecordTypeJulliardSummerArtsLabel
                       && opp.TECH_SchoolCode__c == 'CBS'){
                           if(appDoc.RecordType__c == AP_Constant.oppRecordTypeJulliardSummerArtsLabel){
                               DocumentChecklist__c docChklst = new DocumentChecklist__c(
                                   Opportunity__c = opp.Id,
                                   ApplicationDocument__c = appDoc.Id,
                                   Name = appDoc.Name,
                                   Status__c = AP_Constant.docChklstStatusRequested,
                                   //edit CRA - 1407 
                                   Required__c = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.RecordTypeId).getName() == AP_Constant.oppRecordTypeJulliardSummerArtsLabel 
                                   && appDoc.Name != Label.AppDocNameApplicationForm ? false : appDoc.Required__c, 
                                   Stage__c = appDoc.Stage__c,
                                   recordtype__c = appDoc.RecordType__c,
                                   yeargrade__c = appDoc.YearGrade__c
                               );
                               lstDocChklstToInsert.add(docChklst);
                           }
                       }
                    else if(appDoc.RecordType__c != AP_Constant.oppRecordTypeJulliardSummerArtsLabel || 
                            (Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.RecordTypeId).getName() == AP_Constant.oppRecordTypeJulliardSummerArtsLabel
                             && opp.TECH_SchoolCode__c != 'CBS')){
                                 
                                 DocumentChecklist__c docChklst = new DocumentChecklist__c(
                                     Opportunity__c = opp.Id,
                                     ApplicationDocument__c = appDoc.Id,
                                     Name = appDoc.Name,
                                     Status__c = AP_Constant.docChklstStatusRequested,
                                     //edit CRA - 1407 
                                     Required__c = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.RecordTypeId).getName() == AP_Constant.oppRecordTypeJulliardSummerArtsLabel 
                                     && appDoc.Name != Label.AppDocNameApplicationForm ? false : appDoc.Required__c, 
                                     Stage__c = appDoc.Stage__c,
                                     recordtype__c = appDoc.RecordType__c,
                                     yeargrade__c = appDoc.YearGrade__c
                                 );
                                 lstDocChklstToInsert.add(docChklst); 
                                 
                             }
                }
            }
        }
        //insert newly created document checklist
        if(lstDocChklstToInsert.size() > 0){
            insert lstDocChklstToInsert;
        }
    }

    /**
     * Method to create document checklist on opportunities when a new application document is created
     * @param lstNewAppDoc list of created application documents
     */
    public static void createAppDocDocumentChecklists(List<ApplicationDocument__c> lstNewAppDoc){
        List<Id> lstSchoolId = new List<Id>();
        for(ApplicationDocument__c appDoc : lstNewAppDoc){
            lstSchoolId.add(appDoc.School__c);
        }
        //Query list of opportunities having same school as application document
        List<Opportunity> lstOpp = [SELECT Id, Name, SchoolOfInterest__c, TECH_SchoolCode__c, RecordTypeId FROM Opportunity WHERE SchoolOfInterest__c IN :lstSchoolId];
        createDocChklst(lstOpp, lstNewAppDoc);
    }

    /**
     * Method to create document checklist on opportunities after insert
     * @param lstNewOpp List of newly created opportunities
     */
    public static void createOppDocumentChecklists(List<Opportunity> lstNewOpp){
        List<Id> lstSchoolId = new List<Id>();
        for(Opportunity opp: lstNewOpp){
            lstSchoolId.add(opp.SchoolOfInterest__c);
        }
        //Query list of application documents related to school associated with opportunity
        List<ApplicationDocument__c> lstAppDoc = [SELECT Id, Name, School__c, Stage__c, Required__c, RecordType__c, yeargrade__c
                                                  FROM ApplicationDocument__c WHERE School__c IN :lstSchoolId];
        createDocChklst(lstNewOpp, lstAppDoc);
    } 

    /**
    * @description Create document checklist on opportunities after update - Case 00002205
    * @author CRA | 03/03/2020 
    * @param mapOpp Map of updated opportunties
    * @param setSchId  Set of School Interest Ids of the updated opportunities
    * @return void 
    **/
    public static void createOppDocumentChecklistsAfterUpdate(Map<Id, Opportunity> mapOpp, Set<Id> setSchId) {
        Set<Id> setSchoolId = new Set<Id>();

        //check if the updated opportunities do not have any DocumentChecklist and we create
        for (DocumentChecklist__c docCheck : [SELECT Id, Opportunity__r.SchoolOfInterest__c, Opportunity__c FROM DocumentChecklist__c WHERE Opportunity__c IN :mapOpp.keySet()]) {
            setSchoolId.remove(docCheck.Opportunity__r.SchoolOfInterest__c);
            mapOpp.remove(docCheck.Opportunity__c);
        }
        
        //Query list of application documents related to school associated with opportunity
        List<ApplicationDocument__c> lstAppDoc = [SELECT Id, Name, School__c, Stage__c, Required__c, RecordType__c, yeargrade__c
                                                  FROM ApplicationDocument__c WHERE School__c IN :setSchId];
        
        if (lstAppDoc.size() > 0 && mapOpp.values().size() > 0) {
            createDocChklst(mapOpp.values(), lstAppDoc);
        }                                      
    }
}