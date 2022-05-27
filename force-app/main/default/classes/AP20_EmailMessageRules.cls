public class AP20_EmailMessageRules {
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
    public static void updateEmailMessages(List<EmailMessage> lstEMsg, set<Id> setOppId){
        
        map<id,opportunity> mapOppIdAccId = new map<id,opportunity>([Select Id, AccountId from opportunity where id in :setOppId]);
        for(EmailMessage EMsg : lstEMsg){
            EMsg.RelatedToId = mapOppIdAccId.get(EMsg.RelatedToId).AccountId;
        }
    }
    
}