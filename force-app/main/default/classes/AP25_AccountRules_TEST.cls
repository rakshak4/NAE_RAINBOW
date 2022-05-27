/**
 * @File Name          : AP25_AccountRules_TEST.cls
 * @Description        : Test class for Account rules
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 14/10/2019, 16:41:04
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    14/10/2019          CRA                   Initial Version
 * 1.1	  09/04/2021 		  FKH					Update business account name - derived from name
 * 1.2	  09/04/2021 		  FKH					Case 3374 - Change Contact Account Address mappings
 * 1.3    24/09/2021		  FKH					Case 00004164: BigFoot requirement

**/
@isTest
public with sharing class AP25_AccountRules_TEST {
    static User testUserAdmin;
    static User testUser2;
    static List<User> lstUser;
    static List<Account> lstAccount;
    static List<Contact> lstContact;
    static List<Opportunity> lstOpp;   
    static List<School__c> lstSchool;
    static Map<string,Id> mapRecordType = new Map<String, Id>();

    static{
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        testUserAdmin.SchoolCode__c = 'TST';
        insert testUserAdmin;
        
        lstUser = new List<User>{
            TestFactory.createUser('Owner1', TestFactory.getProfileAdminId())
            ,TestFactory.createUser('Owner2', TestFactory.getProfileAdminId())
        };
        lstUser[0].LastName = 'Mulesoft';
        lstUser[0].firstName = 'Mulesoft';
        insert lstUser;


        System.runAs(testUserAdmin){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('TestUser1', 'Mauritius', false, 'TST'),
                TestFactory.createSchool('TestUser2', 'Mauritius', false, 'LOL')
            };
            
            lstSchool[0].AdmissionsQueueCoordinator__c = lstUser[1].id; 
            insert lstSchool;

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject, AP_Constant.accObject});

            lstAccount = new List<Account> {
                TestFactory.createAccount('testAcc1')
                ,TestFactory.createAccount('testAcc2')
                ,TestFactory.createAccount('testAcc3')
            };
            lstAccount[0].Email__c = 'test@testAcc1Email.com';
            lstAccount[0].Phone = '55555555555';
            lstAccount[1].Email__c = 'test@testAcc2Email.com';
            lstAccount[1].Phone = '22222222222';
            insert lstAccount;

            //creating primary contact in account
            lstContact = new List<Contact>{
                TestFactory.createContact('parent1', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //0
                ,TestFactory.createContact('parent2', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //1
                ,TestFactory.createContact('child1', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))   //2
                ,TestFactory.createContact('child2', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))   //3
                ,TestFactory.createContact('parent1Acc2', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //4
                ,TestFactory.createContact('parent2Acc2', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //5
                ,TestFactory.createContact('child1Acc2', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))   //6
            };

            lstContact[0].Email = 'test@parent1email.com';
            lstContact[0].Phone = '03552216553222';
            lstContact[1].Email = 'test@parent2email.com';
            lstContact[1].Phone = '01234567899522';
            lstContact[4].Email = 'test@parent1Acc2email.com';
            lstContact[4].Phone = '03552216553222';
            // lstContact[4].MailingStreet = 'New lane street';
            // lstContact[4].MailingState = 'State';
            // lstContact[4].MailingCity = 'London';
            // lstContact[4].MailingCountry = 'UK';
            // lstContact[4].MailingPostalCode = '12345';
            lstContact[4].AddressLine1__c = 'New lane street';
            lstContact[4].State__c = 'State';
            lstContact[4].city__c = 'London';
            lstContact[4].Countryofresidence__c = 'China';
            lstContact[4].ZipPostalCode__c = '12345';

            lstContact[5].Email = 'test@parent2Acc2email.com';
            lstContact[5].Phone = '01234567899522';
            insert lstContact; 

            lstAccount[0].PrimaryContact__c = lstContact[0].Id;
            lstAccount[1].PrimaryContact__c = lstContact[4].Id;
            update lstAccount; 
            
        }
    }
    
    @isTest
    static void assignRecordToCoordinatorTest() {
        System.runAs(lstUser[0]){
            Test.startTest();
            List<User> lstMulesoftUser = [SELECT Id,name FROM User WHERE firstname ='Mulesoft' and lastname ='Mulesoft' limit 1]; //get mulesoft user id

            List<Account> lstAccount2 = new List<Account> {
                TestFactory.createFamilyAccount('testFKH')};
                lstAccount2[0].schoolofinterest__c = lstSchool[0].id;
                lstAccount2[0].ownerid = lstMulesoftUser[0].id;
                insert lstAccount2;           
            Test.stopTest();

            List<Account> lstAcc = [SELECT id,ownerid, schoolofinterest__c,schoolofinterest__r.AdmissionsQueueCoordinator__c FROM Account WHERE Id in:lstAccount2];

            if (lstAcc.size() > 0) {
                System.assertEquals(lstAcc[0].ownerid, lstUser[1].id);
            }    
        }
    }
    
    @isTest
    static void primaryContactChangedTest(){
        System.runAs(testUserAdmin){
            Test.startTest();
                lstAccount[0].PrimaryContact__c = lstContact[1].Id;
                update lstAccount[0]; 
            Test.stopTest();
        }

        List<Account> lstAcc = [SELECT Email__c, Phone FROM Account WHERE Id =: lstAccount[0].Id];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].Email__c, lstContact[1].Email);
            System.assertEquals(lstAcc[0].Phone, lstContact[1].Phone);
        }    
    }

     @isTest
    static void primaryContactPhoneEmailChangedTest(){
        System.runAs(testUserAdmin){
            Test.startTest();
                lstContact[4].Phone = '99999999999';
                lstContact[4].Email = 'test@test.com';
                // lstContact[4].MailingStreet = 'New lane test';
                // lstContact[4].MailingState = 'test';
                // lstContact[4].MailingCity = 'test';
                // lstContact[4].MailingCountry = 'FR';
                // lstContact[4].MailingPostalCode = '11111';

                lstContact[4].AddressLine1__c ='New lane test';
                lstContact[4].AddressLine2__c ='2';
                lstContact[4].AddressLine3__c ='3';

                lstContact[4].State__c = 'test';
                lstContact[4].city__c = 'test';
                lstContact[4].Countryofresidence__c = 'China';
                lstContact[4].ZipPostalCode__c = '12345';

                update lstContact[4]; 
            Test.stopTest();
        }

        List<Account> lstAcc = [SELECT Email__c, Phone, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet FROM Account WHERE Id =: lstAccount[1].Id];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].Phone, lstContact[4].Phone);
            System.assertEquals(lstAcc[0].Email__c, 'test@test.com');
            System.assertEquals(lstAcc[0].BillingStreet, 'New lane test, 2, 3');
            System.assertEquals(lstAcc[0].BillingState, 'test');
            System.assertEquals(lstAcc[0].BillingCity, 'test');
            System.assertEquals(lstAcc[0].BillingCountry, 'China');
            System.assertEquals(lstAcc[0].BillingPostalCode, '12345');
        }    
    }

    @isTest
    static void numberOfChildrenChangedTest(){
        System.runAs(testUserAdmin){
            Test.startTest();
                Contact con = TestFactory.createContact('child2Acc2', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild));
                insert con; 
            Test.stopTest();
        }

        List<Account> lstAcc = [SELECT NumberOfChildren__c FROM Account WHERE Id =: lstAccount[1].Id];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].NumberOfChildren__c, '2');
        }    
    }

    @isTest
    static void deleteChildTest(){
        System.runAs(testUserAdmin){
            Test.startTest();
                delete  lstContact[2];
            Test.stopTest();
        }

        List<Account> lstAcc = [SELECT NumberOfChildren__c FROM Account WHERE Id =: lstAccount[0].Id];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].NumberOfChildren__c, '1');
        }    
    }

    @isTest
    static void updateChildTest(){
        System.runAs(testUserAdmin){
            Test.startTest();
                lstContact[2].AccountId = lstAccount[1].Id;
                update  lstContact[2];
            Test.stopTest();
        }

        List<Account> lstAcc = [SELECT NumberOfChildren__c FROM Account WHERE Id =: lstAccount[1].Id];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].NumberOfChildren__c, '2');
        }    
    }

    @isTest
    static void setSchoolOfInterestTest() {
        System.runAs(testUserAdmin) {
            List<Account> lstAccount2 = new List<Account> {
                 TestFactory.createAccount('testAcc1')
                ,TestFactory.createAccount('testAcc2')
                ,TestFactory.createAccount('testAcc3')
            };
            lstAccount2[0].RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(AP_Constant.accRecordTypeDeveloperNameExternalRelationships).getRecordTypeId();
            lstAccount2[1].RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(AP_Constant.accRecordTypeDeveloperNameExternalRelationships).getRecordTypeId();
            lstAccount2[2].RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(AP_Constant.accNatureOfRelationshipFamily).getRecordTypeId();
            lstAccount2[1].SchoolOfInterest__c = lstSchool[1].Id;
            Test.startTest();
            	lstAccount2[0].region__c = 'China';
            	lstAccount2[1].region__c = 'China';
                lstAccount2[0].Billingcity = 'China';
            	lstAccount2[1].Billingcity = 'China';
                insert lstAccount2;
            Test.stopTest();

            List<Account> lstAcc = [SELECT Id, SchoolOfInterest__c, SchoolOfInterest__r.SchoolCode__c FROM Account WHERE Id IN :lstAccount2 ORDER BY Name];
            System.debug('lstAcc '+lstAcc);
            if (lstAcc.size() > 0) {
                System.assertEquals(lstAcc[0].SchoolOfInterest__c, lstSchool[0].Id);
                System.assertEquals(lstAcc[1].SchoolOfInterest__c, lstSchool[1].Id);
            }
            
        }
    }
}