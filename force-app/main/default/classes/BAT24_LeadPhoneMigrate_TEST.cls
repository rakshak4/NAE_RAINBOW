/**
 * @description       : BAT24 Test Class
 * @author            : Spoon Consulting
 * @group             : 
 * @last modified on  : 01-12-2021
 * @last modified by  : Spoon Consulting
 * Modifications Log 
 * Ver   Date         Author             Modification
 * 1.0   01-12-2021   VJA                Initial Version
**/
@isTest
public with sharing class BAT24_LeadPhoneMigrate_TEST {
    static List<User> lstUser;
    static List<Lead> lstLead;

    static {
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;
        CS_Bypass__c setting = new CS_Bypass__c(SetupOwnerId=lstUser[0].Id, BypassTrigger__c='AP02');
        insert setting;
        
        System.runAs(lstUser[0]){
            
            lstLead = new List<Lead>{
                TestFactory.createLead(null, 'Test1', 'Tester', 'childfname1', 'childlname1', 'Male', Date.newInstance(2010, 2, 2))
            };                     
                        
            lstLead[0].Parent1PrimaryEmail__c = 'user@test.com';
            lstLead[0].Parent1CountryOfResidence__c = 'France';                
            lstLead[0].Number_of_Children__c = '1';
            lstLead[0].MarketingQualifiedFirstChild__c = true;
            lstLead[0].Company = 'testComp';
            lstLead[0].IsConverted = false;
            lstLead[0].Lead_Origin__c = 'AdmissionsStage1';
            lstLead[0].Phone = null;
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = null;
            lstLead[0].Parent1HomePhone__c = null;
            
            insert lstLead;
        }
    }

    @isTest public static void test1() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '1234';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '1234';
            lstLead[0].Parent1HomePhone__c = '1234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test2() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '1234';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '1234';
            lstLead[0].Parent1HomePhone__c = '+2301234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('+2301234', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test3() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '+2301234';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '1234';
            lstLead[0].Parent1HomePhone__c = '1234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('+2301234', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test4() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '5678';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '+2301234';
            lstLead[0].Parent1HomePhone__c = '1234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('+2301234', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('5678', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test5() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '5678';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '1234';
            lstLead[0].Parent1HomePhone__c = '+2301234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('+2301234', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('5678', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test6() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '5678';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '1234';
            lstLead[0].Parent1HomePhone__c = '1234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('5678', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test7() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '+2305678';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '5678';
            lstLead[0].Parent1HomePhone__c = '1234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('+2305678', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test8() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '5678';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '+2305678';
            lstLead[0].Parent1HomePhone__c = '1234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('+2305678', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test9() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '5678';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '5678';
            lstLead[0].Parent1HomePhone__c = '1234';
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('5678', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }

    @isTest public static void test10() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
            lstLead[0].Phone = '1234';
            lstLead[0].MobilePhone = null;
            lstLead[0].Parent1MobilePhone__c = '5678';
            lstLead[0].Parent1HomePhone__c = null;
            update lstLead; 

            BAT24_LeadPhoneMigrate batchObj = new BAT24_LeadPhoneMigrate();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Lead> lstUpdatedLead = [SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead];
            System.assertEquals(null, lstUpdatedLead[0].Phone);
            System.assertEquals(null, lstUpdatedLead[0].MobilePhone);
            System.assertEquals('5678', lstUpdatedLead[0].Parent1MobilePhone__c);
            System.assertEquals('1234', lstUpdatedLead[0].Parent1HomePhone__c);
            
        }
    }
}