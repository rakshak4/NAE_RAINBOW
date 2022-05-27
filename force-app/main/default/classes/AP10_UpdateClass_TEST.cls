/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP10_UpdateClass
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 01-AUG-2018  AMU   1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
public with sharing class AP10_UpdateClass_TEST {
    static List<User> lstUser;
    static List<Class__c> lstClasses;
    static List<YearGrade__c> lstYearGrade;
    static List<EnrolmentPeriod__c> lstEnrolmentPeriod;
    static List<Contact> lstContact;
    static List<School__c> lstSchool;
    static List<Opportunity> lstOpp;
    static List<Account> lstAcc;

    static {
        Map<String,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

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
            };
            lstContact[0].Gender__c = AP_Constant.conGenderMale;
            lstContact[1].Gender__c = AP_Constant.conGenderMale;
            lstContact[2].Gender__c = AP_Constant.conGenderFemale;
            lstContact[3].Gender__c = AP_Constant.conGenderFemale;
            lstContact[4].Gender__c = AP_Constant.conGenderFemale;
            insert lstContact;

            lstEnrolmentPeriod = new List<EnrolmentPeriod__c>{
                TestFactory.createEnrolmentPeriod('Semester 1', lstSchool[0].Id, 'YR18', Date.newInstance(2018, 1, 1), Date.newInstance(2019, 1, 1))
            };
            insert lstEnrolmentPeriod;

            lstYearGrade = new List<YearGrade__c>{
                TestFactory.createYearGrade('Group 2018 Junior', lstSchool[0].Id, 10, 15, lstEnrolmentPeriod[0].Id)
            };
            insert lstYearGrade;

            lstClasses = new List<Class__c>{
                TestFactory.createClass('Test1',  50, lstYearGrade[0].Id, lstSchool[0].Id)
                ,TestFactory.createClass('Test2', 100, lstYearGrade[0].Id, lstSchool[0].Id)
            };
            insert lstClasses;

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testopp1', lstAcc[0].Id, AP_Constant.oppStageNameVisit, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testopp2', lstAcc[0].Id, AP_Constant.oppStageNameOfferOut, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testopp3', lstAcc[0].Id, AP_Constant.oppStageNameStarted, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testopp4', lstAcc[0].Id, AP_Constant.oppStageNameDenied, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testopp5', lstAcc[0].Id, AP_Constant.oppStageNameLost, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
            
            lstOpp[0].Child__c = lstContact[0].Id;
            lstOpp[1].Child__c = lstContact[1].Id;
            lstOpp[2].Child__c = lstContact[2].Id;
            lstOpp[3].Child__c = lstContact[3].Id;
            lstOpp[4].Child__c = lstContact[4].Id;
            
            lstOpp[3].LostDeniedOnHoldReason__c = 'Financial';
            lstOpp[4].LostDeniedOnHoldReason__c = 'Financial';

            insert lstOpp;
        }
    }

    @isTest public static void updateclsNewTest(){
        for(Opportunity opp: lstOpp) {
            opp.Class__c = lstClasses[0].Id;
            opp.EnrolmentPeriod__c = lstEnrolmentPeriod[0].Id;
            opp.YearGrade__c = lstYearGrade[0].Id;
        }

        System.runAs(lstUser[0]){
            test.StartTest();
                update lstOpp;
            test.StopTest();

            Class__c cls = [SELECT Id, FemaleCount__c, MaleCount__c FROM Class__c WHERE 
                                                Id =: lstClasses[0].Id LIMIT 1];
            System.assertEquals(cls.FemaleCount__c, 3);
            System.assertEquals(cls.MaleCount__c, 2);
        }
    }

     @isTest public static void updateclsNewOldTest(){
        for(Opportunity opp: lstOpp) {
            opp.Class__c = lstClasses[0].Id;
            opp.EnrolmentPeriod__c = lstEnrolmentPeriod[0].Id;
            opp.YearGrade__c = lstYearGrade[0].Id;
        }
        update lstOpp;

        for(Opportunity opp: lstOpp) {
            opp.Class__c = lstClasses[1].Id;
        }

        System.runAs(lstUser[0]){
            test.StartTest();
                update lstOpp;
            test.StopTest();

            List<Class__c> lstClasses = [SELECT Id, FemaleCount__c, MaleCount__c FROM Class__c WHERE 
                                                        Id IN: lstClasses Order By Name];
            System.assertEquals(lstClasses[0].FemaleCount__c, 0);
            System.assertEquals(lstClasses[0].MaleCount__c, 0);
            System.assertEquals(lstClasses[1].FemaleCount__c, 3);
            System.assertEquals(lstClasses[1].MaleCount__c, 2);
        }
    }
}