/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for LC02_NewLeadForm
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 27-FEB-2019  CRA    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
private class VFC03_VisitReport_TEST {

    static List<User> lstUser;
	static List<Account> lstAcc;
	static List<Contact> lstCon;
	static List<Opportunity> lstOpp;
	static List<School__c> lstSchool;
	static Map<String, Id> mapRecordType;
	static List<DocumentChecklist__c> lstDocChecklist;

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
        			TestFactory.createContact('test child 1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),
        			TestFactory.createContact('test child 2', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),
        			TestFactory.createContact('test parent', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))};
        	lstCon[0].NatureOfRelationship__c = AP_Constant.conNatureRelChild;
			lstCon[0].NativeLanguage__c = 'French';
			lstCon[0].PreferredLanguage__c = 'Spanish';
			lstCon[0].SecondLanguage__c = 'English';
        	lstCon[1].NatureOfRelationship__c = AP_Constant.conNatureRelChild;
        	lstCon[2].NatureOfRelationship__c = AP_Constant.conNatureRelFather;
        	insert lstCon;
        	
        	lstOpp = new List<Opportunity>{
        			TestFactory.createOpportunity('opptest', lstAcc[0].Id, AP_Constant.oppStageNameVisit, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)};
        	lstOpp[0].Child__c = lstCon[0].Id;
        	insert lstOpp;		

        	lstDocChecklist = new List<DocumentChecklist__c>{
        		TestFactory.createDocChecklist('Birth Certificate', lstOpp[0].Id, null),
        		TestFactory.createDocChecklist('Transfert certificate', lstOpp[0].Id, null)
        	};	
        	lstDocChecklist[0].Status__c = AP_Constant.docChklstStatusRequested;
        	lstDocChecklist[0].Stage__c = AP_Constant.docChklstStageVisit;	
        	lstDocChecklist[1].Status__c = AP_Constant.docChklstStatusRequested;
        	lstDocChecklist[1].Stage__c = AP_Constant.docChklstStageApplication;	
        	insert lstDocChecklist;					
        }
	}


    @isTest static void generateVisitReport() {
        PageReference pageRef = Page.VFP03_VisitReport;
        Test.setCurrentPage(pageRef);
        List<Account> acclist=[SELECT id,name,recordtype.name FROM Account ORDER BY createddate DESC limit 1];
        ApexPages.StandardController accController = new ApexPages.StandardController(acclist[0]);
        VFC03_VisitReport controller = new VFC03_VisitReport(accController);
    }

}