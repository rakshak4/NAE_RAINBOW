/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for Visualforce Page VFP03_VisitReport
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 10-JAN-2019  KZE    1.0     Initial version
-- 15-FEB-2019  CRA    1.1     Adding Stage__c in filter for Document Checklist
-- 26-FEB-2019  CRA    1.2     Check if Static Resource exist
-- 23-OCT-2019  CRA    1.3     Resolve Case 00002071
--------------------------------------------------------------------------------------
***************************************************************************************/
public class VFC03_VisitReport {
    public Account acc{ get;set;}
    public Map<Id,List<DocumentChecklist__c>> mapDocum{ get;set;}
    public map<Id,Opportunity> mapOpp { get; set; }
	public map<Id,Contact> mapCon { get; set; }
    public map<Id,String> mapSchool { get; set; }
    public map<Id,List<String>> mapSibling { get; set; }
    public map<Id,List<String>> mapParent { get; set; }
	public map<Id,String> mapOppLang { get; set; }
    public String strResource{ get;set;}
    
    public VFC03_VisitReport (ApexPages.StandardController stdController){
    	List<String> lstStaticResource = new List<String>();
		Set<String> setLang = new Set<String> ();
		Set<String> setResourceToCheck = new Set<String>();
		map<Id,String> mapSchoolToCheck = new map<Id,String>();
		//initialize variables
		mapOpp = new map<Id,Opportunity>();
		mapCon = new map<Id,Contact>();
		mapSchool = new map<Id,String>();
		mapOppLang = new map<Id,String>();		
		mapSibling = new map<Id,List<String>>();
        mapparent = new map<Id,List<String>>();
		mapDocum = new Map<Id,List<DocumentChecklist__c>>();
    	strResource = '';		
        acc = (Account)stdController.getRecord(); 
		//set page name
		Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename=VisitReport.pdf');
		
		//get all contacts
		Map<String, List<String>> mapContact = new Map<String, List<String>>();
		for (Contact con : [SELECT id, Name, RecordType.Name,Email,Phone,PreferredLanguage__c FROM contact WHERE AccountId =: acc.Id]) {

			if(con.RecordType.Name == AP_Constant.conRecordTypeDeveloperNameParent){
               mapCon.put(con.Id,con);
			}
			if (mapContact.size()>0 && mapContact.containsKey(AP_Constant.conRecordTypeDeveloperNameChild) && mapContact.get(con.RecordType.Name)!=null) {
				mapContact.get(con.RecordType.Name).add(con.Name);
			}else{
				mapContact.put(con.RecordType.Name, new List<String> {con.Name});
			}
		}

		//get all related Opportunities
		for(Opportunity opp: [SELECT Id
		  							, Name
									, closedate
									, Child__c
									, Child__r.Name
									, Child__r.Gender__c
									, Child__r.Nationality__c
									, Child__r.Birthdate
									, CurrentPreviousSchoolName__c
									, Child__r.CountryOfResidence__c
									, YearGrade__r.Name
									, ExpectedStartMonth__c
									, ExpectedStartYear__c
									, VisitStartDate__c
									, OpportunityFirstVisitDate__c
									, Notes__c
									, AssessmentTest1Notes__c
									, AssessmentTest2Notes__c
									, AssessmentTest3Notes__c
									, ReferredBy__r.Name
									, ReferredByContact__r.Name 
									, Child__r.NativeLanguage__c
									, Child__r.PreferredLanguage__c
									, Child__r.SecondLanguage__c
									, SchoolOfInterest__r.SchoolCode__c
									, LeadSource
									, LeadSubSource__c
									, StageName
									, YearGrade__r.TECH_Year_Grade_Number__c
									, DayOrBoardingSchool__c
							FROM Opportunity WHERE AccountId = :acc.Id AND Child__c != null]){
			//initialize map values
			mapOpp.put(opp.Id, opp);
			mapDocum.put(opp.Id, new List<DocumentChecklist__c>());
			mapSchool.put(opp.Id, 'Default'); 
			mapSibling.put(opp.Id, new List<String>());
			mapParent.put(opp.Id, new List<String>());

			//set Child languages
			if (opp.Child__r.NativeLanguage__c != null) {
				setLang.add(opp.Child__r.NativeLanguage__c);
			}
			if (opp.Child__r.PreferredLanguage__c != null) {
				setLang.add(opp.Child__r.PreferredLanguage__c);
			}
			if (opp.Child__r.SecondLanguage__c != null) {
				setLang.add(opp.Child__r.SecondLanguage__c);
			}
			mapOppLang.put(opp.Id, String.join(new List<String>(setLang), ', '));

        	if( opp.SchoolOfInterest__r != null && opp.SchoolOfInterest__r.SchoolCode__c != null) {
        		mapSchoolToCheck.put(opp.Id, opp.SchoolOfInterest__r.SchoolCode__c+'_resources');
        	}   
			
			for(String strConName : mapContact.get(AP_Constant.conRecordTypeDeveloperNameChild)) {
				if (opp.Child__r.Name != strConName) {
					mapSibling.get(opp.Id).add(strConName);
				}
			}			
		}
		
		//check Static resource if exist
		List<String> lstResourceChecked = new List<String>();
		if (mapSchoolToCheck.size() > 0) {
			for(StaticResource staticRes : [SELECT Name FROM StaticResource WHERE Name IN :mapSchoolToCheck.values()]) {
				lstResourceChecked.add(staticRes.Name);
			}
		}
		
		for (Id oppId : mapSchoolToCheck.keySet()) {
			if (lstResourceChecked.contains(mapSchoolToCheck.get(oppId))) {
				mapSchool.put(oppId, mapSchoolToCheck.get(oppId));
			}
		}

		//get Stage name probability
		Map<String, Integer> mapStage = new Map<String, Integer>();
		Integer index = 0;
		for(PicklistEntry value: Opportunity.StageName.getDescribe().getPicklistValues()) {
			mapStage.put(value.getValue(), index++);
		}

		for(DocumentChecklist__c docum: [SELECT Id , Opportunity__r.Id , Name , Stage__c , Opportunity__r.StageName , Yeargrade__c, Opportunity__r.Probability FROM DocumentChecklist__c WHERE Opportunity__r.Id IN :mapOpp.keySet() AND Status__c = 'Requested'AND DateReceived__c = null ]){		//CRA-20190215 Adding Stage__c in filter	
			if( (docum.Stage__c == docum.Opportunity__r.StageName || docum.Stage__c == null  
				|| (mapStage.get(docum.Stage__c) <= mapStage.get(docum.Opportunity__r.StageName) && docum.Opportunity__r.Probability != 0))
				&& (docum.Yeargrade__c == null || docum.Yeargrade__c.contains(mapOpp.get(docum.Opportunity__r.Id).YearGrade__r.TECH_Year_Grade_Number__c))){
					mapDocum.get(docum.Opportunity__r.Id).add(docum);
			}
		}
	    
    }
}