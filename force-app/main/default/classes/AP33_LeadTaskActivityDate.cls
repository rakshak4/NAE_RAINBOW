/**
 * @File Name          : AP33_LeadTaskActivityDate
 * @Description        : Populate Lead FirstActivityDate field - Case 3782
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : FKH
 * @Last Modified On   : 06-JUL-2021, 2:03 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    06-JUL-2021, 2:03 PM         FKH         Initial Version
**/
public class AP33_LeadTaskActivityDate {
    public static void updateFirstActivityDate(Set<id> setLeadId,List<Task> lstTskInserted){
        List<Lead> lstLeadToUpdate = [SELECT id,FirstActivityDate__c FROM lead where id IN:setLeadId and FirstActivityDate__c=null]; //filter inserted lead by FirstActivityDate__c
        Set<Id> setLedID = new Set<Id>(); // keep leads having existing task
        List<Task> lstTasks = [SELECT id,WhoId FROM Task Where WhoId IN: lstLeadToUpdate AND (NOT id IN:lstTskInserted )];  //query if existing tasks exists for leads in the List; excluding recent tasks
        
        for (Task tsk: lstTasks){
            setLedID.add(tsk.whoid); // add Leads with existing tasks in set
        }
        for(Lead led :  lstLeadToUpdate){
            led.FirstActivityDate__c = (setLedID==null || !setLedID.contains(led.id)) ? system.now(): null; 
        }
        if(lstLeadToUpdate.size() > 0){
            update lstLeadToUpdate;
        }
    }
}