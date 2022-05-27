/**
 * @File Name          : OpportunityContactRoleTrigger.trigger
 * @Description        : OpportunityContactRoleTrigger
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 23-09-2021 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    23-09-2021 10:00 am         VJA         Initial Version
**/
trigger OpportunityContactRoleTrigger on OpportunityContactRole (before insert) {

    OpportunityContactRoleTriggerHandler handler = new OpportunityContactRoleTriggerHandler();

    if(Trigger.isInsert && Trigger.isBefore){
        System.debug('###OpportunityContactRoleTrigger.BeforeInsert'); 
        handler.handleBeforeInsert(Trigger.new);
    }
}