public class AP17_EventRules {
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
    public static void updateLastVisitDate(List<Event> lstEvent, Set<Id> setAccId){
        map<id, DateTime> mapAccIdVisitDate = new map<id, DateTime>();
        for(Account acc: [SELECT id, AccountFirstVisitDate__c FROM Account WHERE id in: setAccId]){
            mapAccIdVisitDate.put(acc.id, acc.AccountFirstVisitDate__c);
        }
        
        map<id, List<Opportunity>> mapAccIdOpp = new map<id, List<Opportunity>>();
        
        for(Opportunity opp: [SELECT id, Accountid, OpportunityFirstVisitDate__c, isclosed, createdDate, EventType__c FROM Opportunity WHERE AccountId in: setAccId]){
            if(mapAccIdOpp.containsKey(opp.Accountid)){
                mapAccIdOpp.get(opp.Accountid).add(opp);
            }
            else{
                mapAccIdOpp.put(opp.Accountid, new List<Opportunity>{opp});
            }
        }
        
        List<Account> lstAccToUpdate = new List<Account>();
        List<Opportunity> lstOppToUpdate = new List<Opportunity>();
        Set<Id> setOpp = new Set<Id>();
        Set<Id> setAcc = new Set<Id>();
        
        for(Event evt: [SELECT id, EndDateTime, whatid, Type__c FROM Event WHERE id IN: lstEvent]){
            if(mapAccIdVisitDate.containsKey(evt.whatid) && 
               (mapAccIdVisitDate.get(evt.whatid) == null || (mapAccIdVisitDate.get(evt.whatid) != null  && evt.EndDateTime < mapAccIdVisitDate.get(evt.whatid))) ){
                   Account acc = new Account(id = evt.WhatId, AccountFirstVisitDate__c = evt.EndDateTime);
                   if(setAcc.contains(acc.Id) == false){
                       lstAccToUpdate.add(acc);
                       setAcc.add(acc.id);
                   }
               }
            
            if(mapAccIdOpp.containsKey(evt.whatid)){
                for(Opportunity opp: mapAccIdOpp.get(evt.whatid)){
                    if(opp.IsClosed == false && (opp.OpportunityFirstVisitDate__c == null || (evt.EndDateTime >  opp.CreatedDate && evt.EndDateTime < opp.OpportunityFirstVisitDate__c ))){
                        opp.OpportunityFirstVisitDate__c = evt.EndDateTime;
                        opp.EventType__c = evt.Type__c; //CRA20200424
                        if(setOpp.contains(opp.Id) == false){
                            lstOppToUpdate.add(opp);
                            setOpp.add(opp.Id);
                        }
                    }
                }
            }  
        }

        try{   //ANA20181218: Case 1524 - To display proper error message for end-user     
            update lstAccToUpdate;
            update lstOppToUpdate;
        }catch(DmlException e){
            for (Event Evt: lstEvent){
                Evt.addError(e.getDmlMessage(0));
            } 
        }

    }
}