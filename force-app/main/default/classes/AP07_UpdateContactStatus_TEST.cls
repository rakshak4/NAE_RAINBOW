/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP07_UpdateContactStatus
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 31-MAY-2018  AMU    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class AP07_UpdateContactStatus_TEST {
    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
    static List<Opportunity> lstOpp;
    static List<School__c> lstSchool;
    static Map<String,Id> mapRecordType;

    static {
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST')
            };
            insert lstSchool;

            lstAcc = new List<Account>{TestFactory.createAccount('test')};
            insert lstAcc;

            lstContact = new List<Contact>{
                TestFactory.createContact('test1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('test2', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('test3', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('test4', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('test5', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
               // ,TestFactory.createContact('test6', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
               // ,TestFactory.createContact('test7', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
               // ,TestFactory.createContact('test8', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            insert lstContact; 

            lstAcc[0].PrimaryContact__c = lstContact[0].Id;
            update lstAcc;            

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testopp1', lstAcc[0].Id, AP_Constant.oppStageNameVisit, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testopp2', lstAcc[0].Id, AP_Constant.oppStageNameOfferOut, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testopp3', lstAcc[0].Id, AP_Constant.oppStageNameStarted, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                // ,TestFactory.createOpportunity('testopp4', lstAcc[0].Id, AP_Constant.oppStageNameDenied, 
                //                                 mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                // ,TestFactory.createOpportunity('testopp5', lstAcc[0].Id, AP_Constant.oppStageNameLost, 
                //                                  mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                // ,TestFactory.createOpportunity('testopp6', lstAcc[0].Id, AP_Constant.oppStageNameEnrolled, 
                //                                 mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                // ,TestFactory.createOpportunity('testopp7', lstAcc[0].Id, AP_Constant.oppStageNameEnrolled, 
                //                                 mapRecordType.get(AP_Constant.oppRecordTypeReenrolment), lstSchool[0].Id)

                // ,TestFactory.createOpportunity('testopp5', lstAcc[0].Id, AP_Constant.oppStageNameApplication, 
                //                                 mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };

            lstOpp[0].Child__c = lstContact[0].Id;
            lstOpp[1].Child__c = lstContact[1].Id;
            lstOpp[2].Child__c = lstContact[2].Id;
            // lstOpp[3].Child__c = lstContact[3].Id;
            // lstOpp[4].Child__c = lstContact[4].Id;
            // lstOpp[5].Child__c = lstContact[5].Id;
            // lstOpp[6].Child__c = lstContact[6].Id;
            // lstOpp[7].Child__c = lstContact[7].Id;

            insert lstOpp;
        }
    }

    @isTest public static void updateContactTest(){
        lstOpp[0].Waitlisted__c = true;
        lstOpp[0].StageName = AP_Constant.oppStageNameApplication;
        lstOpp[1].StageName = AP_Constant.oppStageNameEnrolled;
        lstOpp[1].RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeReenrolment);
        lstOpp[2].StageName = AP_Constant.oppStageNameOfferOut;
        // lstOpp[3].StageName = AP_Constant.oppStageNameAcceptance;
        // lstOpp[3].AssessmentOutcome__c = AP_Constant.oppAssessOutcomePassed;
        // lstOpp[4].StageName = AP_Constant.oppStageNameDenied;
        // lstOpp[5].StageName = AP_Constant.oppStageNameStarted;
        // lstOpp[6].RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeEnrolment);
        // lstOpp[7].StageName = AP_Constant.oppStageNameLost;

        System.runAs(lstUser[0]){
            test.StartTest();
                update lstOpp;
            test.StopTest();

            List<Contact> lstContact = [SELECT LastName, Status__c FROM Contact WHERE AccountId =: lstAcc[0].Id Order By LastName];
            // System.assertEquals(lstContact[7].Status__c, null);
            // System.assertEquals(lstContact[6].Status__c, AP_Constant.conStatusProspect);
            // System.assertEquals(lstContact[5].Status__c, AP_Constant.conStatusStudent);
            //System.assertEquals(lstContact[4].Status__c, AP_Constant.conStatusDenied);
            //System.assertEquals(lstContact[3].Status__c, AP_Constant.conStatusProspect);
            System.assertEquals(lstContact[2].Status__c, AP_Constant.conStatusProspect);
            System.assertEquals(lstContact[1].Status__c, AP_Constant.conStatusStudent);
            System.assertEquals(lstContact[0].Status__c, AP_Constant.conStatusWaitlisted);
        }
    }
}