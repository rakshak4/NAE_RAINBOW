/***
	Author: Kunal
	Dated: 11 Oct 2013
	Desc: Update line items on invoice update
***/
trigger HandleInvoiceAfterUpdate on Invoice_Statement__c (after update) {
	set<Id> invoiceIds =  new set<Id>();
	for(Invoice_Statement__c i:trigger.new){
		//if(i.Invoice_Date__c != trigger.oldMap.get(i.Id).Invoice_Date__c){
			invoiceIds.add(i.Id);
		//}
	}
	
	if(invoiceIds.size() > 0){
		List<Line_Item__c> lineItems =  new List<Line_Item__c>();
		for(Invoice_Statement__c i:[Select i.Invoice_Date__c, i.Id, (Select Id,Invoice_Date_Text_from_statement__c ,Name From Line_Items__r) From Invoice_Statement__c i where i.Id IN:invoiceIds]){
			for(Line_Item__c l:i.Line_Items__r){
				l.Invoice_Date_Text_from_statement__c = i.Invoice_Date__c;
				lineItems.add(l);
			}
		}
		if(lineItems.size() > 0){
			update lineItems;
		} 
	}
}