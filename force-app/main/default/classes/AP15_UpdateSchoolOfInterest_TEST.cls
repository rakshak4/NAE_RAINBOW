/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP15_UpdateSchoolOfInterest
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 30-OCT-2018  KZE    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class AP15_UpdateSchoolOfInterest_TEST {
    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
    static List<School__c> lstSchool;
    static Map<String,Id> mapRecordType;

    static {
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        lstUser[0].Schoolcode__c = 'XXX';
        insert lstUser;

        System.runAs(lstUser[0]){
        	lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST'),
                TestFactory.createSchool('Test', 'Mauritius', false, 'XXX')
          
            };
            insert lstSchool;

            lstAcc = new List<Account>{
            	TestFactory.createAccount('test'),
            	TestFactory.createAccount('test1')
             };
            lstAcc[0].SchoolOfInterest__c = lstSchool[0].Id;
            lstAcc[1].SchoolOfInterest__c = lstSchool[0].Id;

            insert lstAcc;

            lstContact = new List<Contact>{
                TestFactory.createContact('Smith', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),
                TestFactory.createContact('Smith', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),
                TestFactory.createContact('SmithExtern', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeExternalRelationships))

            };
            lstContact[0].FirstName = 'John';
            lstContact[1].FirstName = 'Jane';
        }
    }

    @isTest public static void updateSchoolTest(){
        System.runAs(lstUser[0]){
            test.StartTest();
        	    insert lstContact;
            test.StopTest();

            List<Contact> lstContactGOT = [SELECT Id, SchoolOfInterest__c, AccountId FROM Contact WHERE AccountId =: lstAcc[0].Id];
            System.assertEquals(lstSchool[0].Id, lstContactGOT[0].SchoolOfInterest__c);
            System.assertEquals(lstSchool[0].Id, lstContactGOT[1].SchoolOfInterest__c);
        }
    }
    
    
        @isTest public static void updateSchoolBusinessTest(){
        System.runAs(lstUser[0]){
            test.StartTest();
        	    insert lstContact;
            test.StopTest();
            List<Contact> lstContactGOT = [SELECT Id, SchoolOfInterest__c, AccountId FROM Contact WHERE AccountId =: lstAcc[1].Id];
            
            System.assertEquals(lstSchool[1].Id, lstContactGOT[0].SchoolOfInterest__c);
        }
    }
}