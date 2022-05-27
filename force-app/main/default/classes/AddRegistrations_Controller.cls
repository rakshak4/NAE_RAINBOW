/**
	Author: Kunal Sharma
	Created Date: 27 Feb 2013
	Description: controller class for VF page for adding bulk student registrations 
	Audit Date:
	Audited By: 
	
	COMMENTS: 
**/ 
public with sharing class AddRegistrations_Controller {
	private Id groupId;
	public Group__c grp{get;set;}
	//public Opportunity opp{get;set;}
	public List<SelectOption> yearGroupOptions {get;set;}
	public List<SelectOption> classOptions {get;set;}
	public String selectedYearGroup {get;set;}
	public String selectedClass {get;set;}
	public List<SelectOption> houseOptions {get;set;}
	public String selectedHouse {get;set;}
	private String defaultStage ;
	private Set<Id> existingRegisteredContacts ;
	public String studentKeyword {get;set;}
	private Id studentRTId;
	private String sortDir ;
	private String sortField ;
	public List<ContactWrapper> fetchedContacts{get;set;}
	private String schoolName ;
	public boolean selectAll {get;set;}
    public AddRegistrations_Controller(ApexPages.StandardController controller) {
		selectAll =  false;
		groupId =  controller.getId();
		grp = [Select Id,School__c, Name from Group__c where Id=:groupId];
		schoolName = grp.School__c ; 
		existingRegisteredContacts = new Set<Id>();
		
		defaultStage = 'Enrolled';
		//populate yearGroup Options	
		yearGroupOptions =  new List<SelectOption>();
		yearGroupOptions.add(new SelectOption('All','All'));	
		/*for(Schema.PicklistEntry entry: Opportunity.Year_Group__c.getDescribe().getPicklistValues()){
			yearGroupOptions.add(new SelectOption(entry.getValue(),entry.getLabel()));
		}*/
		for(String year: portalUtility.getYearGroupOptions()){
			yearGroupOptions.add(new SelectOption(year,year));
		}
		//populate class options 
		classOptions =  new List<SelectOption>();
		classOptions.add(new SelectOption('All','All'));	
		for(Schema.PicklistEntry entry: Opportunity.Class__c.getDescribe().getPicklistValues()){
			classOptions.add(new SelectOption(entry.getValue(),entry.getLabel()));
		}
		//populate house options 
		houseOptions =  new List<SelectOption>();
		houseOptions.add(new SelectOption('All','All'));	
		for(Schema.PicklistEntry entry: Opportunity.House__c.getDescribe().getPicklistValues()){
			houseOptions.add(new SelectOption(entry.getValue(),entry.getLabel()));
		}
		selectedClass = 'All';
		selectedYearGroup = 'All';
		selectedHouse = 'All';
		sortDir =  'asc';
		sortField = 'Student_Name__c';
		fetchedContacts =  new List<ContactWrapper>();
		studentRTId = [Select Id from RecordType where SObjectType='Contact' AND DeveloperName='Student' limit 1].Id;	    	
    }
    
    private string retQuery(boolean countOnly){
    	String query = '';
    	if(countOnly){
    		query = 'Select count() From Contact c ';
    	}else{
    		query = 'Select c.Language_Option_s__c, c.Starting_Date_from_student__c, c.Student_Number__c, c.Date_of_Birth__c, Half_Day__c, c.Student_Name__c, c.Registration_Allowed__c, c.Year_Group__c,c.Class__c, c.Stage__c, c.Name, c.Id, c.House__c, c.EAL__c, c.Admissions_File__c From Contact c ';
    	}
    		//query += ' where c.RecordTypeId = '+ quotedString(studentRTId) +' AND c.Owner.School__c = '+quotedString(schoolName)+' AND c.Student_Starting_Date_30__c = '+quotedString('TRUE')+' ';
    		query += ' where c.RecordTypeId = '+ quotedString(studentRTId) +' AND c.Owner.School__c = '+quotedString(schoolName)+' AND c.Registration_Allowed__c = true ';
    		if(studentKeyword != null && studentKeyword != ''){
    			String keyword = '%'+studentKeyword+'%';
    			query += ' AND (c.Student_Name__c  LIKE '+ quotedString(keyword) +' OR c.Student_Number__c LIKE '+quotedString(keyword)+' OR Language_Option_s__c LIKE '+quotedString(keyword)+') ';	
    		}
    		
    		if(defaultStage != null && defaultStage != 'All'){
    			query += ' AND c.Stage__c = '+ quotedString(defaultStage) ;
    		}
    		if(selectedYearGroup != null && selectedYearGroup != 'All'){
    			query += ' AND c.Year_Group__c = '+ quotedString(selectedYearGroup);
    		}
    		if(selectedClass != null && selectedClass != 'All'){
    			query += ' AND c.Class__c = '+ quotedString(selectedClass) ;
    		}
    		if(selectedHouse != null && selectedHouse != 'All'){
    			query += ' AND c.House__c = '+ quotedString(selectedHouse) ;
    		}
    		if(!countOnly){
    			query += ' order by '+ sortField + ' '+ sortDir;
    		}
    		System.debug('**********query='+query);
    	return query;
    }
    
    private boolean checkRecordCount(){
    	boolean flag = true;
    	string query = retQuery(true);
    	integer recordsNum = Database.countQuery(query);
    	//integer recordsNum = (integer)result[0].get('total');
    	if(recordsNum > 1000){
    		flag = false;
    	}
    	return flag;
    }
    
    //search function
    public PageReference searchContacts(){
    	for(Registration__c a:[Select Id,Student__c from Registration__c where Group__c=:groupId]){
    		existingRegisteredContacts.add(a.Student__c);
    	}
    	fetchedContacts =  new List<ContactWrapper>();
    	if(defaultStage != null || selectedYearGroup != null){  
    		//check for query return size
    		if(checkRecordCount()){
	    		string query = retQuery(false);
	    		for(Contact con: Database.query(query)){
	    			if(!existingRegisteredContacts.contains(con.Id)){
	    				fetchedContacts.add(new ContactWrapper(fetchedContacts.size()+1,con));
	    			}
	    		}
	    		if(fetchedContacts.size() == 0){
	    			ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.WARNING, 'No Students found matching filter criteria.');
					ApexPages.addMessage(errorMessage);	
	    		}
    		}else{
    			ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.WARNING, 'Your search returned more than 1000 results and cannot be displayed. Please use the filters above to refine your search.');
				ApexPages.addMessage(errorMessage);	
    		}
    	}else{
    		ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Error: Please select at least one filter to fetch students.');
			ApexPages.addMessage(errorMessage);	
    	}
    	return null;
    }
    
    //saving students
    public PageReference saveRegistration(){
    	try{
	    	List<Registration__c> newRegistrations =  new List<Registration__c>();
	    	boolean isAllEnrolled  =  true;
	    	for(ContactWrapper c:fetchedContacts){
	    		if(c.selected == true){
	    			if(c.registration == null){
		    			//create new registration
		    			Registration__c registration = new Registration__c();
		    			registration.Student__c = c.con.Id;
		    			registration.Group__c =  grp.Id;
		    			registration.Active__c =  true;
		    			/*if(c.con.Stage__c.equalsIgnoreCase('Enrolled')){
		    				registration.Active__c =  true;
		    			}else{
		    				registration.Active__c =  false;
		    				isAllEnrolled =  false;
		    			}*/
		    			c.registration = registration;
		    			newRegistrations.add(registration);
	    			}
	    			
	    		}
	    	}
	    	if(newRegistrations.size() > 0){
	    		insert newRegistrations;
	    		
	    			String message = 'Selected students are added to group successfully.';
	    			if(!isAllEnrolled){
	    				message += 'You have selected some students who have Stage: A/Testing or A/ Deposit. These student will be added to the Group but will not be active. Select View “Not Active” to review the student(s) under registration management.';
	    			}
	    			ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, message);
					ApexPages.addMessage(successMessage);
	    		
	    	}
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
    
    
    // helper function to return quoted string
	private String quotedString(String s){
		return '\''+String.escapeSingleQuotes(s)+'\'';
	}
	
    //function for sorting table
	public PageReference sortByField(){
		sortField = System.currentPageReference().getParameters().get('field');
		if(sortField ==  null){
			sortField = 'Name';
		}
		if(sortDir == 'asc'){
			sortDir =  'desc';
		}else{
			sortDir = 'asc';
		}
		searchContacts();	
		return null;
	}
  	
  	//select all
  	public PageReference selectAllContacts(){
  		if(fetchedContacts != null){
  			for(ContactWrapper cw:fetchedContacts){
  				cw.selected =  selectAll;
  			}
  		}
  		return null;
  			
  	}
  	
    
    //wrapper class for contact
    public class ContactWrapper{
    	public integer index {get;set;}
    	public Contact con {get;set;}
    	public boolean selected {get;set;}
    	public Registration__c registration{get;set;}
    	public ContactWrapper(Integer i, Contact c){
    		index = i;
    		con = c;
    	}
    }
    
}