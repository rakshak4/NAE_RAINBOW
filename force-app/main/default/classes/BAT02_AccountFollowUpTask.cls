global class BAT02_AccountFollowUpTask implements Database.Batchable<sObject>  , Database.Stateful, Schedulable{
    /**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Batch class to update number of contacts in account
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 22-NOV-2018  AFO    1.0     Initial version   
--------------------------------------------------------------------------------------
**************************************************************************************/
    global String query;
    global String results = '';
    
    global BAT02_AccountFollowUpTask () {
        system.debug('>>>>> BAT02_AccountFollowUpTask - Constructor Starts <<<<<');
        //query = 'Select Id, CreatedDate, OwnerId, (Select Id, StageName FROM Opportunities WHERE StageName != \'Enrolled\' and IsClosed != true limit 1) From Account where id = \'0011j000004OC8IAAW\'';
        query = 'Select Id, CreatedDate, OwnerId, Name, (Select Id, StageName FROM Opportunities WHERE StageName != \'Enrolled\' and IsClosed != true and Waitlisted__c != true limit 1) From Account where SchoolOfInterest__r.BedrockSchool__c = true and SchoolOfInterest__r.OptInAutomatedTask__c = true';
        
        system.debug('>>>>> BAT02_AccountFollowUpTask - Constructor Ends <<<<<');
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        system.debug('>>>>>START BAT02_AccountFollowUpTask - start method <<<<<');
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Account> lstAcc = new List<Account>();
        lstAcc = scope;
        Map<Id, DateTime> mapAccDate = new Map<Id, DateTime>();
        Map<Id, Task> mapTaskDate = new Map<Id, Task>();
        Map<Id, Decimal> mapAccTskLevel = new Map<Id, Decimal>();
        Map<id, id> mapAccOwner = new Map<id,id>();
        Map<id, String> mapOppAccName = new Map<id,String>();

        List<Task> lstTasks = new List<Task>();
        //get All Accounts which do no has opportunities as enrolled or closed
        for(Account acc : lstAcc){
            List<Opportunity> lstOpp = acc.opportunities;
            if(lstOpp.size() > 0){
                mapAccDate.put(acc.Id, acc.createdDate);
                //get account owner to assign tasks to
                mapAccOwner.put(acc.id,acc.OwnerId);
                mapOppAccName.put(acc.id,acc.Name); 
            }
        }
        
        for(Task tsk :[SELECT CreatedDate, lastmodifiedDate, TaskCompletionDateTime__c, isAutomated__c, ActivityDate, TECH_FollowUpCount__c, Subject, Status, WhatId FROM Task WHERE WhatId in : mapAccDate.keySet()]){
            System.debug(tsk.Subject);
            System.debug(tsk.Status);
            
            if(tsk.isAutomated__c == false){
                //if due date is in future
                if(tsk.ActivityDate != null && (tsk.ActivityDate > system.now().date() && tsk.ActivityDate > mapAccDate.get(tsk.whatId))){
                    mapAccDate.put(tsk.whatId, tsk.ActivityDate);
                    System.debug('1');
                }
                else if(tsk.TaskCompletionDateTime__c != null && (tsk.TaskCompletionDateTime__c > mapAccDate.get(tsk.whatId))){
                    mapAccDate.put(tsk.whatId, tsk.TaskCompletionDateTime__c);
                    System.debug('2');
                }
                else if(tsk.TaskCompletionDateTime__c == null && tsk.ActivityDate != null && tsk.ActivityDate > mapAccDate.get(tsk.whatId)){
                    mapAccDate.put(tsk.whatId, tsk.ActivityDate);
                    System.debug('3');
                }
                else if(tsk.TaskCompletionDateTime__c == null && tsk.ActivityDate == null && tsk.createdDate > mapAccDate.get(tsk.whatId)){  //get last created dat of tasks in account
                    mapAccDate.put(tsk.whatId, tsk.createdDate);
                    System.debug('4');
                }
            }
            else if(tsk.isAutomated__c == true && tsk.Subject != null && tsk.Subject.contains('day follow up')){
                if(!mapAccTskLevel.containsKey(tsk.WhatId)){
                    mapAccTskLevel.put(tsk.whatId, tsk.TECH_FollowUpCount__c);
                    mapTaskDate.put(tsk.whatId, tsk);
                }
                else{
                    if(tsk.TECH_FollowUpCount__c > mapAccTskLevel.get(tsk.whatId)){
                        mapAccTskLevel.put(tsk.whatId, tsk.TECH_FollowUpCount__c);
                        mapTaskDate.put(tsk.whatId, tsk);
                    }
                }
            }
        }
        System.debug('##TASK');
        System.debug(mapAccDate);
        for(Event evt :[SELECT CreatedDate, lastmodifiedDate, EndDateTime, ActivityDate, whatId FROM Event WHERE whatId in : mapAccDate.keySet() AND isAutomated__c = false]){                  
            if(evt.ActivityDate != null && (evt.ActivityDate > system.now().date() && evt.ActivityDate > mapAccDate.get(evt.whatId))){
                mapAccDate.put(evt.whatId, evt.ActivityDate);
            }
            else if(evt.EndDateTime != null && evt.EndDateTime > mapAccDate.get(evt.whatId)){
                mapAccDate.put(evt.whatId, evt.EndDateTime);
            }
            else if(evt.EndDateTime == null && evt.ActivityDate != null && evt.ActivityDate > mapAccDate.get(evt.whatId)){
                mapAccDate.put(evt.whatId, evt.ActivityDate);
            }
            else if(evt.EndDateTime == null && evt.ActivityDate == null && evt.createdDate > mapAccDate.get(evt.whatId)){
                mapAccDate.put(evt.whatId, evt.createdDate);
            }
        }
        System.debug('##EVENT');
        System.debug(mapAccDate);
        
        for(EmailMessage em: [SELECT relatedtoid, messageDate, lastmodifiedDate,  Subject FROM EmailMessage WHERE relatedtoid IN : mapAccDate.keySet()]){
            if(em.messageDate != null && em.messageDate > mapAccDate.get(em.relatedtoid)){
                mapAccDate.put(em.relatedtoid, em.messageDate);
            }
        }
        System.debug('##EMAIL');
        System.debug(mapAccDate);
        
        for(Id accId : mapAccDate.keySet()){
            if(mapAccDate.get(accId) != null){
                Date LastDate = mapAccDate.get(accId).date();
                Date DateToday = system.now().date();
                Integer diffInDays = LastDate.daysBetween(DateToday);
                Integer diffInDaysTsk = 0;
                
                if(mapTaskDate.containsKey(accId) && mapTaskDate.get(accId).ActivityDate != null){
                    Date LastTskDate = mapTaskDate.get(accId).ActivityDate;
                    diffInDaysTsk = LastTskDate.daysBetween(DateToday); 
                }
                else if(mapTaskDate.containsKey(accId)){
                    Date LastTskDate = mapTaskDate.get(accId).createddate.date();
                    diffInDaysTsk = LastTskDate.daysBetween(DateToday); 
                }
                
                System.debug(mapAccTskLevel);
                System.debug(diffInDays);
                System.debug(diffInDaysTsk);

                String subject = Label.BAT13_TaskSubjectAcc;
                subject = subject.replace('{!AccName}', mapOppAccName.get(accId));

                if(diffInDays >= 8 && ( !mapAccTskLevel.containsKey(accId) || (mapAccTskLevel.get(accId) == null || mapAccTskLevel.get(accId) == 0))){
                    Task tsk = buildTask(accId, mapAccOwner);
                    tsk.Subject = subject.replace('{!diffInDays}', '8');
                    tsk.Description = subject.replace('{!diffInDays}', '8');
                    tsk.TECH_FollowUpCount__c = 1;
                    lstTasks.add(tsk);
                }
                else if(diffInDays == 8 && mapAccTskLevel.get(accId) == 1){
                    Task tsk = mapTaskDate.get(accId);
                    tsk.ActivityDate = system.now().date();
                    lstTasks.add(tsk);
                }
                else if(diffInDays >= 15 && diffInDaysTsk >= 7 && mapAccTskLevel.get(accId) == 1){
                    Task tsk = buildTask(accId, mapAccOwner);
                    tsk.Subject = subject.replace('{!diffInDays}', '15');
                    tsk.Description = subject.replace('{!diffInDays}', '15');
                    tsk.TECH_FollowUpCount__c = 2;
                    lstTasks.add(tsk);
                }
                else if(diffInDays == 15 && mapAccTskLevel.get(accId) == 2){
                    Task tsk = mapTaskDate.get(accId);
                    tsk.ActivityDate = system.now().date();
                    lstTasks.add(tsk);
                }
                else if(diffInDays >= 22 && diffInDaysTsk >= 7 && mapAccTskLevel.get(accId) == 2){
                    Task tsk = buildTask(accId, mapAccOwner);
                    tsk.Subject = subject.replace('{!diffInDays}', '22');
                    tsk.Description = subject.replace('{!diffInDays}', '22');
                    tsk.TECH_FollowUpCount__c = 3;
                    lstTasks.add(tsk);
                }
                else if(diffInDays == 22 && mapAccTskLevel.get(accId) == 3){
                    Task tsk = mapTaskDate.get(accId);
                    tsk.ActivityDate = system.now().date();
                    lstTasks.add(tsk);
                }
                else if(diffInDays >= 36 && diffInDaysTsk >= 14 && mapAccTskLevel.get(accId) == 3){
                    Task tsk = buildTask(accId, mapAccOwner);
                    tsk.Subject = subject.replace('{!diffInDays}', '36');
                    tsk.Description = subject.replace('{!diffInDays}', '36');
                    tsk.TECH_FollowUpCount__c = 4;
                    lstTasks.add(tsk);
                }
                else if(diffInDays == 36 && mapAccTskLevel.get(accId) == 4){
                    Task tsk = mapTaskDate.get(accId);
                    tsk.ActivityDate = system.now().date();
                    lstTasks.add(tsk);
                }
                
            }
        }
        System.debug(lstTasks);
        if(lstTasks.size() > 0){
            Database.UpsertResult [] srToupsert = Database.upsert(lstTasks, false);
            for(Integer i=0 ; i<srToupsert.size() ; i++){  
                Database.UpsertResult sr = srToupsert[i];
                
                if(srToupsert[i].isSuccess()){ 
                    results = results + 'Follow Up Task created on Account : ' + lstTasks[i].whatId + '\n';
                }
                else{ 
                    Database.Error error = sr.getErrors().get(0);
                    results = '** Error when inserting task for Acount '+ lstTasks[i].whatId + ' Error Occured: ' + results + string.valueOf(error) + '\n';
                }
            }
        } 
    }
    
    public task buildTask(id accId, map<id,id> mapOppOwner){
        System.debug('##create one task');
        Task tsk = new Task();
        tsk.whatId = accId;
        tsk.ActivityDate = system.now().date();
        tsk.isAutomated__c = true;
        tsk.IsReminderSet = true;
        tsk.ReminderDateTime = system.now();
        tsk.Status = 'Open';
        tsk.ownerId = mapOppOwner.get(accId);
        return tsk;
    }
    
    global void finish(Database.BatchableContext BC) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = System.Label.BAT13_emailAddress.split(';');
        mail.setToAddresses(toAddresses);
        mail.setReplyTo(System.Label.BAT13_emailAddress);
        mail.setSenderDisplayName('Salesforce');
        mail.setSubject('BAT13_FollowUpAcc');
        mail.setPlainTextBody('Results:'+ results );
        Messaging.sendEmail(new Messaging.Singleemailmessage [] {mail});
        
    }
    
    global void execute (SchedulableContext sc){
        BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
        Database.executeBatch(batchObj , 200);
    }
    
    
    
}