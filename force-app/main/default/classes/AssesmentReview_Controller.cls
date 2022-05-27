/***
    Desc: VF page controller for assessement review
***/
public class AssesmentReview_Controller {   
    public List<SelectOption> yearOptions {get;set;}
    
    public List<SelectOption> classOptions {get;set;}
    public List<SelectOption> houseOptions {get;set;}
    public List<SelectOption> subjectOptions {get;set;}
    public List<SelectOption> studentOptions {get;set;}
    public String selectedYear {get;set;}
    
    public String selectedClass {get;set;}
    public String selectedHouse {get;set;}
    public String selectedSubject {get;set;}
    public String selectedSubjectName {get;set;}
    public String selectedStudent {get;set;}
    public String selectedStudentName {get;set;}
    private String loggedInUserSchool {get;set;}
    private Assesment__c folder;
    public Assesment__c record {get;set;}
    public boolean isNext {get;set;}
    public boolean isPrevious {get;set;}
    public list<string> studentList {get;set;}
    private integer currentIndex {get;set;}
    private Id schoolStudentGroup {get;set;}
    public List<Assesment__c> assessmentList {get;set;}
    private integer initalQueryLimit = 15;
    public boolean showLoadMoreAssessments {get;set;}
    
    //constructor
    public AssesmentReview_Controller(){
        showLoadMoreAssessments = false;
            
        Id uid  =  UserInfo.getUserId();
        User u = [select Id, School__c,Campus__c from User where Id=:uid];
        loggedInUserSchool =  u.School__c;
        
        yearOptions =  new List<SelectOption>(); yearOptions.add(new SelectOption('-','--Select Year--'));
        
        classOptions =  new List<SelectOption>(); classOptions.add(new SelectOption('-','--All Classes--'));
        houseOptions =  new List<SelectOption>(); houseOptions.add(new SelectOption('-','--All Houses--'));
        subjectOptions =  new List<SelectOption>(); subjectOptions.add(new SelectOption('-','--All Subjects--'));
        studentOptions = new List<SelectOption>(); studentOptions.add(new SelectOption('-','--Select Student--'));
        selectedClass = '-';
        selectedHouse = '-';
        selectedSubject = '-';
        //fetch student group created for school from custom settings
        for(School_Logo_Mapping__c schoolMapping : School_Logo_Mapping__c.getall().values()){
            if(schoolMapping.School_Full_Name__c == loggedInUserSchool){
                if(schoolMapping.All_Student_Group_Id__c != null){
                    schoolStudentGroup = schoolMapping.All_Student_Group_Id__c;
                }
            }
        }
        if(schoolStudentGroup == null){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Setting Error: No student group found for school. Please contact admin@britishschools.co.uk .');
            ApexPages.addMessage(errorMessage);
        }else{
            initalizeOptions();
            //check for URL parameters  
            initializeFromURLParams();
        }
        
        
    }
    
    private void initializeFromURLParams(){
        string year = System.currentPageReference().getParameters().get('year');
        string class_str = System.currentPageReference().getParameters().get('class');
        string house = System.currentPageReference().getParameters().get('house');
        string subject = System.currentPageReference().getParameters().get('subject');
        string student = System.currentPageReference().getParameters().get('student');
        string aid = System.currentPageReference().getParameters().get('aid');
        
        if(aid != null && aid != '' && student != null && student != ''){
            selectedYear = year;
            selectedClass = class_str;
            selectedHouse = house;
            fetchSubjects();
            selectedSubject = subject;
            fetchStudents();
            selectedStudent = student;
            processStudent();
        }
        
    }
    
    private void initalizeOptions(){
        //fetch year options
        List<String> yearGroupList =  new List<String>();
        /*for(Schema.PicklistEntry entry:Opportunity.Year_Group__c.getDescribe().getPickListValues()){
            if(entry.isActive()){
                yearGroupList.add(entry.getValue());
            }
        }*/
        //yearGroupList.sort();
        for(String year:PortalUtility.getYearGroupOptions()){
            yearOptions.add(new SelectOption(year,year));
        }
        
        //fetch class options
        List<String> classList =  new List<String>();
        for(Schema.PicklistEntry entry:Opportunity.Class__c.getDescribe().getPickListValues()){
            if(entry.isActive()){
                classList.add(entry.getValue());
            }
        }
        classList.sort();
        for(String c:classList){
            classOptions.add(new SelectOption(c,c));
        }
        //fetch house options
        for(Schema.PicklistEntry entry:Opportunity.House__c.getDescribe().getPickListValues()){
            if(entry.isActive()){
                houseOptions.add(new SelectOption(entry.getValue(),entry.getValue()));
            }
        }
    }
    
    //fetch subject
    private void getSubjects(){
        subjectOptions =  new List<SelectOption>(); subjectOptions.add(new SelectOption('-','--All Subjects--'));
        studentOptions =  new List<SelectOption>(); studentOptions.add(new SelectOption('-','--Select Student--'));
        Set<Id> addedIds =  new Set<Id>();
        set<string> subjects = new set<string>();
        list<string> subjectsList = new list<string>();
        System.debug('***AssessmentReview_Controller***getSubjects**selectedYear='+selectedYear);
        System.debug('***AssessmentReview_Controller***getSubjects**selectedClass='+selectedClass);
        System.debug('***AssessmentReview_Controller***getSubjects**loggedInUserSchool='+loggedInUserSchool);
        
        if(selectedYear != '-'){
        	//change to agreegate queries
            if(selectedClass != '-'){
                for(AggregateResult ag:[select Group__r.Subject_Name__c subject From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = 'Subject' AND r.School__c =:loggedInUserSchool AND r.Student__r.Class__c=:selectedClass AND r.Student__r.Year_Group__c=:selectedYear group by r.Group__r.Subject_Name__c order by r.Group__r.Subject_Name__c]){
                	subjects.add(String.valueOf(ag.get('subject')));
                }
                /*for(Registration__c r:[Select r.Group__r.Group_Name__c, r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = 'Subject' AND r.School__c =:loggedInUserSchool AND r.Student__r.Class__c=:selectedClass AND r.Student__r.Year_Group__c=:selectedYear order by r.Group__r.Subject_Name__c]){
                    System.debug('***AssessmentReview_Controller***getSubjects**r.Group__r.Subject_Name__c='+r.Group__r.Subject_Name__c);
                    subjects.add(r.Group__r.Subject_Name__c);
                }*/
            }else if(selectedClass == '-' || selectedClass == null){
                for(AggregateResult ag:[select Group__r.Subject_Name__c subject From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = 'Subject' AND r.School__c =:loggedInUserSchool AND  r.Student__r.Year_Group__c=:selectedYear group by r.Group__r.Subject_Name__c order by r.Group__r.Subject_Name__c]){
                	subjects.add(String.valueOf(ag.get('subject')));
                }
                
                /*for(Registration__c r:[Select r.Group__r.Group_Name__c, r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = 'Subject' AND r.School__c =:loggedInUserSchool AND r.Student__r.Year_Group__c=:selectedYear order by r.Group__r.Subject_Name__c]){
                    System.debug('***AssessmentReview_Controller***getSubjects**r.Group__r.Subject_Name__c='+r.Group__r.Subject_Name__c);
                    subjects.add(r.Group__r.Subject_Name__c);
                    
                }*/
            }
            /*System.debug('***AssessmentReview_Controller***getSubjects**subjectsList='+subjectsList);
            subjectsList.sort();
            System.debug('***AssessmentReview_Controller***getSubjects**subjectsList***after sort='+subjectsList);
            for(string s:subjectsList){
                subjects.add(s);
            }*/
            for(string s:subjects){
                subjectsList.add(s);
            }
            subjectsList.sort();
            System.debug('***AssessmentReview_Controller***getSubjects**subjects='+subjects);
            System.debug('***AssessmentReview_Controller***getSubjects**subjectsList='+subjectsList);
            for(string s:subjectsList){
                subjectOptions.add(new SelectOption(s,s));
            } 
            System.debug('***AssessmentReview_Controller***getSubjects**subjectOptions='+subjectOptions);
            //get students
            selectedSubject = '-';
            getStudents();
        }
        
    }
    
    //fetch subject
    private void getStudents(){
        System.debug('***AssessmentReview_Controller***getStudents**selectedYear='+selectedYear);
        System.debug('***AssessmentReview_Controller***getStudents**selectedClass='+selectedClass);
        System.debug('***AssessmentReview_Controller***getStudents**selectedHouse='+selectedHouse);
        System.debug('***AssessmentReview_Controller***getStudents**loggedInUserSchool='+loggedInUserSchool);
        System.debug('***AssessmentReview_Controller***getStudents**selectedSubject='+selectedSubject);
        studentOptions =  new List<SelectOption>(); studentOptions.add(new SelectOption('-','--Select Student--'));
        studentList = new list<string>();
        
        //form query
        //String query = 'Select r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = \'Subject\' ';
        //String query = 'Select r.Student__r.Student_Name__c, r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c From Registration__c r where r.Active__c = true  ';
        String query = 'Select r.Student__r.Stage__c, r.Student__r.Student_Name__c, r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c, r.Include_in_Assessment_Folder__c From Registration__c r where r.Include_in_Assessment_Folder__c = true ';
        query+= ' AND r.School__c =:loggedInUserSchool AND r.Student__r.Starting_Date_from_student__c <= TODAY AND (r.Student__r.Stage__c = \'Enrolled\' OR r.Student__r.Stage__c = \'Left\') ';
        if(selectedClass != null && selectedClass != '-'){
            query += ' AND r.Student__r.Class__c=:selectedClass ';
        }
        if(selectedYear != null && selectedYear != '-'){
            query += ' AND r.Student__r.Year_Group__c=:selectedYear ';
        }
        if(selectedHouse != null && selectedHouse != '-'){
            query += ' AND r.Student__r.House__c=:selectedHouse ';
        }
        if(selectedSubject != null && selectedSubject != '-'){
            query += ' AND r.Group__r.Subject_Name__c=:selectedSubject ';
        }
        query += ' order by r.Student__r.Student_Name__c';
        
        //for checking duplicates
        set<Id> addedStudents =  new set<Id>();
        
        for(Registration__c r:Database.query(query)){
            string s_name = r.Student__r.Student_Name__c;
            if(r.Student__r.Stage__c == 'Left'){
                s_name += ' [LEFT SCHOOL]';
            }
            if(!addedStudents.contains(r.Student__c)){
                studentOptions.add(new SelectOption(r.Student__c,s_name));
                studentList.add(r.Student__c);
                addedStudents.add(r.Student__c);
            }
        }
        /*
        if(selectedSubject != null && selectedSubject != '-'){
            if(selectedClass != '-'){
                for(Registration__c r:[Select r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = 'Subject' AND r.School__c =:loggedInUserSchool AND r.Student__r.Class__c=:selectedClass AND r.Student__r.Year_Group__c=:selectedYear AND r.Group__c=:selectedSubject order by r.Student__r.Name]){
                    System.debug('***AssessmentReview_Controller***getStudents**r.Student__r.Student_Full_Name__c='+r.Student__r.Student_Full_Name__c);
                    studentOptions.add(new SelectOption(r.Student__c,r.Student__r.Student_Full_Name__c));
                    studentList.add(r.Student__c);
                }
            }else{
                for(Registration__c r:[Select r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = 'Subject' AND r.School__c =:loggedInUserSchool AND r.Student__r.Year_Group__c=:selectedYear AND r.Group__c=:selectedSubject order by r.Student__r.Name]){
                    System.debug('***AssessmentReview_Controller***getStudents**r.Student__r.Student_Full_Name__c='+r.Student__r.Student_Full_Name__c);
                    studentOptions.add(new SelectOption(r.Student__c,r.Student__r.Student_Full_Name__c));
                    studentList.add(r.Student__c);
                }
            }
        }else if(selectedSubject == null || selectedSubject == '-'){
            if(selectedClass != '-'){
                for(Registration__c r:[Select r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = 'Subject' AND r.School__c =:loggedInUserSchool AND r.Student__r.Class__c=:selectedClass AND r.Student__r.Year_Group__c=:selectedYear  order by r.Student__r.Name]){
                    System.debug('***AssessmentReview_Controller***getStudents**r.Student__r.Student_Full_Name__c='+r.Student__r.Student_Full_Name__c);
                    studentOptions.add(new SelectOption(r.Student__c,r.Student__r.Student_Full_Name__c));
                    studentList.add(r.Student__c);
                }
            }else{
                for(Registration__c r:[Select r.Student__r.Class__c, r.Student__r.Name_of_Position_Optional__c, r.Student__r.Student_Full_Name__c, r.Student__c, r.School__c, r.Id, r.Group__r.Class_Name__c, r.Group__r.Year_Group__c, r.Group__r.Subject_Name__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__r.Group_Type__c = 'Subject' AND r.School__c =:loggedInUserSchool AND r.Student__r.Year_Group__c=:selectedYear  order by r.Student__r.Name]){
                    System.debug('***AssessmentReview_Controller***getStudents**r.Student__r.Student_Full_Name__c='+r.Student__r.Student_Full_Name__c);
                    studentOptions.add(new SelectOption(r.Student__c,r.Student__r.Student_Full_Name__c));
                    studentList.add(r.Student__c);
                }
            
            }
        }*/
        if(studentList.size() >0){
            selectedStudent = studentList[0];
            processSelectedStudent(selectedStudent); 
        }else{
            selectedStudent = '-';
            record = null;
            folder = null;
        }
    }
    
    private void initializeRecord(){
        //create assessment record
        record =  new Assesment__c();
        record.RecordTypeId = [select Id from RecordType where DeveloperName='Assessment_Record' limit 1].Id;
        record.Group__c = schoolStudentGroup;
        record.Student__c = selectedStudent;
    }
    
    //selected student 
    private void processSelectedStudent(Id studentId){
        selectedStudent = studentId;
        Contact s_student = [select Id,Student_Full_Name__c, Stage__c from Contact where Id=:studentId];
        if(s_student != null){
            selectedStudentName = s_student.Student_Full_Name__c;
            if(s_student.Stage__c == 'Left'){
                selectedStudentName += ' [LEFT SCHOOL]';
            }
        }
        if(selectedSubject != '-'){
            //selectedSubjectName = [select Name from Group__c where Id=:selectedSubject].Name;
            selectedSubjectName = selectedSubject;
        }
        //fetch assessment folder
        folder = getFolder();
        initializeRecord();
        //check for student index
        integer i = 0;
        for(String sId:studentList){
            if(sId == selectedStudent){
                currentIndex = i;
            }
            i++;
        }
        //check for next and previous
        if(currentIndex == 0){
            isPrevious =  false;
            if(studentList.size() > 1){
                isNext  =  true;
            }else{
                isNext = false;
            }
            
        }
        if(currentIndex > 0 && currentIndex < (studentList.size() - 1)){
            isNext  =  true;
            isPrevious =  true;
        }
        if(currentIndex == (studentList.size() - 1)){
            isNext  =  false;
            if(studentList.size() > 1){
                isPrevious =  true;
            }else{
                isPrevious =  false;
            }
        }
        fetchAssessments(initalQueryLimit);
    }
    
    
    private void fetchAssessments(integer queryLimit){           
        integer assessmentCount = [Select count() From Assesment__c a where RecordType.DeveloperName = 'Assessment_Record' AND Student__c=:selectedStudent AND a.Assessment_Folder__r.Auto_Publish__c = true AND (a.Assessment_Folder__r.Type__c = 'Progress Report' OR a.Assessment_Folder__r.Type__c = 'Examination')];
        if(assessmentCount > queryLimit){
            showLoadMoreAssessments =  true;    
        }else{
            showLoadMoreAssessments = false;
        }
        assessmentList =  new List<Assesment__c>();
        if(selectedSubject == null || selectedSubject == '-'){
            for(Assesment__c a:[Select a.Target_Predicted_Grade__c, a.Assessment_Display_Name__c, a.Auto_Approve__c, a.Assessment_Name__c ,a.Type__c, a.Student__c, a.Name, a.Mid_Term_Report__c, a.Group__c, a.Group_Name__c, a.Grade__c, a.Effort__c, a.Comment__c, a.Assessment_Folder__r.School__c, a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Academic_Year__c, a.Assessment_Folder__r.Title__c, a.Assessment_Folder__r.Assessment_Date__c, a.CreatedById,  a.Assessment_Folder__c, a.Achievement__c, a.Academic_Year__c From Assesment__c a where RecordType.DeveloperName = 'Assessment_Record' AND (a.Assessment_Folder__r.Type__c = 'Progress Report' OR a.Assessment_Folder__r.Type__c = 'Examination')  AND Student__c=:selectedStudent AND a.Assessment_Folder__r.Auto_Publish__c = true  order by a.Order__c desc, a.Assessment_Folder__r.Assessment_Date__c desc limit :queryLimit]){
                assessmentList.add(a);
            }
        }else{
            for(Assesment__c a:[Select a.Target_Predicted_Grade__c, a.Assessment_Display_Name__c, a.Auto_Approve__c, a.Assessment_Name__c ,a.Type__c, a.Student__c, a.Name, a.Mid_Term_Report__c, a.Group__c, a.Group_Name__c, a.Grade__c, a.Effort__c, a.Comment__c, a.Assessment_Folder__r.School__c, a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Academic_Year__c, a.Assessment_Folder__r.Title__c, a.Assessment_Folder__r.Assessment_Date__c, a.CreatedById,  a.Assessment_Folder__c, a.Achievement__c, a.Academic_Year__c From Assesment__c a where RecordType.DeveloperName = 'Assessment_Record' AND (a.Assessment_Folder__r.Type__c = 'Progress Report' OR a.Assessment_Folder__r.Type__c = 'Examination') AND Student__c=:selectedStudent AND a.Assessment_Folder__r.Auto_Publish__c = true  AND a.Group__r.Subject_Name__c=:selectedSubject order by a.Order__c desc, a.Assessment_Folder__r.Assessment_Date__c desc limit :queryLimit]){
                assessmentList.add(a);
            }
        }
    }
    
    private Assesment__c getFolder(){   
        Assesment__c fldr;
        //default folder name
        String userTitle = [select Id, Title from User where Id=:UserInfo.getUserId()].Title;
        String folderName = 'Summative Comment' ;
        //fetch assessment folder - logic need to be updated
        for(Assesment__c f:[select Include_Target_Predicted_Grade__c, Id,Assessment_Date__c, Name from Assesment__c where RecordType.DeveloperName = 'Assessment_Folder' AND Title__c=:folderName and Assessment_Date__c =:Date.today() AND CreatedById =: UserInfo.getUserId() order by LastModifiedDate desc limit 1]){
            fldr = f;
        }
        if(fldr == null){
            fldr =  new Assesment__c();
            fldr.Assessment_Date__c = Date.today();
            //fldr.Auto_Publish__c = true;
            fldr.Type__c = 'Progress Report';  
            fldr.RecordTypeId = [select Id from RecordType where DeveloperName='Assessment_Folder' limit 1].Id;
            fldr.Group__c = schoolStudentGroup;
            fldr.Title__c = folderName;
            //for fetching date
            system.debug('****AssesmentReview_Controller***getfolder***selectedStudent='+selectedStudent);
            for(Assesment__c a:[Select a.Assessment_Name__c ,a.Type__c, a.Student__c, a.Name, a.Mid_Term_Report__c, a.Group__c, a.Group_Name__c, a.Grade__c, a.Effort__c, a.Comment__c, a.Assessment_Folder__r.School__c, a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Academic_Year__c, a.Assessment_Folder__r.Title__c, a.Assessment_Folder__r.Assessment_Date__c, a.CreatedById,  a.Assessment_Folder__c, a.Achievement__c, a.Academic_Year__c From Assesment__c a where RecordType.DeveloperName = 'Assessment_Record' AND Student__c=:selectedStudent AND a.Assessment_Folder__r.Auto_Publish__c = true order by a.Order__c desc, a.Assessment_Folder__r.Assessment_Date__c desc limit 1]){
                system.debug('****AssesmentReview_Controller***getfolder***selectedStudent***a='+a);
                if(a.Assessment_Folder__r.Assessment_Date__c >= Date.today()){
                    fldr.Assessment_Date__c = a.Assessment_Folder__r.Assessment_Date__c;
                }
            }
            if(fldr.Assessment_Date__c == null){
                fldr.Assessment_Date__c = Date.today();
            }
        }
        return fldr;
    }
    
    public PageReference fetchSubjects(){
        getSubjects();
        return null;    
    }
    
    public PageReference fetchStudents(){
        getStudents();
        return null;    
    }
    
    public PageReference processStudent(){
        if(selectedStudent != null && selectedStudent != '-'){
            processSelectedStudent(selectedStudent);
        }else{
            record = null;
            folder = null;
        }
        return null;    
    }
    
    public PageReference nextStudent(){
        integer i = 0;
        for(String sId:studentList){
            if((currentIndex + 1) == i){
                processSelectedStudent(sId);
                break;
            }
            i++;
        }
        return null;
    }
    
    public PageReference previousStudent(){
        integer i = 0;
        for(String sId:studentList){
            if((currentIndex -1) == i){
                processSelectedStudent(sId);
                break;
            }
            i++;
        }
        return null;
    }
    
    public PageReference fetchMoreAssessments(){
        initalQueryLimit += 15;
        System.debug('***AssessmentReview_Controller***fetchMoreAssessments***selectedStudent='+selectedStudent);
        fetchAssessments(initalQueryLimit); 
        return null;
    }
    
    public PageReference publishComment(){
        if(record.Comment__c != null){
            if(record.Comment__c.trim() != ''){
                if(folder.Id == null){
                    insert folder;
                }
                record.Assessment_Folder__c = folder.Id;
                upsert record;
                initializeRecord();
                fetchAssessments(initalQueryLimit);
            }
        }           
        return null;
        
    }
    
    public PageReference deleteAssessment(){
        string delId = system.currentPageReference().getParameters().get('did');
        if(delId != null && delId != ''){
            try{
                Assesment__c a = new Assesment__c(Id = delId);
                delete a;
                fetchAssessments(initalQueryLimit);
            }catch(Exception e){
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, e.getMessage());
                ApexPages.addMessage(errorMessage);
            }
        }
        return null;
    }
    
    
}