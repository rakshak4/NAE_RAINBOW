@isTest
public class AP03_MergeDuplicateLeads_TEST {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : TEST class for AP03_MergeDuplicateLeads
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 30-JAN-2018  RRAJ    1.0     Initial version
-- 17-JUL-2018  WCH     1.1     Corrections to adjust modifications done+increase code coverage
--------------------------------------------------------------------------------------
***************************************************************************************/
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User testUserAdmin;
    static List<Lead> lstLedIns = new List<Lead>();
    static List<Lead> lstLedTest = new List<Lead>();
    static School__c testSchl = new School__c();
    
    static{
        //creating user
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert testUserAdmin;

        System.runAs(testUserAdmin){
            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject});

            //creating school
            testSchl = TestFactory.createSchool('testSchool', 'Port Louis', true, 'XXX');
            //testSchl.School_Code__c = 'tst';
            insert testSchl;

            //creating leads
            lstLedIns.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), '1test', 'Lead1', 'test Child1', 'test Child1', AP_Constant.ledGenderMale, Date.newInstance(2012, 2, 25)));
            lstLedIns[0].ExternalId__c = 'Lead 1-lead1@mail.com-1234567890-30/01/2018';
            lstLedIns[0].School_Code__c = testSchl.SchoolCode__c;
            lstLedIns[0].Company = 'testCompany';
            lstLedIns[0].isExternalSource__c=true;
            lstLedIns.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), '2test', 'Lead2', 'test Child3', 'test Child3', AP_Constant.ledGenderMale, Date.newInstance(2014, 12, 5)));
            lstLedIns[1].ExternalId__c = 'Lead 2-lead2@mail.com-1234567890-30/01/2018';
            lstLedIns[1].School_Code__c = testSchl.SchoolCode__c;
            lstLedIns[1].Company = 'testCompany';
            lstLedIns[1].isExternalSource__c=true;
            lstLedIns.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), '3test', 'Lead3', 'test Child3', 'test Child3', AP_Constant.ledGenderMale, Date.newInstance(2010, 4, 13)));
            lstLedIns[2].ExternalId__c = 'Lead 3-lead3@mail.com-1234567890-30/01/2018';
            lstLedIns[2].School_Code__c = testSchl.SchoolCode__c;
            lstLedIns[2].Company = 'testCompany';
            lstLedIns[2].isExternalSource__c=true;
            lstLedIns.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), '4test', 'Lead4', 'test Child4', 'test Child4', AP_Constant.ledGenderMale, Date.newInstance(2008, 6, 15)));
            lstLedIns[3].ExternalId__c = 'Lead 4-lead4@mail.com-1234567890-30/01/2018';
            lstLedIns[3].School_Code__c = testSchl.SchoolCode__c;
            lstLedIns[3].Company = 'testCompany';
            lstLedIns[3].isExternalSource__c=true;
            lstLedIns.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), '5test', 'Lead5', 'test Child5', 'test Child5', AP_Constant.ledGenderMale, Date.newInstance(2006, 8, 9)));
            lstLedIns[4].ExternalId__c = 'Lead 5-lead6@mail.com-1234567890-30/01/2018';
            lstLedIns[4].School_Code__c = testSchl.SchoolCode__c;
            lstLedIns[4].Company = 'testCompany';
            lstLedIns[4].isExternalSource__c=true;
            lstLedIns[4].Send_Acknowledgement__c = true;
            insert lstLedIns;

            lstLedTest.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), '1test', 'Lead1', null, null, null, null));
            lstLedTest[0].LeadSource = AP_Constant.ledSrcWebform;
            lstLedTest[0].School_Code__c = testSchl.SchoolCode__c;
            lstLedtest[0].Company = 'testCompany';
            lstLedTest[0].ExternalId__c = 'Lead 1-lead1@mail.com-1234567890-30/01/2018';
            lstLedTest[0].isExternalSource__c=true;
            lstLedTest.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), '2test', 'Lead2', null, null, null, null));
            lstLedTest[1].LeadSource = AP_Constant.ledSrcWebform;
            lstLedTest[1].School_Code__c = testSchl.SchoolCode__c;
            lstLedtest[1].Company = 'testCompany';
            lstLedTest[1].ExternalId__c = 'Lead 2-lead2@mail.com-1234567890-30/01/2018';
            lstLedTest[1].isExternalSource__c=true;
            //System.debug('### lstLedTest: '+ lstLedTest);
        }
    }

    @isTest
    static void testMergeDuplicates(){
        System.runAs(testUserAdmin){
            List<Lead> lstLedInserted = [SELECT LastName, FirstName, ExternalId__c FROM Lead ORDER BY LastName ASC];
///            system.debug('lstLedInserted>>'+lstLedInserted);
            Test.startTest();
            insert lstLedTest;
            Test.stopTest();

            lstLedInserted = [SELECT LastName, FirstName, ExternalId__c FROM Lead ORDER BY LastName ASC];
            //system.debug('lstLedInserted>>'+lstLedInserted);

        }
    }
}