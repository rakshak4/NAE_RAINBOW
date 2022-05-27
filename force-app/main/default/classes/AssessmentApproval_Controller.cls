/***
 	Author: Kunal Sharma 
 	Date: 17th June 2013
 	Desc: VF page to be used  by HeadMasters for assessmnents approval
***/

public class AssessmentApproval_Controller {
	public List<SelectOption> groupList {get;set;}
	public List<SelectOption> assessmentFolderList {get;set;}
	public String selectedGroup {get;set;}
	public String selectedFolder {get;set;}
	public boolean selectAll {get;set;}
	public List<Assesment__c> assessments {get;set;}
	private Set<Id> groupIds {get;set;}
	private Set<Id> folderIds {get;set;}
	private String loggedInUserSchool {get;set;}
	//constructor
	public AssessmentApproval_Controller(){
		selectedGroup= '-';
		selectedFolder = '-';
		//check for logged in user
		Id uid  =  UserInfo.getUserId();
		loggedInUserSchool =  [Select School__c from User where Id=:uid].School__c;
		
		fetchGroups();
		//check for URL parameters
		String gid = System.currentPageReference().getParameters().get('gid');
		if(gid != null && gid != ''){
			//fetch 18 char group id
			selectedGroup = [select Id from Group__c where Id=:gid].Id;
			fetchFolders();
		}
		String fid = System.currentPageReference().getParameters().get('fid');
		if(fid != null && fid != ''){
			Assesment__c defaultAssessmet = [select Id,Auto_Publish__c from Assesment__c where Id=:fid];
			if(defaultAssessmet.Auto_Publish__c == true){
				selectedFolder = defaultAssessmet.Id;
				fetchAssessments();
			}
			
		}	
	}
	
	//fetch groups
	private void fetchGroups(){
		//fetch all groups against school for which assessments are pending for approval
		groupIds =  new Set<Id>();
		folderIds = new Set<Id>();
		for(Assesment__c a:[Select a.Term__c, a.Student__c, a.Name, a.Auto_Approve__c, a.Id, a.Group__c, a.Grade__c, a.Effort__c, a.Description__c, a.Comment__c, a.Assessment_Name__c, a.Assessment_Folder__c, a.Assessment_Date__c, a.Achievement__c,a.Approval_Comments__c, a.CreatedDate From Assesment__c a where a.RecordType.DeveloperName = 'Assessment_Record' AND a.Auto_Approve__c =  false AND a.Group__r.Approver__c=:UserInfo.getUserId() AND a.Assessment_Folder__r.Auto_Publish__c = true order by a.Group__r.Name]){
			groupIds.add(a.Group__c);
			folderIds.add(a.Assessment_Folder__c);
		}
		groupList =  new List<SelectOption>();
		groupList.add(new SelectOption('-','--Select Group--'));
		for(Group__c g:[Select Id,Name from Group__c where School__c=:loggedInUserSchool AND Approver__c=:UserInfo.getUserId() AND Id IN:groupIds order by Name]){
			groupList.add(new SelectOption(g.Id,g.Name));
		}
		assessmentFolderList = 	new List<SelectOption>();
		assessmentFolderList.add(new SelectOption('-','--Select Folder--'));
	}
	
	public PageReference fetchFolders(){
		assessments = new List<Assesment__c>();
		assessmentFolderList = 	new List<SelectOption>();
		assessmentFolderList.add(new SelectOption('-','--Select Folder--'));
		//fetch selected group 
		if(selectedGroup ==  null || selectedGroup == '-'){
				
		}else{
			List<String> assessmentType =  new List<String>();
			assessmentType.add('Progress Report');
			assessmentType.add('Examination');
			//fetch folders
			for(Assesment__c a:[Select Id,Name,Title__c from Assesment__c where RecordType.DeveloperName='Assessment_Folder' AND Auto_Publish__c = true AND Type__c IN:assessmentType AND Group__c=:selectedGroup AND Id IN:folderIds order by Name ]){
				assessmentFolderList.add(new SelectOption(a.Id,a.Title__c));
			}
		}
		selectedFolder = '-';
		return null;
	}
	
	public PageReference fetchAssessments(){
		assessments = new List<Assesment__c>();
		if(selectedGroup == '-' || selectedFolder == '-'){
			ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Error: Please select Group and Assessment Folder !');
			ApexPages.addMessage(errorMessage);	
			return null;	
		}else{
			for(Assesment__c a:[Select a.Term__c, a.Student__c, a.Name, a.Auto_Approve__c, a.Id, a.Group__c, a.Grade__c, a.Effort__c, a.Description__c, a.Comment__c, a.Assessment_Name__c, a.Assessment_Folder__c, a.Assessment_Date__c, a.Achievement__c,a.Approval_Comments__c ,a.CreatedDate,a.Comments_for_Teacher__c From Assesment__c a where a.RecordType.DeveloperName = 'Assessment_Record' AND a.Auto_Approve__c =  false AND a.Assessment_Folder__c=:selectedFolder order by a.Student__r.Name]){
				assessments.add(a);
			}
		}	
		return null;
	}
	
	public PageReference saveAssessments(){
		try{
			update assessments;
			ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Success: All Assessments are successfully updated !');
			ApexPages.addMessage(successMessage);
		}catch(Exception e){
			ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Data Error: Ooops something went wrong ! If error persists please contact system administrator with following error message :'+e.getMessage());
			ApexPages.addMessage(errorMessage);
		} 	
		return null;
	}
	
	public PageReference selectAllAssessments(){
		If(assessments != null){
			for(Assesment__c a:assessments){
				a.Is_Approved__c = selectAll;
			}
		}
		return null;
	}
}