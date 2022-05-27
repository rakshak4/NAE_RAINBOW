/**
 * @File Name          : AP22_ContentDocumentLinkRules.cls
 * @Description        : - Re-associate Child files from the Account to the respective Child Opportunity
                         - Clone parent documents and associate to All Opportunities
                         - Update associated Document Checklist 
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 04/07/2019, 14:54:38
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    03/07/2019, 14:59:46   CRA     Initial Version
**/
public with sharing class AP22_ContentDocumentLinkRules {
    private Map<Id,List<ContentDocumentLink>> mapAccCdl = new Map<Id,List<ContentDocumentLink>>();
    private Set<Id> setCntDocId = new Set<Id>();
    
    public AP22_ContentDocumentLinkRules (Map<Id,List<ContentDocumentLink>> mapAccountCdl, Set<Id> setContentDocId) {
        System.debug('<<<<<<<<<< Begin - AP22_ContentDocumentLinkRules >>>>>>>>>>');
        mapAccCdl = mapAccountCdl;
        setCntDocId = setContentDocId;
        
        Map<Id,ContentDocument> mapDoc = new Map<Id,ContentDocument>([SELECT Id, Title FROM ContentDocument WHERE Id IN :setContentDocId]);
        List<ContentDocumentLink> lstCdlParent = new List<ContentDocumentLink>();
        Map<Id, DocumentChecklist__c> mapDocChkToUpdate = new Map<Id, DocumentChecklist__c>();

        if (mapAccCdl.size() > 0 && mapDoc.size() > 0) {
            for (Opportunity opp : [SELECT Id, AccountId, Child__r.Firstname, Child__r.Lastname, (SELECT Id, Name, Status__c, DateReceived__c FROM DocumentChecklists__r ) FROM Opportunity WHERE LeadOrigin__c = 'Application' AND AccountId IN :mapAccCdl.keySet()]) {
                for (ContentDocumentLink cdl : mapAccCdl.get(opp.AccountId)) {
                    Map<Id, DocumentChecklist__c> mapDchk = new Map<Id, DocumentChecklist__c>();
                    if (mapDoc.get(cdl.ContentDocumentId) != null) {
                        String docTitle = mapDoc.get(cdl.ContentDocumentId).Title;
                        
                        //attach all Parent Documents to all related opportunities 
                        if(docTitle.startsWithIgnoreCase(AP_Constant.accDocumentTitleParent)) {
                            lstCdlParent.add(new ContentDocumentLink(ContentDocumentId=cdl.ContentDocumentId, LinkedEntityId=opp.Id, ShareType='V', Visibility='AllUsers'));
                            if (opp.DocumentChecklists__r.size() > 0) {
                                mapDchk = getDocumentChecklistToUpdate( opp.DocumentChecklists__r, docTitle);
                            }
                        }

                        //move child document to child opportunity
                        else if (docTitle.startsWithIgnoreCase(AP_Constant.accDocumentTitleChild) 
                                && (mapDoc.get(cdl.ContentDocumentId).Title.substringAfter('_')).substringBeforeLast('_').equalsIgnoreCase(opp.Child__r.Firstname + '-' +opp.Child__r.Lastname)) {
                            cdl.LinkedEntityId = opp.Id;
                            if (opp.DocumentChecklists__r.size() > 0) {
                                mapDchk = getDocumentChecklistToUpdate( opp.DocumentChecklists__r, docTitle);
                            }
                        }
                    }
                    if (mapDchk.size() > 0) {
                        mapDocChkToUpdate.putAll(mapDchk);
                    }
                }
            }
        }

        if (lstCdlParent.size() > 0) {
            System.debug('<<<<<<<<<< Insert - Parent ContentDocumentLink >>>>>>>>>>');
            insert lstCdlParent;
        }

        if (mapDocChkToUpdate.size() > 0) {
            System.debug('<<<<<<<<<< Update - Document Checklist >>>>>>>>>>');
            update mapDocChkToUpdate.values();
        }
        System.debug('<<<<<<<<<< End - AP22_ContentDocumentLinkRules >>>>>>>>>>');
    }

    
    /**
    * @description - Check if the Document Title is equal to the Document Checklist name
    * @author CRA | 04/07/2019
    * @param List<DocumentChecklist__c> lstDocChk - List of Document Checklist to be compared
    * @param String docTitle - Document Name
    * @return Map<Id, DocumentChecklist__c> - Document Checklist to update
    */
    private Map<Id, DocumentChecklist__c> getDocumentChecklistToUpdate(List<DocumentChecklist__c> lstDocChk, String docTitle) {
        System.debug('<<<<<<<<<< Begin - getDocumentChecklistToUpdate >>>>>>>>>>');
        Map<Id, DocumentChecklist__c> mapDocumentChkToUpdate = new Map<Id, DocumentChecklist__c>();
        for(DocumentChecklist__c dchk : lstDocChk) {
            String docName = docTitle.substringAfterLast('_').substringBeforeLast('.');
            System.debug('docname ' +docName);
            System.debug('dchkname ' +(dchk.Name).deleteWhitespace());
            if(docName.containsOnly((dchk.Name).deleteWhitespace())) {
                dchk.Status__c = AP_Constant.docChklstStatusSubmitted;
                dchk.DateReceived__c = System.today();
                mapDocumentChkToUpdate.put(dchk.Id, dchk);
            }
        }
        return mapDocumentChkToUpdate;
    }
}