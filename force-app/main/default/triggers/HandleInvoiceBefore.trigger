//created by Kunal on 19th May 2014
//desc: populates Xero Key on invoice 
trigger HandleInvoiceBefore on Invoice_Statement__c (before insert, before update) {
	list<Invoice_Statement__c> invoicesToBeProcessedForXeroKey = new list<Invoice_Statement__c>();
	set<string> schools = new set<string>();
	for(Invoice_Statement__c invoice:trigger.new){
		if(trigger.isInsert){
			if(invoice.School__c != null){
				invoicesToBeProcessedForXeroKey.add(invoice);
				schools.add(invoice.School__c);
			}
		}
		if(trigger.isUpdate){
			if(invoice.School__c != null && (invoice.School__c !=  trigger.oldMap.get(invoice.Id).School__c || invoice.Xero_Key__c == null)){
				invoicesToBeProcessedForXeroKey.add(invoice);
				schools.add(invoice.School__c);
				if(invoice.School__c == 'Pamplona') {
					schools.add('Navarra');
				}
			}
		}
	}
	
	if(invoicesToBeProcessedForXeroKey.size() > 0){
		
		map<string, Xero_Key__c> xeroKeyMap = new map<string, Xero_Key__c>();
		for(Xero_Key__c key:[select Id,Name from Xero_Key__c where Name IN:schools]){
			xeroKeyMap.put(key.Name,key);
		}
		//populate xero key
		for(Invoice_Statement__c invoice:invoicesToBeProcessedForXeroKey){
			string school = invoice.School__c;
			if(school == 'Pamplona') {
				school = 'Navarra';
			}
			Xero_Key__c key = xeroKeyMap.get(school);      
			if(key != null){
				invoice.Xero_Key__c = key.Id;
			}
		}
	}
}