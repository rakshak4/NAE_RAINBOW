/**
 * @File Name          : ContentDocumentLinkTrigger.trigger
 * @Description        : 
 * @Author             : Spoon Coonsulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 04/07/2019, 11:01:25
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    03/07/2019, 15:49:26   CRA     Initial Version
**/
trigger ContentDocumentLinkTrigger on ContentDocumentLink (before insert) {
    ContentDocumentLinkTriggerHandler handler = new ContentDocumentLinkTriggerHandler();
    if(Trigger.isBefore && Trigger.isInsert) {
        handler.handleBeforeInsert(Trigger.new);
    }
}