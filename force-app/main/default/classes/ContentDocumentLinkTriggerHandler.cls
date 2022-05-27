/**
 * @File Name          : ContentDocumentLinkTriggerHandler.cls
 * @Description        : 
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 04/07/2019, 13:09:50
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    03/07/2019, 15:02:22   CRA     Initial Version
**/
public with sharing class ContentDocumentLinkTriggerHandler {
    private CS_Bypass__c userBypass;

    public ContentDocumentLinkTriggerHandler() {
        userBypass = CS_Bypass__c.getInstance(UserInfo.getUserId());
    }

    public void handleBeforeInsert(List<ContentDocumentLink> lstNewCdl){
        System.debug('<<<<<<<<<< Begin - ContentDocumentLink Trigger Before Insert >>>>>>>>>>');
        Map<Id, List<ContentDocumentLink>> mapCdl = new Map<Id, List<ContentDocumentLink>>();
        Set<Id> setCntDoc = new Set<Id>();

        if(userBypass.BypassTrigger__c == NULL || !userBypass.BypassTrigger__c.contains('AP22')){
            for(Integer i = 0; i<lstNewCdl.size(); i++) {
                if(lstNewCdl[i].LinkedEntityId.getSObjectType() == Schema.Account.SObjectType) { 
                    setCntDoc.add(lstNewCdl[i].ContentDocumentId);
                    if (mapCdl.containsKey(lstNewCdl[i].LinkedEntityId)) {
                        mapCdl.get(lstNewCdl[i].LinkedEntityId).add(lstNewCdl[i]);
                    }
                    else {
                        mapCdl.put(lstNewCdl[i].LinkedEntityId, new List<ContentDocumentLink> { lstNewCdl[i] });
                    }
                }
            }
        }
        
        if(mapCdl.size() > 0 && setCntDoc.size() > 0) {
            new AP22_ContentDocumentLinkRules(mapCdl, setCntDoc);
        }
        System.debug('<<<<<<<<<< End - ContentDocumentLink Trigger Before Insert >>>>>>>>>>');
    }
}