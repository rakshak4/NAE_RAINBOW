/**************************************************************************************
-- - Author        : akaCRM
-- - Description   : Trigger helper for Contact
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  -------------------------------------------------------
-- 09-AUG-2021  FJO    1.0     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/
public class BF_ContactTriggerHandler {
	public BF_ContactTriggerHandler(){}

	private Map<Id, Contact> getYearPromotedContacts(List<Contact> newContacts, Map<Id, Contact> oldContactMap){
		Map<Id, Contact> promotedContactMap = new Map<Id,Contact>();

		if(newContacts<>null){
			for(Contact contact : newContacts){
				if(contact.Promoted_Year_Grade__c<>null && contact.Promoted_Year_Grade__c <> oldContactMap.get(contact.Id)?.Promoted_Year_Grade__c){
					promotedContactMap.put(contact.Id, contact);
				}
			}
		}
		return promotedContactMap;
	}

	public void handleAfterUpdate(List<Contact> newContacts, Map<Id, Contact> oldContactMap){
		Map<Id, Contact> promotedContactMap = this.getYearPromotedContacts(newContacts, oldContactMap);
		if(!promotedContactMap.isEmpty()){
			BF_Enrollment bfEnrollment = new BF_Enrollment();
			bfEnrollment.createReEnrolmentOpportunities(promotedContactMap);
		}
	}

	public void handleBeforeUpdate(List<Contact> newContacts, Map<Id, Contact> oldContactMap){
		Map<Id, Contact> promotedContactMap = this.getYearPromotedContacts(newContacts, oldContactMap);
		for(Contact c : promotedContactMap.values()){
			c.Block_ISAMS_Update__c = true;
		}
	}

}