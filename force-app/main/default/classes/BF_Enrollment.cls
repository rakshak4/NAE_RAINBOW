/**************************************************************************************
-- - Author        : akaCRM
-- - Description   : Enrolment Handler
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  -------------------------------------------------------
-- 09-AUG-2021  FJO    1.0     Initial version
-- 04-OCT-2021  FJO    1.1     Prior Opportunity field 'Staff__c' added too clone
-- 04-MAR-2021  FJO    1.4     Update to query to include additional record types
--------------------------------------------------------------------------------------
**************************************************************************************/
public class BF_Enrollment {
	public BF_Enrollment() {
	}

	public void createReEnrolmentOpportunities(Map<Id, Contact> promotedContactMap){
		Map<Id, Contact> contactsWithOpportunities = getExistingOpportunities(promotedContactMap.keySet());
		this.createOpportunities(promotedContactMap, contactsWithOpportunities);
	}

	public Map<Id, Contact> getExistingOpportunities(Set<Id> contactIds){
		Set<Id> recordTypes = BF_EnrollmentOpportunityConstants.ENROLMENT_SETTING_LIST_IDS;
		Map<Id, Contact> contactsWithPriorOpportunities = new Map<Id, Contact>([select Id, Promoted_Year_Grade__c, Name,
															SchoolOfInterest__c,SchoolOfInterest__r.Re_Enrolment_Close_Date__c,
															AccountId, MidTierContactID__c, DayOrBoardingSchool__c, Day_or_Boarding_Student__c,OwnerId,
															(select FIELDS(STANDARD), Financial_Aid_Type__c, Corporate_Type__c,
															Landlord_Type__c, Non_Tuition_Type__c, Other_Type__c, Staff_Type__c, Staff__c,
															Sibling_Number__c, Scholarship_Type__c
															from Opportunities__r
															where RecordTypeId in :recordTypes
															order by createddate
															DESC limit 1)
														from Contact
														where Id in :contactIds]);
		return contactsWithPriorOpportunities;
	}

	public void createOpportunities(Map<Id, Contact> promotedContactMap, Map<Id, Contact> contactsWithOpp){
		List<Opportunity> opportunitiesToCreate = new List<Opportunity>();
		Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Reenrolment').getRecordTypeId();
		for(Id i : promotedContactMap.keySet()){
			Contact c = contactsWithOpp.get(i);
			Opportunity o = c.Opportunities__r.isEmpty() ? new Opportunity() : c.Opportunities__r[0].clone(false, true);
			o.Name = c.Name;
			o.ContactId = c.Id;
			o.Child__c = c.Id;
			o.RecordTypeId = recordTypeId;
			o.YearGrade__c = c.Promoted_Year_Grade__c;
			o.SchoolOfInterest__c = c.SchoolOfInterest__c;
			o.AccountId = c.AccountId;
			o.StageName = 'Eligible';
			o.Contract_Stage__c = 'Open Enrollment';
			o.CloseDate = c.SchoolOfInterest__r.Re_Enrolment_Close_Date__c;
			o.MidTierOpportunityID__c = c.MidTierContactID__c;
			o.DayOrBoardingSchool__c = c.Day_or_Boarding_Student__c;
			o.OwnerId = c.OwnerId;
			o.MidTierOpportunityID__c = c.MidTierContactID__c;
			opportunitiesToCreate.add(o);
		}
		if(!opportunitiesToCreate.isEmpty()){
			List<Database.SaveResult> lstInsertRes = Database.insert(opportunitiesToCreate, false);
			for(Database.SaveResult insertRes : lstInsertRes){
				if(!insertRes.isSuccess()){
					System.debug('Error: could not create sobject for array element ' + insertRes + '.');
					System.debug('The error reported was: '+ insertRes.getErrors()[0].getMessage() + '\n');
				}else{
					continue;
				}
			}
		}
	}

}