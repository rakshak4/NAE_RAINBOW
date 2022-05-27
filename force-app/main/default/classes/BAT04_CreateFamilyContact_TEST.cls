/**
 * @File Name          : BAT04_CreateFamilyContact_TEST.cls
 * @Description        : Test class for BAT04_CreateFamilyContact
 * @Author             : CRA
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 07-23-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    13/01/2020         CRA                    Initial Version
 * 1.1    23/07/2020         CRA                    Comment codes due to Merge Functionality non usage
**/
@isTest public with sharing class BAT04_CreateFamilyContact_TEST {
    // static Map<string,Id> mapRecordType = new Map<String, Id>();
    // static User usrTestAdmin;
    // static List< Account > lstAccount = new List< Account >();
    // static List< Contact > lstContact = new List< Contact >();
    // static {
    //     //creating user
    //     usrTestAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
    //     insert usrTestAdmin;

    //     CS_Bypass__c setting = new CS_Bypass__c(SetupOwnerId=usrTestAdmin.Id, BypassTrigger__c='AP26');
    //     insert setting;

    //     System.runAs(usrTestAdmin){

    //         mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject});
            
    //         lstAccount = new List< Account > { //creating account
    //             TestFactory.createAccount('Jones Henry Family'),//0
    //             TestFactory.createAccount('Tom Ford Family'),   //1
    //             TestFactory.createAccount('Bill Adams Family') //2
    //         };
    //         insert lstAccount;

    //         lstContact = new List < Contact > { //creating contact
    //             TestFactory.createContact('Jones Henry', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),//0
    //             TestFactory.createContact('Joe Henry', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),   //1
    //             TestFactory.createContact('Paul Henry', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)), //2             
    //             TestFactory.createContact('James Ford', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //3
    //             TestFactory.createContact('Tom Ford', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),   //4
    //             TestFactory.createContact('Peter Ford', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),  //5             
    //             TestFactory.createContact('Bill Adams', lstAccount[2].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //6             
    //             TestFactory.createContact('Ben Adams', lstAccount[2].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))    //7         
    //         };
    //         lstContact[0].MidTierContactID__c = 'AUBONNE-PARENT-2.1';
    //         lstContact[1].MidTierContactID__c = 'AUBONNE-PARENT-2.2';
    //         lstContact[2].MidTierContactID__c = 'AUBONNE-CHILD-1';
    //         lstContact[3].MidTierContactID__c = 'AUBONNE-PARENT-3.1';
    //         lstContact[4].MidTierContactID__c = 'AUBONNE-PARENT-3.2';
    //         lstContact[5].MidTierContactID__c = 'AUBONNE-CHILD-2';
    //         insert lstContact;
    //     }
    // }

    // @isTest public static void createFamilyContactTest() {
    //     System.runAs(usrTestAdmin) {
    //         test.StartTest();  
    //             BAT04_CreateFamilyContact batchObj = new BAT04_CreateFamilyContact('AUBONNE');
    //             Database.executeBatch(batchObj , 200);
    //         test.StopTest();
            
    //         List<Contact> lstConRes = [SELECT Id FROM Contact];
    //         System.assertEquals(10, lstConRes.size());
    //     }
    // }

}