/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP11_OppCheckRequiredDocument
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 17-JULY-2018  AMU   1.0     Initial Version
-- 08-AUG-2018   KZE   1.1     Added test method
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
public with sharing class AP11_OppCheckRequiredDocument_TEST {
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User testUserAdmin;
    static Account account;
    static List<Contact> lstContact;
    static List<School__c> lstSchool;
    static List<ApplicationDocument__c> lstAppDoc;
    static List<Opportunity> lstOpp;
    static List<DocumentChecklist__c> lstDocChecklist;
    static Opportunity oppToTest;
    static {
        //creating user
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert testUserAdmin;

        System.runAs(testUserAdmin){
            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

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
                TestFactory.createApplicationDoc('Birth Certificate', lstSchool[0].Id, true, AP_Constant.docChklstStageApplication), //PVS //Document checklist order : 1
                TestFactory.createApplicationDoc('Transcript', lstSchool[0].Id, false, AP_Constant.docChklstStageAcceptance), //PVS //Document checklist order : 5
                TestFactory.createApplicationDoc('Passport copy', lstSchool[0].Id, null, null), //PVS //Document checklist order : 3
                TestFactory.createApplicationDoc('Health report' , lstSchool[1].Id, true, null), //PPE //Document checklist order : 2
                TestFactory.createApplicationDoc('Transfert certificate', lstSchool[1].Id, false, AP_Constant.docChklstStageEnrolled), //PPE //Document checklist order : 6
                TestFactory.createApplicationDoc('Resident proof', lstSchool[1].Id, null, AP_Constant.docChklstStageAcceptance), //PPE //Document checklist order : 4
                TestFactory.createApplicationDoc('Application fee', lstSchool[1].Id, false, AP_Constant.docChklstStageApplication) //PPE //Document checklist order : 0
            };
            insert lstAppDoc;

            //creating opportunities
            //creating primary contact in account for opportunity
            lstContact = new List<Contact>{
                TestFactory.createContact('parent1', account.Id, mapRecordType.get(AP_Constant.conRecordTypeParent))
                ,TestFactory.createContact('child1', account.Id, mapRecordType.get(AP_Constant.conRecordTypeChild))};
            insert lstContact; 
            
            account.PrimaryContact__c = lstContact[0].Id;
            update account; 

            lstOpp = new List<Opportunity> {
                TestFactory.createOpportunity('Junior Henry - Enrolment', account.Id, AP_Constant.oppStageNameApplication,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id), //PVS
                TestFactory.createOpportunity('Joe Henry - Enrolment', account.Id, AP_Constant.oppStageNameEnquiry,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id), //PVS
                TestFactory.createOpportunity('Lucy Henry - Enrolment', account.Id, AP_Constant.oppStageNameEnquiry,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id) //PPE
            };

            lstOpp[0].Child__c = lstContact[1].Id;
            lstOpp[1].Child__c = lstContact[1].Id;
            lstOpp[2].Child__c = lstContact[1].Id;
            insert lstOpp;
        }
    }

    @isTest
    static void checkReqDocChecklistFailTest() {
        lstOpp[0].StageName = AP_Constant.oppStageNameAcceptance;
        lstOpp[0].AssessmentOutcome__c = AP_Constant.oppAssessOutcomePassed;
        System.runAs(testUserAdmin){            
            Test.startTest();
            try {
                update lstOpp;
            } catch(Exception e) {
                System.assertNotEquals(e.getMessage(), null);
            }               
            Test.stopTest();
        }
    }

    @isTest
    static void checkReqDocChecklistPassTest() {
        lstDocChecklist = [SELECT Id, Name, Stage__c, Status__c, Required__c FROM DocumentChecklist__c 
                                                 WHERE Opportunity__r.id =: lstOpp[0].Id ORDER BY Name ASC ];

        for(DocumentChecklist__c doc: lstDocChecklist) {
            doc.Status__c = AP_Constant.docChklstStatusSubmitted;
        }

        update lstDocChecklist;

        lstOpp[0].StageName = AP_Constant.oppStageNameAcceptance;
        lstOpp[0].AssessmentOutcome__c = AP_Constant.oppAssessOutcomePassed;
        System.runAs(testUserAdmin){            
            Test.startTest();
            try {
                update lstOpp;
            } catch(Exception e) {
                System.assertEquals(e.getMessage(), null);
            }
                
            Test.stopTest();
        }
    }
    @isTest
    static void checkReqDocForClosedLost() {
        lstOpp[0].StageName = AP_Constant.oppStageNameLost;
        lstOpp[0].LostDeniedOnHoldReason__c = 'Financial';
        lstOpp[0].ReasonLostCategory__c = 'Price';
        
        System.runAs(testUserAdmin){            
            Test.startTest();
            try {
                update lstOpp;
            } catch(Exception e) {
                System.assertEquals(e.getMessage(), null);
            }
                
            Test.stopTest();
        }
        
        oppToTest = [SELECT Id, Name, StageName FROM Opportunity 
                                 WHERE Id =: lstOpp[0].Id];
        System.assertEquals(oppToTest.StageName, AP_Constant.oppStageNameLost);        
    }
    @isTest
    static void checkReqDocForClosedDenied() {
        lstOpp[0].StageName = AP_Constant.oppStageNameDenied;
        lstOpp[0].LostDeniedOnHoldReason__c = AP_Constant.oppLostDeniedReasonQuotaReached;
        
        System.runAs(testUserAdmin){            
            Test.startTest();
            try {
                update lstOpp;
            } catch(Exception e) {
                System.assertEquals(e.getMessage(), null);
            }
                
            Test.stopTest();
        }
        
        oppToTest = [SELECT Id, Name, StageName FROM Opportunity 
                                 WHERE Id =: lstOpp[0].Id];
        System.assertEquals(oppToTest.StageName, AP_Constant.oppStageNameDenied);
    }
}