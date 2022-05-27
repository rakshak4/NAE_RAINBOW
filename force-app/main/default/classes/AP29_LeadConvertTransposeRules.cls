/**
 * @File Name          : AP29_LeadConvertTransposeRules.cls
 * @Description        : Invocable methods for lead transposition and conversion
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 21-JAN-2021, 2:20 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    21-JAN-2021, 10:00 am         VJA         Initial Version
**/
public without sharing class AP29_LeadConvertTransposeRules {

    @InvocableMethod(
        label = 'Clone Lead Activities To Account'
        description = 'Clone lead activties and associate the cloned ones to an account. Required Parameters(leadId, accountId)'
    )
    public static void cloneLeadActivities(List<FlowInputs> request){
        if(request.size()>0 && request[0].leadId != null && request[0].accountId != null ){
            Activity act = cloneActivities(request[0].leadId);
            if(act != null){
                try{
                    insertAccountActivities(act,request[0].accountId);
                }catch(Exception e){
                    System.debug('###cloneActivities Failed');
                }
            }
        }
    }

    public static Activity cloneActivities(Id leadId){
        String taskQueryStr = getCreatableFieldsSOQL('Task', 'WhoId =: leadId', '');
        String eventQueryStr = getCreatableFieldsSOQL('Event', 'WhoId =: leadId', '');
        List<Task> lstTasks = (List<Task>) Database.query(taskQueryStr);
        List<Task> lstTaskToCreate = new List<Task>();
        List<Event> lstEvents = (List<Event>) Database.query(eventQueryStr);
        Set<Id> setTaskId = new Set<Id>();

        //CRA 20181207 - W-491
        if(lstTasks.size() > 0) {
            for(Task tsk : lstTasks) {
                tsk.OriginLeadDate__c = tsk.CreatedDate;

                if(tsk.TaskSubtype == 'Email' && tsk.Subject.startsWith('Email:')){ //Distinction between TSK & EM
                    setTaskId.add(tsk.Id);
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

        String emailMessageQueryStr = getCreatableFieldsSOQL('EmailMessage', 'ActivityId in :setTaskId', 'Select Id FROM CombinedAttachments');
        
        List<EmailMessage> lstEmailMessages = (List<EmailMessage>) Database.query(emailMessageQueryStr);

        return new Activity(lstTaskToCreate.size() > 0? lstTaskToCreate.deepClone(): null, lstEvents.size() > 0? lstEvents.deepClone(): null, lstEmailMessages.size() > 0? lstEmailMessages.deepClone(): null);
    }

    public static void insertAccountActivities(Activity activity, Id accId){

        List<CombinedAttachment> lstCombinedAttachment = new List<CombinedAttachment>();
        List<ContentDocumentLink> lstContentDocumentLink  = new List<ContentDocumentLink>();

        if(activity.lstClonedMessages != null) {

            for(EmailMessage emailMessage : activity.lstClonedMessages){ //EM field values assignment
                emailMessage.activityId = null;
                emailMessage.relatedToId = accId;
                emailMessage.ValidatedFromAddress=null;
            }

            System.debug('###AP29 - activity.lstClonedMessages: ' + activity.lstClonedMessages.size());
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
                insert lstContentDocumentLink;
            }
        }

        if(activity.lstClonedTasks != null) { //TSK field values assignment
            for(Task tsk: activity.lstClonedTasks) {
                tsk.WhoId = null;
                tsk.WhatId = accId;
            }
            System.debug('###AP29 - activity.lstClonedTasks: ' + activity.lstClonedTasks.size());
            insert activity.lstClonedTasks;
        }
        
        if(activity.lstClonedEvents != null) { //EVT field values assignment
            for(Event evt: activity.lstClonedEvents) {
                evt.WhoId = null;
                evt.WhatId = accId;
            }
            System.debug('###AP29 - activity.lstClonedEvents: ' + activity.lstClonedEvents.size());
            insert activity.lstClonedEvents;
        }
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

    //input details that comes to apex from flow
    public class FlowInputs{
    
        @InvocableVariable(
            label = 'Lead ID'
            description = 'ID of the Lead'
            required = true
        )
        public ID leadId;

        @InvocableVariable(
            label = 'Account ID'
            description = 'ID of account'
        )
        public ID accountId;
        
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

    //VJA20210427 2.5
    public static void updateConvertedLeadContacts(Map<Id, Id> mapContactIdToLeadId){
        List<Contact> lstCon = [Select id, LeadId__c from Contact where id in : mapContactIdToLeadId.KeySet()];
        List<Contact> lstContactToUpdate = new List<Contact>();
        for(Contact con : lstCon){
            if(mapContactIdToLeadId.get(con.Id) != null && con.LeadId__c == null){
                con.LeadId__c = mapContactIdToLeadId.get(con.Id);
                lstContactToUpdate.add(con);
            }
        }
        update lstContactToUpdate;
    }
}