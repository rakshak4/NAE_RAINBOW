@isTest
private class LC04_DocumentChecklist_TEST {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test Apex class for lightning component LC04_DocumentChecklist
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 18-JUL-2018  CRA    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
	static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User usrTestAdmin;
    static List<DocumentChecklist__c> lstDocChecklist = new List<DocumentChecklist__c>();
    static Opportunity opp;
    static Account acc;
    static {
        //creating user
        usrTestAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert usrTestAdmin;

        System.runAs(usrTestAdmin){
        	mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject});
        	//creating account
            acc = TestFactory.createAccount('Henry Family');
            insert acc;

        	//creating opportunity
        	opp = TestFactory.createOpportunity('Junior Henry - Enrolment', acc.Id, AP_Constant.oppStageNameEnquiry,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), null);
        	insert opp;
        	//creating DocumentChecklist
        	lstDocChecklist = new List< DocumentChecklist__c > {
        		TestFactory.createDocChecklist('Birth Certificate', opp.Id, null), //0  
        		TestFactory.createDocChecklist('Health report', opp.Id, null),     //1   
        		TestFactory.createDocChecklist('Passport copy', opp.Id, null),     //2
        		TestFactory.createDocChecklist('Residence proof', opp.Id, null),   //3 
        		TestFactory.createDocChecklist('Transcript', opp.Id, null),        //4
        		TestFactory.createDocChecklist('Transfert certificate', opp.Id, null)//5
        	};
        	insert lstDocChecklist;
        }
    }

	@isTest
	static void fetchDocumentCheklistsTest() {
		System.runAs(usrTestAdmin){
			Test.startTest();
			List<DocumentChecklist__c> lstDocChklistResult = LC04_DocumentChecklist.fetchDocumentCheklists(opp.Id);
			Test.stopTest();

			System.assertEquals(lstDocChecklist.size(), lstDocChklistResult.size());
			System.assertEquals(lstDocChecklist[0].Id, lstDocChklistResult[0].Id);
        }
	}

	@isTest
	static void saveDocumentCheckListsTest() {
		System.runAs(usrTestAdmin){		
			lstDocChecklist[4].Name = 'Transcript last year';
			lstDocChecklist[1].Name = 'Health report with xray';
			Test.startTest();
			Map<String, String> mapResultSuccess = LC04_DocumentChecklist.saveDocumentCheckLists(JSON.serialize(lstDocChecklist));
			Map<String, String> mapResultError = LC04_DocumentChecklist.saveDocumentCheckLists('Test'); //To check error handling
			Test.stopTest();
			
			System.assertEquals(true, mapResultSuccess.containsKey('SUCCESS'));
			System.assertEquals(true, mapResultError.containsKey('ERROR'));

			List< DocumentChecklist__c > lstDocChecklstResult = [SELECT Id, Name FROM DocumentChecklist__c WHERE Opportunity__r.Id = :opp.Id ORDER BY Name];
			System.assertEquals('Transcript last year', lstDocChecklstResult[4].Name);
			System.assertEquals('Health report with xray', lstDocChecklstResult[1].Name);
        }
	}

    @isTest
    static void saveDocumentCheckListTest() {
        System.runAs(usrTestAdmin){     
            lstDocChecklist[4].Name = 'Transcript last year';
            lstDocChecklist[4].Status__c = AP_Constant.docChklstStatusSubmitted;
            lstDocChecklist[4].DateReceived__c = Date.today();
            Test.startTest();
            LC04_DocumentChecklist.saveDocumentCheckList(JSON.serialize(lstDocChecklist[4]));
            Test.stopTest();

            List< DocumentChecklist__c > lstDocChecklstResult = [SELECT Id, Name, DateReceived__c, Status__c FROM DocumentChecklist__c WHERE Id = :lstDocChecklist[4].Id];
            System.assertEquals('Transcript last year', lstDocChecklstResult[0].Name);
            System.assertEquals(Date.today(), lstDocChecklstResult[0].DateReceived__c);
            System.assertEquals(AP_Constant.docChklstStatusSubmitted, lstDocChecklstResult[0].Status__c);
        }
    }
}