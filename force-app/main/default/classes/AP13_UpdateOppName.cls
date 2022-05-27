/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex class to update opportunity name with its related contact name
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 21-SEPT-2018  YGO   1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/
public without sharing class AP13_UpdateOppName {

	public static void updateOppName(Map<Id, Contact> mapCon){
		List<Opportunity> lstOpp = new List<Opportunity>([	SELECT Id, Name, Child__c 
															FROM Opportunity 
															WHERE Child__c IN :mapCon.keySet()]);

		for(Opportunity opp : lstOpp){
			opp.Name = String.join(new List<String>{
													mapCon.get(opp.Child__c).Salutation, 
													mapCon.get(opp.Child__c).FirstName, 
													//mapCon.get(opp.Child__c).MiddleName,  ANA20191601: Case from Email to remove Preferred & Middle name
													mapCon.get(opp.Child__c).LastName, 
													mapCon.get(opp.Child__c).Suffix} 
									, ' ');
		}

		if(lstOpp.size() > 0){
			update lstOpp;
		}
	}
}