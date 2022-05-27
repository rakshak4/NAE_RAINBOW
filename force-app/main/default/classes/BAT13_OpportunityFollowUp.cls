global class BAT13_OpportunityFollowUp implements Database.Batchable<sObject>  , Database.Stateful, Schedulable{
    /**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Batch class to create follow up tasks for opportunity
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 25-SEP-2018  KZE    1.0     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/
    
    global String query;
    global String results = '';
    
    global BAT13_OpportunityFollowUp () {
        system.debug('>>>>> BAT13_OpportunityFollowUp - Constructor Starts <<<<<');
        
        query = 'SELECT Id, CreatedDate, TECH_StageLastModifiedDate__c, ownerId FROM Opportunity WHERE StageName != \'Enrolled\' and IsClosed != true ORDER BY CreatedDate DESC ';

        system.debug('>>>>> BAT13_OpportunityFollowUp - Constructor Ends <<<<<');
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        system.debug('>>>>>START BAT13_OpportunityFollowUp - start method <<<<<');
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        system.debug('>>>>>START BAT13_OpportunityFollowUp - execute method <<<<<');
        List<Opportunity> lstOpp = new List<Opportunity>();
        lstOpp = scope; 
        List<Task> lstTasks = new List<Task>();
        Map<Id, DateTime> mapOppDate = new Map<Id, DateTime>();
        Map<id, id> mapOppOwner = new Map<id,id>();
        
        //Opportunity an corresponding created date OR TECH_StageLastModifiedDate__c
        for(Opportunity opp: lstOpp){
            mapOppOwner.put(opp.id,opp.OwnerId);
            if(opp.TECH_StageLastModifiedDate__c != null){
               mapOppDate.put(opp.id, opp.TECH_StageLastModifiedDate__c);  
            }
            else{
                mapOppDate.put(opp.id, opp.createdDate); 
            }
        }
       
        //Opportunity and last activity date TASK
        for(Task tsk :[Select createdDate, whatId from task where whatId in : mapOppDate.keySet() ]){
            if(tsk.createdDate != null && (tsk.createdDate > mapOppDate.get(tsk.whatId))){
                mapOppDate.put(tsk.whatId, tsk.createdDate);
            }
        }
        
        //Opportunity and last activity date EVENT
        for(Event evt :[Select createdDate, whatId from event where whatId in : mapOppDate.keySet() ]){                  
            if(evt.createdDate != null && (evt.createdDate > mapOppDate.get(evt.whatId))){
                mapOppDate.put(evt.whatId, evt.createdDate);
            }
        }
        
        for(Id oppId : mapOppDate.keySet()){
            if(mapOppDate.get(oppId) != null){
                Date LastDate = mapOppDate.get(oppId).date();
                Date DateToday = system.now().date();
                
                System.debug('LastDate: ' + LastDate);
                System.debug('DateToday: ' + DateToday);

                Integer diffInDays = LastDate.daysBetween(DateToday);
                System.debug('diffInDays: ' + diffInDays);
                
                if(diffInDays == 8 || diffInDays == 15 || diffInDays == 22 || diffInDays == 36){
                    Task tsk = buildTask(oppId, mapOppOwner);
                    String subject = Label.BAT13_TaskSubjectOpp ;
                    tsk.Subject = subject.replace('{!diffInDays}', String.valueOf(diffInDays));
                    String description = Label.BAT13_TaskDescriptionOpp;
                    tsk.Description = description.replace('{!diffInDays}', String.valueOf(diffInDays));
                    lstTasks.add(tsk);
                }
                
            }
        }

        if(lstTasks.size() > 0){
            Database.SaveResult[] srToInsert = Database.insert(lstTasks, false);
            for(Integer i=0 ; i<srToInsert.size() ; i++){  
                Database.SaveResult sr = srToInsert[i];
                
                if(srToInsert[i].isSuccess()){ 
                    System.debug('Task created on Opportunity : ' + lstTasks[i].whatId);
                    results = results + 'Follow Up Task created on Opportunity : ' + lstTasks[i].whatId + '\n';
                }
                else{ 
                    system.debug('####srToInsert-failure ');
                    Database.Error error = sr.getErrors().get(0);
                    results = '** Error when inserting task for Opportunity '+ lstTasks[i].whatId + ' Error Occured: ' + results + string.valueOf(error) + '\n';
                    System.debug('####results : ' + results);
                }
            }
        } 

    }
    
    public task buildTask(id oppId, map<id,id> mapOppOwner){
        System.debug('##create one task');
        Task tsk = new Task();
        tsk.whatId = oppId;
        tsk.ActivityDate = system.now().date();
        tsk.isAutomated__c = true;
        tsk.IsReminderSet = true;
        tsk.ReminderDateTime = system.now();
        tsk.Status = 'Open';
        tsk.ownerId = mapOppOwner.get(oppId);
        return tsk;
    }
    
    global void finish(Database.BatchableContext BC) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = System.Label.BAT13_emailAddress.split(';');
        mail.setToAddresses(toAddresses);
        mail.setReplyTo(System.Label.BAT13_emailAddress);
        mail.setSenderDisplayName('Salesforce');
        mail.setSubject('BAT13_OpportunityFollowUp');
        mail.setPlainTextBody('Results:'+ results );
        Messaging.sendEmail(new Messaging.Singleemailmessage [] {mail});
    }   
    
    global void execute (SchedulableContext sc){
        BAT13_OpportunityFollowUp batchObj = new BAT13_OpportunityFollowUp();
        Database.executeBatch(batchObj , 200);
    }
}