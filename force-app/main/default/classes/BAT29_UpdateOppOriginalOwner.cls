/**
 * @File Name          : BAT28_LeadPhoneandWeChatMigrate.cls
 * @Description        : Case 4446: Update Original Owner as reference to Opportunity Owner if Original Owner is blank
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : YRA
 * @Last Modified On   : 02-DEC-2021, 8:30 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    01-DEC-2021, 1:30 pm          YRA        Initial Version
**/
global class BAT29_UpdateOppOriginalOwner implements Database.Batchable<sObject>, Database.Stateful{
    
    global String query;
    global String ids = '';

    global BAT29_UpdateOppOriginalOwner() {
        query='SELECT id, OwnerId, OriginalOwner__c FROM Opportunity WHERE OriginalOwner__c = null';
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Opportunity> lstOpp) { 
        for(Opportunity opp : lstOpp){
            opp.OriginalOwner__c = opp.OwnerId;
            ids = ids +' ,' + opp.id;
        }
        if(lstOpp.size()>0){
            update lstOpp;
        }
    }
    global void finish(Database.BatchableContext BC) {
        System.debug('###Ids: ' + ids);
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id =: BC.getJobId()];
        try { // send completion mail.
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] { 'yogini.rampeearee@spoonconsulting.com','fatimah.khodadin@spoonconsulting.com' }; //set receiver of mail
            mail.setToAddresses(toAddresses);
            mail.setSubject('Original Owner Updated');
            mail.setPlainTextBody('Records processed ' + job.TotalJobItems + ' with ' + job.NumberOfErrors + ' failures.'+ 'Ids: ' + ids);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); // send email
            System.debug('#####Finish - BAT29_UpdateOppOriginalOwner#####');
        } catch (Exception e) {
            System.debug('## Sending batch completion status mail ' + e);
        }
    }
}