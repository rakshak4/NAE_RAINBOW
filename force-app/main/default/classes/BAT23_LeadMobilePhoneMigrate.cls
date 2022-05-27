/**
 * @description       : Batch Apex to update the Lead Mobile Phone field
 * @author            : Spoon Consulting
 * @group             : 
 * @last modified on  : 01-12-2021
 * @last modified by  : Spoon Consulting
 * Modifications Log 
 * Ver   Date         Author             Modification
 * 1.0   01-12-2021   VJA                Initial Version
**/
global class BAT23_LeadMobilePhoneMigrate implements Database.Batchable<sObject>, Database.Stateful {
    global String query;    
    global String ids = '';
    global Integer count = 0;
    global Integer listSize = 0;
    global BAT23_LeadMobilePhoneMigrate() {
        query='SELECT id, phone, MobilePhone, Parent1HomePhone__c, Parent1MobilePhone__c, createdDate FROM Lead WHERE MobilePhone != null';
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Lead> lstLead) {   
        // process each batch of records       
        
        String phone,mobilePhone,parent1MobilePhone,parent1HomePhone;
		listSize += lstLead.size();
        
        for(Lead lead : lstLead){
            if(lead.Parent1MobilePhone__c != null){

                phone = lead.Phone;
                mobilePhone = lead.MobilePhone;
                parent1MobilePhone = lead.Parent1MobilePhone__c;
                parent1HomePhone = lead.Parent1HomePhone__c;

                parent1MobilePhone = parent1MobilePhone.replaceAll('\\s+', '');
                parent1MobilePhone = parent1MobilePhone.replaceAll('-', '');
                parent1MobilePhone = parent1MobilePhone.replaceAll('\\(', '');
                parent1MobilePhone = parent1MobilePhone.replaceAll('\\)', '');

                mobilePhone = mobilePhone.replaceAll('\\s+', '');
                mobilePhone = mobilePhone.replaceAll('-', '');
                mobilePhone = mobilePhone.replaceAll('\\(', '');
                mobilePhone = mobilePhone.replaceAll('\\)', '');
                
                if(parent1HomePhone != null){
                    parent1HomePhone = parent1HomePhone.replaceAll('\\s+', '');
                    parent1HomePhone = parent1HomePhone.replaceAll('-', '');
                    parent1HomePhone = parent1HomePhone.replaceAll('\\(', '');
                    parent1HomePhone = parent1HomePhone.replaceAll('\\)', '');
                }

                // phone = phone.replaceAll('-', '');
                // phone = phone.replaceAll('\\s+', '');
                // phone = phone.replaceAll('\\(', '');
                // phone = phone.replaceAll('\\)', '');
                
                
                if(parent1MobilePhone == mobilePhone){ //1. Equal
                    count++;
                    lead.MobilePhone = null;
                }else if(parent1MobilePhone.length() > mobilePhone.length() && parent1MobilePhone.contains(mobilePhone)){ //2. Substring
                    count++;
                    lead.MobilePhone = null;
                }else if(parent1MobilePhone.length() < mobilePhone.length() && mobilePhone.contains(parent1MobilePhone)){ //3. Substring
                    count++;
                    lead.Parent1MobilePhone__c = lead.MobilePhone;
                    lead.MobilePhone = null;
                }
                
                else if(parent1HomePhone != null && parent1MobilePhone.length() > parent1HomePhone.length() && parent1MobilePhone.contains(parent1HomePhone)){ //4. Custom fields Substring
                    count++;
                    lead.Parent1HomePhone__c = lead.Parent1MobilePhone__c;
                    lead.Parent1MobilePhone__c = lead.MobilePhone;
                    lead.MobilePhone = null;
                }else if(parent1HomePhone != null && parent1MobilePhone.length() < parent1HomePhone.length() && parent1HomePhone.contains(parent1MobilePhone)){ //5. Custom fields Substring
                    count++;
                    lead.Parent1MobilePhone__c = lead.MobilePhone;
                    lead.MobilePhone = null;
                }else if(parent1HomePhone != null && parent1MobilePhone == parent1HomePhone){ //6. Both custom fields Equal
                    count++;
                    lead.Parent1MobilePhone__c = lead.MobilePhone;
                    lead.MobilePhone = null;
                }
                
                else if(parent1HomePhone != null && mobilePhone.length() > parent1HomePhone.length() && mobilePhone.contains(parent1HomePhone)){ //7. Cross fields Substring
                    count++;
                    lead.Parent1HomePhone__c = lead.MobilePhone;
                    lead.MobilePhone = null;
                }else if(parent1HomePhone != null && mobilePhone.length() < parent1HomePhone.length() && parent1HomePhone.contains(mobilePhone)){ //8. Cross fields Substring
                    count++;
                    lead.MobilePhone = null;
                }else if(parent1HomePhone != null && mobilePhone == parent1HomePhone){ //9. Both cross custom fields Equal
                    count++;
                    lead.MobilePhone = null;
                }else{
                    System.debug('------------');
                    System.debug(lead.id);
                    System.debug(lead.MobilePhone);
                    System.debug(lead.Parent1MobilePhone__c);
                    System.debug('------------');
                    ids = ids + '\'' + lead.id + '\', ';
                }
            }else{ //10. Parent1MobilePhone__c is null
                count++;
                lead.Parent1MobilePhone__c = lead.MobilePhone;
                lead.MobilePhone = null;
            }
        }

        update lstLead;
        System.debug('Phone Equal: ' + count);
        System.debug('Diff: ' + (lstLead.size() - count));
        System.debug(ids);		
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('###Phone Equal: ' + count);
        System.debug('###Ids: ' + ids);		

		AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id =: BC.getJobId()];
        try { // send completion mail.
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] { 'vyas.jallim@spoonconsulting.com' }; //set receiver of mail
            mail.setToAddresses(toAddresses);
            mail.setSubject('Phone Data Migrated ' + job.Status);
            mail.setPlainTextBody('Record processed ' + job.TotalJobItems + ' with ' + job.NumberOfErrors + ' failures.' + 'Ids to be treated manually: ' + ids + ' Processed/QuerySize: '+ count + '/' + listSize);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); // send email
            System.debug('#####Finish - BAT23_LeadMobilePhoneMigrate#####');
        } catch (Exception e) {
            System.debug('## Sending batch completion status mail ' + e);
        }
    }    
}