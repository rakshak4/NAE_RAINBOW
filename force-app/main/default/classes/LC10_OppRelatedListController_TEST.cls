/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for LC10_OppRelatedListController
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 10-OCT-2018  KZE    1.0     Initial version
--------------------------------------------------------------------------------------
**********************************************************************************/
@isTest
public with sharing class LC10_OppRelatedListController_TEST {
	static Map<string,Id> mapRecordType;
    static User usrTestAdmin;
    static List<Contact> lstContact;
    static List<School__c> lstSchool;
    static List<Opportunity> lstOpp;
    static List<Opportunity> lstOppGOT;
    static Account acc;
    static {
	    lstSchool = new List<School__c>{
	        TestFactory.createSchool('TestSchool1', 'Mauritius', false, 'TST'),
	        TestFactory.createSchool('TestSchool2', 'Mauritius', false, 'LOL')
	    };
	    insert lstSchool;
        
        usrTestAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        usrTestAdmin.SchoolCode__c = 'LOL';
        insert usrTestAdmin;

        System.runAs(usrTestAdmin){
        	mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

            acc = TestFactory.createAccount('Henry Family');
            insert acc;

            //creating contact
            lstContact = new List <Contact> {
                TestFactory.createContact('Jones Henry', acc.Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),//0
                TestFactory.createContact('Joe Henry', acc.Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            insert lstContact;

        	lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testOpp01', acc.Id, AP_Constant.oppStageNameActive,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp02', acc.Id, AP_Constant.oppStageNameAcceptance,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
            lstOpp[0].Child__c = lstContact[1].Id;
            lstOpp[1].Child__c = lstContact[1].Id;
            insert lstOpp;
        }
    }
    @isTest
    static void getOpportunitiesTest() {
        System.runAs(usrTestAdmin) {
        	Map<String, Object> mapResult;
        	test.startTest();      
	        	mapResult = (Map<String, Object>)LC10_OpportunityRelatedListController.getOpportunities(lstContact[1].Id);
            test.stopTest();

            lstOppGOT = (List<Opportunity>) mapResult.get('lstOpp');

        	System.assertEquals(lstOppGOT.size(),2);
        }
    } 
    @isTest
    static void deleteOppTest() {
        System.runAs(usrTestAdmin) { 
        	String oppDeletedName;
        	test.startTest();      
	        	oppDeletedName = LC10_OpportunityRelatedListController.deleteOpp(lstOpp[1].Id);
            test.stopTest();

        	System.assertEquals(oppDeletedName,'testOpp02');
        }
    } 
    @isTest
    static void pepopulateNewOppTest() {
        System.runAs(usrTestAdmin) { 
        	test.startTest();      
	        	Opportunity opp = (Opportunity)LC10_OpportunityRelatedListController.pepopulateNewOpp(lstContact[1].Id, AP_Constant.oppRecordTypeDeveloperNameEnrolment);
            test.stopTest();
        }
    }
}