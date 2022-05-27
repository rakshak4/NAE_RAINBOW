/**
 * @File Name          : AP26_FamilyContact.cls
 * @Description        : Apex Class for creating family contact 
 * @Author             : CRA
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 07-23-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    28/10/2019          BDU                   Initial Version
 * 1.1    23/07/2020          CRA                   Comment codes due to Merge Functionality non usage
**/

public with sharing class AP26_FamilyContact {

    /**
    * @description Create family contact based on Midtier contact ID splitted by period
    * @author BDU | 28/10/2019 
    * @param A list of conctacts lstContact 
    * @return void 
    **/
    // public static void createFamilyContact(List<Contact> lstContact, Set<String> setMidTierID, Boolean isUpdate){
    //     Contact newFatherContact, newMotherContact, conToUpdate;
    //     List<String> lstFamilyCont = new List<String>();
    //     List<String> lstMidTIerContId = new List<String>();
    //     Map<String,Id> mapContactRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject}); //map of record types used in this class
    //     Map<String, Contact> mapFamilyContact = new Map<String, COntact>();
    //     Map<String, Contact> mapFamilyContactToUpdate = new Map<String, COntact>();
    //     Map<String, Contact> mapFamilyContactToInsert = new Map<String, COntact>();
    //     Map<String, List<Contact>> mapConToUpdate = new Map<String, List<Contact>>();
    //     Map<String, Contact> mapExistingFamilyCon = new Map<String, Contact>();
    //     List<Contact> lstConToUpdate = new List<Contact>();

    //     if (setMidTierID.size() > 0) {            
    //         for (Contact con : [SELECT Id, TECH_FamilyContact__c, MidTierContactID__c FROM Contact WHERE MidTierContactID__c IN :setMidTierID]) {
    //             mapExistingFamilyCon.put(String.valueOf(con.MidTierContactID__c), con);
    //         }
    //     }

    //     for(Contact c : lstContact){
    //         System.debug('c.MidTierContactID__c' + c.MidTierContactID__c);
    //         lstFamilyCont = c.MidTierContactID__c.split('\\.'); //E.g. of midTierId BANGKOK-PARENT-10149.2 --> Split by '.' to get details of father(1) and mother(2)
    //         System.debug('lstFamilyCont' + lstFamilyCont);
    //         lstMidTIerContId = lstFamilyCont[0].split('-'); //Split by '-' to get the external ID
    //         newFatherContact = new Contact();
    //         newMotherContact = new Contact();
    //         conToUpdate = new Contact();

    //         if(lstFamilyCont[1] == '1'){ //Check if contact is a father
    //             if(mapFamilyContact.containsKey(lstFamilyCont[0]) || mapExistingFamilyCon.containsKey(lstFamilyCont[0])){
    //                 if (mapFamilyContact.containsKey(lstFamilyCont[0])) {
    //                     newFatherContact = mapFamilyContact.get(lstFamilyCont[0]);
    //                 }
    //                 else {
    //                     newFatherContact = mapExistingFamilyCon.get(lstFamilyCont[0]);
    //                 }

    //                 newFatherContact.FirstName = c.FirstName;
    //                 newFatherContact.LastName = c.LastName;
    //                 newFatherContact.MiddleName = c.MiddleName;
    //                 newFatherContact.Email = c.Email;
    //                 newFatherContact.Salutation = c.Salutation;
    //                 newFatherContact.Company__c = c.Company__c;
    //                 newFatherContact.Contact_Location__c = 'Home';
    //                 newFatherContact.NatureOfRelationship__c = 'Parents';
    //                 newFatherContact.MobilePhone = c.MobilePhone;
    //                 newFatherContact.Phone = c.Phone;
    //                 newFatherContact.MailingCity = c.MailingCity;
    //                 newFatherContact.MailingCountry = c.MailingCountry;
    //                 newFatherContact.MailingPostalCode = c.MailingPostalCode;
    //                 newFatherContact.MailingState = c.MailingState;
    //                 newFatherContact.MailingStreet = c.MailingStreet;
    //                 newFatherContact.SchoolOfInterest__c = c.SchoolOfInterest__c;
    //             }
    //             else{
    //                 newFatherContact = new Contact( //Create a contact for the Father
    //                     RecordTypeId = mapContactRecordType.get(AP_Constant.conRecordTypeFamily),
    //                     AccountId = c.AccountId,
    //                     FirstName = c.FirstName,
    //                     LastName = c.LastName,
    //                     MiddleName = c.MiddleName,
    //                     Email = c.Email,
    //                     Salutation = c.Salutation,
    //                     Company__c = c.Company__c,
    //                     Contact_Location__c = 'Home',
    //                     NatureOfRelationship__c = 'Parents',
    //                     MobilePhone = c.MobilePhone,
    //                     Phone = c.Phone,
    //                     MidTierContactID__c = lstFamilyCont[0],
    //                     MailingCity = c.MailingCity,
    //                     MailingCountry = c.MailingCountry,
    //                     MailingPostalCode = c.MailingPostalCode,
    //                     MailingState = c.MailingState,
    //                     MailingStreet = c.MailingStreet,
    //                     SchoolOfInterest__c = c.SchoolOfInterest__c
    //                 );
    //             }            

    //             System.debug('newFatherContact' + newFatherContact);     
    //             if(c.TECH_FamilyContact__c != null) {
    //                 newFatherContact.Id = c.TECH_FamilyContact__c;
    //                 mapFamilyContactToUpdate.put(lstFamilyCont[0], newFatherContact);
    //             }    
    //             else if (mapExistingFamilyCon.containsKey(lstFamilyCont[0])) {
    //                 mapFamilyContactToUpdate.put(lstFamilyCont[0], newFatherContact);
    //             }
    //             else {
    //                 mapFamilyContactToInsert.put(lstFamilyCont[0], newFatherContact);
    //             }
    //             mapFamilyContact.put(lstFamilyCont[0], newFatherContact);
    //         }
    //         else if(lstFamilyCont[1] == '2'){  
    //             if(mapFamilyContact.containsKey(lstFamilyCont[0]) || mapExistingFamilyCon.containsKey(lstFamilyCont[0])){
    //                 if (mapFamilyContact.containsKey(lstFamilyCont[0])) {
    //                     newMotherContact = mapFamilyContact.get(lstFamilyCont[0]);
    //                 }
    //                 else {
    //                     newMotherContact = mapExistingFamilyCon.get(lstFamilyCont[0]);
    //                 }
                    
    //                 newMotherContact.txtSecondaryForename__c = c.FirstName;
    //                 newMotherContact.txtSecondarySurname__c = c.LastName;
    //                 newMotherContact.txtSecondaryMiddleNames__c = c.MiddleName;
    //                 newMotherContact.txtEmail2__c = c.Email;
    //                 newMotherContact.txtSecondaryTitle__c = c.Salutation;
    //                 newMotherContact.txtSecondaryProfession__c = c.Company__c;
    //                 newMotherContact.Contact_Location__c = 'Home';
    //                 newMotherContact.txtMobile2__c = c.MobilePhone;
    //                 newMotherContact.txtDayTelephone__c = c.Phone;
    //                 newMotherContact.OtherCity = c.MailingCity;
    //                 newMotherContact.OtherCountry = c.MailingCountry;
    //                 newMotherContact.OtherPostalCode = c.MailingPostalCode;
    //                 newMotherContact.OtherState = c.MailingState;
    //                 newMotherContact.OtherStreet = c.MailingStreet;
    //                 newMotherContact.SchoolOfInterest__c = c.SchoolOfInterest__c;
    //             }
    //             else{             
    //                 newMotherContact = new Contact( 
    //                     Lastname = c.LastName, //Set a dummy last name on standard field
    //                     RecordTypeId = mapContactRecordType.get(AP_Constant.conRecordTypeFamily),
    //                     AccountId = c.AccountId,
    //                     txtSecondaryForename__c = c.FirstName,
    //                     txtSecondarySurname__c = c.LastName,
    //                     txtSecondaryMiddleNames__c = c.MiddleName,
    //                     txtEmail2__c = c.Email,
    //                     txtSecondaryTitle__c = c.Salutation,
    //                     txtSecondaryProfession__c = c.Company__c,
    //                     Contact_Location__c = 'Home',
    //                     txtMobile2__c = c.MobilePhone,
    //                     txtDayTelephone__c = c.Phone,
    //                     MidTierContactID__c = lstFamilyCont[0],
    //                     OtherCity = c.MailingCity,
    //                     OtherCountry = c.MailingCountry,
    //                     OtherPostalCode = c.MailingPostalCode,
    //                     OtherState = c.MailingState,
    //                     OtherStreet = c.MailingStreet,
    //                  	SchoolOfInterest__c = c.SchoolOfInterest__c
    //                 );
    //             }
            
    //             System.debug('newMotherContact' + newMotherContact);                
    //             mapFamilyContact.put(lstFamilyCont[0], newMotherContact);
    //             if(c.TECH_FamilyContact__c != null) {
    //                 newMotherContact.Id = c.TECH_FamilyContact__c;
    //                 mapFamilyContactToUpdate.put(lstFamilyCont[0], newMotherContact);
    //             }   
    //             else if (mapExistingFamilyCon.containsKey(lstFamilyCont[0])) {
    //                 mapFamilyContactToUpdate.put(lstFamilyCont[0], newMotherContact);
    //             }
    //             else {
    //                 mapFamilyContactToInsert.put(lstFamilyCont[0], newMotherContact);
    //             }                
    //         }   

    //         if (c.TECH_FamilyContact__c == null ) {
    //             if (isUpdate) {
    //                 if (mapConToUpdate.containsKey(lstFamilyCont[0])) {
    //                     mapConToUpdate.get(lstFamilyCont[0]).add(new Contact(Id = c.Id));
    //                 }
    //                 else {
    //                     mapConToUpdate.put(lstFamilyCont[0], new List<Contact> { new Contact(Id = c.Id) });
    //                 }   
    //             }
    //             else {
    //                 if (mapConToUpdate.containsKey(lstFamilyCont[0])) {
    //                     mapConToUpdate.get(lstFamilyCont[0]).add(c);
    //                 }
    //                 else {
    //                     mapConToUpdate.put(lstFamilyCont[0], new List<Contact> {c} );
    //                 }   
    //             }
    //         }             
    //     } 
    //     System.debug('mapFamilyContact' + mapFamilyContact);
    //     if(mapFamilyContactToInsert.size()>0){
    //         insert mapFamilyContactToInsert.values();           
    //     }
    //     if (mapConToUpdate.size() > 0) {
    //         for (String midTierId :  mapConToUpdate.keySet()) {
    //             for (Contact cont : mapConToUpdate.get(midTierId)) {
    //                 if (mapFamilyContactToInsert.size() > 0 && mapFamilyContactToInsert.containsKey(midTierId)) {
    //                     cont.TECH_FamilyContact__c = mapFamilyContactToInsert.get(midTierId).Id;
    //                 }
    //                 else if (mapExistingFamilyCon.size() > 0 && mapExistingFamilyCon.containsKey(midTierId)){
    //                     cont.TECH_FamilyContact__c = mapExistingFamilyCon.get(midTierId).Id;
    //                 }
                    
    //                 if (isUpdate) {
    //                     lstConToUpdate.add(cont);
    //                 }
    //             }
    //         }
    //     }   

    //     if (mapFamilyContactToUpdate.size() > 0 && mapFamilyContactToUpdate.values().size() > 0) {
    //         lstConToUpdate.addAll(mapFamilyContactToUpdate.values());
    //     }
        
    //     if (lstConToUpdate.size() > 0) {
    //         update lstConToUpdate;
    //     }
    // }

    // public static void mergeContact(String ctcFirstId, String ctcSecondId, String accId, Boolean status){
    //     Map<String,Id> mapContactRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject}); //map of record types used in this class
    //     Map<String, Contact> mapCtc = new Map<String, Contact>();
    //     List<Contact> lstUpd = new List<Contact>();

    //     Map<Id, Contact> mapConParents = new Map<Id, Contact>([SELECT TECH_FamilyContact__c, FirstName, LastName, MiddleName
    //                                                                 , Email, Salutation, Company__c, MobilePhone, Phone , MailingStreet
    //                                                                 , MailingCity, MailingCountry, MailingPostalCode, MailingState, SchoolOfInterest__c
    //                                                             FROM Contact
    //                                                             WHERE id IN :new Set<String> {ctcFirstId, ctcSecondId}]);

    //     System.debug('Status: ' + status);
    //     if(status){
    //         if(String.isNotBlank(ctcFirstId) && String.isBlank(ctcSecondId) && String.isNotBlank(accId)){
    //             System.debug('### 1');
    //             Contact familyCtc = new Contact();
    //             Contact updCtc = new Contact();
    //             List<Contact> lstCtc = new List<Contact> ();
    //             Contact con = mapConParents.get(ctcFirstId); // select parent 1

    //             if(con.TECH_FamilyContact__c == null){ // no Family Contact then create
    //                 System.debug('### 1.1 Fill Parent 1 information ' + con );
    //                 familyCtc.FirstName = con.FirstName;
    //                 familyCtc.LastName = con.LastName;
    //                 familyCtc.MiddleName = con.MiddleName;
    //                 familyCtc.Email = con.Email;
    //                 familyCtc.Salutation = con.Salutation;
    //                 familyCtc.Company__c = con.Company__c;
    //                 familyCtc.MobilePhone = con.MobilePhone;
    //                 familyCtc.Phone = con.Phone;
    //                 familyCtc.RecordTypeId = mapContactRecordType.get(AP_Constant.conRecordTypeFamily);
    //                 familyCtc.NatureOfRelationship__c = 'Parents';
    //                 familyCtc.Contact_Location__c = 'Home';
    //                 familyCtc.AccountId = accId;
    //                 familyCtc.MailingCity = con.MailingCity;
    //                 familyCtc.MailingCountry = con.MailingCountry;
    //                 familyCtc.MailingPostalCode = con.MailingPostalCode;
    //                 familyCtc.MailingState = con.MailingState;
    //                 familyCtc.MailingStreet = con.MailingStreet;                   
    //                 familyCtc.SchoolOfInterest__c = con.SchoolOfInterest__c;
                    
    //                 insert familyCtc;
    //                 con.TECH_FamilyContact__c = familyCtc.id;
    //                 System.debug('### 1.1.1 ' + con );
    //             }
    //             con.TECH_MergePosition__c = '1';
    //             lstUpd.addAll(new List<Contact> {con, familyCtc});
    //         }
    //         else if(String.isNotBlank(ctcFirstId) && String.isNotBlank(ctcSecondId)){
    //             System.debug('### 2');
    //             Contact newFamilyctc = new Contact();
    //             Contact updCtc = new Contact();

    //             for(Contact con : mapConParents.values()){
    //                 System.debug('### con ' + con.TECH_FamilyContact__c );
    //                 if(con.TECH_FamilyContact__c == null){
    //                     updCtc.id = con.id;
    //                     newFamilyctc.txtSecondaryForename__c = con.FirstName;
    //                     newFamilyctc.txtSecondarySurname__c = con.LastName;
    //                     newFamilyctc.txtSecondaryMiddleNames__c = con.MiddleName;
    //                     newFamilyctc.txtEmail2__c = con.Email;
    //                     newFamilyctc.txtSecondaryTitle__c = con.Salutation;
    //                     newFamilyctc.txtSecondaryProfession__c = con.Company__c;
    //                     newFamilyctc.txtMobile2__c = con.MobilePhone;   
    //                     newFamilyctc.txtDayTelephone__c = con.Phone;                     
    //                     // newFamilyctc.txtRelationType__c = 'Parents';  
    //                     newFamilyctc.Contact_Location__c = 'Home';
    //                     newFamilyctc.OtherCity = con.MailingCity;
    //                     newFamilyctc.OtherCountry = con.MailingCountry;
    //                     newFamilyctc.OtherPostalCode = con.MailingPostalCode;
    //                     newFamilyctc.OtherState = con.MailingState;
    //                     newFamilyctc.OtherStreet = con.MailingStreet;
    //                 }
    //                 else{
    //                     newFamilyCtc.id = con.TECH_FamilyContact__c;
    //                     newFamilyctc.FirstName = con.FirstName;
    //                     newFamilyctc.LastName = con.LastName;
    //                     newFamilyctc.MiddleName = con.MiddleName;
    //                     newFamilyctc.Email = con.Email;
    //                     newFamilyctc.Salutation = con.Salutation;
    //                     newFamilyctc.Company__c = con.Company__c;
    //                     newFamilyctc.MobilePhone = con.MobilePhone;
    //                     newFamilyctc.Phone = con.Phone;               
    //                     newFamilyctc.NatureOfRelationship__c = 'Parents';  
    //                     newFamilyctc.Contact_Location__c = 'Home'; 
    //                     newFamilyctc.MailingCity = con.MailingCity;
    //                     newFamilyctc.MailingCountry = con.MailingCountry;
    //                     newFamilyctc.MailingPostalCode = con.MailingPostalCode;
    //                     newFamilyctc.MailingState = con.MailingState;
    //                     newFamilyctc.MailingStreet = con.MailingStreet;
    //                     newFamilyctc.SchoolOfInterest__c = con.SchoolOfInterest__c;
    //                     updCtc.TECH_FamilyContact__c = con.TECH_FamilyContact__c;
    //                 }
    //                 updCtc.TECH_MergePosition__c = '2';
    //             }
    //             lstUpd.addAll(new List<Contact> {newFamilyCtc, updCtc});
    //         }
    //     }
    //     else{   
    //         // System.debug('Unchecking.....');
    //         Contact familyCtc = new Contact(); 
    //         Contact updCtc = new Contact();           
    //         Contact con = new Contact(); // select parent 1

    //         if(String.isNotBlank(ctcFirstId) && String.isNotBlank(ctcSecondId) && String.isNotBlank(accId)){
    //             con = mapConParents.get(ctcSecondId);
    //             updCtc = new Contact(id = ctcFirstId, TECH_FamilyContact__c = null, TECH_MergePosition__c = null);
    //             if(con.TECH_FamilyContact__c != null){
    //                 familyCtc.id = con.TECH_FamilyContact__c;
    //                 familyCtc.FirstName = con.FirstName;
    //                 familyCtc.LastName = con.LastName;
    //                 familyCtc.MiddleName = con.MiddleName;
    //                 familyCtc.Email = con.Email;
    //                 familyCtc.Salutation = con.Salutation;
    //                 familyCtc.Company__c = con.Company__c;
    //                 familyCtc.MobilePhone = con.MobilePhone;
    //                 familyCtc.Phone = con.Phone;
    //                 familyCtc.MailingCity = con.MailingCity;
    //                 familyCtc.MailingCountry = con.MailingCountry;
    //                 familyCtc.MailingPostalCode = con.MailingPostalCode;
    //                 familyCtc.MailingState = con.MailingState;
    //                 familyCtc.MailingStreet = con.MailingStreet;
    //                 familyCtc.NatureOfRelationship__c = 'Parents';
    //                 familyCtc.SchoolOfInterest__c = con.SchoolOfInterest__c;
    //                 familyCtc.txtSecondaryForename__c = null;
    //                 familyCtc.txtSecondarySurname__c = null;
    //                 familyCtc.txtSecondaryMiddleNames__c = null;
    //                 familyCtc.txtEmail2__c = null;
    //                 familyCtc.txtSecondaryTitle__c = null;
    //                 familyCtc.txtSecondaryProfession__c = null;
    //                 familyCtc.txtMobile2__c = null;
    //                 familyCtc.txtDayTelephone__c = null;
    //                 familyCtc.OtherCity = null;
    //                 familyCtc.OtherCountry = null;
    //                 familyCtc.OtherPostalCode = null;
    //                 familyCtc.OtherState = null;
    //                 familyCtc.OtherStreet = null;
    //                 // familyCtc.txtRelationType__c = null;
    //             }
    //             lstUpd.addAll(new List<Contact> {updCtc, familyCtc, new Contact(Id = ctcSecondId, TECH_MergePosition__c = '1')});
    //         }
    //         else if((String.isNotBlank(ctcFirstId) && String.isBlank(ctcSecondId))){
    //             con = mapConParents.get(ctcFirstId);
    //             familyCtc.id = con.TECH_FamilyContact__c;
    //             delete familyCtc;
    //         }
    //     }        
    //     System.debug('lstUpd: ' + lstUpd);
    //     if(lstUpd.size()>0){
    //         update lstUpd;
    //     }
    // }

    // public static void updateMergeContact(List<Contact> lstConUpdated) {
    //     List<Contact> lstConFamily = new List<Contact>();
    //     for (Contact con : lstConUpdated) {
    //         if (con.TECH_MergePosition__c == '1') {
    //             lstConFamily.add(new Contact(
    //                 Id = con.TECH_FamilyContact__c,
    //                 FirstName =con.FirstName,
    //                 LastName = con.LastName,
    //                 MiddleName = con.MiddleName,
    //                 Email = con.Email,
    //                 Salutation = con.Salutation,
    //                 Company__c = con.Company__c,
    //                 MobilePhone = con.MobilePhone,
    //                 Phone = con.Phone,              
    //                 MailingCity = con.MailingCity,
    //                 MailingCountry = con.MailingCountry,
    //                 MailingPostalCode = con.MailingPostalCode,
    //                 MailingState = con.MailingState,
    //                 MailingStreet = con.MailingStreet,
    //                 SchoolOfInterest__c = con.SchoolOfInterest__c                  
    //             ));
    //         }
    //         if (con.TECH_MergePosition__c == '2') {
    //             lstConFamily.add(new Contact(
    //                 Id = con.TECH_FamilyContact__c,
    //                 txtSecondaryForename__c = con.FirstName,
    //                 txtSecondarySurname__c = con.LastName,
    //                 txtSecondaryMiddleNames__c = con.MiddleName,
    //                 txtEmail2__c = con.Email,
    //                 txtSecondaryTitle__c = con.Salutation,
    //                 txtSecondaryProfession__c = con.Company__c,
    //                 txtMobile2__c = con.MobilePhone,
    //                 txtDayTelephone__c = con.Phone,                   
    //                 OtherCity = con.MailingCity,
    //                 OtherCountry = con.MailingCountry,
    //                 OtherPostalCode = con.MailingPostalCode,
    //                 OtherState = con.MailingState,
    //                 OtherStreet = con.MailingStreet
    //             ));
    //         }
    //     }

    //     System.debug('lstConFamily ' +lstConFamily);
    //     if (lstConFamily.size() > 0) {
    //         update lstConFamily;
    //     }
    // }
}