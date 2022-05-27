/**
 * @File Name          : LC12_DataTableController_TEST.cls
 * @Description        : Test Class for LC12_DataTableController.cls
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 12-JAN-2021, 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    12-JAN-2021, 10:00 am         VJA         Initial Version
**/
@isTest
public with sharing class LC12_DataTableController_TEST {
    
    static List<Account> lstAcc;
    static List<String> lstIds;
    static LC12_DataTableController.ResultWrapper resultWrapper;
    static Boolean errorFlag;

   static{
        lstAcc = new List<Account>{new Account(name = 'Account1'), new Account(name = 'Account2')};
        insert lstAcc;
        errorFlag = false;

        lstIds = new List<String>();
        for(Account acc : lstAcc){
            lstIds.add(acc.Id);
        }
   }

    @isTest //If method fail, make sure Account_Fieldset_Test exists in you standard Account object
    public static void testLoadData(){
        System.debug([select id, ownerId from account]);
        Test.StartTest();
                resultWrapper = LC12_DataTableController.loadDataTable('Account', 'Account_Fieldset_Test', lstIds);
        Test.StopTest();

        lstAcc = [select id, name, ownerId from account];
        String strResult = JSON.serialize(resultWrapper);
        System.assertEquals(true, strResult.contains('"linkName":"/'+lstAcc[0].id+'"'));
        System.assertEquals(true, strResult.contains('"Name":"Account1"'));
        System.assertEquals(true, strResult.contains('"linkOwnerName":"/'+lstAcc[1].ownerId+'"'));
        System.assertEquals(true, strResult.contains('"OwnerName":"'));
    }

    @isTest
    public static void testInvalidObjectApiName(){
        Test.StartTest();
            try{
                resultWrapper = LC12_DataTableController.loadDataTable('Account@Invalid', 'Account_Fieldset_Test', lstIds);
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
                resultWrapper = LC12_DataTableController.loadDataTable('Account', 'Account_Fieldset_Test@Invalid', lstIds);
            }catch(Exception e){
                errorFlag = true;
            }
        Test.StopTest();
        System.assert(errorFlag);
    }
}