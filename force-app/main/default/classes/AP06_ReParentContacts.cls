public with sharing class AP06_ReParentContacts {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for Reparenting Account Contact Relation after a contact is deleted
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 18-MAY-2017  RRAJ    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/

    public static void reparentContacts(Map<Id, List<Id>> mapConIdToAccIds, Map<Id, String> mapAccIdToRole){
        List<AccountContactRelation> lstAccConRelToInsert = new List<AccountContactRelation>();
        Map<Id, Contact> mapCon = new Map<Id, Contact>([SELECT Id, AccountId FROM Contact WHERE Id IN :mapConIdToAccIds.keySet()]);
        for(Id conId : mapConIdToAccIds.keySet()){
            for(Id accId : mapConIdToAccIds.get(conId)){
                if(accId != mapCon.get(conId).AccountId){
                    AccountContactRelation accConRel = new AccountContactRelation(
                        Roles = mapAccIdToRole.get(accId),
                        AccountId = accId,
                        ContactId = conId
                    );
                    lstAccConRelToInsert.add(accConRel);
                }
            }
        }
        if(lstAccConRelToInsert.size()>0){
            //System.debug('#### lstAccConRelToInsert: '+ lstAccConRelToInsert);
            insert lstAccConRelToInsert;
        }
    }
}