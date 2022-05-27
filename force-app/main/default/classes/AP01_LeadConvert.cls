public class AP01_LeadConvert {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for Lead Conversion, Contact and Opportunity Creation
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 01-DEC-2017  RRAJ    1.0     Initial version
-- 04-DEC-2018  ANA     1.1     Resolved Case 00001470, 00001504, 00001545, 00001533, 00001555, 00001557, W459
-- 14-JAN-2019  CRA     1.2     Send Acknowledgment Email to parent - W000344
-- 20-MAR-2019  CRA     1.3     Resolved Case 00001679, 00001726
-- 01-APR-2019  CRA     1.4     Store Acknowlegment Email in Account level - w000344
-- 20-MAY-2019  CRA     1.5     Set Contact1 as Primary Contact - W000516
-- 02-JUL-2019  CRA     1.6     Map Has Attended Summercamp field - W000531
-- 31-JUL-2019  CRA     1.7     Removed Sixth child Section - Application Form R2.0
-- 13-SEP-2019  CRA     1.8     Implement Case 00001974
-- 21-OCT-2019  CRA     1.9     Implement Case 00002064
-- 19-JUN-2020  CRA     1.10    Implement Case 00002304
-- 26-NOV-2020  FKH     1.11	Added marketing fields (on Lead Conversion)
-- 14-Mar-2021  VJA     1.12    Fields comment for cleanup
-- 22-OCT-2021  VJA     1.13    IsAgent Boolean Added
--------------------------------------------------------------------------------------
***************************************************************************************/
    
private static Map<String,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject}); //map of record types used in this class
private static Map<String, Contact> mapTempIdToCon = new Map<String, Contact>();
private static Map<String, Opportunity> mapTempIdToOpp = new Map<String, Opportunity>();
private static Map<Id,Id> mapAccAgents = new Map<Id,Id>();
private static Set<Contact> setConToDel = new Set<Contact>();
private static List<Account> lstAccToUpdate = new List<Account>();
private static Map<Id, Account> mapAccToUpdate = new Map<Id, Account>();
private static Map<Id, String> mapCampaignNameLead = new Map<Id, String>();
private static Map<Id, String> mapFinancialContacts = new Map<Id, String>();
private static Map<Id, Id> mapLeadCmpId = new Map<Id, Id>();
    
/**
* [createFamily description]
* @param mapLead [description]
*/
public static void createFamily(Map<Id, Lead> mapLead){
    //System.debug('###### ConvertLED');
    
    //convert lead to contacts && Opportunities
    createContactOpps(mapLead.values());
    
    //delete standard contact create from conversion
    if(setConToDel.size()>0){
        System.debug('##### setConToDel: '+JSON.serialize(setConToDel));
        delete new List<Contact>(setConToDel);
    }
    
    //inserting contacts
    System.debug('#### mapTempIdToCon: '+mapTempIdToCon);
    List<CampaignMember> lstCmpMembers = new List<CampaignMember>();
    if(mapTempIdToCon.values().size() > 0){
        system.debug('### mapTempIdToCon.values() ' + mapTempIdToCon.values() );
        insert mapTempIdToCon.values();
        System.debug('#### mapTempIdToCon.values(): '+mapTempIdToCon.values());

        //if(mapCampaignNameLead.size() > 0) { //insert campaign member - CRA20190710 : W-000556
            //   lstCmpMembers = createCampaignMember(mapTempIdToCon);
        //}
        //else { //update Campaign member - CRA20190416 : Case 00001726
            if(setConToDel.size() > 0) {
                lstCmpMembers = getCampaignMember(setConToDel, mapTempIdToCon);
            }
        //}
    }
    
    //inserting Campaign Members
    System.debug('### lstCmpMembers ' + lstCmpMembers); 
    if(lstCmpMembers.size() > 0) {
        insert lstCmpMembers;
    }

    //update roles of Account contact relationships
    List<AccountContactRelation> lstAccConRel = [SELECT Id, ContactId, AccountId, Roles FROM AccountContactRelation WHERE ContactId IN :mapTempIdToCon.values()];
    lstAccConRel = createAccConRel(lstAccConRel, mapTempIdToCon.values());
    
    if(mapAccAgents.size() > 0){
        //Add AccountContactRelation for Agent(s)
        lstAccConRel.addAll(addAgentsToAccConRelationship(mapAccAgents));
        
        //set Agent(s) as primaryContact 
        setAgentsPrimaryContact(mapAccAgents);   
    }

    if (mapFinancialContacts.size() > 0) {
        //Update Financial Contact for Account
        setFinancialContact(mapFinancialContacts, mapTempIdToCon);  
    }
    
    if(lstAccConRel.size()>0){
        upsert lstAccConRel;
    }

    //CRA - Set Parent1 as Primary Contact - W000516
    setParent1PrimaryContact(mapTempIdToCon);

    //CRA - Update accounts
    if(mapAccToUpdate.size() > 0) {
        update mapAccToUpdate.values();
    }
    
    //inserting opportunities
    System.debug('#### mapTempIdToOpp: '+mapTempIdToOpp);
    for(String tempId : mapTempIdToOpp.keySet()){
        mapTempIdToOpp.get(tempId).Child__c = mapTempIdToCon.get(tempId).Id;
        if (mapLeadCmpId.containsKey(tempId.substringBefore('child'))) { //CRA20200619 - Case00002304
            mapTempIdToOpp.get(tempId).CampaignId = mapLeadCmpId.get(tempId.substringBefore('child')); 
        }
    }
    if(mapTempIdToOpp.values().size() > 0){
        insert mapTempIdToOpp.values();
    }
}
    
/**
* [createAccConRel description]
* @param  lstAccConRel [description]
* @param  lstCon       [description]
* @return              [description]
*/
private static List<AccountContactRelation> createAccConRel(List<AccountContactRelation> lstAccConRel, List<Contact> lstCon) {
    Map<Id, Contact> mapCon = new Map<Id, Contact>(lstCon);
    for(AccountContactRelation accConRel : lstAccConRel){
        if(mapCon.get(accConRel.ContactId).RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeParent)){
            accConRel.Roles = mapCon.get(accConRel.ContactId).NatureOfRelationship__c;
        }
        if(mapCon.get(accConRel.ContactId).RecordTypeId == mapRecordType.get(AP_Constant.conRecordTypeChild)){
            accConRel.Roles = AP_Constant.accConRelRoleChild;
        }
    }
    return lstAccConRel;
}
    
/**
* [updateAccEmail description]
* @param mapAccToSchlId [description]
*/
public static void updateAccEmail(Map<Account, Id> mapAccToSchlId) {
    Map<Id, School__c> mapSchool = new Map<Id, School__c>([SELECT Id, AdmissionsQueueCoordinator__r.Email FROM School__c WHERE Id IN :mapAccToSchlId.values()]);
    List<Account> lstAccToUpdate = new List<Account>();
    for(Account acc : mapAccToSchlId.keySet()){
        acc.TECH_SchoolAdmQueueEmail__c = mapSchool.get(mapAccToSchlId.get(acc)).AdmissionsQueueCoordinator__r.Email;
    }
    //System.debug('##### mapAccToSchlId: '+mapAccToSchlId);
}
    
/**
* [addAgentsToAccConRelationship description]
* @param Map<Id,Id> mapAccAgents
*/
public static List<AccountContactRelation> addAgentsToAccConRelationship(Map<Id,Id> mapAccAgents) {
    List<AccountContactRelation> lstAccConRel = new List<AccountContactRelation>();
    
    for(Id AccId: mapAccAgents.keySet()){
        lstAccConRel.add(new AccountContactRelation(AccountId = AccId , ContactId = mapAccAgents.get(AccId), Roles = 'Agent'));
    }
    
    return lstAccConRel;
}
    
/**
* [setAgentsPrimaryContact description]
* @param Map<Id,Id> mapAccAgents
*/
public static void setAgentsPrimaryContact(Map<Id,Id> mapAccAgents) {
    List<Account> lstAccount = [SELECT ID, PrimaryContact__c
                                FROM Account
                                Where ID IN: mapAccAgents.keySet()];
    
    if(lstAccount.size() > 0){
        for(Account acc : lstAccount){
            acc.PrimaryContact__c = mapAccAgents.get(acc.ID);  
            // CRA20190520 - Edit to update all accounts in mapAccToUpdate
            if (mapAccToUpdate.containsKey(acc.Id)) {
                mapAccToUpdate.get(acc.Id).PrimaryContact__c = mapAccAgents.get(acc.ID);
            }
            else {
                mapAccToUpdate.put(acc.Id, new Account(Id = acc.Id, PrimaryContact__c = mapAccAgents.get(acc.ID) ) );
            } 
        }   
    }
}

    
/**
* [getRecordTypeNameById description]
* @param objectName 
* @param strRecordTypeId
*/
public static String getRecordTypeNameById(String objectName, Id strRecordTypeId) {
    String recordTypeName =  Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosById().get(strRecordTypeId).getName();
    return (recordTypeName == AP_Constant.oppRecordTypeJulliardSummerArtsLabel ? AP_Constant.oppRecordTypeJulliardSummerArts : AP_Constant.oppRecordTypeEnrolment);
} 

    
/**
* [updateOwnership w-344 CRA20190222 - update owner of account, contact, opportunity after lead assignement rule fired]
* @param mapLeadConvertedAcc [description]
**/
public static void updateOwnership(Map<Id, Lead> mapLeadConvertedAcc) {
    List<Contact> lstConToUpdate = new List<Contact>();
    List<Opportunity> lstOppToUpdate = new List<Opportunity>();
    List<Account> lstAccToUpd = new List<Account>();
    List<Id> lstAccountId = new List<Id>();
    Map<Id, String> mapAccSch = new Map<Id, String>();
    Map<Id, Id> mapAccCon = new Map<Id, Id>();
    List<Opportunity> lstOppWeChat = new List<Opportunity>();

    
    //set account owner
    for(Account acc : [SELECT Id
                            , OwnerId
                            , OnlineApplication__c
                            , TECH_SendACKMTDate__c
                            , SchoolOfInterest__r.AdmissionsQueueCoordinator__c
                            , SchoolOfInterest__r.Name
                            , SchoolOfInterest__r.ActivateApplicationForm__c 
                            , FinancialContact__c
                        FROM Account 
                        WHERE TECH_SendACKMTDate__c = null AND id IN : mapLeadConvertedAcc.keySet()
                        ]){
        String ledOwner = mapLeadConvertedAcc.get(acc.Id).OwnerId;
        //set owner id
        acc.OwnerId = getOwnerId(ledOwner, acc.SchoolOfInterest__r.AdmissionsQueueCoordinator__c);

        //send acknowlegment email to owner
        if(acc.SchoolOfInterest__r.ActivateApplicationForm__c && acc.OnlineApplication__c) {
            acc.TECH_SendACKMTDate__c = Datetime.now();
            mapAccSch.put(acc.Id, acc.SchoolOfInterest__r.Name);
        }
        
        lstAccToUpd.add(acc);
        lstAccountId.add(acc.Id);
    }
        
    if(lstAccountId.size() > 0) {
        //set contact owner 
        for(Contact con : [SELECT Id, OwnerId, SchoolOfInterest__r.AdmissionsQueueCoordinator__c, AccountId, LeadPosition__c, Account.OnlineApplication__c FROM Contact WHERE AccountId IN :lstAccountId]){
            String ledOwner = mapLeadConvertedAcc.get(con.AccountId).OwnerId;
            con.OwnerId = getOwnerId(ledOwner, con.SchoolOfInterest__r.AdmissionsQueueCoordinator__c);
            lstConToUpdate.add(con);

            //get parent 1 ID
            if(con.LeadPosition__c == AP_Constant.leadPositionParent1 && con.Account.OnlineApplication__c) {
                mapAccCon.put(con.AccountId, con.Id);
            }
        }
        
        //set opportunity owner
        for(Opportunity opp : [SELECT Id, OwnerId, SchoolOfInterest__r.AdmissionsQueueCoordinator__c, AccountId, LeadOrigin__c, CreatedDate FROM Opportunity WHERE AccountId IN :lstAccountId]){
            String ledOwner = mapLeadConvertedAcc.get(opp.AccountId).OwnerId;
            opp.OwnerId = getOwnerId(ledOwner, opp.SchoolOfInterest__r.AdmissionsQueueCoordinator__c);
            lstOppToUpdate.add(opp);

            //if(opp.LeadOrigin__c == AP_Constant.ledOriginWeChat) {
                //lstOppWeChat.add(opp);
            //}
        }
        
        if(lstAccToUpd.size() > 0) {
            System.debug('##update acc ' +lstAccToUpd);
            update lstAccToUpd;
        }
        if(lstConToUpdate.size() > 0) {
            System.debug('##update con ' +lstConToUpdate);
            update lstConToUpdate;
        }
        if(lstOppToUpdate.size() > 0) {
            System.debug('##update opp ' +lstOppToUpdate);
            update lstOppToUpdate;
        }
    }

    //if (lstOppWeChat.size() > 0) {
        //createVisitEvent(lstOppWeChat);
    //}

    if (mapAccSch.size() > 0 && mapAccCon.size() > 0) {
        sendAcknowlegdmentEmail(mapAccSch,mapAccCon);
    }
    
}
    
    
/**
* [getOwnerId w-344 CRA20190222 - check if lead owner is a queue and return the admissions Queue Coordinator ID]
* @param  ownerIdtoCheck [description]
* @param  admQueueId     [description]
* @return                [description]
*/
private static String getOwnerId(String ownerIdtoCheck, String admQueueId) {
    String ownerId = ownerIdtoCheck;
    if(String.valueOf(ownerIdtoCheck).startsWith('00G') && String.isNotBlank(admQueueId)) {
        ownerId = admQueueId;
    }
    return ownerId;
}


/**
 * [sendAcknowlegdmentEmail w-000344 Send Acknowlegdment email to Parent 1 - CRA20190409]
 * @param mapAccSchool [description]
 * @param mapIdAccCon  [description]
 */
@future(callout=true)
private static void sendAcknowlegdmentEmail(Map<Id, String> mapAccSchool, Map<Id, Id> mapIdAccCon) {
    List<Messaging.SingleEmailMessage>  emails = new List<Messaging.SingleEmailMessage>();
    List<ContentVersion> lstConVer = new List<ContentVersion> ();
    EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE Name='ACC_Application Acknowledgement' LIMIT 1]; 
    if(mapAccSchool.size() > 0 && mapIdAccCon.size() > 0 && et != null) {
        Map<Id, Id> mapAccOrgWideId = getOrgWideId(mapAccSchool);
        for(Id accId : mapAccSchool.keySet()) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            mail.setTargetObjectId(mapIdAccCon.get(accId)); 
            mail.setUseSignature(false); 
            mail.setBccSender(false); 
            mail.setSaveAsActivity(true); 
            mail.setWhatId(accId);
            mail.setTemplateId(et.Id); 
            mail.setOrgWideEmailAddressId(mapAccOrgWideId.get(accId));
            PageReference pageRef = new PageReference('/apex/VFP02_AccApplicationForm?id='+accId+'&gen=auto');
            Messaging.EmailFileAttachment emailAttachement = new Messaging.EmailFileAttachment();
            Blob emailBody = Test.isRunningTest() ? Blob.valueOf('Some Text') : pageRef.getContentAsPdf();
            emailAttachement.setBody(emailBody);
            emailAttachement.setFileName('ApplicationForm.pdf');
            emailAttachement.setinline(false);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttachement});
            emails.add(mail);

            //create contentVersion for the attachement
            lstConVer.add(createContentVersion(emailBody));
        }

        try{
            if(emails.size() > 0) { //send email
                Messaging.SendEmailResult [] r = Messaging.sendEmail(emails);
            }
            if (lstConVer.size() > 0) { //CRA20191021 - Case00002064: insert attachment into Files
                insert lstConVer; 
                insertContentDocumentLink(lstConVer, new List<Id>(mapAccSchool.keySet()));
            }
        }
        catch(Exception e) {
            
        }
    }
    
}

/**
 * [getOrgWideId w-000344 CRA20190401 map organization wide address per account]
 * @param  mapAccSchool [description]
 * @return              [description]
 */
private static Map<Id, Id> getOrgWideId(Map<Id, String> mapAccSchool) {
    Map<Id, Id> mapAccOrgId = new Map<Id, Id>();
    for(OrgWideEmailAddress owea : [SELECT Id, DisplayName, Address FROM OrgWideEmailAddress]) {
        for(Id accId : mapAccSchool.keySet()) {
            if(mapAccSchool.get(accId).contains(owea.DisplayName)) {
                mapAccOrgId.put(accId, owea.Id);
            }
        }
    }
    return mapAccOrgId;
}

/**
 * [getCampaignMember Case 00001726 - CRA20190416]
 * @param  setIdConDeleted [description]
 * @param  mapCon   [description]
 * @return          [description]
 */
private static List<CampaignMember> getCampaignMember(Set<Contact> setConDeleted, Map<String, Contact> mapCon) {
    List<CampaignMember> lstCampaignMembers = new List<CampaignMember>();
    for(CampaignMember cmpMember : [SELECT Id, LeadId, ContactId, CampaignId FROM CampaignMember WHERE ContactId IN :setConDeleted ALL ROWS]) {
        lstCampaignMembers.add(new CampaignMember(ContactId = mapCon.get(cmpMember.LeadId +'parent1').Id, CampaignId = cmpMember.CampaignId));
        mapLeadCmpId.put(cmpMember.LeadId, cmpMember.CampaignId); //CRA20200619 - Case 00002304
    }
    
    return lstCampaignMembers;
    
}

/**
* @description W-000556
* @author CRA | 10/07/2019
* @param Map<String, Contact> mapCon
* @return List<CampaignMember>
*/
private static List<CampaignMember> createCampaignMember(Map<String, Contact> mapCon) {
    List<CampaignMember> lstCampaignMembers = new List<CampaignMember>();
    Map<String, Id> mapCmp = new Map<String, Id>();
    //Selecting existing campaigns
    for(Campaign cmp : [SELECT Name, Id FROM Campaign WHERE Name IN :mapCampaignNameLead.values()]){
        mapCmp.put(cmp.Name, cmp.Id);
    }

    if(mapCmp.size() > 0) {
        for(Id ledId : mapCampaignNameLead.keySet()) {
            if(mapCmp.get(mapCampaignNameLead.get(ledId)) != null) {
                lstCampaignMembers.add(new CampaignMember(ContactId = mapCon.get(ledId +'parent1').Id, CampaignId = mapCmp.get(mapCampaignNameLead.get(ledId))));
            }
        }
    }
    return lstCampaignMembers;
}

/**
 * [setParent1PrimaryContact CRA - W00516 - 20190520]
 * @param mapTempIdToCon [description]
 */
private static void setParent1PrimaryContact(Map<String, Contact> mapTempIdToCon) {
    for(String conId : mapTempIdToCon.keySet()) {
        if(conId.contains('parent1')) {
            Contact con = mapTempIdToCon.get(conId);
            if (mapAccToUpdate.containsKey(con.AccountId)) {
                mapAccToUpdate.get(con.AccountId).PrimaryContact__c = con.Id;
            }
            else {
                mapAccToUpdate.put(con.AccountId, new Account(Id = con.AccountId, PrimaryContact__c = con.Id));
            }    
        }
    }
}

/**
 * [setFinancialContact CRA20190913 - Case00001974 ]
 * @param mapAccFeesPayer [description]
 * @param mapTempIdToCon [description]
 */
private static void setFinancialContact(Map<Id, String> mapAccFeesPayer, Map<String, Contact> mapTempIdToCon) {
    for(String conId : mapTempIdToCon.keySet()) {
        if(conId.contains('parent') && mapTempIdToCon.get(conId).FirstName +' '+ mapTempIdToCon.get(conId).LastName == mapAccFeesPayer.get(Id.valueOf(conId.SubstringBefore('parent')) )) {
            Contact con = mapTempIdToCon.get(conId);
            System.debug('test cra ' +con);
            if (mapAccToUpdate.containsKey(con.AccountId)) {
                mapAccToUpdate.get(con.AccountId).FinancialContact__c = con.Id;
            }
            else {
                mapAccToUpdate.put(con.AccountId, new Account(Id = con.AccountId, FinancialContact__c = con.Id));
            }        
        }
    }
}

/**
* @description - Create Visit Event for WeChat Lead - W000556
* @author CRA | 10/07/2019
* @param List<Opportunity> lstOpp
* @return void
*/
public static void createVisitEvent(List<Opportunity> lstOpp) {
    List<Event> listEvts = new List<Event>();
    for (Opportunity opp : lstOpp){
        Event evt = new Event();
        evt.WhatId = opp.Id;
        evt.Subject = 'Visit';
        evt.Status__c = 'Completed';
        evt.Type = '1 on 1 visit';
        evt.TaskCompletionDateTime__c = opp.CreatedDate;
        evt.ActivityDate = opp.CreatedDate.date();
        evt.IsAllDayEvent = true;
        evt.OwnerId = opp.OwnerId;
        listEvts.add(evt);
    }
    
    if(listEvts.size() > 0) {
        insert listEvts;
        system.debug('## listEvts' + listEvts);
    }
}

/**
* @description - Create ContentDocumentLink for new Application Form on Account - Case00002064
* @author CRA | 21/10/2019 
* @param lstAccId 
* @return void 
**/
private static void insertContentDocumentLink(List<ContentVersion> lstConVer, List<Id> lstAccId) {
    Map<Id, Id> mapContVer = new Map<Id, Id>();
    List<ContentDocumentLink> lstConDocLink = new List<ContentDocumentLink>();
    for(Integer i=0 ; i<lstAccId.size() ; i++) {
        mapContVer.put(lstConVer[i].Id, lstAccId[i]);
    }

    for(ContentVersion conDoc :  [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :mapContVer.keySet()]) {
        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = conDoc.ContentDocumentId;
        cDe.LinkedEntityId = mapContVer.get(conDoc.Id); 
        cDe.ShareType = 'V'; 
        cDe.Visibility = 'AllUsers';
        lstConDocLink.add(cde);
    }

    try {
        if(lstConDocLink.size() > 0) {
            insert lstConDocLink;
        }
    } catch (Exception e) {
        
    }
    
}

/**
* @description create new ContentVersion
* @author CRA | 21/10/2019 
* @param content 
* @return ContentVersion 
**/
private static ContentVersion createContentVersion(Blob content) {
    return new ContentVersion(
        Title = 'ApplicationForm',
        PathOnClient = 'ApplicationForm.pdf',
        VersionData = content,
        Origin = 'H'
    );
}

/**
* [createContactOpps description]
* @param lstLed [description]
*/
    private static void createContactOpps(List<Lead> lstLed){
        //loop through all leads to create family (Parent/ Child contacts and opportunities)
        for(Lead led : lstLed){
            
            System.debug('##### led: '+led);
            setConToDel.add(new Contact(Id = led.ConvertedContactId));
            Boolean isAgent = false;

            //if (led.Lead_Origin__c == AP_Constant.ledOriginWeChat && led.WeChatCampaignName__c != null) { //CRA20190710: W000556
            //    mapCampaignNameLead.put(led.Id, led.WeChatCampaignName__c);
            //}
            
            //VJA
            // if (led.FeesPayer__c != null) { //CRA20190913 - Case 00001974
            //     mapFinancialContacts.put(led.Id, led.FeesPayer__c);
            // }

            if(led.Parent1NatureOfRelationship__c == 'Agent'){ //ANA20191601: W459 
                mapAccAgents.put(led.ConvertedAccountId, led.ReferredByContact__c);
                isAgent = true;
            }
            
            if((String.isNotEmpty(led.Parent1LastName__c) && led.Parent1NatureOfRelationship__c != 'Agent'  && led.Parent1NatureOfRelationship__c != 'Child') //ANA20191601: W459 (Don't create if Relationship is Agent)
                ||
                (led.Lead_Origin__c == AP_Constant.ledOriginWeChat || led.Lead_Origin__c == AP_Constant.ledOriginAdmissionsStage1 || led.Lead_Origin__c == AP_Constant.ledOriginAdmissionsStage2 || led.Lead_Origin__c == AP_Constant.ledOriginApplication)){ 
                    String tempId = led.Id+'parent1';
                    
                    Contact con = new Contact();
                    con.RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeParent);
                    con.AccountId = led.ConvertedAccountId;
                    con.LeadSource = led.LeadSource;
                    con.SchoolOfInterest__c = led.SchoolOfInterest__c;
                    con.ReferredBy__c = led.ReferredBy__c;
                    con.Salutation = led.Parent1Title__c;
                    con.FirstName = led.Parent1FirstName__c;
                    con.LastName = led.Parent1LastName__c;
                    con.PreferredName__c = led.Parent1PreferredName__c; //ANA20190901 : Case 00001562
                    con.NatureOfRelationship__c = led.Parent1NatureOfRelationship__c;
                    con.Nationality__c = led.Parent1Nationality__c;
                    con.Company__c = led.Parent1Company__c;
                    //VJA con.IsAlumni__c = led.Parent1Alumni__c;
                    //VJA con.HasLegalCustodyOfChild__c = led.Parent1LegalCustody__c;
                    con.PreferredLanguage__c = led.Parent1PreferredLanguage__c;
                    con.Email = led.Parent1PrimaryEmail__c;
                    
                //    con.MailingStreet = led.Parent1Street__c;     FKH - Case 3374 new mapping on Contact
                //    con.MailingState = led.Parent1State__c;
                //    con.MailingCity = led.Parent1City__c;
                //    con.MailingPostalCode = led.Parent1ZipPostalCode__c;
                //    con.MailingCountry = led.Parent1CountryOfResidence__c;
                con.AddressLine1__c = led.Parent1Street__c; //FKH - Case 3374 new mapping on Contact
                con.AddressLine2__c = led.Parent1AddLine2__c;
                con.AddressLine3__c = led.Parent1AddLine3__c;
                con.State__c = led.Parent1State__c;
                con.City__c = led.Parent1City__c;
                con.ZipPostalCode__c = led.Parent1ZipPostalCode__c;
                con.CountryOfResidence__c = led.Parent1CountryOfResidence__c; 

                    con.Phone = led.Parent1HomePhone__c;
                    con.MobilePhone = led.Parent1MobilePhone__c;
                    con.WeChatUserId__c = led.Parent1WeChatId__c;
                    con.Household_registration__c = led.Parent1HouseholdRegistration__c; //ANA20190122
                    //VJA con.Parent_1_child_enrolled__c = led.Parent1ChildEnrolled__c;
                    con.LeadPosition__c = AP_Constant.leadPositionParent1; //ANA20190219 W344
                    //VJA con.SecondaryEmail__c = led.Parent1SecondaryEmail__c; //ANA20190222 C1644
                    con.LeadID__c = led.Id; //CRA20190408 
                    //VJA con.SiblingInformation__c = led.SiblingInformation__c; //CRA20190529 AppFormR2.0
                    con.MarketingPermissionEmail__c = led.MarketingPermissionEmail__c;
                    con.MarketingPermissionPhone__c=led.MarketingPermissionPhone__c;
                    con.PermissionToSendYouInformation__c=led.Permission_to_send_you_information__c;
                    mapTempIdToCon.put(tempId, con);
                }
            
            if(String.isNotEmpty(led.Parent2LastName__c )){
                String tempId = led.Id+'parent2';
                
                Contact con = new Contact();
                con.RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeParent);
                con.AccountId = led.ConvertedAccountId;
                con.LeadSource = led.LeadSource;
                con.SchoolOfInterest__c = led.SchoolOfInterest__c;
                con.ReferredBy__c = led.ReferredBy__c;
                con.Salutation = led.Parent2Title__c;
                con.FirstName = led.Parent2FirstName__c;
                con.LastName = led.Parent2LastName__c;
                //VJA con.PreferredName__c = led.Parent2PreferredName__c; //ANA20190901 : Case 00001562
                con.NatureOfRelationship__c = led.Parent2NatureOfRelationship__c;
                con.Nationality__c = led.Parent2Nationality__c;
                con.Company__c = led.Parent2Company__c;
                //VJA con.IsAlumni__c = led.Parent2Alumni__c;
                //VJA con.HasLegalCustodyOfChild__c = led.Parent2LegalCustody__c;
                con.PreferredLanguage__c = led.Parent2PreferredLanguage__c;
                con.Email = led.Parent2PrimaryEmail__c;
                
                    // con.MailingStreet = led.Parent2Street__c; //FKH - Case 3374 new mapping on Contact
                // con.MailingState = led.Parent2State__c;
                // con.MailingCity = led.Parent2City__c;
                // con.MailingPostalCode = led.Parent2ZipPostalCode__c;
                // con.MailingCountry = led.Parent2CountryOfResidence__c;
                
                con.AddressLine1__c = led.Parent2Street__c; //FKH - Case 3374 new mapping on Contact
                con.AddressLine2__c = led.Parent2AddLine2__c;
                con.AddressLine3__c = led.Parent2AddLine3__c;
                con.State__c = led.Parent2State__c;
                con.City__c = led.Parent2City__c;
                con.ZipPostalCode__c = led.Parent2ZipPostalCode__c;
                con.CountryOfResidence__c = led.Parent2CountryOfResidence__c;
                
                con.Phone = led.Parent2HomePhone__c;
                con.MobilePhone = led.Parent2MobilePhone__c;
                con.WeChatUserId__c = led.Parent2WeChatId__c;
                con.Household_registration__c = led.Parent1HouseholdRegistration__c; //ANA20190122 : 
                con.LeadPosition__c = AP_Constant.leadPositionParent2; //ANA20190219 W344
                //VJA con.SecondaryEmail__c = led.Parent2SecondaryEmail__c; //ANA20190222 C1644
                con.LeadID__c = led.Id; //CRA20190408
                con.MarketingPermissionEmail__c = led.MarketingPermissionEmail__c;
                con.MarketingPermissionPhone__c=led.MarketingPermissionPhone__c;
                con.PermissionToSendYouInformation__c=led.Permission_to_send_you_information__c;
                
                
                mapTempIdToCon.put(tempId, con);
            }
            
            //VJA
            // if(String.isNotEmpty(led.Parent3LastName__c)){
            //     String tempId = led.Id+'parent3';
                
            //     Contact con = new Contact();
            //     con.RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeParent);
            //     con.AccountId = led.ConvertedAccountId;
            //     con.LeadSource = led.LeadSource;
            //     con.SchoolOfInterest__c = led.SchoolOfInterest__c;
            //     con.ReferredBy__c = led.ReferredBy__c;
            //     con.Salutation = led.Parent3Title__c;
            //     con.FirstName = led.Parent3FirstName__c;
            //     con.LastName = led.Parent3LastName__c;
            //     //VJA con.PreferredName__c = led.Parent3PreferredName__c; //ANA20190901 : Case 00001562
            //     con.NatureOfRelationship__c = led.Parent3NatureOfRelationship__c;
            //     con.Nationality__c = led.Parent3Nationality__c;
            //     //VJA con.Company__c = led.Parent3Company__c;
            //     //VJA con.IsAlumni__c = led.Parent3Alumni__c;
            //     //VJA con.HasLegalCustodyOfChild__c = led.Parent3LegalCustody__c;
            //     //VJA con.PreferredLanguage__c = led.Parent3PreferredLanguage__c;
            //     con.Email = led.Parent3PrimaryEmail__c;
            //     con.MailingStreet = led.Parent3Street__c;
            //     //VJA con.MailingState = led.Parent3State__c;
            //     con.MailingCity = led.Parent3City__c;
            //     con.MailingPostalCode = led.Parent3ZipPostalCode__c;
            //     con.MailingCountry = led.Parent3CountryOfResidence__c;
            //     con.CountryOfResidence__c = led.Parent3CountryOfResidence__c;
            //     con.Phone = led.Parent3HomePhone__c;
            //     //VJA con.MobilePhone = led.Parent3MobilePhone__c;
            //     //VJA con.WeChatUserId__c = led.Parent3WeChatId__c;
            //     con.Household_registration__c = led.Parent2HouseholdRegistration__c; //ANA20190122 : 
            //     con.LeadPosition__c = AP_Constant.leadPositionParent3; //ANA20190219 W344
            //     con.LeadID__c = led.Id; //CRA20190408
            //     con.MarketingPermissionEmail__c = led.MarketingPermissionEmail__c;
            //     con.MarketingPermissionPhone__c=led.MarketingPermissionPhone__c;
            //     con.PermissionToSendYouInformation__c=led.Permission_to_send_you_information__c;
                
            //     mapTempIdToCon.put(tempId, con);
            // }
            
            if(String.isNotEmpty(led.LastNameFirstChild__c)){
                
                system.debug('#### Entered Opp');
                String tempId = led.Id+'child1';
                
                Contact con = new Contact();
                con.NatureOfRelationship__c = AP_Constant.conNatureRelChild;
                con.RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeChild);
                con.AccountId = led.ConvertedAccountId;
                con.LeadSource = led.LeadSource;
                con.SchoolOfInterest__c = led.SchoolOfInterest__c;
                con.ReferredBy__c = led.ReferredBy__c;
                con.Birthdate = led.DateOfBirthFirstChild__c;
                con.FirstName = led.FirstNameFirstChild__c;
                con.LastName = led.LastNameFirstChild__c;
                con.PreferredName__c = led.PreferredNameFirstChild__c;
                con.Gender__c = led.GenderFirstChild__c;
                con.Nationality__c = led.NationalityFirstChild__c;
                //VJA con.Nationality2__c = led.Nationality2FirstChild__c;
                con.NativeLanguage__c = led.Native_Language_of_First_Child__c;
                con.Ethnicity__c = led.EthnicityFirstChild__c;
                //VJA con.ReligionPicklist__c = led.ReligionFirstChild__c; //CRA20190320 Case 00001679
                //VJA con.PassportNumber__c = led.NationalPassportIdFirstChild__c;
                //VJA con.Interests__c = led.InterestsFirstChild__c;
                con.SecondLanguage__c = led.SecondLanguageFirstChild__c;    //ANA20181220: Case: 00001545 
                //VJA con.Additional_Languages__c = led.AdditionalLanguageFirstChild__c;    //CRA20191008 : Case 00002034
                con.Household_registration__c = led.Parent1HouseholdRegistration__c; //ANA20190122 : 
                //VJA con.Parent_1_child_enrolled__c = led.Parent1ChildEnrolled__c;
                con.LeadPosition__c = AP_Constant.leadPositionChild1; //ANA20190219 W344
                con.LeadID__c = led.Id; //CRA20190408 
                mapTempIdToCon.put(tempId, con);
                con.MarketingPermissionEmail__c = led.MarketingPermissionEmail__c;
                con.MarketingPermissionPhone__c=led.MarketingPermissionPhone__c;
                con.PermissionToSendYouInformation__c=led.Permission_to_send_you_information__c;
                
                if(led.MarketingQualifiedFirstChild__c){
                    Opportunity opp = new Opportunity();
                    opp.CloseDate = (led.ValidationBypass__c && led.EnrollmentDateFirstChild__c==null) ? Date.newInstance (2050,1,1) : led.EnrollmentDateFirstChild__c;
                    opp.RecordTypeId = led.RecordTypeId != null ? mapRecordType.get(getRecordTypeNameById('Lead', led.RecordTypeId)) :  mapRecordType.get(AP_Constant.oppRecordTypeEnrolment); //ANA20191101: W482 & 487 
                    opp.AccountId = led.ConvertedAccountId;
                    opp.LeadSource = led.LeadSource;
                    opp.LeadSubSource__c = led.LeadSubSource__c;
                    opp.LeadMethod__c = led.LeadMethod__c;
                    opp.LeadOrigin__c = led.Lead_Origin__c; //ANA20190401: Case 00001555
                    opp.StageName = AP_Constant.oppStageEnquiry;
                    opp.ReferredBy__c = led.ReferredBy__c;
                    opp.SchoolOfInterest__c = led.SchoolOfInterest__c;
                    opp.GACLIENTID__c = led.GACLIENTID__c;
                    opp.GATRACKID__c = led.GATRACKID__c;
                    opp.GAUSERID__c = led.GAUSERID__c;
                    opp.Name = String.join(new List<String>{led.FirstNameFirstChild__c, led.LastNameFirstChild__c}, ' '); //ANA20191501 Removed PreferredName 
                    opp.YearGrade__c = led.ExpectedYearGradeFirstChild__c;
                    //VJA opp.ChildVisa__c  = led.NeedVisaFirstChild__c;
                    //VJA opp.RequestedYearLevel__c  = led.RequestedLevelFirstChild__c;
                    opp.PreferredEnrolmentDate__c  = led.PreferredEnrollmenDateFirstChild__c; //RRAJ: 20180920 - Removed upon business request
                    opp.DayOrBoardingSchool__c  = led.DayOrBoardingSchoolFirstChild__c == AP_Constant.ledBoardingDayBoarding ? AP_Constant.ledFullBoarding : led.DayOrBoardingSchoolFirstChild__c; //CRA20190305 - w000344
                    opp.TECH_IsFromAgentLead__c = isAgent ? true : false;
                    opp.Notes__c  = led.FirstChildNotes__c;
                    // opp.CloseDate  = led.EnrollmentDateFirstChild__c;
                    //VJA opp.EnglishProficiencySpoken__c  = led.EnglishSpokenFirstChild__c;
                    //VJA opp.EnglishProficiencyWritten__c  = led.EnglishWrittenFirstChild__c;
                    //VJA opp.ConcernsOnSocialAcademicProgress__c  = led.ConcernAroundFirstChild__c;
                    //VJA opp.EducationSupportNeeded__c  = led.AdditionnalNeedsFirstChild__c;
                    //VJA opp.SocialEmotionalDifficulties__c  = led.EmotionalSocialDifficultyFirstChild__c;
                    //VJA opp.ChildNeedAdditionalSupport__c  = led.ExtraSupportFirstChild__c;
                    opp.CurrentPreviousSchoolName__c  = led.AttendedSchoolFirstChild__c;
                    //VJA opp.AttendedFrom__c  = led.AttendedFromFirstChild__c;
                    //VJA opp.AttendedTo__c  = led.AttendedToFirstChild__c;
                    //VJA opp.Country__c  = led.CountryFirstChild__c;
                    //VJA opp.City__c  = led.CityFirstChild__c;
                    //VJA opp.Curriculum__c  = led.CurriculumFirstChild__c;
                    //VJA opp.LanguageOfInstruction__c  = led.LanguageInstructionFirstChild__c;
                    //VJA opp.ReferenceRequest__c  = led.RefRequestFirstChild__c;
                    //VJA opp.ReasonForLeaving__c  = led.ReasonLeavingFirstChild__c;
                    //VJA opp.NumberOfSchoolsAttended__c  = led.NumberSchoolAttendedFirstChild__c;
                    //VJA opp.SchoolRejection__c  = led.RejectedFirstChild__c;
                    //VJA opp.WhatIsTheReason__c  = led.ReasonRejectedFirstChild__c;
                    //VJA opp.MedicalConditions__c  = led.MedicalConditionsFirstChild__c;
                    //VJA opp.SurgeryHistory__c  = led.MedicalSurgeryFirstChild__c;
                    //VJA opp.PrescriptionDrugs__c  = led.DrugsPrescriptionFirstChild__c;
                    //VJA opp.InabilityToParticipateInSports__c  = led.UnableSportFirstChild__c;
                    //VJA opp.ChildsAllergies__c  = led.AllergiesFirstChild__c;
                    //VJA opp.Vaccinations__c  = led.VaccinationsFirstChild__c;
                    //VJA opp.DietaryRequirements__c  = led.SpecialDietryFirstChild__c;
                    opp.Campus__c = led.Campus__c;
                    opp.LeadSubmissionDate__c = led.CreatedDate;
                    //VJA opp.FinancialAidRequested__c = led.FinancialAidRequested__c;
                    opp.ReferredByContact__c = Led.ReferredByContact__c; //ANA20181204 : Case 00001470
                    opp.ParentEmail__c = led.Parent1PrimaryEmail__c ;  //ANA20181210: Case 00001504 
                    //VJA opp.ChineseProficiencySpoken__c = led.ChineseSpokenFirstChild__c; //ANA20181218: Case 00001533
                    //VJA opp.ChineseProficiencyWritten__c = led.ChineseWrittenFirstChild__c;
                    opp.WeChatCampaignName__c = led.WeChatCampaignName__c;   //ANA20190122 : Case 00001570
                    opp.TermsConditions__c   =  Led.TermsConditions__c; //ANA20190107 : Case 00001557 (Added TermsConditions__c, ..., PaymentMethod__c for conversion)
                    opp.MedicalTermsConditions__c    =  Led.MedicalTermsConditions__c;
                    opp.PrivacyPolicy__c     =  Led.PrivacyPolicy__c;
                    opp.ChildPhotoDisclaimer__c  =  Led.ChildPhotoDisclaimer__c;
                    //VJA opp.SchoolTripAuthorization__c   =  Led.SchoolTripAuthorization__c;
                    //VJA opp.PrimaryContact__c    =  Led.PrimaryContact__c;
                    //VJA opp.ReportsReceipient__c     =  Led.ReportsReceipient__c;
                    //VJA opp.SchoolNewsCommContact__c  =     Led.SchoolNewsCommContact__c;
                    //VJA opp.ParentPortalAccess__c    =  Led.ParentPortalAccess__c;
                    //VJA opp.EmergencyContact__c  =  Led.EmergencyContact__c;
                    //VJA opp.EmergencyContactNum__c   =  Led.EmergencyContactNum__c;
                    //VJA opp.FeesPayer__c     =  Led.FeesPayer__c;
                    opp.CompanyOther__c  =  Led.CompanyOther__c;
                    //VJA opp.InvoiceAddress1__c   =  Led.InvoiceAddress1__c;
                    //VJA opp.InvoiceAddress2__c   =  Led.InvoiceAddress2__c;
                    opp.InvoiceCity__c   =  Led.City__c;
                    opp.PostalZipCode__c     =  Led.PostalZipCode__c;
                    opp.InvoiceCountry__c    =  Led.Country__c;
                    //VJA opp.PaymentStructure__c  =  Led.PaymentStructure__c;
                    //VJA opp.PaymentMethod__c     =  Led.PaymentMethod__c;
                    //VJA opp.ContactName__c = Led.ContactNameFirstChild__c; //CRA20190211 : W344
                    //VJA opp.ContactEmailAddress__c = Led.ContactEmailFirstChild__c;  //CRA20190211 : W344
                    opp.LeadPriority__c = Led.Priority__c; //CRA20190804 : Case 00001738
                    opp.LeadID__c = led.Id; //CRA20190408 
                    opp.Lead__c = led.Id; //CRA20200619 : Case 00002304
                    opp.HasAttendedSummercamp__c = Led.HasAttendedSummercampFirstChild__c; //CRA20190625 :W000531
                    
                    mapTempIdToOpp.put(tempId, opp);
                }
            }
            
            if(String.isNotEmpty(led.LastNameSecondChild__c)){
                String tempId = led.Id+'child2';
                
                Contact con = new Contact();
                con.NatureOfRelationship__c = AP_Constant.conNatureRelChild;
                con.RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeChild);
                con.AccountId = led.ConvertedAccountId;
                con.LeadSource = led.LeadSource;
                con.SchoolOfInterest__c = led.SchoolOfInterest__c;
                con.ReferredBy__c = led.ReferredBy__c;
                con.Birthdate = led.DateOfBirthSecondChild__c;
                con.FirstName = led.FirstNameSecondChild__c;
                con.LastName = led.LastNameSecondChild__c;
                con.PreferredName__c = led.PreferredNameSecondChild__c;
                con.Gender__c = led.GenderSecondChild__c;
                con.Nationality__c = led.NationalitySecondChild__c;
                //VJA con.Nationality2__c = led.Nationality2SecondChild__c;
                con.NativeLanguage__c = led.Native_Language_of_Second_Child__c;
                //VJA con.Ethnicity__c = led.EthnicitySecondChild__c;
                //VJA con.ReligionPicklist__c = led.ReligionSecondChild__c; //CRA20190320 Case 00001679
                //VJA con.PassportNumber__c = led.NationalPassportIdSecondChild__c;
                //VJA con.Interests__c = led.InterestsSecondChild__c;
                //VJA con.SecondLanguage__c = led.SecondLanguageSecondChild__c;    //ANA20181220: Case: 00001545 
                //VJA con.Additional_Languages__c = led.AdditionalLanguageSecondChild__c;    //CRA20191008 : Case 00002034
                con.LeadPosition__c = AP_Constant.leadPositionChild2; //ANA20190219 W344
                con.LeadID__c = led.Id; //CRA20190408
                con.MarketingPermissionEmail__c = led.MarketingPermissionEmail__c;
                con.MarketingPermissionPhone__c=led.MarketingPermissionPhone__c;
                con.PermissionToSendYouInformation__c=led.Permission_to_send_you_information__c;
                
                
                mapTempIdToCon.put(tempId, con);
                
                if(led.MarketingQualifiedSecondChild__c){
                    Opportunity opp = new Opportunity();
                    opp.CloseDate = (led.ValidationBypass__c && led.EnrollmentDateSecondChild__c==null) ? Date.newInstance (2050,1,1) : led.EnrollmentDateSecondChild__c;
                    opp.RecordTypeId = led.RecordTypeId != null ? mapRecordType.get(getRecordTypeNameById('Lead', led.RecordTypeId)) :  mapRecordType.get(AP_Constant.oppRecordTypeEnrolment); //ANA20191101: W482 & 487 
                    opp.AccountId = led.ConvertedAccountId;
                    opp.LeadSource = led.LeadSource;
                    opp.LeadSubSource__c = led.LeadSubSource__c;
                    opp.LeadMethod__c = led.LeadMethod__c;
                    opp.LeadOrigin__c = led.Lead_Origin__c; //ANA20190401: Case 00001555
                    opp.StageName = AP_Constant.oppStageEnquiry;
                    opp.ReferredBy__c = led.ReferredBy__c;
                    opp.SchoolOfInterest__c = led.SchoolOfInterest__c;
                    opp.GACLIENTID__c = led.GACLIENTID__c;
                    opp.GATRACKID__c = led.GATRACKID__c;
                    opp.GAUSERID__c = led.GAUSERID__c;
                    opp.Name = String.join(new List<String>{led.FirstNameSecondChild__c, led.LastNameSecondChild__c}, ' ');
                    opp.YearGrade__c = led.ExpectedYearGradeSecondChild__c;
                    //VJA opp.ChildVisa__c  = led.NeedVisaSecondChild__c;
                    //VJA opp.RequestedYearLevel__c  = led.RequestedLevelSecondChild__c;
                    //opp.PreferredEnrolmentDate__c  = led.PreferredEnrollmenDateSecondChild__c; //RRAJ: 20180920 - Removed upon business request
                    opp.DayOrBoardingSchool__c  = led.DayOrBoardingSchoolSecondChild__c == AP_Constant.ledBoardingDayBoarding ? AP_Constant.ledFullBoarding : led.DayOrBoardingSchoolSecondChild__c; //CRA20190305 - w000344
                    opp.TECH_IsFromAgentLead__c = isAgent ? true : false;
                    opp.Notes__c  = led.SecondChildNotes__c;
                    //opp.CloseDate  = led.EnrollmentDateSecondChild__c;
                    //VJA opp.EnglishProficiencySpoken__c  = led.EnglishSpokenSecondChild__c;
                    //VJA opp.EnglishProficiencyWritten__c  = led.EnglishWrittenSecondChild__c;
                    //VJA opp.ConcernsOnSocialAcademicProgress__c  = led.ConcernAroundSecondChild__c;
                    //VJA opp.EducationSupportNeeded__c  = led.AdditionnalNeedsSecondChild__c;
                    //VJA opp.SocialEmotionalDifficulties__c  = led.EmotionalSocialDifficultySecondChild__c;
                    //VJA opp.ChildNeedAdditionalSupport__c  = led.ExtraSupportSecondChild__c;
               	    opp.CurrentPreviousSchoolName__c  = led.AttendedSchoolSecondChild__c;
                    //VJA opp.AttendedFrom__c  = led.AttendedFromSecondChild__c;
                    //VJA opp.AttendedTo__c  = led.AttendedToSecondChild__c;
                    //VJA opp.Country__c  = led.CountrySecondChild__c;
                    //VJA opp.City__c  = led.CitySecondChild__c;
                    //VJA opp.Curriculum__c  = led.CurriculumSecondChild__c;
                    //VJA opp.LanguageOfInstruction__c  = led.LanguageInstructionSecondChild__c;
                    //VJA opp.ReferenceRequest__c  = led.RefRequestSecondChild__c;
                    //VJA opp.ReasonForLeaving__c  = led.ReasonLeavingSecondChild__c;
                    //VJA opp.NumberOfSchoolsAttended__c  = led.NumberSchoolAttendedSecondChild__c;
                    //VJA opp.SchoolRejection__c  = led.RejectedSecondChild__c;
                    //VJA opp.WhatIsTheReason__c  = led.ReasonRejectedSecondChild__c;
                    //VJA opp.MedicalConditions__c  = led.MedicalConditionsSecondChild__c;
                    //VJA opp.SurgeryHistory__c  = led.MedicalSurgerySecondChild__c;
                    //VJA opp.PrescriptionDrugs__c  = led.DrugsPrescriptionSecondChild__c;
                    //VJA opp.InabilityToParticipateInSports__c  = led.UnableSportSecondChild__c;
                    //VJA opp.ChildsAllergies__c  = led.AllergiesSecondChild__c;
                    //VJA opp.Vaccinations__c  = led.VaccinationsSecondChild__c;
                    //VJA opp.DietaryRequirements__c  = led.SpecialDietrySecondChild__c;
                    opp.Campus__c = led.Campus__c;
                    opp.LeadSubmissionDate__c = led.CreatedDate;
                    //VJA opp.FinancialAidRequested__c = led.FinancialAidRequested__c;
                    opp.ReferredByContact__c = Led.ReferredByContact__c; //ANA20181204 : Case 00001470
                    opp.ParentEmail__c = led.Parent1PrimaryEmail__c ;  //ANA20181012 : Case 00001504 
                    //VJA opp.ChineseProficiencySpoken__c = led.ChineseSpokenSecondChild__c; //ANA20181218: Case 00001533
                    //VJA opp.ChineseProficiencyWritten__c = led.ChineseWrittenSecondChild__c;
                    opp.WeChatCampaignName__c = led.WeChatCampaignName__c;   //ANA20190122 : Case 00001570
                    
                    opp.TermsConditions__c   =  Led.TermsConditions__c; //ANA20190107 : Case 00001557 (Added TermsConditions__c, ..., PaymentMethod__c for conversion)
                    opp.MedicalTermsConditions__c    =  Led.MedicalTermsConditions__c;
                    opp.PrivacyPolicy__c     =  Led.PrivacyPolicy__c;
                    opp.ChildPhotoDisclaimer__c  =  Led.ChildPhotoDisclaimer__c;
                    //VJA opp.SchoolTripAuthorization__c   =  Led.SchoolTripAuthorization__c;
                    //VJA opp.PrimaryContact__c    =  Led.PrimaryContact__c;
                    //VJA opp.ReportsReceipient__c     =  Led.ReportsReceipient__c;
                    //VJA opp.SchoolNewsCommContact__c  =     Led.SchoolNewsCommContact__c;
                    //VJA opp.ParentPortalAccess__c    =  Led.ParentPortalAccess__c;
                    //VJA opp.EmergencyContact__c  =  Led.EmergencyContact__c;
                    //VJA opp.EmergencyContactNum__c   =  Led.EmergencyContactNum__c;
                    //VJA opp.FeesPayer__c     =  Led.FeesPayer__c;
                    opp.CompanyOther__c  =  Led.CompanyOther__c;
                    //VJA opp.InvoiceAddress1__c   =  Led.InvoiceAddress1__c;
                    //VJA opp.InvoiceAddress2__c   =  Led.InvoiceAddress2__c;
                    opp.InvoiceCity__c   =  Led.City__c;
                    opp.PostalZipCode__c     =  Led.PostalZipCode__c;
                    opp.InvoiceCountry__c    =  Led.Country__c;
                    //VJA opp.PaymentStructure__c  =  Led.PaymentStructure__c;
                    //VJA opp.PaymentMethod__c     =  Led.PaymentMethod__c;
                    
                    //VJA opp.ContactName__c = Led.ContactNameSecondChild__c; //CRA20190211 : W344
                    //VJA opp.ContactEmailAddress__c = Led.ContactEmailSecondChild__c;  //CRA20190211 : W344
                    opp.LeadPriority__c = Led.Priority__c; //CRA20190804 : Case 00001738

                    opp.LeadID__c = led.Id; //CRA20190408 
                    opp.Lead__c = led.Id; //CRA20200619 : Case 00002304
                    opp.HasAttendedSummercamp__c = Led.HasAttendedSummercampSecondChild__c; //CRA20190625 :W000531
                    
                    mapTempIdToOpp.put(tempId, opp);
                }
            }
            
            if(String.isNotEmpty(led.LastNameThirdChild__c)){
                String tempId = led.Id+'child3';
                
                Contact con = new Contact();
                con.NatureOfRelationship__c = AP_Constant.conNatureRelChild;
                con.RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeChild);
                con.AccountId = led.ConvertedAccountId;
                con.LeadSource = led.LeadSource;
                con.SchoolOfInterest__c = led.SchoolOfInterest__c;
                con.ReferredBy__c = led.ReferredBy__c;
                con.Birthdate = led.DateOfBirthThirdChild__c;
                con.FirstName = led.FirstNameThirdChild__c;
                con.LastName = led.LastNameThirdChild__c;
                con.PreferredName__c = led.PreferredNameThirdChild__c;
                con.Gender__c = led.GenderThirdChild__c;
                con.Nationality__c = led.NationalityThirdChild__c;
                //VJA con.Nationality2__c = led.Nationality2ThirdChild__c;
                con.NativeLanguage__c = led.Native_Language_of_Third_Child__c;
                //VJA con.Ethnicity__c = led.EthnicityThirdChild__c;
                //VJA con.ReligionPicklist__c = led.ReligionThirdChild__c; //CRA20190320 Case 00001679
                //VJA con.PassportNumber__c = led.NationalPassportIdThirdChild__c;
                //VJA con.Interests__c = led.InterestsThirdChild__c;
                //VJA con.SecondLanguage__c = led.SecondLanguageThirdChild__c;    //ANA20181220: Case: 00001545 
                //VJA con.Additional_Languages__c = led.AdditionalLanguageThirdChild__c;    //CRA20191008 : Case 00002034
                con.LeadPosition__c = AP_Constant.leadPositionChild3; //ANA20190219 W344
                con.LeadID__c = led.Id; //CRA20190408 
                con.MarketingPermissionEmail__c = led.MarketingPermissionEmail__c;
                con.MarketingPermissionPhone__c=led.MarketingPermissionPhone__c;
                con.PermissionToSendYouInformation__c=led.Permission_to_send_you_information__c;
                
                mapTempIdToCon.put(tempId, con);
                
                if(led.MarketingQualifiedThirdChild__c){
                    Opportunity opp = new Opportunity();
                    opp.CloseDate = (led.ValidationBypass__c && led.EnrollmentDateThirdChild__c==null) ? Date.newInstance (2050,1,1) : led.EnrollmentDateThirdChild__c;
                    opp.RecordTypeId = led.RecordTypeId != null ? mapRecordType.get(getRecordTypeNameById('Lead', led.RecordTypeId)) :  mapRecordType.get(AP_Constant.oppRecordTypeEnrolment); //ANA20191101: W482 & 487 
                    opp.AccountId = led.ConvertedAccountId;
                    opp.LeadSource = led.LeadSource;
                    opp.LeadSubSource__c = led.LeadSubSource__c;
                    opp.LeadMethod__c = led.LeadMethod__c;
                    opp.LeadOrigin__c = led.Lead_Origin__c; //ANA20190401: Case 00001555
                    opp.StageName = AP_Constant.oppStageEnquiry;
                    opp.ReferredBy__c = led.ReferredBy__c;
                    opp.SchoolOfInterest__c = led.SchoolOfInterest__c;
                    opp.GACLIENTID__c = led.GACLIENTID__c;
                    opp.GATRACKID__c = led.GATRACKID__c;
                    opp.GAUSERID__c = led.GAUSERID__c;
                    opp.Name = String.join(new List<String>{led.FirstNameThirdChild__c, led.LastNameThirdChild__c}, ' '); //ANA20191501 Removed PreferredName
                    opp.YearGrade__c = led.ExpectedYearGradeThirdChild__c;
                    //VJA opp.ChildVisa__c  = led.NeedVisaThirdChild__c;
                    //VJA opp.RequestedYearLevel__c  = led.RequestedLevelThirdChild__c;
                    //opp.PreferredEnrolmentDate__c  = led.PreferredEnrollmenDateThirdChild__c; //RRAJ: 20180920 - Removed upon business request
                    opp.DayOrBoardingSchool__c  = led.DayOrBoardingSchoolThirdChild__c == AP_Constant.ledBoardingDayBoarding ? AP_Constant.ledFullBoarding : led.DayOrBoardingSchoolThirdChild__c; //CRA20190305 - w000344
                    opp.TECH_IsFromAgentLead__c = isAgent ? true : false;
                    opp.Notes__c  = led.ThirdChildNotes__c;
                    // opp.CloseDate  = led.EnrollmentDateThirdChild__c;
                    //VJA opp.EnglishProficiencySpoken__c  = led.EnglishSpokenThirdChild__c;
                    //VJA opp.EnglishProficiencyWritten__c  = led.EnglishWrittenThirdChild__c;
                    //VJA opp.ConcernsOnSocialAcademicProgress__c  = led.ConcernAroundThirdChild__c;
                    //VJA opp.EducationSupportNeeded__c  = led.AdditionnalNeedsThirdChild__c;
                    //VJA opp.SocialEmotionalDifficulties__c  = led.EmotionalSocialDifficultyThirdChild__c;
                    //VJA opp.ChildNeedAdditionalSupport__c  = led.ExtraSupportThirdChild__c;
             		opp.CurrentPreviousSchoolName__c  = led.AttendedSchoolThirdChild__c;
                    //VJA opp.AttendedFrom__c  = led.AttendedFromThirdChild__c;
                    //VJA opp.AttendedTo__c  = led.AttendedToThirdChild__c;
                    //VJA opp.Country__c  = led.CountryThirdChild__c;
                    //VJA opp.City__c  = led.CityThirdChild__c;
                    //VJA opp.Curriculum__c  = led.CurriculumThirdChild__c;
                    //VJA opp.LanguageOfInstruction__c  = led.LanguageInstructionThirdChild__c;
                    //VJA opp.ReferenceRequest__c  = led.RefRequestThirdChild__c;
                    //VJA opp.ReasonForLeaving__c  = led.ReasonLeavingThirdChild__c;
                    //VJA opp.NumberOfSchoolsAttended__c  = led.NumberSchoolAttendedThirdChild__c;
                    //VJA opp.SchoolRejection__c  = led.RejectedThirdChild__c;
                    //VJA opp.WhatIsTheReason__c  = led.ReasonRejectedThirdChild__c;
                    //VJA opp.MedicalConditions__c  = led.MedicalConditionsThirdChild__c;
                    //VJA opp.SurgeryHistory__c  = led.MedicalSurgeryThirdChild__c;
                    //VJA opp.PrescriptionDrugs__c  = led.DrugsPrescriptionThirdChild__c;
                    //VJA opp.InabilityToParticipateInSports__c  = led.UnableSportThirdChild__c;
                    //VJA opp.ChildsAllergies__c  = led.AllergiesThirdChild__c;
                    //VJA opp.Vaccinations__c  = led.VaccinationsThirdChild__c;
                    //VJA opp.DietaryRequirements__c  = led.SpecialDietryThirdChild__c;
                    opp.Campus__c = led.Campus__c;
                    opp.LeadSubmissionDate__c = led.CreatedDate;
                    //VJA opp.FinancialAidRequested__c = led.FinancialAidRequested__c;
                    opp.ReferredByContact__c = Led.ReferredByContact__c; //ANA20181204 : Case 00001470
                    opp.ParentEmail__c = led.Parent1PrimaryEmail__c ;  //ANA20181012 : Case 00001504 
                    //VJA opp.ChineseProficiencySpoken__c = led.ChineseSpokenThirdChild__c; //ANA20181218: Case 00001533
                    //VJA opp.ChineseProficiencyWritten__c = led.ChineseWrittenThirdChild__c;
                    opp.WeChatCampaignName__c = led.WeChatCampaignName__c;   //ANA20190122 : Case 00001570
                    
                    opp.TermsConditions__c   =  Led.TermsConditions__c; //ANA20190107 : Case 00001557 (Added TermsConditions__c, ..., PaymentMethod__c for conversion)
                    opp.MedicalTermsConditions__c    =  Led.MedicalTermsConditions__c;
                    opp.PrivacyPolicy__c     =  Led.PrivacyPolicy__c;
                    opp.ChildPhotoDisclaimer__c  =  Led.ChildPhotoDisclaimer__c;
                    //VJA opp.SchoolTripAuthorization__c   =  Led.SchoolTripAuthorization__c;
                    //VJA opp.PrimaryContact__c    =  Led.PrimaryContact__c;
                    //VJA opp.ReportsReceipient__c     =  Led.ReportsReceipient__c;
                    //VJA opp.SchoolNewsCommContact__c  =     Led.SchoolNewsCommContact__c;
                    //VJA opp.ParentPortalAccess__c    =  Led.ParentPortalAccess__c;
                    //VJA opp.EmergencyContact__c  =  Led.EmergencyContact__c;
                    //VJA opp.EmergencyContactNum__c   =  Led.EmergencyContactNum__c;
                    //VJA opp.FeesPayer__c     =  Led.FeesPayer__c;
                    opp.CompanyOther__c  =  Led.CompanyOther__c;
                    //VJA opp.InvoiceAddress1__c   =  Led.InvoiceAddress1__c;
                    //VJA opp.InvoiceAddress2__c   =  Led.InvoiceAddress2__c;
                    opp.InvoiceCity__c   =  Led.City__c;
                    opp.PostalZipCode__c     =  Led.PostalZipCode__c;
                    opp.InvoiceCountry__c    =  Led.Country__c;
                    //VJA opp.PaymentStructure__c  =  Led.PaymentStructure__c;
                    //VJA opp.PaymentMethod__c     =  Led.PaymentMethod__c;
                    
                    //VJA opp.ContactName__c = Led.ContactNameThirdChild__c; //CRA20190211 : W344
                    //VJA opp.ContactEmailAddress__c = Led.ContactEmailThirdChild__c;  //CRA20190211 : W344
                    opp.LeadPriority__c = Led.Priority__c; //CRA20190804 : Case 00001738
                    
                    opp.LeadID__c = led.Id; //CRA20190408 
                    opp.Lead__c = led.Id; //CRA20200619 : Case 00002304
                    opp.HasAttendedSummercamp__c = Led.HasAttendedSummercampThirdChild__c; //CRA20190625 :W000531

                    mapTempIdToOpp.put(tempId, opp);
                }
            }
            
            if(String.isNotEmpty(led.LastNameFourthChild__c)){
                String tempId = led.Id+'child4';
                
                Contact con = new Contact();
                con.NatureOfRelationship__c = AP_Constant.conNatureRelChild;
                con.RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeChild);
                con.AccountId = led.ConvertedAccountId;
                con.LeadSource = led.LeadSource;
                con.SchoolOfInterest__c = led.SchoolOfInterest__c;
                con.ReferredBy__c = led.ReferredBy__c;
                con.Birthdate = led.DateOfBirthFourthChild__c;
                con.FirstName = led.FirstNameFourthChild__c;
                con.LastName = led.LastNameFourthChild__c;
                con.PreferredName__c = led.PreferredNameFourthChild__c;
                con.Gender__c = led.GenderFourthChild__c;
                con.Nationality__c = led.NationalityFourthChild__c;
                //VJA con.Nationality2__c = led.Nationality2FourthChild__c;
                con.NativeLanguage__c = led.Native_Language_of_Fourth_Child__c;
                //VJA con.Ethnicity__c = led.EthnicityFourthChild__c;
                //VJA con.ReligionPicklist__c = led.ReligionFourthChild__c; //CRA20190320 Case 00001679
                //VJA con.PassportNumber__c = led.NationalPassportIdFourthChild__c;
                //VJA con.Interests__c = led.InterestsFourthChild__c;
                //VJA con.SecondLanguage__c = led.SecondLanguageFourthChild__c;    //ANA20181220: Case: 00001545 
                //VJA con.Additional_Languages__c = led.AdditionalLanguageFourthChild__c;    //CRA20191008 : Case 00002034
                con.LeadPosition__c = AP_Constant.leadPositionChild4; //ANA20190219 W344
                con.LeadID__c = led.Id; //CRA20190408 
                con.MarketingPermissionEmail__c = led.MarketingPermissionEmail__c;
                con.MarketingPermissionPhone__c=led.MarketingPermissionPhone__c;
                con.PermissionToSendYouInformation__c=led.Permission_to_send_you_information__c;
                
                mapTempIdToCon.put(tempId, con);
                
                if(led.MarketingQualifiedFourthChild__c){
                    Opportunity opp = new Opportunity();
                    opp.CloseDate = (led.ValidationBypass__c && led.EnrollmentDateFourthChild__c==null) ? Date.newInstance (2050,1,1) : led.EnrollmentDateFourthChild__c;                    
                    opp.RecordTypeId = led.RecordTypeId != null ? mapRecordType.get(getRecordTypeNameById('Lead', led.RecordTypeId)) :  mapRecordType.get(AP_Constant.oppRecordTypeEnrolment); //ANA20191101: W482 & 487 
                    opp.AccountId = led.ConvertedAccountId;
                    opp.LeadSource = led.LeadSource;
                    opp.LeadSubSource__c = led.LeadSubSource__c;
                    opp.LeadMethod__c = led.LeadMethod__c;
                    opp.LeadOrigin__c = led.Lead_Origin__c; //ANA20190401: Case 00001555
                    opp.StageName = AP_Constant.oppStageEnquiry;
                    opp.ReferredBy__c = led.ReferredBy__c;
                    opp.SchoolOfInterest__c = led.SchoolOfInterest__c;
                    opp.GACLIENTID__c = led.GACLIENTID__c;
                    opp.GATRACKID__c = led.GATRACKID__c;
                    opp.GAUSERID__c = led.GAUSERID__c;
                    opp.Name = String.join(new List<String>{led.FirstNameFourthChild__c, led.LastNameFourthChild__c}, ' '); //ANA20191501 Removed PreferredName
                    opp.YearGrade__c = led.ExpectedYearGradeFourthChild__c;
                    //VJA opp.ChildVisa__c  = led.NeedVisaFourthChild__c;
                    //VJA opp.RequestedYearLevel__c  = led.RequestedLevelFourthChild__c;
                    //opp.PreferredEnrolmentDate__c  = led.PreferredEnrollmenDateFourthChild__c; //RRAJ: 20180920 - Removed upon business request
                    opp.DayOrBoardingSchool__c  = led.DayOrBoardingSchoolFourthChild__c == AP_Constant.ledBoardingDayBoarding ? AP_Constant.ledFullBoarding : led.DayOrBoardingSchoolFourthChild__c; //CRA20190305 - w000344
                    opp.TECH_IsFromAgentLead__c = isAgent ? true : false;
                    opp.Notes__c  = led.FourthChildNotes__c;
                    //opp.CloseDate  = led.EnrollmentDateFourthChild__c;
                    //VJA opp.EnglishProficiencySpoken__c  = led.EnglishSpokenFourthChild__c;
                    //VJA opp.EnglishProficiencyWritten__c  = led.EnglishWrittenFourthChild__c;
                    //VJA opp.ConcernsOnSocialAcademicProgress__c  = led.ConcernAroundFourthChild__c;
                    //VJA opp.EducationSupportNeeded__c  = led.AdditionnalNeedsFourthChild__c;
                    //VJA opp.SocialEmotionalDifficulties__c  = led.EmotionalSocialDifficultyFourthChild__c;
                    //VJA opp.ChildNeedAdditionalSupport__c  = led.ExtraSupportFourthChild__c;
                 	opp.CurrentPreviousSchoolName__c  = led.AttendedSchoolFourthChild__c;
                    //VJA opp.AttendedFrom__c  = led.AttendedFromFourthChild__c;
                    //VJA opp.AttendedTo__c  = led.AttendedToFourthChild__c;
                    //VJA opp.Country__c  = led.CountryFourthChild__c;
                    //VJA opp.City__c  = led.CityFourthChild__c;
                    //VJA opp.Curriculum__c  = led.CurriculumFourthChild__c;
                    //VJA opp.LanguageOfInstruction__c  = led.LanguageInstructionFourthChild__c;
                    //VJA opp.ReferenceRequest__c  = led.RefRequestFourthChild__c;
                    //VJA opp.ReasonForLeaving__c  = led.ReasonLeavingFourthChild__c;
                    //VJA opp.NumberOfSchoolsAttended__c  = led.NumberSchoolAttendedFourthChild__c;
                    //VJA opp.SchoolRejection__c  = led.RejectedFourthChild__c;
                    //VJA opp.WhatIsTheReason__c  = led.ReasonRejectedFourthChild__c;
                    //VJA opp.MedicalConditions__c  = led.MedicalConditionsFourthChild__c;
                    //VJA opp.SurgeryHistory__c  = led.MedicalSurgeryFourthChild__c;
                    //VJA opp.PrescriptionDrugs__c  = led.DrugsPrescriptionFourthChild__c;
                    //VJA opp.InabilityToParticipateInSports__c  = led.UnableSportFourthChild__c;
                    //VJA opp.ChildsAllergies__c  = led.AllergiesFourthChild__c;
                    //VJA opp.Vaccinations__c  = led.VaccinationsFourthChild__c;
                    //VJA opp.DietaryRequirements__c  = led.SpecialDietryFourthChild__c;
                    opp.Campus__c = led.Campus__c;
                    opp.LeadSubmissionDate__c = led.CreatedDate;
                    //VJA opp.FinancialAidRequested__c = led.FinancialAidRequested__c;
                    opp.ReferredByContact__c = Led.ReferredByContact__c; //ANA20181204 : Case 00001470
                    opp.ParentEmail__c = led.Parent1PrimaryEmail__c ;  //ANA20181012 : Case 00001504 
                    //VJA opp.ChineseProficiencySpoken__c = led.ChineseSpokenFourthChild__c; //ANA20181218: Case 00001533
                    //VJA opp.ChineseProficiencyWritten__c = led.ChineseWrittenFourthChild__c;
                    opp.WeChatCampaignName__c = led.WeChatCampaignName__c;   //ANA20190122 : Case 00001570
                    
                    opp.TermsConditions__c   =  Led.TermsConditions__c; //ANA20190107 : Case 00001557 (Added TermsConditions__c, ..., PaymentMethod__c for conversion)
                    opp.MedicalTermsConditions__c    =  Led.MedicalTermsConditions__c;
                    opp.PrivacyPolicy__c     =  Led.PrivacyPolicy__c;
                    opp.ChildPhotoDisclaimer__c  =  Led.ChildPhotoDisclaimer__c;
                    //VJA opp.SchoolTripAuthorization__c   =  Led.SchoolTripAuthorization__c;
                    //VJA opp.PrimaryContact__c    =  Led.PrimaryContact__c;
                    //VJA opp.ReportsReceipient__c     =  Led.ReportsReceipient__c;
                    //VJA opp.SchoolNewsCommContact__c  =     Led.SchoolNewsCommContact__c;
                    //VJA opp.ParentPortalAccess__c    =  Led.ParentPortalAccess__c;
                    //VJA opp.EmergencyContact__c  =  Led.EmergencyContact__c;
                    //VJA opp.EmergencyContactNum__c   =  Led.EmergencyContactNum__c;
                    //VJA opp.FeesPayer__c     =  Led.FeesPayer__c;
                    opp.CompanyOther__c  =  Led.CompanyOther__c;
                    //VJA opp.InvoiceAddress1__c   =  Led.InvoiceAddress1__c;
                    //VJA opp.InvoiceAddress2__c   =  Led.InvoiceAddress2__c;
                    opp.InvoiceCity__c   =  Led.City__c;
                    opp.PostalZipCode__c     =  Led.PostalZipCode__c;
                    opp.InvoiceCountry__c    =  Led.Country__c;
                    //VJA opp.PaymentStructure__c  =  Led.PaymentStructure__c;
                    //VJA opp.PaymentMethod__c     =  Led.PaymentMethod__c;
                    
                    //VJA opp.ContactName__c = Led.ContactNameFourthChild__c; //CRA20190211 : W344
                    //VJA opp.ContactEmailAddress__c = Led.ContactEmailFourthChild__c;  //CRA20190211 : W344

                    opp.LeadID__c = led.Id; //CRA20190408 
                    opp.Lead__c = led.Id; //CRA20200619 : Case 00002304
                    opp.HasAttendedSummercamp__c = Led.HasAttendedSummercampFourthChild__c; //CRA20190625 :W000531
                    
                    mapTempIdToOpp.put(tempId, opp);
                }
            }
            
            if(String.isNotEmpty(led.LastNameFifthChild__c)){
                String tempId = led.Id+'child5';
                
                Contact con = new Contact();
                con.NatureOfRelationship__c = AP_Constant.conNatureRelChild;
                con.RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeChild);
                con.AccountId = led.ConvertedAccountId;
                con.LeadSource = led.LeadSource;
                con.SchoolOfInterest__c = led.SchoolOfInterest__c;
                con.ReferredBy__c = led.ReferredBy__c;
                con.Birthdate = led.DateOfBirthFifthChild__c;
                con.FirstName = led.FirstNameFifthChild__c;
                con.LastName = led.LastNameFifthChild__c;
                con.PreferredName__c = led.PreferredNameFifthChild__c;
                con.Gender__c = led.GenderFifthChild__c;
                con.Nationality__c = led.NationalityFifthChild__c;
                //VJA con.Nationality2__c = led.Nationality2FifthChild__c;
                con.NativeLanguage__c = led.Native_Language_of_Fifth_Child__c;
                //VJA con.Ethnicity__c = led.EthnicityFifthChild__c;
                //VJA con.ReligionPicklist__c = led.ReligionFifthChild__c; //CRA20190320 Case 00001679
                //VJA con.PassportNumber__c = led.NationalPassportIdFifthChild__c;
                //VJA con.Interests__c = led.InterestsFifthChild__c;
                //VJA con.SecondLanguage__c = led.SecondLanguageFifthChild__c;    //ANA20181220: Case: 00001545 
                //VJA con.Additional_Languages__c = led.AdditionalLanguageFifthChild__c;    //CRA20191008 : Case 00002034
                con.LeadPosition__c = AP_Constant.leadPositionChild5; //ANA20190219 W344
                con.LeadID__c = led.Id; //CRA20190408 
                con.MarketingPermissionEmail__c = led.MarketingPermissionEmail__c;
                con.MarketingPermissionPhone__c=led.MarketingPermissionPhone__c;
                con.PermissionToSendYouInformation__c=led.Permission_to_send_you_information__c;  
                
                mapTempIdToCon.put(tempId, con);
                
                if(led.MarketingQualifiedFifthChild__c){
                    Opportunity opp = new Opportunity();
                    opp.CloseDate = (led.ValidationBypass__c && led.EnrollmentDateFifthChild__c==null) ? Date.newInstance (2050,1,1) : led.EnrollmentDateFifthChild__c;                    
                    opp.RecordTypeId = led.RecordTypeId != null ? mapRecordType.get(getRecordTypeNameById('Lead', led.RecordTypeId)) :  mapRecordType.get(AP_Constant.oppRecordTypeEnrolment); //ANA20191101: W482 & 487 
                    opp.AccountId = led.ConvertedAccountId;
                    opp.LeadSource = led.LeadSource;
                    opp.LeadSubSource__c = led.LeadSubSource__c;
                    opp.LeadMethod__c = led.LeadMethod__c;
                    opp.LeadOrigin__c = led.Lead_Origin__c; //ANA20190401: Case 00001555
                    opp.StageName = AP_Constant.oppStageEnquiry;
                    opp.ReferredBy__c = led.ReferredBy__c;
                    opp.SchoolOfInterest__c = led.SchoolOfInterest__c;
                    opp.GACLIENTID__c = led.GACLIENTID__c;
                    opp.GATRACKID__c = led.GATRACKID__c;
                    opp.GAUSERID__c = led.GAUSERID__c;
                    opp.Name = String.join(new List<String>{led.FirstNameFifthChild__c, led.LastNameFifthChild__c}, ' '); //ANA20191501 Removed PreferredName
                    opp.YearGrade__c = led.ExpectedYearGradeFifthChild__c;
                    //VJA opp.ChildVisa__c  = led.NeedVisaFifthChild__c;
                    //VJA opp.RequestedYearLevel__c  = led.RequestedLevelFifthChild__c;
                    //opp.PreferredEnrolmentDate__c  = led.PreferredEnrollmenDateFifthChild__c; //RRAJ: 20180920 - Removed upon business request
                    opp.DayOrBoardingSchool__c  = led.DayOrBoardingSchoolFifthChild__c == AP_Constant.ledBoardingDayBoarding ? AP_Constant.ledFullBoarding : led.DayOrBoardingSchoolFifthChild__c; //CRA20190305 - w000344
                    opp.TECH_IsFromAgentLead__c = isAgent ? true : false;
                    opp.Notes__c  = led.FifthChildNotes__c;
                    //opp.CloseDate  = led.EnrollmentDateFifthChild__c;
                    //VJA opp.EnglishProficiencySpoken__c  = led.EnglishSpokenFifthChild__c;
                    //VJA opp.EnglishProficiencyWritten__c  = led.EnglishWrittenFifthChild__c;
                    //VJA opp.ConcernsOnSocialAcademicProgress__c  = led.ConcernAroundFifthChild__c;
                    //VJA opp.EducationSupportNeeded__c  = led.AdditionnalNeedsFifthChild__c;
                    //VJA opp.SocialEmotionalDifficulties__c  = led.EmotionalSocialDifficultyFifthChild__c;
                    //VJA opp.ChildNeedAdditionalSupport__c  = led.ExtraSupportFifthChild__c;
              		opp.CurrentPreviousSchoolName__c  = led.AttendedSchoolFifthChild__c; //-- WAS not COMMENTED ON PREPROD
                    //VJA opp.AttendedFrom__c  = led.AttendedFromFifthChild__c;
                    //VJA opp.AttendedTo__c  = led.AttendedToFifthChild__c;
                    //VJA opp.Country__c  = led.CountryFifthChild__c;
                    //VJA opp.City__c  = led.CityFifthChild__c;
                    //VJA opp.Curriculum__c  = led.CurriculumFifthChild__c;
                    //VJA opp.LanguageOfInstruction__c  = led.LanguageInstructionFifthChild__c;
                    //VJA opp.ReferenceRequest__c  = led.RefRequestFifthChild__c;
                    //VJA opp.ReasonForLeaving__c  = led.ReasonLeavingFifthChild__c;
                    //VJA opp.NumberOfSchoolsAttended__c  = led.NumberSchoolAttendedFifthChild__c;
                    //VJA opp.SchoolRejection__c  = led.RejectedFifthChild__c;
                    //VJA opp.WhatIsTheReason__c  = led.ReasonRejectedFifthChild__c;
                    //VJA opp.MedicalConditions__c  = led.MedicalConditionsFifthChild__c;
                    //VJA opp.SurgeryHistory__c  = led.MedicalSurgeryFifthChild__c;
                    //VJA opp.PrescriptionDrugs__c  = led.DrugsPrescriptionFifthChild__c;
                    //VJA opp.InabilityToParticipateInSports__c  = led.UnableSportFifthChild__c;
                    //VJA opp.ChildsAllergies__c  = led.AllergiesFifthChild__c;
                    //VJA opp.Vaccinations__c  = led.VaccinationsFifthChild__c;
                    //VJA opp.DietaryRequirements__c  = led.SpecialDietryFifthChild__c;
                    opp.Campus__c = led.Campus__c;
                    opp.LeadSubmissionDate__c = led.CreatedDate;
                    //VJA opp.FinancialAidRequested__c = led.FinancialAidRequested__c;
                    opp.ReferredByContact__c = Led.ReferredByContact__c; //ANA20181204 : Case 00001470
                    opp.ParentEmail__c = led.Parent1PrimaryEmail__c ;  //ANA20181012 : Case 00001504 
                    //VJA opp.ChineseProficiencySpoken__c = led.ChineseSpokenFifthChild__c; //ANA20181218: Case 00001533
                    //VJA opp.ChineseProficiencyWritten__c = led.ChineseWrittenFifthChild__c;
                    opp.WeChatCampaignName__c = led.WeChatCampaignName__c;   //ANA20190122 : Case 00001570
                    
                    opp.TermsConditions__c   =  Led.TermsConditions__c; //ANA20190107 : Case 00001557 (Added TermsConditions__c, ..., PaymentMethod__c for conversion)
                    opp.MedicalTermsConditions__c    =  Led.MedicalTermsConditions__c;
                    opp.PrivacyPolicy__c     =  Led.PrivacyPolicy__c;
                    opp.ChildPhotoDisclaimer__c  =  Led.ChildPhotoDisclaimer__c;
                    //VJA opp.SchoolTripAuthorization__c   =  Led.SchoolTripAuthorization__c;
                    //VJA opp.PrimaryContact__c    =  Led.PrimaryContact__c;
                    //VJA opp.ReportsReceipient__c     =  Led.ReportsReceipient__c;
                    //VJA opp.SchoolNewsCommContact__c  =     Led.SchoolNewsCommContact__c;
                    //VJA opp.ParentPortalAccess__c    =  Led.ParentPortalAccess__c;
                    //VJA opp.EmergencyContact__c  =  Led.EmergencyContact__c;
                    //VJA opp.EmergencyContactNum__c   =  Led.EmergencyContactNum__c;
                    //VJA opp.FeesPayer__c     =  Led.FeesPayer__c;
                    opp.CompanyOther__c  =  Led.CompanyOther__c;
                    //VJA opp.InvoiceAddress1__c   =  Led.InvoiceAddress1__c;
                    //VJA opp.InvoiceAddress2__c   =  Led.InvoiceAddress2__c;
                    opp.InvoiceCity__c   =  Led.City__c;
                    opp.PostalZipCode__c     =  Led.PostalZipCode__c;
                    opp.InvoiceCountry__c    =  Led.Country__c;
                    //VJA opp.PaymentStructure__c  =  Led.PaymentStructure__c;
                    //VJA opp.PaymentMethod__c     =  Led.PaymentMethod__c;
                    
                    //VJA opp.ContactName__c = Led.ContactNameFifthChild__c; //CRA20190211 : W344
                    //VJA opp.ContactEmailAddress__c = Led.ContactEmailFifthChild__c;  //CRA20190211 : W344
                    opp.LeadPriority__c = Led.Priority__c; //CRA20190804 : Case 00001738
                    opp.LeadID__c = led.Id; //CRA20190408 
                    opp.Lead__c = led.Id; //CRA20200619 : Case 00002304
                    opp.HasAttendedSummercamp__c = Led.HasAttendedSummercampFifthChild__c; //CRA20190625 :W000531

                    mapTempIdToOpp.put(tempId, opp);
                }
            }
        }
    }
    
}