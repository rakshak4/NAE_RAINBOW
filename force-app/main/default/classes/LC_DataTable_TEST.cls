/**
 * @File Name          : LC_DataTable_TEST.cls
 * @Description        : Test Class for LC_DataTable.cls
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 29-JAN-2021, 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    29-JAN-2021, 10:00 am         VJA         Initial Version
**/
@isTest
public with sharing class LC_DataTable_TEST {
    
    static List<Account> lstAccIns, lstAcc;
    static List<String> lstIds;
    static LC_DataTable.ResultWrapper resultWrapper;
    static Boolean errorFlag;

   static{
        lstAccIns = new List<Account>{new Account(name = 'Account1'), new Account(name = 'Account2')};
        insert lstAccIns;
        errorFlag = false;

        lstAcc = [SELECT Id, Name, OwnerId from Account];
        System.debug('###lstAcc: ' + JSON.serialize(lstAcc));
        
   }

    @isTest //If method fail, make sure Account_Fieldset_Test exists in you standard Account object
    public static void testLoadData(){
        System.debug([select id, ownerId from account]);
        Test.StartTest();
                resultWrapper = LC_DataTable.loadDataTable('Account', 'Account_Fieldset_Test', JSON.serialize(lstAcc));
        Test.StopTest();

        lstAcc = [select id, name, ownerId from account];
        String strResult = JSON.serialize(resultWrapper);

        System.assertEquals(true, strResult.contains('"Name":"Account1"'));
        System.assertEquals(true, strResult.contains('"linkOwnerName":"/'+lstAcc[1].ownerId+'"'));
        System.assertEquals(true, strResult.contains('"OwnerName":"'));
        System.assertEquals(true, strResult.contains('"OwnerId":"'+lstAcc[0].ownerId+'"'));

    }

    @isTest
    public static void testInvalidObjectApiName(){
        Test.StartTest();
            try{
                resultWrapper = LC_DataTable.loadDataTable('Account@Invalid', 'Account_Fieldset_Test', JSON.serialize(lstAcc));
            }catch(Exception e){
                errorFlag = true;
            }
        Test.StopTest();
        System.assert(errorFlag);
    }

    @isTest
    public static void testInvalidFieldSet(){
        Test.StartTest();
            try{
                resultWrapper = LC_DataTable.loadDataTable('Account', 'Account_Fieldset_Test@Invalid', JSON.serialize(lstAcc));
            }catch(Exception e){
                errorFlag = true;
            }
        Test.StopTest();
        System.assert(errorFlag);
    }
}