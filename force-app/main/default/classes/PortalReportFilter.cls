/***
    Author: Kunal 
    Created Date: 28 April 2013
    Desc: Master class for parent portal filters
***/

public virtual class PortalReportFilter{ 
    public Id parentAccountId {get;set;}
    public Set<Id> studentIds {get;set;}    
    public User portalUser {get;set;}
    
    //filters
    //for student selection
    public List<SelectOption> studentList {get;set;}
    public String selectedStudentId {get;set;}
    //for academic year selection
    public List<SelectOption> academicYearOptions {get;set;}
    public String selectedAcademicYear {get;set;}
    /*//for term selection
    public List<SelectOption> termOptions {get;set;}
    public List<String> selectedTerm {get;set;}*/
    //for assessment type selection
    public List<ReportTypeWrapper> assessmentTypeOptions {get;set;}
    
    public List<ReportTypeWrapper> attendanceTypeOptions {get;set;}
    
    public List<ReportTypeWrapper> conductTypeOptions {get;set;}
    
    public List<ReportTypeWrapper> newsEventTypeOptions {get;set;}
    //for subject type
    public List<SelectOption> subjectTypeOptions {get;set;}
    public String selectedSubjectType {get;set;} 
    //for parent name 
    public String familyName {get;set;}
    public Map<String,String> schoolLogoMap;
    private Id accId {get;set;}
    //constructor
    public  PortalReportFilter(){
        Id loggedInUserId =  UserInfo.getUserId();
        //fetch account id 
        //parentAccountId =  [Select u.Name, Family_File_Id__c, u.ContactId, u.AccountId From User u where Id=:loggedInUserId].AccountId;
        portalUser =  [Select u.LocaleSidKey,  u.School__c, u.Name, Family_File_Id__c ,u.ContactId, u.AccountId From User u where Id=:loggedInUserId];
        if(portalUser.Family_File_Id__c != null && portalUser.Family_File_Id__c != ''){
            parentAccountId = portalUser.Family_File_Id__c ;
        }else{
            parentAccountId = portalUser.AccountId;
        }  
        
        //check for testing
        if(parentAccountId == null){
            //fetch parentaccount id from URL 
            string a_id = System.currentPageReference().getParameters().get('accid');
            if(a_id != null & a_id != ''){
            	accId = a_id;
            	parentAccountId =  accId;
            }
        }      
        if(parentAccountId != null){
            Account parentAcc = [Select a.FirstName,a.LastName From Account a where a.Id=:parentAccountId];
            familyName = parentAcc.LastName+' - '+parentAcc.FirstName;
            initialize();
        }else{
            //add error to page
        }
    }
    
    public void createTabClickEvent(string tab){
        if(portalUser != null && accId == null){
            if(portalUser.ContactId != null){
                Contact con = [select Id, Chatter_Favorite_Added__c from Contact where Id=:portalUser.ContactId];
                if(tab == 'assessment'){
                    con.Assessment_Reports_Accessed__c = DateTime.now();
                    //update con;
                }else if(tab == 'attendance'){
                    con.Attendance_Report_Accessed__c = DateTime.now();
                    //update con;
                }else if(tab == 'pastoral'){
                    con.Pastoral_Report_Accessed__c = DateTime.now();
                    //update con;
                }else if(tab == 'newsevents'){
                    con.NewsEvents_Report_Accessed__c = DateTime.now();
                }
                try{
                    //check for chatter favorite
                    if(con.Chatter_Favorite_Added__c ==  false){
                        Map<String,School_Logo_Mapping__c>schoolSettingMap =  new Map<String,School_Logo_Mapping__c>();
                        List<School_Logo_Mapping__c> settings = School_Logo_Mapping__c.getall().values(); 
                        for(School_Logo_Mapping__c setting:settings){
                            schoolSettingMap.put(setting.School_Full_Name__c,setting);
                        }
                        if(schoolSettingMap.get(portalUser.School__c) != null){
                            if(schoolSettingMap.get(portalUser.School__c).Community_Id__c != null){
                                if(schoolSettingMap.get(portalUser.School__c).Topic_Id__c != null){
                                    ConnectApi.FeedFavorite feedFavoriteResult = ConnectApi.ChatterFavorites.addRecordFavorite(schoolSettingMap.get(portalUser.School__c).Community_Id__c , portalUser.Id, schoolSettingMap.get(portalUser.School__c).Topic_Id__c);
                                    con.Chatter_Favorite_Added__c = true;
                                }
                            }
                        }
                    }
                    update con;
                }catch(Exception e){
                    //do nothing
                }
            }
        }
        
    }
    
    private void initialize(){
        //check for student cookie
        Cookie cookie_sid_prf = ApexPages.currentPage().getCookies().get('sid');
        
        //populate schools logo map
        schoolLogoMap =  new Map<String,String>();
        List<School_Logo_Mapping__c> settings = School_Logo_Mapping__c.getall().values(); 
        for(School_Logo_Mapping__c setting:settings){
            if(accId == null){
            	schoolLogoMap.put(setting.School_Full_Name__c,setting.Logo_URL__c);
            }else{
            	string logo_URL = setting.Logo_URL__c;
            	if(logo_URL != null){
            		logo_URL = logo_URL.replace('/parents','');
            	}
            	schoolLogoMap.put(setting.School_Full_Name__c,logo_URL);
            }
        }
        //initialze report filters
        initializeStudentList();
        initializeYearSubject();
        initializeAssessmentReportTypes();
        initializeAttendanceReportTypes();
        initializeConductReportTypes();
        initializeNewsEventTypeOptions();
        if(studentList != null){
             //check if cookie is not null and student is there is student list
            boolean isSelectedStudent = false;
            if(cookie_sid_prf != null){
                string cookie_value = cookie_sid_prf.getValue();
                if(cookie_value != null && cookie_value != ''){
                    for(Id sid : studentIds){
                        string str_id = sid;
                        if(sid == cookie_value){
                               isSelectedStudent = true;
                               break;                   
                        }
                    }
                }
            } 
            if(isSelectedStudent){ 
                selectedStudentId = cookie_sid_prf.getValue();
            }else if(studentList.size() > 0){
                selectedStudentId = studentList[0].getValue();
            }
        }
        
        if(academicYearOptions != null){
            if(academicYearOptions.size() > 0 && selectedAcademicYear == null){
                selectedAcademicYear = academicYearOptions[0].getValue();
            }
        }
        
        selectedSubjectType = '-';
        
        /*
        //initialize group list
        groupList = new List<String>();
        groupList.add('All');
        for(AssessmentWrapper a:assessmentList){
            if(a.isTutorGroup){
                groupList.add('Tutor Group - '+a.groupName);    
            }
        }
        for(AssessmentWrapper a:assessmentList){
            if(!a.isTutorGroup){
                groupList.add(a.groupName); 
            }
        }*/
    }
    
    //helper function to initialize student list
    private void initializeStudentList(){
        studentList = new List<SelectOption>();
        studentIds =  new Set<Id>();
        for(Contact c:[Select c.RecordTypeId, c.Student_Name_in_Portal__c, c.Name, c.Main_Parent_File__c, c.LastName, c.FirstName, c.Email, c.EAL__c, c.Class_Name__c, c.AccountId From Contact c where c.RecordType.DeveloperName = 'Student' AND c.Main_Parent_File__c=:parentAccountId AND (Stage__c = 'Enrolled' OR Stage__c = 'Left') order by Name]){
            studentList.add(new SelectOption(c.Id,c.Student_Name_in_Portal__c));
            studentIds.add(c.Id);
        }
        System.debug('***PortalReportFilter*****initialize***studentIds='+studentIds);
    }
    
    //helper function to initialize academic year & subject type
    private void initializeYearSubject(){
        //fetch all acdemic year options  & subject Type
        Set<String> aYear =  new Set<String>();
        Set<String> subjectList =  new Set<String>();
        for(Registration__c r:[Select r.Student__c, r.Id, r.Group__r.Subject_Name__c, r.Group__r.Academic_Year__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__r.Id, r.Group__c, r.Active__c From Registration__c r where r.Student__c IN:studentIds AND r.Group__r.Group_Type__c = 'Tutor Group'  order by r.Group__r.CreatedDate desc]){
                if(selectedAcademicYear == null){
                    selectedAcademicYear = r.Group__r.Academic_Year__c;
                }
                aYear.add(r.Group__r.Academic_Year__c);
                if(r.Group__r.Group_Type__c.equalsIgnoreCase('subject') && r.Group__r.Subject_Name__c != null && r.Group__r.Subject_Name__c != ''){
                    subjectList.add(r.Group__r.Subject_Name__c);
                }
        }
        academicYearOptions = new List<SelectOption>();
        list<string> years =  new list<string>();
        for(String s:aYear){
            years.add(s);
        }
        years.sort();
        for(integer i = years.size() -1; i >=0 ; i--){
            academicYearOptions.add(new SelectOption(years[i],years[i]));
        }
        //for(String s:aYear){
            //academicYearOptions.add(new SelectOption(s,s));
        //}
        subjectTypeOptions = new List<SelectOption>();
        subjectTypeOptions.add(new SelectOption('-','All Subjects'));
        //subjectList.sort();
        for(String s:subjectList){
            subjectTypeOptions.add(new SelectOption(s,s));
        }
        System.debug('***PortalReportFilter*****initialize***academicYearOptions='+academicYearOptions);
    }
    /*
    //helper function to initialize terom  options
    private void initializeTermOptions(){
        //fetch all term options
        Set<String> terms =  new Set<String>();
        for(Assesment__c a:[Select a.Student__c, a.Id, a.Assessment_Folder__r.Term__c, a.Assessment_Folder__r.Mid_Term_Report__c, a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Auto_Publish__c, a.Assessment_Folder__r.Id, a.Assessment_Folder__c From Assesment__c a where a.Student__c IN:studentIds AND a.Assessment_Folder__r.Auto_Publish__c = true order by a.Assessment_Folder__r.Term__c]){
            terms.add(a.Assessment_Folder__r.Term__c);
        }
        termOptions = new List<SelectOption>();
        for(String s:terms){
            termOptions.add(new SelectOption(s,s));
        }
    }*/
    
    //helper function to initialize assessment report types
    private void initializeAssessmentReportTypes(){
        //fetch all assessment type options
        assessmentTypeOptions = new List<ReportTypeWrapper>();
    
        List<String> assessmentType =  new List<String>();
        for(Schema.PicklistEntry entry: Assesment__c.Type__c.getDescribe().getPicklistValues()){
            if(!entry.getValue().equalsIgnoreCase('Tracking')){
                assessmentType.add(entry.getValue());
            }
        }
        assessmentTypeOptions = new List<ReportTypeWrapper>();
        for(String s:assessmentType){
            assessmentTypeOptions.add(new ReportTypeWrapper(s,assessmentTypeOptions.size()));
        }
        System.debug('***PortalReportFilter*****initialize***assessmentTypeOptions='+assessmentTypeOptions);
    }
    
    //helper function to initialize attendance report types
    private void initializeAttendanceReportTypes(){     
        attendanceTypeOptions =  new List<ReportTypeWrapper>();
        attendanceTypeOptions.add(new ReportTypeWrapper('Lates',attendanceTypeOptions.size()));
        attendanceTypeOptions.add(new ReportTypeWrapper('Absences',attendanceTypeOptions.size()));
        attendanceTypeOptions.add(new ReportTypeWrapper('Partials',attendanceTypeOptions.size()));
        attendanceTypeOptions.add(new ReportTypeWrapper('External Activities',attendanceTypeOptions.size()));
        System.debug('***PortalReportFilter*****initialize***attendanceTypeOptions='+attendanceTypeOptions);
    }
    
    //helper function to initialize attendance report types
    private void initializeConductReportTypes(){        
        conductTypeOptions =  new List<ReportTypeWrapper>();
        conductTypeOptions.add(new ReportTypeWrapper('Incidents',conductTypeOptions.size()));
        conductTypeOptions.add(new ReportTypeWrapper('Achievements',conductTypeOptions.size()));
        //conductTypeOptions.add(new ReportTypeWrapper('Leadership Roles',conductTypeOptions.size()));
        conductTypeOptions.add(new ReportTypeWrapper('Effort & Attitude',conductTypeOptions.size()));
        System.debug('***PortalReportFilter*****initialize***conductTypeOptions='+conductTypeOptions);
    }
    
    //helper function to initialize attendance report types
    private void initializeNewsEventTypeOptions(){        
        newsEventTypeOptions =  new List<ReportTypeWrapper>();
        PortalReportFilter.ReportTypeWrapper termsHolidays = new ReportTypeWrapper('Term / Holidays',newsEventTypeOptions.size());
        termsHolidays.reportTypeValue = 'Term;Holiday';
        newsEventTypeOptions.add(termsHolidays);
        
        PortalReportFilter.ReportTypeWrapper events = new ReportTypeWrapper('Events',newsEventTypeOptions.size());
        events.reportTypeValue = 'Event';
        newsEventTypeOptions.add(events);
        
        PortalReportFilter.ReportTypeWrapper reminders = new ReportTypeWrapper('Notices',newsEventTypeOptions.size());
        reminders.reportTypeValue = 'Notice';
        newsEventTypeOptions.add(reminders);
        
        System.debug('***PortalReportFilter*****initialize***newsEventTypeOptions='+newsEventTypeOptions); 
    }
    
    //wrapper class for report type
    public class ReportTypeWrapper{
        public String reportType {get;set;}
        public String reportTypeValue {get;set;}
        public boolean selected {get;set;}
        public Integer index {get;set;}
        public Integer rt {get;set;}
        public ReportTypeWrapper(String s, Integer i){
            index =  i+1;
            reportType =  s;
            selected =  true;
            if(reportType.equalsIgnoreCase('Progress Report') || reportType.equalsIgnoreCase('Partials') || reportType.equalsIgnoreCase('Partial') || reportType.equalsIgnoreCase('Effort & Attitude') || reportType.equalsIgnoreCase('Term / Holidays')){
                rt = 1;
            }else if(reportType.equalsIgnoreCase('Assignment') || reportType.equalsIgnoreCase('External Activities') || reportType.equalsIgnoreCase('External Activity') || reportType.equalsIgnoreCase('Achievements') || reportType.equalsIgnoreCase('Events')){
                rt = 2;
            }else if(reportType.equalsIgnoreCase('Examination') || reportType.equalsIgnoreCase('Late') || reportType.equalsIgnoreCase('Lates') ){
                rt = 3;
            }else if(reportType.equalsIgnoreCase('Test') || reportType.equalsIgnoreCase('Incidents') || reportType.equalsIgnoreCase('Notices') || reportType.equalsIgnoreCase('Absent') || reportType.equalsIgnoreCase('Absences')){
                rt = 4;
            }
        } 
    }
}