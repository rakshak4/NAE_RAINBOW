public with sharing class LC10_OpportunityRelatedListController {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Server-side controller for the component LC10_OpportunityRelatedList
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 23-08-2018   KZE    1.0     Initial version
-- 31-JAN-2019  ANA	   1.2	   Case 00001558
-- 05-JUL-2019  CRA    1.3	   W-000531 - Auto populate Opportunity Name with the Child name
-- 31-JUL-2019  CRA    1.4     Removed Sixth child Section - Application Form R2.0
-- 04-OCT-2019  CRA    1.5     Implement Case 00002030 - Auto populate DayBoarding field
--------------------------------------------------------------------------------------
***************************************************************************************/
    @AuraEnabled
	public static Object getOpportunities(Id contactID) {
		Map<String, Object> mapResult = new Map<String, Object>();

		Map<String, Schema.RecordTypeInfo> mapOppRecTypes = Schema.SObjectType.Opportunity.getRecordTypeInfosByName();
		mapResult.put('lstRecTypes', mapOppRecTypes.keySet());

		List<Opportunity> lstOpp = [SELECT Id, Name, Account.Name, CloseDate FROM Opportunity WHERE Child__c =: contactID];
		mapResult.put('lstOpp', lstOpp);

		return mapResult;
	}

	@AuraEnabled
	public static String deleteOpp(Id oppId) {		
		Opportunity opp =[SELECT Id, Name	FROM Opportunity 
							WHERE Id =: oppId];
		String oppName = opp.Name;
		delete opp;
		
		return oppName;
	}

	@AuraEnabled
	public static Object pepopulateNewOpp(Id conId, String recTypeName){
		Map<String, Schema.RecordTypeInfo> mapOppRecTypes = Schema.SObjectType.Opportunity.getRecordTypeInfosByName();
		String recTypeId = mapOppRecTypes.get(recTypeName).getRecordTypeId();

		User currUser = [SELECT Id, SchoolCode__c FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        //String boardingBasedOnschool = (currUser.SchoolCode__c == AP_Constant.schLincoln || currUser.SchoolCode__c == AP_Constant.schNorthbridge || currUser.SchoolCode__c == AP_Constant.schBoston) ? AP_Constant.ledBoardingDay : null;
        
		//CRA20191004 - Case00002030
		School__c userSchool = [SELECT Id, DayBoarding__c FROM School__c WHERE SchoolCode__c = :currUser.SchoolCode__c LIMIT 1];
		String boardingBasedOnSchool = null;
		if (userSchool != null && userSchool.DayBoarding__c == AP_Constant.ledBoardingDay) {
			boardingBasedOnSchool = AP_Constant.ledBoardingDay;
		}
		else if (userSchool != null && userSchool.DayBoarding__c == AP_Constant.ledBoarding) {
			boardingBasedOnSchool = AP_Constant.ledBoarding;
		} //End CRA
		
		Contact currCon = [SELECT Id, FirstName, LastName, Salutation, Suffix, AccountId FROM Contact WHERE Id = :conId];

		List<Lead> lstLead = [SELECT LeadSource, LeadSubSource__c, ReferredBy__c,ReferredByContact__c, EnrollmentDateFirstChild__c,
								FirstNameFirstChild__c, LastNameFirstChild__c, FirstNameSecondChild__c, LastNameSecondChild__c, 
								EnrollmentDateSecondChild__c, FirstNameThirdChild__c, LastNameThirdChild__c, EnrollmentDateThirdChild__c, 
								FirstNameFourthChild__c, LastNameFourthChild__c, EnrollmentDateFourthChild__c, FirstNameFifthChild__c, 
								LastNameFifthChild__c, EnrollmentDateFifthChild__c FROM lead WHERE ConvertedAccountId =: currCon.AccountId];

		Opportunity opp = new Opportunity(
			Child__c = currCon.Id,
			AccountId = currCon.AccountId,
			SchoolOfInterest__c = userSchool.Id,
			RecordTypeId = recTypeId,
			StageName = AP_Constant.oppStageEnquiry,
            DayOrBoardingSchool__c = boardingBasedOnschool,	//ANA20190131: Case 0001558
			Name = String.join(new List<String>{
													currCon.Salutation, 
													currCon.FirstName, 
													currCon.LastName, 
													currCon.Suffix} 
									, ' ') //CRA20190705: W-000531
		);

		if(lstLead.size() > 0) {
			Lead led = lstLead[0];
			opp.LeadSource = led.LeadSource;
            opp.LeadSubSource__c = led.LeadSubSource__c;
            opp.ReferredBy__c = led.ReferredBy__c;
            opp.ReferredByContact__c = led.ReferredByContact__c;
            opp.CloseDate = currCon.FirstName == led.FirstNameFirstChild__c && currCon.LastName == led.LastNameFirstChild__c? led.EnrollmentDateFirstChild__c : opp.CloseDate;
			opp.CloseDate = currCon.FirstName == led.FirstNameSecondChild__c && currCon.LastName == led.LastNameSecondChild__c? led.EnrollmentDateSecondChild__c : opp.CloseDate;
			opp.CloseDate = currCon.FirstName == led.FirstNameThirdChild__c && currCon.LastName == led.LastNameThirdChild__c? led.EnrollmentDateThirdChild__c : opp.CloseDate;
			opp.CloseDate = currCon.FirstName == led.FirstNameFourthChild__c && currCon.LastName == led.LastNameFourthChild__c? led.EnrollmentDateFourthChild__c : opp.CloseDate;
			opp.CloseDate = currCon.FirstName == led.FirstNameFifthChild__c && currCon.LastName == led.LastNameFifthChild__c? led.EnrollmentDateFifthChild__c : opp.CloseDate;
			//opp.CloseDate = currCon.FirstName == led.FirstNameSixthChild__c && currCon.LastName == led.LastNameSixthChild__c? led.EnrollmentDateSixthChild__c : opp.CloseDate;
		}

		return opp;
	}
}