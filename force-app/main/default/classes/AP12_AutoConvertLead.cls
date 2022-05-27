/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex class to auto convert a list of Leads 
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 18-JUL-2018  RRJ   1.0     Initial Version
-- 11-JAN-2022  FKH   1.1     Clone Activities - Case 4209
--------------------------------------------------------------------------------------
**************************************************************************************/
public with sharing class AP12_AutoConvertLead {

    public static void convertLeads(List<Lead> lstAutoConvLed){
        List<Database.LeadConvert> lstLeadConv = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Map<Id,ID> mapLedAccids = new Map<Id,ID> ();
        Map<Id,List<Task>> leadTasks = new Map<Id,List<Task>>();
        Map<Id,List<Event>> leadEvents = new Map<Id,List<Event>>();

        leadTasks = getLeadTasks(lstAutoConvLed);   //get leads tasks
      leadEvents = getLeadEvents(lstAutoConvLed); //get leads events

        for(Lead led : lstAutoConvLed){
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(led.Id);
            lc.setConvertedStatus(convertStatus.MasterLabel);
            lc.setDoNotCreateOpportunity(true);
            lstLeadConv.add(lc);
        }

       Database.LeadConvertResult[] lstLeadConvRes = Database.convertLead(lstLeadConv);
       for (Database.LeadConvertResult lcr: lstLeadConvRes){ // FKH Clone Activities - Case 4209
            mapLedAccids.put(lcr.getLeadID(),lcr.getAccountId());    //map Leadid to accountID
       }

        insertTasks(leadTasks,mapLedAccids);
insertEvents(leadEvents,mapLedAccids);
    }   

    /**
     * Method to insert lists of tasks and relate it to Account
     * @param mapLeadTsk Map of Lead id with lists of tasks
     * @param  mapLedAccids  Map of lead id to account id
    */
    public static void insertTasks(Map<Id,List<Task>> mapLeadTsk, Map<Id,ID> mapLedAccids){
        List<Task> lstAlltsk = new List<Task>();
        List<Task> lstTask = new List<Task>();

        for(Id ledid: mapLeadTsk.keySet()){
            lstTask = mapLeadTsk.get(ledid);
            for(Task tsk:lstTask){
                tsk.WhoId = null;
                tsk.id = null;
                tsk.WhatId = mapLedAccids.get(ledid);
                lstAlltsk.add(tsk);
            }
        }
        if(lstAlltsk.size()>0) insert lstAlltsk;
    }

    /**
     * Method to insert lists of events and relate it to Account
     * @param mapLeadEvent Map of Lead id with lists of events
     * @param  mapLedAccids  Map of lead id to account id
    */
    public static void insertEvents(Map<Id,List<Event>> mapLeadEvent, Map<Id,ID> mapLedAccids){
        List<Event> lstAllEvent= new List<Event>();
        List<Event> lstEvent = new List<Event>();

        for(Id ledid: mapLeadEvent.keySet()){
            for(Event evt:mapLeadEvent.get(ledid)){
                evt.WhoId = null;
                evt.WhatId = mapLedAccids.get(ledid);
                lstAllEvent.add(evt);
            }     
        }
        if(lstAllEvent.size()>0) insert lstAllEvent;
    }

    /**
     * Method to get events related to lead
     * @param lstAutoConvLed list of leads
     * @return map of lead id with associated events
    */
    public static Map<Id,List<Event>> getLeadEvents(List<Lead> lstAutoConvLed){
        List<Event> lstEventsQuery = [SELECT id,OriginLeadDate__c,CreatedDate,WhoId FROM Event WHERE WhoId IN : lstAutoConvLed];
        Map<Id,List<Event>> mapLedIdEvents = new Map<Id,List<Event>>();
        List<Event> lstEventToCreate;
        List<Event> lstEvents = new List<Event>();

        if (lstEventsQuery.size()>0) lstEvents =lstEventsQuery.deepClone();

        for(Event evt : lstEvents) {
            evt.OriginLeadDate__c = evt.CreatedDate;
            lstEventToCreate = new List<Event>();
            if(mapLedIdEvents.get(evt.WhoId)!=null) lstEventToCreate = mapLedIdEvents.get(evt.WhoId);
            lstEventToCreate.add(evt);
            mapLedIdEvents.put(evt.WhoId,lstEventToCreate); //map: lead,list of event
        }
        return mapLedIdEvents;
    }

    /**
     * Method to get tasks related to lead
     * @param lstAutoConvLed list of leads
     * @return map of lead id with associated tasks
    */
    public static Map<Id,List<Task>> getLeadTasks(List<Lead> lstAutoConvLed){
        List<Task> lstTasksQuery = [SELECT WhoId,WhatId,Subject,ActivityDate,Status,Priority,OwnerId,Description,Type,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,CallDurationInSeconds,CallType,CallDisposition,CallObject,ReminderDateTime,IsReminderSet,IsRecurrence,RecurrenceStartDateOnly,RecurrenceEndDateOnly,RecurrenceTimeZoneSidKey,RecurrenceType,RecurrenceInterval,RecurrenceDayOfWeekMask,RecurrenceDayOfMonth,RecurrenceInstance,RecurrenceMonthOfYear,RecurrenceRegeneratedType,TaskSubtype,Contact1__c,ExternalID__c,MeetingOutcome__c,Status__c,TaskCompletionDateTime__c,isAutomated__c,TECH_FollowUpCount__c,OriginLeadDate__c,SLT_Involved__c,ExpectedStartDate__c,Type__c,Client_GUID__c, (Select id from Attachments) FROM Task WHERE WhoId IN : lstAutoConvLed]; //query all tasks fields
        List<Task> lstTaskToCreate = new List<Task>();
        Map<Id,List<Task>> mapLedIdTasks = new Map<Id,List<Task>>();
        List<Task> emailTasks = new List<Task>();
        List<Task> lstTasks = new List<Task>();

        if (lstTasksQuery.size()>0) lstTasks =lstTasksQuery.deepClone();    //clone tasks list

        for(Task tsk : lstTasks) {
            lstTaskToCreate=new List<Task>();
            tsk.OriginLeadDate__c = tsk.CreatedDate;
            if(mapLedIdTasks.get(tsk.WhoId)!=null)  lstTaskToCreate = mapLedIdTasks.get(tsk.WhoId); // add all tasks of leads in lists
            lstTaskToCreate.add(tsk);   //add task to list
            mapLedIdTasks.put(tsk.WhoId,lstTaskToCreate); //map - lead : list of tasks
        }
        return mapLedIdTasks;
    }
}