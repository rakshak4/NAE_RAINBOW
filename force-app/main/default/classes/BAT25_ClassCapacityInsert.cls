/** 
 * @Description        : Invocable methods for automatic capacityrecord creation
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 05-FEB-2021, 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    05-FEB-2021, 10:00 am         VJA         Initial Version
 * 1.1    13-MAY-2021                   VJA         Modification to generateStartDate() for previous year
**/
global class BAT25_ClassCapacityInsert implements Database.Batchable<sObject>, Database.Stateful, Schedulable{

    global Set<Id> setClassId;
    global Set<Id> setClassIdTrigger;
    global String query;
    global String isFromTrigger;


    // Constructor for Specific classes
    global BAT25_ClassCapacityInsert(Set<Id> setClassIdTrigger){
        System.debug('##BAT26_ClassCapacityUpdate setClassId.size(): ' + setClassIdTrigger.size());

        setClassId = new Set<Id>();
        if(setClassIdTrigger == null){
            setClassIdTrigger = new Set<Id>();
        }
        this.setClassIdTrigger = setClassIdTrigger;
        
        query = buildQuery(setClassIdTrigger, true);
    }

    global BAT25_ClassCapacityInsert(){
        setClassId = new Set<Id>();
        query = buildQuery(new Set<Id>{}, false);
    }

    global void execute (SchedulableContext sc){
        BAT25_ClassCapacityInsert batchObj = new BAT25_ClassCapacityInsert();
        Database.executeBatch(batchObj , 100);
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Class__c> lstClass){
        Date executionDate = System.today();
        // executionDate = Date.newInstance(System.today().addYears(1).year(), 9, 1);
        Date referenceDate, startDate;
        Date maxDate;
        Integer executionMonth = executionDate.month();
        Integer executionDay = executionDate.day();
        Decimal lastCapacityTotal;
        Boolean isNewCapacity = false;
        String EnrolmentYear;
        Map<Id, List<ClassCapacity__c>> mapClassIdToClassCapacityList = new Map<Id, List<ClassCapacity__c>>();
        List<ClassCapacity__c> lstClassCapacityInsert = new List<ClassCapacity__c>();
        List<ClassCapacity__c> lstClassCapacityUpdate = new List<ClassCapacity__c>();

        //Capacity record creation
        for(Class__c cls : lstClass){
            isNewCapacity = false;
            startDate = generateStartDate(executionDate, cls.SchoolName__r.Reference_Date__c); //startDate Generation usingdd/mm from School.ReferenceDate & Current Year
            maxDate = startDate;
            lastCapacityTotal = 0;
            EnrolmentYear = startDate.year() + '/' + (startDate.year() + 1); //key of map
            System.debug('###EnrolmentYear: ' +  EnrolmentYear);
            System.debug('###cls.Class_Capacities__r: ' +  cls.Class_Capacities__r);

            if(cls.Class_Capacities__r .size() > 0){ //Check if there is existing school capacities
                lastCapacityTotal =  cls.Class_Capacities__r[0].CapacityTotal__c > 0 ? cls.Class_Capacities__r[0].CapacityTotal__c : 0 ;

                //Loop existing class capacity records per class
                for(ClassCapacity__c classCapacity : cls.Class_Capacities__r){ 
                    System.debug('###CC cls.Name: ' + cls.Name);
                    System.debug('###CC classCapacity.EndDate__c: ' + classCapacity.EndDate__c);

                    if(classCapacity.EndDate__c > maxDate){ // check if new Start date is greater that the last End Date of class capacity
                        System.debug('###classCapacity.EndDate__c > startDate');
                        maxDate = classCapacity.EndDate__c;
                    }

                }

                //Create new class capacity record if batch execution date is past the most recent class capacity end date
                if(maxDate == startDate){
                    lstClassCapacityInsert.add(createCapacity(cls.Id, String.join(new List<String>{cls.Name, EnrolmentYear}, ' - '), startDate, lastCapacityTotal));
                    setClassId.add(cls.Id);
                    mapClassIdToClassCapacityList.put(cls.Id, cls.Class_Capacities__r);
                    isNewCapacity = true;
                }

            }else{ //Create first capacity record for the current year only
                lstClassCapacityInsert.add(createCapacity(cls.Id, String.join(new List<String>{cls.Name, EnrolmentYear}, ' - '), startDate, 0));
                setClassId.add(cls.Id);
            }
        }

        for(Id clsId : mapClassIdToClassCapacityList.keySet()){ //Uncheck previous capacity records if new one was created
            for(ClassCapacity__c classCapacity : mapClassIdToClassCapacityList.get(clsId)){
                if(classCapacity.CurrentYear__c){
                    lstClassCapacityUpdate.add(new ClassCapacity__c(id = classCapacity.Id, CurrentYear__c = false));
                }
            }
        }

        if(lstClassCapacityInsert.size() > 0){
            System.debug('###lstClassCapacityInsert Size: ' +  lstClassCapacityInsert.size());
            System.debug('###lstClassCapacityInsert: ' +  JSON.serialize(lstClassCapacityInsert.size()));
            insert lstClassCapacityInsert;
        }

        if(lstClassCapacityUpdate.size() > 0){
            System.debug('###lstClassCapacityUpdate Size: ' +  lstClassCapacityUpdate.size());
            System.debug('###lstClassCapacityUpdate: ' +  JSON.serialize(lstClassCapacityUpdate.size()));
            update lstClassCapacityUpdate;
        }        
    }    

    global void finish(Database.BatchableContext bc){
        String jobName = 'BAT25_ClassCapacityInsert' + System.now();
        System.debug('##AP31_ClassRules setClassId.size(): ' + setClassId.size());
        System.debug('###AP31 batch 26 execution');
        Id batchJobId = Database.executeBatch(new BAT26_ClassCapacityUpdate(setClassId));
    }

    // Method to create new capacity record
    public ClassCapacity__c createCapacity(Id classId, String strName, Date startDate, Decimal capacityTotal){
        Date endDate = startDate.addYears(1).addDays(-1);
        System.debug('###strName: ' + strName);
        System.debug('###startDate: ' + startDate);
        System.debug('###endDate: ' + endDate);
        System.debug('###capacityTotal: ' + capacityTotal);

        return new ClassCapacity__c(Name = strName, Class__c = classId, StartDate__c = startDate, EndDate__c = endDate, CapacityTotal__c = capacityTotal );
    }

    //Method to generate capacity Start Date.
    public Date generateStartDate(Date executionDate, Date referenceDate){
        Date startDate;
        Date referenceDateCopy = referenceDate;
        System.debug('###executionDate: ' + executionDate);
        System.debug('###referenceDate: ' + referenceDate);
        if(referenceDate == null){
            referenceDate = Date.newInstance(executionDate.year(), 9, 1); //Default Date : 01/09/YYYY
        }else{
            referenceDate = referenceDate = Date.newInstance(executionDate.year(), referenceDateCopy.month(), referenceDateCopy.day());
        }
        
        if(executionDate < referenceDate){
            startDate = Date.newInstance(executionDate.addYears(-1).year(), referenceDate.month(), referenceDate.Day());
        }
        else if(executionDate >= referenceDate){
            startDate = Date.newInstance(executionDate.year(), referenceDate.month(), referenceDate.Day());
        }
        
        System.debug('###StartDate: ' + startDate);
        return startDate;
    }


    global String buildQuery(Set<Id> setClassIdTrigger, Boolean hasCond){

        String query = 'SELECT Id, Name, SchoolName__c, SchoolName__r.Reference_Date__c, (SELECT Id, Name, StartDate__c, EndDate__c, CapacityUsed__c, CapacityTotal__c, CapacityAvailable__c, CurrentYear__c,EnrolmentYear__c  FROM Class_Capacities__r ORDER BY EndDate__c Desc), (SELECT Id, StageName, Enrolment_Year__c,EnrolledStartDate__c FROM Opportunities1__r) FROM Class__c WHERE SchoolName__c != null AND SchoolName__r.IsNAESchool__c = true ';
        
        if(hasCond){
            query += ' AND Id in : setClassIdTrigger';
        }

        return query;
    }
}