/***
    Author: Kunal 
    Created Date: 28 April 2013
    Desc: VF controller for PortaAttendancePage
***/
public class PortalAttendancePage_Controller extends PortalReportFilter{
	public String schoolName {get;set;}
    public Integer totalAbsent {get;set;}
    public Integer totalLate {get;set;}
    public Integer totalPartial {get;set;}
    public Integer totalUnauthorizedAbsence {get;set;}
    public Integer totalExternalActivity {get;set;}
    public List<AttendanceWrapper> attendanceWrapperList {get;set;}
	public boolean hasItems{get{boolean flag = false;if(attendanceWrapperList != null){if(attendanceWrapperList.size() > 0){flag = true;}}return flag;}}
    //constructor
    public  PortalAttendancePage_Controller(){
        
    	
    }
    
    //function to search attendances
	public PageReference filterAttendances(){ 
		createTabClickEvent('attendance');
		attendanceWrapperList =  new List<AttendanceWrapper>();
		totalAbsent = 0;
    	totalLate = 0;
    	totalPartial = 0;
    	totalUnauthorizedAbsence = 0;
    	totalExternalActivity = 0;
		System.debug('*****PortalAttendancePage_Controller**filterAttendances**selectedStudentId='+selectedStudentId);
		System.debug('*****PortalAttendancePage_Controller**filterAttendances**selectedAcademicYear='+selectedAcademicYear);
		System.debug('*****PortalAttendancePage_Controller**filterAttendances**attendanceTypeOptions='+attendanceTypeOptions);
		//set cookie to current selected student
		Cookie cookie_sid = new Cookie('sid', selectedStudentId,null,-1,false);
		ApexPages.currentPage().setCookies(new Cookie[]{cookie_sid});
		//make list of assessment report types
		List<String> selectedReportTypes =  new List<String>();
		for(PortalReportFilter.ReportTypeWrapper rt:attendanceTypeOptions){
			if(rt.selected){
				if(rt.reportType == 'Absent' || rt.reportType == 'Authorised Absence' || rt.reportType == 'Absences' ){
					selectedReportTypes.add('Absent');
					selectedReportTypes.add('Authorised Absence');
					selectedReportTypes.add('Unauthorised Absence');	
				}else if(rt.reportType == 'Late' || rt.reportType == 'Lates'){
					selectedReportTypes.add('Late');
				}else if(rt.reportType == 'Partials' || rt.reportType == 'Partial'){
					selectedReportTypes.add('Partial');
				}else if(rt.reportType == 'External Activity' || rt.reportType == 'External Activities'){
					selectedReportTypes.add('External Activity');
				}else{
					selectedReportTypes.add(rt.reportType);
				}
			}
		}
		//System.debug('*****ParentPortalAttendance_Controller**filterAttendances**events'+Database.query('Select Id from Event where WhoId=\'003c000000LhmmoAAB\''));
		//fetch school name basis student selection
		if(selectedStudentId != null && selectedStudentId != '' && selectedAcademicYear != null && selectedAcademicYear != ''){
			//fetch are active registartion against tutor group for selected student
			/*set<Id> tutorGroupIds =  new set<Id>();
			for(Registration__c r:[Select Id, Group__c from Registration__c where Group__r.Group_Type__c = 'Tutor Group' AND Student__c=:selectedStudentId AND Group__r.Academic_Year__c=:selectedAcademicYear]){
				tutorGroupIds.add(r.Group__c);
			}*/
			schoolName = [Select c.Admissions_File__r.School__c, c.Admissions_File__r.Id, c.Admissions_File__c From Contact c where c.Id=:selectedStudentId].Admissions_File__r.School__c;
			//fetch attendances
			//for(Event e: [Select e.Display_Name__c, e.Display_Date__c, e.WhoId, e.WhatId, e.What.Name, e.Description,  e.Subject, e.RecordType.DeveloperName, e.RecordTypeId, e.Attendance_Type__c, e.ActivityDate, e.Academic_Year__c From Event e where e.RecordType.DeveloperName='Attendance' AND e.WhoId=:selectedStudentId AND e.Academic_Year__c=:selectedAcademicYear AND e.Subject IN:selectedReportTypes AND e.WhatId IN:tutorGroupIds AND e.IsDeleted =  false AND e.ActivityDate <=:date.today() order by e.ActivityDate desc ALL ROWS]){
			for(Event e: [Select e.Display_Name__c, e.Display_Date__c, e.WhoId, e.WhatId, e.What.Name, e.Description,  e.Subject, e.RecordType.DeveloperName, e.RecordTypeId, e.Attendance_Type__c, e.ActivityDate, e.Academic_Year__c From Event e where e.RecordType.DeveloperName='Attendance' AND e.WhoId=:selectedStudentId AND e.Academic_Year__c=:selectedAcademicYear AND e.Subject IN:selectedReportTypes AND e.Is_Tutor_Group_Attendance__c = true AND e.IsDeleted =  false AND e.ActivityDate <=:date.today() order by e.ActivityDate desc ALL ROWS]){
				if(e.Subject.equalsIgnoreCase('Absent') || e.Subject.equalsIgnoreCase('Authorised Absence') || e.Subject.equalsIgnoreCase('Absences') ){
					totalAbsent++;
				}else if(e.Subject.equalsIgnoreCase('Late')){
					totalLate++;
				}else if(e.Subject.equalsIgnoreCase('Partial')){
					totalPartial++;
				}else if(e.Subject.equalsIgnoreCase('Unauthorised Absence')){
					totalUnauthorizedAbsence++;
				}else if(e.Subject.equalsIgnoreCase('External Activity')){
					totalExternalActivity++;
				}
				attendanceWrapperList.add(new AttendanceWrapper(e.What.Name, e.Subject, e.ActivityDate, e.Description, e.Display_Date__c, e.Display_Name__c));
			}
			
		}	
		return null;
	}
	 
	//function to search attendances
	public PageReference reset(){
		PageReference pg = Page.PortalAttendancePage;
		pg.setRedirect(true);
		return pg;
	}
    
    public class AttendanceWrapper{
    	public String groupName{get;set;}
    	public String status {get;set;}
    	//public Task t{get;set;}
    	//public Date attendanceDate {get;set;}
    	public String dateString {get;set;}
    	public String comments {get;set;}
    	public Integer rt {get;set;}
    	public string displayName {get;set;}
    	public AttendanceWrapper(String gn, String s, Date d, String c, string displayDate, string dName){
    		groupName = gn;
    		status =  s;
    		displayName = dName;
    		//dateString = d.format();
    		dateString = displayDate;
    		comments = c;
    		if(s.equalsIgnoreCase('Absent') || s.equalsIgnoreCase('Unauthorised Absence') || s.equalsIgnoreCase('Authorised Absence')){
    			rt = 4;
    		}else if(s.equalsIgnoreCase('Late')){
    			rt = 3;
    		}else if(s.equalsIgnoreCase('Partial')){
    			rt = 1;
    		}else if(s.equalsIgnoreCase('External Activity')){
    			rt = 2;
    		}
    		if(comments == null || comments == ''){
    			comments = 'No comments available.';
    		}
    	}
    } 
    
    
	
}