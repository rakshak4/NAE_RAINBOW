/**
 * @description       : Apex class for Opportunity Contact Role utilities - Case 00002304
 * @author            : CRA
 * @group             : 
 * @last modified on  : 07-23-2020
 * @last modified by  : CRA
 * Modifications Log 
 * Ver   Date         Author   Modification
 * 1.0   07-10-2020   CRA   Initial Version
 * 2.0   23-09-2021   VJA   new function createRoles: Create missing OppConRole & assignRoles: Assign Role when OppConRole is created
**/
public with sharing class AP28_OppConRoleRules {
    /**
    * @description Update Role when the Contact is updated
    * @author CRA | 07-10-2020 
    * @param lstCon 
    **/
    public static void updateRole(Map<Id, List<AccountContactRelation>> mapConAccConRel){
        List<OpportunityContactRole> lstOppConRelToUpdt = new List<OpportunityContactRole>();
        
        for(OpportunityContactRole oppConRel : [SELECT Id, Role, ContactId, Contact.AccountId FROM OpportunityContactRole WHERE ContactId IN :mapConAccConRel.keySet()]){
            for (AccountContactRelation accConRel : mapConAccConRel.get(oppConRel.ContactId)) {
                if(accConRel.AccountId == oppConRel.Contact.AccountId){
                    oppConRel.Role = accConRel.Roles;
                    lstOppConRelToUpdt.add(oppConRel);
                }
            }
        }
        
        if(lstOppConRelToUpdt.size() > 0){
            update lstOppConRelToUpdt;
        }
    }

    /**
    * @description Create Role when the Opportunity is created
    * @author CRA | 07-10-2020 
    * @param lstCon 
    **/
    /*public static void createRole(List<Opportunity> lstOpp, Set<Id> setAccId){
        Map<Id, List<AccountContactRelation>> mapAccIdtoAccConRel = new Map<Id, List<AccountContactRelation>> ();
        List<OpportunityContactRole> lstOppConRelToIns = new List<OpportunityContactRole>();

        for (AccountContactRelation accConRel : [SELECT AccountId, ContactId, Roles FROM AccountContactRelation WHERE AccountId IN :setAccId]) {
            if (mapAccIdtoAccConRel.containsKey(accConRel.AccountId)) {
                mapAccIdtoAccConRel.get(accConRel.AccountId).add(accConRel);
            }
            else {
                mapAccIdtoAccConRel.put(accConRel.AccountId, new List<AccountContactRelation> {accConRel});
            }
        }

        for (Opportunity opp : lstOpp) {
            if(mapAccIdtoAccConRel.containsKey(opp.AccountId)) {
                for (AccountContactRelation accConRel : mapAccIdtoAccConRel.get(opp.AccountId)) {
                    lstOppConRelToIns.add(new OpportunityContactRole(
                        Role = accConRel.Roles,
                        ContactId = accConRel.ContactId,
                        OpportunityId = opp.Id
                    ));
                }
            }
        }

        if(lstOppConRelToIns.size() > 0){
            insert lstOppConRelToIns;
        }
    }
    */

    /**
    * @description Create missing Role when the Opportunity is created
    * @author VJA | 23-09-2021 
    * @param lstCon 
    **/
    public static void createRoles(List<Opportunity> lstOpp){
        Set<Id> setConId = new Set<Id>();
        List<OpportunityContactRole> lstOppConRelToIns = new List<OpportunityContactRole>();
        Map<Id, List<Id>> mapOppIdToConId = new Map<Id, List<Id>> (); //MAP of Opportunity Id to List of ContactId (Opportunity Contact Roles. One Opportunity to many Contacts)

        //Loop to get set of child contact id
        for(Opportunity opp : lstOpp){
            if(opp.child__c != null) setConId.add(opp.child__c);
            if(opp.ContactId != null) setConId.add(opp.ContactId);
        }

        //Existing Opp Con Role Query
        List<OpportunityContactRole> lstOppConRole = [SELECT OpportunityId, ContactId, Role FROM OpportunityContactRole WHERE ContactId IN :setConId];

        //Contact Query to get NatureofRelationShip__c
        Map<Id, Contact> mapIdToCon = new Map<Id, Contact>([Select id, NatureofRelationShip__c, TECH_RecordTypeName__c FROM Contact where Id in :setConId]);

        //Loop to get map of Opportunity Id to List of Contact Ids using OpportunityContactRole
        for(OpportunityContactRole oppConRole : lstOppConRole){
            if (mapOppIdToConId.containsKey(oppConRole.OpportunityId)) {
                mapOppIdToConId.get(oppConRole.OpportunityId).add(oppConRole.ContactId);
            }
            else {
                mapOppIdToConId.put(oppConRole.OpportunityId, new List<Id> {oppConRole.ContactId});
            }
        }

        for (Opportunity opp : lstOpp) {
            Id oppChildId = (opp.ContactId != null) ?  opp.ContactId : (opp.child__c != null ? opp.child__c : null);

            if(oppChildId != null){
                //Existing OpportunityContactRole under Opportunity.Id
                if(mapOppIdToConId.containsKey(opp.Id)){
                    List<Id> lstConId = mapOppIdToConId.get(opp.Id); //get List of Contact Ids using Opportunity Id
                    System.debug('##AP28.Existing');
                    //Create OpportunityContactRole if there is no existing record under Contact.Id
                    if(!lstConId.contains(oppChildId)){
                        lstOppConRelToIns.add(new OpportunityContactRole(
                            Role = mapIdToCon.get(oppChildId).NatureOfRelationship__c,
                            ContactId = oppChildId,
                            OpportunityId = opp.Id
                        ));
                    }   
                }
                else{ //No OpportunityContactRole under Opportunity.Id
                    lstOppConRelToIns.add(new OpportunityContactRole(
                        Role = mapIdToCon.get(oppChildId).NatureOfRelationship__c,
                        ContactId = oppChildId,
                        OpportunityId = opp.Id
                    ));
                }
            }
        }

        if(lstOppConRelToIns.size() > 0){
            insert lstOppConRelToIns;
        }

    }

    /**
    * @description Assign Role when OppConRole is created
    * @author VJA | 23-09-2021 
    * @param List<OpportunityContactRole> lstOppConRole 
    * @param Set<Id> setConId
    **/
    public static void assignRoles(List<OpportunityContactRole> lstOppConRole, Set<Id> setConId){
        Map<Id, Contact> mapIdToCon = new Map<Id, Contact>([Select id, NatureofRelationShip__c, TECH_RecordTypeName__c FROM Contact where Id in :setConId]);

        for(OpportunityContactRole oppConRole :  lstOppConRole){
            if(mapIdToCon.get(oppConRole.ContactId) != null){
                Contact con = mapIdToCon.get(oppConRole.ContactId);
                oppConRole.Role = con.NatureofRelationShip__c;
            }
        }
    }

}