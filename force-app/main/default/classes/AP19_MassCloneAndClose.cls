/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for for VFpage AP19_MassAndClone
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 07-Jan-2019  ANA    1.0     Initial version
***************************************************************************************/
public without sharing class AP19_MassCloneAndClose { //ANA20192501: Case 00001593
    
    public String retUrl;
    
	public List<Opportunity> lstOpportunities {get;set;}
    public Set<Id> setIds = new Set<Id>();
    public String serializedList {get;set;}
    public String stageName {get;set;}
    public String Lost_Reason_Description {get;set;}
  
    private ApexPages.StandardSetController standardController;

    public AP19_MassCloneAndClose(ApexPages.StandardSetController standardController){
        this.standardController = standardController;
        lstOpportunities = new List<Opportunity>();
        for (Opportunity opp : (List<Opportunity>)standardController.getSelected()){ 
            setIds.add(opp.Id);
        }
    
        lstOpportunities = Database.query(getCreatableFieldsSOQL(AP_Constant.oppObject, 'Id IN: setIds'));
        //lstOpportunities = Database.query('SELECT Id, Name, StageName, Lost_Reason_Description__c  FROM Opportunity WHERE Id IN: SetIds');
        //serializedList = JSON.serialize(lstOpportunities );        
    }
    
    public static void updateDocumentCheckList(List<Opportunity> lstCloneOpps, Set<Id> setIds){
		List<DocumentCheckList__c> lstDocCheckList = [SELECT Opportunity__c FROM DocumentCheckList__c where Opportunity__c IN: setIds];
	
		if(lstDocCheckList.size() > 0 && lstCloneOpps.size() > 0) {
            for(Opportunity opp: lstCloneOpps){
             	for(DocumentCheckList__c doc: lstDocCheckList) {
					if(doc.Opportunity__c == opp.getCloneSourceId())
                		doc.Opportunity__c = opp.Id;
				}   
            }
            
			update lstDocCheckList;
		}
	}
    
    
	public PageReference doAction(){
        system.debug(stageName);
        system.debug(Lost_Reason_Description);
        System.debug('--- Executed listview button method ---');
        // get the return url if it's in Lightning view
        String retUrl = apexpages.currentpage().getParameters().get('vfRetURLInSFX');       
        // get the return url if it's in classic view
        
        retUrl = '/lightning/o/Opportunity/list?filterName=Recent';         
        // do page reference
        System.debug('retUrl: ' + retUrl);
        PageReference pageRef = new PageReference(retUrl);
  		pageRef.setRedirect(true);
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record Created Successfully.!'));
 	 return pageRef;
    }
    
    public PageReference cancel(){
        String retUrl = apexpages.currentpage().getParameters().get('vfRetURLInSFX');       
        retUrl = '/lightning/o/Opportunity/list?filterName=Recent';         
        PageReference pageRef = new PageReference(retUrl);
  		pageRef.setRedirect(true);
 	 return pageRef;
    }
    
    public static void updateFiles(List<Opportunity> lstCloneOpps, Set<Id> setIds) {
		List<ContentDocumentLink> lstFiles = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink 
												Where LinkedEntityId  IN: setIds];
        
		List<ContentDocumentLink> lstNewFiles = new List<ContentDocumentLink>();
        
        for(Opportunity CloneOpp: lstCloneOpps){
        	for(ContentDocumentLink doc: lstFiles) {
                if(doc.LinkedEntityId == CloneOpp.getCloneSourceId()){
                 	lstNewFiles.add(new ContentDocumentLink(
                    LinkedEntityId = CloneOpp.Id
                    ,ContentDocumentId = doc.ContentDocumentId
                    ,ShareType = 'V'
             	   ));   
                }
			}   
        }

		if(lstNewFiles.size() > 0) {
			insert lstNewFiles;
		}

		if(lstFiles.size() > 0) {
			delete lstFiles;
		}
	}
    
   
    public  boolean clone(String lstOpps){
        system.debug('String lstOpps ' + lstOpps);
        Type ArrType = Type.forName('List<Opportunity>');
       	List<Opportunity> lstOpportunities = (List<Opportunity>) JSON.deserialize(lstOpps, ArrType);
        Set<ID> SetOppIds = (new Map<Id,SObject>(lstOpportunities)).keySet();
        
        system.debug('#### lstOpportunities: ' + lstOpportunities);
        system.debug('#### SetOppIds: ' + SetOppIds);
        
        update lstOpportunities;
            
        lstOpportunities = Database.query(getCreatableFieldsSOQL(AP_Constant.oppObject, 'Id IN: SetOppIds'));
        MassClone();
        return true;
    }
    
    
    public PageReference MassClone(){
        List<Opportunity> lstCloneOpps = new List<Opportunity>();
        Set<ID> SetOppIds = (new Map<Id,SObject>(lstOpportunities)).keySet();
        
        for(Opportunity opp : lstOpportunities){
            opp.StageName = this.stageName;
            opp.Lost_Reason_Description__c = this.Lost_Reason_Description;
        }

       // Set save point
		Savepoint sp = Database.setSavepoint();
        
        try{
            
            update lstOpportunities;
            
            for(Opportunity Opp : lstOpportunities){             
                
                //Opportunity opp = (Opportunity) Database.query(oppQuery);
                Opportunity cloneOpp = opp.clone(false, true, false, false);
                cloneOpp.EnrolmentPeriod__c = null;
                cloneOpp.AcceptanceStartDate__c = null;
                cloneOpp.ActiveStartDate__c = null;
                cloneOpp.ApplicationStartDate__c = null;
                cloneOpp.DeniedStartDate__c = null;
                cloneOpp.EligibleForReenrolmentStartDate__c = null;
                cloneOpp.EnquiryStartDate__c = null;
                cloneOpp.EnrolledStartDate__c = null;
                cloneOpp.InactiveStartDate__c = null;
                cloneOpp.LostStartDate__c = null;
                cloneOpp.Lost_Reason_Description__c = null;
                cloneOpp.OfferOutStartDate__c = null;
                cloneOpp.OnHoldStartDate__c = null;
                cloneOpp.StartedStartDate__c = null;
                cloneOpp.VisitStartDate__c = null;
                cloneOpp.YearGrade__c = null;
                cloneOpp.Class__c = null;
                cloneOpp.LostDeniedOnHoldReason__c = null;  //CRA20190411 Case 00001742
                cloneOpp.ReasonLostCategory__c = null; //CRA20190411 Case 00001742
                cloneOpp.StageName = AP_Constant.oppStageNameEnquiry;
                cloneOpp.MidTierOpportunityID__c = null;
                cloneOpp.OpportunityFirstVisitDate__c = null; //ANA20181205: Case 00001457
                cloneOpp.CloseDate = Opp.StageName ==  AP_Constant.oppStageNameDeferred ? Opp.CloseDate.addYears(1) : cloneOpp.CloseDate;
                
                lstCloneOpps.add(cloneOpp);
            }
            
           	insert lstCloneOpps;
            updateDocumentCheckList(lstCloneOpps, SetOppIds);  
            updateFiles(lstCloneOpps, SetOppIds);
            system.debug('Clone Opps: ' + lstCloneOpps);
            return doAction();	
           
            
        }catch (Exception e){
            //system.debug(e.getMessage());
            //ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.FATAL,e.getDmlMessage(0)));
            for (Opportunity opp: lstOpportunities){
                opp.addError('For ' + opp.Name + ': ' + e.getDmlMessage(0));
            }
            Database.rollback(sp);
            return null;
        }
    }
    
    
    public static String getCreatableFieldsSOQL(String objectName, String whereClause) {
        String selects = '';
         
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<String> selectFields = new list<string>();
         
        if (fMap != null) {
            for (Schema.SObjectField ft : fMap.values()) { 
                Schema.DescribeFieldResult fd = ft.getDescribe();
                if (fd.isCreateable()) {
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