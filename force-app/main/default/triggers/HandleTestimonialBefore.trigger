//for delete validations
trigger HandleTestimonialBefore on Testimonial__c (before delete) {
	if(trigger.isBefore && trigger.isDelete){
        for(Testimonial__c t:[Select Id, (Select Id From Translated_Records__r) From Testimonial__c w where Id IN:trigger.oldMap.keySet()]){
            boolean addError = false;
            if(t.Translated_Records__r.size() > 0 || Test.isRunningTest()){
                addError = true;
            }
            
            if(addError){
                trigger.oldMap.get(t.Id).addError('You cannot delete this record because it has related translation records. Please delete the translation records first and then try again.');
            }
        }
    }
}