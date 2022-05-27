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
    -- 28-JAN-2019   ANA     1.1     Added School codes for C1558
    -- 06-FEB-2019   CRA     1.2     Added School Bilingual values for W-00344 
    -- 19-FEB-2019   ANA     1.3     Added Lead Position picklist values
    -- 19-DEC-2019   CRA     1.4     Added GetLanguage method used in VFC02_AccApplicationForm and VFC02_ApplicationForm classes
    -- 07-OCT-2020   FKH     1.5     Added Translation Portuguese
    -- 18-01-2021    VJA     1.6     ###NDM_1 Lead record types
    -- 14-Mar-2021  VJA      1.7      CommentParent3
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
    
        /**
         * Get map month.
         * @return     The month in string
         */
        public static Map<Integer, String> getIntToMonthMap(){
            return new Map<Integer, String>{
                1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April', 5 => 'May', 6 => 'June', 7 => 'July', 8 => 'August', 
                9 => 'September', 10 => 'October', 11 => 'November', 12 => 'December'
            };
        }
    
        /**
        * @description : Method to get the code used in PDF of a given language e.g., chinese 
        * @author CRA | 19/12/2019 
        * @param language 
        * @return string 
        **/
        public static string getLanguage(String language) {
            String code = 'en_US';
            if(language == AP_Constant.schoolBilingualChinese || language == AP_Constant.accAppFormLangZH ){
                code = 'zh_CN';
            }
            else if(language == AP_Constant.schoolBilingualThai || language == AP_Constant.accAppFormLangTH) {
                code = 'th';
            }
            else if(language == AP_Constant.schoolBilingualFrench || language == AP_Constant.accAppFormLangFR) {
                code = 'fr';
            }
            else if (language == AP_Constant.schoolBilingualVietnamese || language == AP_Constant.accAppFormLangVI) {
                code = 'vi';
            }
            else if (language == AP_Constant.schoolBilingualSpanish ||language == AP_Constant.accAppFormLangES) {
                code = 'es';
            }
            else if (language == AP_Constant.schoolBilingualSlovak ||language == AP_Constant.accAppFormLangSK) {
                code = 'sk';
            }
            else if (language == AP_Constant.schoolBilingualPortuguese ||language == AP_Constant.accAppFormLangPOR) { // FKH - Translation portuguese
                code = 'pt_BR';
            }

            return code;
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
            public static String accAppFormLangFR='fr';  // french
            public static String accAppFormLangTH='th';  // thai
            public static String accAppFormLangZH='zh';  // chinese
            public static String accAppFormLangVI='vi';  // vietnamese
            public static String accAppFormLangES='es';  // Spanish
            public static String accAppFormLangSK='sk';  // Slovak
            public static String accAppFormLangPOR='pt_BR';  // Portuguese
            public static String accDocumentTitleParent='Parent';
            public static String accDocumentTitleChild='Child';
            public static String accRecordTypeDeveloperNameExternalRelationships = 'External Relationships';
            public static String accRecordTypeExternalRelationships = 'Account-ExternalRelationships';
    
         /***********************************************************************
         * Contact constants
            ************************************************************************/
            public static String conObject='Contact';
            public static String conRecordTypeDeveloperNameChild = 'Child';
            public static String conRecordTypeDeveloperNameParent = 'Parent';
            public static String conRecordTypeChild = 'Contact-Child';
            public static String conRecordTypeParent = 'Contact-Parent';
            public static String conRecordTypeFamily = 'Contact-Family';
            public static String conRecordTypeExternalRelationships = 'Contact-ExternalRelationships';
            public static String conStatusProspect = 'Prospect';
            public static String conStatusStudent = 'Student';
            public static String conStatusDenied = 'Denied';
            public static String conStatusWaitlisted = 'Waitlisted';
            public static String conStatusLost = 'Lost';
            public static String conNatureRelChild = 'Child';
            public static String conNatureRelMother = 'Mother';
            public static String conNatureRelFather = 'Father';
            public static String conNatureRelAssistant = 'Assistant';
            public static String conGenderMale = 'Male';
            public static String conGenderFemale = 'Female';
    
            public static String leadPositionParent1 = 'Parent 1';  //ANA20190219
            public static String leadPositionParent2 = 'Parent 2';
            //VJA public static String leadPositionParent3 = 'Parent 3';
            public static String leadPositionChild1 = 'Child 1';
            public static String leadPositionChild2 = 'Child 2';
            public static String leadPositionChild3 = 'Child 3';
            public static String leadPositionChild4 = 'Child 4';
            public static String leadPositionChild5 = 'Child 5';
            public static String leadPositionChild6 = 'Child 6';
    
        /***********************************************************************
         * AccountContactRelation constants
         ************************************************************************/
            public static String accConRelRoleChild = 'Child';
            public static String accConRelObject = 'AccountContactRelation';
    
        /***********************************************************************
         * Lead constants
         ************************************************************************/
            public static String ledRecordTypeDeveloperNameClientLead = 'Client_Lead';
            public static String ledRecordTypeClient = 'Lead-Client_Lead';
            public static String ledRecordTypeDeveloperNameEnrolment = 'Enrolment';
            public static String ledRecordTypeEnrolment = 'Lead-Enrolment';
            public static String ledGenderMale = 'Male';
            public static String ledGenderFemale = 'Female';
            public static String ledNatureOfRelationshipFather = 'Father';
            public static String ledNatureOfRelationshipMother = 'Mother';
            public static String ledNatureOfRelationshipAgent = 'Agent';
            public static String ledSrcWebform = 'Website';
            public static String ledMethodEvent = 'Event';
            public static String ledMethodWeb = 'Web';
            public static String ledMethodEmail = 'Email';
            public static String ledMethodSocialMedia = 'Social Media';
            public static String ledOriginAdmissionsStage1 = 'AdmissionsStage1';
            public static String ledOriginAdmissionsStage2 = 'AdmissionsStage2';
            public static String ledOriginFAApplication = 'FA Application';
            public static String ledOriginApplication = 'Application';
            public static String ledOriginWeChat = 'WeChat';
            public static String ledSrcOnline = 'Online';
            public static String ledExpStartYearNotSure = 'Not sure';
            public static String ledObject = 'Lead';
            public static String ledStatusNew = 'New';
            public static String ledStatusQualified = 'Qualified';
            public static String ledStatusUnqualified = 'Unqualified';
            public static String ledBoardingDay = 'Day';
            public static String ledFullBoarding = 'Full Boarding';
            public static String ledBoarding = 'Boarding';
            public static String ledBoardingDayBoarding = 'Boarding Day';
            public static String ledInterestFirstChild = 'InterestsFirstChild__c';
            public static String ledDayOrBoardingFirstChild = 'DayOrBoardingSchoolFirstChild__c';
            public static String ledMethod = 'LeadMethod__c';
            public static String ledSrc = 'LeadSource';
            public static String ledSubSrc = 'LeadSubSource__c';
            public static String ledNationalityChinese = 'Chinese';
            public static String ledCountryChina = 'China';
            public static String ledNumChildOne = '1';
            public static Integer allowCreateFamily = 0;
            public static String schLincoln = 'BCL';
            public static String schNorthbridge = 'NSC';
            public static String schBoston = 'BOS';
            public static String ledCampus = 'Campus__c';
            public static String ledRecordTypeJulliardSummerArts = 'Lead-Julliard_Summer_Arts';
            public static String ledRecordTypeIndividualChildEnrolmentLead = 'Lead-Individual_Child_Enrolment_Lead';
            public static String ledTranspositionStatusReceived = 'Received';
			public static String ledFacebookLeadAd = 'Facebook Lead Ad';
            public static String ledPPCCampaign = 'PPC Campaign';
            public static String ledBaiduPPC = 'Baidu PPC H5';


    
        /***********************************************************************
         * Opportunity constants
         ************************************************************************/
            public static String oppRecordTypeDeveloperNameEnrolment = 'Enrolment';
            public static String oppRecordTypeDeveloperNameReenrolment = 'Reenrolment';
            public static String oppRecordTypeDeveloperNameJulliardSummerArts = 'Julliard_Summer_Arts';
            public static String oppRecordTypeEnrolment = 'Opportunity-Enrolment';
            public static String oppRecordTypeReenrolment = 'Opportunity-Reenrolment';
            public static String oppRecordTypeJulliardSummerArts = 'Opportunity-JulliardSummerArts';
            public static String oppRecordTypeJulliardSummerArtsLabel = 'Juilliard Summer Arts';
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
            public static String oppStageNameActive = 'Active';
            public static String oppStageNameOnHold = 'On Hold';
            public static String oppStageNameDeferred = 'Deferred';
            public static String oppStageNameInactive = 'Inactive';
            public static String oppStageNameReenrolment = 'Eligible for Reenrolment';
            public static String oppStageNameApplication = 'Application';
            public static String oppAssessOutcomePassed = 'Passed';
            public static String oppLostDeniedReasonQuotaReached = 'No Places available / Quota reached';
    
        /***********************************************************************
         * Document Checklist constants
         ************************************************************************/
            public static String docChklstStatusSubmitted = 'Received';
            public static String docChklstStatusRequested = 'Requested';
            public static String docChklstObject = 'DocumentChecklist__c';
            public static String docChklstStageApplication = 'Application';
            public static String docChklstStageEnrolled = 'Enrolled';
            public static String docChklstStageVisit = 'Visit';
            public static String docChklstStageAcceptance = 'Acceptance';
    
    
        /***********************************************************************
         * Task constants
         ************************************************************************/
            public static String tskStatusCompleted = 'Completed';
            public static String tskStatusOpen = 'Open';
            public static String tskObject = 'Task';
    
    
        /***********************************************************************
         * School constants
         ************************************************************************/
            public static String schoolRegionChina = 'CN';
            public static String schoolBilingualChinese = 'Chinese';  //CRA / W-00344
            public static String schoolBilingualThai = 'Thai'; //CRA / W-00344
            public static String schoolBilingualFrench = 'French'; //CRA / W-00344
            public static String schoolBilingualVietnamese = 'Vietnamese'; //CRA / W-00344
            public static String schoolBilingualSpanish = 'Spanish'; //CRA / W-00344
            public static String schoolBilingualSlovak = 'Slovak'; //CRA / W-00344
            public static String schoolBilingualPortuguese = 'Portuguese'; // FKH - Translation portuguese
            public static String schDayBoardingBoth = 'Both'; //CRA W-000535
    
    	/***********************************************************************
         * Chargent Constants
         ************************************************************************/
            public static String transactionResponseStatusApproved = 'Approved';
            public static String transactionTypeCharge = 'Charge';
    }