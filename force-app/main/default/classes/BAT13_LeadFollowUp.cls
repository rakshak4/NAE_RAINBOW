global class BAT13_LeadFollowUp implements Database.Batchable<sObject>  , Database.Stateful, Schedulable{
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Batch class to create follow up tasks for lead
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 29-AUG-2018  AFO    1.0     Initial version
-- 11-MAR-2019  CRA    1.1     C00001648
-- 05-DEC-2019  CRA    1.2     C00002114 - Add filter to exclude unqualified lead
-- 19-OCT-2020  VJA    1.3     C00002678 - Added FA Enquiry to query
--------------------------------------------------------------------------------------
**************************************************************************************/
    
    global String query;
    global String results = '';
    
    global BAT13_LeadFollowUp () {
        system.debug('>>>>> BAT13_LeadFollowUp - Constructor Starts <<<<<');
        
        //CRA20190311 - C1648 - Add Lead Method and QuickWin School filters 
        query = 'SELECT Status, createdDate, ownerid, Owner.Type, lastModifiedDate, SchoolOfInterest__r.AdmissionsQueueCoordinator__c, id, SchoolOfInterest__r.BedrockSchool__c, Name FROM Lead '+
                'WHERE Isconverted = false AND Status IN (\'New\',\'Qualified\') AND Lead_Origin__c IN (\'AdmissionsStage1\',\'AdmissionsStage2\', \'WeChat\',\'PPC Campaign\',\'FA Enquiry\') AND SchoolOfInterest__r.BedrockSchool__c = true and SchoolOfInterest__r.OptInLeadFollowUp__c = true'; 
        system.debug('>>>>> BAT13_LeadFollowUp - Constructor Ends <<<<<');
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        system.debug('>>>>>START BAT13_LeadFollowUp - start method <<<<<');
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        system.debug('>>>>>START BAT13_LeadFollowUp - execute method <<<<<');
        List<Lead> lstLead = new List<Lead>();
        lstLead = scope; 
        List<Task> lstTasks = new List<Task>();
        Map<Id, Id> mapLeadIdAdminCoordinatorId = new map<Id, Id>();
        Map<Id, Task> mapTaskDate = new Map<Id, Task>();
        Map<Id, DateTime> mapLeadDate = new Map<Id, DateTime>();
        Map<Id, String> mapLeadName = new Map<Id, String>();
        Map<Id, Decimal> mapLedTskLevel = new Map<Id, Decimal>();
        String lead_prefix = Schema.SObjectType.Lead.getKeyPrefix();
        
        //lead an corresponding created date
        for(Lead lea : lstLead){
            if(lea.status == Label.BAT13_statusQualified){
                mapLeadDate.put(lea.id, lea.lastModifiedDate);
                mapLeadName.put(lea.id, lea.Name);
            }
            else{
                mapLeadDate.put(lea.id, lea.createdDate);
                mapLeadName.put(lea.id, lea.Name);
            }
            
            if(lea.ownerid != null){
                if(lea.Owner.Type == 'User') {
                    mapLeadIdAdminCoordinatorId.put(lea.id, lea.ownerid);
                }
                else {
                    mapLeadIdAdminCoordinatorId.put(lea.id, lea.SchoolOfInterest__r.AdmissionsQueueCoordinator__c);
                }
            }
        }
        System.debug('## mapLeadDate' +mapLeadDate);
        System.debug('## listTask Initial' + [SELECT CreatedDate, lastmodifiedDate, TaskCompletionDateTime__c, isAutomated__c, ActivityDate, TECH_FollowUpCount__c, Subject, Status, WhoId FROM task WHERE WhoId in : mapLeadDate.keySet()]);
        for(Task tsk : [SELECT CreatedDate, lastmodifiedDate, TaskCompletionDateTime__c, isAutomated__c, ActivityDate, TECH_FollowUpCount__c, Subject, Status, WhoId FROM task WHERE WhoId IN : mapLeadDate.keySet()]){
            System.debug('## tsk Subject' + tsk.Subject);
            System.debug('## tsk Status' + tsk.Status);
            
            if(tsk.isAutomated__c == false){
                //if due date is in future
                if(tsk.ActivityDate != null && (tsk.ActivityDate > system.now().date() && tsk.ActivityDate > mapLeadDate.get(tsk.WhoId))){
                    mapLeadDate.put(tsk.WhoId, tsk.ActivityDate);
                    System.debug('1');
                }
                else if(tsk.TaskCompletionDateTime__c != null && (tsk.TaskCompletionDateTime__c > mapLeadDate.get(tsk.WhoId))){
                    mapLeadDate.put(tsk.WhoId, tsk.TaskCompletionDateTime__c);
                    System.debug('2');
                }
                else if(tsk.TaskCompletionDateTime__c == null && tsk.ActivityDate != null && tsk.ActivityDate > mapLeadDate.get(tsk.WhoId)){
                    mapLeadDate.put(tsk.WhoId, tsk.ActivityDate);
                    System.debug('3');
                }
                else if(tsk.TaskCompletionDateTime__c == null && tsk.ActivityDate == null && tsk.createdDate > mapLeadDate.get(tsk.WhoId)){  //get last created dat of tasks in account
                    mapLeadDate.put(tsk.WhoId, tsk.createdDate);
                    System.debug('4');
                }
            }
            // else if(tsk.isAutomated__c == true && tsk.Subject != null && tsk.Subject.contains('Follow Up On') && ((String)tsk.WhoId).startsWith(lead_prefix) && tsk.Status == 'Open'){

            else if(tsk.isAutomated__c == true && tsk.Subject != null && tsk.Subject.contains('Follow Up On') && ((String)tsk.WhoId).startsWith(lead_prefix) ){
                if(!mapLedTskLevel.containsKey(tsk.WhoId)){
                    mapLedTskLevel.put(tsk.WhoId, tsk.TECH_FollowUpCount__c);
                    mapTaskDate.put(tsk.WhoId, tsk);
                }
                else{
                    if(tsk.TECH_FollowUpCount__c > mapLedTskLevel.get(tsk.WhoId)){
                        mapLedTskLevel.put(tsk.WhoId, tsk.TECH_FollowUpCount__c);
                        mapTaskDate.put(tsk.WhoId, tsk);
                    }
                }
            }
        }
        System.debug('##TASK');
        System.debug(mapLeadDate);
        for(Event evt : [SELECT CreatedDate, LastModifiedDate, EndDateTime, ActivityDate, WhoId FROM Event WHERE WhoId IN : mapLeadDate.keySet() AND isAutomated__c = false]){                  
            if(evt.ActivityDate != null && (evt.ActivityDate > system.now().date() && evt.ActivityDate > mapLeadDate.get(evt.WhoId))){
                mapLeadDate.put(evt.WhoId, evt.ActivityDate);
            }
            else if(evt.EndDateTime != null && evt.EndDateTime > mapLeadDate.get(evt.WhoId)){
                mapLeadDate.put(evt.WhoId, evt.EndDateTime);
            }
            else if(evt.EndDateTime == null && evt.ActivityDate != null && evt.ActivityDate > mapLeadDate.get(evt.WhoId)){
                mapLeadDate.put(evt.WhoId, evt.ActivityDate);
            }
            else if(evt.EndDateTime == null && evt.ActivityDate == null && evt.createdDate > mapLeadDate.get(evt.WhoId)){
                mapLeadDate.put(evt.WhoId, evt.createdDate);
            }
        }
        System.debug('##EVENT');
        System.debug(mapLeadDate);
        
        for(EmailMessageRelation emRel: [SELECT RelationId, EmailMessage.MessageDate, EmailMessage.lastmodifiedDate,  EmailMessage.Subject FROM EmailMessageRelation WHERE RelationId IN : mapLeadDate.keySet()]){
            if(emRel.EmailMessage.messageDate != null && emRel.EmailMessage.messageDate > mapLeadDate.get(emRel.RelationId)){
                mapLeadDate.put(emRel.RelationId, emRel.EmailMessage.messageDate);
            }
        }
        System.debug('##EMAIL');
        System.debug(mapLeadDate);

        for(Id LeadId : mapLeadDate.keySet()){
            System.debug(mapLeadIdAdminCoordinatorId);
            if(mapLeadDate.get(LeadId) != null && mapLeadIdAdminCoordinatorId.containsKey(LeadId)){
                Date LastDate = mapLeadDate.get(LeadId).date();
                Date DateToday = system.now().date();
                Integer diffInDays = LastDate.daysBetween(DateToday);
                Integer diffInDaysTsk = 0;
                
                if(mapTaskDate.containsKey(LeadId) && mapTaskDate.get(LeadId).ActivityDate != null){
                    Date LastTskDate = mapTaskDate.get(LeadId).ActivityDate;
                    diffInDaysTsk = LastTskDate.daysBetween(DateToday); 
                }
                else if(mapTaskDate.containsKey(LeadId)){
                    Date LastTskDate = mapTaskDate.get(LeadId).createddate.date();
                    diffInDaysTsk = LastTskDate.daysBetween(DateToday); 
                }
                
                System.debug('##Level ' +mapLedTskLevel);
                System.debug('##diffInDays ' +diffInDays);
                System.debug('##diffInDaysTsk ' +diffInDaysTsk);

                String description = Label.BAT13_TaskDescription;
                String Subject = Label.BAT13_TaskSubject;
               
               if(diffInDays >= 1 && ( !mapLedTskLevel.containsKey(LeadId) || (mapLedTskLevel.get(LeadId) == null || mapLedTskLevel.get(LeadId) == 0))){
                    Task tsk = buildTask(LeadId, mapLeadIdAdminCoordinatorId);
                    tsk.Subject = Subject.replace('{!LeadName}', mapLeadName.get(LeadId));
                    tsk.Description = description.replace('{!diffInDays}', '1st');
                    tsk.TECH_FollowUpCount__c = 1;
                    lstTasks.add(tsk);
                }
                //else if(diffInDays >= 1 && mapLedTskLevel.get(LeadId) == 1){
                 //   Task tsk = mapTaskDate.get(LeadId);
                 //   tsk.ActivityDate = system.now().date();
                //    lstTasks.add(tsk);
               // }
                /*else if(diffInDays >= 15 && diffInDaysTsk >= 7 && mapLedTskLevel.get(LeadId) == 1){
                    Task tsk = buildTask(LeadId, mapLeadIdAdminCoordinatorId);
                    tsk.Subject = Label.BAT13_TaskSubject;
                    tsk.Description = description.replace('{!diffInDays}', '15');
                    tsk.TECH_FollowUpCount__c = 2;
                    lstTasks.add(tsk);
                }
                else if(diffInDays == 15 && mapLedTskLevel.get(LeadId) == 2){
                    Task tsk = mapTaskDate.get(LeadId);
                    tsk.ActivityDate = system.now().date();
                    lstTasks.add(tsk);
                }
                else if(diffInDays >= 22 && diffInDaysTsk >= 7 && mapLedTskLevel.get(LeadId) == 2){
                    Task tsk = buildTask(LeadId, mapLeadIdAdminCoordinatorId);
                    tsk.Subject = Label.BAT13_TaskSubject;
                    tsk.Description = description.replace('{!diffInDays}', '22');
                    tsk.TECH_FollowUpCount__c = 3;
                    lstTasks.add(tsk);
                }
                else if(diffInDays == 22 && mapLedTskLevel.get(LeadId) == 3){
                    Task tsk = mapTaskDate.get(LeadId);
                    tsk.ActivityDate = system.now().date();
                    lstTasks.add(tsk);
                }
                else if(diffInDays >= 36 && diffInDaysTsk >= 14 && mapLedTskLevel.get(LeadId) == 3){
                    Task tsk = buildTask(LeadId, mapLeadIdAdminCoordinatorId);
                    tsk.Subject = Label.BAT13_TaskSubject;
                    tsk.Description = description.replace('{!diffInDays}', '36');
                    tsk.TECH_FollowUpCount__c = 4;
                    lstTasks.add(tsk);
                }
                else if(diffInDays == 36 && mapLedTskLevel.get(LeadId) == 4){
                    Task tsk = mapTaskDate.get(LeadId);
                    tsk.ActivityDate = system.now().date();
                    lstTasks.add(tsk);
                }*/
            }
        }
        
        System.debug('##listTask' +lstTasks);

        if(lstTasks.size() > 0){
            Database.UpsertResult[] srToUpsert = Database.upsert(lstTasks, false);
            for(Integer i=0 ; i<srToUpsert.size() ; i++){  
                Database.UpsertResult sr = srToUpsert[i];
                
                if(srToUpsert[i].isSuccess()){ 
                    System.debug('Task created on lead : ' + lstTasks[i].whoId);
                    results = results + 'Follow Up Task created on lead : ' + lstTasks[i].whoId + '\n';
                }
                else{ 
                    system.debug('####srToUpsert-failure ');
                    Database.Error error = sr.getErrors().get(0);
                    results = '** Error when inserting task for lead '+ lstTasks[i].whoId + ' Error Occured: ' + results + string.valueOf(error) + '\n';
                }
            }
        } 

    }
    
    public task buildTask(id leadID, map<id,id> mapOwner){
        System.debug('##create one task');
        Task tsk = new Task();
        tsk.WhoId = leadID;
        tsk.ActivityDate = system.now().date();
        tsk.isAutomated__c = true;
        tsk.IsReminderSet = true;
        tsk.ReminderDateTime = system.now();
        tsk.Status = 'Open';
        tsk.ownerId = mapOwner.get(leadID);
        return tsk;
    }
    
    global void finish(Database.BatchableContext BC) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = System.Label.BAT13_emailAddress.split(';');
        mail.setToAddresses(toAddresses);
        mail.setReplyTo(System.Label.BAT13_emailAddress);
        mail.setSenderDisplayName('Salesforce');
        mail.setSubject('BAT13_LeadFollowUp');
        mail.setPlainTextBody('Results:'+ results );
        Messaging.sendEmail(new Messaging.Singleemailmessage [] {mail});
    }   
    
    global void execute (SchedulableContext sc){
        BAT13_LeadFollowUp batchObj = new BAT13_LeadFollowUp();
        Database.executeBatch(batchObj , 200);
    }

}