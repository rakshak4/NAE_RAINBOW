public with sharing class StudentAssessments_Controller {
	private Id studentId;
    public list<Assesment__c> assessments {get;set;}
    public StudentAssessments_Controller(ApexPages.StandardController controller) {
		studentId = controller.getId();
		fetchAssessments();
    }
    private void fetchAssessments(){
    	assessments = new list<Assesment__c>();
    	for(Assesment__c a:[Select a.Target_Predicted_Grade__c, a.Type__c, a.Title__c, a.Term__c, a.Student__c, a.School__c, a.Parent_Portal_Visibility__c, a.Order__c, a.Order_Text__c, a.Number_of_Assessments_in_Folder__c, a.Number_of_Approved_Assessments_in_Folder__c, a.Name, a.Mid_Term_Report__c, a.Is_Approved__c, a.Id, a.Group__c, a.Group_Type__c, a.Group_Name__c, a.Grade__c, a.Folder_Order__c, a.External_Examination__c, a.Effort__c, a.Description__c, a.Comment__c, a.Auto_Publish__c, a.Auto_Approve__c, a.Assessment_Name__c, a.Assessment_Folder__c, a.Assessment_Display_Name__c, a.Assessment_Date__c, a.Assessment_Date_Copy__c, a.CreatedById, a.Approval_Comments__c, a.Achievement__c, a.Academic_Year__c From Assesment__c a where Student__c=:studentId AND RecordType.DeveloperName = 'Assessment_Record' order by a.Order__c desc, a.Assessment_Folder__r.Assessment_Date__c desc]){
    		assessments.add(a);
    	}
    }

}