/**
 * @File Name          : BAT26_ClassCapacityUpdate.cls
 * @Description        : Invocable methods for automatic capacityrecord update
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 08-FEB-2021, 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    08-FEB-2021, 10:00 am         VJA         Initial Version
**/
global class BAT26_ClassCapacityUpdate implements Database.Batchable<sObject>{

    global String query;
    global List<String> lstSchoolId;
    global Set<Id> setClassId;

    // Constructor for Specific classes
    global BAT26_ClassCapacityUpdate(Set<Id> setClassId){
        System.debug('##BAT26_ClassCapacityUpdate setClassId.size(): ' + setClassId.size());
        if(setClassId == null){
            setClassId = new Set<Id>();
        }
        this.setClassId = setClassId;
        query = buildQuery(setClassId, true);
    }

    global BAT26_ClassCapacityUpdate(){
        query = buildQuery(new Set<Id>{}, false);
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Class__c> lstClass){

        Map<String, List<Opportunity>> mapClassEnrolmentYearToOpportunityList;
        List<ClassCapacity__c> lstClassCapacityUpdate = new List<ClassCapacity__c>();
        System.debug('###lstClass: ' +  JSON.serialize(lstClass));

        for(Class__c cls : lstClass){
            mapClassEnrolmentYearToOpportunityList = new Map<String, List<Opportunity>>();
            System.debug('###cls.Opportunities1__r.size(): ' +  JSON.serialize(cls.Opportunities1__r.size()));

            if(cls.Opportunities1__r.size() > 0){ //create map of EY to list Of Opp for current class
                for(Opportunity opp : cls.Opportunities1__r){
                    if(opp.StageName == AP_Constant.oppStageNameEnrolled ||
                        opp.StageName == AP_Constant.oppStageNameStarted ||
                        opp.StageName == AP_Constant.oppStageNameAcceptance
                        // opp.StageName == AP_Constant.oppStageNameApplication
                    ){
                        if (mapClassEnrolmentYearToOpportunityList.containsKey(opp.Enrolment_Year__c)) {
                            mapClassEnrolmentYearToOpportunityList.get(opp.Enrolment_Year__c).add(opp);
                        }else{
                            mapClassEnrolmentYearToOpportunityList.put(opp.Enrolment_Year__c, new List<Opportunity> {opp});
                        }
                    }
                }
            }
            System.debug('###mapClassEnrolmentYearToOpportunityList: ' +  JSON.serialize(mapClassEnrolmentYearToOpportunityList));

            if(cls.Class_Capacities__r.size() > 0){ 

                for(ClassCapacity__c classCapacity : cls.Class_Capacities__r){
                    Integer oppListSize = 0;
                    if(mapClassEnrolmentYearToOpportunityList.get(classCapacity.EnrolmentYear__c) != null){
                        oppListSize = mapClassEnrolmentYearToOpportunityList.get(classCapacity.EnrolmentYear__c).size();
                    }
                    lstClassCapacityUpdate.add(new ClassCapacity__c( Id = classCapacity.Id, CapacityUsed__c = oppListSize));
                }

            }
        }

        if(lstClassCapacityUpdate.size() > 0){
            System.debug('###lstClassCapacityUpdate Size: ' +  lstClassCapacityUpdate.size());
            System.debug('###lstClassCapacityUpdate: ' +  JSON.serialize(lstClassCapacityUpdate));
            update lstClassCapacityUpdate;
        }
        
    }    

    global void finish(Database.BatchableContext bc){
        String jobName = 'BAT26_ClassCapacityUpdate' + System.now(); 
    }

    global String buildQuery(Set<Id> setClassId, Boolean hasCond){

        String query = 'SELECT Id, Name, SchoolName__c, SchoolName__r.Reference_Date__c, (SELECT Id, Name, StartDate__c, EndDate__c, CapacityUsed__c, CapacityTotal__c, CapacityAvailable__c, CurrentYear__c,EnrolmentYear__c  FROM Class_Capacities__r ORDER BY EndDate__c Desc), (SELECT Id, StageName, Enrolment_Year__c,EnrolledStartDate__c FROM Opportunities1__r) FROM Class__c WHERE SchoolName__c != null AND SchoolName__r.IsNAESchool__c = true ';
        
        if(hasCond){
            query += ' AND Id in : setClassId';
        }

        return query;
    }
}