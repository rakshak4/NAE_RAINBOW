/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for creation of new Lead
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 17-MAY-2018  AMU    1.0     Initial version
-- 06-DEC-2018  CRA	   1.1	   User can choose ExpectedYearGrade of child (W-000465)
-- 28-JAN-2019  ANA	   1.2	   Case 00001558
-- 31-MAI-2019  CRA    1.3     Auto-populate Day/Boarding fields regarding Day/Boarding value in School level (W-000535)
-- 31-JUL-2019  CRA    1.4     Removed Sixth child Section - Application Form R2.0
-- 24-MAR-2020  CRA    1.5     Case 00002295 - Add Campus field
-- 01-DEC-2020  FKO    1.6     Case 00002820 - Cater for default recordtype
-- 14-Mar-2021  VJA    1.7    Fields comment for cleanup
--------------------------------------------------------------------------------------
***************************************************************************************/
public with sharing class LC02_NewLeadForm {

    /**
     * Get new lead details
     * @return     New lead details
     */
    @AuraEnabled
    public static Map<String, Object> getDetails() {
        Map<String, Object> mapResult = new Map<String,Object>();
        try {    
            Map<String, String> mapCountryPhone = new Map<String, String>();
            List<School__c> lstSchool = new List<School__c>();

            User user = [SELECT Id, SchoolCode__c, Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
            if(String.isNotBlank(user.SchoolCode__c)) {
                lstSchool = [SELECT Id, Region__c, SchoolCode__c, DayBoarding__c FROM School__c WHERE SchoolCode__c =: user.SchoolCode__c.trim()];
            }
            
            //ANA20190125: Case 0001558
            //String boardingBasedOnschool = (user.SchoolCode__c == AP_Constant.schLincoln || user.SchoolCode__c == AP_Constant.schNorthbridge || user.SchoolCode__c == AP_Constant.schBoston) ? AP_Constant.ledBoardingDay : null;

            //CRA20190531: W-00535 
            String boardingBasedOnschool = null;
            if(lstSchool.size() > 0 && lstSchool[0].DayBoarding__c == AP_Constant.ledBoarding) {
                boardingBasedOnschool = AP_Constant.ledBoardingDayBoarding;
            }
            else if(lstSchool.size() > 0 && lstSchool[0].DayBoarding__c == AP_Constant.ledBoardingDay) {
                boardingBasedOnschool = AP_Constant.ledBoardingDay;
            }
            //if(lstSchool.size()>0 && lstSchool[0].DayBoarding__c != null && lstSchool[0].DayBoarding__c != AP_Constant.schDayBoardingBoth) {
              //  boardingBasedOnschool = lstSchool[0].DayBoarding__c == AP_Constant.ledBoarding ? AP_Constant.ledBoardingDayBoarding : AP_Constant.ledBoardingDay;
            //}

            Lead lead = new Lead(
                SchoolOfInterest__c = lstSchool.size()>0? lstSchool[0].Id : null
                ,Status = AP_Constant.ledStatusNew
                ,Number_of_children__c = '1'
                ,OwnerId = user.Id
                ,MarketingQualifiedFirstChild__c = true
                ,MarketingQualifiedSecondChild__c = true
                ,MarketingQualifiedThirdChild__c = true
                ,MarketingQualifiedFourthChild__c = true
                ,MarketingQualifiedFifthChild__c = true
                //,MarketingQualifiedSixthChild__c = true
                ,DayOrBoardingSchoolFirstChild__c = boardingBasedOnschool
                ,DayOrBoardingSchoolSecondChild__c = boardingBasedOnschool
                ,DayOrBoardingSchoolThirdChild__c = boardingBasedOnschool
                ,DayOrBoardingSchoolFourthChild__c = boardingBasedOnschool
                ,DayOrBoardingSchoolFifthChild__c = boardingBasedOnschool
                //,DayOrBoardingSchoolSixthChild__c = boardingBasedOnschool
            );

            if(String.isNotBlank(user.SchoolCode__c)) {
                if(user.SchoolCode__c.trim() == 'CBS') {
                    lead.DayOrBoardingSchoolFirstChild__c = AP_Constant.ledFullBoarding;
                    lead.DayOrBoardingSchoolSecondChild__c = AP_Constant.ledFullBoarding;
                    lead.DayOrBoardingSchoolThirdChild__c = AP_Constant.ledFullBoarding;
                    lead.DayOrBoardingSchoolFourthChild__c = AP_Constant.ledFullBoarding;
                    lead.DayOrBoardingSchoolFifthChild__c = AP_Constant.ledFullBoarding;
                    //lead.DayOrBoardingSchoolSixthChild__c = AP_Constant.ledFullBoarding;
                }
            }
            mapResult.put('lead', lead);

            if(boardingBasedOnschool != null) {
                mapResult.put('dayBoarding', true);
            }
            else {
                mapResult.put('dayBoarding', false);
            }
          
            for(CS_CountryPhoneCode__c countryPhone : CS_CountryPhoneCode__c.getAll().values()) {
                mapCountryPhone.put(countryPhone.Country_Name__c, countryPhone.Phone_Code__c);
            }

            mapResult.put('mapCountry', mapCountryPhone);

            // Map<String, List<String>> mapPickList = getSelectOptions(lead, new List<String>{AP_Constant.ledInterestFirstChild, AP_Constant.ledMethod, AP_Constant.ledDayOrBoardingFirstChild, AP_Constant.ledCampus}); //cra20190603-W000535

            Map<String, List<String>> mapPickList = getSelectOptions(lead, new List<String>{AP_Constant.ledMethod, AP_Constant.ledDayOrBoardingFirstChild, AP_Constant.ledCampus}); //

            mapResult.put('mapPickList', mapPickList);

            //VJA mapResult.put('lstInterest', getInterest());

            Map<String, SObjectField> fieldsMapByName = Schema.getGlobalDescribe().get(AP_Constant.ledObject).getDescribe().fields.getMap(); 
            SObjectField leadSrcField = fieldsMapByName.get(AP_Constant.ledSrc); 
            SObjectField leadSubSrcField = fieldsMapByName.get(AP_Constant.ledSubSrc);

            Map<String, List<String>> mapDepPicklist = getDependentOptionsImpl(leadSubSrcField, leadSrcField);
            mapResult.put('mapDepPicklist', mapDepPicklist);

            mapResult.put('fieldVisible', false);
            if(lstSchool != null){
                if(lstSchool.size() > 0) {
                     if(lstSchool[0].Region__c == AP_Constant.schoolRegionChina){
                        mapResult.put('fieldVisible', true);
                    }
                }
            }
            
            Map<String, String> mapUserDetails = new Map<String, String>{
                'label' => user.Name
                ,'id' => user.Id
                ,'type' => 'User'
            };
            mapResult.put('userDetail', mapUserDetails);
            mapResult.put('success', true);
         } catch(Exception e) {
            mapResult.put('success', false);
            mapResult.put('message', e.getMessage());
        }
        return mapResult;
    }

            

    /*public static Object getInterest(){
        List<Object> lstPicklist = new List<Object>();
        Schema.DescribeFieldResult fieldResult = Lead.InterestsFirstChild__c.getDescribe();
        
        for(Schema.PicklistEntry entry : fieldResult.getPicklistValues()){
            lstPicklist.add(new Map<String, String>{'value' => entry.getValue(), 'label' => entry.getLabel()});
        }
        return lstPicklist;
    }*/

    //public static String updatePhone(String phoneNo){
     //   return AP18_UpdatePhoneFormat.updatePhoneFormat(phoneNo);
    //}

    /**
     * Saves a lead.
     * @param      lead  The lead
     * @return     return Map of results.
     */
    @AuraEnabled
    public static Map<String, String> saveLead(Lead lead, String RecordTypeId){
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.AssignmentRuleHeader.useDefaultRule = true;
        try {

            if(validateRecordTypeId(RecordTypeId))
                lead.RecordTypeId = RecordTypeId; 
            else
                lead.RecordTypeId = getDefaultRecordTypeID();
            //lead.setOptions(dmo);            
            lead = updateStartYearMonth(lead);
            lead = updateYearGrade(lead);
            insert lead;
            return new Map<String, String>{'type'=>Label.success, 'leadId'=>lead.Id, 'message'=>Label.LeadCreateSuccessMessage};
        } catch(System.DmlException e) {
            return new Map<String, String>{'type'=>Label.error, 'message'=>e.getDmlMessage(0)};
        }
    }

    /**
     * Update start month and start year of lead
     * @param      lead  Inserted Lead
     * @return     updated lead.
     */
    public static Lead updateStartYearMonth(Lead lead){
        Map<Integer, String> mapIntToMonth = AP_Constant.getIntToMonthMap();

        Date startDateFirstChild = lead.EnrollmentDateFirstChild__c; 
        Date startDateSecondChild = lead.EnrollmentDateSecondChild__c;
        Date startDateThirdChild = lead.EnrollmentDateThirdChild__c;
        Date startDateFourthChild = lead.EnrollmentDateFourthChild__c;
        Date startDateFifthChild = lead.EnrollmentDateFifthChild__c;
        //Date startDateSixthChild = lead.EnrollmentDateSixthChild__c;

        if(String.isNotBlank(String.valueOf(startDateFirstChild))) {
            lead.ExpectedStartMonthFirstChild__c = mapIntToMonth.get(startDateFirstChild.month());
            lead.ExpectedStartYearFirstChild__c = String.valueOf(startDateFirstChild.year());
        }

        if(String.isNotBlank(String.valueOf(startDateSecondChild))) {
            lead.ExpectedStartMonthSecondChild__c = mapIntToMonth.get(startDateSecondChild.month());
            lead.ExpectedStartYearSecondChild__c = String.valueOf(startDateSecondChild.year());
        }

        if(String.isNotBlank(String.valueOf(startDateThirdChild))) {
            lead.ExpectedStartMonthThirdChild__c = mapIntToMonth.get(startDateThirdChild.month());
            lead.ExpectedStartYearThirdChild__c = String.valueOf(startDateThirdChild.year());
        }

        //VJA 
        /*
        if(String.isNotBlank(String.valueOf(startDateFourthChild))) {
            lead.ExpectedStartMonthFourthChild__c = mapIntToMonth.get(startDateFourthChild.month());
            lead.ExpectedStartYearFourthChild__c = String.valueOf(startDateFourthChild.year());
        }

        if(String.isNotBlank(String.valueOf(startDateFifthChild))) {
            lead.ExpectedStartMonthFifthChild__c = mapIntToMonth.get(startDateFifthChild.month());
            lead.ExpectedStartYearFifthChild__c = String.valueOf(startDateFifthChild.year());
        }*/

        //if(String.isNotBlank(String.valueOf(startDateSixthChild))) {
           // lead.ExpectedStartMonthSixthChild__c = mapIntToMonth.get(startDateSixthChild.month());
            //lead.ExpectedStartYearSixthChild__c = String.valueOf(startDateSixthChild.year());
        //}
        
        return lead;
    }

    /**
     * Update expected year Grade of lead
     * @param      lead  The lead
     * @return     updated lead.
     */
    public static Lead updateYearGrade(Lead lead){
        Date dobFirstChild = lead.DateOfBirthFirstChild__c;
        Date dobSecondChild = lead.DateOfBirthSecondChild__c;
        Date dobThirdChild = lead.DateOfBirthThirdChild__c;
        Date dobFourthChild = lead.DateOfBirthFourthChild__c;
        Date dobFifthChild = lead.DateOfBirthFifthChild__c;
        //Date dobSixthChild = lead.DateOfBirthSixthChild__c;
		
        //CRA 20181206:W-000465 
        if(dobFirstChild != null && lead.ExpectedYearGradeFirstChild__c == null) {
            Integer ageFirstChild =  getAge(dobFirstChild);
            List<YearGrade__c> lstYrGrade = getYearGrade(ageFirstChild, lead.SchoolOfInterest__c);

            if(lstYrGrade.size() > 0) {
                lead.ExpectedYearGradeFirstChild__c = lstYrGrade[0].Id;
            }
        }

        //CRA 20181206:W-000465 
        if(dobSecondChild != null && lead.ExpectedYearGradeSecondChild__c == null) {
            Integer ageSecondChild = getAge(dobSecondChild);
            List<YearGrade__c> lstYrGrade = getYearGrade(ageSecondChild, lead.SchoolOfInterest__c);

            if(lstYrGrade.size() > 0) {
                lead.ExpectedYearGradeSecondChild__c = lstYrGrade[0].Id;
            }
        }

        //CRA 20181206:W-000465 
        if(dobThirdChild != null && lead.ExpectedYearGradeThirdChild__c == null) {
            Integer ageThirdChild = getAge(dobThirdChild);
            List<YearGrade__c> lstYrGrade = getYearGrade(ageThirdChild, lead.SchoolOfInterest__c);

            if(lstYrGrade.size() > 0) {
                lead.ExpectedYearGradeThirdChild__c = lstYrGrade[0].Id;
            }
        }

        //CRA 20181206:W-000465 
        if(dobFourthChild != null && lead.ExpectedYearGradeFourthChild__c == null) {
            Integer ageFourthChild = getAge(dobFourthChild);
            List<YearGrade__c> lstYrGrade = getYearGrade(ageFourthChild, lead.SchoolOfInterest__c);

            if(lstYrGrade.size() > 0) {
                lead.ExpectedYearGradeFourthChild__c = lstYrGrade[0].Id;
            }
        }

        //CRA 20181206:W-000465 
        if(dobFifthChild != null && lead.ExpectedYearGradeFifthChild__c == null) {
            Integer ageFifthChild = getAge(dobFifthChild);
            List<YearGrade__c> lstYrGrade = getYearGrade(ageFifthChild, lead.SchoolOfInterest__c);

            if(lstYrGrade.size() > 0) {
                lead.ExpectedYearGradeFifthChild__c = lstYrGrade[0].Id;
            }
        }

        //CRA 20181206:W-000465 
        //if(dobSixthChild != null && lead.ExpectedYearGradeSixthChild__c == null) {
            //Integer ageSixthChild = getAge(dobSixthChild);
            //List<YearGrade__c> lstYrGrade = getYearGrade(ageSixthChild, lead.SchoolOfInterest__c);

            //if(lstYrGrade.size() > 0) {
            //    lead.ExpectedYearGradeSixthChild__c = lstYrGrade[0].Id;
            //}
        //}
        return lead; 
    }

    /**
     * Get year Grade.
     * @param      age       The age
     * @param      schoolId  The school identifier
     * @return     List of year Grade.
     */
    public static List<YearGrade__c> getYearGrade(Integer age, String schoolId){
        return [SELECT Id FROM YearGrade__c WHERE MaximumAge__c >= :age
                    AND MinimumAge__c <= :age AND SchoolName__c =:schoolId];
    }

    /**
     * Gets the age.
     * @param      dob   date of birth
     * @return     The age
     */
    public static Integer getAge(Date dob){
        return Integer.valueOf(dob.daysBetween(Date.Today())/365);
    }

    /**
     * get map of picklist value and its dependant picklist
     * param      objObject  sObject name
     * param      lstFldName list of all picklist values
     * return     Map of picklist and dependant picklist
     */
    public static Map<String, List<String>> getSelectOptions(sObject objObject, List<String> lstFldName) { 
        Map<String, List<String>> allOpts = new Map<String, List<String>>();
        Schema.sObjectType objType = objObject.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
       
        Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();

        for(String fld :lstFldName) {
            List<Schema.PicklistEntry> lstValues = fieldMap.get(fld).getDescribe().getPickListValues();

            for(Schema.PicklistEntry a: lstValues) {
                if(allOpts.containsKey(fld)) {
                    allOpts.get(fld).add(a.getValue());
                    allOpts.get(fld).sort();  
                } else {
                    allOpts.put(fld, new List<String>{a.getValue()});
                }
            }
        }

        return allOpts;
    }

    /**
     * get dependant options
     * param      theField the dependant picklist field
     * param      ctrlField the controlled picklist field
     * return     get dependant options
     */
    public static Map<String, List<String>> getDependentOptionsImpl(Schema.SObjectField theField, Schema.SObjectField ctrlField) {
        // validFor property cannot be accessed via a method or a property,
        // so we need to serialize the PicklistEntry object and then deserialize into a wrapper.
        List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
        List<PicklistEntryWrapper> depEntries =
                LC02_NewLeadForm.wrapPicklistEntries(theField.getDescribe().getPicklistValues());

        // Set up the return container - Map<ControllingValue, List<DependentValues>>
        Map<String, List<String>> objResults = new Map<String, List<String>>();
        List<String> controllingValues = new List<String>();

        for (Schema.PicklistEntry ple : contrEntries) {
            String label = ple.getLabel();
            objResults.put(label, new List<String>());
            controllingValues.add(label);
        }

        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            for (Integer i = 0; i < validForBits.length(); i++) {
                // For each bit, in order: if it's a 1, add this label to the dependent list for the corresponding controlling value
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    objResults.get(controllingValues.get(i)).add(label);
                }
            }
        }

        return objResults;
    }

    // Convert decimal to binary representation (alas, Apex has no native method :-(
    //    eg. 4 => '100', 19 => '10011', etc.
    // Method: Divide by 2 repeatedly until 0. At each step note the remainder (0 or 1).
    // These, in reverse order, are the binary.
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }

    // Convert a base64 token into a binary/bits representation
    // e.g. 'gAAA' => '100000000000000000000'
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';

        String validForBits = '';

        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }

        return validForBits;
    }

    private static final String base64Chars = '' +
            'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
            'abcdefghijklmnopqrstuvwxyz' +
            '0123456789+/';

    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }

    public class PicklistEntryWrapper {
        /*public String active {get; set;}
        public String defaultValue {get; set;}*/
        public String label {get; set;}
        //public String value {get; set;}
        public String validFor {get; set;}
    }
    
    @AuraEnabled //FKO 20201201:Case 00002820 
    public static String getRecordTypeNameById(String objectName, String strRecordTypeId){
        if(!validateRecordTypeId(strRecordTypeId)){
            strRecordTypeId = getDefaultRecordTypeID();
        }
        return Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosById().get(strRecordTypeId).getName();
    }  
    
    //FKO 20201201:Case 00002820
    public static boolean validateRecordTypeId(String strRecordTypeId){
        String strLeadRecordTypeId;
        for(RecordTypeInfo info: Lead.SObjectType.getDescribe().getRecordTypeInfos()) {
            if(info.isAvailable()) {
                strLeadRecordTypeId = (String)info.getRecordTypeId();
                if(strLeadRecordTypeId.contains(strRecordTypeId))
                    return true;
            }
        }
        return false;
    }

    //FKO 20201201:Case 00002820
    public static String getDefaultRecordTypeID(){
        List<Schema.RecordTypeInfo> infos = Schema.SObjectType.Lead.RecordTypeInfos;
        String defaultRecordTypeId;

        for (Schema.RecordTypeInfo info : infos){
          if (info.DefaultRecordTypeMapping) 
            defaultRecordTypeId = (String)info.RecordTypeId;
        }
        return defaultRecordTypeId;
    }

}