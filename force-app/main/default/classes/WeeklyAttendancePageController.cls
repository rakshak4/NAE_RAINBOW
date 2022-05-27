/***
	Author: Kunal Sharma
	Created Date: 06 Feb 2013
	Description: VF page controller for WeeklyAttendancePageController
	Audit Date:
	Audited By: 
	
	COMMENTS:
	

***/
public class WeeklyAttendancePageController {
	
	private String groupId;
	public Group__c groupObj {get;set;}
  	private Id attendanceEventRTId;
    private Map<Id,String> studentMap;
    private List<Id> studentIdList;
    
    private Map<String,Event> attendanceDataMap;
    public List<StudentAttendanceRow> rowList {get;set;}
    //variable declaration
    public List<SelectOption> attendanceTypes {get;set;}
    public DateTime weekStartDate{get;set;}
    public DateTime weekEndDate{get;set;}
    public Integer iWeek {get;set;}
    public List<ColumnHeader> colHeaders {get;set;}
    public Id groupAttendanceReportId {get;set;}
   
    public WeeklyAttendancePageController(ApexPages.StandardController controller) {
		studentMap = new Map<Id,String>();
		studentIdList =  new List<Id>();
		attendanceTypes = new List<SelectOption>();
		attendanceTypes.add(new SelectOption('-','-'));
		attendanceTypes.add(new SelectOption('Present','Present'));
		attendanceTypes.add(new SelectOption('Late','Late'));
		attendanceTypes.add(new SelectOption('Absent','Absent'));
		//attendance data map: key is student id -  event id
    	attendanceDataMap =  new Map<String,Event>();
    	rowList = new List<StudentAttendanceRow>();
		iWeek = 0;        
        String sWeek = System.currentPageReference().getParameters().get('w');
        groupId = controller.getId();
        groupObj = [Select Name from Group__c where Id=:groupId];
        if(sWeek != null){
            try{
                iWeek = Integer.valueOf(sWeek);
            }catch(Exception e){
                throw e;
            }
        } 
        initialize();
        
    }
	
	//helper function to initialize data
    public void initialize(){
        //fetch id of attendance record type
        attendanceEventRTId =  [Select Id from RecordType where SObjectType='Event' AND DeveloperName='Attendance' limit 1].Id;
        //fetch id of group attendance report
        try{
        	groupAttendanceReportId = [Select Id,Name,DeveloperName from Report where DeveloperName = 'Group_Attendance_Report'].Id;
        }catch(Exception e){
        	//do nothing
        }
        populateWeekStartEndDate();
        populateColumnHeader();
    	fetchData(); 
    	initializeRows();   
    }
    
    
    //populate week start/end date time
    private void populateWeekStartEndDate(){
        //week start day should be sunday
        Time t = DateTime.now().time();
        weekStartDate = DateTime.newInstance(Date.today().toStartOfWeek(),t);  
        /*
        //if week starts from monday , move it to sunday
        if(weekStartDate.format('EEE').equalsIgnoreCase('mon')){
            weekStartDate = weekStartDate.addDays(-1);
        }
        //if week starts from sat , move it to sunday
        if(weekStartDate.format('EEE').equalsIgnoreCase('sat')){
            weekStartDate = weekStartDate.addDays(1);
        }
        */
        weekStartDate =  weekStartDate.addDays(iWeek*7);
        weekEndDate = weekStartDate.addDays(6);
    }
    
    //populates column headers from weekstartDate to weekEndDate
    private void populateColumnHeader(){
        system.debug('****populateColumnHeader*****weekStartDate***='+weekStartDate);
        colHeaders =  new List<ColumnHeader>();
        for(integer  i = 0 ; i < 7 ; i++){
            DateTime tempDate = weekStartDate.addDays(i);            
            //add to column header
            colHeaders.add(new ColumnHeader(tempDate.format('EEEEEEEE'),tempDate.date(),colHeaders.size()));
        }
        System.debug('****populateColumnHeader()*****colHeaders***********'+colHeaders);   
    }
    
    
    
    //fetches event data for selected group for provided week
    private void fetchData(){
    	
 		//fetch students in the selected group
 		for(Registration__c registration:[Select a.Student__r.Student_Full_Name__c, a.Student__r.Name, a.Student__r.Id, a.Student__c,  a.Id, a.Group__c From Registration__c a where a.Group__c =:groupId AND  a.Active__c = true order by a.Student__r.Student_Age__c desc] ){
 			  
 			if(registration.Student__c != null){
 				studentMap.put(registration.Student__r.Id,registration.Student__r.Student_Full_Name__c);
 				studentIdList.add(registration.Student__r.Id);
 			}
 		}
 		//fetch all attendance events for fetched students 
 		for(Event e:[Select e.WhoId, e.WhatId, e.Attendance_Type__c, e.Description, e.Subject, e.StartDateTime, e.Id, e.ActivityDateTime, e.ActivityDate From Event e where e.WhatId=:groupId AND e.WhoId IN:studentIdList AND e.RecordTypeId=:attendanceEventRTId AND e.ActivityDate >=: weekStartDate.date() AND e.ActivityDate <=: weekEndDate.date() order by e.ActivityDate, e.Attendance_Type__c]){
 			attendanceDataMap.put(e.WhoId+'-'+e.Id,e);
 		}
 		System.debug('***WeeklyAttendancePageController***fetchData***attendanceDataMap='+attendanceDataMap);
 		System.debug('***WeeklyAttendancePageController***fetchData***attendanceDataMap size='+attendanceDataMap.size());	
    }
    
    
    //populate weeks data
    private void initializeRows(){
    	//create contact map
    	Map<Id,Contact> contactMap = new Map<Id,Contact>([Select Id,Half_Day__c,Nickname__c,Primary_Parent__c,Primary_Phone__c from Contact where Id IN:studentIdList]);
 		//for each student (sorted by name) .. check for attendance event 
 		for(Id studentId:studentIdList){
 			StudentAttendanceRow row = new StudentAttendanceRow(rowList.size());
 			row.studentId = studentId;
 			row.studentName =  studentMap.get(studentId);
 			System.debug('***WeeklyAttendancePageController***initializeRows***row.studentName='+row.studentName);
 			if(contactMap.get(studentId) != null){
 				row.halfDay = contactMap.get(studentId).Half_Day__c;
 				row.primaryParent = contactMap.get(studentId).Primary_Parent__c;
 				row.primaryPhone = contactMap.get(studentId).Primary_Phone__c;
 				row.nickname = contactMap.get(studentId).Nickname__c;
 			}
 			//start populating dates in column data
 			Date startDate = weekStartDate.date();
 			for(Integer i=0; i<=6 ; i++){
 				Date eventDate = startDate.adddays(i);
 				System.debug('***WeeklyAttendancePageController***initializeRows***eventDate='+eventDate);
 				//fetch existing event against student for event date
 				List<Event> foundEventList = fetchStudentEvent(row.studentId,eventDate);
 				System.debug('***WeeklyAttendancePageController***initializeRows***foundEventList='+foundEventList);
 				if(foundEventList == null){ // no attendance event is found 
 					row.attendanceList.add(new DayAttendanceWrapper(eventDate,row.attendanceList.size()));
 				}else if(foundEventList.size() == 1){
 					row.attendanceList.add(new DayAttendanceWrapper(foundEventList[0],row.attendanceList.size()));
 				}else if(foundEventList.size() == 2){
 					row.attendanceList.add(new DayAttendanceWrapper(foundEventList[0],foundEventList[1],row.attendanceList.size()));
 					
 				}
 			}
 			rowList.add(row);
 		}
    }
    
    private List<Event> fetchStudentEvent(Id sId, Date eDate){
    	List<Event> foundEventList  =  new List<Event>() ;
    	System.debug('***WeeklyAttendancePageController***fetchStudentEvent***sId='+sId);
    	System.debug('***WeeklyAttendancePageController***fetchStudentEvent***eDate='+eDate);
    	//iterate whole student  map to find event 
    	for(String key:attendanceDataMap.keySet()){
    		System.debug('***WeeklyAttendancePageController***fetchStudentEvent***key='+key);
    		//check if key for respective student
    		if(key.startsWith(sId)){
    			//fetch corresponding event date
    			System.debug('***WeeklyAttendancePageController***fetchStudentEvent***StartDateTime.date()='+attendanceDataMap.get(key).StartDateTime.date());
    			if(attendanceDataMap.get(key).StartDateTime.date() == eDate){
    				foundEventList.add(attendanceDataMap.get(key));
    				System.debug('***WeeklyAttendancePageController***fetchStudentEvent***foundEventList='+foundEventList);
    			}
    		}
    	}
    	if(foundEventList.size() == 0){
    		foundEventList = null;
    	}else if(foundEventList.size() == 2){
    		if(foundEventList[1].Attendance_Type__c == 'First'){
    			List<Event> newFoundListEvent = new List<Event>();
    			newFoundListEvent.add(foundEventList[1]);
    			newFoundListEvent.add(foundEventList[0]);
    			foundEventList = newFoundListEvent;
    		}
    	}
    	return foundEventList;
    }
    
    //for generating two rows
    public PageReference populateSecRow(){ 
    	//fetch row index
    	String rIndex =  System.currentPageReference().getParameters().get('rindex');
    	if(rIndex !=  null){
    		try{
    			Integer i = Integer.valueOf(rIndex);
    			//itegerate all rows to populate 2nd row
    			 
    			for(StudentAttendanceRow row: rowList){
    				for(DayAttendanceWrapper att:row.attendanceList){
    					if(att.index ==  i){
    						if(att.secondAttendance == null){
    							att.secondAttendance  = new ColumnData(att.firstAttendance.attendanceDate);
    						}
    					}
    				}
    			}
    		}catch(Exception e){
    			throw e;
    		}
    	}
    	system.currentPageReference().getParameters().put('stab','attendancemanage');
    	return null;
    }
    
    //for removing two rows
    public PageReference unpopulateSecRow(){
    	//fetch row index
    	String rIndex =  System.currentPageReference().getParameters().get('rindex');
    	if(rIndex !=  null){
    		try{
    			Integer i = Integer.valueOf(rIndex);
    			//itegerate all rows to populate 2nd row
    			List<Event> toBeDeleted =  new List<Event>(); 
    			for(StudentAttendanceRow row: rowList){
    				for(DayAttendanceWrapper att:row.attendanceList){
    					if(att.index ==  i){
    						if(att.secondAttendance != null){
    							if(att.secondAttendance.attendanceEvent.Id != null){
    								toBeDeleted.add(att.secondAttendance.attendanceEvent);
    							}
    						}
    						att.secondAttendance = null;
    					}
    				}
    			}
    			if(toBeDeleted.size() > 0){
    				delete toBeDeleted;
    			}
    		}catch(Exception e){
    			throw e;
    		}
    	}
    	system.currentPageReference().getParameters().put('stab','attendancemanage');
    	return null;
    }
    
    //saving attendances
    public PageReference performSave(){
    	try{
    		List<Event> attendanceEventList = new List<Event>();
			//iterate all rows 
			System.debug('*****WeeklyAttendancePageController***performSave***rowList='+rowList);
			for(StudentAttendanceRow row: rowList){
				//iterate all
				for(DayAttendanceWrapper att:row.attendanceList){
					if(att.firstAttendance != null){
						if(att.firstAttendance.attendanceEvent.Subject != '-'){
							att.firstAttendance.attendanceEvent.RecordTypeId = attendanceEventRTId;
							att.firstAttendance.attendanceEvent.WhatId =  groupId;
							att.firstAttendance.attendanceEvent.WhoId =  row.studentId;
							att.firstAttendance.attendanceEvent.Attendance_Type__c =  'First';
							//fields addded later
							att.firstAttendance.attendanceEvent.Primary_Parent__c = row.primaryParent;
							att.firstAttendance.attendanceEvent.Primary_Phone__c = row.primaryPhone;
							att.firstAttendance.attendanceEvent.Half_Day__c = row.halfDay;
							att.firstAttendance.attendanceEvent.Nickname__c = row.nickname;
							attendanceEventList.add(att.firstAttendance.attendanceEvent);
						}
					}
					
					if(att.secondAttendance != null){
						if(att.secondAttendance.attendanceEvent.Subject != '-'){
							att.secondAttendance.attendanceEvent.RecordTypeId = attendanceEventRTId;
							att.secondAttendance.attendanceEvent.WhatId =  groupId;
							att.secondAttendance.attendanceEvent.WhoId =  row.studentId;
							att.secondAttendance.attendanceEvent.Attendance_Type__c =  'Second';
							//fields addded later
							att.secondAttendance.attendanceEvent.Primary_Parent__c = row.primaryParent;
							att.secondAttendance.attendanceEvent.Primary_Phone__c = row.primaryPhone;
							att.secondAttendance.attendanceEvent.Half_Day__c = row.halfDay;
							att.secondAttendance.attendanceEvent.Nickname__c = row.nickname;
							attendanceEventList.add(att.secondAttendance.attendanceEvent);
						}
					}
					
				}
								
			}
			if(attendanceEventList.size() > 0){
				upsert attendanceEventList;
			}
			//display pagemessage
			
			ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Thank you for submitting attendances. All attendances are recorded successfully.');
			ApexPages.addMessage(successMessage);
			System.debug('*****WeeklyAttendancePageController***performSave***successMessage='+successMessage);
		}catch(Exception e){
			//display pagemessage
			ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Ooops ..Failed to record attandances. Please contact admin@britishschools.co.uk and provide follwing error message: '+e.getMessage());
			ApexPages.addMessage(errorMessage);
			//throw e;
		}
		system.currentPageReference().getParameters().put('stab','attendancemanage');
    	return null;
    }
    
    
    //resetting page
    public PageReference reset(){
    	PageReference pg  = Page.Tabbed_Group_Detail ; 
    	pg.getParameters().put('id',groupId);
    	pg.getParameters().put('stab','attendance');
    	pg.setRedirect(true);
        return pg;
    }
    
    //back to group 
    public PageReference back(){
    	PageReference pg  = new PageReference('/'+groupId) ; 
        return pg;
    }
    
    public boolean getHasPreviousWeek(){
        boolean flag =  false;
        if(iWeek > -4){
            flag = true;
        }
        return flag;
    }
    
    //page reference functions
    //previous week
    public PageReference previousWeek(){
        PageReference pg = Page.Tabbed_Group_Detail;
        pg.getParameters().put('w',''+(iWeek-1));
    	pg.getParameters().put('stab','attendance');
        pg.getParameters().put('id',groupId);
        pg.setRedirect(true);
        return pg;
        
    }
    
    
    //next week
    public PageReference nextWeek(){
        PageReference pg = Page.Tabbed_Group_Detail;
        pg.getParameters().put('w',''+(iWeek+1));
        pg.getParameters().put('stab','attendance');
        pg.getParameters().put('id',groupId);
        pg.setRedirect(true);
        return pg;
    }
    //current week
    public PageReference currentWeek(){
        PageReference pg = Page.Tabbed_Group_Detail;
        pg.getParameters().put('w','0');
        pg.getParameters().put('stab','attendance');
        pg.getParameters().put('id',groupId);
        pg.setRedirect(true);
        return pg;
    }
    
    //wrapper classes
    //for table header
    public class ColumnHeader{
        public String day{get;set;}
        public Date timesheetdate{get;set;}
        public Integer index {get;set;}
        public boolean isToday {get;set;}
        public String dateString{
            get{
                String temp = '';
                if(timesheetdate != null){
                    //temp = timesheetdate.day() + ' '+monthMap.get(timesheetdate.month());
                    temp = monthMap.get(timesheetdate.month())+' '+timesheetdate.day();
                }
                return temp;
            }set;
        
        }
        private Map<Integer,String> monthMap ;  
        //constructor
        public ColumnHeader(String d,Date tDate, Integer i){
            day = d;
            index =  i;
            isToday =  false;
            timesheetdate = tDate;
            if(tDate ==  Date.today()){
            	isToday =  true;
            }
            monthMap = new Map<Integer,String>();
            monthMap.put(1,'Jan');
            monthMap.put(2,'Feb');
            monthMap.put(3,'Mar');
            monthMap.put(4,'Apr');
            monthMap.put(5,'May');
            monthMap.put(6,'Jun');
            monthMap.put(7,'Jul');
            monthMap.put(8,'Aug');
            monthMap.put(9,'Sep');
            monthMap.put(10,'Oct');
            monthMap.put(11,'Nov');
            monthMap.put(12,'Dec');
        }   
    }
	//attendance row
	public class StudentAttendanceRow{
		public String studentId {get;set;}
		public String studentName {get;set;}
		public String halfDay {get;set;}
		public String primaryParent {get;set;}
		public String primaryPhone {get;set;}
		public String nickname {get;set;}
		public Integer index {get;set;}
		public List<DayAttendanceWrapper> attendanceList {get;set;}
		public StudentAttendanceRow(Integer i ){
			attendanceList = new List<DayAttendanceWrapper>();
			index = i;
		}
	}
	
	//for storing data 
    public class ColumnData{
 		public Event attendanceEvent{get;set;}
 		public Date attendanceDate {get;set;}
 		public boolean isPresent{get;set;}
 		public boolean isToday{get;set;}
 		public boolean isLate{get;set;} 
 		public String description{get;set;}
 		
 		public ColumnData(Date eDate){
 			isToday =  false;
 			Time t = DateTime.now().time();
 			attendanceDate = eDate;
 			attendanceEvent =  new Event();
 			attendanceEvent.ActivityDate =  eDate;
 			attendanceEvent.StartDateTime =  DateTime.newInstance(eDate,t);
 			attendanceEvent.EndDateTime =  DateTime.newInstance(eDate,t);
 			attendanceEvent.IsVisibleInSelfService =  true; 
 			if(eDate == Date.today()){
 				attendanceEvent.Subject = 'Present';
 				isPresent =  true;
 				isToday =  true;
 			}
 			
 			isLate =  false;
 		}
 		
 		public ColumnData(Event e){
 			isToday =  false;
 			attendanceEvent =  e;
 			isPresent =  false;
 			
 			isLate =  false;
 			if(e.Subject != null){
	 			if(e.Subject.equalsIgnoreCase('present')){
	 				isPresent =  true;
	 			}else if(e.Subject.equalsIgnoreCase('late')){
	 				isLate =  true;
	 				isPresent =  true;
	 			}else{
	 				isPresent =  false;
	 				isLate =  false;
	 			}
 			}else{
 					isPresent =  false;
	 				isLate =  false;
 			}
 			attendanceDate =  e.StartDateTime.date();
 			if(attendanceDate ==  Date.today()){
 				isToday =  true;
 			}
 			attendanceEvent.IsVisibleInSelfService =  true; 
 			description =  e.Description;
 		} 	
    }
    
    public class DayAttendanceWrapper{
    	public ColumnData firstAttendance {get;set;}
    	public ColumnData secondAttendance {get;set;}
    	public Integer index {get;set;}
    	
    	
    	public DayAttendanceWrapper(Date d, Integer i){
    		firstAttendance =  new ColumnData(d);
    		index = i;
    	}
    	public DayAttendanceWrapper(Event e, Integer i){
    		index = i;
    		firstAttendance =  new ColumnData(e);
    		firstAttendance.attendanceEvent.Attendance_Type__c = 'First';
    	}
    	public DayAttendanceWrapper(Event e1,Event e2, Integer i){
    		if(e1.Attendance_Type__c == 'First'){
    			firstAttendance =  new ColumnData(e1);
    			secondAttendance =  new ColumnData(e2);
    		}else{
    			firstAttendance =  new ColumnData(e2);
    			secondAttendance =  new ColumnData(e1);
    		}
    		index = i;
    	}
    }
    
}