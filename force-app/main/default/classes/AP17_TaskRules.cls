public class AP17_TaskRules {

/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Class to update Account and Opportunity first visit date 
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 30-OCT-2018  AFO    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
    public static void updateExpectedStartDate(Map<Id, Task> mapAccIdTask){
        Map<Id, Date> mapAccIdDate= new Map<Id, Date>();
        
        for(Opportunity opp: [Select AccountId, closedate from opportunity where AccountId in : mapAccIdTask.keyset()]){
            System.debug('2');
            if(opp.closedate != null){
                System.debug('3');
                if(mapAccIdDate.containsKey(opp.AccountId)  && opp.CloseDate < mapAccIdDate.get(opp.AccountId) ){
                    mapAccIdDate.put(opp.AccountId,opp.CloseDate);
                    System.debug('4');
                }
                else if(mapAccIdDate.containsKey(opp.AccountId) == false){
                    mapAccIdDate.put(opp.AccountId,opp.CloseDate);
                    System.debug('5');
                }
            }
        }
        
        for (Id key : mapAccIdTask.keySet()) {
            System.debug('6');
            if(mapAccIdDate.containsKey(key)){
                mapAccIdTask.get(key).ExpectedStartDate__c = mapAccIdDate.get(key);
                System.debug('7');
            }
        }
    }
    
}