/**************************************************************************************
-- - Author        : akaCRM
-- - Description   : Constants
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  -------------------------------------------------------
-- 09-AUG-2021  FJO    1.0     Initial version
-- 04-MAR-2022  FJO    1.1     Additional Record Types Included
--------------------------------------------------------------------------------------
**************************************************************************************/
public class BF_EnrollmentOpportunityConstants {
	public static final String ENROLMENT = 'Enrolment';
	public static final String REENROLMENT = 'Reenrolment';
	public static final Map<String, RecordTypeInfo> OPPORTUNITY_RECORD_TYPE_INFO = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName();
	public static final List<BF_Enrolment_Setting__mdt> ENROLMENT_SETTING_LIST = BF_Enrolment_Setting__mdt.getAll().values();

	public static Set<Id> ENROLMENT_SETTING_LIST_IDS {
		get{
			Set<Id> ids = new Set<Id>();
			for(BF_Enrolment_Setting__mdt es : ENROLMENT_SETTING_LIST){
				ids.add(OPPORTUNITY_RECORD_TYPE_INFO.get(es.Record_Type_Name__c)?.getRecordTypeId());
			}
			return ids;
		}
	}

	public static Set<Id> ENROLMENT_RECORD_TYPE_IDS {
		get{
			Set<Id> ids = new Set<Id>();
			for(BF_Enrolment_Setting__mdt es : ENROLMENT_SETTING_LIST){
				if(es.Enrolment_Type__c == ENROLMENT){
					ids.add(OPPORTUNITY_RECORD_TYPE_INFO.get(es.Record_Type_Name__c)?.getRecordTypeId());
				}
			}
			return ids;
		}
	}


	public static final List<Schema.SObjectField> DISCOUNT_FIELDS = new List<Schema.SObjectField> {
			Opportunity.Financial_Aid_Type__c,
			Opportunity.Scholarship_Type__c,
			Opportunity.Corporate_Type__c,
			Opportunity.Landlord_Type__c,
			Opportunity.Non_Tuition_Type__c,
			Opportunity.Other_Type__c,
			Opportunity.Staff_Type__c
			};

	public static final Map<Schema.SObjectField,String> DISCOUNT_KEY_MAP =
	new Map<Schema.SObjectField,String> {
			Opportunity.Financial_Aid_Type__c => 'Financial Aid',
			Opportunity.Scholarship_Type__c => 'Scholarship',
			Opportunity.Corporate_Type__c => 'Corporate',
			Opportunity.Landlord_Type__c => 'Landlord',
			Opportunity.Non_Tuition_Type__c => 'Non-Tuition',
			Opportunity.Other_Type__c => 'Other',
			Opportunity.Staff_Type__c => 'Staff'
	};

	public static final Map<Schema.SObjectField,Schema.SObjectField> DISCOUNT_AMOUNT_FIELD_MAP =
	new Map<Schema.SObjectField,Schema.SObjectField> {
			Opportunity.Financial_Aid_Type__c => Opportunity.Financial_Aid_Amount__c,
			Opportunity.Scholarship_Type__c => Opportunity.Scholarship_Amount__c,
			Opportunity.Corporate_Type__c => Opportunity.Corporate_Amount__c,
			Opportunity.Landlord_Type__c => Opportunity.Landlord_Amount__c,
			Opportunity.Non_Tuition_Type__c => Opportunity.Non_Tuition_Amount__c,
			Opportunity.Other_Type__c => Opportunity.Other_Amount__c,
			Opportunity.Staff_Type__c => Opportunity.Staff_Amount__c
	};

	public static final Map<Schema.SObjectField,Schema.SObjectField> DISCOUNT_PERCENTAGE_FIELD_MAP =
	new Map<Schema.SObjectField,Schema.SObjectField> {
			Opportunity.Financial_Aid_Type__c => Opportunity.Financial_Aid_Percentage__c,
			Opportunity.Scholarship_Type__c => Opportunity.Scholarship_Percentage__c,
			Opportunity.Corporate_Type__c => Opportunity.Corporate_Percentage__c,
			Opportunity.Landlord_Type__c => Opportunity.Landlord_Percentage__c,
			Opportunity.Non_Tuition_Type__c => Opportunity.Non_Tuition_Percentage__c,
			Opportunity.Other_Type__c => Opportunity.Other_Percentage__c,
			Opportunity.Staff_Type__c => Opportunity.Staff_Percentage__c
	};

}