public with sharing class ContactTriggerHandler {
    /**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Contact Trigger Handler Class
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 18-MAY-2018  RRAJ   1.0     Initial Version
-- 21-SEP-2018  YGO    1.1     Added handleAfterUpdate()
-- 10-DEC-2018  ANA    1.2     Resolved Case 00001492, 00001450
-- 11-OCT-2019  ZRA    1.3     Added update Number of children when you manually add a Child
-- 14-OCT-2019  CRA    1.4     Implemented Case 00002035, Case 00002036, Case 00002070
-- 31-OCT-2019  BDU    1.5     Added method handleBeforeDelete
-- 23-JUL-2020  CRA    1.6     Comment all dependencies related to the Merge Functionality as it is not used
-- 19-APR-2021  FKH    1.7     Cater for Business Account Contacts
-- 29-JUN-2021	VJA	   1.8     Case 2529 - Make sure FirstName and LastName is filled before account renaming	
-- 30-JUN-2021  FKH    1.9     Update tech_recordtypeid on updating record types Case 3734
-- 24-SEP-2021  FKH	   2.2	   Case 00004164: BigFoot requirement
-- 28-FEB-2022  FKH	   2.3	   Comment additional query
-- 01-MAR-2022  FKH    2.3     Case 00004544: Bypass B2B Account
--------------------------------------------------------------------------------------
**************************************************************************************/
    //public boolean isExecuting = true;
    //public integer BatchSize = 0;
    
    private CS_Bypass__c userBypass;
    private String userProfileName;
    private User CurrUser;

    public ContactTriggerHandler(boolean isExecuting, integer size) {
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
		// userProfileName = [Select Id,Name from Profile where Id=:userinfo.getProfileId()].Name; //FKH - commented - not required
        CurrUser = [select id,Schoolcode__c,profile.Name from user where id=:userinfo.getuserid()];
        userProfileName = CurrUser.profile.Name;    //FKH - added
    }
    
    private static Map<String,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject}); //map of record types used in this class
    
    public void handleAfterDelete(List<Contact> lstOldCon){
        system.debug('### Starting handleAfterDelete');
        //System.debug('##### lstOldCon: '+lstOldCon);
        Map<Id, List<Id>> mapConIdToAccIds = new Map<Id, List<Id>>();
        Map<Id, String> mapAccConRole = new Map<Id, String>();
        Set<Id> setAccId = new Set<Id>();

        for(Contact con : lstOldCon){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP06')){
                if(con.RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeParent) && con.MasterRecordId != null){
                    if(mapConIdToAccIds.containsKey(con.MasterRecordId)){
                        mapConIdToAccIds.get(con.MasterRecordId).add(con.AccountId);
                    }else{
                        mapConIdToAccIds.put(con.MasterRecordId, new List<Id>{con.AccountId});
                    }
                }
                mapAccConRole.put(con.AccountId, con.NatureOfRelationship__c);
            }

            //CRA20191014 - Case 00002036: Update Account Number of Children if Child is deleted
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP25')){
                if (con.RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeChild)) {
                    setAccId.add(con.AccountId);
                }
            }
        }
        //System.debug('##### mapConIdToAccIds: '+mapConIdToAccIds);
        
        if(mapConIdToAccIds.size()>0){
            AP06_ReParentContacts.reparentContacts(mapConIdToAccIds, mapAccConRole);
        }
        
        if (setAccId.size() > 0) {
            AP25_AccountRules.setNumOfChild(setAccId);
        }
       system.debug('### Ending handleAfterDelete'); 
    }

    // public void handleBeforeDelete(List<Contact> lstOldCon){
    //     Id profileId = userinfo.getProfileId();
    //     String profileName = [Select Id,Name from Profile where Id=:profileId].Name;
    //     system.debug('ProfileName: ' + profileName);

    //     if(profileName.equals('Admissions Officer')){
    //         lstOldCon[0].addError('Not enough rights to delete');
    //     }
    // }
    
    public void handleBeforeInsert(List<Contact> lstNewCon){
        List<Contact> lstCon = new List<Contact>();
        List<Contact> lstConExternal = new List<Contact>();
        Set<String> setAcc = new Set<String>();
        List<Contact> lstFamilyCon = new List<Contact>();
        Set<String> setMidTierID = new Set<String>();
        Boolean isGetTeamProfile = false;
        
        if (userProfileName.equals('GET Team USE ME')){
            isGetTeamProfile = true;
            system.debug('GET TEAM');
        }
        
        for(Contact con : lstNewCon){
            if(con.Birthdate != null){
                con.TECH_DoBText__c = String.valueOf(con.Birthdate);
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP15')){
                if(con.SchoolOfInterest__c == null) {
                    if (con.RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeChild)){
                        lstCon.add(con);
                        setAcc.add(con.AccountId);
                    }
                    if (con.RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeExternalRelationships) && !isGetTeamProfile){
                        lstConExternal.add(con); // Case 3305 FKH
                    }
                        

                }
            }
            
            // if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP26')) { // Added by BDU //CRA20200723 - Comment due to Merge Functionality Non usage
            //     if((con.MidTierContactID__c != null) && (con.MidTierContactID__c.contains('.')) && !userProfileName.equals('Admissions Officer') && !userProfileName.equals('Champion/Super User')){
            //         lstFamilyCon.add(con);
            //         setMidTierID.add(con.MidTierContactID__c.split('\\.')[0]);
            //     }
            // }
      
            con.TECH_RecordTypeId__c = con.RecordTypeId;    //ANA20181012: Case 00001492
        }
        
        if(lstCon.size() > 0) {
            AP15_UpdateSchoolOfInterest.updateSchool(lstCon,setAcc);
        }

        if(lstConExternal.size() > 0) {
            AP15_UpdateSchoolOfInterest.updateSchoolBusinessAccount(lstConExternal,CurrUser.Schoolcode__c); // Case 3305 FKH
        }
        
        // if(lstFamilyCon.size()>0){ //Added by BDU  //CRA20200723 - Comment due to Merge Functionality Non usage
        //     AP26_FamilyContact.createFamilyContact(lstFamilyCon, setMidTierID, false);
        // }
    }
                        
    
    public void handleAfterInsert(List<Contact> lstNewCon){
        // system.debug('### Starting handleAfterInsert');
        List<Contact> lstConWithRel = new List<Contact>();
        Set<id> setConid = new Set<id>();
        Set<id> setAllConid = new Set<id>();        
        Set<id> setConAccountId = new Set<id>();
        List<Contact> lstContactToReassign= new List<Contact>();
        Set<ID> setSchoolIDToReassign = new Set<ID>();
        
        for(integer i=0; i<lstNewCon.size(); i++){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP14')){
                if(String.isNotBlank(lstNewCon[i].NatureOfRelationship__c)){
                    lstConWithRel.add(lstNewCon[i]);
                }
            }
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP16')){
                if(lstNewCon[i].TECH_RecordTypeName__c == 'Parent' && lstNewCon[i].FirstName != NULL && lstNewCon[i].LastName != NULL){ //afo //VJA20210629 - Case 2529
                    setConid.add(lstNewCon[i].id);
                }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP21')){
                setAllConid.add(lstNewCon[i].id);
            }
            
            // Add by  ZRA
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP25')) {
                lstContactToReassign.add(lstNewCon[i]); // FKH Case 00004164
                setSchoolIDToReassign.add(lstNewCon[i].schoolofinterest__c);
                
                if(lstNewCon[i].RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeChild)){
                    // lstConChild.add(lstNewCon[i]);
                    setConAccountId.add(lstNewCon[i].AccountId);                                        
                }
            }
            // End Add by  ZRA
        }
        
        if(setAllConid.size()>0){
            AP21_UpdateAccLastActivityDate.updateAccsLastActivityDate(setAllConid);
        }
        
        if(lstConWithRel.size()>0){
            AP14_UpdtAccConRelRoles.updtRole(lstConWithRel);
        }
        
        if(setConid.size()>0){
            AP16_UpdateAccName.updateAccnameByAccConRole(setConid);
        }
        
        // Add by ZRA
        if (setConAccountId.size() > 0) {
            AP25_AccountRules.setNumOfChild(setConAccountId);            
        }
        
        if(lstContactToReassign.size()>0){ // FKH Case 00004164
            AP25_AccountRules.assignRecordToCoordinator(lstContactToReassign, setSchoolIDToReassign);
        }
        // system.debug('### Ending handleAfterInsert');
    }
    
    public void handleBeforeUpdate(List<Contact> lstOldCon,List<Contact> lstNewCon){
        // system.debug('### Starting handleBeforeUpdate');
                System.debug('Before Update');     
        for(Integer i=0; i<lstNewCon.size(); i++){
            if((lstNewCon[i].Birthdate != lstOldCon[i].Birthdate) && lstNewCon[i].Birthdate != null){
                lstNewCon[i].TECH_DoBText__c = String.valueOf(lstNewCon[i].Birthdate);
            }
            if (lstNewCon[i].RecordTypeId != lstOldCon[i].RecordTypeId) {
                lstNewCon[i].TECH_RecordTypeId__c = lstNewCon[i].RecordTypeId;    //FKH Case 3734
            }
        }
        system.debug('### Ending handleBeforeUpdate');
    }
    
    public void handleAfterUpdate(List<Contact> lstOldCon,List<Contact> lstNewCon){
        system.debug('### Starting handleAfterUpdate');
        List<Contact> lstFamilyCon = new List<Contact>();
        List<Contact> lstFamilyConUpdated = new List<Contact>();
        Map<Id, Contact> mapCon = new Map<Id, Contact>();
        Map<Id, Contact> mapOldCon = new Map<Id, Contact>();
        Map<Id, Contact> mapNewCon = new Map<Id, Contact>();
        List<Contact> lstConWithRel = new List<Contact>();
        Map<Id, Contact> mapConUpdated = new Map<Id, Contact>();
        Set<Id> setAccId = new Set<Id>();
        Set<String> setMidTierID = new Set<String>();
        
        Set<id> setAllConid = new Set<id>();
        
        for(Integer i=0; i<lstNewCon.size(); i++){
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP13')){
                if(lstNewCon[i].Salutation != lstOldCon[i].Salutation || 
                   lstNewCon[i].FirstName != lstOldCon[i].FirstName || 
                   lstNewCon[i].MiddleName != lstOldCon[i].MiddleName ||
                   lstNewCon[i].LastName != lstOldCon[i].LastName ||
                   lstNewCon[i].Suffix != lstOldCon[i].Suffix){
                       mapCon.put(lstNewCon[i].Id,lstNewCon[i]);
                   }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP14')){   
                if(String.isNotBlank(lstNewCon[i].NatureOfRelationship__c)){
                    lstConWithRel.add(lstNewCon[i]);
                }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP16')){ 
                if(lstNewCon[i].FirstName != lstOldCon[i].FirstName || lstNewCon[i].LastName != lstOldCon[i].LastName) { 
                    mapOldCon.put(lstOldCon[i].Id, lstOldCon[i]);
                    mapNewCon.put(lstNewCon[i].Id, lstNewCon[i]);
                }
            }
            
            if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP21')){
                setAllConid.add(lstNewCon[i].id);
            }
            
            if (userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP25')) { 
                //CRA20191014 - Case 00002035: Update Account if its Primary Contact's Email, Phone or Address fields are changed
                // if (lstNewCon[i].Email != lstOldCon[i].Email || lstNewCon[i].Phone != lstOldCon[i].Phone 
                //     || lstNewCon[i].MailingCity != lstOldCon[i].MailingCity || lstNewCon[i].MailingCountry != lstOldCon[i].MailingCountry 
                //     || lstNewCon[i].MailingPostalCode != lstOldCon[i].MailingPostalCode || lstNewCon[i].MailingState != lstOldCon[i].MailingState 
                //     || lstNewCon[i].MailingStreet != lstOldCon[i].MailingStreet) {
                //     mapConUpdated.put(lstNewCon[i].Id, lstNewCon[i]);
                // }

                if ((lstNewCon[i].Email != lstOldCon[i].Email || lstNewCon[i].Phone != lstOldCon[i].Phone 
                || lstNewCon[i].City__c != lstOldCon[i].City__c || lstNewCon[i].CountryOfResidence__c != lstOldCon[i].CountryOfResidence__c 
                || lstNewCon[i].ZipPostalCode__c != lstOldCon[i].ZipPostalCode__c || lstNewCon[i].State__c != lstOldCon[i].State__c 
                || lstNewCon[i].AddressLine1__c != lstOldCon[i].AddressLine1__c || lstNewCon[i].AddressLine2__c != lstOldCon[i].AddressLine2__c
                || lstNewCon[i].AddressLine3__c != lstOldCon[i].AddressLine3__c) && lstNewCon[i].RecordTypeId != mapRecordType.get(AP_Constant.conRecordTypeExternalRelationships)) {//FKH Case 4544 - bypass B2B
                mapConUpdated.put(lstNewCon[i].Id, lstNewCon[i]);
            }


                //CRA20191014 - Case 00002036: Update Account Number of Children if Contact's Account is changed
                if (lstNewCon[i].AccountId != lstOldCon[i].AccountId && 
                    (lstNewCon[i].RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeChild) 
                     || lstOldCon[i].RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeChild) )) {
                    setAccId.add(lstNewCon[i].AccountId);
                    setAccId.add(lstOldCon[i].AccountId);
                }
            } 

            //  if (userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP26')) { //CRA20200723 - Comment due to Merge Functionality Non usage
            //     if(lstNewCon[i].TECH_FamilyContact__c != null && 
            //      lstNewCon[i].MidTierContactID__c != null && lstNewCon[i].MidTierContactID__c.contains('.') && 
            //      !userProfileName.equals('Admissions Officer') && !userProfileName.equals('Champion/Super User')  && 
            //     (lstNewCon[i].Salutation != lstOldCon[i].Salutation || 
            //         lstNewCon[i].FirstName != lstOldCon[i].FirstName || 
            //         lstNewCon[i].MiddleName != lstOldCon[i].MiddleName ||
            //         lstNewCon[i].LastName != lstOldCon[i].LastName || 
            //         lstNewCon[i].Email != lstOldCon[i].Email || 
            //         lstNewCon[i].Company__c != lstOldCon[i].Company__c ||
            //         lstNewCon[i].MobilePhone != lstOldCon[i].MobilePhone ||
            //         lstNewCon[i].Phone != lstOldCon[i].Phone ||
            //         lstNewCon[i].MailingCity != lstOldCon[i].MailingCity || 
            //         lstNewCon[i].MailingCountry != lstOldCon[i].MailingCountry ||
            //         lstNewCon[i].MailingPostalCode != lstOldCon[i].MailingPostalCode ||
            //         lstNewCon[i].MailingState != lstOldCon[i].MailingState  ||
            //         lstNewCon[i].MailingStreet != lstOldCon[i].MailingStreet ||
            //         lstNewCon[i].SchoolOfInterest__c != lstOldCon[i].SchoolOfInterest__c 
            //     )){
            //         lstFamilyCon.add(lstNewCon[i]);
            //     }

            //     else if(lstNewCon[i].TECH_FamilyContact__c != null && 
            //      !userProfileName.equals('Admissions Officer') && !userProfileName.equals('Champion/Super User')  && 
            //     (lstNewCon[i].Salutation != lstOldCon[i].Salutation || 
            //         lstNewCon[i].FirstName != lstOldCon[i].FirstName || 
            //         lstNewCon[i].MiddleName != lstOldCon[i].MiddleName ||
            //         lstNewCon[i].LastName != lstOldCon[i].LastName || 
            //         lstNewCon[i].Email != lstOldCon[i].Email || 
            //         lstNewCon[i].Company__c != lstOldCon[i].Company__c ||
            //         lstNewCon[i].MobilePhone != lstOldCon[i].MobilePhone ||
            //         lstNewCon[i].Phone != lstOldCon[i].Phone ||
            //         lstNewCon[i].MailingCity != lstOldCon[i].MailingCity || 
            //         lstNewCon[i].MailingCountry != lstOldCon[i].MailingCountry ||
            //         lstNewCon[i].MailingPostalCode != lstOldCon[i].MailingPostalCode ||
            //         lstNewCon[i].MailingState != lstOldCon[i].MailingState  ||
            //         lstNewCon[i].MailingStreet != lstOldCon[i].MailingStreet ||
            //         lstNewCon[i].SchoolOfInterest__c != lstOldCon[i].SchoolOfInterest__c 
            //         )){
            //         lstFamilyConUpdated.add(lstNewCon[i]);
            //     }
            // }
        }
        
        if(setAllConid.size()>0){
            AP21_UpdateAccLastActivityDate.updateAccsLastActivityDate(setAllConid);
        }
        
        if(mapCon.size() > 0){
            AP13_UpdateOppName.updateOppName(mapCon);
        }
        
        if(lstConWithRel.size()>0){	//Case 00001450
            AP14_UpdtAccConRelRoles.updtRole(lstConWithRel);
        }
        
        if(mapOldCon.size() > 0) {
            AP16_UpdateAccName.updateAccName(mapOldCon, mapNewCon);
        }
        
        if (mapConUpdated.size() > 0) {
            AP25_AccountRules.setPhoneAndEmailByContact(mapConUpdated);
        }
        
        if (setAccId.size() > 0) {
            AP25_AccountRules.setNumOfChild(setAccId);
        }
        
        // if(lstFamilyCon.size()>0){//Added by BDU //CRA20200723 - Comment due to Merge Functionality Non usage
        //     AP26_FamilyContact.createFamilyContact(lstFamilyCon, new Set<String>(), true);
        // }

        // if (lstFamilyConUpdated.size() > 0) {
        //     AP26_FamilyContact.updateMergeContact(lstFamilyConUpdated);
        // }
         system.debug('### Ending handleAfterUpdate');
    }
}