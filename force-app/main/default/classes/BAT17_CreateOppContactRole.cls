global with sharing class BAT17_CreateOppContactRole implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
    global String query;    
    global String results = '';

    global BAT17_CreateOppContactRole() {
        System.debug('>>>>> BAT16_UpdateOpp - Constructor Starts <<<<<'); 
        query = 'SELECT Id, AccountId, ContactId, Roles FROM AccountContactRelation WHERE ContactId NOT IN (SELECT ContactId FROM OpportunityContactRole)';
        System.debug('>>>>> BAT16_UpdateOpp - Constructor End <<<<<');
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('>>>>>START BAT16_UpdateOpp - start method <<<<<');
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        System.debug('>>>>>START BAT16_UpdateOpp - execute method <<<<<');
        List<AccountContactRelation> lstAccConRole = new List<AccountContactRelation>();
        lstAccConRole = scope;
        List<OpportunityContactRole> lstOppConRelToIns = new List<OpportunityContactRole>();
        Map<Id, List<AccountContactRelation>> mapAccIdtoAccConRel = new Map<Id, List<AccountContactRelation>> ();
        
        for (AccountContactRelation accConRel : lstAccConRole) {
            if (mapAccIdtoAccConRel.containsKey(accConRel.AccountId)) {
                mapAccIdtoAccConRel.get(accConRel.AccountId).add(accConRel);
            }
            else {
                mapAccIdtoAccConRel.put(accConRel.AccountId, new List<AccountContactRelation> {accConRel});
            }
        }

        for(Opportunity opp : [SELECT Id, accountId FROM Opportunity WHERE accountId IN :mapAccIdtoAccConRel.keySet()]){
            for (AccountContactRelation accConRel : mapAccIdtoAccConRel.get(opp.AccountId)) {
                lstOppConRelToIns.add(new OpportunityContactRole(
                    Role = accConRel.Roles,
                    ContactId = accConRel.ContactId,
                    OpportunityId = opp.Id
                ));
            }
        }

        if(lstOppConRelToIns.size() > 0) {
            insert lstOppConRelToIns;
        }
        System.debug('>>>>>END BAT16_UpdateOpp - execute method <<<<<');
    }

    global void finish(Database.BatchableContext BC) {
        AsyncApexJob a = [SELECT Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = System.Label.BAT13_emailAddress.split(';');
        mail.setToAddresses(toAddresses);
        mail.setReplyTo(System.Label.BAT13_emailAddress);
        mail.setSenderDisplayName('Salesforce');
        mail.setSubject('Opportunity Update');
        mail.setPlainTextBody('Records processed ' + a.TotalJobItems +   'with '+ a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.Singleemailmessage [] {mail});
    }

    global void execute (SchedulableContext sc){
        BAT16_UpdateOpp batchObj = new BAT16_UpdateOpp();
        Database.executeBatch(batchObj , 200);
    }

}