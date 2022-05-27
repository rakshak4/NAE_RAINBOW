/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP16_UpdateAccName
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 30-OCT-2018  KZE    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class AP16_UpdateAccName_TEST {
    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
    static Map<String,Id> mapRecordType;

    static {
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstAcc = new List<Account>{
            	TestFactory.createAccount('test'),
            	TestFactory.createAccount('test2')
            };
            insert lstAcc;

            lstContact = new List<Contact>{
                TestFactory.createContact('Smith', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            lstContact[0].FirstName = 'John';
            insert lstContact; 

            lstAcc[0].PrimaryContact__c = lstContact[0].Id;
            lstAcc[0].Name= 'John Smith Family';
            lstAcc[1].Name= 'John Smith Family';
            update lstAcc;

            AccountContactRelation accConRel = new AccountContactRelation(
                        AccountId = lstAcc[1].id,
                        ContactId = lstContact[0].id
                    );
            insert accConRel;
        }
    }

    @isTest public static void updateAccNameTest(){
        System.runAs(lstUser[0]){
        	List<Contact> lstContactGOT = [SELECT Id, FirstName, LastName FROM Contact WHERE Id =: lstContact[0].Id];
        	lstContactGOT[0].FirstName = 'Jane';

            test.StartTest();
                update lstContactGOT;
            test.StopTest();

            List<Account> lstAccGOT = [SELECT Id, Name FROM Account WHERE Id =: lstAcc[0].Id OR Id =: lstAcc[1].Id];
            System.assertEquals('Jane Smith Family', lstAccGOT[0].Name);
            System.assertEquals('Jane Smith Family', lstAccGOT[1].Name);
        }
    }
}