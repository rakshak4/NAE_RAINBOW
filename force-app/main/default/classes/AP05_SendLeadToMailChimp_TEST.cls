/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP05_SendLeadToMailChimp
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 10-Jul-2018  AMU    1.1      Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
global class AP05_SendLeadToMailChimp_TEST {
    static List<User> lstUser;
    static List<School__c> lstSchool;
    static List<Mailchimp__c> lstMailchimp;
    static List<Lead> lstLead;

    static {
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST'),
                TestFactory.createSchool('TestMSchool', 'Mauritius', false, 'TSM')
            };
            insert lstSchool;

            lstMailchimp = new List<Mailchimp__c>{
                TestFactory.createMailChimp(lstSchool[0].Id, 'key', 'list', 'group'),
                TestFactory.createMailChimp(lstSchool[1].Id, 'key', 'list', 'group')
            };

            lstMailchimp[0].URL__c = 'https://us18.api.mailchimp.com/3.0/batches';
            lstMailchimp[1].URL__c = 'https://us18.api.mailchimp.com/3.0/batches';

            insert lstMailchimp;

            lstLead = new List<Lead>{
                TestFactory.createLead(
                    null, 'Test', 'Tester', 'childfname', 'childlname', 'Male', Date.newInstance(2010, 2, 2)
                ),
                TestFactory.createLead(
                    null, 'Test1', 'Tester1', 'childfname1', 'childlname1', 'Female', Date.newInstance(2010, 2, 2)
                ),
                TestFactory.createLead(
                    null, 'Test2', 'Tester2', 'childfname2', 'childlname2', 'Female', Date.newInstance(2010, 2, 2)
                )
            };

            lstLead[0].Parent1FirstName__c = 'Marie';
            lstLead[0].Parent1LastName__c = 'Curi';
            lstLead[0].Parent1PrimaryEmail__c = 'user@test.com';
            lstLead[0].Parent1HomePhone__c = '2143314';
            lstLead[0].Parent1CountryOfResidence__c = 'France';
            lstLead[0].Parent1Nationality__c = 'French';
            lstLead[0].Parent2FirstName__c = 'Jean';
            lstLead[0].Parent2LastName__c = 'Curi';
            lstLead[0].Parent2PrimaryEmail__c = 'user@test.com';
            lstLead[0].Parent2HomePhone__c = '2143314';
            lstLead[0].Parent2CountryOfResidence__c = 'France';
            lstLead[0].Parent2Nationality__c = 'French';
            lstLead[0].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[1].Parent1FirstName__c = 'Sammy';
            lstLead[1].Parent1LastName__c = 'Curi';
            lstLead[1].Parent1PrimaryEmail__c = 'usersammy@test.com';
            lstLead[1].Parent1HomePhone__c = '214331423';
            lstLead[1].Parent1CountryOfResidence__c = 'France';
            lstLead[1].Parent1Nationality__c = 'French';
            lstLead[1].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[2].Parent1FirstName__c = 'Fun';
            lstLead[2].Parent1LastName__c = 'Curi';
            lstLead[2].Parent1PrimaryEmail__c = 'userfun@test.com';
            lstLead[2].Parent1HomePhone__c = '214331423';
            lstLead[2].Parent1CountryOfResidence__c = 'France';
            lstLead[2].Parent1Nationality__c = 'French';
            lstLead[2].SchoolOfInterest__c = lstSchool[1].Id;

            insert lstLead;
        }
    }

    @isTest public static void sendToMailChimpTest(){
        System.runAs(lstUser[0]) {
            test.StartTest();
                Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
                AP05_SendLeadToMailChimp.sendToMailChimp(lstLead);
            test.StopTest();

            lstLead = [SELECT TECH_MCResponse__c FROM Lead WHERE Id IN : lstLead];
            System.assertEquals(lstLead[0].TECH_MCResponse__c, 'Lead parent details sent to MailChimp successfully');
        }
    }

    @isTest public static void sendToMailChimpFailTest(){
        System.runAs(lstUser[0]) {
            test.StartTest();
                Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorFail());
                AP05_SendLeadToMailChimp.sendToMailChimp(lstLead);
            test.StopTest();

            lstLead = [SELECT TECH_MCResponse__c FROM Lead WHERE Id IN : lstLead];
            System.assertNotEquals(lstLead[0].TECH_MCResponse__c, 'Lead parent details sent to MailChimp successfully');
        }
    }
    
    global class MockHttpResponseGenerator implements HttpCalloutMock {
        global HTTPResponse respond(HTTPRequest req) {
            Map<String, Object> response = new Map<String, Object>{'success' => true}; 

            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(JSON.serialize(response));
            res.setStatusCode(200);
            return res;
        }
    }

    global class MockHttpResponseGeneratorFail implements HttpCalloutMock {
        global HTTPResponse respond(HTTPRequest req) {
            Map<String, Object> response = new Map<String, Object>{'success' => true}; 

            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(JSON.serialize(response));
            res.setStatusCode(403);
            return res;
        }
    }
}