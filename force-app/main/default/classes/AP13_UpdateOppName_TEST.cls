/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test Apex class for contact trigger to update opportunity name with 
--					 related contact name
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 21-SEPT-2018  YGO    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class AP13_UpdateOppName_TEST {
	
	static List<User> lstUser;
	static List<Account> lstAcc;
	static List<Contact> lstCon;
	static List<Opportunity> lstOpp;
	static List<School__c> lstSchool;
	static Map<String, Id> mapRecordType;

	static{
		lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
        	lstAcc = new List<Account>{
        								TestFactory.createAccount('test12')};
        	insert lstAcc;

        	lstSchool = new List<School__c>{
        								TestFactory.createSchool('le cateau vert', 'St pierre', true, 'PPE')};
        	insert lstSchool;
        	
        	mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        	lstCon = new List<Contact>{
        								TestFactory.createContact('testLastname', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))};
        	insert lstCon;
        	
        	lstOpp = new List<Opportunity>{
        									TestFactory.createOpportunity('opptest', lstAcc[0].Id, AP_Constant.oppStageEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)};
        	lstOpp[0].Child__c = lstCon[0].Id;
        	insert lstOpp;								
        }
	}

	@isTest
    public static void updateOppNameTest(){

    	lstCon[0].lastName = 'testupdateCon';

    	Test.startTest();
    		update lstCon;
    	Test.stopTest();

    	Opportunity opp = [SELECT Id, Name, Child__c FROM Opportunity WHERE Child__c = :lstCon[0].Id];

    	System.assertEquals(opp.Name, lstCon[0].lastName);
    }
}