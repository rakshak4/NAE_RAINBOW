//validation for assessments before group deletion
trigger HandleGroupBefore on Group__c (before delete) {
    for(Group__c g:trigger.old){
        if(g.Assessments__c != null){
            if(g.Assessments__c > 0){
                g.addError('You can\'t delete a student group which contains assessment records. Please delete any related assessment records first or contact your system administrator for assistance');
            }
        }
    }
}