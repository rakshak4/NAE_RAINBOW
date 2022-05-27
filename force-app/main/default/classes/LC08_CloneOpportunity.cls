/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for cloning opportunity
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 03-Aug-2018  AMU    1.0     Initial version
-- 05-Dec-2018  ANA    1.1     Resolved Case 00001457
-- 07-Dec-2018  ANA    1.2     Resolved Work-Item 495, Case 00001593
-- 15-Sep-2020  FKH    1.3     Resolved Work- Case 00002580; added Clone Without Close functionality
-- 21-Oct-2020  VJA    1.4     00002580 Additional field filtering for Deffered and Clone
-- 18-Nov-2020	VJA	   1.5	   Case 2782: Added dependent picklist values to Component	 	
-- 09-MAR-2021	VJA    1.6     Case 00002782	
-- 02-MAR-2022	FKH    1.7     Case 00004545	
--------------------------------------------------------------------------------------
***************************************************************************************/
public without sharing class LC08_CloneOpportunity { //ANA20192501: Case 00001593

	@AuraEnabled
	public static Object getOpp(String oppId){
		Map<String, Object> mapResult = new Map<String, Object>();

		Opportunity opp = [SELECT StageName, CloseDate, LostDeniedOnHoldReason__c, Lost_Reason_Description__c, ReasonLostCategory__c
							FROM Opportunity WHERE Id =: oppId limit 1];

		mapResult.put('opp', opp);
		mapResult.put('lstLostReasons', getLostReasons());

		return mapResult;
	}

	public static Object getLostReasons(){
        List<Object> lstPicklist = new List<Object>();
        Schema.DescribeFieldResult fieldResult = Opportunity.LostDeniedOnHoldReason__c.getDescribe();
       
        for(Schema.PicklistEntry entry : fieldResult.getPicklistValues()){
            lstPicklist.add(entry.getValue());
        }
        return lstPicklist;
	}

	@AuraEnabled
	public static Map<String, String> cloneOpportunity(String oppId, Opportunity oldOpp, Boolean close){
        Savepoint sp = Database.setSavepoint();
		Map<String, String> mapResult = new Map<String, String>();

		String oppQuery = getCreatableFieldsSOQL(AP_Constant.oppObject, 'Id =: oppId Limit 1');	

		try {
			Opportunity opp = (Opportunity) Database.query(oppQuery);

			Opportunity cloneOpp = opp.clone(false, true, false, false);

			cloneOpp.AcceptanceStartDate__c = null;
			cloneOpp.EnrolledStartDate__c = null;
			cloneOpp.OfferOutStartDate__c = null;
			cloneOpp.StartedStartDate__c = null;
			cloneOpp.LostDeniedOnHoldReason__c = opp.LostDeniedOnHoldReason__c;
			cloneOpp.ReasonLostCategory__c = opp.ReasonLostCategory__c;
			cloneOpp.WaitlistPriorityReason__c = null;
			cloneOpp.Waitlisted__c = false;
			cloneOpp.LostStartDate__c = null;
			cloneOpp.InactiveStartDate__c = null;
			cloneOpp.DeniedStartDate__c = null;
			cloneOpp.ActiveStartDate__c = null;
			cloneOpp.OnHoldStartDate__c = null;
			cloneOpp.StageName = opp.StageName;
			cloneOpp.CloseDate = oldOpp.StageName ==  AP_Constant.oppStageNameDeferred ? oldOpp.CloseDate.addYears(1) : cloneOpp.CloseDate;		
			cloneOpp.YearGrade__c = null;
			cloneOpp.EnrolmentPeriod__c = null;
            cloneOpp.Class__c = null;
            cloneOpp.Campus__c = null;
			cloneOpp.CurriculumName__c = null;
			cloneOpp.TECH_IsClone__c = true;             //VJA20210309 - Case 00002782
			//cloneOpp.EnrolmentPeriod__c = null;
			//cloneOpp.ActiveStartDate__c = null;
			//cloneOpp.DeniedStartDate__c = null;
			//cloneOpp.EligibleForReenrolmentStartDate__c = null;
			//cloneOpp.EnquiryStartDate__c = system.today();
			//cloneOpp.EnrolledStartDate__c = null;
			//cloneOpp.InactiveStartDate__c = null;
			//cloneOpp.LostStartDate__c = null;
			//cloneOpp.OfferOutStartDate__c = null;
			//cloneOpp.OnHoldStartDate__c = null;
			//cloneOpp.StartedStartDate__c = null;
			//cloneOpp.VisitStartDate__c = system.today();
			//cloneOpp.YearGrade__c = null;
			//cloneOpp.Class__c = null;
			//cloneOpp.LostDeniedOnHoldReason__c = null;  //CRA20190411 Case 00001742
			//cloneOpp.ReasonLostCategory__c = null; //CRA20190411 Case 00001742
            //cloneOpp.MidTierOpportunityID__c = null;
			//cloneOpp.OpportunityFirstVisitDate__c = null; //ANA20181205: Case 00001457
				
			if(close){ //Clone and close
				if(opp.StageName == AP_Constant.oppStageNameEnquiry || opp.StageName == AP_Constant.oppStageNameVisit){
					cloneOpp.ApplicationStartDate__c = null;
				}
				insert cloneOpp;

				updateDocumentChekList(oppId, cloneOpp.Id);
				updateFiles(oppId, cloneOpp.Id);
				
				opp.MidTierOpportunityID__c = null;	//FKH Case 4545
				opp.StageName = oldOpp.StageName;
				opp.LostDeniedOnHoldReason__c = oldOpp.LostDeniedOnHoldReason__c;
				opp.Lost_Reason_Description__c = oldOpp.Lost_Reason_Description__c;
				opp.ReasonLostCategory__c = oldOpp.ReasonLostCategory__c;  //VJA20201118: Case 2782
				opp.Waitlisted__c = false;
				opp.WaitlistPriorityReason__c = null;
				update opp;
			}
			else { //Clone without close
				cloneOpp.ApplicationStartDate__c = null;
				cloneOpp.MidTierOpportunityID__c = null;
				cloneOpp.SchoolOfInterest__c = null;
				
				insert cloneOpp;

				insertDocumentChekList(oppId, cloneOpp.Id);
				insertFiles(oppId, cloneOpp.Id);

			}
			mapResult.put('type', Label.success);
			mapResult.put('message', Label.OpportunityCloneSuccessMessage);
			mapResult.put('cloneOppId', cloneOpp.Id);
		} 
		catch (DmlException ex) {
            throw new AurahandledException(ex.getDmlMessage(0));
        } catch (Exception ex) {
			mapResult.put('type', Label.error);
			mapResult.put('message', ex.getMessage());
			
			Database.rollback(sp);
            throw new AurahandledException(ex.getMessage());
        }

		return mapResult;
	}

	public static void updateDocumentChekList(String oppId, String cloneOppId){
		List<DocumentCheckList__c> lstDocCheckList = [SELECT Opportunity__c FROM DocumentCheckList__c where Opportunity__c =: oppId];
	
		if(lstDocCheckList.size() > 0) {
			for(DocumentCheckList__c doc: lstDocCheckList) {
				doc.Opportunity__c = cloneOppId;
			}
			update lstDocCheckList;
		}
	}




	public static void updateFiles(String parentId, String cloneOppId) {
		List<ContentDocumentLink> lstFiles = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink 
												Where LinkedEntityId  = :parentId];
		List<ContentDocumentLink> lstNewFiles = new List<ContentDocumentLink>();
		for(ContentDocumentLink doc: lstFiles) {
			lstNewFiles.add(new ContentDocumentLink(
				LinkedEntityId = cloneOppId
			 	,ContentDocumentId = doc.ContentDocumentId
			 	,ShareType = 'V'
			));
		}

		if(lstNewFiles.size() > 0) {
			insert lstNewFiles;
		}

		if(lstFiles.size() > 0) {
			delete lstFiles;
		}
	}

	public static void insertFiles(String parentId, String cloneOppId) {
		List<ContentDocumentLink> lstFiles = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink 
												Where LinkedEntityId  = :parentId];
		List<ContentDocumentLink> lstNewFiles = new List<ContentDocumentLink>();
		for(ContentDocumentLink doc: lstFiles) {
			lstNewFiles.add(new ContentDocumentLink(
				LinkedEntityId = cloneOppId
			 	,ContentDocumentId = doc.ContentDocumentId
			 	,ShareType = 'V'
			));
		}

		if(lstNewFiles.size() > 0) {
			insert lstNewFiles;
		}
	}



	public static void insertDocumentChekList(String oppId, String cloneOppId){

		List<DocumentCheckList__c> lstDocCheckList = [SELECT Opportunity__c,ApplicationDocument__c,DateReceived__c,Name,RecordType__c,Required__c, 
													Status__c, TECH_DMIdentifier__c, Stage__c,YearGrade__c FROM DocumentCheckList__c where Opportunity__c =: oppId];
		
		List<DocumentCheckList__c> lstDocCheckList1=  new List<DocumentCheckList__c>();

		if(lstDocCheckList.size() > 0) {
			for(DocumentCheckList__c doc: lstDocCheckList) {
				lstDocCheckList1.add(new DocumentCheckList__c( 
					Opportunity__c = cloneOppId,
					ApplicationDocument__c = doc.ApplicationDocument__c,
					DateReceived__c = doc.DateReceived__c,
					Name = doc.Name,
					RecordType__c  = doc.RecordType__c,
					Required__c = doc.Required__c,
					Status__c = doc.Status__c,
					TECH_DMIdentifier__c = doc.TECH_DMIdentifier__c,
					YearGrade__c = doc.YearGrade__c,
					Stage__c = doc.Stage__c
				));

			}
			insert lstDocCheckList1;
		}
	}


	public static String getCreatableFieldsSOQL(String objectName, String whereClause) {
        String selects = '';
         
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<String> selectFields = new list<string>();
         
        if (fMap != null) {
            for (Schema.SObjectField ft : fMap.values()) { 
                Schema.DescribeFieldResult fd = ft.getDescribe();
                if (fd.isAccessible()) {	
                    selectFields.add(fd.getName());
                }
            }
        }
         
        if (!selectFields.isEmpty()) {
            for (String s:selectFields) {
                selects += s + ',';
            }
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
        }
         
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
    }
}