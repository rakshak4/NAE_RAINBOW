public without sharing class CreatePastorals {  
	public Id groupId{get;set;}
	public Group__c grp{get;set;}
	public Conduct__c folder {get;set;}
    public set<Id> existingPastoralsIds {get;set;}
   	public list<PastoralWrapper> pastorals {get;set;} 
    //filters
	public List<SelectOption> yearGroupOptions {get;set;}
	public List<SelectOption> classOptions {get;set;}
	public List<SelectOption> houseOptions {get;set;}
	public String selectedYearGroup {get;set;}
	public String selectedClass {get;set;}
	public String selectedHouse {get;set;}
	public String studentKeyword {get;set;}
	//record type
	private Id folderRTId {get;set;}
	//for multiselection
	public list<SelectOption> selectedStudents { get; set; }
    public list<SelectOption> searchedStudents { get; set; } 
    //group students
    set<Id> grpEnrolledStudents {get;set;}
    //booolean values
    public boolean showPastoralLines{get{
    	boolean flag = false;
    	if(pastorals != null){
    		if(pastorals.size() > 0){
    			flag = true;
    		}
    	}
    	return flag;
    }}
    //selected students
    public boolean ifSelectedStudents{get;set;}
    public boolean disableFolderType {get;set;}
    public boolean isSingleStudent {get;set;}
    private string sid {get;set;}
    public Contact student_selected {get;set;}
   
    //constructor
    public CreatePastorals(ApexPages.StandardController controller) {
    	ifSelectedStudents =  true;
    	disableFolderType = false;
    	isSingleStudent =  false;
    	pastorals =  new list<PastoralWrapper>();
    	selectedStudents = new list<SelectOption>();
    	searchedStudents = new list<SelectOption>(); 
    	existingPastoralsIds =  new set<Id>();
    	//get group details
    	grpEnrolledStudents = new set<Id>();
    	Id groupId ;
    	string gid = system.currentPageReference().getParameters().get('gid');
    	if(gid != null && gid != ''){
    		groupId = gid;
    	}else{
    		if(controller.getId() != null){
    			groupId = controller.getId();
    		}
    	}
    	if(groupId != null){
			grp = [Select g.Year_Group__c, g.School__c, g.Name, g.Id, g.Group_Name__c, g.Description__c, g.Class__c, g.Academic_Year__c, (Select Id, Name, Group__c, Active__c, Admission_Stage__c, Description__c, EAL__c, Grade_1_5__c, House__c, Student__c, Group_Type__c, School__c, Group_Name__c, Is_Whole_School_Group_Registration__c, Include_in_Assessment_Folder__c From Assessments_Registrations__r where Include_in_Assessment_Folder__c = true) From Group__c g where g.Id=:groupId];
	    	for(Registration__c r:grp.Assessments_Registrations__r){
	    		grpEnrolledStudents.add(r.Student__c);
	    	}
    	}
    	
    	folderRTId = [select Id from RecordType where SObjectType='Conduct__c' AND DeveloperName='Pastoral_Folder'].Id;
		string fid = system.currentPageReference().getParameters().get('fid');
		string s = system.currentPageReference().getParameters().get('s');
		
		if(fid != null && fid != ''){
			folder = [select Private_Comment__c, Reason__c, Pastoral_Date__c, Student_Group__c, Folder_Title__c, Folder_Type__c, Folder_Description__c from Conduct__c where Id=:fid];
			disableFolderType = true;
			folder.Private_Comment__c = null;
			folder.Reason__c = null;
			fetchExistingPastorals();
		}else{
			folder = new Conduct__c();
			folder.RecordTypeId = folderRTId;
			if(grp != null){
				folder.Student_Group__c = grp.Id;
			}
			folder.Pastoral_Date__c = date.today(); 
		}
		
		if(s != null){
			if(s == '1'){
				ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Success: All pastorals are successfully updated.');
				ApexPages.addMessage(successMessage);
			}
		}
		//check for if pastoral is for individual student
		sid = system.currentPageReference().getParameters().get('sid');
		if(sid != null && sid != ''){
			isSingleStudent =  true;
			//fetch student name 
			Contact student =  [select School__c, Student_Name__c from Contact where Id=:sid];
			student_selected = student;
			selectedStudents.add(new SelectOption(sid,student.Student_Name__c));
			//set group as whole school group
			for(School_Logo_Mapping__c schoolMapping : School_Logo_Mapping__c.getall().values()){
			if(schoolMapping.School_Full_Name__c == student.School__c){
				if(schoolMapping.All_Student_Group_Id__c != null){
					folder.Student_Group__c = schoolMapping.All_Student_Group_Id__c;
					if(grp == null){
						grp = [Select g.Year_Group__c, g.School__c, g.Name, g.Id, g.Group_Name__c, g.Description__c, g.Class__c, g.Academic_Year__c From Group__c g where g.Id=:schoolMapping.All_Student_Group_Id__c];
					}
					break;
				}
			}
		}
		}
		initialize();
    }
    
    private void initialize(){
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
		if(!isSingleStudent){
			//search students
			searchStudents();
		}
    }
    
    
    //fetches existing pastorals
    private void fetchExistingPastorals(){
    	
    	for(Conduct__c pastoral:[Select c.Display_in_Portal__c, c.Parent_Portal_Visibility__c,c.Student_Group__c, c.Effort__c, c.Pastoral_Date__c, c.Title__c, c.Student_Name__c,  Student_Name__r.Student_Name__c,  c.RecordType.DeveloperName, c.RecordType.Name, c.RecordType.Id, c.RecordTypeId, c.Reason__c, c.Private_Comment__c,  c.Name, c.Id, c.House__c, c.House_Points__c,  c.Health_Related__c, c.Folder__c, c.Folder_Type__c, c.Folder_Title__c, c.Folder_Description__c, c.Description__c,  c.CreatedDate, c.CreatedById,  c.Action_Taken__c, c.Academic_Year__c From Conduct__c c where Folder__c =:folder.Id AND Student_Group__c=:grp.id order by Student_Name__r.Student_Name__c asc]){
    		existingPastoralsIds.add(pastoral.Id);
    		selectedStudents.add(new SelectOption(pastoral.Student_Name__c,pastoral.Student_Name__r.Student_Name__c));
    		pastorals.add(new PastoralWrapper(pastoral.Student_Name__c,pastoral.Student_Name__r.Student_Name__c,pastoral,folder.Id));
    	}                       
    }
    
    public PageReference onChangeFolderType(){
    	string selectedFolderType = system.currentPageReference().getParameters().get('ft');
    	if(selectedFolderType != null && selectedFolderType != ''){
    		folder.Folder_Type__c = selectedFolderType;
    	}
    	return null;
    }
    
    public PageReference searchStudents(){
    	searchedStudents = new list<SelectOption>();
    	set<Id> alreadyAddedStudents = new set<Id>();
    	for(SelectOption sp:selectedStudents){
    		alreadyAddedStudents.add(sp.getValue());
    	}
    	String query = 'Select Student__r.Stage__c, Student__r.House__c, Student__r.Class__c, Student__r.Year_Group__c,  r.Student__c, r.Student__r.Student_Name__c ,r.Student__r.Student_Full_Name__c,  r.Student__r.Name, r.Name, r.Id, r.Group__c, r.Active__c From Registration__c r where r.Group__c= '+quotedString(grp.Id)+' AND r.Include_in_Assessment_Folder__c = true ';
    		//query += ' where c.RecordTypeId = '+ quotedString(studentRTId) +' AND c.Owner.School__c = '+quotedString(schoolName)+' AND c.Student_Starting_Date_30__c = '+quotedString('TRUE')+' ';
    		query += ' AND CreatedBy.School__c = '+quotedString(grp.School__c)+' ';
    		
    		if(studentKeyword != null && studentKeyword != ''){
    			String keyword = '%'+studentKeyword+'%';
    			query += ' AND Student__r.Student_Name__c  LIKE '+ quotedString(keyword) ;	
    		}
    		
    		if(selectedYearGroup != null && selectedYearGroup != 'All'){
    			query += ' AND Student__r.Year_Group__c = '+ quotedString(selectedYearGroup);
    		}
    		if(selectedClass != null && selectedClass != 'All'){
    			query += ' AND Student__r.Class__c = '+ quotedString(selectedClass) ;
    		}
    		if(selectedHouse != null && selectedHouse != 'All'){
    			query += ' AND Student__r.House__c = '+ quotedString(selectedHouse) ;
    		}
    		query += ' order by Student__r.Student_Name__c asc';
    		System.debug('**********query='+query);
    	
    	for(Registration__c r:Database.query(query)){
    		if(!alreadyAddedStudents.contains(r.Student__c)){
    			searchedStudents.add(new SelectOption(r.Student__c,r.Student__r.Student_Name__c));
    		}
    	}
    	return null;
    }
    
    private string validateSavedPastorals(){
    	string errorMessage = '';
    	set<Id> selectedPastoralIds = new set<Id>();
    	for(SelectOption so:selectedStudents){
    		selectedPastoralIds.add(so.getValue());
    	}
    	for(PastoralWrapper pw:pastorals){
    		if(!selectedPastoralIds.contains(pw.pastoral.Student_Name__c)){
    			errorMessage += 'A pastoral record already exists in this folder for '+pw.studentName+'. Please delete the record from the pastoral entries list to remove them from the \'Selected Students\' list <br/>';
    			selectedStudents.add(new SelectOption(pw.pastoral.Student_Name__c,pw.studentName));
    			//removed from serched students
    			integer index ;
    			integer i = 0;
    			for(SelectOption so:searchedStudents){
    				if(so.getValue() == pw.pastoral.Student_Name__c){
    					index = i;
    				}
    				i++;
    			}
    			if(index != null){
    				searchedStudents.remove(index);
    			}
    		}
    	}
    	/*
    	for(SelectOption so:selectedStudents){
    		Id selectedStudentId = so.getValue();
    		if(pastorals != null){
	    		for(PastoralWrapper pw:pastorals){
	    			if(pw.pastoral.Student_Name__c == selectedStudentId && pw.pastoral.Id != null){
	    				errorMessage += 'Pastoral Record exists for '+pw.studentName+'. Please delete the record from below list to delete respective pastoral record. <br/>';
	    			}
	    		}
    		}
    	}*/
    	return errorMessage;
    }
    
    //create pastorals
    public PageReference createPastorals(){
    	string emessage = validateSavedPastorals();
	    if(emessage == ''){
    		ifSelectedStudents =  false;
	    	if(selectedStudents != null){
	    		if(selectedStudents.size() > 0){
	    			ifSelectedStudents = true;
	    		}
	    	}
    		if(ifSelectedStudents){
    			Id pastoralRTId = [select Id from RecordType where SObjectType='Conduct__c' AND Name=:folder.Folder_Type__c].Id;
		    	list<PastoralWrapper> tempList = new list<PastoralWrapper>();
		    	for(SelectOption so:selectedStudents){
		    		PastoralWrapper pw = checkPastoralList(so.getValue());
		    		if(pw == null){
		    			Conduct__c p = new Conduct__c(RecordTypeId=pastoralRTId,Folder__c=folder.Id,Student_Name__c=so.getValue(),Title__c=folder.Folder_Title__c,Reason__c=folder.Reason__c,Private_Comment__c=folder.Private_Comment__c, Pastoral_Date__c=folder.Pastoral_Date__c, House_Points__c=folder.House_Points__c,Effort__c=folder.Effort__c);
		    			pw = new PastoralWrapper(so.getValue(),so.getLabel(),p,folder.Id);
		    		}
		    		tempList.add(pw);
		    	}
		    	pastorals =  tempList;
		    	disableFolderType = true;
    		}
    	
	    }else{
    		ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, emessage);
			ApexPages.addMessage(errorMessage);
	    }
    	/*ifSelectedStudents =  false;
    	if(selectedStudents != null){
    		if(selectedStudents.size() > 0){
    			ifSelectedStudents = true;
    		}
    	}
    	if(ifSelectedStudents){
	    	//check if a student is removed from list for which saved pastoral record is there
	    	string emessage = validateSavedPastorals();
	    	if(emessage == ''){
		    	Id pastoralRTId = [select Id from RecordType where SObjectType='Conduct__c' AND Name=:folder.Folder_Type__c].Id;
		    	list<PastoralWrapper> tempList = new list<PastoralWrapper>();
		    	for(SelectOption so:selectedStudents){
		    		PastoralWrapper pw = checkPastoralList(so.getValue());
		    		if(pw == null){
		    			Conduct__c p = new Conduct__c(RecordTypeId=pastoralRTId,Folder__c=folder.Id,Student_Name__c=so.getValue(),Title__c=folder.Folder_Title__c,Reason__c=folder.Reason__c,Private_Comment__c=folder.Private_Comment__c, Pastoral_Date__c=folder.Pastoral_Date__c, House_Points__c=folder.House_Points__c,Effort__c=folder.Effort__c);
		    			pw = new PastoralWrapper(so.getValue(),so.getLabel(),p,folder.Id);
		    		}
		    		tempList.add(pw);
		    	}
		    	pastorals =  tempList;
		    	disableFolderType = true;
	    	}else{
	    		ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, emessage);
				ApexPages.addMessage(errorMessage);
	    	}
    	}*/
    	return null;
    }
    
    public PageReference back(){
    	PageReference pg;
    	if(!isSingleStudent){
	    	pg  = Page.Tabbed_Group_Detail ; 
			
			pg.getParameters().put('id',grp.Id);
			pg.getParameters().put('stab','pastorals');
			pg.setRedirect(true);
    	}else {
    		pg  = Page.Tabbed_Record_Contact ; 
			pg.getParameters().put('id',sid);
			pg.getParameters().put('stab','Behaviour');
			pg.setRedirect(true);
    	}
    	return pg;
    }
    
    private PastoralWrapper checkPastoralList(string sid){
    	PastoralWrapper foundWrapper ;
    	for(PastoralWrapper p:pastorals){
    		if(sid == p.studentId){
    			foundWrapper = p;
    		}
    	}
    	return foundWrapper;
    }
    
    //save pastorals
    public PageReference savePastorals(){
    	try{
    		if(!isSingleStudent){
	    		//upsert folder
	    		upsert folder;
	    		//upsert pastorals
	    		list<Conduct__c> upsertList = new list<Conduct__c>();
	    		list<Conduct__c> deleteList = new list<Conduct__c>();
	    		set<Id> upertListIds = new set<Id>();
	    		list<PastoralWrapper> upertListWrapper = new list<PastoralWrapper>();
	    		for(PastoralWrapper pw:pastorals){
	    			
	    			if(pw.pastoral != null){
	    				pw.pastoral.Folder__c = folder.Id;
	    				if(pw.pastoral.Student_Group__c == null){pw.pastoral.Student_Group__c = grp.Id;}
	    				upsertList.add(pw.pastoral);
	    				upertListWrapper.add(pw);
	    				if(pw.pastoral !=null){
							upertListIds.add(pw.pastoral.Id);
						}
	    				/*
	    				if(folder.Folder_Type__c == 'Achievements'){
	    					if(pw.pastoral.Title__c != null){
	    						pw.pastoral.Folder__c = folder.Id;
	    						if(pw.pastoral.Student_Group__c == null){pw.pastoral.Student_Group__c = grp.Id;}
	    						upsertList.add(pw.pastoral);
	    						upertListWrapper.add(pw);
	    						if(pw.pastoral !=null){
	    							upertListIds.add(pw.pastoral.Id);
	    						}
	    					}else if(pw.pastoral.Id != null){
	    						deleteList.add(pw.pastoral);
	    					}
	    				}else if(folder.Folder_Type__c == 'Effort & Attitude'){
	    					//if(pw.pastoral.House_Points__c != null){
	    					if(pw.pastoral.Title__c != null){
	    						pw.pastoral.Folder__c = folder.Id;
	    						if(pw.pastoral.Student_Group__c == null){pw.pastoral.Student_Group__c = grp.Id;}
	    						upsertList.add(pw.pastoral);
	    						upertListWrapper.add(pw);
	    						if(pw.pastoral !=null){
	    							upertListIds.add(pw.pastoral.Id);
	    						}
	    					}else if(pw.pastoral.Id != null){
	    						deleteList.add(pw.pastoral);
	    					}
	    				
	    				}else if(folder.Folder_Type__c == 'Incidents'){
	    					if(pw.pastoral.Title__c != null){
	    						pw.pastoral.Folder__c = folder.Id;
	    						if(pw.pastoral.Student_Group__c == null){pw.pastoral.Student_Group__c = grp.Id;}
	    						upsertList.add(pw.pastoral);
	    						upertListWrapper.add(pw);
	    						if(pw.pastoral !=null){
	    							upertListIds.add(pw.pastoral.Id);
	    						}
	    					}else if(pw.pastoral.Id != null){
	    						deleteList.add(pw.pastoral);
	    					}
	    				}*/
	    			}
	    		}
	    		/*
	    		//check if all existing pastorals are added to list
	    		for(Id existingPastoralId:existingPastoralsIds){
	    			if(!upertListIds.contains(existingPastoralId)){
	    				deleteList.add(new Conduct__c(Id=existingPastoralId));	
	    			}
	    		}*/
	    		boolean isError = false;
	    		if(upsertList.size() > 0){
	    			list<Database.UpsertResult> srList = Database.upsert(upsertList,false);
			        integer i = 0;
			        for(Database.UpsertResult sr:srlist){
			            PastoralWrapper pastoralWrapper = upertListWrapper[i];
			            if(!sr.isSuccess()){
			            	string emessage = sr.getErrors()[0].getMessage();
			                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Failed to update pastoral for student ['+pastoralWrapper.studentName+']. Error Message: '+emessage);
							ApexPages.addMessage(errorMessage);
							pastoralWrapper.isError = true;
							isError= true;
							pastoralWrapper.errorMessage = emessage;
			            }else{
			            	pastoralWrapper.isError = false;
			            	pastoralWrapper.errorMessage = null;
			            }
			            i++;
			        }
	    			
	    		}
	    		/*if(deleteList.size() > 0){
	    			delete deleteList;
	    		}*/
	    		if(isError == false){
		    		PageReference pg = Page.CreatePastorals;
		    		pg.getParameters().put('id',grp.Id);
		    		pg.getParameters().put('fid',folder.Id);
		    		pg.getParameters().put('s','1');
		    		pg.setRedirect(true);
		    		return pg;
	    		}
    		}else{
    			//in case of single student - dont create folder
    			Id pastoralRTId = [select Id from RecordType where SObjectType='Conduct__c' AND Name=:folder.Folder_Type__c].Id;
    			Conduct__c p = new Conduct__c(RecordTypeId=pastoralRTId,Folder__c=folder.Id,Student_Name__c=selectedStudents[0].getValue(),Title__c=folder.Folder_Title__c,Reason__c=folder.Reason__c,Private_Comment__c=folder.Private_Comment__c, Pastoral_Date__c=folder.Pastoral_Date__c, House_Points__c=folder.House_Points__c,Student_Group__c=folder.Student_Group__c,Health_Related__c=folder.Health_Related__c,Effort__c=folder.Effort__c);
    			insert p;
    			PageReference pg  = Page.Tabbed_Record_Contact ; 
				pg.getParameters().put('id',sid);
				pg.getParameters().put('stab','Behaviour');
				pg.setRedirect(true);
				return pg;
    			
    		}
    	}catch(Exception e){
    		ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Failure: Ooops ..Failed to update pastorals. Please correct data and try again. Error Message: '+e.getMessage());
			ApexPages.addMessage(errorMessage);
			//throw e;
    	}
    	return null;
    }
    
    public PageReference deletePastoral(){
    	string did = system.currentPageReference().getParameters().get('did');
    	if(did != null && did != ''){
    		Conduct__c c = new Conduct__c(Id=did);
    		delete c;
    		PageReference pg = Page.CreatePastorals;
    		pg.getParameters().put('id',grp.Id);
    		pg.getParameters().put('fid',folder.Id);
    		pg.getParameters().put('s','1');
    		pg.setRedirect(true);
    		return pg;
    	}
    	return null;
    }
    
    // helper function to return quoted string
	private String quotedString(String s){
		return '\''+String.escapeSingleQuotes(s)+'\'';
	}
	
    public class PastoralWrapper{
    	public Id folderId {get;set;}
    	public String studentId {get;set;}
    	public String studentName {get;set;}
		public Conduct__c pastoral {get;set;}
		public boolean isError {get;set;}
		public string errorMessage {get;set;}
		public PastoralWrapper(string sid, String sName, Conduct__c c, Id fid){
			studentId = sid;
			studentName = sName;
			pastoral = c;
			folderId = fid;
			isError = false;
		}    	
		    	
    }

}