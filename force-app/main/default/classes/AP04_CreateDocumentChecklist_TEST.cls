@isTest
private class AP04_CreateDocumentChecklist_TEST {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test Apex class for creation on document checklist on insertion of application document
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 13-JUL-2018  CRA    1.0     Initial version
-- 03-MAR-2020  CRA    1.1     Implement Case 00002205
--------------------------------------------------------------------------------------
***************************************************************************************/
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User usrTestAdmin;
    static Account acc;
    static List<School__c> lstSchool = new List<School__c>();
    static List<ApplicationDocument__c> lstAppDoc = new List<ApplicationDocument__c>();
    static List<Opportunity> lstOpp = new List<Opportunity>();
    static {
        //creating user
        usrTestAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert usrTestAdmin;

        System.runAs(usrTestAdmin){

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject});
            //creating account
            acc = TestFactory.createAccount('Henry Family');
            insert acc;

            //creating school
            lstSchool = new List < School__c > {
                TestFactory.createSchool('Petit Verger School', 'Petit Verger', false, 'PVS'),
                TestFactory.createSchool('Le Petit Pouce Elementary School', 'Vivéa Business Park', false, 'PPE'),
                TestFactory.createSchool('Cateau Vert Elementary School', 'St Pierre', false, 'CVE')
            };
            insert lstSchool;

            // creating application document
            lstAppDoc = new list < ApplicationDocument__c > {
                TestFactory.createApplicationDoc('Birth Certificate', lstSchool[0].Id, true, 'Application'), //PVS //Document checklist order : 1
                TestFactory.createApplicationDoc('Transcript', lstSchool[0].Id, false, 'Acceptance'), //PVS //Document checklist order : 5
                TestFactory.createApplicationDoc('Passport copy', lstSchool[0].Id, null, null), //PVS //Document checklist order : 3
                TestFactory.createApplicationDoc('Health report' , lstSchool[1].Id, true, null), //PPE //Document checklist order : 2
                TestFactory.createApplicationDoc('Transfert certificate', lstSchool[1].Id, false, 'Enrolled'), //PPE //Document checklist order : 6
                TestFactory.createApplicationDoc('Resident proof', lstSchool[1].Id, null, 'Acceptance'), //PPE //Document checklist order : 4
                TestFactory.createApplicationDoc('Application fee', lstSchool[1].Id, false, 'Application') //PPE //Document checklist order : 0
            };

            //creating opportunities
            lstOpp = new List< Opportunity > {
                TestFactory.createOpportunity('Junior Henry - Enrolment', acc.Id, AP_Constant.oppStageNameEnquiry,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id), //PVS
                TestFactory.createOpportunity('Joe Henry - Enrolment', acc.Id, AP_Constant.oppStageNameEnquiry,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id), //PVS
                TestFactory.createOpportunity('Lucy Henry - Enrolment', acc.Id, AP_Constant.oppStageNameEnquiry,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id), //PPE
                TestFactory.createOpportunity('Dave Henry - Enrolment', acc.Id, AP_Constant.oppStageNameEnquiry,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id) //CVE
            };

        }
    }

    @isTest static void createAppDocDocumentChecklistsTest() {
        System.runAs(usrTestAdmin){            
            insert lstOpp;
            Test.startTest();
            insert lstAppDoc;
            Test.stopTest();            
            List<DocumentChecklist__c> lstDocChecklist = [SELECT Id, Name FROM DocumentChecklist__c 
                                                     WHERE ApplicationDocument__r.id = :lstAppDoc[1].Id ];

            System.assertEquals(2 , lstDocChecklist.size());
        }

    }

    @isTest static void createOppDocumentChecklistsTest() {
        System.runAs(usrTestAdmin){
            insert lstAppDoc;
            Test.startTest();
            insert lstOpp;
            Test.stopTest();
            List<DocumentChecklist__c> lstDocChecklist = [SELECT Id, Name FROM DocumentChecklist__c WHERE Opportunity__r.id = :lstOpp[2].Id];
            System.assertEquals(4, lstDocChecklist.size());
            List<DocumentChecklist__c> lstDocChk = [SELECT Id, Name, Stage__c, Status__c, Required__c FROM DocumentChecklist__c 
                                                 WHERE Opportunity__r.id IN :lstOpp ORDER BY Name ASC ];
            //System.assertEquals('Birth Certificate', lstDocChk[1].Name);
            //System.assertEquals('Birth Certificate', lstDocChk[2].Name);
            //System.assertEquals('Application', lstDocChk[2].Stage__c);
            //System.assertEquals('Passport copy', lstDocChk[5].Name);
            System.assertEquals(AP_Constant.docChklstStatusRequested, lstDocChk[0].Status__c);
            System.assertEquals(true, lstDocChk[3].Required__c);

        }
    }

    @isTest static void createOppDocCheckAfterUpdateTest() {
        System.runAs(usrTestAdmin) {
            insert lstAppDoc;
            insert lstOpp;

            lstOpp[3].SchoolOfInterest__c = lstSchool[1].Id;
            Test.startTest();
            update lstOpp;
            Test.stopTest();

            List<DocumentChecklist__c> lstDocChecklist = [SELECT Id, Name FROM DocumentChecklist__c WHERE Opportunity__r.id = :lstOpp[3].Id];
            System.assertEquals(4, lstDocChecklist.size());
        }
    }

}