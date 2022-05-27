public class AP02_LeadRules {
    /**************************************************************************************************
    -- - Author        : Spoon Consulting
    -- - Description   : Apex Class for Implementing Rules on Lead Insert
    --
    -- Maintenance History: 
    --
    -- Date         Name  Version  Remarks 
    -- -----------  ----  -------  -------------------------------------------------------
    -- 11-JAN-2018  RRAJ    1.0     Initial version
    -- 17-JAN-2019  ANA     1.1     W-459: Allow populating Lead family without Parent1FirstName
    -- 22-JAN-2019  ANA     1.1     Case 00001587 
    -- 07-MAR-2019  CRA     1.2     W-000344 : Change Day or Boarding fields value if the webform for Application Form send "Boarding" value
    -- 03-JUN-2019  CRA     1.3     W-000538: Auto populate Day/Boarding picklist fields following Day/Boarding checkbox for Web form
    -- 31-JUL-2019  CRA     1.4     Removed Sixth child Section - Application Form R2.0
    -- 23-AUG-2019  CRA     1.5     Case 00001911
    -- 16-OCT-2019  CRA     1.6     Case 00002055
    -- 08-JUL-2020  CRA     1.7     Case 00002440
	-- 02-OCT-2020	VJA		1.8		Case 00002604
	-- 12-OCT-2020	VJA		1.9		Case 00002653 Process Builder + APEX logic modified
    -- 03-NOV-2020  FKH     2.0     Added updatePickListOrigin
    -- 16-NOV-2020  VJA     2.1     Case 00002766 - Added "Facebook Lead Ad" to populateFields()
    -- 12-JAN-2021  VJA     2.2     Case 00002725 - Phone comment
    -- 18-01-2021   VJA     1.6     ###NDM_1 Lead record types 
    -- 29-01-2021   VJA     1.7     ###NDM_2 Lead record types -assignemnts 
    -- 16-FEB-2021  VJA     2.3     Case 00002813 - Enable automatic marketing fields check if child last name is filled
    -- 14-Mar-2021  VJA     2.4     CommentParent3
    -- 22-JUN-2021  VJA     2.5     Generate Company Name - Case 2529
    -- 24-FEB-2022  YRA     2.6     Do not populate APIModifiedDate field for Summer Camp Leads
    --------------------------------------------------------------------------------------
    ***************************************************************************************************/
    
        private static Map<String, Integer> mapMonthToInt = AP_Constant.getMonthToIntMap();
        private static Map<String,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject}); //VJA20210118 1.6 ###NDM_1

        /**
         * Method to update standard fields upon update on correspondint custom fields
         * @param lstNewLed List on newly updated leads
         */
        public static void updateFields(List<Lead> lstNewLed){ 
            for(Lead led: lstNewLed) {
                if(String.isNotBlank(led.Parent1Title__c)) led.Title = led.Parent1Title__c;
                if(String.isNotBlank(led.Parent1LastName__c))  led.LastName = led.Parent1LastName__c;
                if(String.isNotBlank(led.Parent1FirstName__c)) led.Firstname = led.Parent1FirstName__c;
                if(String.isNotBlank(led.Parent1PrimaryEmail__c)) led.Email = led.Parent1PrimaryEmail__c;
                if(String.isNotBlank(led.Parent1Nationality__c)) led.Nationality__c = led.Parent1Nationality__c;
                if(String.isNotBlank(led.Parent1CountryOfResidence__c)) led.Country_of_residence__c = led.Parent1CountryOfResidence__c;
                if(String.isNotBlank(led.Parent1HomePhone__c)) led.Phone = led.Parent1HomePhone__c;
                //if(String.isNotBlank(led.Parent1Street__c)) led.Street = led.Parent1Street__c;
                if(String.isNotBlank(led.Parent1Street__c+led.Parent1AddLine2__c+led.Parent1AddLine3__c)) led.Street = AP25_AccountRules.getAddress(led.Parent1Street__c,led.Parent1AddLine2__c,led.Parent1AddLine3__c);
                if(String.isNotBlank(led.Parent1City__c)) led.City = led.Parent1City__c;
                if(String.isNotBlank(led.Parent1State__c)) led.State = led.Parent1State__c;
                if(String.isNotBlank(led.Parent1ZipPostalCode__c)) led.PostalCode = led.Parent1ZipPostalCode__c;
                if(String.isNotBlank(led.Parent1CountryOfResidence__c)) led.Country = led.Parent1CountryOfResidence__c;

                //VJA20210622 - Case2529
                led.company = generateCompanyName(led);

                // if(String.isNotBlank(led.Parent1FirstName__c) && String.isNotBlank(led.Parent1LastName__c)){
                //     led.Company = led.Parent1FirstName__c + ' ' + led.Parent1LastName__c + ' ' + 'Family';
                // } else if(led.Parent1NatureOfRelationship__c == 'Agent' || led.Parent1NatureOfRelationship__c == 'Child'){	//ANA20191501 : W459
                //     led.Company = led.Parent1LastName__c + ' ' + 'Family';
                // }
                // else if(String.isNotBlank(led.Parent1LastName__c) && led.status == 'New'){
                //     led.Company = led.Parent1LastName__c + ' ' + 'Family';
                // }
            }
        }
    
        /**
         * Method to autopopulate fields on lead before insertine lead
         * Method Populates School of interest based on school code and viseversa
         * Method populates external id of lead based on field values
         * Method auto populates LastName an Company fields on lead as these standard fields are mandatory
         * @param lstNewLed List of newly inserted lists
         */
        public static void populateFields(List<Lead> lstNewLed){
            Set<String> schCodeSet = new Set<String>(); // set of all school codes
            Set<Id> schIdSet = new Set<Id>(); // set of all shcool ids of leads
            Set<String> externalIdSet = new Set<String>(); // stores all external Ids of incoming leads
            //akshaye 2020
        	Set<String> ldIdSet = new Set<String>(); // stores all  Ids of incoming leads
            Set<String> existingExternalIdSet = new Set<String>(); // stores all EXISTING external Ids of incoming leads
            Map<Id,School__c> schIdSchoolMap = new Map<Id,School__c>(); // map of school id to school
            Map<String,School__c> schCodeSchoolMap = new Map<String,School__c>(); // map of school code to school
            Map<Id, School__c> schIdSchoolAdmEmailMap = new Map<Id,School__c>(); // CRA store all Admissions queue email school 
    
            for(Lead led : lstNewLed){
                //rules for leads to autoconvert
                if(led.AutoConvert__c){
                    led.isExternalSource__c = true;
                }
                led.LeadOrigins__c = led.LeadOrigins__c == null ? led.Lead_Origin__c : led.LeadOrigins__c; //CRA20200708 - Case 00002440s

                //Rules for leads coming from webform
                //VJA20201116: Case 00002766
                if(led.Lead_Origin__c == AP_Constant.ledOriginAdmissionsStage1 || led.Lead_Origin__c == AP_Constant.ledOriginAdmissionsStage2 || led.Lead_Origin__c == AP_Constant.ledOriginApplication || led.Lead_Origin__c == 'PPC Campaign' || led.Lead_Origin__c == 'Facebook Lead Ad' || led.Lead_Origin__c == AP_Constant.ledBaiduPPC){
                    led.LeadSource = led.LeadSource == null ? AP_Constant.ledSrcOnline : led.LeadSource; //rraj added to set lead source of lead from webform - CRA20191014: Case 00002055
                    led.Send_Acknowledgement__c = true; //RRAJ added to default send acknowledgement flag to true for all leads sent from webform
                    led.isExternalSource__c = true;
                    led.LeadMethod__c = led.LeadMethod__c == null ? AP_Constant.ledMethodWeb : led.LeadMethod__c;	//ANA20190122: Case 00001587 
    
                    //VJA20210118 1.6 ###NDM_1 //Record type check to skip if statement block. Meant only for block lead
                    if(led.RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) || led.RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeEnrolment)){
                        
                        if(String.isBlank(led.Parent1Company__c) && String.isNotBlank(led.Company)){
                            led.Company = null; // set company to null as company is populated with family name later
                        }
        
                        //set expected start date of children based on expected start month and expected start year
                        if(String.isNotBlank(led.ExpectedStartYear__c) && String.isNotBlank(led.ExpectedStartMonth__c)){
                            Date expStartDate = generateStartDate(led.ExpectedStartMonth__c, led.ExpectedStartYear__c);
        
                            if(String.isNotBlank(led.Number_of_Children__c) ){
                                if(Integer.valueOf(led.Number_of_children__c) > 0){
                                    if(led.EnrollmentDateFirstChild__c == null) led.EnrollmentDateFirstChild__c = expStartDate;
                                    led.ExpectedStartMonthFirstChild__c = led.ExpectedStartMonth__c;
                                    led.ExpectedStartYearFirstChild__c = led.ExpectedStartYear__c;
                                    led.MarketingQualifiedFirstChild__c = true;
								}
                                if(Integer.valueOf(led.Number_of_children__c) > 1){
                                    if(led.EnrollmentDateSecondChild__c == null) led.EnrollmentDateSecondChild__c  = expStartDate;
                                    led.ExpectedStartMonthSecondChild__c = led.ExpectedStartMonth__c;
                                    led.ExpectedStartYearSecondChild__c = led.ExpectedStartYear__c;
                                    led.MarketingQualifiedSecondChild__c = true;
                                }
                                if(Integer.valueOf(led.Number_of_children__c) > 2){
                                    if(led.EnrollmentDateThirdChild__c == null) led.EnrollmentDateThirdChild__c = expStartDate;
                                    led.ExpectedStartMonthThirdChild__c = led.ExpectedStartMonth__c;
                                    led.ExpectedStartYearThirdChild__c = led.ExpectedStartYear__c;
                                    led.MarketingQualifiedThirdChild__c = true;
                                }
                                if(Integer.valueOf(led.Number_of_children__c) > 3){
                                    if(led.EnrollmentDateFourthChild__c == null) led.EnrollmentDateFourthChild__c = expStartDate;
                                    //VJA led.ExpectedStartMonthFourthChild__c = led.ExpectedStartMonth__c;
                                    //VJA led.ExpectedStartYearFourthChild__c = led.ExpectedStartYear__c;
                                    led.MarketingQualifiedFourthChild__c = true;
                                }
                                if(Integer.valueOf(led.Number_of_children__c) > 4){
                                    if(led.EnrollmentDateFifthChild__c == null) led.EnrollmentDateFifthChild__c = expStartDate;
                                    //VJA led.ExpectedStartMonthFifthChild__c = led.ExpectedStartMonth__c;
                                    //VJA led.ExpectedStartYearFifthChild__c = led.ExpectedStartYear__c;
                                    led.MarketingQualifiedFifthChild__c = true;
                                }
                            }
                        }
                        //CRA20190307 - W000344 - Change Day or Boarding value to "Boarding Day" if the webform for Application Form send "Boarding" value
                        if(led.Lead_Origin__c == AP_Constant.ledOriginApplication) {
                            led.DayOrBoardingSchoolFirstChild__c = led.DayOrBoardingSchoolFirstChild__c == AP_Constant.ledBoarding ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolFirstChild__c;
                            led.DayOrBoardingSchoolSecondChild__c = led.DayOrBoardingSchoolSecondChild__c == AP_Constant.ledBoarding ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolSecondChild__c;
                            led.DayOrBoardingSchoolThirdChild__c = led.DayOrBoardingSchoolThirdChild__c == AP_Constant.ledBoarding ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolThirdChild__c;
                            led.DayOrBoardingSchoolFourthChild__c = led.DayOrBoardingSchoolFourthChild__c == AP_Constant.ledBoarding ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolFourthChild__c;
                            led.DayOrBoardingSchoolFifthChild__c = led.DayOrBoardingSchoolFifthChild__c == AP_Constant.ledBoarding ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolFifthChild__c;        
                        }
                        //CRA20190503 - W000538
                        if(led.Interested_in_boarding_school__c) {
                                led.DayOrBoardingSchoolFirstChild__c = led.DayOrBoardingSchoolFirstChild__c == null ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolFirstChild__c;
                                led.DayOrBoardingSchoolSecondChild__c = led.DayOrBoardingSchoolSecondChild__c == null ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolSecondChild__c;
                                led.DayOrBoardingSchoolThirdChild__c = led.DayOrBoardingSchoolThirdChild__c == null ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolThirdChild__c;
                                led.DayOrBoardingSchoolFourthChild__c = led.DayOrBoardingSchoolFourthChild__c == null ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolFourthChild__c;
                                led.DayOrBoardingSchoolFifthChild__c = led.DayOrBoardingSchoolFifthChild__c == null ? AP_Constant.ledBoardingDayBoarding : led.DayOrBoardingSchoolFifthChild__c;                        
                        }
                        else {
                            schIdSet.add(led.SchoolOfInterest__c);
                        }
                    }else if(led.RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeIndividualChildEnrolmentLead)){ //VJA20210129 1.6 ###NDM_2
                        System.debug('###AP02: Assignment for Individual Child Lead RT - 1');
                        if(led.Lead_Origin__c == AP_Constant.ledOriginApplication) {
                            led.Child_DayOrBoardingSchool__c = led.Child_DayOrBoardingSchool__c == AP_Constant.ledBoarding ? AP_Constant.ledBoardingDayBoarding : led.Child_DayOrBoardingSchool__c;
                        }

                        if(led.Interested_in_boarding_school__c) {
                            led.Child_DayOrBoardingSchool__c = led.Child_DayOrBoardingSchool__c == null ? AP_Constant.ledBoardingDayBoarding : led.Child_DayOrBoardingSchool__c;
                        }else {
                            schIdSet.add(led.SchoolOfInterest__c);
                        }
                    }
                }


                //VJA20210118 1.6 ###NDM_1 //Record type check to skip if statement block. Meant only for block lead
                if(led.RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) || led.RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeEnrolment)){
                    //populate parent fields necessary for lead conversion
                    if(String.isBlank(led.Parent1Title__c) && String.isNotBlank(led.Title)) led.Parent1Title__c = led.Title;
                    if(String.isBlank(led.Parent1FirstName__c) && String.isNotBlank(led.Firstname)) led.Parent1FirstName__c = led.Firstname; 
                    if(String.isBlank(led.Parent1LastName__c) && String.isNotBlank(led.Lastname))led.Parent1LastName__c = led.Lastname;
                    if(String.isBlank(led.Parent1PrimaryEmail__c) && String.isNotBlank(led.Email)) led.Parent1PrimaryEmail__c = led.Email;
                    if(String.isBlank(led.Parent1Nationality__c) && String.isNotBlank(led.Nationality__c)) led.Parent1Nationality__c = led.Nationality__c;
                    if(String.isBlank(led.Parent1CountryOfResidence__c) && String.isNotBlank(led.Country_of_residence__c)) led.Parent1CountryOfResidence__c = led.Country_of_residence__c;
                    if(String.isBlank(led.Parent1HomePhone__c) && String.isNotBlank(led.Phone)){ //VJA20210112: Case 00002725
                        led.Parent1HomePhone__c = led.Phone;
                        led.Phone = null;	
                    }
                    if(String.isBlank(led.Parent1WeChatId__c) && String.isNotBlank(led.WeChatExternalID__c)) led.Parent1WeChatId__c = led.WeChatExternalID__c;
                    if(String.isBlank(led.Parent1WeChatId__c) && String.isNotBlank(led.WeChat__c)) led.Parent1WeChatId__c = led.WeChat__c;

                }else{
                    System.debug('###AP02: Skipped block 2');
                }
    
                //populate lead firstname, lastname, email as these fields are required
                //populate fields from required for conversion and lead creation
                if(String.isBlank(led.Title) && String.isNotBlank(led.Parent1Title__c)) led.Title = led.Parent1Title__c;
                if(String.isBlank(led.LastName) && String.isNotBlank(led.Parent1LastName__c))  led.LastName = led.Parent1LastName__c;
                if(String.isBlank(led.Firstname) &&  String.isNotBlank(led.Parent1FirstName__c)) led.Firstname = led.Parent1FirstName__c;
                if(String.isBlank(led.Email) && String.isNotBlank(led.Parent1PrimaryEmail__c)) led.Email = led.Parent1PrimaryEmail__c;
                if(String.isBlank(led.Nationality__c) && String.isNotBlank(led.Parent1Nationality__c)) led.Nationality__c = led.Parent1Nationality__c;
                if(String.isBlank(led.Country_of_residence__c) && String.isNotBlank(led.Parent1CountryOfResidence__c)) led.Country_of_residence__c = led.Parent1CountryOfResidence__c;
                if(String.isBlank(led.Phone) && String.isNotBlank(led.Parent1HomePhone__c)) led.Phone = led.Parent1HomePhone__c;
                if(String.isBlank(led.WeChatUserId__c) && String.isNotBlank(led.WeChat__c)) led.WeChatUserId__c = led.WeChat__c;
                if(String.isBlank(led.Parent1WeChatId__c) && String.isNotBlank(led.WeChat__c)) led.Parent1WeChatId__c = led.WeChat__c;
    
                //VJA20210622 - Case2529
                led.company = generateCompanyName(led);

                //Set company family name of lead as company name is for family account name during conversion
                // if(String.isBlank(led.Company) && String.isNotBlank(led.Parent1FirstName__c) && String.isNotBlank(led.Parent1LastName__c)){
                //     led.Company = led.Parent1FirstName__c + ' ' + led.Parent1LastName__c + ' ' + 'Family';
                // }else if(led.Parent1NatureOfRelationship__c == 'Agent' || led.Parent1NatureOfRelationship__c == 'Child'){
                //     led.Company = led.Parent1LastName__c + ' ' + 'Family';	//ANA20191501 : W459
                // }
                // else if(String.isNotBlank(led.Parent1LastName__c) && led.status == 'New'){
                //     led.Company = led.Parent1LastName__c + ' ' + 'Family';
                // }
    
                if(led.Address == null) {
                    if(String.isNotBlank(led.Parent1Street__c+led.Parent1AddLine2__c+led.Parent1AddLine3__c)) {
                        led.Street = AP25_AccountRules.getAddress(led.Parent1Street__c,led.Parent1AddLine2__c,led.Parent1AddLine3__c);
                    }
    
                    if(String.isNotBlank(led.Parent1City__c)) {
                        led.City = led.Parent1City__c;
                    }
    
                    if(String.isNotBlank(led.Parent1State__c)) {
                        led.State = led.Parent1State__c;
                    }
    
                    if(String.isNotBlank(led.Parent1ZipPostalCode__c)) {
                        led.PostalCode = led.Parent1ZipPostalCode__c;
                    }
    
                    if(String.isNotBlank(led.Parent1CountryOfResidence__c)) {
                        led.Country = led.Parent1CountryOfResidence__c;
                    }
                }
    
                //build mapping of school code and school id to populate school code/school of interest on lead
                if(String.isNotEmpty(led.SchoolOfInterest__c) && String.isEmpty(led.School_Code__c)) schIdSet.add(led.SchoolOfInterest__c);
                if(String.isEmpty(led.SchoolOfInterest__c) && String.isNotEmpty(led.School_Code__c)) schCodeSet.add(led.School_Code__c);
            }
        
            if (schCodeSet.size()>0 || schIdSet.size()>0){
                for (School__c sc : [SELECT Id, SchoolCode__c,  AdmissionsQueueCoordinator__r.Email, DayBoarding__c FROM School__c WHERE Id IN :schIdSet OR SchoolCode__c IN :schCodeSet]){
                    schIdSchoolMap.put(sc.Id, sc);
                    schCodeSchoolMap.put(sc.SchoolCode__c, sc);
                }
            }
            
            for(Lead led : lstNewLed){ //CRA20200427 - Case 00002325
                if (String.isEmpty(led.School_Code__c) && led.SchoolOfInterest__c!=null && schIdSchoolMap.containsKey(led.SchoolOfInterest__c)) led.School_Code__c = schIdSchoolMap.get(led.SchoolOfInterest__c).SchoolCode__c;
                if (String.isNotEmpty(led.School_Code__c) && led.SchoolOfInterest__c==null && schCodeSchoolMap.containsKey(led.School_Code__c)) led.SchoolOfInterest__c = schCodeSchoolMap.get(led.School_Code__c).Id;
                
                //setting externalId of lead
                if(led.Lead_Origin__c != AP_Constant.ledOriginApplication && led.ExternalId__c == null) {
                   led.ExternalId__c = generateExternalId(led);
                }
                
                ldIdSet.add(led.Id); //akshaye 2020
                externalIdSet.add(led.ExternalId__c);  
                
                //CRA20190823 - Case00001911 //VJA20201116: Case 00002766
                if((led.Lead_Origin__c == AP_Constant.ledOriginAdmissionsStage1 || led.Lead_Origin__c == AP_Constant.ledOriginAdmissionsStage2  || led.Lead_Origin__c == AP_Constant.ledOriginApplication || led.Lead_Origin__c == 'PPC Campaign' || led.Lead_Origin__c == 'Facebook Lead Ad' || led.Lead_Origin__c == AP_Constant.ledBaiduPPC) && !led.Interested_in_boarding_school__c && String.isNotEmpty(led.School_Code__c) && led.SchoolOfInterest__c!=null) {
                    String leadBoarding;
    
                    if(schIdSchoolMap.get(led.SchoolOfInterest__c).DayBoarding__c == AP_Constant.ledBoarding) {
                        leadBoarding = AP_Constant.ledBoardingDayBoarding;
                    }
                    else if(schIdSchoolMap.get(led.SchoolOfInterest__c).DayBoarding__c == AP_Constant.ledBoardingDay) {
                        leadBoarding = AP_Constant.ledBoardingDay;
                    }
    
                    if (String.isNotBlank(leadBoarding)) {
                        //VJA20210118 1.6 ###NDM_1 //Record type check to skip if statement block. Meant only for block lead
                        if(led.RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) || led.RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeEnrolment)){
                            System.debug('###AP02: School Check Block Lead');
                            led.DayOrBoardingSchoolFirstChild__c = led.DayOrBoardingSchoolFirstChild__c == null ? leadBoarding : led.DayOrBoardingSchoolFirstChild__c;
                            led.DayOrBoardingSchoolSecondChild__c = led.DayOrBoardingSchoolSecondChild__c == null ? leadBoarding : led.DayOrBoardingSchoolSecondChild__c;
                            led.DayOrBoardingSchoolThirdChild__c = led.DayOrBoardingSchoolThirdChild__c == null ? leadBoarding : led.DayOrBoardingSchoolThirdChild__c;
                            led.DayOrBoardingSchoolFourthChild__c = led.DayOrBoardingSchoolFourthChild__c == null ? leadBoarding : led.DayOrBoardingSchoolFourthChild__c;
                            led.DayOrBoardingSchoolFifthChild__c = led.DayOrBoardingSchoolFifthChild__c == null ? leadBoarding : led.DayOrBoardingSchoolFifthChild__c;          
                        } 
                        else if(led.RecordTypeId == mapRecordType.get(AP_Constant.ledRecordTypeIndividualChildEnrolmentLead)){ //VJA20210129 1.6 ###NDM_2
                            System.debug('###AP02: School Check Individual Lead');
                            led.Child_DayOrBoardingSchool__c = led.Child_DayOrBoardingSchool__c == null ? leadBoarding : led.Child_DayOrBoardingSchool__c;
                        } 
                    }
                }
            }
            
            //VJA 02-10-2020 CASE2604 //VJA 20-10-2020 CASE2681
            for (Lead led : [SELECT Id, ExternalId__c FROM Lead WHERE ExternalId__c IN :externalIdSet]){
                existingExternalIdSet.add(led.ExternalId__c);
            }

            //Before Insert
            //YRA 24-02-2022 Case 4524
            for (Lead led : lstNewLed){
                if(led.RecordTypeId != mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts) && existingExternalIdSet.contains(led.ExternalId__c) && led.ExternalId__c!= null && led.id == null){
                    led.APIModifiedDate__c = DateTime.now();
                }
            }

            //Before Update
            for(Lead led : lstNewLed) {
                if (existingExternalIdSet.contains(led.ExternalId__c) && led.id != null && led.APIModifiedDate__c != null){
                    led.APIModifiedDate__c = DateTime.now();
                }
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
    
        /**
         * [generateStartDate description]
         * @param  month [description]
         * @param  year  [description]
         * @return       [description]
         */
        public static Date generateStartDate(String month, String year){
            month = month.trim();
            year = year.trim();
            
            Integer yearInt;
            Integer monthInt;
            Date expStart;
            
            if(month.equalsIgnoreCase(AP_Constant.ledExpStartYearNotSure) || year.equalsIgnoreCase(AP_Constant.ledExpStartYearNotSure) || month == '' || year == ''){
                return null;
            }else{
                monthInt = mapMonthToInt.get(month);
                yearInt = Integer.valueOf(year);
            }
            try{
                expStart = Date.newInstance(yearInt, monthInt, 1);
            }catch(Exception e){
                expStart = null;
            }
            return expStart;
        }
        
        public static void updateSchool(List<Lead> lstLeadToUpdate, Set<id> setOwnerId){
            map<id, string> mapUid_SchCode = new map<id, string>();
            set<string> setSchCode = new set<string>();
            map<string, id> mapSchId_SchCOde = new map<string, id>();
            
            for(User u : [Select id, SchoolCode__c from user where id in:setOwnerId ]){
                if(u.SchoolCode__c != null){
                    mapUid_SchCode.put(u.id, u.SchoolCode__c);
                    setSchCode.add(u.SchoolCode__c);
                }
            }
            
            for(School__c sch : [ Select id, SchoolCode__c from school__c where SchoolCode__c in: setSchCode]){
                if(sch.SchoolCode__c != null){
                    mapSchId_SchCOde.put(sch.SchoolCode__c, sch.id);
                }
            }
            
            for(Lead lead : lstLeadToUpdate){
                if(mapUid_SchCode.containskey(lead.ownerid) && mapSchId_SchCOde.containskey(mapUid_SchCode.get(lead.ownerid))){
                    lead.SchoolOfInterest__c = mapSchId_SchCOde.get(mapUid_SchCode.get(lead.ownerid));
                }
            }
            //testafoTo to be place in another class
        }

        // Used in Lead trigger handler to update the lead origins picklist values and keep the initial lead origin value 
        public static void updatePickListOrigin(List<Lead> lstOldLead, List<Lead> lstNewLead){
            List<Lead> lstUpdatedLead = new List<Lead>();
            String newPicklist;
            for(Integer i = 0; i < lstNewLead.size(); i++){
                if (lstNewLead[i].Lead_Origin__c !=null ){ //cater when setting the lead origin blank
                    if(lstOldLead[i].LeadOrigins__c == null || !(lstOldLead[i].LeadOrigins__c.contains(lstNewLead[i].Lead_Origin__c))){ // if lead origin created - null or has value
                        lstNewLead[i].LeadOrigins__c = lstOldLead[i].LeadOrigins__c != null? lstOldLead[i].LeadOrigins__c + ';' + lstNewLead[i].Lead_Origin__c : lstNewLead[i].LeadOrigins__c; // if not null = 
                    }
                }
                lstNewLead[i].Lead_Origin__c = (lstOldLead[i].Lead_Origin__c==null) ? lstNewLead[i].Lead_Origin__c:  lstOldLead[i].Lead_Origin__c; //resetting new value with original value				
            } 
        }

        //VJA20210216 - Case 00002813
        /**
         * Set marketing field to true if insert or new child details added in update operation. Uncheck if child details removed
         * @param  lstOldLead [Old lead info]
         * @param  lstNewLead [New lead info]
         * @param  isInsert [disctinction between update and insert operation to check marketing fields]
         * @return void
         */
        public static void setChildrenMarketingFields(List<Lead> lstOldLead, List<Lead> lstNewLead, boolean isInsert){

            for(Integer i = 0; i < lstNewLead.size(); i++){ 
                lstNewLead[i].MarketingQualifiedFirstChild__c = (lstNewLead[i].LastNameFirstChild__c != null && lstOldLead[i].LastNameFirstChild__c == null) ? true : ((lstNewLead[i].LastNameFirstChild__c == null && lstOldLead[i].LastNameFirstChild__c != null) ? false : ((lstNewLead[i].LastNameFirstChild__c != null && lstOldLead[i].LastNameFirstChild__c != null && isInsert)  ? true : lstNewLead[i].MarketingQualifiedFirstChild__c));
                
                lstNewLead[i].MarketingQualifiedSecondChild__c = (lstNewLead[i].LastNameSecondChild__c != null && lstOldLead[i].LastNameSecondChild__c == null) ? true : ((lstNewLead[i].LastNameSecondChild__c == null && lstOldLead[i].LastNameSecondChild__c != null) ? false : ((lstNewLead[i].LastNameSecondChild__c != null && lstOldLead[i].LastNameSecondChild__c != null && isInsert)  ? true : lstNewLead[i].MarketingQualifiedSecondChild__c));
                
                lstNewLead[i].MarketingQualifiedThirdChild__c = (lstNewLead[i].LastNameThirdChild__c != null && lstOldLead[i].LastNameThirdChild__c == null) ? true : ((lstNewLead[i].LastNameThirdChild__c == null && lstOldLead[i].LastNameThirdChild__c != null) ? false : ((lstNewLead[i].LastNameThirdChild__c != null && lstOldLead[i].LastNameThirdChild__c != null && isInsert)  ? true : lstNewLead[i].MarketingQualifiedThirdChild__c));
                
                lstNewLead[i].MarketingQualifiedFourthChild__c = (lstNewLead[i].LastNameFourthChild__c != null && lstOldLead[i].LastNameFourthChild__c == null) ? true : ((lstNewLead[i].LastNameFourthChild__c == null && lstOldLead[i].LastNameFourthChild__c != null) ? false : ((lstNewLead[i].LastNameFourthChild__c != null && lstOldLead[i].LastNameFourthChild__c != null && isInsert)  ? true : lstNewLead[i].MarketingQualifiedFourthChild__c));
                
                lstNewLead[i].MarketingQualifiedFifthChild__c = (lstNewLead[i].LastNameFifthChild__c != null && lstOldLead[i].LastNameFifthChild__c == null) ? true : ((lstNewLead[i].LastNameFifthChild__c == null && lstOldLead[i].LastNameFifthChild__c != null) ? false : ((lstNewLead[i].LastNameFifthChild__c != null && lstOldLead[i].LastNameFifthChild__c != null && isInsert)  ? true : lstNewLead[i].MarketingQualifiedFifthChild__c));
            }
        }

        //VJA20210216 - Case 00002813
        /**
         * Method to generate company name w.r.t agent, child and contact1
         * @param  led -> Lead Record
         * @return String -> Lead Company Name
         */
        public static String generateCompanyName(Lead led){

            //Use Contact 2 Name or Child 1 Name to generate Company Name
            if(led.Parent1NatureOfRelationship__c == 'Agent' || led.Parent1NatureOfRelationship__c == 'Child'){

                if(String.isNotBlank(led.Parent2FirstName__c) && String.isNotBlank(led.Parent2LastName__c)){ //Contact 2 Full Name
                    led.Company = led.Parent2FirstName__c + ' ' + led.Parent2LastName__c + ' ' + 'Family';
                }else if(String.isNotBlank(led.FirstNameFirstChild__c) && String.isNotBlank(led.LastNameFirstChild__c)){ //Child 1 Full Name
                    led.Company = led.FirstNameFirstChild__c + ' ' + led.LastNameFirstChild__c + ' ' + 'Family';
                }else if(String.isNotBlank(led.Parent1LastName__c)){ //Contact 1 Last Name
                    led.Company = led.Parent1LastName__c + ' ' + 'Family';
                }

            //Use Contact 1 Name to generate Company Name
            }else if(String.isNotBlank(led.Parent1LastName__c)){

                if(String.isNotBlank(led.Parent1FirstName__c)){
                    led.Company = led.Parent1FirstName__c + ' ' + led.Parent1LastName__c + ' ' + 'Family';
                }else{
                    led.Company = led.Parent1LastName__c + ' ' + 'Family';
                }

            }

            return led.Company;
        }
}