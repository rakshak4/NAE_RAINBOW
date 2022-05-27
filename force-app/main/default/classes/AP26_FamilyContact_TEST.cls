/**
* @File Name          : AP26_FamilyContactRules_TEST.cls
* @Description        : Test class for Family Contact
* @Author             : CRA
* @Group              : 
* @Last Modified By   : CRA
* @Last Modified On   : 07-23-2020
* @Modification Log   : 
* Ver       Date            Author      		    Modification
* 1.0    29/10/2019          BDU                   Initial Version
* 1.1    18/11/2019          CRA                   Add Test cases
* 1.2    23/07/2020          CRA                   Comment codes due to Merge Functionality non usage
**/

@isTest
public with sharing class AP26_FamilyContact_TEST {
    // static User testUserAdmin, admissionOfficer;
    // static Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Admissions Officer' LIMIT 1];

    // static List<Contact> lstCtc = new List<Contact>();
    // static List<Contact> lstCtcTest = new List<Contact>();   
    // static List<Contact> lstContact = new List<Contact>();
    // static List<Contact> lstContact2 = new List<Contact>();
    // static List<Account> lstAccount = new List<Account>();
    // static Map<String,Id> mapContactRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject});

    // static{
    //     //creating user
    //     testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
    //     insert testUserAdmin;

    //     System.runAs(testUserAdmin){
    //         lstAccount = new List<Account> {
    //             TestFactory.createFamilyAccount('TestFamily'),
    //             TestFactory.createFamilyAccount('TestFamily2'),
    //             TestFactory.createFamilyAccount('TestFamily3'),
    //             TestFactory.createFamilyAccount('TestFamily4'),
    //             TestFactory.createFamilyAccount('TestFamily5'),
    //             TestFactory.createFamilyAccount('TestFamily6'),
    //             TestFactory.createFamilyAccount('TestFamily7'),
    //             TestFactory.createFamilyAccount('TestFamily8'),
    //             TestFactory.createFamilyAccount('TestFamily9'),
    //             TestFactory.createFamilyAccount('TestFamily10'),
    //             TestFactory.createFamilyAccount('TestFamily11'),
    //             TestFactory.createFamilyAccount('TestFamily12'),
    //             TestFactory.createFamilyAccount('TestFamily13'),
    //             TestFactory.createFamilyAccount('TestFamily14'),
    //             TestFactory.createFamilyAccount('TestFamily15'),
    //             TestFactory.createFamilyAccount('TestFamily16')
    //         };
    //         insert lstAccount;

    //         lstContact = new List<Contact> {
    //             TestFactory.createContact('APaul', lstAccount[0].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //1
    //             TestFactory.createContact('APaul', lstAccount[0].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //2
    //             TestFactory.createContact('APaul', lstAccount[1].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //3
    //             TestFactory.createContact('APaul', lstAccount[1].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //4
    //             TestFactory.createContact('APaul', lstAccount[2].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //5
    //             TestFactory.createContact('APaul', lstAccount[2].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //6
    //             TestFactory.createContact('APaul', lstAccount[3].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //7
    //             TestFactory.createContact('APaul', lstAccount[3].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //8
    //             TestFactory.createContact('APaul', lstAccount[4].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //9
    //             TestFactory.createContact('APaul', lstAccount[12].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //10
    //             TestFactory.createContact('APaul', lstAccount[12].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //11
    //             TestFactory.createContact('APaul', lstAccount[13].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //12
    //             TestFactory.createContact('APaul', lstAccount[13].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //13
    //             TestFactory.createContact('APaul', lstAccount[14].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //14
    //             TestFactory.createContact('APaul', lstAccount[14].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //15
    //             TestFactory.createContact('APaul', lstAccount[15].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)) //16
    //         };
            

            
    //         lstContact2 = new List<Contact> {
    //             TestFactory.createContact('APaul', lstAccount[8].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //1
    //             TestFactory.createContact('APaul', lstAccount[8].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //2
    //             TestFactory.createContact('APaul', lstAccount[9].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //3
    //             TestFactory.createContact('APaul', lstAccount[9].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //4
    //             TestFactory.createContact('APaul', lstAccount[10].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //5
    //             TestFactory.createContact('APaul', lstAccount[10].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //6
    //             TestFactory.createContact('APaul', lstAccount[15].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //7
    //             TestFactory.createContact('APaul', lstAccount[11].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //8
    //             TestFactory.createContact('APaul', lstAccount[11].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //9
    //             TestFactory.createContact('APaul', lstAccount[4].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //10
    //             TestFactory.createContact('APaul', lstAccount[5].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //11
    //             TestFactory.createContact('APaul', lstAccount[5].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //12
    //             TestFactory.createContact('APaul', lstAccount[6].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //13
    //             TestFactory.createContact('APaul', lstAccount[6].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //14
    //             TestFactory.createContact('APaul', lstAccount[7].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)), //15
    //             TestFactory.createContact('APaul', lstAccount[7].Id, mapContactRecordType.get(AP_Constant.conRecordTypeParent)) //16
    //         };

    //         lstContact[0].MidTierContactID__c = 'BANGKOK-PARENT-13659.1'; //1
    //         lstContact[1].MidTierContactID__c = 'BANGKOK-PARENT-13659.2'; //1
    //         lstContact[2].MidTierContactID__c = 'BANGKOK-PARENT-136.1'; //2
    //         lstContact[3].MidTierContactID__c = 'BANGKOK-PARENT-136.2'; //2
    //         lstContact[4].MidTierContactID__c = 'BANGKOK-PARENT-659.1'; //3
    //         lstContact[5].MidTierContactID__c = 'BANGKOK-PARENT-659.2'; //3
    //         lstContact[6].MidTierContactID__c = 'BANGKOK-PARENT-12.2'; //4
    //         lstContact[7].MidTierContactID__c = 'BANGKOK-PARENT-12.1'; //4
    //         lstContact[8].MidTierContactID__c = 'BANGKOK-PARENT-13.2'; //5
    //         lstContact[9].MidTierContactID__c = 'BANGKOK-PARENT-13.1';  //5
    //         lstContact[10].MidTierContactID__c = 'BANGKOK-PARENT-14.2'; //6
    //         lstContact[11].MidTierContactID__c = 'BANGKOK-PARENT-14.1'; //6

            
    //         lstContact2[0].MidTierContactID__c = 'BANGKOK-PARENT-1.1'; //1
    //         lstContact2[1].MidTierContactID__c = 'BANGKOK-PARENT-1.2'; //1
    //         lstContact2[2].MidTierContactID__c = 'BANGKOK-PARENT-2.1'; //2
    //         lstContact2[3].MidTierContactID__c = 'BANGKOK-PARENT-2.2'; //2
    //         lstContact2[4].MidTierContactID__c = 'BANGKOK-PARENT-3.1'; //3
    //         lstContact2[5].MidTierContactID__c = 'BANGKOK-PARENT-3.2'; //3
    //         lstContact2[6].MidTierContactID__c = 'BANGKOK-PARENT-4.2'; //4
    //         lstContact2[7].MidTierContactID__c = 'BANGKOK-PARENT-4.1'; //4
    //         lstContact2[8].MidTierContactID__c = 'BANGKOK-PARENT-5.2'; //5
    //         lstContact2[9].MidTierContactID__c = 'BANGKOK-PARENT-5.1';  //5
    //         lstContact2[10].MidTierContactID__c = 'BANGKOK-PARENT-6.2'; //6
    //         lstContact2[11].MidTierContactID__c = 'BANGKOK-PARENT-6.1'; //6

    //         admissionOfficer = TestFactory.createUser('testAdmissionOfficer', profileId.id);
    //         insert admissionOfficer;
    //         System.debug('admissionOfficer: ' + admissionOfficer);
    //     }
    // }

    // @isTest
    // static void createFamilyContactWithMidTierIDTest(){
    //     System.runAs(testUserAdmin){        

    //         Test.startTest();
    //         insert lstContact;
    //         insert lstContact2;
    //         Test.stopTest();

    //         List<Contact> lstConNew = [SELECT Id FROM Contact ];

    //         System.assertEquals(lstConNew.size(), 44);
    //     }
    // }

    // @isTest
    // static void createFamilyContactManuallyTest() {
    //     System.runAs(testUserAdmin) {

    //         Test.startTest();
    //         insert lstContact;
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, null, lstAccount[6].Id, true);
    //         Test.stopTest();

    //         for(Contact con : [SELECT Id, TECH_FamilyContact__c FROM Contact WHERE Id =: lstContact[13].Id]) {
    //             System.assertEquals(true, con.TECH_FamilyContact__c != null ? true : false);
    //         }

    //         List<Contact> lstConNew = [SELECT Id FROM Contact ];
    //         System.assertEquals(lstConNew.size(), 23);
    //     }
    // }

    // @isTest
    // static void updateFamilyContactManuallyTest(){
    //     System.runAs(testUserAdmin){     
    //         insert lstContact;      
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, null, lstAccount[6].Id, true);

    //         Test.startTest();
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, lstContact[14].Id, lstAccount[6].Id, true);
    //         Test.stopTest();

    //         for(Contact con : [SELECT Id, TECH_FamilyContact__c FROM Contact WHERE Id =: lstContact[14].Id]) {
    //             System.assertEquals(true, con.TECH_FamilyContact__c != null ? true : false);
    //         }

    //         List<Contact> lstConNew = [SELECT Id FROM Contact ];
    //         System.assertEquals(23, lstConNew.size());
    //     }
    // }

    // @isTest
    // static void updateFirstParentRecordTest(){
    //     System.runAs(testUserAdmin){     
    //         insert lstContact;      
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, null, lstAccount[6].Id, true);
    //         lstContact[13].LastName = 'Pitt';
    //         lstContact[13].FirstName = 'Bradley';

    //         Test.startTest();
    //         update lstContact[13];
    //         Test.stopTest();

    //         List<Contact> lstConNew = [SELECT Id FROM Contact WHERE LastName='Pitt'];
    //         System.assertEquals(lstConNew.size(), 2);
    //     }
    // }

    // @isTest
    // static void updateSecondParentRecordTest(){
    //     System.runAs(testUserAdmin){     
    //         insert lstContact;      
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, null, lstAccount[6].Id, true);
    //         AP26_FamilyContact.mergeContact(lstContact[14].Id, lstContact[13].Id, lstAccount[6].Id, true);
    //         lstContact[14].LastName = 'Pitt';
    //         lstContact[14].FirstName = 'Bradley';

    //         Test.startTest();
    //         update lstContact[14];
    //         Test.stopTest();

    //         List<Contact> lstConNew = [SELECT Id FROM Contact WHERE txtSecondaryForename__c = 'Bradley' AND txtSecondarySurname__c = 'Pitt'];
    //         System.assertEquals(1, lstConNew.size());
    //     }
    // }


    // @isTest
    // static void unmergeFamilyContactTest(){
    //     System.runAs(testUserAdmin){    
    //         insert lstContact;      
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, null, lstAccount[6].Id, true);

    //         Test.startTest();
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, null, lstAccount[6].Id, false);
    //         Test.stopTest();

    //         for(Contact con : [SELECT Id, TECH_FamilyContact__c FROM Contact WHERE Id =: lstContact[13].Id]) {
    //             System.assertEquals(true, con.TECH_FamilyContact__c == null ? true : false);
    //         }

    //         List<Contact> lstConNew = [SELECT Id FROM Contact ];
    //         System.assertEquals(lstConNew.size(), 22);
    //     }
    // }

    
    // @isTest
    // static void unmergeSecondParentFromFamilyContactTest(){
    //     System.runAs(testUserAdmin){     
    //         insert lstContact;      
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, null, lstAccount[6].Id, true);
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, lstContact[14].Id, lstAccount[6].Id, true);

    //         Test.startTest();
    //         AP26_FamilyContact.mergeContact(lstContact[13].Id, lstContact[14].Id, lstAccount[6].Id, false);
    //         Test.stopTest();

    //         for(Contact con : [SELECT Id, TECH_FamilyContact__c FROM Contact WHERE Id =: lstContact[13].Id]) {
    //             System.assertEquals(true, con.TECH_FamilyContact__c == null ? true : false);
    //         }

    //         List<Contact> lstConNew = [SELECT Id FROM Contact ];
    //         System.assertEquals(lstConNew.size(), 23);
    //     }
    // }
}