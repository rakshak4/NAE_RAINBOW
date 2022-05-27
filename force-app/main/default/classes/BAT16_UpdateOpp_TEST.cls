/**
 * @description       : Test Class for BAT16_UpdateOpp
 * @author            : Spoon Consulting
 * @group             : 
 * @last modified on  : 07-13-2020
 * @last modified by  : Spoon Consulting
 * Modifications Log 
 * Ver   Date         Author             Modification
 * 1.0   07-13-2020   CRA                Initial Version
**/
@isTest
public with sharing class BAT16_UpdateOpp_TEST {
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User testUserAdmin;
    static List<School__c> lstSchool;
    static List<Lead> lstLead;

    static{
        //creating user
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert testUserAdmin;

        System.runAs(testUserAdmin){
            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject, AP_Constant.oppObject});

            //creating school
            lstSchool = new List<School__c>{
                TestFactory.createSchool('testSchool', 'Port Louis', true, 'XXX')
            };
            insert lstSchool;

            lstLead = new List<Lead>{
                TestFactory.createLead(
                    null, 'Test1', 'Tester', 'childfname1', 'childlname1', 'Male', Date.newInstance(2010, 2, 2)
                ),
                TestFactory.createLead(
                    null, 'Test2', 'Tester', 'childfname2', 'childlname2', 'Male', Date.newInstance(2010, 2, 2)
                )
            };                     
                        
            lstLead[0].Parent1PrimaryEmail__c = 'user@test.com';
            lstLead[0].Parent1CountryOfResidence__c = 'France';           
            lstLead[0].Parent2FirstName__c = 'Jean';
            lstLead[0].Parent2LastName__c = 'Curi';
            lstLead[0].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[0].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[0].Parent2CountryOfResidence__c = 'France';
            lstLead[0].Parent2Nationality__c = 'French';           
            lstLead[0].Number_of_Children__c = '1';
            lstLead[0].MarketingQualifiedFirstChild__c = true;
            lstLead[0].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[0].IsConverted = false;
            lstLead[0].Lead_Origin__c = 'AdmissionsStage1';
            lstLead[0].Status = 'Qualified';
            
            lstLead[1].Parent1PrimaryEmail__c = 'user@test.com';
            lstLead[1].Parent1CountryOfResidence__c = 'France';           
            lstLead[1].Parent2FirstName__c = 'Jean1';
            lstLead[1].Parent2LastName__c = 'Curi2';
            lstLead[1].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[1].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[1].Parent2CountryOfResidence__c = 'France';
            lstLead[1].Parent2Nationality__c = 'French';           
            lstLead[1].Number_of_Children__c = '1';
            lstLead[1].MarketingQualifiedFirstChild__c = true;
            lstLead[1].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[1].IsConverted = false;
            lstLead[1].LeadMethod__c = 'Email';
            lstLead[1].Lead_Origin__c = 'AdmissionsStage1';
            lstLead[1].Status = 'Qualified';

            insert lstLead;
        }
    }

    @isTest public static void updateOppTest() {
        System.runAs(testUserAdmin) {
            AP12_AutoConvertLead.convertLeads(lstLead);
            List<Opportunity> lstOpp = new List<Opportunity>();
            for (Opportunity opp : [SELECT Id, LEad__c FROM Opportunity]) {
                opp.Lead__c = null;
                lstOpp.add(opp);
            }
            update lstOpp;

            Test.startTest();
                BAT16_UpdateOpp batchObj = new BAT16_UpdateOpp();
                Database.executeBatch(batchObj , 200);
            Test.stopTest();

            List<Opportunity> lstOppRes = [SELECT Id, Lead__c FROM Opportunity];
            System.assertEquals(true, lstOppRes[0].Lead__c != null);

        }
    }

    static testMethod void testSchedulePass() {
        delete [SELECT Id FROM OpportunityContactRole];
		Test.startTest();
		for (CronTrigger c: [Select Id From CronTrigger Where CronJobDetailId IN(Select Id From CronJobDetail WHERE
			JobType = '7')]) {
			System.abortJob(c.id);
		}       
		BAT16_UpdateOpp batchObj = new BAT16_UpdateOpp();
		String cronStr7 = '0 0 6 * * ? '; 
		Id jobId = System.schedule('Test schedule batch', cronStr7, batchObj);        
	    CronTrigger ct = [Select Id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where Id = : jobId];
	    Test.stopTest();
	    System.assertEquals(0, ct.TimesTriggered);
	}
}