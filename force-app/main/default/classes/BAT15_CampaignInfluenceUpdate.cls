global with sharing class BAT15_CampaignInfluenceUpdate implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    /**
     * @File Name          : BAT15_CampaignInfluenceUpdate.cls
     * @Description        : Batch to Update Opporunity with their related Campaign and Lead - Case 00002304
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
    
        global BAT15_CampaignInfluenceUpdate() {
            System.debug('>>>>> BAT15_CampaignInfluenceUpdate - Constructor Starts <<<<<'); 
            query = 'SELECT Id, ContactId, CampaignId, Contact.AccountId FROM CampaignMember';
            System.debug('>>>>> BAT15_CampaignInfluenceUpdate - Constructor Ends <<<<<');
        }
        
        global Database.QueryLocator start(Database.BatchableContext BC) {
            System.debug('>>>>>START BAT15_CampaignInfluenceUpdate - start method <<<<<');
            return Database.getQueryLocator(query);
        }
    
        global void execute(Database.BatchableContext BC, List<sObject> scope) {
            System.debug('>>>>>START BAT15_CampaignInfluenceUpdate - execute method <<<<<');
            List<CampaignMember> lstCmp = new List<CampaignMember>();
            lstCmp = scope; 
            Map<Id, CampaignMember> mapId = new Map<Id, CampaignMember>();
            List<Opportunity> lstOpp = new List<Opportunity>();
            Map<Id, Id> mapAccLead = new Map<Id, Id>();
            Set<Id> setAcc = new Set<Id>();
    
            for (CampaignMember cmp : lstCmp) {
                mapId.put(cmp.Contact.AccountId, cmp);
            }
    
            if (mapId.size() > 0) {
                for(Lead ld : [SELECT Id, ConvertedAccountId from Lead WHERE ConvertedAccountId IN :mapId.keyset()]) {
                    mapAccLead.put(ld.ConvertedAccountId, ld.Id);
                }
    
                if (mapAccLead.size() > 0) {
                    for(Opportunity opp : [SELECT Id, CampaignId, Lead__c, AccountId, LeadId__c FROM Opportunity WHERE AccountId IN :mapAccLead.keyset() AND Lead__c = null]) {
                        opp.CampaignId = mapId.get(opp.AccountId).CampaignId;
                        opp.Lead__c = mapAccLead.get(opp.AccountId);
                        lstOpp.add(opp);
                    }
                }
    
                if (lstOpp.size() > 0) {
                    update lstOpp;
                }
            }
    
            System.debug('>>>>>END BAT15_CampaignInfluenceUpdate - execute method <<<<<');
        }
    
        global void finish(Database.BatchableContext BC) {
            AsyncApexJob a = [SELECT Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
    
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = System.Label.BAT13_emailAddress.split(';');
            mail.setToAddresses(toAddresses);
            mail.setReplyTo(System.Label.BAT13_emailAddress);
            mail.setSenderDisplayName('Salesforce');
            mail.setSubject('Campaign Influence Update');
            mail.setPlainTextBody('Records processed ' + a.TotalJobItems +   'with '+ a.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.Singleemailmessage [] {mail});
        }
    
        global void execute (SchedulableContext sc){
            BAT15_CampaignInfluenceUpdate batchObj = new BAT15_CampaignInfluenceUpdate();
            Database.executeBatch(batchObj , 200);
        }
    
    }