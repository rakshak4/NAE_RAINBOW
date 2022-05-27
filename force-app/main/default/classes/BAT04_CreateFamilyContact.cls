/**
 * @File Name          : BAT04_CreateFamilyContact.cls
 * @Description        : Batch to create family contact for Data Patching of all migrated data
 * @Author             : CRA
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 07-23-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    13/11/2019         CRA                    Initial Version
 * 1.1    23/07/2020         CRA                    Comment codes due to Merge Functionality non usage
**/
global class BAT04_CreateFamilyContact implements Database.Batchable<sObject>{

    String query;

    global BAT04_CreateFamilyContact(String schoolCode) {
    //     System.debug('#####Begin - BAT04_CreateFamilyContact#####');
    //     query = 'SELECT Id, MidTierContactID__c, TECH_FamilyContact__c, FirstName, LastName, MiddleName'+
    //                     ', Email, Salutation, Company__c, MobilePhone, Phone, MailingStreet, AccountId' +
    //                     ', MailingCity, MailingCountry, MailingPostalCode, MailingState, SchoolOfInterest__c'+
    //             ' FROM Contact WHERE RecordType.Name=\'Parent\'' +
    //             ' AND TECH_FamilyContact__c = null AND MidtierContactID__c like \'%'+schoolCode+'%\' AND MidtierContactID__c like \'%.%\'';
    //     System.debug('Query ' + query);
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
    //     System.debug('#####QueryLocator#####');
	    return Database.getQueryLocator(query);
	}

    global void execute(Database.BatchableContext BC, List<Contact> lstContact) {  
    //     System.debug('#####Execute#####');
    //     Set<String> setMidTierID = new Set<String>();
    //     if (lstContact.size() > 0) {
    //         for (Contact con : lstContact) {
    //             setMidTierID.add(con.MidTierContactID__c.split('\\.')[0]);
    //         }
    //         AP26_FamilyContact.createFamilyContact(lstContact, setMidTierID, true);
    //     } 
    }

    global void finish(Database.BatchableContext BC) {
	// 	AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
    //                         FROM AsyncApexJob
    //                         WHERE Id =: BC.getJobId()];
    //     try { // send completion mail.
    //         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    //         String[] toAddresses = new String[] { job.CreatedBy.Email }; //set receiver of mail
    //         mail.setToAddresses(toAddresses);
    //         mail.setSubject('Batch Create Family Account ' + job.Status);
    //         mail.setPlainTextBody('Record processed ' + job.TotalJobItems + ' with ' + job.NumberOfErrors + ' failures.');
    //         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); // send email
    //         System.debug('#####Finish - BAT04_CreateFamilyContact#####');
    //     } catch (Exception e) {
    //         System.debug('## Sending batch completion status mail ' + e);
    //     }
	}
}