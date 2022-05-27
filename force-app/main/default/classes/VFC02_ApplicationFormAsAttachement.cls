/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Controller class for VFC02_ApplicationFormAsAttachement to generate
                     an application form
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 12-DEC-2018  CRA   1.0     Initial Version[User Story: W-00344]
-- 28-JUN-2020  CRA   1.1     Case 00002322
-- 07-OCT-2020  FKH   1.2     Added Translation Portuguese
-- 04-JAN-2021  FKH   1.3     Case 2906 - Cater for CBL schools
-- 12-JAN-2021  FKH   1.4     Case 2927 - Cater for Dover Court School
-- 30-MAR-2021  FKH   1.5     Case 3201- Cater for BIS School
-- 11-JUN-2021  FKH   1.6     Case 3677 - specific cover format for schools similar to BIS (no white space)
-- 25-JUN-2021  FKH   1.7     Case 3194 - cater for San roberto requirements
-- 18-NOV-2021  YRA   1.8     Case 4198 - Cater for Oxford Schools (DOV,OIC,OSF)
-- 26-NOV-2021  FKH   1.9     Case 3947 - New requirements for ISR
-- 02-DEV-2021  FKH   2.0     Case 4452 - NDL School - cover image
-- 13-APR-2022  YRA   2.1     Case 3947 - ISR new requirements (max number of contacts set to 8 + query other fields from Account/Opp)
-- 21-APR-2022  YRA   2.2     Case 5098 - Cater for legal page in Spanish
--------------------------------------------------------------------------------------
**************************************************************************************/
public without sharing class VFC02_ApplicationFormAsAttachement {
    public integer noOfParents {get;set;} 
    public boolean hasFinancialContact {get;set;}
    public Contact theChild {get;set;}
    public Contact thePrimaryContact {get;set;}
    public String theSchoolOfInterest {get;set;}  
    public String schoolCode {get;set;}  
    public Map<String,List<Contact>> thefamily {get;set;}
    public Account theAcc {get;set;}
    public integer noOfChilds {get;set;}
    public Map<Id,Opportunity> theOpportunities {get;set;}
    public Opportunity theOppToSend {get;set;}
    public Map<String, String> mapAPILabel {get;set;}
    public String fieldsNotVisible {get;set;}
    public Opportunity oppForLegalPage {get;set;}
    public boolean isGenManual {get;set;}
    public String lang {get;set;}
    public String medicalTermsConditions {get;set;}
    public String privacyPolicy {get;set;}
    public String termsAndConditions {get;set;}
    public String childPhotoDisclaimer {get;set;}
    public boolean isAppForm {get;set;}
    public boolean isCBLSchool {get;set;} //fkh Case 2906
    public boolean isBISSchool {get;set;} //fkh Case 3677
    public List<String> lstBISSchools {get;set;} //fkh Case 3677
    public boolean isMadridSchool {get;set;} //San Roberto FKH - Case 3394
    public boolean isMadridSchoolESpdf {get;set;} //San Roberto FKH - Case 3394: display text in Espanol
    public List<String> lstTARegionSpecificchools {get;set;} //fkh Case 3877
    public boolean isTARegionSchool {get;set;} //fkh Case 3877
    public boolean isOxfordSchool {get;set;} //YRA Case 4198
    public List<String> lstOxfordSchools {get;set;} //YRA Case 4198
    public boolean isDalianSchool {get;set;} // Case 4452 FKH
    public List<String> lstDalianSchools {get;set;} //FKH Case 4452
    public List<String> lstNatureOfRelationship {get;set;} //YRA Case 5098


    public boolean init {
        get{
            init();
            return false;
        }
    }

    public VFC02_ApplicationFormAsAttachement() {
        theChild=thePrimaryContact=new Contact();
        hasFinancialContact=false;theSchoolOfInterest='';
        thefamily = new Map<String, List<Contact>> {'FinancialContact' => new List<Contact>(), 
                                                     'PrimaryContact' => new List<Contact>(), 
                                                     'ParentContact' => new List<Contact>(),
                                                     'ChildContact' => new List<Contact>(),
                                                     'allParents' => new List<Contact>(),
                                                     'onlyParents' => new List<Contact>()};

        theOpportunities=new Map<Id,Opportunity> ();
        mapAPILabel = new Map<String, String> ();
        isAppForm = false;
     }

    /**
     * [Requirements for specific schools ]
     * Cater for additional requirements for different schools  [description]
     */
   public void RequirementsForSpecificSchools() {
        isCBLSchool=false;
        isMadridSchool=false; 
        isMadridSchoolESpdf=false;
        lstBISSchools = new list<String>{'BIS','BIH', 'JKT','BKL','BST'}; //FKH Case 3677 - specific cover format for schools similar to BIS
        isTARegionSchool=false;
        lstTARegionSpecificchools = new list<String>{'VIL','WPS', 'NBP'}; //FKH Case 3877 - new questions for TA school
        isOxfordSchool=false;
        lstOxfordSchools= new list<String>{'DOV','OIC','OSF'};
        lstDalianSchools= new list<String>{'NDL'};
        isDalianSchool=false;
        //Check if CBL school
            if((theAcc!=null && theAcc.SchoolOfInterest__r.Sub_Region__c=='CBL' &&  theAcc.SchoolOfInterest__r.Bilingual__c=='Chinese' &&  (theAcc.TECH_ApplicationFormLang__c==null || theAcc.TECH_ApplicationFormLang__c=='zh')) || (theOppToSend!=null && theOppToSend.SchoolOfInterest__r.Sub_Region__c=='CBL' &&  theOppToSend.SchoolOfInterest__r.Bilingual__c=='Chinese' &&  (theOppToSend.Account.TECH_ApplicationFormLang__c==null || theOppToSend.Account.TECH_ApplicationFormLang__c=='zh'))){
                isCBLSchool = true;
                mapAPILabel.put('Child_LastName',mapAPILabel.get('Child_LastName_CBL')); // put translated label value into Child_LastName & Child_FirstName - FKH Case 2906
                mapAPILabel.put('Child_FirstName',mapAPILabel.get('Child_FirstName_CBL'));
            }
            //Check if Dubai School before putting translated label value into EducationSupportNeeded__c - FKH Case 2918 
            if( lang == 'en_US' && ((theAcc!=null && theAcc.SchoolOfInterest__r.SchoolCode__c=='NDB') || ( theOppToSend!=null && theOppToSend.SchoolOfInterest__r.SchoolCode__c=='NDB'))){
                mapAPILabel.put('EducationSupportNeeded__c',mapAPILabel.get('EducationSupportNeeded__c_NDB'));
            }
            //Check if Dover Court school - FKH Case 2927
            if( lang == 'en_US' && ((theAcc!=null && theAcc.SchoolOfInterest__r.SchoolCode__c=='DPS') || ( theOppToSend!=null && theOppToSend.SchoolOfInterest__r.SchoolCode__c=='DPS'))){
                mapAPILabel.put('Parent_1_child_enrolled__c',mapAPILabel.get('Parent_1_child_enrolled__c_DPS'));
            }
            //FKH - Case 3677 check if school is similar to BIS 
            if((theAcc!=null && lstBISSchools.Contains(theAcc.SchoolOfInterest__r.SchoolCode__c)) || ( theOppToSend!=null && lstBISSchools.Contains(theOppToSend.SchoolOfInterest__r.SchoolCode__c))){
                isBISSchool = true;
            }
            //FKH Case 3877
            if((theAcc!=null && lstTARegionSpecificchools.Contains(theAcc.SchoolOfInterest__r.SchoolCode__c)) || ( theOppToSend!=null && lstTARegionSpecificchools.Contains(theOppToSend.SchoolOfInterest__r.SchoolCode__c))){
                isTARegionSchool = true;
            }
            //YRA Case 4208
            if((theAcc!=null && lstOxfordSchools.Contains(theAcc.SchoolOfInterest__r.SchoolCode__c)) || ( theOppToSend!=null && lstOxfordSchools.Contains(theOppToSend.SchoolOfInterest__r.SchoolCode__c))){
                isOxfordSchool = true;
            }
       		// Case 4452 FKH
            if((theAcc!=null && lstDalianSchools.Contains(theAcc.SchoolOfInterest__r.SchoolCode__c)) || ( theOppToSend!=null && lstDalianSchools.Contains(theOppToSend.SchoolOfInterest__r.SchoolCode__c))){
            	isDalianSchool = true; 
        	}
            if((theAcc!=null && theAcc.SchoolOfInterest__r.schoolcode__c=='ISR') ||   (theOppToSend!=null && theOppToSend.SchoolOfInterest__r.schoolcode__c=='ISR')){ //case 3947 FKH
                isMadridSchool = true;  //FKH Case 3194
                isMadridSchoolESpdf = (lang=='es') ? true: false;
                mapAPILabel.put('FrenchProficiencySpoken__c',mapAPILabel.get('SpanishProficiencySpoken__c')); // put translated label value into Child_LastName & Child_FirstName - FKH Case 2906
                mapAPILabel.put('FrenchProficiencyWritten__c',mapAPILabel.get('SpanishProficiencyWritten__c')); // put translated label value into Child_LastName & Child_FirstName - FKH Case 2906
            }else{
                //get all parents and add into onlyparents for non ISR Schools
                thefamily.put('onlyParents', thefamily.get('allParents')); //Case 3947 - FKH Cater for signature part last page of PDF 
            }
        }

     public void init() {
        lstNatureOfRelationship= new list<String>{'Father','Padre','Mother', 'Madre'}; //YRA Case 5098

        if(theAcc != null) { //check if the PDF is generated in Account level
            List<Account> lstAcc = [SELECT id
                                            ,SchoolOfInterest__r.Name
                                            ,SchoolOfInterest__r.SchoolCode__c
                                            ,SchoolOfInterest__r.MedicalTermsConditions__c
                                            ,SchoolOfInterest__r.MedicalTermsConditionsBilingual__c
                                            ,SchoolOfInterest__r.ChildPhotoDisclaimer__c
                                            ,SchoolOfInterest__r.AuthorizationParticipateSchoolTrips__c
                                            ,SchoolOfInterest__r.PrivacyPolicy__c
                                            ,SchoolOfInterest__r.PrivacyPolicyBilingual__c
                                            ,SchoolOfInterest__r.TermsAndConditions__c 
                                            ,SchoolOfInterest__r.TermsAndConditionsBilingual__c 
                                            ,SchoolOfInterest__r.ChildPhotoDisclaimerBilingual__c 
                                            ,SchoolOfInterest__r.PermissionToSubmitLetter__c 
                                            ,SchoolOfInterest__r.Bilingual__c
                                            ,SchoolOfInterest__r.PDFFieldVisibility__c
                                            ,SchoolOfInterest__r.Sub_Region__c
                                            ,NumberOfChildren__c
                                            ,TECH_ApplicationFormLang__c
                                            ,Referrer_Family_1_Name__c
                                            ,Referrer_Family_1_Email__c
                                            ,Referrer_Family_1_Phone_Number__c
                                            ,Referrer_Family_2_Name__c
                                            ,Referrer_Family_2_Email__c
                                            ,Referrer_Family_2_Phone_Number__c
                                    FROM Account WHERE id =: theAcc.Id];
            if(lstAcc.size() > 0) {
                theAcc = lstAcc[0];
                
                //get the translated labels and lang value
                getLabelMapping(String.isNotBlank(theAcc.TECH_ApplicationFormLang__c) ? theAcc.TECH_ApplicationFormLang__c : theAcc.SchoolOfInterest__r.Bilingual__c);
                fieldsNotVisible = theAcc.SchoolOfInterest__r.PDFFieldVisibility__c ;

                //set all T&C fields
                medicalTermsConditions = lang.equals('en_US')  ?  theAcc.SchoolOfInterest__r.MedicalTermsConditions__c : theAcc.SchoolOfInterest__r.MedicalTermsConditionsBilingual__c;
                privacyPolicy = lang.equals('en_US') ?  theAcc.SchoolOfInterest__r.PrivacyPolicy__c : theAcc.SchoolOfInterest__r.PrivacyPolicyBilingual__c;
                termsAndConditions = lang.equals('en_US') ?  theAcc.SchoolOfInterest__r.TermsAndConditions__c : theAcc.SchoolOfInterest__r.TermsAndConditionsBilingual__c;
                childPhotoDisclaimer = lang.equals('en_US') ?  theAcc.SchoolOfInterest__r.ChildPhotoDisclaimer__c : theAcc.SchoolOfInterest__r.ChildPhotoDisclaimerBilingual__c;
                
                getSchoolOfInterest(theAcc.SchoolOfInterest__r.SchoolCode__c); //get the name of the static resource related to school 
                List<Opportunity> lstOpp = getListOpportunity(theAcc.Id, null);  //get all opportunities of the account         

                if(lstOpp.size() > 0) {
                    Set<Id> setAccId = new Set<Id>();
                    for(Opportunity opp : lstOpp) {
                        if(opp.AccountId != null) {setAccId.add(opp.AccountId);}
                        if(opp.Account.FinancialContact__c != null) {setAccId.add(opp.Account.FinancialContact__c);}
                        if(opp.Account.PrimaryContact__c != null) {setAccId.add(opp.Account.PrimaryContact__c);}
                        //setAccId.addAll(new Set<Id>{opp.AccountId,opp.Account.FinancialContact__c,opp.Account.PrimaryContact__c});
                         if (opp.Account.OnlineApplication__c && !isAppForm) { //CRA20200601 - Case 2322
                            isAppForm = true;
                        }
                    }
                    
                    List<Contact> lstCon = getListContact(setAccId); //get contact list related to the opportunities
                    if(thefamily.get('ParentContact').size() < 1 && thefamily.get('ChildContact').size() < 1) {
                        for(Opportunity opp : lstOpp) {
                            getFamily(lstCon, opp); //generate the family
                        }
                        
                        Set<Contact> uniqueParentContacts = new Set<Contact>(); //merge primary  contact with parents
                        uniqueParentContacts.addAll(thefamily.get('PrimaryContact'));
                        uniqueParentContacts.addAll(thefamily.get('ParentContact'));
                        for(Contact contactToAdd :uniqueParentContacts){ //only 3 parents allowed
                            if(thefamily.get('allParents').size()<3 && theAcc.SchoolOfInterest__r.schoolcode__c!='ISR')
                            thefamily.get('allParents').add(contactToAdd);
                        else if(thefamily.get('allParents').size()<8 && theAcc.SchoolOfInterest__r.schoolcode__c=='ISR') //FKH Case 3194
                            thefamily.get('allParents').add(contactToAdd);
                    }
                    }
                    oppForLegalPage = lstOpp[0];
                    noOfParents = thefamily.get('allParents').size(); //get number of parents in the family
                    if(noOfParents > 0){ //get the primary contact in the family
                       thePrimaryContact = thefamily.get('allParents')[0];
                    } 
                    noOfChilds = thefamily.get('ChildContact').size();  //get number of children in the family
                }
            }
        }
        
        if(theOppToSend != null) { //check if the PDF is generated in Opportunity level
            List<Opportunity> lstOpp =  getListOpportunity(null, theOppToSend.Id); //initialize opportunity record
            if(lstOpp.size() > 0) {
                theOppToSend = lstOpp[0];
                oppForLegalPage = lstOpp[0];

                //get the translated labels and lang value
                getLabelMapping(String.isNotBlank(theOppToSend.Account.TECH_ApplicationFormLang__c) ? theOppToSend.Account.TECH_ApplicationFormLang__c : theOppToSend.SchoolOfInterest__r.Bilingual__c);                
                
                fieldsNotVisible = theOppToSend.SchoolOfInterest__r.PDFFieldVisibility__c ; //get list of fields to hide

                //set all T&C fields
                medicalTermsConditions = lang.equals('en_US') ?  theOppToSend.SchoolOfInterest__r.MedicalTermsConditions__c : theOppToSend.SchoolOfInterest__r.MedicalTermsConditionsBilingual__c;
                privacyPolicy = lang.equals('en_US') ?  theOppToSend.SchoolOfInterest__r.PrivacyPolicy__c : theOppToSend.SchoolOfInterest__r.PrivacyPolicyBilingual__c;
                termsAndConditions = lang.equals('en_US') ?  theOppToSend.SchoolOfInterest__r.TermsAndConditions__c : theOppToSend.SchoolOfInterest__r.TermsAndConditionsBilingual__c;
                childPhotoDisclaimer = lang.equals('en_US') ?  theOppToSend.SchoolOfInterest__r.ChildPhotoDisclaimer__c : theOppToSend.SchoolOfInterest__r.ChildPhotoDisclaimerBilingual__c;
                
                getSchoolOfInterest(theOppToSend.SchoolOfInterest__r.SchoolCode__c); //get the name of the static resource related to school 

                Set<Id> setOppAccId = new Set<Id>();
                if(theOppToSend.AccountId != null) {setOppAccId.add(theOppToSend.AccountId);}
                if(theOppToSend.Account.FinancialContact__c != null) {setOppAccId.add(theOppToSend.Account.FinancialContact__c);}
                if(theOppToSend.Account.PrimaryContact__c != null) {setOppAccId.add(theOppToSend.Account.PrimaryContact__c);}
                List<Contact> lstCon = getListContact(setOppAccId);
                // List<Contact> lstCon = getListContact(new Set<Id> { theOppToSend.AccountId, //get contact list related to the opportunities
                //                                                     theOppToSend.Account.FinancialContact__c, 
                //                                                     theOppToSend.Account.PrimaryContact__c});
                if(thefamily.get('ParentContact').size() < 1 && thefamily.get('ChildContact').size() < 1) { //generate the family
                    getFamily(lstCon, theOppToSend); 
                    
                    Set<Contact> uniqueParentContacts = new Set<Contact>(); //merge primary contact with parents
                    uniqueParentContacts.addAll(thefamily.get('PrimaryContact'));
                    uniqueParentContacts.addAll(thefamily.get('ParentContact'));
                    
                    for(Contact contactToAdd :uniqueParentContacts){ //only 3 parents allowed
                        if(thefamily.get('allParents').size()<3 && theOppToSend.SchoolOfInterest__r.schoolcode__c!='ISR') 
                            thefamily.get('allParents').add(contactToAdd);
                        else if(thefamily.get('allParents').size()<8 && theOppToSend.SchoolOfInterest__r.schoolcode__c=='ISR') //FKH Case 3194
                            thefamily.get('allParents').add(contactToAdd);
                    }
                }                
                
                if (theOppToSend.Account.OnlineApplication__c && !isAppForm) { //CRA20200601 - Case 2322
                    isAppForm = true;
                }
                
                noOfParents = thefamily.get('allParents').size(); //get number of parents in the family 
                if(noOfParents>0){ //get the primary contact in the family
                   thePrimaryContact = thefamily.get('allParents')[0];
                } 
               
                noOfChilds = thefamily.get('ChildContact').size();   //get number of children in the family
                if(noOfChilds > 0) {
                    Contact child = thefamily.get('ChildContact')[0];
                    theOpportunities.put(child.Id, theOppToSend); 
                }
            }
        }
        RequirementsForSpecificSchools();   //Cater for additional requirements for different schools FKH Case 2906 & Case 2918 
    }

    /**
     * [getListOpportunity description]
     * @param  accId [description]
     * @param  oppId [description]
     * @return       [description]
     */
    public List<Opportunity> getListOpportunity(Id accId, Id oppId) {
        String strQuery = 'SELECT  id'+
                            ',StageName'+
                            ',Name'+
                            ',AccountId'+
                            ',Account.Name'+
                            ',Child__c'+
                            ',Account.FinancialContact__c'+
                            ',Account.PrimaryContact__c'+
                            ',Account.TECH_ApplicationFormLang__c'+
                            ',AttendedFrom__c'+
                            ',AttendedTo__c'+
                            ',ChildsAllergies__c'+
                            ',ConcernsOnSocialAcademicProgress__c'+
                            ',CurrentPreviousSchoolName__c'+
                            ',Curriculum__c'+
                            ',toLabel(DayOrBoardingSchool__c)'+
                            ',DietaryRequirements__c'+
                            ',Subject_Choices__c'+
                            ',ChildVisa__c'+
                            ',toLabel(EnglishProficiencySpoken__c)'+
                            ',toLabel(EnglishProficiencyWritten__c)'+
                            ',InabilityToParticipateInSports__c'+
                            ',LanguageOfInstruction__c'+
                            ',LeadSource'+
                            ',MedicalConditions__c'+
                            ',PrescriptionDrugs__c'+
                            ',ReasonForLeaving__c'+
                            ',ReferenceRequest__c'+
                            ',SchoolOfInterest__r.Name'+
                            ',SchoolOfInterest__r.SchoolCode__c'+
                            ',SchoolOfInterest__r.MedicalTermsConditions__c'+
                            ',SchoolOfInterest__r.MedicalTermsConditionsBilingual__c'+
                            ',SchoolOfInterest__r.ChildPhotoDisclaimer__c'+
                            ',SchoolOfInterest__r.ChildPhotoDisclaimerBilingual__c'+
                            ',SchoolOfInterest__r.AuthorizationParticipateSchoolTrips__c'+
                            ',SchoolOfInterest__r.PrivacyPolicy__c'+
                            ',SchoolOfInterest__r.PrivacyPolicyBilingual__c'+
                            ',SchoolOfInterest__r.TermsAndConditions__c'+
                            ',SchoolOfInterest__r.TermsAndConditionsBilingual__c'+
                            ',SchoolOfInterest__r.PermissionToSubmitLetter__c'+
                            ',SchoolOfInterest__r.Bilingual__c'+
                            ',SchoolOfInterest__r.PDFFieldVisibility__c'+
                            ',SchoolOfInterest__r.Sub_Region__c'+
                            ',SchoolRejection__c'+
                            ',Vaccinations__c'+
                            ',WhatIsTheReason__c'+
                            ',childNeedAdditionalSupport__c'+
                            ',AttendedSpecialClasses__c'+
                            ',EducationSupportNeeded__c'+ 
                            ',City__c'+
                            ',toLabel(Country__c)'+
                            ',RequestedYearLevel__c'+
                            ',Account.NumberOfChildren__c'+
                            ',toLabel(ChineseProficiencySpoken__c)'+
                            ',toLabel(ChineseProficiencyWritten__c)'+
                            ',Campus__c'+
                            ',CloseDate'+
                            ',SchoolTripAuthorization__c'+
                            ',ChildPhotoDisclaimer__c'+
                            ',PrivacyPolicy__c'+
                            ',MedicalTermsConditions__c'+
                            ',TermsConditions__c'+
                            ',PrimaryContact__c'+
                            ',ReportsReceipient__c'+
                            ',SchoolNewsCommContact__c'+
                            ',ParentPortalAccess__c'+
                            ',EmergencyContact__c'+
                            ',EmergencyContactNum__c'+
                            ',FeesPayer__c'+
                            ',CompanyOther__c'+
                            ',InvoiceAddress1__c'+
                            ',PostalZipCode__c'+
                            ',InvoiceCity__c'+
                            ',InvoiceCountry__c'+
            				',ContactName__c'+
                            ',ContactEmailAddress__c'+
                            ',LeadSubmissionDate__c'+
                            ',LeadOrigin__c'+
                            ',Account.OnlineApplication__c'+
                            ',Account.Referrer_Family_1_Name__c'+
                            ',Account.Referrer_Family_2_Name__c'+
                            ',Account.Referrer_Family_1_Email__c'+
                            ',Account.Referrer_Family_2_Email__c'+
                            ',Account.Referrer_Family_1_Phone_Number__c'+
                            ',Account.Referrer_Family_2_Phone_Number__c'+
                            ',Account.PrimaryContact__r.Name'+
                            ',Account.FinancialContact__r.Name'+
                            ',ChildsFavouriteSubjects__c'+
                            ',Interests__c'+
               ' FROM Opportunity'+
               ' WHERE ';
        if(oppId != null) {
            strQuery += ' id =: oppId';
        }
        if(accId != null) {
            strQuery += ' AccountId =: accId';
        }
        List<Opportunity> lstOpp = (List<Opportunity>)Database.query(strQuery);
        return lstOpp;
    }

    /**
     * [getListContact description]
     * @param  setAccId [description]
     * @return          [description]
     */
    public List<Contact> getListContact(Set<Id> setAccId) {
        return [SELECT  Id
                        ,isPrimaryContact__c
                        ,isFinancialContact__c
                        ,toLabel(NatureOfRelationship__c)
                        ,recordtype.Name
                        //,MailingAddress
                        ,Salutation
                        ,Company__c
                        ,FirstName
                        ,MiddleName
                        ,Household_registration__c
                        ,LastName
                        //,MailingCity
                        //,MailingCountry
                        //,MailingPostalCode
                        //,MailingState
                        //,MailingStreet
                        ,AddressLine1__c
                        ,AddressLine2__c
                        ,AddressLine3__c
                        ,State__c
                        ,City__c 
                        ,ZipPostalCode__c
                        ,MobilePhone
                        ,Name
                        ,toLabel(Nationality__c)
                        ,Phone
                        ,Title
                        ,WeChatUserId__c
                        ,CountryCode__c
                        ,Email
                        ,Birthdate
                        ,toLabel(Ethnicity__c)
                        ,toLabel(Gender__c)
                        ,toLabel(Nationality2__c)
                        ,toLabel(NativeLanguage__c)
                        ,PassportNumber__c
                        ,Photo__c
                        ,toLabel(ReligionPicklist__c)
                        ,toLabel(SecondLanguage__c)
                        ,preferredName__c
                        ,isAlumni__c
                        ,hasLegalCustodyOfChild__c
                        ,Parent_1_child_enrolled__c
                        ,SiblingInformation__c
                        ,toLabel(CountryOfResidence__c)
                        ,LeadPosition__c
                        ,Parent_Conviction__c
                        ,MaritalStatus__c
                        ,JobTitle__c
                        ,Work_Phone__c
                        ,Other_Businesses__c
                        ,Is_Contact_Deceased__c
                        ,Profession__c
                        ,Remarried_Status__c
                        ,I_20_Required_for_Visa__c
                FROM Contact 
                WHERE AccountId in : setAccId
                ORDER BY LeadPosition__c ASC];
    }

    /**
     * [getFamily ]
     * @param lstCon [list of contact to add in the family]
     * @param opp    [the opportunity related to the family]
     */
    public void getFamily(List<Contact> lstCon, Opportunity opp) {

        for(Contact theContact : lstCon) {
            if(theContact.isPrimaryContact__c && theContact.recordtype.Name.equals(AP_Constant.conRecordTypeDeveloperNameParent) && !thefamily.get('PrimaryContact').contains(theContact)){
                thefamily.get('PrimaryContact').add(theContact);
            }
            if((opp.Account.FinancialContact__c!=null && (opp.Account.FinancialContact__c.equals(theContact.Id)) || theContact.isFinancialContact__c) && !thefamily.get('FinancialContact').contains(theContact)){
                thefamily.get('FinancialContact').add(theContact);
                hasFinancialContact=true;
            }
            if(!(theContact.isPrimaryContact__c||theContact.isFinancialContact__c) && theContact.recordtype.Name.equals(AP_Constant.conRecordTypeDeveloperNameParent) && !thefamily.get('ParentContact').contains(theContact)){
                thefamily.get('ParentContact').add(theContact);
            }
            if(theContact.recordtype.Name.equals(AP_Constant.conRecordTypeDeveloperNameChild) && opp.Child__c!=null && opp.Child__c.equals(theContact.Id) && !thefamily.get('ChildContact').contains(theContact)){
                thefamily.get('ChildContact').add(theContact);
                theOpportunities.put(theContact.Id, opp);
            }
            if(theContact.recordtype.Name.equals(AP_Constant.conRecordTypeDeveloperNameParent) && lstNatureOfRelationship.Contains(theContact.NatureOfRelationship__c) && !thefamily.get('onlyParents').contains(theContact)){ //add only mother & father - ISR Case 3194 and 5098
                thefamily.get('onlyParents').add(theContact);
            }
        }
     }

    /**
    * [getSchoolOfInterest get the school resources]
    * @param code [school code]
    */
    public void getSchoolOfInterest(String code) {
        Map<String,String> mapSCSR = new Map<String,String>();
        theSchoolOfInterest = 'Default';
        schoolCode = 'XXX_resources';
        //fetch application form settings
        for(SchoolApplicationFormSetting__mdt mdtSaf : [SELECT 
                                                        DeveloperName,
                                                        StaticResourceCode__c
                                                    FROM SchoolApplicationFormSetting__mdt]){
            mapSCSR.put(mdtSaf.DeveloperName,mdtSaf.StaticResourceCode__c);
        }
        if( code != null ) {
                theSchoolOfInterest = mapSCSR.containsKey(code) ? code+'_resources' : 'Default';
                schoolCode = code+'_resources';
        }
    } 

    /**
     * [getAPIName Initializing LabelMapping and lang values]
     * @param schoolCode [description]
     */
    public void getLabelMapping(String language) {
        //initialize lang to english
        lang = 'en_US';
        //initialize the standard label
        List<CM_LabelMapping__mdt> lstMdtLabel = [SELECT DeveloperName, MasterLabel, TranslatedLabel__c FROM CM_LabelMapping__mdt WHERE DeveloperName LIKE 'XXX_%'];
        if(lstMdtLabel.size() > 0) {
            for(CM_LabelMapping__mdt mdtLabel : lstMdtLabel) {
                mapAPILabel.put(mdtLabel.MasterLabel, mdtLabel.TranslatedLabel__c);
            }
        }

        if(language != null) {
            String strCondition = '';
            if(language == AP_Constant.schoolBilingualChinese || language == AP_Constant.accAppFormLangZH) {
                strCondition = 'CHN_%';
                lang = 'zh_CN';
            }
            if(language == AP_Constant.schoolBilingualThai || language == AP_Constant.accAppFormLangTH) {
                strCondition = 'THA_%';
                lang = 'th';
            }
            if(language == AP_Constant.schoolBilingualFrench || language == AP_Constant.accAppFormLangFR) {
                strCondition = 'FRH_%';
                lang = 'fr';
            }
            if (language == AP_Constant.schoolBilingualVietnamese || language == AP_Constant.accAppFormLangVI) {
                strCondition = 'VIE_%';
                lang = 'vi';
            }
            else if (language == AP_Constant.schoolBilingualSpanish ||language == AP_Constant.accAppFormLangES) {
                strCondition = 'SPA_%';
                lang = 'es';
            }
            else if (language == AP_Constant.schoolBilingualSlovak ||language == AP_Constant.accAppFormLangSK) {
                strCondition = 'SLK_%';
                lang = 'sk';
            }
            else if (language == AP_Constant.schoolBilingualPortuguese ||language == AP_Constant.accAppFormLangPOR) {   // FKH - Translation portuguese
                strCondition = 'POR_%';
                lang = 'pt_BR';
            }

            if (String.isNotBlank(strCondition)) {
                for(CM_LabelMapping__mdt mdtLabel : [SELECT DeveloperName, MasterLabel, TranslatedLabel__c FROM CM_LabelMapping__mdt WHERE DeveloperName LIKE :strCondition]) {
                    mapAPILabel.put(mdtLabel.MasterLabel, mdtLabel.TranslatedLabel__c);
                }          
            }
        }
    }
}