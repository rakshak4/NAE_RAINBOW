/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test Apex class for opportunity trigger to store previous stage 
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 16-JUL-2018  RRAJ    1.0     Initial version
-- 18-FEB-2021  VJA     1.1     Added day of boarding to all lead records
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class AP12_AutoConvertLead_TEST {
	
    static List<User> lstUser;
    static List<Lead> lstLead;
    static List<Lead> lstLeadWithActs;
    static List<Task> lstTasks;

    static {
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId()),
        TestFactory.createUser('Test2', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstLead = new List<Lead>{
                TestFactory.createLead(
                    null, 'Test', 'Tester', 'childfname', 'childlname', 'Male', Date.newInstance(2010, 2, 2)
                )
                ,TestFactory.createLead(
                    null, 'Test1', 'Tester1', 'childfname1', 'childlname1', 'Female', Date.newInstance(2010, 2, 2)
                )
                ,TestFactory.createLead(
                    null, 'Test2', 'Tester2', 'childfname2', 'childlname2', 'Male', Date.newInstance(2015, 6, 21)
                )
                ,TestFactory.createLead(
                    null, 'Test3', 'Tester3', 'childfname3', 'childlname3', 'Female', Date.newInstance(2013, 8, 4)
                )
                ,TestFactory.createLead(
                    null, 'Test4', 'Tester4', 'childfname4', 'childlname4', 'Male', Date.newInstance(2012, 9, 30)
                )
            };

            lstLead[0].Parent1CountryOfResidence__c = 'France';
            lstLead[0].Parent1Nationality__c = 'Australian';
            lstLead[0].DayOrBoardingSchoolFirstChild__c = 'Day'; 

            lstLead[1].Parent1CountryOfResidence__c = 'United Arab Emirates';
            lstLead[1].Parent1Nationality__c = 'Australian';
            lstLead[1].DayOrBoardingSchoolFirstChild__c = 'Day';  

            lstLead[2].Parent1CountryOfResidence__c = 'Afghanistan';
            lstLead[2].Parent1Nationality__c = 'Australian';
            lstLead[2].DayOrBoardingSchoolFirstChild__c = 'Day';  

            lstLead[3].Parent1CountryOfResidence__c = 'Cambodia';
            lstLead[3].Parent1Nationality__c = 'Australian';
            lstLead[3].DayOrBoardingSchoolFirstChild__c = 'Day';  

            lstLead[4].Parent1CountryOfResidence__c = 'Philippines';
            lstLead[4].Parent1Nationality__c = 'Australian';
            lstLead[4].DayOrBoardingSchoolFirstChild__c = 'Day';  

            lstLeadWithActs = new List<Lead>{
                TestFactory.createLead(null, 'Test', 'Tester', 'childfname', 'childlname', 'Male', Date.newInstance(2010, 2, 2))
                ,TestFactory.createLead(null, 'Test', 'Tester', 'childfname', 'childlname', 'Male', Date.newInstance(2010, 2, 2))
                ,TestFactory.createLead(null, 'Test', 'Tester', 'childfname', 'childlname', 'Male', Date.newInstance(2010, 2, 2))
            };
            lstLeadWithActs[0].Parent1CountryOfResidence__c = 'France';
            lstLeadWithActs[0].Parent1Nationality__c = 'Australian';
            lstLeadWithActs[0].DayOrBoardingSchoolFirstChild__c = 'Day';

            lstLeadWithActs[1].Parent1CountryOfResidence__c = 'France';
            lstLeadWithActs[1].Parent1Nationality__c = 'Australian';
            lstLeadWithActs[1].DayOrBoardingSchoolFirstChild__c = 'Day';  

            lstLeadWithActs[2].Parent1CountryOfResidence__c = 'France';
            lstLeadWithActs[2].Parent1Nationality__c = 'Australian';
            lstLeadWithActs[2].DayOrBoardingSchoolFirstChild__c = 'Day';  
            insert lstLeadWithActs;



            lstTasks = new List<Task>{
                TestFactory.createTask('task1'),
                TestFactory.createTask('task2'),
                TestFactory.createTask('task2'),
                TestFactory.createTask('task2')
            };
            lstTasks[0].whoid=lstLeadWithActs[0].id;
            lstTasks[1].whoid=lstLeadWithActs[1].id;
            lstTasks[2].whoid=lstLeadWithActs[2].id;
            lstTasks[3].whoid=lstLeadWithActs[2].id;

            insert lstTasks;
        }
    }

    @isTest public static void insertWithoutConv(){
        Test.startTest();
        insert lstLead;
        Test.stopTest();

        List<Lead> lstInsertedLed = [SELECT Id, isConverted FROM Lead WHERE isConverted=False  ORDER BY LastName];

        System.assertEquals(8, lstInsertedLed.size());
        System.assertEquals(false, lstInsertedLed[0].isConverted);
        System.assertEquals(false, lstInsertedLed[1].isConverted);
        System.assertEquals(false, lstInsertedLed[2].isConverted);
        System.assertEquals(false, lstInsertedLed[3].isConverted);
        System.assertEquals(false, lstInsertedLed[4].isConverted);
    }

    @isTest public static void insertWithPartialConv(){
        lstLead[0].AutoConvert__c = true;
        lstLead[1].AutoConvert__c = true;

        Test.startTest();
        insert lstLead;
        Test.stopTest();

        List<Lead> lstInsertedLed = [SELECT Id, Name, isConverted FROM Lead  ORDER BY LastName];

        System.assertEquals(false, lstInsertedLed[0].isConverted);
        System.assertEquals(false, lstInsertedLed[1].isConverted);
        System.assertEquals(false, lstInsertedLed[2].isConverted);
        System.assertEquals(true, lstInsertedLed[3].isConverted);
        System.assertEquals(true, lstInsertedLed[4].isConverted);
    }

    @isTest public static void insertAllConv(){
        lstLead[0].AutoConvert__c = true;
        lstLead[1].AutoConvert__c = true;
        lstLead[2].AutoConvert__c = true;
        lstLead[3].AutoConvert__c = true;
        lstLead[4].AutoConvert__c = true;

        Test.startTest();
        insert lstLead;
        Test.stopTest();

        List<Lead> lstInsertedLed = [SELECT Id, Name, isConverted FROM Lead WHERE isConverted=TRUE ORDER BY LastName];

        System.assertEquals(5, lstInsertedLed.size());
        System.assertEquals(true, lstInsertedLed[0].isConverted);
        System.assertEquals(true, lstInsertedLed[1].isConverted);
        System.assertEquals(true, lstInsertedLed[2].isConverted);
        System.assertEquals(true, lstInsertedLed[3].isConverted);
        System.assertEquals(true, lstInsertedLed[4].isConverted);
    }

    @isTest public static void autoConvertFAApplicationTest(){ //CRA20200110 - Case 2079
        insert lstLead;
        lstLead[0].AutoConvert__c = true;
        lstLead[1].AutoConvert__c = true;
        lstLead[2].AutoConvert__c = true;
        lstLead[3].AutoConvert__c = true;
        lstLead[4].AutoConvert__c = true;
        lstLead[0].Lead_Origin__c = 'FA Application';
        lstLead[1].Lead_Origin__c = 'FA Application';
        lstLead[2].Lead_Origin__c = 'FA Application';
        lstLead[3].Lead_Origin__c = 'FA Application';
        lstLead[4].Lead_Origin__c = 'FA Application';
        lstLead[0].Status = AP_Constant.ledStatusQualified;
        lstLead[1].Status = AP_Constant.ledStatusQualified;
        lstLead[2].Status = AP_Constant.ledStatusQualified;
        lstLead[3].Status = AP_Constant.ledStatusQualified;
        lstLead[4].Status = AP_Constant.ledStatusQualified;

        Test.startTest();
            update lstLead;
        Test.stopTest();

        List<Lead> lstInsertedLed = [SELECT Id, Name, isConverted FROM Lead WHERE isConverted=TRUE ORDER BY LastName];

        System.assertEquals(5, lstInsertedLed.size());
        System.assertEquals(true, lstInsertedLed[0].isConverted);
        System.assertEquals(true, lstInsertedLed[1].isConverted);
        System.assertEquals(true, lstInsertedLed[2].isConverted);
        System.assertEquals(true, lstInsertedLed[3].isConverted);
        System.assertEquals(true, lstInsertedLed[4].isConverted);
    }

    @isTest public static void autoConvertWithTasks(){ //CRA20200110 - Case 2079
        System.runAs(lstUser[1]) {
            test.StartTest();
                try {
                    lstLeadWithActs[0].AutoConvert__c = true;
                    lstLeadWithActs[0].Lead_Origin__c = 'FA Application';
                    lstLeadWithActs[0].Status = AP_Constant.ledStatusQualified;

                    lstLeadWithActs[1].AutoConvert__c = true;
                    lstLeadWithActs[1].Lead_Origin__c = 'FA Application';
                    lstLeadWithActs[1].Status = AP_Constant.ledStatusQualified;

                    lstLeadWithActs[2].AutoConvert__c = true;
                    lstLeadWithActs[2].Lead_Origin__c = 'FA Application';
                    lstLeadWithActs[2].Status = AP_Constant.ledStatusQualified;
                    update lstLeadWithActs;
                } catch(AuraHandledException e) {
                    System.assertEquals(e.getMessage(), null);
                }
            test.StopTest();

            List<Task> tsList = [SELECT Subject, WhatId, WhoId, OriginLeadDate__c from Task];
            System.assertEquals(tsList.size(), 4);
        }
    }
}