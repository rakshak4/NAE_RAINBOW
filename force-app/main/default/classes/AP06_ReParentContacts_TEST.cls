@isTest
private class AP06_ReParentContacts_TEST {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test Apex class for for Reparenting Account Contact Relation after a contact is deleted
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 17-JUL-2018  CRA    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User usrTestAdmin;
    static List< Account > lstAccount = new List< Account >();
    static List< Contact > lstContact = new List< Contact >();
    static {
        //creating user
        usrTestAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert usrTestAdmin;

        System.runAs(usrTestAdmin){

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject});
            //creating account
            lstAccount = new List< Account > {
                TestFactory.createAccount('Jones Henry Family'),//0
                TestFactory.createAccount('Paul Smith Family'), //1
                TestFactory.createAccount('Tom Ford Family'),   //2
                TestFactory.createAccount('Bill Adams Family') //3
            };
            insert lstAccount;

            //creating contact
            lstContact = new List < Contact > {
                TestFactory.createContact('Jones Henry', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),//0
                TestFactory.createContact('Joe Henry', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),   //1
                TestFactory.createContact('Paul Smith', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //2             
                TestFactory.createContact('James Smith', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)), //3
                TestFactory.createContact('Tom Ford', lstAccount[2].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),   //4
                TestFactory.createContact('Peter Ford', lstAccount[2].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),  //5             
                TestFactory.createContact('Bill Adams', lstAccount[3].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //6             
                TestFactory.createContact('Ben Adams', lstAccount[3].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))    //7         
            };
            insert lstContact;
        }
    }

    @isTest
    static void reparentContactsTest() {
        System.runAs(usrTestAdmin) {   
            List< Contact > lstConToMerge = new List< Contact > {
                lstContact[2], lstContact[4]
            };
            Test.startTest();
            merge lstContact[0] lstConToMerge;
            Test.stopTest();
        }
        List< AccountContactRelation > accConRel = [SELECT Id, AccountId, ContactId, Account.Name FROM AccountContactRelation WHERE ContactId =: lstContact[0].Id ORDER BY Account.Name ];
        System.assertEquals(3, accConRel.size()); 
        System.assertEquals(lstAccount[0].Id, accConRel[0].AccountId);
        System.assertEquals(lstAccount[1].Id, accConRel[1].AccountId);
        System.assertEquals(lstAccount[2].Id, accConRel[2].AccountId);
        
    }
}