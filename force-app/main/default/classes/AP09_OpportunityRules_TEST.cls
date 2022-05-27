/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   :  
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 16-JUL-2018  AMU    1.0     Initial version
-- 11-OCT-2020	FKO    1.1     Case 00002654 
-- 14-Mar-2021  VJA    1.2     CommentParent3
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class AP09_OpportunityRules_TEST{
    static User testUserAdmin;
    static User testUser2;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
    static List<Opportunity> lstOpp;   
    static List<School__c> lstSchool;
    static Map<string,Id> mapRecordType = new Map<String, Id>();

    static{
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert testUserAdmin;

        System.runAs(testUserAdmin){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('TestUser1', 'Mauritius', false, 'TST'),
                TestFactory.createSchool('TestUser2', 'Mauritius', false, 'LOL')
            };
            lstSchool[1].AvailableForIsamsPush__c = true;
            insert lstSchool;

            //create second user to test change owner
            testUser2 = TestFactory.createUser('testUser2',TestFactory.getProfileAdminId());
            testUser2.SchoolCode__c= lstSchool[1].SchoolCode__c;
            insert testUser2;

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

            lstAcc = new List<Account>{
                TestFactory.createAccount('test Acc')
                ,TestFactory.createAccount('test Acc 1')
                ,TestFactory.createAccount('test Acc 2')
            };
            insert lstAcc;

            //creating primary contact in account for opportunity
            lstContact = new List<Contact>{
                TestFactory.createContact('parent1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))
                ,TestFactory.createContact('child1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('child2', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('parent2', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))
                ,TestFactory.createContact('child21', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('child31', lstAcc[2].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                //VJA ,TestFactory.createContact('parent3', lstAcc[2].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))
            };
            lstContact[3].NatureOfRelationship__c = AP_Constant.conNatureRelFather;
            //VJA lstContact[6].NatureOfRelationship__c = AP_Constant.conNatureRelFather;
            lstContact[4].NatureOfRelationship__c = AP_Constant.conNatureRelChild;
            lstContact[5].NatureOfRelationship__c = AP_Constant.conNatureRelChild;
            lstContact[4].Gender__c = AP_Constant.conGenderFemale;
            lstContact[5].Gender__c = AP_Constant.conGenderFemale;

            insert lstContact; 
            
            lstAcc[0].PrimaryContact__c = lstContact[0].Id;
            lstAcc[1].PrimaryContact__c = lstContact[3].Id;
            lstAcc[1].FinancialContact__c = lstContact[3].Id;
            //VJA lstAcc[2].PrimaryContact__c = lstContact[6].Id;
            lstAcc[0].SchoolOfInterest__c=lstSchool[1].Id;
            lstAcc[1].SchoolOfInterest__c=lstSchool[1].Id;
            update lstAcc; 

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testOpp01', lstAcc[0].Id, AP_Constant.oppStageNameActive,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp02', lstAcc[0].Id, AP_Constant.oppStageNameAcceptance,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp03', lstAcc[0].Id, AP_Constant.oppStageNameApplication,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp04', lstAcc[0].Id, AP_Constant.oppStageNameDenied,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp05', lstAcc[0].Id, AP_Constant.oppStageNameReenrolment,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp06', lstAcc[0].Id, AP_Constant.oppStageNameEnquiry,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp07', lstAcc[0].Id, AP_Constant.oppStageNameEnrolled,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp08', lstAcc[0].Id, AP_Constant.oppStageNameInactive,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp09', lstAcc[0].Id, AP_Constant.oppStageNameLost,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp10', lstAcc[0].Id, AP_Constant.oppStageNameOfferOut,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp11', lstAcc[0].Id, AP_Constant.oppStageNameOnHold,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp12', lstAcc[0].Id, AP_Constant.oppStageNameStarted,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp13', lstAcc[0].Id, AP_Constant.oppStageNameVisit,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
                
                ,TestFactory.createOpportunity('testOpp14', lstAcc[1].Id, AP_Constant.oppStageNameEnquiry,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id)

                ,TestFactory.createOpportunity('testOpp15', lstAcc[2].Id, AP_Constant.oppStageNameEnquiry,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id)
            };

            //opportunity childs
            lstOpp[1].Child__c = lstContact[1].Id;
            lstOpp[11].Child__c = lstContact[2].Id;
            lstOpp[13].Child__c = lstContact[4].Id;
            lstOpp[14].Child__c = lstContact[5].Id;

            //Testing to ensure that start date with values is not updated after insert.
            lstOpp[0].ActiveStartDate__c = System.today() - 5;
            lstOpp[1].AssessmentOutcome__c = AP_Constant.oppAssessOutcomePassed;
            
            //Required LostDeniedReason //11-OCT-2020	FKO    1.1     Case 00002654
            lstOpp[3].LostDeniedOnHoldReason__c = 'Financial';
            lstOpp[8].LostDeniedOnHoldReason__c = 'Financial';
            lstOpp[5].TECH_IsClone__c =  true;


            insert lstOpp;
        }
    }
    
    @isTest static void capturePrevStageTest(){
        System.runAs(testUserAdmin){
            lstOpp[0].StageName = AP_Constant.oppStageNameEnrolled;
            lstOpp[1].StageName = AP_Constant.oppStageNameStarted;
            lstOpp[2].StageName = AP_Constant.oppStageNameOnHold;
            lstOpp[3].StageName = AP_Constant.oppStageNameOfferOut;
            lstOpp[4].StageName = AP_Constant.oppStageNameLost;
            lstOpp[4].LostDeniedOnHoldReason__c = 'Financial';
            lstOpp[5].StageName = AP_Constant.oppStageNameInactive;
            lstOpp[6].StageName = AP_Constant.oppStageNameVisit;
            lstOpp[7].StageName = AP_Constant.oppStageNameEnquiry;
            lstOpp[8].StageName = AP_Constant.oppStageNameReenrolment;
            lstOpp[9].StageName = AP_Constant.oppStageNameDenied;
            lstOpp[9].LostDeniedOnHoldReason__c = 'Financial';
            lstOpp[10].StageName = AP_Constant.oppStageNameApplication;
            lstOpp[11].StageName = AP_Constant.oppStageNameAcceptance;
            lstOpp[11].AssessmentOutcome__c = AP_Constant.oppAssessOutcomePassed;
            lstOpp[12].StageName = AP_Constant.oppStageNameActive;

            test.startTest();
                update lstOpp;
            test.stopTest();

            List<Opportunity> lstUpdOpp = [SELECT Name, ActiveStartDate__c, AcceptanceStartDate__c, ApplicationStartDate__c, DeniedStartDate__c,
                                            EligibleForReenrolmentStartDate__c, EnquiryStartDate__c, EnrolledStartDate__c, InactiveStartDate__c,
                                            LostStartDate__c, OfferOutStartDate__c, OnHoldStartDate__c, StartedStartDate__c, VisitStartDate__c,
                                            PreviousStageBeforeLostDenied__c FROM Opportunity Where Id IN : lstOpp Order By Name];
     
        }
    }
    @isTest static void testUpdateSchool(){
        System.runAs(testUserAdmin){
            List<Opportunity> lstInsertedOpp= [SELECT Id, Ownerid FROM Opportunity WHERE AccountId = :lstAcc[0].Id];
            lstInsertedOpp[0].Ownerid = testUser2.Id;
            lstInsertedOpp[1].Ownerid = testUser2.Id;

            Test.startTest();
                update lstInsertedOpp;

                List<Opportunity> lstUpdatedOpp = [SELECT SchoolOfInterest__c FROM Opportunity WHERE AccountId = :lstAcc[0].Id];
               // System.assertEquals(lstSchool[1].Id, lstUpdatedOpp[0].SchoolOfInterest__c);
               // System.assertEquals(lstSchool[1].Id, lstUpdatedOpp[1].SchoolOfInterest__c);

            Test.stopTest();
        }
    }

    @isTest static void testAutomatedPush() {
        System.runAs(testUserAdmin) {
            lstOpp[13].StageName = AP_Constant.oppStageNameEnrolled;
            lstOpp[14].StageName = AP_Constant.oppStageNameEnrolled;
            lstOpp[1].schoolOfInterest__c=lstSchool[0].Id;
            lstOpp[13].midTierOpportunityid__c='LOL123';


            Test.startTest();
            try {
                update lstOpp;
            }
            catch(Exception e) {

            }
            Test.stopTest();
        }
    }
}