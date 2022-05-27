/**
 * @description       : Test class for BAT17_CreateOppContactRole
 * @author            : CRA
 * @group             : Spoon Consulting
 * @last modified on  : 07-13-2020
 * @last modified by  : CRA
 * Modifications Log 
 * Ver   Date         Author             Modification
 * 1.0   07-13-2020   CRA                Initial Version
**/
@isTest
public with sharing class BAT17_CreateOppContactRole_TEST {
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User testUserAdmin;
    static List<School__c> lstSchl;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
	static List<Opportunity> lstOpp;

    static{
        //creating user
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert testUserAdmin;

        System.runAs(testUserAdmin){
            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject, AP_Constant.oppObject});

            //creating school
            lstSchl = new List<School__c>{
                TestFactory.createSchool('testSchool', 'Port Louis', true, 'XXX')
            };
            insert lstSchl;

            lstAcc = new List<Account>{
                TestFactory.createAccount('Acc1')
            };
            lstAcc[0].SchoolOfInterest__c = lstSchl[0].Id;
            insert lstAcc;

            lstContact = new List<Contact> {
                TestFactory.createContact('Paul', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //1
                TestFactory.createContact('Chris', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)), //2
                TestFactory.createContact('Eva', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //3
            };
            lstContact[0].NatureOfRelationship__c = AP_Constant.conNatureRelFather;
            lstContact[1].NatureOfRelationship__c = AP_Constant.conNatureRelChild;
            lstContact[2].NatureOfRelationship__c = AP_Constant.conNatureRelMother;
            lstContact[0].SchoolOfInterest__c = lstSchl[0].Id;
            lstContact[1].SchoolOfInterest__c = lstSchl[0].Id;
            lstContact[2].SchoolOfInterest__c = lstSchl[0].Id;
            insert lstContact;

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('opptest', lstAcc[0].Id, AP_Constant.oppStageEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchl[0].Id)
            };
            lstOpp[0].Child__c = lstContact[1].Id;
            insert lstOpp;
        }
    }

    @isTest public static void testNewOppContactRole() {
        System.runAs(testUserAdmin) {
            delete [SELECT Id FROM OpportunityContactRole];
            Test.startTest();
                BAT17_CreateOppContactRole batchObj = new BAT17_CreateOppContactRole();
                Database.executeBatch(batchObj , 200);
            Test.stopTest();
        }

        List<OpportunityContactRole> lstRes = [SELECT Id FROM OpportunityContactRole];
        System.assertEquals(3, lstRes.size());
    }

    static testMethod void testSchedulePass() {
        delete [SELECT Id FROM OpportunityContactRole];
		Test.startTest();
		for (CronTrigger c: [Select Id From CronTrigger Where CronJobDetailId IN(Select Id From CronJobDetail WHERE
			JobType = '7')]) {
			System.abortJob(c.id);
		}       
		BAT17_CreateOppContactRole batchObj = new BAT17_CreateOppContactRole();
		String cronStr7 = '0 0 6 * * ? '; 
		Id jobId = System.schedule('Test schedule batch', cronStr7, batchObj);        
	    CronTrigger ct = [Select Id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where Id = : jobId];
	    Test.stopTest();
	    System.assertEquals(0, ct.TimesTriggered);
	}
}