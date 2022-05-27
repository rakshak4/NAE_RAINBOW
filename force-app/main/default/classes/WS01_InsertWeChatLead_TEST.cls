/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for WS01_InsertWeChatLead
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 11-MAY-2018  AMU   1.0     Initial Version
-- 17-JUL-2018  WCH   1.1     Corrections 
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
public with sharing class WS01_InsertWeChatLead_TEST {
    static List<User> lstUser;
    static List<Lead> lstLead;
    static List<School__c> lstSchool;

    static {
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{TestFactory.createSchool('Test school', 'test address', true, 'NHK')};
            insert lstSchool;
        }
    }

    @isTest public static void createLeadTest(){
        System.runAs(lstUser[0]){
            Lead lead = TestFactory.createLead(null, 'test1lname', 'test1fname', 'testchildfname', 'testchildlname', 'Male', Date.newInstance(2000, 12, 22));
            lead.Company = 'test company';
            lead.School_Code__c = lstSchool[0].SchoolCode__c;
            lead.WeChatCampaignName__c = 'Test campaign';
            lead.SubmittedDateofEnquiry__c = Date.newInstance(2018, 5, 6);
            //lead.WeChatUserId__c = 'asdf1rt234';
            lead.WeChatExternalID__c = 'asdf1rt234';
            
            lead.WeChatCustomerJourney__c = 'asdf1234';
            lead.Parent1FirstName__c = 'parent1 fname';
            lead.Parent1LastName__c = 'parent1 lname';

            test.StartTest();
                List<Map<String, String>> lstResult = WS01_InsertWeChatLead.updateCreateLead(new List<Lead>{lead});
            test.StopTest();

            String status = lstResult[0].get('status');
            String success = lstResult[0].get('success');
            System.assertEquals(status, '200');
            System.assertEquals(success, Label.RecordCreateSuccessMessage);
        }
    }

    @isTest public static void updateLeadTest(){
        System.runAs(lstUser[0]){
            Lead lead = TestFactory.createLead(null, 'testLname', 'testFname', 'testchildfname', 'testchildlname', 'Male', Date.newInstance(2000, 12, 22));
            lead.Company = 'test company';
            lead.School_Code__c = lstSchool[0].SchoolCode__c;
            lead.WeChatCampaignName__c = 'Test campaign';
            lead.SubmittedDateofEnquiry__c = Date.newInstance(2018, 5, 6);
            //lead.WeChatUserId__c = 'asdf1rt234';
            lead.Parent1MobilePhone__c = '1235';
            lead.WeChatCustomerJourney__c = 'asdf1234';
            lead.Parent1FirstName__c = 'Wechat parent1';
            lead.Parent1LastName__c = 'Wechat parent1 lname';
            lead.isExternalSource__c=true;
            lead.WeChatExternalID__c = 'NHK1235';
            lstLead = new List<Lead>{lead};
            insert lstLead;

            test.StartTest();
            	lstLead[0].WeChatExternalID__c = '';
                List<Map<String, String>> lstResult = WS01_InsertWeChatLead.updateCreateLead(lstLead);
            test.StopTest();
			List<Lead> ls = [SELECT WeChatExternalID__c FROM Lead where id =:lstLead[0].Id];
            String status = lstResult[0].get('status');
            String success = lstResult[0].get('success');
            System.assertEquals(status, '200');
            System.assertEquals(success, Label.RecordUpdateSuccessMessage);
        }
    }
}