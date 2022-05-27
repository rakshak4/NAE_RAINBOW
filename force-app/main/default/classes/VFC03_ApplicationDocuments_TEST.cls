/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for C03_ApplicationDocuments
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 27-JUL-2018  AMU     1.0     Get list of Application documents for a particular school
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class VFC03_ApplicationDocuments_TEST {
	static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User testUserAdmin;
    static Account account;
    static List<School__c> lstSchool;
    static List<ApplicationDocument__c> lstAppDoc;

    static {
        //creating user
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        testUserAdmin.SchoolCode__c = 'PPE';
        insert testUserAdmin;

        System.runAs(testUserAdmin){

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject});
            //creating account
            account = TestFactory.createAccount('Henry Family');
            insert account;

            //creating school
            lstSchool = new List<School__c> {
                TestFactory.createSchool('Petit Verger School', 'Petit Verger', false, 'PVS'),
                TestFactory.createSchool('Le Petit Pouce Elementary School', 'Vivéa Business Park', false, 'PPE')
            };
            insert lstSchool;

            // creating application document
            lstAppDoc = new List<ApplicationDocument__c> {
                TestFactory.createApplicationDoc('Birth Certificate', lstSchool[0].Id, true, 'Application'), 
                TestFactory.createApplicationDoc('Transcript', lstSchool[0].Id, false, 'Acceptance'), 
                TestFactory.createApplicationDoc('Passport copy', lstSchool[0].Id, null, null), 
                TestFactory.createApplicationDoc('Health report' , lstSchool[1].Id, true, null), 
                TestFactory.createApplicationDoc('Transfert certificate', lstSchool[1].Id, false, 'Enrolled'), 
                TestFactory.createApplicationDoc('Resident proof', lstSchool[1].Id, null, 'Acceptance'), 
                TestFactory.createApplicationDoc('Application fee', lstSchool[1].Id, false, 'Application') 
            };
            insert lstAppDoc;
        }
    }

    @isTest
    static void getApplicationDocumentsTest() {
        System.runAs(testUserAdmin){            
            Test.startTest();
           		List<ApplicationDocument__c> lstAppDocs = new VFC03_ApplicationDocuments().getAppDocs();
            Test.stopTest();
            System.assertEquals(lstAppDocs.size(), 4);
        }
    }
}