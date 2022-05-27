/***
	Author: Kunal Sharma
	Created Date: 22 Feb 2013
	Description: controller class for VF page BulkRegistration 
	Audit Date:
	Audited By: 
	
	COMMENTS:
	

***/
 
public with sharing class BulkRegistration_Controller {
	//variables
	private Id groupId;
	public Group__c grp{get;set;}
	public List<Registration__c> existingRegistrations {get{
		return paginationSet.getRecords();
	}set;}	
	
	private String sortDir ;
	private String sortField ;
	public boolean showActive {get;set;}
	//public boolean showAll {get;set;}
	//for pagination
	private ApexPages.StandardSetController paginationSet {get;set;}
	public integer totalRegistrations {get{
		return paginationSet.getResultSize();
	}}
	public integer totalPages {get{
		return Integer.valueOf((totalRegistrations/decimal.valueOf(pageSize)).round(System.RoundingMode.CEILING));
	}}
	public integer pageNum {get;set;}
	public list<SelectOption> pageOptions{
		get{
			list<SelectOption> temp = new list<SelectOption>();
			for(integer i = 1; i <= totalPages; i++){
				temp.add(new SelectOption(''+i,''+i));
			}
			return temp;
		}
	}
	 private integer pageSize {get;set;}
	//constrcutor
   
    public BulkRegistration_Controller(ApexPages.StandardController controller) {
		pageSize = 50;
		
		showActive =  true;
		//showAll = false;
		groupId =  controller.getId();
		grp = [Select Id, Name from Group__c where Id=:groupId];
		sortDir =  'asc';
		sortField = 'Student__r.Student_Name__c';		
		initializeList();
		pageNum = paginationSet.getPageNumber();
    }
    
    //function to initialize list of students
	private void initializeList(){
		existingRegistrations =  new List<Registration__c>();
		String query = 'Select a.Student__r.Half_Day__c, a.Student__r.Date_of_Birth__c, a.Student__r.Student_Number__c, a.Student__r.Gender_Student__c, a.Student__r.Starting_Date_from_student__c, a.EAL_Start_Date__c, a.Student__r.Nationality__c, a.Student__r.Class_Name__c, a.Student__r.Student_Name__c,  a.Bus_Service__c, a.Student_Nickname__c, a.Student__r.Name, a.Student__c,  a.Name, a.Medical_Special_Needs__c, a.Id, a.House__c, a.Group__c, a.EAL__c, a.Description__c, a.Admission_Stage__c, a.Active__c From Registration__c a ';
		query += ' where a.Group__c = '+quotedString(groupId);
		//if(showAll == false){
			query += ' AND a.Active__c ='+showActive+' ';
		//}
		query += ' order by '+ sortField + ' '+ sortDir;
		//query += ' limit 200';
		paginationSet = new ApexPages.StandardSetController(Database.getQueryLocator(query));
		paginationSet.setPageSize(pageSize);
		/*for(Registration__c registration: Database.query(query)){
			existingRegistrations.add(registration);
		}*/
	}
	
	// helper function to return quoted string
	private String quotedString(String s){
		return '\''+s+'\'';
	}
	
	//function for sorting table
	public PageReference sortByField(){
		sortField = System.currentPageReference().getParameters().get('field');
		if(sortField ==  null){
			sortField = 'Student__r.Student_Name__c';
		}
		if(sortDir == 'asc'){
			sortDir =  'desc';
		}else{
			sortDir = 'asc';
		}
		initializeList();	
		return null;
	}
	
	//save changes
	public PageReference saveRegistrations(){
		try{
			if(existingRegistrations.size() > 0){
				update existingRegistrations;
			}
			initializeList();
			ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Success: All registrations are successfully updated.');
			ApexPages.addMessage(successMessage);
		}catch(Exception e){
			string error_message ;
			if(e.getMessage().contains('INSUFFICIENT_ACCESS_ON_CROSS_REFERENCE_ENTITY') || e.getMessage().contains('INSUFFICIENT_ACCESS_OR_READONLY')){
				error_message = 'You have insufficient privileges to add or remove students from this group. Please speak to the group owner if you require access.';
			}else if(e.getMessage().contains('previous academic years')){
				error_message = 'You cannot add or remove students from groups that belong to previous academic years. Please create a new group for the new academic year.';
			}else{
				error_message = e.getMessage();
			}
			ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Failed to update registrations. '+error_message);
			ApexPages.addMessage(errorMessage);		
		}
		return null;
	}
	
	//save changes
	public PageReference showActive(){
		showActive =  true;
		//showAll = false;
		initializeList();
		
		return null;
	}
	
	//show active registrations
	public PageReference showInActive(){
		showActive =  false;
		//showAll = false;
		initializeList();
		return null;
	}
	
	//for pagination
	// indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return paginationSet.getHasNext();
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return paginationSet.getHasPrevious();
        }
        set;
    }

    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return paginationSet.getPageNumber();
        }
        set;
    }

    // returns the first page of records
     public void first() {
         paginationSet.first();
         pageNum = paginationSet.getPageNumber();
     }

     // returns the last page of records
     public void last() {
         paginationSet.last();
         pageNum = paginationSet.getPageNumber();
     }

     // returns the previous page of records
     public void previous() {
         paginationSet.previous();
         pageNum = paginationSet.getPageNumber();
     }

     // returns the next page of records
     public void next() {
         paginationSet.next();
         pageNum = paginationSet.getPageNumber();
     }
     
     // sets page number
     public void  setPageNumber() {
         paginationSet.setPageNumber(pageNum);
     }
	
	/*
	//show inactive registrations
	public PageReference showAll(){
		showActive =  true;
		//showAll = true;
		initializeList();
		return null;
	}*/
	
}