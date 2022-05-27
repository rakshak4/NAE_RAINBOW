/**
 * @File Name          : AP25_AccountRules.cls
 * @Description        : Apex Class for Implementing Rules on Account
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 14/10/2019, 10:47:59
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    14/10/2019          CRA                   Initial Version
 * 1.1    26/11/2019          CRA                   Implemented Case 00001818, Case 00002090
 * 1.2	  09/04/2021 		  FKH					Update business account name - derived from name
 * 1.3    24/09/2021		  FKH					Case 00004164: BigFoot requirement
 * 1.4    27/01/2022          YRA                   Case 00004624: Add FA Online Form User 

**/
public with sharing class AP25_AccountRules {

    /**
    * @description Update Account Phone and Email if Primary Contact value is updated
    * @author CRA | 14/10/2019 
    * @param mapAccCon 
    * @return void 
    **/
    public static void setPhoneAndEmail(Map<Id, Account> mapAccCon) {
        // for (Contact con : [SELECT Email, Phone, MailingCity, MailingCountry, MailingPostalCode, MailingState, MailingStreet FROM Contact WHERE Id IN :mapAccCon.keyset()]) {
        for (Contact con : [SELECT Email, Phone, City__c, CountryOfResidence__c, ZipPostalCode__c, State__c, AddressLine1__c,AddressLine2__c,AddressLine3__c FROM Contact WHERE Id IN :mapAccCon.keyset()]) {
            mapAccCon.get(con.Id).Email__c = con.Email;
            mapAccCon.get(con.Id).Phone = con.Phone; 
            // mapAccCon.get(con.Id).BillingCity = con.MailingCity; //CRA20191126 - Case 00001818: Update Account Address fields
            // mapAccCon.get(con.Id).BillingCountry = con.MailingCountry;
            // mapAccCon.get(con.Id).BillingPostalCode = con.MailingPostalCode;
            // mapAccCon.get(con.Id).BillingState = con.MailingState;
            // mapAccCon.get(con.Id).BillingStreet = con.MailingStreet;
            mapAccCon.get(con.Id).BillingCity = con.City__c; //CRA20191126 - Case 00001818: Update Account Address fields
            mapAccCon.get(con.Id).BillingCountry = con.CountryOfResidence__c; ///FKH
            mapAccCon.get(con.Id).BillingPostalCode = con.ZipPostalCode__c;
            mapAccCon.get(con.Id).BillingState = con.State__c;
            mapAccCon.get(con.Id).BillingStreet = getAddress(con.AddressLine1__c, con.AddressLine2__c, con.AddressLine3__c);
        }
    }

    /**
    * @description Update Account Phone and Email if Primary Contact's Phone or Email is updated
    * @author CRA | 14/10/2019 
    * @param mapCon 
    * @return void 
    **/
    public static void setPhoneAndEmailByContact(Map<Id, Contact> mapCon) {
        List<Account> lstAccToUpdate = new List<Account>();


        
        for (Account acc : [SELECT Id, PrimaryContact__c FROM Account WHERE PrimaryContact__c IN :mapCon.keyset()]) {
            lstAccToUpdate.add( 
                new Account(Id = acc.Id
                            , Email__c = mapCon.get(acc.PrimaryContact__c).Email
                            , Phone = mapCon.get(acc.PrimaryContact__c).Phone
                            // , BillingCity = mapCon.get(acc.PrimaryContact__c).MailingCity //CRA20191126 - Case 00001818: Update Account Address fields
                            // , BillingCountry = mapCon.get(acc.PrimaryContact__c).MailingCountry
                            // , BillingPostalCode = mapCon.get(acc.PrimaryContact__c).MailingPostalCode
                            // , BillingState = mapCon.get(acc.PrimaryContact__c).MailingState
                            // , BillingStreet = mapCon.get(acc.PrimaryContact__c).MailingStreet) 
                            , BillingCity = mapCon.get(acc.PrimaryContact__c).City__c //CRA20191126 - Case 00001818: Update Account Address fields
                            , BillingCountry = mapCon.get(acc.PrimaryContact__c).CountryOfResidence__c  //FKH
                            , BillingPostalCode = mapCon.get(acc.PrimaryContact__c).ZipPostalCode__c
                            , BillingState = mapCon.get(acc.PrimaryContact__c).State__c
                            //, BillingStreet = mapCon.get(acc.PrimaryContact__c).AddressLine1__c + ', ' + mapCon.get(acc.PrimaryContact__c).AddressLine2__c + ', ' + mapCon.get(acc.PrimaryContact__c).AddressLine3__c) 
                            , BillingStreet = getAddress(mapCon.get(acc.PrimaryContact__c).AddressLine1__c,mapCon.get(acc.PrimaryContact__c).AddressLine2__c, mapCon.get(acc.PrimaryContact__c).AddressLine3__c)
                
                            ));
        }

        if (lstAccToUpdate.size() > 0) {
            update lstAccToUpdate;
        }
    }

    public static String getAddress(String Line1, String Line2, String Line3){
        if(line1==null && line2==null && line3==null){
            return '';
        }
        else if(line1==null && line2!=null && line3==null){
            return line2;
        }
        else if(line1==null && line2==null && line3!=null){
            return line3;
        }
        else if(line1!=null && line2==null && line3==null){
            return line1;
        }      
        else if(line1==null && line2!=null && line3!=null){
            return line2+', '+ line3;
        } 
        else if(line1!=null && line2!=null && line3==null){
            return line1+', '+ line2;
        } 
        else if(line1!=null && line2==null && line3!=null){
            return line1+', '+ line3;
        } 
        
        return line1+', '+ line2+', '+ line3;
    }

    /**
    * @description Update Number of children when you manually add a Child
    * @author ZRA | 14/10/2019 
    * @param setConAccountId
    * @return void 
    **/
    public static void setNumOfChild (Set<Id> setConAccountId) {
        List<Account> lstAccUpdate = new List<Account> ();
        for (AggregateResult ar : [SELECT accountid, count(id)num FROM Contact WHERE RecordType.Name =: AP_Constant.conRecordTypeDeveloperNameChild AND AccountId IN :setConAccountId GROUP BY accountid]) {
            lstAccUpdate.add(new Account(Id=String.valueOf(ar.get('AccountId')), NumberOfChildren__c=String.valueOf(ar.get('num'))));
        }

        if (lstAccUpdate.size() > 0) {
            update lstAccUpdate;
        }        
    }


    /**
    * @description Case 00002090: Set schoolOfInterest related to the owner's schoolCode
    * @author CRA | 26/11/2019 
    * @param mapAccToOwner 
    * @return void 
    **/
    public static void setSchoolOfInterest (Map<Id, List<Account>> mapAccToOwner) {
        Map<String, Id> mapSchool = new Map<String, Id>();
        Set<String> setSchoolCode = new Set<String>();
        Map<Id, String> mapUserSchoolCode = new Map<Id, String>();
        for (User owner : [SELECT Id, SchoolCode__c FROM User WHERE Id IN :mapAccToOwner.keyset()]) {
            if (owner.SchoolCode__c != null) {  
                mapUserSchoolCode.put(owner.Id, owner.SchoolCode__c);
                setSchoolCode.add(owner.SchoolCode__c);
            }
        }

        if (setSchoolCode.size() > 0) {
            for (School__c sch : [SELECT Id, SchoolCode__c FROM School__c WHERE SchoolCode__c IN :setSchoolCode]) {
                mapSchool.put(sch.SchoolCode__c, sch.Id);
            }
        }

        if (mapSchool.size() > 0) {
            System.debug('mapSchool ' +mapSchool);
            for (Id ownerId : mapAccToOwner.keyset()) {
                if (mapAccToOwner.get(ownerId).size() > 0 && mapUserSchoolCode.get(ownerId) != null) {
                    for (Account acc : mapAccToOwner.get(ownerId)) {
                        System.debug('SchoolOfInterest__c ' +mapSchool.get(mapUserSchoolCode.get(ownerId)));
                        acc.SchoolOfInterest__c = mapSchool.get(mapUserSchoolCode.get(ownerId));
                    }
                }
            }
        }
    }
    
        /**
    * @description Update business account name - derived from name
    * @author FKH | 09/04/2021 
    * @param lstBusinessAcc 
    * @return void 
    **/
    public static void setBusinessOriginalAccountName(List <Account> lstBusinessAcc) {
        for(Account acc: lstBusinessAcc ){
				acc.OriginalAccountName__c  = acc.Name;
        }
    }
    
        /**
    * @description Case 00004164: Set new record owner if Mulesoft User - Bigfoot project
    * @description YRA- Case 00004624: Set new record owner if FA Online Forms User -
    * @author FKH | 24/09/2021 
    * @param lstAcc, @param setSchoolID
    * @return void 
    **/
    public static void assignRecordToCoordinator (List<SObject> lstsObjects, Set<ID> setSchoolID) {
        Map<ID, User> mapUsers = new Map<ID,User>([SELECT Id,name FROM User WHERE Name IN ('Mulesoft Mulesoft', 'FA Online Forms')]); //get user id
        Map<ID, School__c> mapSchoolIDToSchoolCordinator = new Map<ID, School__c>([SELECT Id, AdmissionsQueueCoordinator__c FROM School__c where id in:setSchoolID ]); // get map of school id with respective coordinator
        List<SObject> sObjectsToUpdate = new List<SObject>();

        if(mapUsers.size()>0){ // check if user retrieved
            for (SObject sobj : lstsObjects) { //iterate list of sObject 
                if(mapUsers.containsKey((ID) sobj.get('Ownerid')) && sobj.get('schoolofinterest__c')!=null && mapSchoolIDToSchoolCordinator.get((ID) sobj.get('schoolofinterest__c')).AdmissionsQueueCoordinator__c!=null){ //check if owner is Mulesoft & get coordinator
                    SObject newSobjectAdded = sobj.id.getSObjectType().newSObject(sobj.id); //to be addded in sObjectsToUpdate
                    newSobjectAdded.put('Ownerid',mapSchoolIDToSchoolCordinator.get((ID) sobj.get('schoolofinterest__c')).AdmissionsQueueCoordinator__c); //set new owner id value
                    newSobjectAdded.put('id',sobj.id); //set id
                    sObjectsToUpdate.add(newSobjectAdded);
                }
            }
        }
        if(sObjectsToUpdate.size()>0)
            update sObjectsToUpdate;
    }
    
}