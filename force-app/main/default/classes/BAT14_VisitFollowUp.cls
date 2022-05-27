global with sharing class BAT14_VisitFollowUp implements Database.Batchable<sObject>  , Database.Stateful, Schedulable {
    /**
 * @File Name          : BAT14_VisitFollowUp.cls
 * @Description        : Batch to send email if no action has been taken after 24hr of the creation of the Visit Event
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 23/06/2020, 06:37:10
 * @Modification Log   : 
 * Ver       Date            Author      		Modification
 * ----   ----------        -------         -------------------------------------------------------
 * 1.0    23/06/2020         CRA                Initial Version
**/ 
    global String query;    
    global String results = '';

    global BAT14_VisitFollowUp() {
        System.debug('>>>>> BAT14_VisitFollowUp - Constructor Starts <<<<<'); 
        //query = 'SELECT Id, WhatId, OwnerId, EndDateTime FROM Event WHERE Type = \'1 on 1 visit\' AND Status__c = \'Completed\' AND Account.SchoolOfInterest__r.OptIn24hrVisit__c = true';
        query = 'SELECT Id, WhatId, OwnerId, EndDateTime FROM Event WHERE Type = \'1 on 1 visit\' AND Status__c = \'Completed\' AND Account.SchoolOfInterest__r.OptIn24hrVisit__c = true AND EndDateTime = LAST_N_DAYS:1';
        System.debug('>>>>> BAT14_VisitFollowUp - Constructor Ends <<<<<');
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('>>>>>START BAT14_VisitFollowUp - start method <<<<<');
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        system.debug('>>>>>START BAT14_VisitFollowUp - execute method <<<<<');
        List<Event> lstEvent = new List<Event>();
        lstEvent = scope; 
        Map<Id, Event> mapEvtAcc = new Map<Id, Event> (); 
        Map<Id, DateTime> mapAccLastDate = new Map<Id, DateTime>();
        List<Task> lstTskToAdd = new List<Task>();

        for (Event evt : lstEvent) { //Check if the Completion DateTime is more than 24Hr
            if((evt.EndDateTime.date()).daysBetween(System.now().date()) >= 1
                && ((mapEvtAcc.containsKey(evt.WhatId) && mapEvtAcc.get(evt.WhatId).EndDateTime < evt.EndDateTime )
                || !mapEvtAcc.containsKey(evt.WhatId))) {
                    mapEvtAcc.put(evt.WhatId, evt);
            }
        }

        if(mapEvtAcc.size() > 0) { 
            //Check if an automated Task is already created or there is an action on task
            for(Task tsk : [SELECT Id, LastModifiedDate, CreatedDate, isAutomated__c, Subject, WhatId FROM Task WHERE WhatId IN :mapEvtAcc.keySet()]) {
                if (tsk.isAutomated__c && tsk.Subject.equals(Label.BAT14_Subject)) {
                    mapEvtAcc.remove(tsk.WhatId); //if an automated task reminder is already created
                }
                else {
                    Date tskLastDate = tsk.LastModifiedDate > tsk.CreatedDate ? tsk.LastModifiedDate.Date() : tsk.CreatedDate.date();
                    if(!mapAccLastDate.containsKey(tsk.WhatId) || (mapAccLastDate.containsKey(tsk.WhatId) && mapAccLastDate.get(tsk.WhatId) < tskLastDate)) {
                        mapAccLastDate.put(tsk.WhatId, tskLastDate);
                    }
                }
            }
            //Check if the Account Creation Date/Last Modified Date is less than 24Hr
            for(Account acc : [SELECT Id
                                    , LastModifiedDate
                                    , CreatedDate 
                                    , (SELECT Id, LastModifiedDate, CreatedDate FROM Opportunities)
                                    , (SELECT Id, LastModifiedDate, CreatedDate FROM Contacts)
                                FROM Account WHERE Id IN :mapEvtAcc.keySet()]){
                Date accLastDate = acc.LastModifiedDate > acc.CreatedDate ? acc.LastModifiedDate.date() : acc.CreatedDate.date();
                if(!mapAccLastDate.containsKey(acc.Id) || (mapAccLastDate.containsKey(acc.Id) && mapAccLastDate.get(acc.Id) < accLastDate)) {
                    mapAccLastDate.put(acc.Id, accLastDate);
                }
                for (Contact con : acc.Contacts) {
                    Date conLastDate = con.LastModifiedDate > con.CreatedDate ? con.LastModifiedDate.date() : con.CreatedDate.date();
                    System.debug('### con '+con);
                    System.debug('### conLastDate '+conLastDate);
                    if(mapAccLastDate.get(acc.Id) < conLastDate) {
                        mapAccLastDate.put(acc.Id, conLastDate);
                        System.debug('### con ');
                    }
                }
                for (Opportunity opp : acc.Opportunities) {
                    Date oppLastDate = opp.LastModifiedDate > opp.CreatedDate ? opp.LastModifiedDate.date() : opp.CreatedDate.date();
                    if(mapAccLastDate.get(acc.Id) < oppLastDate) {
                        mapAccLastDate.put(acc.Id, oppLastDate);
                    }
                }
            }

            for(EmailMessage em: [SELECT Relatedtoid, MessageDate, LastmodifiedDate FROM EmailMessage WHERE Relatedtoid IN :mapEvtAcc.keySet()]){
                if(!mapAccLastDate.containsKey(em.Relatedtoid) || (em.MessageDate != null && mapAccLastDate.containsKey(em.Relatedtoid) && mapAccLastDate.get(em.Relatedtoid) < em.MessageDate)) {
                    mapAccLastDate.put(em.Relatedtoid, em.MessageDate);
                }
            }

            for (Event evt : [SELECT Id, LastModifiedDate, CreatedDate, WhatId FROM Event WHERE WhatId IN :mapEvtAcc.keySet() AND isAutomated__c = false AND Type != '1 on 1 visit']) {
                Date evtLastDate = evt.LastModifiedDate > evt.CreatedDate ? evt.LastModifiedDate.date() : evt.CreatedDate.date();
                if(!mapAccLastDate.containsKey(evt.WhatId) || (mapAccLastDate.containsKey(evt.WhatId) && mapAccLastDate.get(evt.WhatId) < evtLastDate)) {
                    mapAccLastDate.put(evt.WhatId, evtLastDate);
                }
            }

            if (mapAccLastDate.size() > 0 && mapEvtAcc.size() > 0) {
                for (Id accId : mapEvtAcc.keySet()) {
                    if ((mapEvtAcc.get(accId).EndDateTime.date()).daysBetween(mapAccLastDate.get(accId).date()) >= 1) {
                        Task tsk = new Task();
                        tsk.WhatId = accId;
                        tsk.ActivityDate = System.now().date();
                        //tsk.ActivityDate = mapEvtAcc.get(accId).endDate == 7 ? mapEvtAcc.get(accId).EndDateTime.date() + 2 : mapEvtAcc.get(accId).EndDateTime.date() + 1;
                        tsk.isAutomated__c = true;
                        tsk.IsReminderSet = true;
                        tsk.ReminderDateTime = System.now();
                        tsk.Status = 'Open';
                        tsk.Subject = Label.BAT14_Subject;
                        tsk.OwnerId = mapEvtAcc.get(accId).OwnerId;
                        tsk.Priority = 'Normal';

                        lstTskToAdd.add(tsk);
                    }
                }

                if (lstTskToAdd.size() > 0) {
                    Database.SaveResult[] srToInsert = Database.insert(lstTskToAdd, false);
                    for(Integer i=0 ; i<srToInsert.size() ; i++){  
                        Database.SaveResult sr = srToInsert[i];
                        
                        if(srToInsert[i].isSuccess()){ 
                            System.debug('Task created on account : ' + lstTskToAdd[i].WhatId);
                            results = results + 'Follow Up Task created on Family : ' + lstTskToAdd[i].WhatId + '\n';
                        }
                        else{ 
                            system.debug('####srToInsert-failure ');
                            Database.Error error = sr.getErrors().get(0);
                            results = '** Error when inserting task for account '+ lstTskToAdd[i].WhatId + ' Error Occured: ' + results + string.valueOf(error) + '\n';
                        }
                    }
                }
            }
        }

        System.debug('>>>>>END BAT14_VisitFollowUp - execute method <<<<<'); 
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
        BAT14_VisitFollowUp batchObj = new BAT14_VisitFollowUp();
        Database.executeBatch(batchObj , 200);
    }
}