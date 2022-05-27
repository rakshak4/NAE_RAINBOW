public without sharing class AP21_UpdateAccLastActivityDate {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Class to update Account and Opportunity first visit date 
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 21-06-2019  AFO    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
    //afo
    public static void updateLastActivityDate(Set<id> setAccId){
        List<Account> lstAccToUpdate = new List<Account>();
        for(Id accId :  setAccId){
            Account acc = new Account(id = accId, TECH_LastActivityDate__c = system.now());
            lstAccToUpdate.add(acc);
        }
        if(lstAccToUpdate.size() > 0){
            update lstAccToUpdate;
        }
    }
    
    public static void updateAccsLastActivityDate(Set<id> setConId){
        Set<id> setAccId = new set<Id>();
        for(AccountContactRelation ACR : [SELECT ContactId, AccountId FROM AccountContactRelation WHERE ContactId IN : setConId ]){
            setAccId.add(ACR.AccountId);
        } 
        if(setAccId.size() > 0){
            updateLastActivityDate(setAccId);
        }
    }
    
}