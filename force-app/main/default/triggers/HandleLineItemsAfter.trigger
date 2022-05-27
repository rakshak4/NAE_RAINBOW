//created by Kunal on 20th May
//rolls up text fields info on invoice object
trigger HandleLineItemsAfter on Line_Item__c (after insert, after update) {
	system.debug('***HandleLineItemsAfter**start***new map='+trigger.newMap);
	system.debug('***HandleLineItemsAfter**start***old map='+trigger.oldMap);
	set<Id> invoiceIds = new set<Id>();
	for(Line_Item__c li:trigger.new){
		if(trigger.isInsert){
			if(li.Student_Local_Name__c != null && li.Student_Local_Name__c != ''){
				invoiceIds.add(li.Invoice_Statement__c);
			}			
		}
		if(trigger.isUpdate){     
			if(li.Student_Local_Name__c != trigger.oldMap.get(li.Id).Student_Local_Name__c || li.Invoice_Statement__c != trigger.oldMap.get(li.Id).Invoice_Statement__c || li.Student__c != trigger.oldMap.get(li.Id).Student__c ){
				invoiceIds.add(li.Invoice_Statement__c);
			}
		}
	}
	system.debug('***HandleLineItemsAfter**invoiceIds='+invoiceIds);
	if(invoiceIds.size() > 0){
		//fetch all line items for Invoice 
		list<Invoice_Statement__c> invoiceList = new list<Invoice_Statement__c>();
		for(Invoice_Statement__c invoice:[Select i.Reference_Local_Language__c, (Select Id, Name, Student__c, Student_Local_Name__c From Line_Items__r order by Name) From Invoice_Statement__c i where i.Id IN:invoiceIds]){
			string reference_localName ;
			set<string> slist = new set<string>();
			for(Line_Item__c li:invoice.Line_Items__r){
				if(li.Student_Local_Name__c != null && li.Student_Local_Name__c != ''){
					slist.add(li.Student_Local_Name__c);
				}
			}
			for(string name:slist){
				if(reference_localName == null){
					reference_localName = name;
				}else{
					reference_localName += ','+name;
				}
			}
			if(reference_localName != null){
				invoice.Reference_Local_Language__c = reference_localName;
				invoiceList.add(invoice);
			}
		}
		if(invoiceList.size() > 0){
			update invoiceList;
		}
	}
	
}