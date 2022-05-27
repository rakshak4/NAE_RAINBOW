/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for LC03_360View
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 31-MAY-2018  AMU    1.0     Initial version
-- 12-DEC-2018  ANA    1.1     Refactored test methods for updatePrimaryContact & update updateSecondaryContact
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class LC03_360View_TEST {

    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
    static List<Opportunity> lstOpp;
    static List<School__c> lstSchool;

    static {
        Map<String,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST')
            };
            insert lstSchool;

            lstAcc = new List<Account>{TestFactory.createAccount('test')};
            insert lstAcc;

            lstContact = new List<Contact>{
                TestFactory.createContact('test1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('test2', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            insert lstContact;

            lstAcc[0].FinancialContact__c = lstContact[0].Id;
            lstAcc[0].PrimaryContact__c = lstContact[0].Id;
            update lstAcc; 
            
            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testopp', lstAcc[0].Id, 'Enquiry', mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };

            lstOpp[0].Child__c = lstContact[0].Id;
            insert lstOpp;
        }
    }
    
    @isTest public static void getfamilyViewOppTest(){
        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.getfamilyView(lstOpp[0].Id);
            test.StopTest();
            List<Opportunity> lstOpp = (List<Opportunity>)mapResult.get('lstOpp');
            List<LC03_360View.ContactCustom> lstContacts = (List<LC03_360View.ContactCustom>)mapResult.get('lstContacts');
            System.assertEquals(1, lstOpp.size());
            System.assertEquals(2, lstContacts.size());
        }
    }

    @isTest public static void getfamilyViewContTest(){
        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.getfamilyView(lstContact[0].Id);
            test.StopTest();
            List<Opportunity> lstOpp = (List<Opportunity>)mapResult.get('lstOpp');
            List<LC03_360View.ContactCustom> lstContacts = (List<LC03_360View.ContactCustom>)mapResult.get('lstContacts');
            System.assertEquals(1, lstOpp.size());
            System.assertEquals(2, lstContacts.size());
        }
    }

    @isTest public static void getfamilyViewAccTest(){
        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.getfamilyView(lstAcc[0].Id);
            test.StopTest();
            List<Opportunity> lstOpp = (List<Opportunity>)mapResult.get('lstOpp');
            List<LC03_360View.ContactCustom> lstContacts = (List<LC03_360View.ContactCustom>)mapResult.get('lstContacts');
            System.assertEquals(1, lstOpp.size());
            System.assertEquals(2, lstContacts.size());
        }
    }

    
    @isTest public static void updatePrimaryContactTest_forOnePrimaryContact(){
        List<LC03_360View.ContactCustom> lstContacts = new List<LC03_360View.ContactCustom>();
        List<AccountContactRelation> lstAccContRelations = new List<AccountContactRelation>([SELECT Id, AccountId, Account.Name, Account.FinancialContact__c, Account.PrimaryContact__c,
                                                  ContactId, Contact.FirstName, Contact.LastName, Contact.MiddleName, Contact.NatureOfRelationship__c FROM AccountContactRelation]); 

        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.updatePrimaryContact(lstAccContRelations[0].AccountId, lstAccContRelations[0].ContactId, 1);
            test.StopTest();
            Boolean success = (Boolean) mapResult.get('success');
            System.assertEquals(true, success);
        }
    }
    
    @isTest public static void updatePrimaryContactTest_forTwoPrimaryContacts(){
        List<LC03_360View.ContactCustom> lstContacts = new List<LC03_360View.ContactCustom>();
        List<AccountContactRelation> lstAccContRelations = new List<AccountContactRelation>([SELECT Id, AccountId, Account.Name, Account.FinancialContact__c, Account.PrimaryContact__c,
                                                  ContactId, Contact.FirstName, Contact.LastName, Contact.MiddleName, Contact.NatureOfRelationship__c FROM AccountContactRelation]); 

        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.updatePrimaryContact(lstAccContRelations[0].AccountId, lstAccContRelations[0].ContactId, 2);
            test.StopTest();
            Boolean success = (Boolean) mapResult.get('success');
            System.assertEquals(true, success);
        }
    }
    
    @isTest public static void updatePrimaryContactTest_forZeroPrimaryContact(){
        List<LC03_360View.ContactCustom> lstContacts = new List<LC03_360View.ContactCustom>();
        List<AccountContactRelation> lstAccContRelations = new List<AccountContactRelation>([SELECT Id, AccountId, Account.Name, Account.FinancialContact__c, Account.PrimaryContact__c,
                                                  ContactId, Contact.FirstName, Contact.LastName, Contact.MiddleName, Contact.NatureOfRelationship__c FROM AccountContactRelation]); 

        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.updatePrimaryContact(lstAccContRelations[0].AccountId, lstAccContRelations[0].ContactId, 0);
            test.StopTest();
            Boolean success = (Boolean) mapResult.get('success');
            System.assertEquals(true, success);
        }
    }


        @isTest public static void updateFinancialContactTest_forOneFinancialContact(){
        List<LC03_360View.ContactCustom> lstContacts = new List<LC03_360View.ContactCustom>();
        List<AccountContactRelation> lstAccContRelations = new List<AccountContactRelation>([SELECT Id, AccountId, Account.Name, Account.FinancialContact__c, Account.SecondaryFinancialContact__c, Account.PrimaryContact__c,
                                                  ContactId, Contact.FirstName, Contact.LastName, Contact.MiddleName, Contact.NatureOfRelationship__c FROM AccountContactRelation]); 

        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.updateFinancialContact(lstAccContRelations[0].AccountId, lstAccContRelations[0].ContactId, 1);
            test.StopTest();
            Boolean success = (Boolean) mapResult.get('success');
            System.assertEquals(true, success);
        }
    }
    
    @isTest public static void updateFinancialContactTest_forTwoFinancialContacts(){
        List<LC03_360View.ContactCustom> lstContacts = new List<LC03_360View.ContactCustom>();
        List<AccountContactRelation> lstAccContRelations = new List<AccountContactRelation>([SELECT Id, AccountId, Account.Name, Account.FinancialContact__c,  Account.SecondaryFinancialContact__c, Account.PrimaryContact__c,
                                                  ContactId, Contact.FirstName, Contact.LastName, Contact.MiddleName, Contact.NatureOfRelationship__c FROM AccountContactRelation]); 

        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.updateFinancialContact(lstAccContRelations[0].AccountId, lstAccContRelations[0].ContactId, 2);
            test.StopTest();
            Boolean success = (Boolean) mapResult.get('success');
            System.assertEquals(true, success);
        }
    }
    
    @isTest public static void updateFinancialContactTest_forZeroFinancialContact(){
        List<LC03_360View.ContactCustom> lstContacts = new List<LC03_360View.ContactCustom>();
        List<AccountContactRelation> lstAccContRelations = new List<AccountContactRelation>([SELECT Id, AccountId, Account.Name, Account.FinancialContact__c,  Account.SecondaryFinancialContact__c,Account.PrimaryContact__c,
                                                  ContactId, Contact.FirstName, Contact.LastName, Contact.MiddleName, Contact.NatureOfRelationship__c FROM AccountContactRelation]); 

        System.runAs(lstUser[0]){
            test.StartTest();
                Map<String, Object> mapResult = (Map<String, Object>) LC03_360View.updateFinancialContact(lstAccContRelations[0].AccountId, lstAccContRelations[0].ContactId, 0);
            test.StopTest();
            Boolean success = (Boolean) mapResult.get('success');
            System.assertEquals(true, success);
        }
    }
}