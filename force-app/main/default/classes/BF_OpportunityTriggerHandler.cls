/**************************************************************************************
-- - Author        : akaCRM
-- - Description   : Opportunity Trigger Handler class
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  -------------------------------------------------------
-- 09-AUG-2021  FJO    1.0     Initial version
-- 11-OCT-2021  FJO    1.1     Static variable added
--------------------------------------------------------------------------------------
**************************************************************************************/
public class BF_OpportunityTriggerHandler {
	public static Boolean run = true;
	public BF_OpportunityTriggerHandler() {}

	public void handleAfterUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap){
		BF_OpportunityTriggerHandler.run = false;
		System.debug('---------  START ----- Trigger Fired:BF_OpportunityTriggerHandler');
		BF_EnrollmentTuition tuition = new BF_EnrollmentTuition(newOpportunities, oldOpportunitiesMap);
		tuition.applyTuitionAndFees();
		tuition.applyScholarshipsAndDiscounts();
		tuition.applyPaymentPlanFeeOrDiscount();
		System.debug('--------- END ----- Trigger Fired:BF_OpportunityTriggerHandler');
	}
}