/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP01_LeadConvert
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 11-Jul-2018  AMU    1.0      Initial version
-- 23-DEC-2019  CRA    1.1      Add test coverage
-- 16-FEB-2021  VJA    1.2      Added day of boarding to all lead records
-- 14-Mar-2021  VJA    1.3      CommentParent3
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
public with sharing class AP01_LeadConvert_TEST {
    static List<User> lstUser;
    static List<Lead> lstLead;
    static List<School__c> lstSchool;
    static List<Campaign> lstCampaign;
    static List<CampaignMember> lstCampMember;
    static Account testAcc;
    static List<Contact> lstContact;
    static Map<string,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.accObject, AP_Constant.conObject});

    static {
        lstUser = new List<User>{
            TestFactory.createUser('Test', TestFactory.getProfileAdminId())
            ,TestFactory.createUser('Test1', TestFactory.getProfileAdminId())
        };
        insert lstUser;

        System.runAs(lstUser[0]){

            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST')
            };
            lstSchool[0].ActivateApplicationForm__c = true;
            insert lstSchool;

            testAcc = TestFactory.createAccount('testAccAgent');
            testAcc.recordTypeId = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);
            testAcc.BillingCity = 'Paris';
            testAcc.Region__c = 'Europe';
            insert testAcc;

            //creating primary contact in account for opportunity
            lstContact = new List<Contact>{
                TestFactory.createContact('agent1', testAcc.Id, mapRecordType.get(AP_Constant.conRecordTypeExternalRelationships))};
            insert lstContact; 

            lstLead = new List<Lead>{
                TestFactory.createLead( null, 'Test', 'Tester', 'childfname', 'childlname', 'Male', Date.newInstance(2010, 2, 2)),
                TestFactory.createLead( null, 'Test1', 'Tester1', 'childfname1', 'childlname1', 'Male', Date.newInstance(2010, 2, 2)),
                TestFactory.createLead( null, 'Test2', 'Tester2', 'childfname2', 'childlname2', 'Male', Date.newInstance(2010, 2, 2)),
                TestFactory.createLead( null, 'Test3', 'Tester3', 'childfname3', 'childlname3', 'Male', Date.newInstance(2010, 2, 2)),
                TestFactory.createLead( null, 'Test4', 'Tester4', 'childfname4', 'childlname4', 'Male', Date.newInstance(2010, 2, 2)),
                TestFactory.createLead( null, 'Test5', 'Tester5', 'childfname5', 'childlname5', 'Male', Date.newInstance(2010, 2, 2))
            };                     

            lstLead[0].Parent1PrimaryEmail__c = 'user@test.com';
            lstLead[0].Parent1CountryOfResidence__c = 'France';

            lstLead[0].Parent2FirstName__c = 'Jean';
            lstLead[0].Parent2LastName__c = 'Curi';
            lstLead[0].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[0].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[0].Parent2CountryOfResidence__c = 'France';
            lstLead[0].Parent2Nationality__c = 'French';

            //VJA lstLead[0].Parent3FirstName__c = 'Tom';
            //VJA lstLead[0].Parent3LastName__c = 'Curi';
            //VJA lstLead[0].Parent3NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            //VJA lstLead[0].Parent3HomePhone__c = '+852 9999-9999';
            //VJA lstLead[0].Parent3CountryOfResidence__c = 'Mauritius';
            //VJA lstLead[0].Parent3Nationality__c = 'French';

            lstLead[0].Number_of_Children__c = '5';
            lstLead[0].MarketingQualifiedFirstChild__c = true;
            lstLead[0].DayOrBoardingSchoolFirstChild__c = 'Day';

            lstLead[0].FirstNameSecondChild__c = 'scnFname';
            lstLead[0].LastNameSecondChild__c = 'scnLname';
            lstLead[0].DateOfBirthSecondChild__c = Date.newInstance(2010, 2, 2);
            lstLead[0].GenderSecondChild__c = 'Male';
            lstLead[0].MarketingQualifiedSecondChild__c = true;
            lstLead[0].EnrollmentDateSecondChild__c = Date.newInstance(2019, 2, 2);
            lstLead[0].DayOrBoardingSchoolSecondChild__c = 'Day';

            lstLead[0].FirstNameThirdChild__c = 'thdFname';
            lstLead[0].LastNameThirdChild__c = 'thdLname';
            lstLead[0].DateOfBirthThirdChild__c = Date.newInstance(2010, 2, 2);
            lstLead[0].EnrollmentDateThirdChild__c = Date.newInstance(2019, 2, 2);
            lstLead[0].GenderThirdChild__c = 'Male';
            lstLead[0].MarketingQualifiedThirdChild__c = true;
            lstLead[0].DayOrBoardingSchoolThirdChild__c = 'Day';

            lstLead[0].FirstNameFourthChild__c = 'frfFname';
            lstLead[0].LastNameFourthChild__c = 'frfLname';
            lstLead[0].DateOfBirthFourthChild__c = Date.newInstance(2010, 2, 2);
            lstLead[0].EnrollmentDateFourthChild__c = Date.newInstance(2019, 2, 2);
            lstLead[0].GenderFourthChild__c = 'Male';
            lstLead[0].MarketingQualifiedFourthChild__c = true;
            lstLead[0].DayOrBoardingSchoolFourthChild__c = 'Day';

            lstLead[0].FirstNameFifthChild__c = 'fifFname';
            lstLead[0].LastNameFifthChild__c = 'fifLname';
            lstLead[0].DateOfBirthFifthChild__c =Date.newInstance(2010, 2, 2);
            lstLead[0].EnrollmentDateFifthChild__c = Date.newInstance(2019, 2, 2);
            lstLead[0].GenderFifthChild__c = 'Male';
            lstLead[0].MarketingQualifiedFifthChild__c = true;
            lstLead[0].DayOrBoardingSchoolFifthChild__c = 'Day';

            lstLead[0].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[0].Company = 'testComp';
            lstLead[0].isExternalSource__c =true;
            lstLead[0].Status = 'Qualified';

            //4 children
            lstLead[1].Parent1PrimaryEmail__c = 'user1@test.com';
            lstLead[1].Parent1CountryOfResidence__c = 'France';

            lstLead[1].Parent2FirstName__c = 'Jean1';
            lstLead[1].Parent2LastName__c = 'Curi1';
            lstLead[1].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[1].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[1].Parent2CountryOfResidence__c = 'France';
            lstLead[1].Parent2Nationality__c = 'French';

            lstLead[1].Number_of_Children__c = '4';
            lstLead[1].MarketingQualifiedFirstChild__c = true; //first child details inserted already
            lstLead[1].DayOrBoardingSchoolFirstChild__c = 'Day';

            lstLead[1].FirstNameSecondChild__c = 'scnFname1';
            lstLead[1].LastNameSecondChild__c = 'scnLname1';
            lstLead[1].DateOfBirthSecondChild__c = Date.newInstance(2010, 2, 2);
            lstLead[1].GenderSecondChild__c = 'Male';
            lstLead[1].MarketingQualifiedSecondChild__c = true;
            lstLead[1].EnrollmentDateSecondChild__c = Date.newInstance(2019, 2, 2);
            lstLead[1].DayOrBoardingSchoolSecondChild__c = 'Day';

            lstLead[1].FirstNameThirdChild__c = 'thdFname1';
            lstLead[1].LastNameThirdChild__c = 'thdLname1';
            lstLead[1].DateOfBirthThirdChild__c = Date.newInstance(2010, 2, 2);
            lstLead[1].EnrollmentDateThirdChild__c = Date.newInstance(2019, 2, 2);
            lstLead[1].GenderThirdChild__c = 'Male';
            lstLead[1].MarketingQualifiedThirdChild__c = true;
            lstLead[1].DayOrBoardingSchoolThirdChild__c = 'Day';

            lstLead[1].FirstNameFourthChild__c = 'frfFname1';
            lstLead[1].LastNameFourthChild__c = 'frfLname1';
            lstLead[1].DateOfBirthFourthChild__c = Date.newInstance(2010, 2, 2);
            lstLead[1].EnrollmentDateFourthChild__c = Date.newInstance(2019, 2, 2);
            lstLead[1].GenderFourthChild__c = 'Male';
            lstLead[1].MarketingQualifiedFourthChild__c = true;
            lstLead[1].DayOrBoardingSchoolFourthChild__c = 'Day';

            lstLead[1].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[1].Company = 'testComp';
            lstLead[1].isExternalSource__c =true;
            lstLead[1].Status = 'Qualified';
            lstLead[1].WeChatCampaignName__c = 'Test Campaign';
            //VJA lstLead[1].FeesPayer__c = 'Jean1 Curi1';

            //3 children
            lstLead[2].Parent1PrimaryEmail__c = 'user3@test.com';
            lstLead[2].Parent1CountryOfResidence__c = 'France';

            lstLead[2].Parent2FirstName__c = 'Jean3';
            lstLead[2].Parent2LastName__c = 'Curi3';
            lstLead[2].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[2].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[2].Parent2CountryOfResidence__c = 'France';
            lstLead[2].Parent2Nationality__c = 'French';

            lstLead[2].Number_of_Children__c = '3';
            lstLead[2].MarketingQualifiedFirstChild__c = true; //first child details inserted already
            lstLead[2].DayOrBoardingSchoolFirstChild__c = 'Day';

            lstLead[2].FirstNameSecondChild__c = 'scnFname3';
            lstLead[2].LastNameSecondChild__c = 'scnLname3';
            lstLead[2].DateOfBirthSecondChild__c = Date.newInstance(2010, 2, 2);
            lstLead[2].GenderSecondChild__c = 'Male';
            lstLead[2].MarketingQualifiedSecondChild__c = true;
            lstLead[2].EnrollmentDateSecondChild__c = Date.newInstance(2019, 2, 2);
            lstLead[2].DayOrBoardingSchoolSecondChild__c = 'Day';

            lstLead[2].FirstNameThirdChild__c = 'thdFname3';
            lstLead[2].LastNameThirdChild__c = 'thdLname3';
            lstLead[2].DateOfBirthThirdChild__c = Date.newInstance(2010, 2, 2);
            lstLead[2].EnrollmentDateThirdChild__c = Date.newInstance(2019, 2, 2);
            lstLead[2].GenderThirdChild__c = 'Male';
            lstLead[2].MarketingQualifiedThirdChild__c = true;
            lstLead[2].DayOrBoardingSchoolThirdChild__c = 'Day';

            lstLead[2].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[2].Company = 'testComp';
            lstLead[2].isExternalSource__c =true;
            lstLead[2].Status = 'Qualified';

            //2 children
            lstLead[3].Parent1PrimaryEmail__c = 'user4@test.com';
            lstLead[3].Parent1CountryOfResidence__c = 'France';

            lstLead[3].Parent2FirstName__c = 'Jean4';
            lstLead[3].Parent2LastName__c = 'Curi4';
            lstLead[3].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[3].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[3].Parent2CountryOfResidence__c = 'France';
            lstLead[3].Parent2Nationality__c = 'French';

            lstLead[3].Number_of_Children__c = '2';
            lstLead[3].MarketingQualifiedFirstChild__c = true; //first child details inserted already
            lstLead[3].DayOrBoardingSchoolFirstChild__c = 'Day';

            lstLead[3].FirstNameSecondChild__c = 'scnFname4';
            lstLead[3].LastNameSecondChild__c = 'scnLname4';
            lstLead[3].DateOfBirthSecondChild__c = Date.newInstance(2010, 2, 2);
            lstLead[3].GenderSecondChild__c = 'Male';
            lstLead[3].MarketingQualifiedSecondChild__c = true;
            lstLead[3].EnrollmentDateSecondChild__c = Date.newInstance(2019, 2, 2);
            lstLead[3].DayOrBoardingSchoolSecondChild__c = 'Day';

            lstLead[3].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[3].Company = 'testComp';
            lstLead[3].isExternalSource__c =true;
            lstLead[3].Status = 'Qualified';

            //1 child
            lstLead[4].Parent1PrimaryEmail__c = 'user5@test.com';
            lstLead[4].Parent1CountryOfResidence__c = 'France';

            lstLead[4].Parent2FirstName__c = 'Jean5';
            lstLead[4].Parent2LastName__c = 'Curi5';
            lstLead[4].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[4].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[4].Parent2CountryOfResidence__c = 'France';
            lstLead[4].Parent2Nationality__c = 'French';

            lstLead[4].Number_of_Children__c = '1';
            lstLead[4].MarketingQualifiedFirstChild__c = true; //first child details inserted already
            lstLead[4].DayOrBoardingSchoolFirstChild__c = 'Day';

            lstLead[4].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[4].Company = 'testComp';
            lstLead[4].isExternalSource__c =true;
            lstLead[4].Status = 'Qualified';

            //agent
            lstLead[5].Parent1PrimaryEmail__c = 'user5@test.com';
            lstLead[5].Parent1CountryOfResidence__c = 'France';
            lstLead[5].Parent1NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipAgent;
            lstLead[5].ReferredByContact__c = lstContact[0].Id;
            lstLead[5].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[5].Company = 'testComp';
            lstLead[5].isExternalSource__c =true;
            lstLead[5].Status = 'Qualified';
            lstLead[5].Number_of_Children__c = '1';
            lstLead[5].MarketingQualifiedFirstChild__c = true;
            lstLead[5].DayOrBoardingSchoolFirstChild__c = 'Day';

            insert lstLead;
            
            lstCampaign = new List<Campaign> {
                new Campaign(Name='Test Campaign', isActive=true)
            };
            insert lstCampaign;

            lstCampMember = new List<CampaignMember>{ new CampaignMember(CampaignId = lstCampaign[0].Id, LeadId = lstLead[1].Id)};
            insert lstCampMember;
        }
    }

    @isTest public static void createFamilyTest(){
        System.runAs(lstUser[0]) {
            List<Database.LeadConvert> lstLeadConv = new List<Database.LeadConvert>();
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];

            for(Lead led : lstLead){
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(led.Id);
                lc.setConvertedStatus(convertStatus.MasterLabel);
                lc.setDoNotCreateOpportunity(true);
                lstLeadConv.add(lc);
            }
        
            test.StartTest();
                Database.LeadConvertResult[] lstLeadConvRes = Database.convertLead(lstLeadConv);
            test.StopTest();

            List<Opportunity> lstOpp = [SELECT Id, Name FROM Opportunity];
            System.assertEquals(lstOpp.size(), 16); // 5 + 4 + 3 + 2 + 1 + 1(agent) = 16 children/opportunities

            List<Account> lstAcc = [SELECT Id, Name FROM Account];
            System.assertEquals(lstAcc.size(), 7);

            List<Lead> lstLeadAgent = [SELECT ConvertedAccountId FROM Lead WHERE Id =: lstLead[5].Id];
            List<Account> lstAccAgent = [SELECT Id, PrimaryContact__c FROM Account WHERE Id =: lstLeadAgent[0].ConvertedAccountId];
            System.assertEquals(lstLead[5].ReferredByContact__c, lstAccAgent[0].PrimaryContact__c);
        }
    }

    @isTest public static void createFamilyFromApplicationForm() {
        List<Lead> lstLeadAppForm = new List<Lead>{
            TestFactory.createLead(null, 'Test1', 'Tester1', 'childfname1', 'childlname1', 'Male', Date.newInstance(2010, 2, 2))
        };

        //Application form
        lstLeadAppForm[0].Parent2FirstName__c = 'firstName';
        lstLeadAppForm[0].Parent2LastName__c = 'lastName';
        lstLeadAppForm[0].Parent2PrimaryEmail__c = 'user@test.com';
        lstLeadAppForm[0].Parent2HomePhone__c = '+852 9999-9999';
        lstLeadAppForm[0].Parent2CountryOfResidence__c = 'France';
        lstLeadAppForm[0].Parent2Nationality__c = 'Afghani';
        lstLeadAppForm[0].Parent2NatureOfRelationship__c = AP_Constant.ledNatureOfRelationshipFather;
        lstLeadAppForm[0].MarketingQualifiedFirstChild__c = true;
        lstLeadAppForm[0].DayOrBoardingSchoolFirstChild__c = 'Day';
        lstLeadAppForm[0].EnrollmentDateFirstChild__c = Date.newInstance(2119, 2, 2);
        lstLeadAppForm[0].PreferredNameFirstChild__c = 'tom';
        lstLeadAppForm[0].DateOfBirthFirstChild__c = Date.newInstance(2112, 11, 23);       
        lstLeadAppForm[0].Number_of_Children__c = '1';
        lstLeadAppForm[0].Lead_Origin__c = AP_Constant.ledOriginApplication;
        lstLeadAppForm[0].SchoolOfInterest__c = lstSchool[0].Id;
        lstLeadAppForm[0].Company = 'testComp';
        lstLeadAppForm[0].isExternalSource__c = true;
        lstLeadAppForm[0].Status = AP_Constant.ledStatusQualified;
        lstLeadAppForm[0].AutoConvert__c = true;

        Test.startTest();
        insert lstLeadAppForm;
        lstLeadAppForm[0].ownerid = lstUser[1].Id;
        update lstLeadAppForm;
        Test.stopTest();
    }
}