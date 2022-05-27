/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex controller for lightning component LC05_ConvertLead
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 13-JUNE-2018  RRAJ   1.0     Initial Version
-- 07-DEC-2018   CRA    1.1     Copy CreatedDate of Lead's Task to converted Activities  
-- 24-JAN-2020   CRA    1.2     Resolved Case 00002195
-- 02-Mar-2021   VJA    1.3     Case 0000 3103 - Cater for EmailMessage
-- 02-Mar-2021   VJA    1.4     Case 00003433 - Cater for Email Tasks + Attachments
--------------------------------------------------------------------------------------
**************************************************************************************/
public with sharing class LC05_ConvertLead {

    /**
     * Controller method to convert a single lead
     * @param  ledId Id of lead to be converted
     * @return Upon successful conversion, returns id of converted account.
     */
    @AuraEnabled
    public static Id convertLead(Id ledId){ 
        Activity activity = cloneActivities(ledId);

        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(ledId);
        lc.setConvertedStatus(convertStatus.MasterLabel);
        lc.setDoNotCreateOpportunity(true);

        try{
            Database.LeadConvertResult lcr = Database.convertLead(lc);
            updateCloneActivities(activity, lcr.getAccountId());
            return lcr.getAccountId();
        }catch(System.DmlException e){
            System.debug('##LC05_ConvertLead error msg: ' + e);
            throw new AuraHandledException(e.getDmlMessage(0));
        }
    }


    public static void updateCloneActivities(Activity activity, Id accId){

        List<CombinedAttachment> lstCombinedAttachment = new List<CombinedAttachment>();
        List<ContentDocumentLink> lstContentDocumentLink  = new List<ContentDocumentLink>();
        List<Attachment> lstTaskAttachment = new List<Attachment>();
        List<Attachment> lstAttachment = new List<Attachment>();
        Map<Id, Set<Id>> mapTaskIdToAttachmentIds = new Map<Id, Set<Id>>();
        Set<Id> setAttachmentId = new Set<Id>();
        Map<ID, Attachment> lstAttachmentResult = new Map<ID, Attachment>();

        //VJA20210427 Case 00003433
        if(activity.lstClonedMessages != null) {

            for(EmailMessage emailMessage : activity.lstClonedMessages){ //EM field values assignment
                emailMessage.activityId = null;
                emailMessage.relatedToId = accId;
                emailMessage.ValidatedFromAddress=null;
            }

            insert activity.lstClonedMessages;

            for(EmailMessage emailMessage : activity.lstClonedMessages){ //Create ContentDocumentLink to Attachment
                lstCombinedAttachment = emailMessage.CombinedAttachments;
                if(lstCombinedAttachment != null && lstCombinedAttachment.size() > 0){
                    for(CombinedAttachment combinedAttachment : lstCombinedAttachment){
                        lstContentDocumentLink.add( new ContentDocumentLink(LinkedEntityId = emailMessage.id, ContentDocumentId = combinedAttachment.Id, ShareType = 'V') );
                    }
                }
            }
    
            if(lstContentDocumentLink.size() > 0){
                System.debug('###lstContentDocumentLink: ' + lstContentDocumentLink.size());
                insert lstContentDocumentLink;
            }
        }

        if(activity.lstClonedTasks != null) { //TSK field values assignment
            for(Task tsk: activity.lstClonedTasks) {
                tsk.WhoId = null;
                tsk.WhatId = accId;
            }

            insert activity.lstClonedTasks;

            for(Task tsk: activity.lstClonedTasks) {
                lstTaskAttachment = tsk.Attachments;
                System.debug('###lstTaskAttachment: ' + lstTaskAttachment.size());

                for(Attachment attachment : lstTaskAttachment){
                    setAttachmentId.add(attachment.Id);

                    if(mapTaskIdToAttachmentIds.containsKey(tsk.id)){
                        mapTaskIdToAttachmentIds.get(tsk.id).add(attachment.id);
                    }
                    else{
                        mapTaskIdToAttachmentIds.put(tsk.id, new Set<Id>{attachment.id});
                    }
                }
            }

            if(setAttachmentId.size() > 0){
                lstAttachmentResult = new Map<ID, Attachment>([SELECT Id, Body, Name, Description, ParentId FROM Attachment WHERE Id=:setAttachmentId]);
                System.debug('###lstAttachmentResult: ' + lstAttachmentResult.size());
            }

            if(lstAttachmentResult.size() > 0){
                for(Task tsk: activity.lstClonedTasks) {
                    if(mapTaskIdToAttachmentIds.containsKey(tsk.id)){
                        for(Id attachmentId : mapTaskIdToAttachmentIds.get(tsk.id)){
                            if(lstAttachmentResult.containsKey(attachmentId)){
                                Attachment attachment = lstAttachmentResult.get(attachmentId);
                                Attachment clonedAttachment = attachment.clone();
                                clonedAttachment.parentid = tsk.id;
                                // lstAttachment.add( new Attachment(name = attachment.name, body = attachment.body, parentid = tsk.id));
                                lstAttachment.add(clonedAttachment);
                            }
                        }
                    }
                }
            }

            if(lstAttachment.size() > 0){
                System.debug('###lstAttachment: ' + lstAttachment.size());
                insert lstAttachment;
            }
        }
       
        if(activity.lstClonedEvents != null) { //EVT field values assignment
            for(Event evt: activity.lstClonedEvents) {
                evt.WhoId = null;
                evt.WhatId = accId;
            }
            insert activity.lstClonedEvents;
        }
    }

    public static Activity cloneActivities(Id leadId){
        String taskQueryStr = getCreatableFieldsSOQL('Task', 'WhoId =: leadId', 'Select id from Attachments');
        String eventQueryStr = getCreatableFieldsSOQL('Event', 'WhoId =: leadId', '');
        List<Task> lstTasks = (List<Task>) Database.query(taskQueryStr);
        List<Task> lstTaskToCreate = new List<Task>();
        List<Event> lstEvents = (List<Event>) Database.query(eventQueryStr);
        Map<Id, Task> mapIdToTask = new Map<Id, Task>();
        Set<Id> setActivityId = new Set<Id>();
        Set<Id> setTaskId = new Set<Id>();

        //CRA 20181207 - W-491
        if(lstTasks.size() > 0) {
            for(Task tsk : lstTasks) {
                tsk.OriginLeadDate__c = tsk.CreatedDate;
                if(tsk.TaskSubtype == 'Email' && tsk.Subject.startsWith('Email:')){ //Distinction between TSK & EM
                    mapIdToTask.put(tsk.Id, tsk);
                }else{
                    lstTaskToCreate.add(tsk);
                }
            }
        }

        if(lstEvents.size() > 0) {
            for(Event evt : lstEvents) {
                evt.OriginLeadDate__c = evt.CreatedDate;
            }
        }
        //End CRA

        setTaskId = mapIdToTask.keySet();
        String emailMessageQueryStr = getCreatableFieldsSOQL('EmailMessage', 'ActivityId in :setTaskId', 'Select Id FROM CombinedAttachments');
        
        List<EmailMessage> lstEmailMessages = (List<EmailMessage>) Database.query(emailMessageQueryStr);

        for(EmailMessage emailMessage : lstEmailMessages){
            setActivityId.add(emailMessage.ActivityId);
        }

        for(Id taskId : mapIdToTask.KeySet()){
            if(!setActivityId.contains(taskId)){
                lstTaskToCreate.add(mapIdToTask.get(taskId));
            }
        }

        return new Activity(lstTaskToCreate.size() > 0? lstTaskToCreate.deepClone(): null, lstEvents.size() > 0? lstEvents.deepClone(): null, lstEmailMessages.size() > 0? lstEmailMessages.deepClone(): null);
    }

    public static String getCreatableFieldsSOQL(String objectName, String whereClause, String innerQuery) {
        String selects = '';
         
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        Set<String> selectFields = new Set<string>();
         
        if (fMap != null) {
            for (Schema.SObjectField ft : fMap.values()) { 
                Schema.DescribeFieldResult fd = ft.getDescribe();
                if (fd.isCreateable()) {
                    selectFields.add(fd.getName());
                }
            }
        }
         
        if (!selectFields.isEmpty()) {
        	//CRA Edit- 20181207 - W-491 
            if(!selectFields.contains('CreatedDate')) {
                selectFields.add('CreatedDate');
            }
            //End CRA
            for (String s:selectFields) {
                selects += s + ',';
            }
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
        }
        
        if(String.isNotEmpty(innerQuery)){ //Add innerQuery
            if(!selectFields.isEmpty()){
                selects = selects + ', (' + innerQuery + ')';
            }else{
                selects = selects + ' (' + innerQuery + ')';
            }
        }

        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
    }

    public class Activity{
        List<Task> lstClonedTasks{get;set;}
        List<Event> lstClonedEvents{get;set;}
        List<EmailMessage> lstClonedMessages{get;set;}

        public Activity(List<Task> lstClonedTasks, List<Event> lstClonedEvents, List<EmailMessage> lstClonedMessages){
            this.lstClonedTasks = lstClonedTasks;
            this.lstClonedEvents = lstClonedEvents;
            this.lstClonedMessages = lstClonedMessages;
        }
    }
}