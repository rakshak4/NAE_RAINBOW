@isTest
public with sharing class AP28_OppConRoleRules_TEST {
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
                TestFactory.createOpportunity('opptest', lstAcc[0].Id, AP_Constant.oppStageEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchl[0].Id),
                TestFactory.createOpportunity('opptest1', lstAcc[0].Id, AP_Constant.oppStageEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchl[0].Id)
            };
            lstOpp[0].Child__c = lstContact[1].Id;
            lstOpp[1].Child__c = lstContact[1].Id;
        }
    }

    @isTest public static void testCreateRoles() {
        System.runAs(testUserAdmin) {
            Test.startTest();
                insert lstOpp;
            Test.stopTest();
        }

        List<OpportunityContactRole> lstRes = [SELECT Id FROM OpportunityContactRole];
        System.assertEquals(2, lstRes.size());
        List<OpportunityContactRole> lstRes2 = [SELECT Id FROM OpportunityContactRole where Role = 'Child'];
        System.assertEquals(2, lstRes2.size());
    }

    @isTest public static void testCreateRolesSameContact() {
        System.runAs(testUserAdmin) {
            Test.startTest();
                insert lstOpp;
                Opportunity opp = TestFactory.createOpportunity('opptest2', lstAcc[0].Id, AP_Constant.oppStageEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchl[0].Id);
                opp.Child__c = lstContact[1].Id;
                insert opp;
            Test.stopTest();
        }

        List<OpportunityContactRole> lstRes = [SELECT Id FROM OpportunityContactRole];
        System.assertEquals(3, lstRes.size());
        List<OpportunityContactRole> lstRes2 = [SELECT Id FROM OpportunityContactRole where Role = 'Child'];
        System.assertEquals(3, lstRes2.size());
    }

    @isTest public static void testUpdateRoles() {
        System.runAs(testUserAdmin) {
            Opportunity opp = TestFactory.createOpportunity('opptest2', lstAcc[0].Id, AP_Constant.oppStageEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchl[0].Id);
            insert opp;
            List<OpportunityContactRole> lstOppConRoleBefore = [SELECT Id FROM OpportunityContactRole];
            Test.startTest();
                insert new OpportunityContactRole(ContactId = lstContact[1].Id, OpportunityId = opp.id);
            Test.stopTest();
            List<OpportunityContactRole> lstOppConRoleAfter = [SELECT Id FROM OpportunityContactRole where role = 'Child'];
            System.assertEquals(1, lstOppConRoleAfter.size());
            System.assertEquals(0, lstOppConRoleBefore.size());

        } 
    }

    @isTest public static void testUpdateOppContactRole() {
        System.runAs(testUserAdmin) {
            insert lstOpp;
            lstContact[1].NatureOfRelationship__c = AP_Constant.accNatureOfRelationshipFather;
            Test.startTest();
                update lstContact;
            Test.stopTest();
        }

        List<OpportunityContactRole> lstRes = [SELECT Id, Role FROM OpportunityContactRole WHERE Role = 'Father'];
        System.assertEquals(2, lstRes.size());
    }
}