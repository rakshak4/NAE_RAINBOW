//for before delete valiadtions on web content 
//not allows deletion if record is mentioned in self lookup in other records
trigger HandleWebContentBefore on Web_Content__c (before delete) {
    if(trigger.isBefore && trigger.isDelete){
        for(Web_Content__c wc:[Select w.Id, (Select Id From Sidebar_Block__r), (Select Id From web_content_link__r), (Select Id From Translated_Records__r), (Select Id From Web_Sub_Content__r) From Web_Content__c w where Id IN:trigger.oldMap.keySet()]){
            boolean addError = false;
            if(wc.Sidebar_Block__r.size() > 0){
                addError = true;
            }
            if(wc.web_content_link__r.size() > 0){
                addError = true;
            }
            if(wc.Translated_Records__r.size() > 0){
                addError = true;
            }
            if(wc.Web_Sub_Content__r.size() > 0){
                addError = true;
            }
            if(addError){
                trigger.oldMap.get(wc.Id).addError('You cannot delete this record because it has related child records. Please delete the child records first and then try again.');
            }
        }
    }
}