/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test Class for AP33_ContractRules
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 22-OCT-2021  FKH    1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
public without sharing class AP33_ContractRules_TEST {
    static User testUserAdmin;
    static User testUser2;
    static List<Account> lstAccount;
    static List<Contract> lstContract;
    static Map<string,Id> mapRecordType = new Map<String, Id>();

    static{
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert testUserAdmin;
        
        System.runAs(testUserAdmin){

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject, AP_Constant.accObject});

            lstAccount = new List<Account> {
                TestFactory.createAccount('A') //0
                ,TestFactory.createAccount('B') //1
                ,TestFactory.createAccount('C')//2
                ,TestFactory.createAccount('D')//3
                ,TestFactory.createAccount('E')//4
                ,TestFactory.createAccount('F')//5
                ,TestFactory.createAccount('Z')//6
                ,TestFactory.createAccount('X')//7
            };
            insert lstAccount;

            lstAccount[0].globalHq__c = true;
            lstAccount[1].globalHq__c = true;
            lstAccount[2].globalHq__c = true;
            lstAccount[3].globalHq__c = true;
            lstAccount[4].globalHq__c = true;
            lstAccount[5].globalHq__c = true;
            lstAccount[6].globalHq__c = true;
            lstAccount[7].globalHq__c = true;

            lstAccount[0].recordtypeid = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);
            lstAccount[1].recordtypeid = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);
            lstAccount[2].recordtypeid = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);
            lstAccount[3].recordtypeid = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);
            lstAccount[4].recordtypeid = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);
            lstAccount[5].recordtypeid = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);
            lstAccount[6].recordtypeid = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);
            lstAccount[7].recordtypeid = mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships);

            lstAccount[1].parentid = lstAccount[0].id;
            lstAccount[2].parentid = lstAccount[1].id;
            lstAccount[4].parentid = lstAccount[0].id;
            lstAccount[3].parentid = lstAccount[4].id;
            lstAccount[5].parentid = lstAccount[4].id;
            lstAccount[7].parentid = lstAccount[1].id;

            update lstAccount;
            
            lstContract = new List<Contract> {
                 TestFactory.createContract(lstAccount[1].id,System.today(), 4, 'India')
                ,TestFactory.createContract(lstAccount[3].id,System.today(), 4, 'The Americas')
                ,TestFactory.createContract(lstAccount[5].id,System.today(), 4, 'Europe')
                ,TestFactory.createContract(lstAccount[2].id,System.today(), 4, null)
                ,TestFactory.createContract(lstAccount[6].id,System.today(), 4, 'Europe')
                ,TestFactory.createContract(lstAccount[6].id,System.today(), 4, 'The Americas')
                ,TestFactory.createContract(lstAccount[1].id,System.today(), 4, 'Middle East') //6
            };

            insert lstContract;

            lstContract[3].Status = 'Activated';
            lstContract[0].Status = 'Activated';
            lstContract[1].Status = 'Activated';
            lstContract[2].Status = 'Activated';
            lstContract[4].Status = 'Activated';
            lstContract[5].Status = 'Activated';
            lstContract[6].Status = 'Activated';

            update lstContract;         
            
        }
    }
	@isTest
    static void deleteContract() {
        System.runAs(testUserAdmin){
        
            Test.startTest();
            delete lstContract[0]; 
            Test.stopTest();
        }
        
         List<Account> lstAcc = [SELECT id,name, parentid, IndiaActiveContract__c,TheAmericasActiveContract__c,SouthEastAsiaActiveContract__c,MiddleEastActiveContract__c,EuropeActiveContract__c, ChinaActiveContract__c from Account WHERE Id in:lstAccount];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[0].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[0].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[0].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[0].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[0].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[1].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[1].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[1].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[1].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[1].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[1].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[2].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[2].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[2].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[2].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[3].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[3].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[3].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[3].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[4].IndiaActiveContract__c, false);   
            System.assertEquals(lstAcc[4].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[4].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[4].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[4].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[4].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[5].IndiaActiveContract__c, false);    
            System.assertEquals(lstAcc[5].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[5].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[5].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[5].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[5].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[6].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[6].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[6].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[6].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[6].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[6].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[7].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[7].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[7].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[7].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[7].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[7].ChinaActiveContract__c, false);
 
 
        }
    
    }
    
    @isTest
    static void updateAccountSpecificRegionsTestSetActive() {
 
        List<Account> lstAcc = [SELECT id, parentid, IndiaActiveContract__c,TheAmericasActiveContract__c,SouthEastAsiaActiveContract__c,MiddleEastActiveContract__c,EuropeActiveContract__c, ChinaActiveContract__c from Account WHERE Id in:lstAccount];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].IndiaActiveContract__c, true);
            System.assertEquals(lstAcc[0].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[0].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[0].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[0].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[0].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[1].IndiaActiveContract__c, true);
            System.assertEquals(lstAcc[1].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[1].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[1].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[1].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[1].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[2].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[2].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[2].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[2].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[3].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[3].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[3].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[3].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[4].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[4].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[4].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[4].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[4].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[4].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[5].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[5].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[5].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[5].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[5].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[5].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[6].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[6].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[6].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[6].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[6].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[6].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[7].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[7].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[7].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[7].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[7].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[7].ChinaActiveContract__c, false);
        }   
    
    }

    @isTest
    static void updateAccountSpecificRegionsTestSetRegion() {
        System.runAs(testUserAdmin){
        
            Test.startTest();
            lstContract[3].Region__c = 'China'; //c
            lstContract[1].Region__c = null; //d
            update lstContract; 
            Test.stopTest();
        }

        List<Account> lstAcc = [SELECT id, parentid, IndiaActiveContract__c,TheAmericasActiveContract__c,SouthEastAsiaActiveContract__c,MiddleEastActiveContract__c,EuropeActiveContract__c, ChinaActiveContract__c from Account WHERE Id in:lstAccount];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].IndiaActiveContract__c, true);
            System.assertEquals(lstAcc[0].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[0].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[0].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[0].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[0].ChinaActiveContract__c, true);

            System.assertEquals(lstAcc[1].IndiaActiveContract__c, true);
            System.assertEquals(lstAcc[1].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[1].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[1].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[1].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[1].ChinaActiveContract__c, true);

            System.assertEquals(lstAcc[2].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[2].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[2].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[2].ChinaActiveContract__c, true);

            System.assertEquals(lstAcc[3].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[3].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[3].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[3].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[4].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[4].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[4].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[4].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[4].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[4].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[5].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[5].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[5].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[5].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[5].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[5].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[6].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[6].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[6].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[6].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[6].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[6].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[7].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[7].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[7].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[7].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[7].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[7].ChinaActiveContract__c, false);
        }   
    }

    @Istest
    static void deteteAccountTest() {
        System.runAs(testUserAdmin){
        
            Test.startTest();
            Delete lstAccount[4];
            Test.stopTest();
        }

        List<Account> lstAcc = [SELECT id,name, parentid, IndiaActiveContract__c,TheAmericasActiveContract__c,SouthEastAsiaActiveContract__c,MiddleEastActiveContract__c,EuropeActiveContract__c, ChinaActiveContract__c from Account WHERE Id in:lstAccount];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].IndiaActiveContract__c, true);
            System.assertEquals(lstAcc[0].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[0].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[0].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[0].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[0].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[1].IndiaActiveContract__c, true);
            System.assertEquals(lstAcc[1].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[1].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[1].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[1].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[1].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[2].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[2].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[2].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[2].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[3].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[3].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[3].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[3].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[4].IndiaActiveContract__c, false);    //F
            System.assertEquals(lstAcc[4].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[4].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[4].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[4].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[4].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[5].IndiaActiveContract__c, false);    //Z
            System.assertEquals(lstAcc[5].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[5].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[5].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[5].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[5].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[6].IndiaActiveContract__c, false);    //X
            System.assertEquals(lstAcc[6].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[6].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[6].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[6].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[6].ChinaActiveContract__c, false);
        }   
    }

    @Istest
    static void updateHierarchy() {
        System.runAs(testUserAdmin){
        
            Test.startTest();
            lstAccount[1].parentid = lstAccount[0].id;
            lstAccount[7].parentid = lstAccount[1].id;
            lstAccount[2].parentid = lstAccount[1].id;
            lstAccount[4].parentid = lstAccount[6].id;
            lstAccount[3].parentid = lstAccount[4].id;
            lstAccount[5].parentid = lstAccount[4].id;
            update lstAccount;
            Test.stopTest();
        }

        List<Account> lstAcc = [SELECT id,name, parentid, IndiaActiveContract__c,TheAmericasActiveContract__c,SouthEastAsiaActiveContract__c,MiddleEastActiveContract__c,EuropeActiveContract__c, ChinaActiveContract__c from Account WHERE Id in:lstAccount];
        if (lstAcc.size() > 0) {
            System.assertEquals(lstAcc[0].IndiaActiveContract__c, true);
            System.assertEquals(lstAcc[0].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[0].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[0].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[0].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[0].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[1].IndiaActiveContract__c, true);
            System.assertEquals(lstAcc[1].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[1].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[1].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[1].MiddleEastActiveContract__c, true);
            System.assertEquals(lstAcc[1].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[2].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[2].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[2].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[2].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[2].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[3].IndiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[3].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[3].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[3].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[3].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[4].IndiaActiveContract__c, false);   
            System.assertEquals(lstAcc[4].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[4].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[4].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[4].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[4].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[5].IndiaActiveContract__c, false);    
            System.assertEquals(lstAcc[5].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[5].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[5].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[5].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[5].ChinaActiveContract__c, false);

            System.assertEquals(lstAcc[6].IndiaActiveContract__c, false);    //X
            System.assertEquals(lstAcc[6].EuropeActiveContract__c, true);
            System.assertEquals(lstAcc[6].TheAmericasActiveContract__c, true);
            System.assertEquals(lstAcc[6].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[6].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[6].ChinaActiveContract__c, false);
           
            System.assertEquals(lstAcc[7].IndiaActiveContract__c, false);    //X
            System.assertEquals(lstAcc[7].EuropeActiveContract__c, false);
            System.assertEquals(lstAcc[7].TheAmericasActiveContract__c, false);
            System.assertEquals(lstAcc[7].SouthEastAsiaActiveContract__c, false);
            System.assertEquals(lstAcc[7].MiddleEastActiveContract__c, false);
            System.assertEquals(lstAcc[7].ChinaActiveContract__c, false);
        }   
    }
}