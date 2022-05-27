public with sharing class AP14_UpdtAccConRelRoles {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex class to autopopulate roles field on account contact relation
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 25-SEP-2018  RRAJ    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
    
    public static void updtRole(List<Contact> lstCon){
        Map<Id, Contact> mapCon = new Map<Id, Contact>(lstCon);
        Map<Id, Id> mapConToAccId = new Map<Id, Id>();
        
        for(Contact con : lstCon){
            mapConToAccId.put(con.Id, con.AccountId);
        }
        
        List<AccountContactRelation> lstAccConRel = [SELECT Id, Roles, ContactId, AccountId FROM AccountContactRelation WHERE AccountId IN :mapConToAccId.values() AND ContactId IN :mapConToAccId.keySet() AND isDirect = true];
        List<AccountContactRelation> lstAccConRelToUpdt = new List<AccountContactRelation>();
        
        for(AccountContactRelation accConRel : lstAccConRel){
            if(mapConToAccId.containsKey(accConRel.ContactId)){
                if(accConRel.AccountId == mapConToAccId.get(accConRel.ContactId)){
                    accConRel.Roles = mapCon.get(accConRel.ContactId).NatureOfRelationship__c;
                    lstAccConRelToUpdt.add(accConRel);
                }
            }
        }
        
        if(lstAccConRelToUpdt.size()>0){
            update lstAccConRelToUpdt;
        }
    }
    
}