/***
    Author: Kunal 
    Created Date: 28 April 2013
    Desc: VF controller for ParentPortalAssessment Page
***/

public class ParentPortalAssessment_Controller extends PortalReportFilter{ 
    
    public String schoolName {get;set;}
    public String schoolLogoURL {get;set;}
    public String studentName {get;set;}
    
    public List<TermWrapper> termWrapperList {get;set;}
    public List<SelectOption> studentGroupsOptions {get;set;}
    public String selectedStudentGroup {get;set;}
    public List<SelectOption> studentYearOptions {get;set;}
    public String selectedStudentYear {get;set;}
    public boolean hasItems{get{boolean flag = false;if(termWrapperList != null){if(termWrapperList.size() > 0){flag = true;}}return flag;}}
    //for subject options
    private Map<String,Set<Id>> groupNameIdMap ;
    private String tutorSchoolGroup = 'Tutor / Summative' ;
    
    //constructor
    public  ParentPortalAssessment_Controller(){
        termWrapperList =  new List<TermWrapper>();
        populateYearOptions();
        populateGroupOptions();
    }
    
    //function to search attendances
    public PageReference reset(){
        PageReference pg = Page.PortalAssessmentPage;
        pg.setRedirect(true);
        return pg;
    } 
    
    //function to search assessments
    public PageReference filterAssessments(){
        createTabClickEvent('assessment');
        termWrapperList =  new List<TermWrapper>();
        System.debug('*****ParentPortalAssessment_Controller**filterAssessments**selectedStudentId='+selectedStudentId);
        System.debug('*****ParentPortalAssessment_Controller**filterAssessments**selectedStudentYear='+selectedStudentYear);
        System.debug('*****ParentPortalAssessment_Controller**filterAssessments**selectedStudentGroup='+selectedStudentGroup);
        System.debug('*****ParentPortalAssessment_Controller**filterAssessments**assessmentTypeOptions='+assessmentTypeOptions);
        System.debug('*****ParentPortalAssessment_Controller**filterAssessments**schoolLogoMap='+schoolLogoMap);
        //set cookie to current selected student
        Cookie cookie_sid = new Cookie('sid', selectedStudentId,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{cookie_sid});
        //make list of assessment report types
        List<String> selectedReportTypes =  new List<String>();
        for(PortalReportFilter.ReportTypeWrapper rt:assessmentTypeOptions){
            if(rt.selected){
                selectedReportTypes.add(rt.reportType);
            }
        }
        
        
        //fetch school name basis student selection
        if(selectedStudentId != null && selectedStudentId != '' && selectedStudentYear != null && selectedStudentYear != ''){
            
            schoolName = [Select c.Admissions_File__r.School__c, c.Admissions_File__r.Id, c.Admissions_File__c From Contact c where c.Id=:selectedStudentId].Admissions_File__r.School__c;
            System.debug('*****ParentPortalAssessment_Controller**filterAssessments**schoolName='+schoolName);
            studentName = [Select Name from Contact where Id=:selectedStudentId].Name;
            schoolLogoURL = schoolLogoMap.get(schoolName);
            System.debug('*****ParentPortalAssessment_Controller**filterAssessments**schoolLogoURL='+schoolLogoURL);
            //fetch assessments
            Set<Id> ownerIds =  new Set<Id>();
            Map<Id,User> userMap =  new Map<Id,User>();
            for(Assesment__c assessment:[Select a.Assessment_Display_User__c,a.CreatedById From Assesment__c a where a.RecordType.DeveloperName = 'Assessment_Record' AND a.Academic_Year__c=:selectedStudentYear AND a.Student__c=:selectedStudentId AND a.Assessment_Folder__r.Auto_Publish__c=true AND a.Assessment_Folder__r.Type__c IN:selectedReportTypes order by a.Assessment_Folder__r.Assessment_Date__c desc]){
                ownerIds.add(assessment.Assessment_Display_User__c);
            }
            for(User u:[Select u.Email_Copy__c, u.Title, u.Title_Copy__c, u.SmallPhotoUrl, u.School__c, u.Name, u.LastName, u.IsActive, u.Id, u.FullPhotoUrl, u.FirstName, u.Email, u.Division, u.Department, u.ContactId, u.Alias, u.AboutMe From User u  where u.Id IN:ownerIds]){
                userMap.put(u.Id,u);
            }
            for(Assesment__c assessment:[Select a.Assessment_Folder__r.Include_Target_Predicted_Grade__c, a.Target_Predicted_Grade__c, a.Effort_ATL_Output_Label__c, a.Assessment_Display_User__c, a.CreatedById, a.Assessment_Display_Name__c, a.Owner_Title__c ,a.Term__c, a.Student__c, a.Name, a.Mid_Term_Report__c, a.Group__r.Subject_Name__c, a.Group__r.Academic_Year__c, a.Group__r.Group_Type__c, a.Group__r.Name, a.Group__r.Group_Name__c, a.Group__c, a.Grade__c, a.Effort__c, a.Comment__c, a.Assessment_Name__c, a.Assessment_Folder__r.Assessment_Date_Copy__c, a.Assessment_Folder__r.External_Examination__c, a.Assessment_Folder__r.Mid_Term_Report__c,a.Assessment_Folder__r.Title__c , a.Assessment_Folder__r.Type__c, a.Assessment_Folder__r.Auto_Publish__c, a.Assessment_Folder__r.Group__c, a.Assessment_Folder__r.Assessment_Date__c, a.Assessment_Folder__r.CreatedDate, a.Assessment_Folder__r.Id, a.Assessment_Folder__c, a.Assessment_Date__c, a.Achievement__c From Assesment__c a where a.RecordType.DeveloperName = 'Assessment_Record' AND a.Academic_Year__c=:selectedStudentYear AND a.Student__c=:selectedStudentId AND a.Assessment_Folder__r.Auto_Publish__c = true AND a.Auto_Approve__c = true AND a.Assessment_Folder__r.Type__c IN:selectedReportTypes order by a.Order__c desc, a.Assessment_Folder__r.Assessment_Date__c desc]){
                boolean doProcess = false; 
                if(selectedStudentGroup != '-'){
                    //fetch group ids
                    set<Id> selectedGroupIds = groupNameIdMap.get(selectedStudentGroup); 
                    if(selectedGroupIds.contains(assessment.Group__c)){
                        doProcess =  true;
                    }
                }else{
                    doProcess =  true;
                }
                if(doProcess){
                    //check if term wrapper instance exists                 
                    TermWrapper tw = checkTermWrapper(assessment.Term__c, true);
                    if(userMap.get(assessment.Assessment_Display_User__c) != null){ 
                        String userinfo_Name =  userMap.get(assessment.Assessment_Display_User__c).Name;
                        String userinfo_Email =  userMap.get(assessment.Assessment_Display_User__c).Email_Copy__c;
                        String userinfo_Title;
                        if(assessment.Owner_Title__c != null && assessment.Owner_Title__c != ''){
                            userinfo_Title =  assessment.Owner_Title__c;
                        }else{
                            userinfo_Title =  userMap.get(assessment.Assessment_Display_User__c).Title_Copy__c;
                        }
                        String userinfo_ImageURL =  userMap.get(assessment.Assessment_Display_User__c).SmallPhotoUrl;
                        tw.assessments.add(new AssessmentWrapper(assessment,userinfo_Name,userinfo_Email,userinfo_Title,userinfo_ImageURL,tw.assessments.size()));
                    }else{
                        tw.assessments.add(new AssessmentWrapper(assessment,null,null,null,null,tw.assessments.size()));    
                    }
                }   
            } 
                
        
        }   
        return null;
    }
    
    //fucntion to populate student academic year optios 
    private void populateYearOptions(){
        Set<String> aYear =  new Set<String>();
        for(Registration__c r:[Select r.Group__r.Academic_Year__c, r.Group__c, r.Active__c From Registration__c r where r.Student__c =:selectedStudentId   order by r.Group__r.Academic_Year__c desc]){
            if(selectedStudentYear == null){
                selectedStudentYear = r.Group__r.Academic_Year__c;
            }
            aYear.add(r.Group__r.Academic_Year__c);
        }
        studentYearOptions =  new List<SelectOption>();
        for(String s:aYear){
            studentYearOptions.add(new SelectOption(s,s));
        }
        System.debug('*****ParentPortalAssessment_Controller**populateYearOptions**studentYearOptions='+studentYearOptions);
        System.debug('*****ParentPortalAssessment_Controller**populateYearOptions**selectedStudentYear='+selectedStudentYear);
    
    }   
    
    //function to fetch student group options for selected student
    private void populateGroupOptions(){ 
        groupNameIdMap = new Map<String,Set<Id>>();
        studentGroupsOptions =  new List<SelectOption>();
        studentGroupsOptions.add(new SelectOption('-', 'All'));
        for(Registration__c r:[Select r.Student__c, r.Id, r.Group__r.Subject_Name__c, r.Group__r.Academic_Year__c, r.Group__r.Group_Type__c, r.Group__r.Name, r.Group__r.Id, r.Group__c, r.Active__c From Registration__c r where r.Student__c =:selectedStudentId  AND r.Group__r.Academic_Year__c=:selectedStudentYear  order by r.Group__r.Group_Type__c , r.Group__r.Subject_Name__c desc]){
            if(r.Group__r.Group_Type__c.equalsIgnoreCase('tutor group') || r.Group__r.Group_Type__c.equalsIgnoreCase('school group')){
                //check if values are in map
                if(groupNameIdMap.containsKey(tutorSchoolGroup)){
                    groupNameIdMap.get(tutorSchoolGroup).add(r.Group__c);
                }else{
                    set<Id> gIds =  new set<Id>();
                    gIds.add(r.Group__c);
                    groupNameIdMap.put(tutorSchoolGroup,gIds);
                    studentGroupsOptions.add(new SelectOption(tutorSchoolGroup, tutorSchoolGroup));
                }
            }else if(r.Group__r.Group_Type__c.equalsIgnoreCase('subject') && r.Group__r.Subject_Name__c != null){
                if(groupNameIdMap.containsKey(r.Group__r.Subject_Name__c)){
                    groupNameIdMap.get(r.Group__r.Subject_Name__c).add(r.Group__c);
                }else{
                    set<Id> gIds =  new set<Id>();
                    gIds.add(r.Group__c);
                    groupNameIdMap.put(r.Group__r.Subject_Name__c,gIds);
                    studentGroupsOptions.add(new SelectOption(r.Group__r.Subject_Name__c, r.Group__r.Subject_Name__c));
                }
            }
        }
        selectedStudentGroup = '-';
        System.debug('*****ParentPortalAssessment_Controller**populateGroupOptions**studentGroupsOptions='+studentGroupsOptions);
        System.debug('*****ParentPortalAssessment_Controller**populateGroupOptions**selectedStudentGroup='+selectedStudentGroup);
        
    }
    
    public PageReference handleStudentChange(){
        populateYearOptions();
        populateGroupOptions();
        filterAssessments();
        return null; 
    }
    
    public PageReference handleYearChange(){
        populateGroupOptions();
        filterAssessments();
        return null;
    }
    
    public PageReference handleSubjectChange(){
        filterAssessments();
        return null;
    }
    
    public PageReference handleReportTypeChange(){
        filterAssessments();
        return null;
    }
    
    //function to print report
    public PageReference printAssessments(){
        PageReference pg  =  Page.PortalAssessmentPage_Print;
        pg.setRedirect(false);
        return pg;
    }
    
    private TermWrapper checkTermWrapper(String t, boolean mt){
        TermWrapper foundInstance;
        for(TermWrapper tw:termWrapperList){
            if(tw.term == t){
                foundInstance =  tw;
            }
        }
        if(foundInstance == null){
            foundInstance = new TermWrapper(t,mt,termWrapperList.size());
            termWrapperList.add(foundInstance);
        }
        
        return foundInstance;
    }
    
    public class TermWrapper{
        public String term{get;set;}
        public boolean isMidTerm{get;set;}
        public List<AssessmentWrapper> assessments {get;set;}
        public Integer index {get;set;}
        public TermWrapper(String t, boolean mt, integer i){
            term = t;
            isMidTerm = mt;
            assessments =  new List<AssessmentWrapper>();
            index = i+1;
        }
    }
    
    //wrapper class for group management
    public class AssessmentWrapper{
        public Assesment__c assessment {get;set;}
        public String groupName {get;set;}
        public String subjectName {get;set;}
        public boolean isTutorGroup {get;set;}
        public String userInfo_Name {get;set;}
        public String userInfo_Title {get;set;}
        public String userInfo_Email {get;set;}
        public String userInfo_PicURL {get;set;}
        public Integer index {get;set;}
        public Integer rt {get;set;}
        public boolean isEffortNumeric {get;set;}
        public AssessmentWrapper(Assesment__c a,String name,String email, String title, String pic, Integer i){
            assessment = a;
            index = i+1;
            userInfo_Name = name;
            userInfo_Title = title;
            userInfo_Email = email;
            userInfo_PicURL = pic;
            
            subjectName = a.Group__r.Subject_Name__c;  
            groupName = a.Assessment_Display_Name__c;
            /*if(a.Group__r.Group_Name__c == '' || a.Group__r.Group_Name__c == null){
                groupName = assessment.Assessment_Folder__r.Title__c;
            }else{
                groupName = a.Group__r.Group_Name__c + ' - '+assessment.Assessment_Folder__r.Title__c;
            }*/  
            if(a.Group__r.Group_Type__c == 'Tutor Group' || a.Group__r.Group_Type__c == 'School Group'){
                isTutorGroup =  true;
                //groupName = a.Group__r.Group_Name__c + ' - '+assessment.Assessment_Folder__r.Title__c;
            }else{
                isTutorGroup = false;
                //groupName = a.Group__r.Group_Name__c + ' - '+assessment.Assessment_Folder__r.Title__c;
            }
            String rType = assessment.Assessment_Folder__r.Type__c;
            if(rType.equalsIgnoreCase('Progress Report')){
                rt = 1;
            }else if(rType.equalsIgnoreCase('Assignment')){
                rt = 2;
            }else if(rType.equalsIgnoreCase('Examination')){
                rt = 3;
            }else if(rType.equalsIgnoreCase('Test')){
                rt = 4;
            }
            if(a.Effort__c != null && a.Effort__c.isNumeric()){
                isEffortNumeric = true;
            }else{
                isEffortNumeric = false;
            }               
                  
        }
    }
    
    
}