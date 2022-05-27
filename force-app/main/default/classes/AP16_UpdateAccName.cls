/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex controller for LC06_ViewDuplicates
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 11-JUN-2018  AMU   1.0     Initial Version
-- 30-OCT-2018  KZE   1.1     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/
public with sharing class AP16_UpdateAccName {
	public static void updateAccName(Map<Id, Contact> mapOldCon, Map<Id, Contact> mapNewCon){
		List<Account> lstUpdAcc = new List<Account>();
		Set<String> setAllAccId = new Set<String>();
		Map<Id, List<String>> mapConToLstAccId = new Map<Id, List<String>>();

		for(AccountContactRelation accCon: [SELECT ContactId, AccountId FROM AccountContactRelation WHERE ContactId IN: mapOldCon.values()]) {
			setAllAccId.add(accCon.AccountId);
			if(mapConToLstAccId.containsKey(accCon.ContactId)) {
				List<String> lstAccId = mapConToLstAccId.get(accCon.ContactId);
				lstAccId.add(accCon.AccountId);
				mapConToLstAccId.put(accCon.ContactId, lstAccId);
			} else {
				mapConToLstAccId.put(accCon.ContactId, new List<String>{accCon.AccountId});
			}
		}

		Map<Id, Account> mapAcc = new Map<Id, Account>([SELECT Id, Name FROM Account WHERE Id IN : setAllAccId]);

		for(Contact con: mapOldCon.values()) {
			String familyName = String.join(new List<String>{con.FirstName, con.LastName, 'Family'}, ' ');

            if(mapConToLstAccId.size() > 0 && mapConToLstAccId.containsKey(con.Id)) { 
                for(String accId: mapConToLstAccId.get(con.Id)) {
                    //KZE-30-OCT-2018
                    Account acc = mapAcc.get(accId);
    
                    if(familyName == acc.Name) {
                        acc.Name = String.join(new List<String>{
                            mapNewCon.get(con.Id).FirstName, mapNewCon.get(con.Id).LastName, 'Family'}, ' ');
                        lstUpdAcc.add(acc);
                    }
                }
            }
			
		}

		if(lstUpdAcc.size() > 0) {
			update lstUpdAcc;
		}
	}
    
    //CRA 20190624 - Moved from AP14 
    public static void updateAccnameByAccConRole(Set<Id> setConid){
        map<id,id> ConIdAccId = new map<id,id>();
        set<id> setAccId = new Set<Id>();
        map<Id, String> IdFamName = new map<Id, String>();
        List<Account> lstAcc = new List<Account>();
        //get accounts related to contact
        for(AccountContactRelation ACR: [Select AccountId, ContactId, contact.Firstname, Contact.Lastname, TECH_ContactRecordtype__c from AccountContactRelation where contactid in : setConid ]){
            ConIdAccId.put(ACR.AccountId, ACR.ContactId);
            setAccId.add(ACR.AccountId);
        }
        
        System.debug(ConIdAccId);
        System.debug(setAccId);
        
        for(AccountContactRelation ACR: [Select AccountId, ContactId, contact.Firstname, Contact.Lastname, TECH_ContactRecordtype__c from AccountContactRelation where accountid in : setAccId ]){
            if(ACR.TECH_ContactRecordtype__c == 'Parent' && ACR.ContactId != ConIdAccId.get(ACR.AccountId)){
                setAccId.remove(ACR.AccountId);
                System.debug('#1');
            }
            else if(ACR.ContactId == ConIdAccId.get(ACR.AccountId)){
                String familyName = String.join(new List<String>{ACR.Contact.FirstName, ACR.Contact.LastName, 'Family'}, ' ');
                IdFamName.put(ACR.AccountId, familyName);
                System.debug('#2');
            }
            
        }
        
        System.debug(setAccId);
        
        for(id AccId: setAccId){
            Account acc = new Account();
            acc.Id = AccId;
            acc.name = IdFamName.get(AccId); 
            lstAcc.add(acc);
        }
        
        update lstAcc;
    }
}