/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for LC05_ConvertLead
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 11-Jul-2018  AMU    1.1      Initial version
-- 18-FEB-2021  VJA     1.1     Added day of boarding to all lead records
-- 02-Mar-2021  VJA    1.2      Cater for EmailMessage
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
public with sharing class LC05_ConvertLead_TEST {
    static List<User> lstUser;
    static List<Lead> lstLead;
    static List<School__c> lstSchool;
    static List<Task> lstTasks;
    static List<Event> lstEvents;
    static List<EmailMessage> lstEmailMessages;
    static List<Account> lstAcc;

    static {
        lstUser = new List<User>{TestFactory.createUser('TestUserAd', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST')
            };
            insert lstSchool;

            lstLead = new List<Lead>{
                TestFactory.createLead(
                    null, 'Test', 'Tester', 'childlname', 'childfname', 'Male', Date.newInstance(2010, 2, 2)
                )
            };

            lstLead[0].Parent2FirstName__c = 'Jean';
            lstLead[0].Parent2LastName__c = 'Curi';
            lstLead[0].Parent2NatureOfRelationship__c = AP_Constant.ledNatureOfRelationshipFather;
            lstLead[0].Parent2PrimaryEmail__c = 'user@test.com';
            lstLead[0].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[0].Parent2CountryOfResidence__c = 'France';
            lstLead[0].Parent2Nationality__c = 'French';

            lstLead[0].Lead_Origin__c = AP_Constant.ledOriginAdmissionsStage1;
            lstLead[0].LeadSource='Offline';
            lstLead[0].Number_of_Children__c = '1';

            lstLead[0].MarketingQualifiedFirstChild__c = true;
            lstLead[0].EnrollmentDateFirstChild__c = Date.newInstance(2019, 2, 2);
            lstLead[0].PreferredNameFirstChild__c = 'tom';
            lstLead[0].DayOrBoardingSchoolFirstChild__c = 'Day'; //VJA20210218

            lstLead[0].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[0].Company = 'testComp';
            lstLead[0].isExternalSource__c=true;
            insert lstLead;

            lstAcc = new List<Account>{
                TestFactory.createFamilyAccount('Acc')
            };
            insert lstAcc;

            lstEvents = new List<Event>{
                TestFactory.createEvent('event1', 10, Datetime.newInstanceGmt(2018, 8, 1)),
                TestFactory.createEvent('event2', 15, Datetime.newInstanceGmt(2019, 8, 1))
            };

            lstTasks = new List<Task>{
                TestFactory.createTask('task1'),
                TestFactory.createTask('task2')
            };

            lstEmailMessages = new List<EmailMessage>{ //VJA20210302
                TestFactory.createEmailMessage('Invest', 'Test'),
                TestFactory.createEmailMessage('Buy', 'Bitcoins')
            };
        }
    }

    @isTest public static void updateCloneActivitiesTest(){
        System.runAs(lstUser[0]) {
            test.StartTest();
                LC05_ConvertLead.Activity activity = new LC05_ConvertLead.Activity(lstTasks, lstEvents, lstEmailMessages); //VJA20210302
                LC05_ConvertLead.updateCloneActivities(activity, lstAcc[0].Id);
            test.StopTest();

            List<Event> lstEvts = [SELECT WhatId FROM Event WHERE Subject =:lstEvents[0].Subject];
            System.assertEquals(lstEvts[0].WhatId, lstAcc[0].Id);
        }
    }

    @isTest public static void convertLeadFailTest(){
        System.runAs(lstUser[0]) {
            test.StartTest();
            try {
                 LC05_ConvertLead.convertLead(lstLead[0].Id);
            } catch(AuraHandledException e) {
                System.assertNotEquals(e.getMessage(), null);
            }
            test.StopTest();
        }
    }

    @isTest public static void convertLeadTest(){
        lstLead[0].Status = AP_Constant.ledStatusQualified;
        update lstLead;

        System.runAs(lstUser[0]) {
            test.StartTest();
                try {
                     LC05_ConvertLead.convertLead(lstLead[0].Id);
                } catch(AuraHandledException e) {
                    System.assertEquals(e.getMessage(), null);
                }
            test.StopTest();

            List<Account> accList  = [SELECT Name from Account];
            System.assertEquals(accList.size(), 2);
        }
    }


    @isTest public static void convertLeadWithTaskTest(){
        lstLead[0].Status = AP_Constant.ledStatusQualified;
        update lstLead;
        
        lstTasks[0].WhoId = lstLead[0].Id;
        lstTasks[1].WhoId = lstLead[0].Id;
        insert lstTasks;
        System.runAs(lstUser[0]) {
            test.StartTest();
                try {
                     LC05_ConvertLead.convertLead(lstLead[0].Id);
                } catch(AuraHandledException e) {
                    System.assertEquals(e.getMessage(), null);
                }
            test.StopTest();

            List<Account> accList  = [SELECT Id, Name from Account where Name != 'Acc'];
            System.assertEquals(accList.size(), 1);
            List<Task> tsList = [SELECT Subject, WhatId, WhoId, OriginLeadDate__c from Task];
            //System.assertEquals(tsList.size(), 0);
            System.assertEquals(tsList[0].WhatId, accList[0].Id);
            //System.assertEquals(tsList[0].OriginLeadDate__c, lstTasks[0].CreatedDate);
        }
    }

    //VJA20210302
    @isTest public static void convertLeadWithEventTest(){
        lstLead[0].Status = AP_Constant.ledStatusQualified;
        update lstLead;
        
        lstEvents[0].WhoId = lstLead[0].Id;
        lstEvents[1].WhoId = lstLead[0].Id;
        insert lstEvents;
        System.runAs(lstUser[0]) {
            test.StartTest();
                try {
                     LC05_ConvertLead.convertLead(lstLead[0].Id);
                } catch(AuraHandledException e) {
                    System.assertEquals(e.getMessage(), null);
                }
            test.StopTest();

            List<Account> accList  = [SELECT Id, Name from Account where Name != 'Acc'];
            System.assertEquals(accList.size(), 1);
            List<Event> evtList = [SELECT Subject, WhatId, WhoId, OriginLeadDate__c from Event];
            System.assertEquals(evtList[0].WhatId, accList[0].Id);
        }
    }
}