/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for LC08_CloneOpportunity
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 07-Aug-2018  AMU    1.0     Initial version
-- 18-Nov-2020	VJA	   1.5	   Case 2782: Added dependent picklist values to Component	 	
--------------------------------------------------------------------------------------
**********************************************************************************/
@isTest
public with sharing class LC08_CloneOpportunity_TEST {
	static Map<string,Id> mapRecordType;
    static User usrTestAdmin;
    static List<DocumentChecklist__c> lstDocChecklist;
    static List<ContentDocumentLink> lstContDocLinks;
    static Opportunity opp;
    static Account acc;
    static {
        
        usrTestAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert usrTestAdmin;

        System.runAs(usrTestAdmin){
        	mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject});
        	
            acc = TestFactory.createAccount('Henry Family');
            insert acc;

        	opp = TestFactory.createOpportunity('Junior Henry - Enrolment', acc.Id, AP_Constant.oppStageNameEnquiry,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), null);
        	insert opp;
        
        	lstDocChecklist = new List<DocumentChecklist__c> {
        		TestFactory.createDocChecklist('Birth Certificate', opp.Id, null), 
        		TestFactory.createDocChecklist('Health report', opp.Id, null),     
        		TestFactory.createDocChecklist('Passport copy', opp.Id, null),     
        		TestFactory.createDocChecklist('Residence proof', opp.Id, null),   
        		TestFactory.createDocChecklist('Transcript', opp.Id, null),        
        		TestFactory.createDocChecklist('Transfert certificate', opp.Id, null)
        	};
        	insert lstDocChecklist;

        	List<ContentVersion> lstContentVersions = new List<ContentVersion> {
	 			new ContentVersion(Title = 'Test',
					PathOnClient = 'test.txt',
					VersionData = Blob.valueOf('test'))
	 		};
	 		insert lstContentVersions;
		 
		 	ContentVersion contentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :lstContentVersions[0].Id LIMIT 1];

		 	lstContDocLinks = new List<ContentDocumentLink>{
		 		new ContentDocumentLink(LinkedEntityId = opp.Id
		 			,ContentDocumentId = contentVersion.ContentDocumentId
		 			,ShareType = 'V')
		 	};
		 	insert lstContDocLinks;
        }
    }

    @isTest public static void getOppTest(){
        System.runAs(usrTestAdmin) {
            test.StartTest();
                LC08_CloneOpportunity.getOpp(opp.Id);
            test.StopTest();
        }
    }

    @isTest
    public static void cloneOpportunityTest(){
    	System.runAs(usrTestAdmin) {
            Test.StartTest();
            Map<String, String> mapResultNoClose = LC08_CloneOpportunity.cloneOpportunity(opp.Id, opp,false);
            Test.StopTest();

            Opportunity oldOpp2 = [SELECT StageName, LostDeniedOnHoldReason__c, Waitlisted__c, (SELECT Id FROM DocumentChecklists__r), 
                                    (SELECT Id FROM ContentDocumentLinks) FROM Opportunity WHERE Id =: opp.Id LIMIT 1];

            Opportunity cloneOpp2 = [SELECT StageName, LostDeniedOnHoldReason__c, (SELECT Id FROM DocumentChecklists__r), (SELECT 
                                    Id FROM ContentDocumentLinks) FROM Opportunity WHERE Id =: mapResultNoClose.get('cloneOppId') LIMIT 1];


            System.assertEquals(mapResultNoClose.get('type'), 'success');
            System.assertEquals(mapResultNoClose.get('message'), 'Opportunity cloned successfully');
            System.assertEquals(oldOpp2.Waitlisted__c, false);
            System.assertEquals(cloneOpp2.ContentDocumentLinks.size(), 1);
            System.assertEquals(cloneOpp2.DocumentChecklists__r.size(),6);
            System.assertEquals(cloneOpp2.StageName, 'Enquiry');

        }
    }

    @isTest
    public static void cloneDeferredOpportunityTest(){
        System.runAs(usrTestAdmin) {
            test.StartTest();
                opp.StageName = AP_Constant.oppStageNameLost;
                opp.LostDeniedOnHoldReason__c = 'Financial';
                //update opp;
                Map<String, String> mapResult = LC08_CloneOpportunity.cloneOpportunity(opp.Id, opp,true);
            test.StopTest();

            Opportunity oldOpp = [SELECT StageName, LostDeniedOnHoldReason__c, (SELECT Id FROM DocumentChecklists__r), 
                                    (SELECT Id FROM ContentDocumentLinks) FROM Opportunity WHERE Id =: opp.Id LIMIT 1];

            Opportunity cloneOpp = [SELECT StageName, LostDeniedOnHoldReason__c, (SELECT Id FROM DocumentChecklists__r), (SELECT 
                                    Id FROM ContentDocumentLinks) FROM Opportunity WHERE Id =: mapResult.get('cloneOppId') LIMIT 1];

            System.assertEquals(mapResult.get('type'), 'success');
            System.assertEquals(mapResult.get('message'), 'Opportunity cloned successfully');
            System.assertEquals(oldOpp.StageName, AP_Constant.oppStageNameLost);
            System.assertEquals(oldOpp.DocumentChecklists__r.size(), 0);
            System.assertEquals(oldOpp.ContentDocumentLinks.size(), 0);
            System.assertEquals(cloneOpp.DocumentChecklists__r.size(), 6);
            System.assertEquals(cloneOpp.ContentDocumentLinks.size(), 1);
            System.assertNotEquals(cloneOpp.LostDeniedOnHoldReason__c, AP_Constant.oppLostDeniedReasonQuotaReached);
        }
    }

    @isTest
    public static void cloneOpportunityFailTest(){
        Boolean errorThrown = false;
    	System.runAs(usrTestAdmin) {
            test.StartTest();
                try {
                    Map<String, String> mapResult = LC08_CloneOpportunity.cloneOpportunity(null, null,true);
                } catch(Exception e) {
                    errorThrown = true;
                }
            test.StopTest();

            System.assertEquals(true, errorThrown);
        }
    }
}