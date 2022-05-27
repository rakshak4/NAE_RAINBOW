public without sharing class AP_Constant {
/**************************************************************************************
-- - Name          : AP_Constant
-- - Author        : Spoon Consulting
-- - Description   : Class for keeping all common constant variables 
--                 : and common methods    
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 06-DEC-2017   RRAJ    1.0     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/
     
    //Method to generate a map that contains developer Name and id for a set of ObjectAPINames 
    public static map<String,Id> getDeveloperIdMap(Set<String> ObjectAPINames){
        map <String,Id> developerIdMap = new map <String,Id>();
    
        //returns a map where key is Sobject-RecDevName and value is recordtypeId
        //e.g Account-Customer, XXXXX
        for(RecordType r : [select SobjectType,DeveloperName,Id from RecordType where SobjectType IN:ObjectAPINames order by SobjectType ASC ]){
            developerIdMap.put((r.SobjectType +'-'+ r.DeveloperName),r.Id);
        }
        return developerIdMap;                  
    }

    /**
     * Method to get mapping of month to month number
     * @return Map of month (string) to month number (int)
     */
    public static Map<String, Integer> getMonthToIntMap(){
        return new Map<String, Integer>{
            'January' => 1, 
            'February' => 2,
            'March' => 3,
            'April' => 4,
            'May' => 5,
            'June' => 6,
            'July' => 7, 
            'August' => 8,
            'September' => 9,
            'October' => 10,
            'November' => 11,
            'December' => 12
        };
    }


    // Inner class defining custom exception
    public class customException extends Exception {}

    /***********************************************************************
     * Account constants
     ************************************************************************/
        public static String accNatureOfRelationshipFamily='Family';
        public static String accNatureOfRelationshipSibling='Child';
        public static String accNatureOfRelationshipFather = 'Father';
        public static String accNatureOfRelationshipMother ='Mother';
        public static String accObject='Account';

     /***********************************************************************
     * Contact constants
     ************************************************************************/
      public static String conObject='Contact';
      public static String conRecordTypeDeveloperNameChild = 'Child';
      public static String conRecordTypeDeveloperNameParent = 'Parent';
      public static String conRecordTypeChild = 'Contact-Child';
      public static String conRecordTypeParent = 'Contact-Parent';
      public static String conStatusProspect = 'Prospect';
      public static String conStatusStudent = 'Student';
      public static String conStatusDenied = 'Denied';
      public static String conStatusWaitlisted = 'Waitlisted';
      public static String conStatusLost = 'Lost';
      public static String conNatureRelChild = 'Child';
      public static String conGenderMale = 'Male';
      public static String conGenderFemale = 'Female';

    /***********************************************************************
     * AccountContactRelation constants
     ************************************************************************/
        public static String accConRelRoleChild = 'Child';
        public static String accConRelRoleParent = 'Parent';
        public static String accConRelObject = 'AccountContactRelation';

    /***********************************************************************
     * Lead constants
     ************************************************************************/
     	public static String ledRecordTypeDeveloperNameClientLead = 'Client_Lead';
     	public static String ledRecordTypeClient = 'Lead-Client_Lead';
      public static String ledGenderMale = 'Male';
      public static String ledGenderFemale = 'Female';
      public static String ledNatureOfRelationshipFather = 'Father';
      public static String ledNatureOfRelationshipMother = 'Mother';
      public static String ledSrcWebform = 'Website';
      public static String ledOriginAdmissionsStage1 = 'AdmissionsStage1';
      public static String ledOriginAdmissionsStage2 = 'AdmissionsStage2';
      public static String ledSrcOnline = 'Online';
      public static String ledExpStartYearNotSure = 'Not sure';
     	public static String ledObject = 'Lead';
      public static String ledStatusNew = 'New';

    /***********************************************************************
     * Opportunity constants
     ************************************************************************/
    	public static String oppRecordTypeDeveloperNameEnrolment = 'Enrolment';
    	public static String oppRecordTypeDeveloperNameReenrolment = 'Reenrolment';
    	public static String oppRecordTypeDeveloperNameJulliardSummerArts = 'Julliard_Summer_Arts';
    	public static String oppRecordTypeEnrolment = 'Opportunity-Enrolment';
    	public static String oppRecordTypeReenrolment = 'Opportunity-Reenrolment';
    	public static String oppRecordTypeJulliardSummerArts = 'Opportunity-Julliard_Summer_Arts';
    	public static String oppStageEnquiry = 'Enquiry';
    	public static String oppObject = 'Opportunity';
        public static String oppDeniedOnHoldReasonWaitingList = 'Waiting list';
        public static String oppStageNameAcceptance = 'Acceptance';
        public static String oppStageNameEnquiry = 'Enquiry';
        public static String oppStageNameVisit = 'Visit';
        public static String oppStageNameEnrolled = 'Enrolled';
        public static String oppStageNameOfferOut = 'Offer Out';
        public static String oppStageNameStarted = 'Started';
        public static String oppStageNameDenied = 'Denied';
        public static String oppStageNameLost = 'Lost';
        public static String oppStageNameApplication = 'Application';


    /***********************************************************************
     * Opportunity constants
     ************************************************************************/
        public static String oppConRolChild = 'Child';
        public static String oppConRolObject = 'OpportunityContactRole';

    /***********************************************************************
     * Document Checklist constants
     ************************************************************************/
        public static String docChklstStatusSubmitted = 'Received';
        public static String docChklstStatusRequested = 'Requested';
        public static String docChklstObject = 'DocumentChecklist__c';

    /***********************************************************************
     * Task constants
     ************************************************************************/
        public static String tskStatusCompleted = 'Completed';
        public static String tskStatusOpen = 'Open';
        public static String tskObject = 'Task';

}