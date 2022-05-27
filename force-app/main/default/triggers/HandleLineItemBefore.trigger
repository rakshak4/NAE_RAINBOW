trigger HandleLineItemBefore on Line_Item__c (before insert, before update) {
    for(Line_Item__c li:trigger.new){
        li.Student_Local_Name__c = li.Student_Local_Name_Sys__c;
    }
}