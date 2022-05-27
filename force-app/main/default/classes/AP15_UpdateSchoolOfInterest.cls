/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Server-side controller for the component LC10_OpportunityRelatedList
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 11-10-2018   AMU    1.0     Initial version
-- 12-04-2021   FKH    1.1     Case 3305 FKH - business account contacts rule
--------------------------------------------------------------------------------------
***************************************************************************************/
public with sharing class AP15_UpdateSchoolOfInterest {
	
	public static void updateSchool(List<Contact> lstCon, Set<String> setAcc){
		try {
			//Set<String> setAcc = new Set<String>();
			Map<String, String> mapAccIdToSchoolId = new Map<String, String>();

			//for(Contact con: lstCon) {
			//	setAcc.add(con.AccountId);
			//}

			for(Account acc: [SELECT Id, SchoolOfInterest__c FROM Account WHERE Id IN: setAcc]) {
				mapAccIdToSchoolId.put(acc.Id, acc.SchoolOfInterest__c);
			}

			for(Contact con: lstCon) {
				con.SchoolOfInterest__c = mapAccIdToSchoolId.get(con.AccountId);
			}
		} catch(Exception e) {
			System.debug(e.getMessage());
		}
	}

	public static void updateSchoolBusinessAccount(List<Contact> lstCon, String schoolCode){ // Case 3305 FKH - business account contacts rule
		try {

			List<School__c> lstUserSchool = [SELECT id from School__c where schoolCode__c = :schoolCode];
            if (lstUserSchool[0]!=null){
                   for(Contact con: lstCon) {
                    con.SchoolOfInterest__c = lstUserSchool[0].id;
                	} 
            }
			
		} catch(Exception e) {
			System.debug(e.getMessage());
		}
	}
}