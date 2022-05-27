/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for VFC02_ApplicationFormAsAttachement to generate
                     an application form
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 06-FEB-2019  CRA   1.0     Initial Version[User Story: W-000344]
-- 13-APR-2022  YRA   2.0     Case 3947- Increase Code Coverage 
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
private class VFC02_ApplicationFormAsAttachement_TEST
{
	static List< Opportunity > lstOpp = new List< Opportunity >();
	static Map< string,Id > mapRecordType = new Map< String, Id >();
	static Map< string,Id > mapOppRecordType = new Map< String, Id >();
    static User usrTestAdmin;
    static List< Account > lstAccount = new List< Account >();
    static List< Contact > lstContact = new List< Contact >();
    static List< School__c > lstSchool = new List< School__c >();

    static {
        //creating user
        usrTestAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert usrTestAdmin;

        System.runAs(usrTestAdmin){

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject});
            mapOppRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject});

            //creatiing school
            lstSchool = new List<School__c>{
                TestFactory.createSchool('TestUser1', 'Mauritius', false, 'VIL'), //0
                TestFactory.createSchool('TestUser2', 'Mauritius', false, 'WPS'), //1
                TestFactory.createSchool('TestUser3', 'Mauritius', false, 'OIC'), //2
                TestFactory.createSchool('TestUser4', 'Mauritius', false, 'XYZ'), //3
                TestFactory.createSchool('TestUser5', 'Mauritius', false, 'ISR'), //4
                TestFactory.createSchool('TestUser6', 'Mauritius', false, 'BIS'), //5
                TestFactory.createSchool('TestUser7', 'Mauritius', false, 'NDL'), //6
                TestFactory.createSchool('TestUser8', 'Mauritius', false, 'NDB'), //7
                TestFactory.createSchool('TestUser9', 'Mauritius', false, 'DPS') //8
            };
            lstSchool[0].Bilingual__c = AP_Constant.schoolBilingualChinese;
            lstSchool[0].Sub_Region__c = 'CBL';
            lstSchool[1].Bilingual__c = AP_Constant.schoolBilingualThai;
            lstSchool[2].Bilingual__c = AP_Constant.schoolBilingualFrench;
            lstSchool[3].Bilingual__c = AP_Constant.schoolBilingualVietnamese;
            lstSchool[4].Bilingual__c = AP_Constant.schoolBilingualSpanish;
            lstSchool[5].Bilingual__c = AP_Constant.schoolBilingualSlovak;
            lstSchool[6].Bilingual__c = AP_Constant.schoolBilingualPortuguese;
           
            insert lstSchool;

            //creating account
            lstAccount = new List< Account > {
                TestFactory.createAccount('Jones Henry Family'),//0
                TestFactory.createAccount('Paul Smith Family'), //1
                TestFactory.createAccount('Tom Ford Family'),   //2
                TestFactory.createAccount('Bill Adams Family'), //3
                TestFactory.createAccount('Peter Harold Family'), //4
                TestFactory.createAccount('Lynn Cooper Family'), //5
                TestFactory.createAccount('Louis Bly Family'), //6
                TestFactory.createAccount('Theodora Hills Family'), //7
                TestFactory.createAccount('Benny Payton Family') //8

            };

            lstAccount[0].SchoolOfInterest__c = lstSchool[0].Id;

            insert lstAccount;

            //creating contact
            lstContact = new List < Contact > {
                TestFactory.createContact('Jones Henry', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),//0
                TestFactory.createContact('Joe Henry', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),   //1
                TestFactory.createContact('Paul Smith', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //2             
                TestFactory.createContact('James Smith', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)), //3
                TestFactory.createContact('Tom Ford', lstAccount[2].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),   //4
                TestFactory.createContact('Peter Ford', lstAccount[2].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),  //5             
                TestFactory.createContact('Bill Adams', lstAccount[3].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //6             
                TestFactory.createContact('Ben Adams', lstAccount[3].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),   //7
                TestFactory.createContact('Peter Harold', lstAccount[4].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //8            
                TestFactory.createContact('Elise Harold', lstAccount[4].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),   //9  
                TestFactory.createContact('Lynn Cooper', lstAccount[5].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //10             
                TestFactory.createContact('Alice Cooper', lstAccount[5].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),    //11  
                TestFactory.createContact('Louis Bly', lstAccount[6].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //12            
                TestFactory.createContact('Jake Bly', lstAccount[6].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),    //13  
                TestFactory.createContact('Theodora Hills', lstAccount[7].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //14             
                TestFactory.createContact('Nellie Hills', lstAccount[7].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),    //15
                TestFactory.createContact('Benny Payton', lstAccount[8].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //16
                TestFactory.createContact('Nellie Payton', lstAccount[8].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))    //17         
            };

            lstContact[0].isPrimaryContact__c = true;
            lstContact[6].isPrimaryContact__c = true;

            insert lstContact;

            lstAccount[0].FinancialContact__c = lstContact[0].Id;
            lstAccount[1].FinancialContact__c = lstContact[2].Id;
            lstAccount[2].FinancialContact__c = lstContact[4].Id;
            update lstAccount;

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testOpp01', lstAccount[0].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp02', lstAccount[1].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id)

                ,TestFactory.createOpportunity('testOpp03', lstAccount[2].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[2].Id)

                ,TestFactory.createOpportunity('testOpp04', lstAccount[3].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[3].Id)
                    
                ,TestFactory.createOpportunity('testOpp05', lstAccount[4].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[4].Id)

                ,TestFactory.createOpportunity('testOpp06', lstAccount[5].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[5].Id)
                
                ,TestFactory.createOpportunity('testOpp07', lstAccount[6].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[6].Id)

                ,TestFactory.createOpportunity('testOpp08', lstAccount[7].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[7].Id)
                
                ,TestFactory.createOpportunity('testOpp09', lstAccount[8].Id, AP_Constant.oppStageNameApplication,
                                                mapOppRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[8].Id)
            };
            lstOpp[0].Child__c = lstContact[1].Id; 
            lstOpp[1].Child__c = lstContact[3].Id; 
            lstOpp[2].Child__c = lstContact[5].Id; 
            lstOpp[3].Child__c = lstContact[7].Id;
            lstOpp[4].Child__c = lstContact[9].Id;
            lstOpp[5].Child__c = lstContact[11].Id;
            lstOpp[6].Child__c = lstContact[13].Id;
            lstOpp[7].Child__c = lstContact[15].Id;
            lstOpp[8].Child__c = lstContact[17].Id;

            insert lstOpp;
        }
    }

    @isTest static void generateApplicationFormWithAcc() { //cater for CBL and Chinese bilingual
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	Test.startTest();
    	ctrl.theAcc = lstAccount[0];
    	ctrl.init();
    	Test.stopTest();
    	System.assertEquals(1, ctrl.noOfParents);  // number of parent
    	System.assertEquals(lstContact[0].LastName, ctrl.thePrimaryContact.LastName); 
    }


    @isTest static void generateApplicationFormWithOpp() { //cater for thai language
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	Test.startTest();
    	ctrl.theOppToSend = lstOpp[1];
    	ctrl.init();
    	Test.stopTest();
    	List<Contact> lstFinancialCon = ctrl.thefamily.get('FinancialContact');

    	System.assertEquals(lstContact[2].LastName, lstFinancialCon[0].LastName);

    }
    @isTest static void generateApplicationFormInit() { //cater for french language
    	Boolean result;
    	Test.startTest();
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	ctrl.theOppToSend = lstOpp[2];
    	result = ctrl.init;
    	Test.stopTest();

    	System.assertEquals(false, result);
    }
    @isTest static void generateApplicationFormViet() { //cater for french language
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	Test.startTest();
    	ctrl.theOppToSend = lstOpp[3];
    	ctrl.init();
    	Test.stopTest();

    }
    @isTest static void generateApplicationFormSpanish() { //cater for spanish language
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	Test.startTest();
    	ctrl.theOppToSend = lstOpp[4];
    	ctrl.init();
    	Test.stopTest();
    }
    @isTest static void generateAppFormSlovak() { //cater for spanish language
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	Test.startTest();
    	ctrl.theOppToSend = lstOpp[5];
    	ctrl.init();
    	Test.stopTest();
    }
    @isTest static void generateAppFormPortuguese() { //cater for portuguese language
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	Test.startTest();
    	ctrl.theOppToSend = lstOpp[6];
    	ctrl.init();
    	Test.stopTest();
    }
    @isTest static void generateAppFormNDB() { //cater for NDB
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	Test.startTest();
    	ctrl.theOppToSend = lstOpp[7];
    	ctrl.init();
    	Test.stopTest();
    }
    @isTest static void generateAppFormDPS() { //cater for DPS
    	VFC02_ApplicationFormAsAttachement ctrl = new VFC02_ApplicationFormAsAttachement();
    	Test.startTest();
    	ctrl.theOppToSend = lstOpp[8];
    	ctrl.init();
    	Test.stopTest();
    }

}