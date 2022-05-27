/***
	Author: Kunal Sharma
	Created Date: 01 April 2013
	Desc: VF controller to handle bulk assessments
***/

public with sharing class BulkAssessments_Controller {   
	public Id groupId{get;set;}
	public Group__c grp{get;set;}
	public Assesment__c folder {get;set;}
	private boolean warningMessageDisplayed;
    private Id assessmentRTId;
    private Map<Id,Assesment__c> studentAssessmentMap ;
     private Map<Id,Assesment__c> studentAssessmentMapForComparison ;
    public List<AssessmentRecord> assessments {get;set;}
    //constructor
    public BulkAssessments_Controller(ApexPages.StandardController controller) {
		warningMessageDisplayed = false;
		groupId = controller.getId();
		grp = [Select Id,Name,Approver__c from Group__c where Id=:groupId];
		folder = [Select Include_Target_Predicted_Grade__c, Id,Name,Title__c,Type__c,Assessment_Date__c from Assesment__c where Id=:System.currentPageReference().getParameters().get('fid')];
		assessmentRTId = [Select Id from RecordType where SObjectType='Assesment__c' AND DeveloperName='Assessment_Record' limit 1].Id;
    	string s_param = system.currentPageReference().getParameters().get('s');
    	if(s_param != null && s_param == '1'){
    		ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Success: All assessments are successfully updated.');
			ApexPages.addMessage(successMessage);
    	}
    	initialize();
    }
    
    //function to fetch all existing assessment records 
    private void initialize(){
    	studentAssessmentMap =  new  Map<Id,Assesment__c>();
    	//studentAssessmentMapForComparison  =  new  Map<Id,Assesment__c>();
    	//for(Assesment__c a:[Select Id,Approval_Comments__c,Auto_Approve__c,Name,Achievement__c,Comment__c,Effort__c,Grade__c,Group__c,Student__c,Student__r.Name,Student__r.Student_Full_Name__c, Student__r.Student_Name__c, Comments_for_Teacher__c from Assesment__c where Assessment_Folder__c=:folder.Id AND Group__c=:groupId order by Student__r.Student_Name__c asc]){
    	for(Assesment__c a:[Select Target_Predicted_Grade__c, Id,Approval_Comments__c,Auto_Approve__c,Name,Achievement__c,Comment__c,Effort__c,Grade__c,Group__c,Student__c,Student__r.Name,Student__r.Student_Full_Name__c, Student__r.Stage__c , Student__r.Student_Name__c, Comments_for_Teacher__c from Assesment__c where Assessment_Folder__c=:folder.Id AND Group__c=:groupId  order by Student__r.Student_Name__c asc]){
    		studentAssessmentMap.put(a.Student__c,a);
    		//studentAssessmentMapForComparison.put(a.Student__c,a);
    	}
    	//fetch all active registrations under group 
    	assessments =  new List<AssessmentRecord>();
    	//for(Registration__c r:[Select r.Student__c, r.Student__r.Student_Name__c ,r.Student__r.Student_Full_Name__c,  r.Student__r.Name, r.Name, r.Id, r.Group__c, r.Active__c From Registration__c r where r.Group__c=:groupId AND r.Active__c= true AND r.Student__r.Starting_Date_from_student__c <=:folder.Assessment_Date__c  order by r.Student__r.Student_Name__c asc]){
    	for(Registration__c r:[Select Student__r.Stage__c, r.Student__c, r.Student__r.Student_Name__c ,r.Student__r.Student_Full_Name__c,  r.Student__r.Name, r.Name, r.Id, r.Group__c, r.Active__c From Registration__c r where r.Group__c=:groupId AND r.Include_in_Assessment_Folder__c = true AND r.Student__r.Starting_Date_from_student__c <=:folder.Assessment_Date__c  order by r.Student__r.Student_Name__c asc]){
    		//for each active registration , create a assessment record
    		AssessmentRecord ar =  new AssessmentRecord();
    		ar.studentRegistration =  r;
    		if(studentAssessmentMap.get(r.Student__c) != null){
    			ar.assessment = studentAssessmentMap.get(r.Student__c);
    		}else{
    			ar.assessment =  new Assesment__c();
    			ar.assessment.RecordTypeId = assessmentRTId;
    			ar.assessment.Assessment_Folder__c = folder.Id;
    			ar.assessment.Group__c = groupId;
    			ar.assessment.Student__c = r.Student__c;
    			/*//ar.assessment.Is_Approved__c = true;
    			else if(grp.Approver__c == UserInfo.getUserId()){
    				ar.assessment.Is_Approved__c = true;
    			}*/
    			
    		}
    		/*if(folder.Type__c == 'Assignment' || folder.Type__c == 'Test'){
				ar.assessment.Is_Approved__c = true;
			}else{
				ar.assessment.Is_Approved__c = false;
			}*/
    		assessments.add(ar);
    	}
    }  
	
	private boolean compareComments(){
		studentAssessmentMapForComparison  =  new  Map<Id,Assesment__c>();
		for(Assesment__c a:[Select Id,Approval_Comments__c,Auto_Approve__c,Name,Achievement__c,Comment__c,Effort__c,Grade__c,Group__c,Student__c,Student__r.Name,Student__r.Student_Full_Name__c, Student__r.Stage__c , Student__r.Student_Name__c, Comments_for_Teacher__c from Assesment__c where Assessment_Folder__c=:folder.Id AND Group__c=:groupId  order by Student__r.Student_Name__c asc]){
    		studentAssessmentMapForComparison.put(a.Student__c,a);
    	}
		boolean flag = false;
		for(AssessmentRecord a:assessments){
			Assesment__c existingAssessment = studentAssessmentMapForComparison.get(a.assessment.Student__c);
			if(existingAssessment != null){
				if(a.assessment.Comment__c == null || a.assessment.Comment__c == ''){
					if(existingAssessment.Comment__c != null && existingAssessment.Comment__c != ''){
						flag = true;
						break;
					}
				}
			}
		}
		return flag;
	}
	
	//function to save assessments 
	public PageReference saveAssessments(){
		PageReference pg;
		try{
			if(compareComments() && !warningMessageDisplayed){
				ApexPages.Message warningMessage = new ApexPages.Message(ApexPages.severity.WARNING, 'Warning: One or more of the assessment comment fields has been changed to blank. If you continue this will delete the previous assessment comment that was in the relevant cell. Changes once made can not be reverted! Please click \'Save\' if you are sure you want to continue.');
				ApexPages.addMessage(warningMessage);
				warningMessageDisplayed = true;	
				return null;
			}
			List<Assesment__c> updatedAssessments =  new List<Assesment__c>();
			List<Assesment__c> deletedAssessments =  new List<Assesment__c>();
			//iterate all assessements to 
			for(AssessmentRecord a:assessments){
				boolean isComment = false;
				String assessmentComment = a.assessment.Comment__c;
				if(assessmentComment != null){
					if(assessmentComment.trim() != ''){
						isComment = true;
					}
				}
				if(a.assessment.Id == null){ //for new assessments
					if(a.assessment.Achievement__c != null || a.assessment.Effort__c != null || a.assessment.Grade__c != null || isComment){
						updatedAssessments.add(a.assessment);
					}
				}else{ //for existing assessments
					if(a.assessment.Achievement__c != null || a.assessment.Effort__c != null || a.assessment.Grade__c != null || isComment){
						updatedAssessments.add(a.assessment);
					}else{
						deletedAssessments.add(a.assessment);
					}
				}
			}
			if(updatedAssessments.size() > 0){
				upsert updatedAssessments;
				pg = Page.BulkAssessments;
				pg.getParameters().put('id',groupId);
				pg.getParameters().put('fid',folder.Id);
				pg.getParameters().put('s','1');
				pg.setRedirect(true);
			}
			if(deletedAssessments.size() > 0){
				delete deletedAssessments;
				pg = Page.BulkAssessments;
				pg.getParameters().put('id',groupId);
				pg.getParameters().put('fid',folder.Id);
				pg.getParameters().put('s','1');
				pg.setRedirect(true);
			}
			
			//ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Success: All assessments are successfully updated.');
			//ApexPages.addMessage(successMessage);
		}catch(Exception e){
			ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Failure: Ooops ..Failed to update assessments. Please contact admin@britishschools.co.uk and provide follwing error message: '+e.getMessage());
			ApexPages.addMessage(errorMessage);	
			pg =null;
		}
		
		return pg;
	}
	
	//wrapper class for assesments records
	public class AssessmentRecord{
		public Registration__c studentRegistration{get;set;}
		public Assesment__c assessment{get;set;}
	}
}