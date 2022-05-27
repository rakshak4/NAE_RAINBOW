//batch process to update parent login on related contact
global with sharing class Batch_UserLoginUpdate implements Database.Batchable<sObject>,Database.Stateful{
    String query; 
    DateTime hourBefore = DateTime.now().addHours(-5);  
    global string errorMessage ; 
    global Batch_UserLoginUpdate() {
        errorMessage = '';
        //query = 'Select l.UserId, l.Status, l.SourceIp, l.Platform, l.LoginUrl, l.LoginType, l.LoginTime, l.Id, l.ClientVersion, l.Browser, l.Application, l.ApiVersion, l.ApiType From LoginHistory l where l.LoginTime >=:hourBefore order by l.UserId, l.LoginTime desc';
        query = 'Select l.UserId, l.Status, l.SourceIp, l.Platform, l.LoginUrl, l.LoginType, l.LoginTime, l.Id, l.ClientVersion, l.Browser, l.Application, l.ApiVersion, l.ApiType From LoginHistory l where l.LoginTime != null order by l.UserId, l.LoginTime desc';
    
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<LoginHistory> scope) {
        system.debug('***Batch_UserLoginUpdate***execute***scope='+scope);
        set<Id> userIds = new set<Id>();
        map<Id,LoginHistory> userLoginHistory = new map<Id,LoginHistory>();
        for(LoginHistory lh:scope){
            if(lh.Status == 'Success'){
                userIds.add(lh.UserId);
                if(!userLoginHistory.containsKey(lh.UserId)){
                    userLoginHistory.put(lh.UserId,lh);
                } 
            }
        }       
        system.debug('***Batch_UserLoginUpdate***execute***userIds='+userIds);
        system.debug('***Batch_UserLoginUpdate***execute***userLoginHistory='+userLoginHistory);
        if(userIds.size() > 0){
            list<Contact> contactsToBeUpdated = new list<Contact>();
            for(User u:[select Id,ContactId, Contact.User_Last_Login__c, AccountId from User where Id IN:userIds AND Is_Portal_User__c = true AND ContactId != null]){
                LoginHistory lh = userLoginHistory.get(u.Id);
                if(lh != null){
                    if(u.Contact.User_Last_Login__c < lh.LoginTime || Contact.User_Last_Login__c == null){
                        Contact con = new Contact(Id=u.ContactId);
                        con.User_Last_Login__c = lh.LoginTime;
                        contactsToBeUpdated.add(con);
                    }
                }
            }
            system.debug('***Batch_UserLoginUpdate***execute***contactsToBeUpdated='+contactsToBeUpdated);
            if(contactsToBeUpdated.size() > 0){
                //update contactsToBeUpdated;
                list<Database.SaveResult> srList = Database.update(contactsToBeUpdated,false);
                integer i = 0;
                for(Database.Saveresult sr:srlist){
                    if(!sr.isSuccess()){
                        if(errorMessage == ''){
                            errorMessage += 'Error Occured while processing user login history ';
                        }
                        errorMessage += 'Error Occured updating contact record = '+contactsToBeUpdated[i]+'. Error Message: '+sr.getErrors();
                    }
                    i++;
                }
            }
        }
    }
    
    global void finish(Database.BatchableContext BC) {
         if(errorMessage != ''){
            //send email to Ben, Kunal
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           list<String> toAddresses =  new list<String>();
           toAddresses.add('ben.hails@britishschools.co.uk');
           toAddresses.add('kunal.sharma@britishschools.co.uk');
           
           //String[] toAddresses = new String[] {'ben.hails@britishschools.co.uk','kunal.sharma@britishschools.co.uk'};
           mail.setToAddresses(toAddresses);
           mail.setSubject('Error while processing user login history.');
           string emailText = 'There were errors processing contact records for login history update. Find error message below:';
           emailText += '\n';
           emailText += errorMessage;
           mail.setPlainTextBody(emailText);
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        }
    }
}