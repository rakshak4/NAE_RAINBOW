/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP33_LeadTaskActivityDate
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 22-JUN-2021  FKH    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class AP21_UpdateAccLastActivityDate_TEST {
    static List<User> lstUser;
    static List<Task> lstTask;
    static Map<String,Id> mapRecordType;
    static List< Account > lstAccount = new List< Account >();
    static List< Contact > lstContact = new List< Contact >();

    static {
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        lstUser[0].Schoolcode__c = 'XXX';
        insert lstUser;

        System.runAs(lstUser[0]){

        lstAccount = new List< Account > {
            TestFactory.createAccount('Jones Henry Family'),
            TestFactory.createAccount('Paul Smith Family'), 
            TestFactory.createAccount('Tom Ford Family'),   
            TestFactory.createAccount('Bill Adams Family') 
        };
        insert lstAccount;

        }
    }

    @isTest public static void updateLastActivityDateTest(){
        System.runAs(lstUser[0]){
            test.StartTest();
            lstTask = new List<Task>{
                TestFactory.createTask('task1')
            };
            lstTask[0].WhatId = lstAccount[0].id;

            insert lstTask;

            test.StopTest();

            List<Account> lstUpdatedAccount = [SELECT Id, TECH_LastActivityDate__c FROM Account WHERE id IN: lstAccount];
            System.assertNotEquals(lstUpdatedAccount[0].TECH_LastActivityDate__c,null);
            System.assertEquals(lstUpdatedAccount[1].TECH_LastActivityDate__c,null);
            System.assertEquals(lstUpdatedAccount[2].TECH_LastActivityDate__c,null);
            System.assertEquals(lstUpdatedAccount[3].TECH_LastActivityDate__c,null);

        }
    }
    @isTest public static void updateAccsLastActivityDateTest(){
        System.runAs(lstUser[0]){
            test.StartTest();
            lstContact = new List < Contact > {
                TestFactory.createContact('Jones Henry', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))        
            };
            insert lstContact;
            test.StopTest();

            List<Account> lstUpdatedAccount = [SELECT Id, TECH_LastActivityDate__c FROM Account WHERE id IN: lstAccount];
            System.assertEquals(lstUpdatedAccount[0].TECH_LastActivityDate__c,null);
            System.assertNotEquals(lstUpdatedAccount[1].TECH_LastActivityDate__c,null);
            System.assertEquals(lstUpdatedAccount[2].TECH_LastActivityDate__c,null);
            System.assertEquals(lstUpdatedAccount[3].TECH_LastActivityDate__c,null);

        }
    }


}