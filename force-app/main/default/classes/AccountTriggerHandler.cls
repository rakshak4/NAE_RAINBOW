public with sharing class AccountTriggerHandler {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Account Trigger Handler Class
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 18-MAY-2018  RRAJ   1.0     Initial Version
-- 14-OCT-2019  CRA    1.1     Add After update logic
-- 30-MAR-2021  VJA    2.0     NDM: Acc handle before delete (Explicitly delete opps to invoke opp trigger)
-- 24-SEP-2021  FKH    2.2     Case 00004164: BigFoot requirement
-- 22-OCT-2021  FKH    2.3     Case 00004232: Autumn Leaves Enhancement
-- 01-MAR-2022  FKH    2.3     Case 00004544: Bypass B2B Account
--------------------------------------------------------------------------------------
**************************************************************************************/
    private CS_Bypass__c userBypass;
    private static Map<String,Id> mapRecordType; 
    public AccountTriggerHandler(){
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.accObject}); //map of record types used in this class 
    }
    public void OnBeforeInsert(List<Account> lstNewAcc){
        Map<Account, Id> mapAccToSchId = new Map<Account, Id>();
        Map<Id, List<Account>> mapAccToOwnerId = new Map<Id, List<Account>>();
        List<Account> lstBusinessAcc = new List<Account>();
        for(Account acc : lstNewAcc){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP01')){
                if(acc.SchoolOfInterest__c != null){
                    mapAccToSchId.put(acc, acc.SchoolOfInterest__c);
                }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP25')) { //CRA20191126 - Case00002090: Set school of interest
                if(acc.RecordTypeId == mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships)) {
                    lstBusinessAcc.add(acc);
                    if(acc.SchoolOfInterest__c == null){
                        if (mapAccToOwnerId.containsKey(acc.OwnerId)) {
                            mapAccToOwnerId.get(acc.OwnerId).add(acc);
                        }
                        else {
                            mapAccToOwnerId.put(acc.OwnerId, new List<Account> {acc});
                        }
                    }
                }
            }
        }
        if(mapAccToSchId.size()>0){
            //System.debug('#### mapAccToSchId: '+mapAccToSchId);
            AP01_LeadConvert.updateAccEmail(mapAccToSchId);
        }
        
        if (mapAccToOwnerId.size() > 0) {
            AP25_AccountRules.setSchoolOfInterest(mapAccToOwnerId);
        }
        
        if (lstBusinessAcc.size() > 0) {
            AP25_AccountRules.setBusinessOriginalAccountName(lstBusinessAcc);
        }
    }
    
     public void OnAfterInsert(List<Account> lstNewAcc) {
        List<Account> lstAccountToReassign= new List<Account>(); // FKH Case 00004164
        Set<ID> setSchoolIDToReassign = new Set<ID>(); 

        for (Integer i = 0; i < lstNewAcc.size(); i++) {
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP25')) { 
                lstAccountToReassign.add(lstNewAcc[i]);
                setSchoolIDToReassign.add(lstNewAcc[i].schoolofinterest__c);
            }            
        }
     
        if(lstAccountToReassign.size()>0){ // FKH Case 00004164
            AP25_AccountRules.assignRecordToCoordinator(lstAccountToReassign, setSchoolIDToReassign);
        }
    }

    public void OnBeforeUpdate(List<Account> lstOldAcc, List<Account> lstNewAcc) {
        Map<Id, Account> mapAccPrimaryCon = new Map<Id, Account>();
        for (Integer i = 0; i < lstNewAcc.size(); i++) {
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP25')) {//FKH Case 4544 - bypass B2B
                if (lstNewAcc[i].PrimaryContact__c != lstOldAcc[i].PrimaryContact__c && lstNewAcc[i].RecordTypeId != mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships)) {
                    mapAccPrimaryCon.put(lstNewAcc[i].PrimaryContact__c, lstNewAcc[i]);
                }
            }
        }
    
        if (mapAccPrimaryCon.size() > 0) {
            AP25_AccountRules.setPhoneAndEmail(mapAccPrimaryCon);
        }
    }   


    //VJA20210330 -NDM 2.0
    public void handleBeforeDelete(List<Account> lstOldAcc){
        Set<Id> setAccId = new Set<Id>();
        for (Integer i = 0; i < lstOldAcc.size(); i++) {
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP32')) {
                setAccId.add(lstOldAcc[i].Id);
            }
        }
        if(setAccId.size() > 0){
            //To find work around - VJA20210513
            //AP32_DeleteOpportunity.deleteAccountOpportunity(setAccId);
        }
    }

    public void OnAfterUpdate(List<Account> lstOldAcc, List<Account> lstNewAcc) {
        Set<ID> setAllRelatedAccIds = new Set<ID>();
        Boolean execBatch = false;

            for (Integer i = 0; i < lstNewAcc.size(); i++) {
                if((userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP25'))){
                    if(lstNewAcc[i].RecordTypeId == mapRecordType.get(AP_Constant.accRecordTypeExternalRelationships) && lstNewAcc[i].ParentId!=lstOldAcc[i].ParentId){
                        execBatch = true;
                        break;
                    }
                }
            }

            if(execBatch)   Id batchJobId = Database.executeBatch(new BAT27_RecalculateContracts());
    }
}