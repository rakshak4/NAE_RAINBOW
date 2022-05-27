/***
    Author: Kunal Sharma
    Created Date: 04 Sep 2013
    Description: VF page controller for DailyAttendancePageController 
    Audit Date:
    Audited By: 
    
    COMMENTS: 
    

***/
public class DailyAttendancePageController {  
    
    private String groupId;
    public Group__c groupObj {get;set;}
    private Id attendanceEventRTId;
    private Map<Id,String> studentMap;
    private List<Id> studentIdList;
    private Map<String,Event> attendanceDataMap;
    //variable declaration
    public List<SelectOption> attendanceTypes {get;set;}
    //task object for date
    public Task dateTask {get;set;}
    //wrapper list
    public List<AttendanceWrapper> dataList {get;set;}
    private Id assignedToId {get;set;}
    //constructor
    public DailyAttendancePageController(ApexPages.StandardController controller) {
        System.debug('***DailyAttendancePageController**datetime='+Datetime.now());
        System.debug('***DailyAttendancePageController**date='+Date.today());
        System.debug('***DailyAttendancePageController**time='+DateTime.now().time());
        groupId = controller.getId();
        //for(User u:[SELECT Id from User where Name = 'Group Administrator' limit 1]){
            assignedToId = '0056F000008tfhZ';
        //}
        initialize();
    }
    
    //helper function to initialize data
    private void initialize(){
        dateTask =  new Task();
        dateTask.ActivityDate = Date.today();
        //get group name
        groupObj = [Select Name from Group__c where Id=:groupId];
        //fetch id of attendance record type
        attendanceEventRTId =  [Select Id from RecordType where SObjectType='Event' AND DeveloperName='Attendance' limit 1].Id;     
        //populate attendance types
        attendanceTypes = new List<SelectOption>();
        attendanceTypes.add(new SelectOption('','-'));
        attendanceTypes.add(new SelectOption('Present','Present'));
        attendanceTypes.add(new SelectOption('Late','Late'));
        attendanceTypes.add(new SelectOption('Authorised Absence','Authorised Absence'));
        attendanceTypes.add(new SelectOption('Unauthorised Absence','Unauthorised Absence'));
        attendanceTypes.add(new SelectOption('Partial','Partial'));
        attendanceTypes.add(new SelectOption('External Activity','External Activity'));
        //fetch existing events
        fetchData();
        //populate attendance wrapper
        populateWrapper();
    }
    
    //fetches event data for selected group for provided week
    private void fetchData(){
        studentMap =  new Map<Id,String>();
        studentIdList =  new List<Id>();
        attendanceDataMap = new Map<String,Event>(); 
        //fetch students in the selected group
        for(Registration__c registration:[Select a.Student__r.Student_Name__c, a.Student__r.Student_Full_Name__c, a.Student__r.Name, a.Student__r.Id, a.Student__c,  a.Id, a.Group__c From Registration__c a where a.Group__c =:groupId AND  (a.Active__c = true OR a.Student__r.Starting_Date_from_student__c >:date.today()) AND a.Student__r.Starting_Date_from_student__c <=:dateTask.ActivityDate  order by a.Student__r.Student_Name__c asc] ){
              
            if(registration.Student__c != null){
                studentMap.put(registration.Student__r.Id,registration.Student__r.Student_Name__c);
                studentIdList.add(registration.Student__r.Id);
            }
        }
        //fetch all attendance events for fetched students 
        DateTime previousDayDateTime =  DateTime.now().addDays(-1);
        DateTime nextDayDateTime =  DateTime.now().addDays(1);
        String formattedDate =  dateTask.ActivityDate.format();
        //for(Event e:[Select e.WhoId, e.WhatId, e.Attendance_Type__c, e.Description, e.Subject, e.StartDateTime, e.Id, e.ActivityDateTime, e.ActivityDate From Event e where e.WhatId=:groupId AND e.WhoId IN:studentIdList AND e.RecordTypeId=:attendanceEventRTId AND e.StartDateTime >=:previousDayDateTime AND e.StartDateTime <=:nextDayDateTime order by e.ActivityDate, e.Attendance_Type__c]){
         for(Event e:[Select e.Student_Name__c, e.WhoId, e.WhatId, e.Attendance_Type__c, e.Description, e.Subject, e.StartDateTime, e.Id, e.ActivityDateTime, e.ActivityDate From Event e where e.WhatId=:groupId AND e.WhoId IN:studentIdList AND e.RecordTypeId=:attendanceEventRTId AND ((e.Attendance_Formatted_Date__c=:formattedDate) OR(e.Attendance_Formatted_Date__c = null AND e.ActivityDate =:dateTask.ActivityDate)) order by e.ActivityDate, e.Attendance_Type__c]){
            //if(dateTask.ActivityDate == e.StartDateTime.date()){
                attendanceDataMap.put(e.WhoId+'-'+e.Id,e);
            //}
        }
        System.debug('***DailyAttendancePageController***fetchData***attendanceDataMap='+attendanceDataMap);
        System.debug('***DailyAttendancePageController***fetchData***attendanceDataMap size='+attendanceDataMap.size());   
    }
    
    private void populateWrapper(){
        //create contact map
        Map<Id,Contact> contactMap = new Map<Id,Contact>([Select Student_Name__c, Id,Half_Day__c,Nickname__c,Primary_Parent__c,Primary_Phone__c from Contact where Id IN:studentIdList]);
        dataList =  new List<AttendanceWrapper>();
        for(Id studentId:studentIdList){
            String studentName = studentMap.get(studentId);
            //check for existing event
            Event studentAttendanceEvent ;
            for(String key:attendanceDataMap.keySet()){
                if(key.startsWith(studentId)){
                    studentAttendanceEvent = attendanceDataMap.get(key);
                }
            }
            //initialize event in case no attendance event if found
            if(studentAttendanceEvent == null){
                studentAttendanceEvent =  new Event();
                studentAttendanceEvent.RecordTypeId = attendanceEventRTId;
                studentAttendanceEvent.IsVisibleInSelfService = true;
                studentAttendanceEvent.WhoId = studentId;
                studentAttendanceEvent.WhatId = groupId;
                if(contactMap.get(studentId) != null){
                    if(assignedToId != null){
                        studentAttendanceEvent.OwnerId = assignedToId; 
                    }
                    studentAttendanceEvent.Primary_Parent__c = contactMap.get(studentId).Primary_Parent__c;
                    studentAttendanceEvent.Primary_Phone__c = contactMap.get(studentId).Primary_Phone__c;
                    studentAttendanceEvent.Half_Day__c = contactMap.get(studentId).Half_Day__c;
                    studentAttendanceEvent.Nickname__c = contactMap.get(studentId).Nickname__c;
                    studentAttendanceEvent.ActivityDate = dateTask.ActivityDate;
                    Time t = DateTime.now().time();
                    studentAttendanceEvent.StartDateTime = DateTime.newInstance(dateTask.ActivityDate,t);
                    studentAttendanceEvent.EndDateTime = DateTime.newInstance(dateTask.ActivityDate,t);
                    studentAttendanceEvent.Attendance_Formatted_Date__c = dateTask.ActivityDate.format();
                    studentAttendanceEvent.Student_Name__c = contactMap.get(studentId).Student_Name__c;
                    if(dateTask.ActivityDate == Date.today()){
                        studentAttendanceEvent.Subject = 'Present';
                    }  
                }
            }
            
            dataList.add(new AttendanceWrapper(studentId,studentName,studentAttendanceEvent));
            
        } 
    }
    
    public PageReference fetchAttandences(){
        //fetch existing events
        fetchData();
        //populate attendance wrapper
        populateWrapper();
        return null;
    }
    
    public PageReference saveAttandences(){
        try{
            List<Event> attendances = new List<Event>();
            List<Event> toBeDeleted = new List<Event>();
            Map<Id,Event> existingAttendancesMap =  new Map<Id,Event>(); //key=contact id
            String formattedDate =  dateTask.ActivityDate.format();
            for(Event e:[Select e.WhoId, e.WhatId, e.Attendance_Type__c, e.Description, e.Subject, e.StartDateTime, e.Id, e.ActivityDateTime, e.ActivityDate From Event e where e.WhatId=:groupId AND e.WhoId IN:studentIdList AND e.RecordTypeId=:attendanceEventRTId AND ((e.Attendance_Formatted_Date__c=:formattedDate) OR(e.Attendance_Formatted_Date__c = null AND e.ActivityDate =:dateTask.ActivityDate)) order by e.ActivityDate, e.Attendance_Type__c]){
                existingAttendancesMap.put(e.WhoId,e);
            }
            System.debug('***DailyAttendancePageController***saveAttandences***existingAttendancesMap='+existingAttendancesMap);
            for(AttendanceWrapper w:dataList){
                if(w.attendanceEvent != null){
                    if(w.attendanceEvent.Subject != null && w.attendanceEvent.Subject != ''){
                        //check if event already is craeted
                        if(existingAttendancesMap.keySet().contains(w.attendanceEvent.WhoId)){
                            existingAttendancesMap.get(w.attendanceEvent.WhoId).Subject = w.attendanceEvent.Subject;
                            existingAttendancesMap.get(w.attendanceEvent.WhoId).Description = w.attendanceEvent.Description;
                            System.debug('***DailyAttendancePageController***saveAttandences***existing attendance='+existingAttendancesMap.get(w.attendanceEvent.WhoId));
                            attendances.add(existingAttendancesMap.get(w.attendanceEvent.WhoId));
                        }else{
                            System.debug('***DailyAttendancePageController***saveAttandences***new attendance='+w.attendanceEvent);
                            Event e = new Event();
                            e.RecordTypeId = w.attendanceEvent.RecordTypeId;
                            e.WhoId = w.attendanceEvent.WhoId;
                            e.WhatId = w.attendanceEvent.WhatId;
                            e.StartDateTime = w.attendanceEvent.StartDateTime;
                            e.EndDateTime = w.attendanceEvent.EndDateTime;
                            e.Subject = w.attendanceEvent.Subject;
                            e.ActivityDate = w.attendanceEvent.ActivityDate;
                            e.Attendance_Formatted_Date__c = w.attendanceEvent.Attendance_Formatted_Date__c;
                            e.Primary_Parent__c = w.attendanceEvent.Primary_Parent__c;
                            e.Primary_Phone__c = w.attendanceEvent.Primary_Phone__c;
                            e.Half_Day__c = w.attendanceEvent.Half_Day__c;
                            e.Nickname__c = w.attendanceEvent.Nickname__c;
                            e.OwnerId = w.attendanceEvent.OwnerId;
                            e.IsVisibleInSelfService = true;
                            e.Description  = w.attendanceEvent.Description;
                            e.Student_Name__c = w.attendanceEvent.Student_Name__c;
                            w.attendanceEvent = e;
                            attendances.add(e);
                            
                        }
                    }else if((w.attendanceEvent.Subject == null || w.attendanceEvent.Subject == '') && w.attendanceEvent.Id != null){
                        toBeDeleted.add(w.attendanceEvent);
                    }
                }
            }
            if(attendances.size() > 0){
                upsert attendances;
            }
            if(toBeDeleted.size() > 0){
                delete toBeDeleted;
            }
            
            ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Thank you for submitting attendances. All attendances are recorded successfully.');
            ApexPages.addMessage(successMessage);
        }catch(Exception e){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Ooops ..Failed to record attandances. Please contact admin@britishschools.co.uk and provide follwing error message: '+e.getMessage());
            ApexPages.addMessage(errorMessage);
        }
        
        return null;
    }
    
   
    
    //wrapper class
    public class AttendanceWrapper{
        public Id studentId {get;set;}
        public String studentName {get;set;}
        public Event attendanceEvent {get;set;}
        public AttendanceWrapper(Id sid, String sn, Event e){
            studentId = sId;
            studentName = sn;
            attendanceEvent = e;
        }
    }

}