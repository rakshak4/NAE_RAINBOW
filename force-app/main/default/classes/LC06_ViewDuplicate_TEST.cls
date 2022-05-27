/**
 * @File Name          : LC06_ViewDuplicate_TEST.cls
 * @Description        : Test class for LC06_ViewDuplicate class
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 17/12/2019, 17:22:11
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    17/12/2019         CRA                    Initial Version
**/
@isTest
public with sharing class LC06_ViewDuplicate_TEST {
    static List<User> lstUser;
    static List<Lead> lstLead;
    static List<School__c> lstSchool;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
    static Map<String, Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject, AP_Constant.conObject});

    static {
        lstUser = new List<User>{TestFactory.createUser('TestUserAd', TestFactory.getProfileAdminId())};
        lstUser[0].SchoolCode__c = 'TST';
        insert lstUser;

        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST')
            };
            insert lstSchool;

            lstLead = new List<Lead>{
                TestFactory.createLead( mapRecordType.get(AP_Constant.ledRecordTypeEnrolment), 'Test', 'Tester', 'childlname', 'childfname', 'Male', Date.newInstance(2010, 2, 2))
                ,TestFactory.createLead( mapRecordType.get(AP_Constant.ledRecordTypeEnrolment), 'Test1', 'Tester1', 'childlname1', 'childfname1', 'Male', Date.newInstance(2010, 2, 2))
                ,TestFactory.createLead( mapRecordType.get(AP_Constant.ledRecordTypeEnrolment), 'Test2', 'Tester2', 'childlname2', 'childfname2', 'Male', Date.newInstance(2010, 2, 2))
            };
            lstLead[0].Email = 'sdf@sd.s';
            lstLead[1].Phone = '234324';
            lstLead[0].schoolOfInterest__c = lstSchool[0].id;
            lstLead[0].Nationality__c = 'Indian';

            insert lstLead;

            lstAcc = new List<Account>{
                TestFactory.createAccount('testAcc')
                ,TestFactory.createAccount('testAcc1')
            };
            lstAcc[0].Phone = '9898787878';
            lstAcc[0].globalHQ__c = true;
            lstAcc[0].RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(AP_Constant.accRecordTypeDeveloperNameExternalRelationships).getRecordTypeId();


            insert lstAcc;

            lstContact = new List<Contact>{
                TestFactory.createContact('TestCon', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeExternalRelationships)),
                TestFactory.createContact('TestCon', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('TestCon1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('TestCon2', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('TestCon3', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            lstContact[0].Birthdate = Date.newInstance(2010, 2, 2);
            lstContact[1].Birthdate = Date.newInstance(2010, 2, 2);
            lstContact[1].Firstname = 'test';
            lstContact[1].Phone = '+230 777';
            lstContact[0].Firstname = 'test';
            lstContact[0].Phone = '+230 777';
            lstContact[1].Birthdate = Date.newInstance(2010, 2, 2); 
            insert lstContact;     
        }
    }

    @isTest public static void testDuplicateBusinessAccount(){

        System.runAs(lstUser[0]) {
            DuplicateRule dR = [select id from DuplicateRule where DeveloperName = 'CustomBusinessAccountDuplicateRule' LIMIT 1];
            DuplicateRecordSet dupRS = new DuplicateRecordSet(DuplicateRuleId = dR.id);
            insert dupRS;
            
            test.StartTest(); 
            Account acc = new Account(name = 'testAcc', phone='9898787878');
            acc.globalHQ__c = true;
            acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(AP_Constant.accRecordTypeDeveloperNameExternalRelationships).getRecordTypeId();
            Database.DMLOptions insertDML = new Database.DMLOptions(); 
            insertDML.DuplicateRuleHeader.AllowSave = true; 
            Database.SaveResult sr = Database.insert(acc, insertDML);
 
            List<LC06_ViewDuplicate.DupRecord> lstDupAcc = LC06_ViewDuplicate.getDuplicates(lstAcc[0].Id); //same name and phone
            List<LC06_ViewDuplicate.DupRecord> lstDupAcc1 = LC06_ViewDuplicate.getDuplicates(lstAcc[1].Id);
            test.StopTest();
            
            //System.assertEquals(1, lstDupAcc.size());
            //System.assertEquals(0, lstDupAcc1.size());
        }
    }

    @isTest public static void testDuplicateBusinessContacts(){

        System.runAs(lstUser[0]) {
            DuplicateRule dR = [select id from DuplicateRule where DeveloperName = 'CustomBusinessContactsDuplicateRule' LIMIT 1];
            DuplicateRecordSet dupRS = new DuplicateRecordSet(DuplicateRuleId = dR.id);
            insert dupRS;

            List<Contact> lstCon =  new List<Contact> {
                TestFactory.createContact('TestCon', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeExternalRelationships))
                ,TestFactory.createContact('TestCon1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            lstCon[0].Birthdate = Date.newInstance(2010, 2, 2);
            lstCon[0].Firstname = 'test';
            lstCon[0].Phone = '+230 777';
            lstCon[1].Birthdate = Date.newInstance(2010, 3, 3);

            test.StartTest(); 
            Database.DMLOptions insertDML = new Database.DMLOptions(); 
            insertDML.DuplicateRuleHeader.AllowSave = true; 
            Database.SaveResult[] sr = Database.insert(lstCon, insertDML);
 
            List<LC06_ViewDuplicate.DupRecord> lstDupCon = LC06_ViewDuplicate.getDuplicatesCon(lstContact[0].Accountid); //same name and birthdate

            test.StopTest();
            
            //System.assertEquals(1, lstDupCon.size());
            //System.assertEquals(0, lstDupCon1.size());
           // System.assertEquals(0, lstDupCon2.size());
        }
    }


    @isTest public static void testDuplicateContact(){

        System.runAs(lstUser[0]) {
            DuplicateRule dR = [select id from DuplicateRule where DeveloperName = 'CustomChildContactDuplicateRule' LIMIT 1];
            DuplicateRecordSet dupRS = new DuplicateRecordSet(DuplicateRuleId = dR.id);
            insert dupRS;

            List<Contact> lstCon =  new List<Contact> {
                TestFactory.createContact('TestCon', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('TestCon1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            lstCon[0].Birthdate = Date.newInstance(2010, 2, 2);
            lstCon[0].Firstname = 'test';
            lstCon[1].Birthdate = Date.newInstance(2010, 3, 3);

            test.StartTest(); 
            Database.DMLOptions insertDML = new Database.DMLOptions(); 
            insertDML.DuplicateRuleHeader.AllowSave = true; 
            Database.SaveResult[] sr = Database.insert(lstCon, insertDML);
 
            List<LC06_ViewDuplicate.DupRecord> lstDupCon = LC06_ViewDuplicate.getDuplicates(lstContact[0].Id); //same name and birthdate
            List<LC06_ViewDuplicate.DupRecord> lstDupCon1 = LC06_ViewDuplicate.getDuplicates(lstContact[1].Id); // same name and different birthdate
            List<LC06_ViewDuplicate.DupRecord> lstDupCon2 = LC06_ViewDuplicate.getDuplicates(lstContact[2].Id);
            test.StopTest();
            
            //System.assertEquals(1, lstDupCon.size());
            //System.assertEquals(0, lstDupCon1.size());
           // System.assertEquals(0, lstDupCon2.size());
        }
    }

    @isTest public static void testDuplicateLead(){

        System.runAs(lstUser[0]) {
            DuplicateRule dR = [select id from DuplicateRule where DeveloperName = 'CustomLeadDuplicateRule_25_03' LIMIT 1];
            DuplicateRecordSet dupRS = new DuplicateRecordSet(DuplicateRuleId = dR.id);
            insert dupRS;

            List<Lead> lstLeadDupicate = new List<Lead> {
                new Lead(RecordTypeId = mapRecordType.get(AP_Constant.ledRecordTypeEnrolment) , LastName = 'Test', FirstName='Tester', phone= '234324', email = 'sdf@sd.s')
                ,new Lead(RecordTypeId = mapRecordType.get(AP_Constant.ledRecordTypeEnrolment) , LastName = 'Test1', FirstName='Tester1', phone= '234324', email = 'sdf@sd.s')
            };

            lstLeadDupicate[0].schoolOfInterest__c = lstSchool[0].id;
            lstLeadDupicate[0].Nationality__c = 'Indian';

        
            test.StartTest();  
            Database.DMLOptions insertDML = new Database.DMLOptions(); 
            insertDML.DuplicateRuleHeader.AllowSave = true; 
            Database.SaveResult[] sr = Database.insert(lstLeadDupicate, insertDML);

            List<LC06_ViewDuplicate.DupRecord> lstDupLed = LC06_ViewDuplicate.getDuplicates(lstLead[0].Id); // same name and same email
            List<LC06_ViewDuplicate.DupRecord> lstDupLed1 = LC06_ViewDuplicate.getDuplicates(lstLead[1].Id); // same name and same phone
            List<LC06_ViewDuplicate.DupRecord> lstDupLed2 = LC06_ViewDuplicate.getDuplicates(lstLead[2].Id);
            test.StopTest();

            //System.assertEquals(1, lstDupLed.size());
            //System.assertEquals(1, lstDupLed1.size());
            //System.assertEquals(0, lstDupLed2.size());
        }
    }
}