/**
 * @author 	SC 
 * @version 1.0
 * @since	12/10/2018
 *
 * Description : This class create batch that flag all family 
 *               accounts and their related contacts and opportunities
 *               with poor data quality 
 *                           
 *-- Maintenance History: 
 *--
 *-- Date         Name  Version  Remarks 
 *-- -----------  ----  -------  ------------------------
 *-- 12-10-2018   CRA    1.0     Initial version
 *-------------------------------------------------------
 * 
 */
global class BAT01_FlagPoorFamilyAccount implements Database.Batchable<sObject>, Schedulable {
	
	String query;
	Set<Id> setNoContactInfo = new Set<Id> ();
    Set<Id> setHasContactInfo = new Set<Id> ();
	
	/**
	 * Class constructor 
	 * @return [description]
	 */
	global BAT01_FlagPoorFamilyAccount() {
		//query = 'SELECT Id, PoorDataQuality__c FROM Account WHERE MidTierAccountID__c != null AND RecordType.DeveloperName = \'Family\' ' + 'and id = \'0010O00002A43vN\'';
		query = 'SELECT Id, PoorDataQuality__c FROM Account WHERE MidTierAccountID__c != null AND RecordType.DeveloperName = \'Family\' ';
	}
	
	//Retrieve family account with their related contact and opportunity with poor data quality 
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

	//Flag all retrieved family account and their related contact and opportunity
   	global void execute(Database.BatchableContext BC, List<Account> lstAccount) {   		
        List<Contact> lstContact = new List<Contact> ();
        List<Opportunity> lstOpportunity = new List<Opportunity> ();   		
        Set<Id> setGoodFullname = new Set<Id> ();
        Set<Id> setGoodContactInfo = new Set<Id> ();        

        Set<id> setAccHasCon= new Set<id>();
            
        for(Contact con : [SELECT AccountId, FirstName, LastName, Name, Phone, MobilePhone, Email, RecordType.DeveloperName 
                           FROM Contact WHERE AccountId IN :lstAccount]) {
            setAccHasCon.add(con.AccountId);
            
            if( ( String.isNotBlank(con.FirstName) && !(con.FirstName.contains('unknown')) && !(con.FirstName.equals('*')) && !(con.FirstName.equals('-')) ) 
                || ( !(con.LastName.contains('unknown')) && !(con.LastName.equals('*')) && !(con.LastName.equals('-')) ) ){
                setGoodFullname.add(con.AccountId);
            }
            
            if((con.MobilePhone != null || con.Phone != null || con.Email != null) && con.RecordType.DeveloperName != AP_Constant.conRecordTypeDeveloperNameChild ) {
                setHasContactInfo.add(con.AccountId);
                if(setNoContactInfo.contains(con.AccountId)){
                    setNoContactInfo.remove(con.AccountId);
                }
            } 
            else if((con.MobilePhone == null && con.Phone == null && con.Email == null) && con.RecordType.DeveloperName != AP_Constant.conRecordTypeDeveloperNameChild ) {
                if(!setHasContactInfo.contains(con.AccountId)){
                    setNoContactInfo.add(con.AccountId);
                }
                
            }
		}
        
        System.debug('##setNoContactInfo:' + setNoContactInfo);
        System.debug('##setGoodFullname:' + setGoodFullname);
        
		for(Opportunity opp : [SELECT AccountId, ReferredByContact__c, ReferredBy__c, RelatedAccount__c FROM Opportunity 
                               WHERE AccountId IN :setNoContactInfo 
                               AND (ReferredByContact__c != null 
                               OR ReferredBy__c != null 
                               OR RelatedAccount__c != null )]) {
			setGoodContactInfo.add(opp.AccountId);
		}
        
        System.debug('##setAccHasCon:' + setAccHasCon);
        System.debug('##setNoContactInfo:' + setNoContactInfo);
        System.debug('##setGoodFullname:' + setGoodFullname);
        System.debug('##setGoodContactInfo:' + setGoodContactInfo);
        
		if(lstAccount.size() > 0) {
			for(Account acc : lstAccount) {
                if(setAccHasCon.contains(acc.Id) == false){
                    acc.PoorDataQuality__c = false;
                    System.debug('##1');
                }
                else if(setNoContactInfo.contains(acc.Id) == false && setGoodFullname.contains(acc.Id) == false){
                    acc.PoorDataQuality__c = true;
                    System.debug('##2');
                }
                else if((setGoodFullname.contains(acc.Id) == false || setGoodContactInfo.contains(acc.Id) == false) && setNoContactInfo.contains(acc.Id) ){
                    acc.PoorDataQuality__c = true;
                    System.debug('##3');
                }
                else {
                    acc.PoorDataQuality__c = false;
                    System.debug('##4');
                }
			}
			update lstAccount;
		}		

	}

	//
	global void finish(Database.BatchableContext BC) {
		AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id =: BC.getJobId()];
        /*try { // send completion mail.
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] { job.CreatedBy.Email }; //set receiver of mail
            mail.setToAddresses(toAddresses);
            mail.setSubject('Batch Flag Poor Family Account ' + job.Status);
            mail.setPlainTextBody('Record processed ' + job.TotalJobItems + ' with ' + job.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); // send email
        } catch (Exception e) {
            System.debug('## Sending batch completion status mail ' + e);
        }*/
	}

	//Execute schedule for an automatic batch
    global void execute(SchedulableContext SC) {
        BAT01_FlagPoorFamilyAccount batchObject = new BAT01_FlagPoorFamilyAccount();
        Id batchId = Database.executeBatch(batchObject);
    }
	
}