/**
 * Needed to process more than 10 xero orgs in the future, so changed from executing
 * 10 future methods, to a batch of scope size 1
 *
 * @author Logan Moore
 * @created October 2013
 */
global class XeroSyncBatch implements Database.Batchable<sObject>, Database.AllowsCallouts , Database.Stateful{
    
    String query;
    global string errorMessage = '';
    global XeroSyncBatch() {
        errorMessage = '';
        query = 'SELECT Id FROM Xero_Key__c WHERE Exclude_From_Sync__c = false';
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Xero_Key__c> scope) {
        System.assert(scope.size()==1);
        try{
            XeroSyncLogic.sync(scope[0].Id);
        }catch(Exception e){
            errorMessage += '<br/>'+'Failed to Sync Xero Org Id: '+ scope[0].Id+'. Error Message: '+ e.getMessage();
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        if(errorMessage != '' || Test.isRunningTest()){
            //send email to BSF Group Admin
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           list<String> toAddresses =  new list<String>();
           toAddresses.add('admin@britishschools.co.uk');
           
           
           //String[] toAddresses = new String[] {'ben.hails@britishschools.co.uk','kunal.sharma@britishschools.co.uk'};
           mail.setToAddresses(toAddresses);
           mail.setSubject('BSF Salesforce -Error(s) while processing XeroSyncBatch.');
           string emailText = 'There were errors processing Xero orgs for scheduled sync. Find error message below:';
           emailText += '</br>';
           emailText += errorMessage;
           mail.setHtmlBody(emailText);
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        }
    }
}