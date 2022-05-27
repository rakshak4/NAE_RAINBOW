public class AssessmentApproval1_Controller{    
    //for assessment report approval
    public List<SelectOption> yearOptionsForApproval {get;set;}
    public List<SelectOption> campusOptionsForApproval {get;set;}
    public String[] selectedYears = new String[]{};
    public String[] selectedCampuses = new String[]{};
    
    private String loggedInUserSchool {get;set;}
    public String loggedInUserCampus {get;set;}
    
    //for assessment approval
    public Task assessmentApprovalDateTask {get;set;}
    //for selected years
    public String[] getSelectedYears(){
        return selectedYears;
    }
    
    public void setSelectedYears(String[] years){
        selectedYears = years;
    }
    //for selected campus
    public String[] getSelectedCampuses(){
        return selectedCampuses;
    }
    
    public void setSelectedCampuses(String[] cs){
        selectedCampuses = cs;
    }
    
    //for pastoral approval
    public List<SelectOption> reportTypeOptionsForApproval {get;set;}
    public String[] selectedReportTypes = new String[]{};
    //for selected years
    public String[] getSelectedReportTypes(){
        return selectedReportTypes;
    }
    
    public void setSelectedReportTypes(String[] types){
        selectedReportTypes = types;
    }
    //constructor
    public AssessmentApproval1_Controller(){ 
        assessmentApprovalDateTask =  new Task();
        Id uid  =  UserInfo.getUserId();
        User u = [select Id, School__c,Campus__c from User where Id=:uid];
        loggedInUserSchool =  u.School__c;
        loggedInUserCampus = u.Campus__c;
        yearOptionsForApproval = new list<SelectOption>();
        for(String year:PortalUtility.getYearGroupOptions()){
            yearOptionsForApproval.add(new SelectOption(year,year));
        }
        //campus options
        campusOptionsForApproval = new list<SelectOption>();
        campusOptionsForApproval.add(new SelectOption('Campus 1','Campus 1 (Classes A-H)'));
        campusOptionsForApproval.add(new SelectOption('Campus 2','Campus 2 (Classes I-P)'));
        campusOptionsForApproval.add(new SelectOption('Campus 3','Campus 3 (Classes Q-X)'));
        //pastoral type options 
        reportTypeOptionsForApproval  =  new list<SelectOption>();
        reportTypeOptionsForApproval.add(new SelectOption('Progress Report','Progress Reports'));
        reportTypeOptionsForApproval.add(new SelectOption('Examination','Examinations'));
        reportTypeOptionsForApproval.add(new SelectOption('Effort & Attitude','Effort & Attitude'));
        
    }
    
    public PageReference publishReports(){       
        //check of atleast one option is selected
        boolean filter_flag = false;
        if(selectedReportTypes.size()== 0){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Please select at least one Report Type.');
            ApexPages.addMessage(errorMessage);
            filter_flag = true;
        }
        if(selectedYears.size() == 0){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Please select at least one Year Group.');
            ApexPages.addMessage(errorMessage);
            filter_flag = true;
        }
        if(loggedInUserCampus != null && selectedCampuses.size() == 0){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Please select at least one Campus.');
            ApexPages.addMessage(errorMessage);
            filter_flag = true;
        }
        if(filter_flag){
            return null;
        }else{
            //fetch all assessments for user's school marked as published
            Date reportDate = assessmentApprovalDateTask.ActivityDate;
            set<String> selectedReportTypeSet = new set<String>();
            for(String s:selectedReportTypes){
                selectedReportTypeSet.add(s);
            }
            if(selectedReportTypeSet.contains('Progress Report') || selectedReportTypeSet.contains('Examination')){
            //if(true){
                List<Assesment__c> assessments =  new List<Assesment__c>();
                //string query = 'Select a.Id ,a.Type__c, a.Student__c, a.Name, a.Mid_Term_Report__c, a.Group__c, a.Group_Name__c, a.Grade__c, a.Effort__c, a.Comment__c, a.Assessment_Folder__r.School__c, a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Academic_Year__c, a.Assessment_Folder__r.Title__c, a.Assessment_Folder__r.Assessment_Date__c, a.CreatedById,  a.Assessment_Folder__c, a.Achievement__c, a.Academic_Year__c From Assesment__c a where RecordType.DeveloperName = \'Assessment_Record\' AND a.Assessment_Folder__r.Assessment_Date__c <=:reportDate AND a.Assessment_Folder__r.Auto_Publish__c = true AND a.Auto_Approve__c = false AND a.Group__r.School__c=:loggedInUserSchool AND a.Assessment_Folder__r.Type__c IN:selectedReportTypes ';
                string query = 'Select a.Id, a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Assessment_Date__c, a.Is_Approved__c From Assesment__c a where RecordType.DeveloperName = \'Assessment_Record\' AND a.Assessment_Folder__r.Assessment_Date__c <=:reportDate AND a.Is_Approved__c = false AND a.Group__r.School__c=:loggedInUserSchool AND a.Assessment_Folder__r.Type__c IN:selectedReportTypes ';
                if(selectedYears != null && selectedYears.size()  > 0){
                    query += ' AND a.Student__r.Year_Group__c IN:selectedYears ';
                }
                if(selectedCampuses != null && selectedCampuses.size()  > 0){
                    query += ' AND a.Contact_Campus__c IN:selectedCampuses ';
                }
                
                for(Assesment__c a:Database.query(query)){
                    a.Is_Approved__c =  true;
                    assessments.add(a);
                }
                
                /*
                if(selectedYears != null && selectedYears.size()  > 0){
                    for(Assesment__c a:[Select a.Id ,a.Type__c, a.Student__c, a.Name, a.Mid_Term_Report__c, a.Group__c, a.Group_Name__c, a.Grade__c, a.Effort__c, a.Comment__c, a.Assessment_Folder__r.School__c, a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Academic_Year__c, a.Assessment_Folder__r.Title__c, a.Assessment_Folder__r.Assessment_Date__c, a.CreatedById,  a.Assessment_Folder__c, a.Achievement__c, a.Academic_Year__c From Assesment__c a where RecordType.DeveloperName = 'Assessment_Record' AND a.Assessment_Folder__r.Assessment_Date__c <=:assessmentApprovalDateTask.ActivityDate AND a.Assessment_Folder__r.Auto_Publish__c = true AND a.Auto_Approve__c = false AND a.Group__r.School__c=:loggedInUserSchool AND a.Student__r.Year_Group__c IN:selectedYears]){
                        a.Is_Approved__c =  true;
                        assessments.add(a);
                    }
                }else{
                    for(Assesment__c a:[Select a.Id ,a.Type__c, a.Student__c, a.Name, a.Mid_Term_Report__c, a.Group__c, a.Group_Name__c, a.Grade__c, a.Effort__c, a.Comment__c, a.Assessment_Folder__r.School__c, a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Academic_Year__c, a.Assessment_Folder__r.Title__c, a.Assessment_Folder__r.Assessment_Date__c, a.CreatedById,  a.Assessment_Folder__c, a.Achievement__c, a.Academic_Year__c From Assesment__c a where RecordType.DeveloperName = 'Assessment_Record' AND a.Assessment_Folder__r.Assessment_Date__c <=:assessmentApprovalDateTask.ActivityDate AND a.Assessment_Folder__r.Auto_Publish__c = true AND a.Auto_Approve__c = false AND a.Group__r.School__c=:loggedInUserSchool]){
                        a.Is_Approved__c =  true;
                        assessments.add(a);
                    }
                }*/
                if(assessments.size() > 0){
                    try{
                        update assessments;
                        //add success message
                        
                        ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, assessments.size() + ' assessment(s) were successfully approved.');
                        ApexPages.addMessage(successMessage);
                    }catch(Exception e){
                        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Data Error: Fatal Error ocurred. If error persists, please contact admin@britishschools.co.uk and provide following message: '+e.getMessage());
                        ApexPages.addMessage(errorMessage);
                    }
                }else{
                    ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'No assessments found pending for approval.');
                    ApexPages.addMessage(successMessage);
                }
            }
            //for pastorals 
            if(selectedReportTypeSet.contains('Effort & Attitude')){
            
                List<Conduct__c> pastorals =  new List<Conduct__c>();
                string query = 'Select c.Title__c, c.Student_Name__c, c.Student_Group__c, c.RecordTypeId, c.Pastoral_Date__c, c.Name, c.Is_Approved__c, c.Id, c.House_Points__c, c.Health_Related__c, c.Folder__c, c.Folder_Type__c, c.Folder_Title__c, c.Effort__c, c.Display_in_Portal__c, c.Display_Title__c, c.Display_Header__c, c.Description__c, c.Action_Taken__c, c.Academic_Year__c From Conduct__c c where c.RecordType.DeveloperName != \'Pastoral_Folder\' AND c.Pastoral_Date__c <=:reportDate AND c.Is_Approved__c = false AND c.Student_Group__r.School__c=:loggedInUserSchool AND RecordType.Name IN:selectedReportTypes AND Display_in_Portal__c = false ';
                if(selectedYears != null && selectedYears.size()  > 0){
                    query += ' AND c.Student_Name__r.Year_Group__c IN:selectedYears ';
                }
                if(selectedCampuses != null && selectedCampuses.size()  > 0){
                    query += ' AND c.Contact_Campus__c IN:selectedCampuses ';
                }
                for(Conduct__c c:Database.query(query)){
                    c.Is_Approved__c =  true;
                    pastorals.add(c);
                }
                
                if(pastorals.size() > 0){
                    try{
                        update pastorals;
                        //add success message
                        
                        ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, pastorals.size() + ' pastoral(s) were successfully approved.');
                        ApexPages.addMessage(successMessage);
                    }catch(Exception e){
                        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Data Error: Fatal Error ocurred. If error persists, please contact admin@britishschools.co.uk and provide following message: '+e.getMessage());
                        ApexPages.addMessage(errorMessage);
                    }
                }else{
                    ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'No pastorals found pending for approval.');
                    ApexPages.addMessage(successMessage);
                }
            }
        }   
        return null;
        
    } 
    
    
}