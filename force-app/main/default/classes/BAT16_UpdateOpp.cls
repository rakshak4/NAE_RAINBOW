/**
 * @description       : Batch Apex to update the Lead field on Opportunity
 * @author            : Spoon Consulting
 * @group             : 
 * @last modified on  : 07-13-2020
 * @last modified by  : Spoon Consulting
 * Modifications Log 
 * Ver   Date         Author             Modification
 * 1.0   07-13-2020   CRA                Initial Version
**/
global with sharing class BAT16_UpdateOpp implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
    global String query;    
    global String results = '';

    global BAT16_UpdateOpp() {
        System.debug('>>>>> BAT16_UpdateOpp - Constructor Starts <<<<<'); 
        query = 'SELECT Id, ConvertedAccountId, (SELECT Lead__c FROM Opportunities__r) FROM Lead WHERE ConvertedAccountId != null';
        System.debug('>>>>> BAT16_UpdateOpp - Constructor End <<<<<');
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('>>>>>START BAT16_UpdateOpp - start method <<<<<');
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        System.debug('>>>>>START BAT16_UpdateOpp - execute method <<<<<');
        List<Lead> lstLed = new List<Lead>();
        lstLed = scope;
        Map<Id, Opportunity> mapOpp = new Map<Id, Opportunity>();
        Map<Id, Id> mapLeadAcc = new Map<Id, Id>();
        List<Opportunity> lstOpptoUpd = new List<Opportunity>();

        for(Lead led : lstLed){
            if(led.Opportunities__r.size() == 0) {
                mapLeadAcc.put(led.ConvertedAccountId, led.Id);
            }
        }
        for(Opportunity opp : [SELECT Id, accountId, lead__c FROM Opportunity WHERE accountId IN :mapLeadAcc.keySet() and Lead__c = null]){
            opp.Lead__c = mapLeadAcc.get(opp.accountId);
            lstOpptoUpd.add(opp);
        }

        if(lstOpptoUpd.size() > 0) {
            update lstOpptoUpd;
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