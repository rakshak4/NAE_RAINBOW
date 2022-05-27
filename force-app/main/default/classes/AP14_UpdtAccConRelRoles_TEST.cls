@isTest
private class AP14_UpdtAccConRelRoles_TEST {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex test class for AP13_UpdtAccConRelRoles
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 25-SEP-2018  RRAJ    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/

    static Map<String, Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});
    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Contact> lstCon;


    static{
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstAcc = new List<Account>{
                TestFactory.createAccount('testAcc1')
                ,TestFactory.createAccount('testAcc2')
            };

            insert lstAcc;

            lstCon = new List<Contact>{
                                        TestFactory.createContact('testLastname1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                                        ,TestFactory.createContact('testLastname2', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))
                                        ,TestFactory.createContact('testLastname3', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))
                                        ,TestFactory.createContact('testLastname4', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))
                                    };
            //insert lstCon;                        
        }
    }

    @isTest
    public static void insertConWithRel(){
        System.runAs(lstUser[0]){
            lstCon[0].NatureOfRelationship__c = AP_Constant.conNatureRelChild;
            lstCon[1].NatureOfRelationship__c = AP_Constant.conNatureRelMother;
            lstCon[2].NatureOfRelationship__c = AP_Constant.conNatureRelFather;
            lstCon[3].NatureOfRelationship__c = AP_Constant.conNatureRelAssistant;

            Test.startTest();
            insert lstCon;
            Test.stopTest();

            list<Contact> lstConIns = [SELECT Id, NatureOfRelationship__c FROM Contact WHERE AccountId IN: lstAcc ORDER BY LastName];

            System.assertEquals(AP_Constant.conNatureRelChild, lstConIns[0].NatureOfRelationship__c);
            System.assertEquals(AP_Constant.conNatureRelMother, lstConIns[1].NatureOfRelationship__c);
            System.assertEquals(AP_Constant.conNatureRelFather, lstConIns[2].NatureOfRelationship__c);
            System.assertEquals(AP_Constant.conNatureRelAssistant, lstConIns[3].NatureOfRelationship__c);
        }
    }

    @isTest
    public static void insertConWithoutRel(){
        System.runAs(lstUser[0]){

            Test.startTest();
            insert lstCon;
            Test.stopTest();

            list<Contact> lstConIns = [SELECT Id, NatureOfRelationship__c FROM Contact WHERE AccountId IN: lstAcc ORDER BY LastName];

            System.assertEquals(null, lstConIns[0].NatureOfRelationship__c);
            System.assertEquals(null, lstConIns[1].NatureOfRelationship__c);
            System.assertEquals(null, lstConIns[2].NatureOfRelationship__c);
            System.assertEquals(null, lstConIns[3].NatureOfRelationship__c);
        }
    }
	
}