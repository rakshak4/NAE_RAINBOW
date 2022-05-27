global with sharing class Batch_PostContactsToXero implements Database.Batchable<sObject>, Database.AllowsCallouts{
    global string query;
    global string school;
    global list<Id> accountIds;
    global Batch_PostContactsToXero(string s) {
    	accountIds = new list<Id>();
    	accountIds.add('001D000001iKbck');
    	accountIds.add('001D000001dah43');
    	school = s;
        query = 'select Id, Xero_Contact_Id__c from Account where Xero_Contact_Id__c != null AND Company_School__c=:school AND Id IN:accountIds limit 1';
    
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {
    	Map<String,String> schoolAssignment = new Map<String,String>();
        List<Account_Owner_Mapping__c> settings = Account_Owner_Mapping__c.getall().values(); 
        for(Account_Owner_Mapping__c sttng:settings){
            if(sttng.School_Name__c != null && sttng.School_Short_Name__c != null){
                schoolAssignment.put(sttng.School_Name__c,sttng.School_Short_Name__c);
            }
        }
        string schoolShortName = schoolAssignment.get(school);
        if(schoolShortName == 'Pamplona') {
                    schoolShortName = 'Navarra'; 
                }
        Xero_Key__c xeroKey = [
                    SELECT Id, Name, Private_Key__c, Consumer_Key__c, Consumer_Secret__c, 
                        AccCode_Tuition__c, AccCode_Lunch__c, AccCode_Bus__c, AccCode_Other__c,
                        AccCode_Enrolment__c, AccCode_Application__c, AccCode_EAL__c, Tracking_Category_1_Company__c, Tracking_Category_2_Campus_Misc__c
                      FROM Xero_Key__c 
                     WHERE Name =: schoolShortName limit 1
                 ];
        list<sfXero.XeroContact> xeroContactList = new list<sfXero.XeroContact>();
        /*for(Account acc:scope){
        	sfXero.XeroContact xcon = new sfXero.XeroContact();
        	xcon.contactId = acc.Xero_Contact_Id__c;
        	xcon.contactNumber = acc.Id;
        	xeroContactList.add(xcon);
        }*/
        sfXero.XeroContact xcon = new sfXero.XeroContact();
    	xcon.contactId = '9accb7fb-5683-46b9-afc3-3ea7dc644dbf';
    	xcon.contactNumber = '';
    	xeroContactList.add(xcon);
        if(xeroContactList.size() > 0){
        	String consumerSecret = (xeroKey.Consumer_Secret__c == null) ? '' : xeroKey.Consumer_Secret__c;
            sfXero.XeroCredentials xeroCreds = new sfXero.XeroCredentials(xeroKey.Consumer_Key__c, consumerSecret, xeroKey.Private_Key__c);
            sfXero.XeroContactResponse response = sfXero.XeroAPI.postContacts(xeroContactList , xeroCreds);
            System.debug('### *****response ' +response);
        }
    }
    
    global void finish(Database.BatchableContext BC) {
    }
}