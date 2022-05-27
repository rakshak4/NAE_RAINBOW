public class AP02_LeadRules {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for Implementing Rules on Lead Insert
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 11-JAN-2018  RRAJ    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/

    private static Map<String, Integer> mapMonthToInt = AP_Constant.getMonthToIntMap();

    /**
     * Method to autopopulate fields on lead before insertine lead
     * Method Populates School of interest based on school code and viseversa
     * Method populates external id of lead based on field values
     * Method auto populates LastName an Company fields on lead as these standard fields are mandatory
     * @param lstNewLed List of newly inserted lists
     */
    public static void populateFields(List<Lead> lstNewLed){
        //Set<String> schCodeSet = new Set<String>(); // set of all school codes
        //Set<Id> schIdSet = new Set<Id>(); // set of all shcool ids of leads
        Set<String> externalIdSet = new Set<String>(); // stores all external Ids of incoming leads
        Set<String> existingExternalIdSet = new Set<String>(); // stores all EXISTING external Ids of incoming leads
        //Map<Id,School__c> schIdSchoolMap = new Map<Id,School__c>(); // map of school id to school
        //Map<String,School__c> schCodeSchoolMap = new Map<String,School__c>(); // map of school code to school

        for(Lead led : lstNewLed){

            //Rules for leads coming from webform
            if(led.Lead_Origin__c == AP_Constant.ledOriginAdmissionsStage1 || led.Lead_Origin__c == AP_Constant.ledOriginAdmissionsStage2){
                led.LeadSource = AP_Constant.ledSrcOnline; //rraj added to set lead source of lead from webform
                //led.Send_Acknowledgement__c = true; //RRAJ added to default send acknowledgement flag to true for all leads sent from webform
                //led.isExternalSource__c = true;

                //if(String.isBlank(led.Parent1Company__c) && String.isNotBlank(led.Company)){
                //    led.Parent1Company__c = led.Company;
                //    led.Company = null; // set company to null as company is populated with family name later
                //}

                //set expected start date of children based on expected start month and expected start year
                //if(String.isNotBlank(led.ExpectedStartYear__c) && String.isNotBlank(led.ExpectedStartMonth__c)){
                //    Date expStartDate = generateStartDate(led.ExpectedStartMonth__c, led.ExpectedStartYear__c);
                //    if(String.isNotBlank(led.Number_of_Children__c) ){
                //        if(Integer.valueOf(led.Number_of_children__c) > 0){
                //            led.EnrollmentDateFirstChild__c = expStartDate;
                //            led.ExpectedStartMonthFirstChild__c = led.ExpectedStartMonth__c;
                //            led.ExpectedStartYearFirstChild__c = led.ExpectedStartYear__c;
                //        }
                //        if(Integer.valueOf(led.Number_of_children__c) > 1){
                //            led.EnrollmentDateSecondChild__c = expStartDate;
                //            led.ExpectedStartMonthSecondChild__c = led.ExpectedStartMonth__c;
                //            led.ExpectedStartYearSecondChild__c = led.ExpectedStartYear__c;
                //        }
                //        if(Integer.valueOf(led.Number_of_children__c) > 2){
                //            led.EnrollmentDateThirdChild__c = expStartDate;
                //            led.ExpectedStartMonthThirdChild__c = led.ExpectedStartMonth__c;
                //            led.ExpectedStartYearThirdChild__c = led.ExpectedStartYear__c;
                //        }
                //        if(Integer.valueOf(led.Number_of_children__c) > 3){
                //            led.EnrollmentDateFourthChild__c = expStartDate;
                //            led.ExpectedStartMonthFourthChild__c = led.ExpectedStartMonth__c;
                //            led.ExpectedStartYearFourthChild__c = led.ExpectedStartYear__c;
                //        }
                //        if(Integer.valueOf(led.Number_of_children__c) > 4){
                //            led.EnrollmentDateFifthChild__c = expStartDate;
                //            led.ExpectedStartMonthFifthChild__c = led.ExpectedStartMonth__c;
                //            led.ExpectedStartYearFifthChild__c = led.ExpectedStartYear__c;
                //        }
                //        if(Integer.valueOf(led.Number_of_children__c) > 5){
                //            led.EnrollmentDateSixthChild__c = expStartDate;
                //            led.ExpectedStartMonthSixthChild__c = led.ExpectedStartMonth__c;
                //            led.ExpectedStartYearSixthChild__c = led.ExpectedStartYear__c;
                //        }
                //    }
                //}
            }

            //populate parent fields necessary for lead conversion
            //if(String.isBlank(led.Parent1Title__c) && String.isNotBlank(led.Title)) led.Parent1Title__c = led.Title;
            //if(String.isBlank(led.Parent1FirstName__c) && String.isNotBlank(led.Firstname)) led.Parent1FirstName__c = led.Firstname; 
            //if(String.isBlank(led.Parent1LastName__c) && String.isNotBlank(led.Lastname))led.Parent1LastName__c = led.Lastname;
            //if(String.isBlank(led.Parent1PrimaryEmail__c) && String.isNotBlank(led.Email)) led.Parent1PrimaryEmail__c = led.Email;
            //if(String.isBlank(led.Parent1Nationality__c) && String.isNotBlank(led.Nationality__c)) led.Parent1Nationality__c = led.Nationality__c;
            //if(String.isBlank(led.Parent1CountryOfResidence__c) && String.isNotBlank(led.Country_of_residence__c)) led.Parent1CountryOfResidence__c = led.Country_of_residence__c;
            //if(String.isBlank(led.WeChat__c) && String.isNotBlank(led.WeChatUserId__c)) led.WeChat__c = led.WeChatUserId__c;

            //populate lead firstname, lastname, email as these fields are required
            //populate fields from required for conversion and lead creation
            //if(String.isBlank(led.Title) && String.isNotBlank(led.Parent1Title__c)) led.Title = led.Parent1Title__c;
            //if(String.isBlank(led.LastName) && String.isNotBlank(led.Parent1LastName__c))  led.LastName = led.Parent1LastName__c;
            //if(String.isBlank(led.Firstname) &&  String.isNotBlank(led.Parent1FirstName__c)) led.Firstname = led.Parent1FirstName__c;
            //if(String.isBlank(led.Email) && String.isNotBlank(led.Parent1PrimaryEmail__c)) led.Email = led.Parent1PrimaryEmail__c;
            //if(String.isBlank(led.Nationality__c) && String.isNotBlank(led.Parent1Nationality__c)) led.Nationality__c = led.Parent1Nationality__c;
            //if(String.isBlank(led.Country_of_residence__c) && String.isNotBlank(led.Parent1CountryOfResidence__c)) led.Country_of_residence__c = led.Parent1CountryOfResidence__c;
            //if(String.isBlank(led.WeChatUserId__c) && String.isNotBlank(led.WeChat__c)) led.WeChatUserId__c = led.WeChat__c;

            //Set company family name of lead as company name is for family account name during conversion
            //if(String.isBlank(led.Company) && String.isNotBlank(led.Parent1FirstName__c) && String.isNotBlank(led.Parent1LastName__c)){
            //    led.Company = led.Parent1FirstName__c + ' ' + led.Parent1LastName__c + ' ' + 'Family';
            //}

            //build mapping of school code and school id to populate school code/school of interest on lead
            //if(String.isNotEmpty(led.SchoolOfInterest__c) && String.isEmpty(led.School_Code__c)) schIdSet.add(led.SchoolOfInterest__c);
            //if(String.isEmpty(led.SchoolOfInterest__c) && String.isNotEmpty(led.School_Code__c)) schCodeSet.add(led.School_Code__c);


            //setting externalId of lead
            led.ExternalId__c = generateExternalId(led);
            
            externalIdSet.add(led.ExternalId__c);
            
        }

        for (Lead led : [SELECT Id, ExternalId__c FROM Lead WHERE ExternalId__c IN :externalIdSet]){
            existingExternalIdSet.add(led.ExternalId__c);
        }

        //System.debug('##### existingExternalIdSet: '+existingExternalIdSet);

        //if (schCodeSet.size()>0 || schIdSet.size()>0){
        //    for (School__c sc : [SELECT Id, SchoolCode__c FROM School__c WHERE Id IN :schIdSet OR SchoolCode__c IN :schCodeSet]){
        //        schIdSchoolMap.put(sc.Id, sc);
        //        schCodeSchoolMap.put(sc.SchoolCode__c, sc);
        //    }
        //}
        
        for(Lead led : lstNewLed){

            if (existingExternalIdSet.contains(led.ExternalId__c)){
                led.APIModifiedDate__c = DateTime.now();
            }
                

            //if (String.isEmpty(led.School_Code__c) && led.SchoolOfInterest__c!=null && schIdSchoolMap.containsKey(led.SchoolOfInterest__c)) led.School_Code__c = schIdSchoolMap.get(led.SchoolOfInterest__c).SchoolCode__c;
            //if (String.isNotEmpty(led.School_Code__c) && led.SchoolOfInterest__c==null && schCodeSchoolMap.containsKey(led.School_Code__c)) led.SchoolOfInterest__c = schCodeSchoolMap.get(led.School_Code__c).Id;

            //System.debug('#### led:'+ JSON.serialize(led));
        }
    }

    /**
     * Method to generate external Id of a Lead using lastName, Email, SchoolCode, and Date Created.
     * @param  led Lead object to determine external id based on field values
     * @return     ExternalId on Lead
     */
    public static String generateExternalId(Lead led){
        String month        = (date.today().month()<10) ? '0'+date.today().month() : String.valueOf(date.today().month());
        String day          = (date.today().day()<10) ? '0'+date.today().day() : String.valueOf(date.today().day());
        String dateStr      = date.today().year() +'/'+ month +'/'+ day;
        String extId = led.LastName+'-'+led.Email +'-'+ led.School_Code__c +'-'+ dateStr;
        return extId;
    }

    ///**
    // * [generateStartDate description]
    // * @param  month [description]
    // * @param  year  [description]
    // * @return       [description]
    // */
    //public static Date generateStartDate(String month, String year){
    //    month = month.trim();
    //    year = year.trim();
        
    //    Integer yearInt;
    //    Integer monthInt;
    //    Date expStart;
        
    //    if(month.equalsIgnoreCase(AP_Constant.ledExpStartYearNotSure) || year.equalsIgnoreCase(AP_Constant.ledExpStartYearNotSure) || month == '' || year == ''){
    //        return null;
    //    }else{
    //        monthInt = mapMonthToInt.get(month);
    //        yearInt = Integer.valueOf(year);
    //    }
    //    try{
    //        expStart = expStart;
    //    }catch(Exception e){
    //        expStart = null;
    //    }
    //    return expStart;
    //}
}