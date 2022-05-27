/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP33_LeadTaskActivityDate
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 22-JUN-2021  FKH    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class AP33_LeadTaskActivityDate_TEST {
    static List<User> lstUser;
    static List<Lead> lstLead;
    static List<Task> lstTask;
    static List<Task> lstTaskOrig;
    static Map<String,Id> mapRecordType;

    static {
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        lstUser[0].Schoolcode__c = 'XXX';
        insert lstUser;

        System.runAs(lstUser[0]){
            lstLead = new List<Lead>{
                TestFactory.createLead( null, 'Test', 'Tester', 'childfname', 'childlname', 'Male', Date.newInstance(2010, 2, 2)),
                TestFactory.createLead( null, 'Test1', 'Tester1', 'childfname1', 'childlname1', 'Male', Date.newInstance(2010, 2, 2)),
                TestFactory.createLead( null, 'Test12', 'Tester12', 'childfname12', 'childlname21', 'Male', Date.newInstance(2010, 2, 2))

            };                     

            lstLead[0].Parent1PrimaryEmail__c = 'user@test.com';
            lstLead[0].Parent1CountryOfResidence__c = 'France';

            lstLead[0].Parent2FirstName__c = 'Jean';
            lstLead[0].Parent2LastName__c = 'Curi';
            lstLead[0].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[0].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[0].Parent2CountryOfResidence__c = 'France';
            lstLead[0].Parent2Nationality__c = 'French';

            lstLead[0].FirstNamefirstChild__c = 'fifFname';
            lstLead[0].LastNamefirstChild__c = 'fifLname';
            lstLead[0].DateOfBirthfirstChild__c =Date.newInstance(2010, 2, 2);
            lstLead[0].EnrollmentDatefirstChild__c = Date.newInstance(2019, 2, 2);
            lstLead[0].GenderfirstChild__c = 'Male';
            lstLead[0].MarketingQualifiedfirstChild__c = true;
            lstLead[0].DayOrBoardingSchoolfirstChild__c = 'Day';

            lstLead[1].Parent1PrimaryEmail__c = 'user1@test.com';
            lstLead[1].Parent1CountryOfResidence__c = 'France';

            lstLead[1].Parent2FirstName__c = 'Jean1';
            lstLead[1].Parent2LastName__c = 'Curi1';
            lstLead[1].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[1].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[1].Parent2CountryOfResidence__c = 'France';
            lstLead[1].Parent2Nationality__c = 'French';
            lstLead[1].FirstActivityDate__c = Datetime.newInstance(2008, 12, 1, 12, 30, 2);

            lstLead[2].Parent1PrimaryEmail__c = 'user1@test.com';
            lstLead[2].Parent1CountryOfResidence__c = 'France';
            lstLead[2].Parent2FirstName__c = 'Jean1';
            lstLead[2].Parent2LastName__c = 'Curi1';
            lstLead[2].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[2].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[2].Parent2CountryOfResidence__c = 'France';
            lstLead[2].Parent2Nationality__c = 'French';

            insert lstLead;

            lstTaskOrig = new List<Task>{
                TestFactory.createTask('task3')
            };
            lstTaskOrig[0].whoId = lstLead[2].id;

            insert lstTaskOrig;

            lstLead[2].FirstActivityDate__c = null;
            update lstLead;




        }
    }

    @isTest public static void updateFirstActivityDateTest(){
        System.runAs(lstUser[0]){
            test.StartTest();
            lstTask = new List<Task>{
                TestFactory.createTask('task1'),
                TestFactory.createTask('task2'),
                TestFactory.createTask('task3')

            };
            lstTask[0].whoId = lstLead[0].id;
            lstTask[1].whoId = lstLead[1].id;
            lstTask[2].whoId = lstLead[2].id;

            insert lstTask;

            test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT Id, FirstActivityDate__c FROM lead WHERE id IN: lstLead];
            System.assertNotEquals(lstUpdatedLead[0].FirstActivityDate__c,null);
            System.assertEquals(lstUpdatedLead[1].FirstActivityDate__c,lstLead[1].FirstActivityDate__c);
            System.assertEquals(lstUpdatedLead[2].FirstActivityDate__c,null);

        }
    }
}