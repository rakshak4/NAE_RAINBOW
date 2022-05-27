/**
 * Sets a pricebook on new opportunities as dictated by the "Price Book to Allocate" formula field.
 * This trigger searches for a matching pricebook name and sets it automatically.
 *
 * @author Logan
 * @date Septemer 2013
 */
 trigger SelectDefaultPricebook on Opportunity (after insert) {

 	Set<String> pricebookNames = new Set<String>();
	for (Opportunity student : trigger.new) {
		pricebookNames.add(student.Price_Book_to_Allocate__c);
	}

	Map<String,Id> pricebookIds = new Map<String,Id>();
	for(Pricebook2 pb : [SELECT Id, Name FROM Pricebook2 WHERE Name IN :pricebookNames]) {
		pricebookIds.put(pb.Name, (pricebookIds.containsKey(pb.Name) ? null : pb.Id));
	}

	List<Opportunity> opportunities = new List<Opportunity>();
	for (Opportunity student : Trigger.New) {
		if (student.Pricebook2Id == null && pricebookIds.containsKey(student.Price_Book_to_Allocate__c)) {
			Id pricebookId = pricebookIds.get(student.Price_Book_to_Allocate__c);
			if (pricebookId != null) {
				opportunities.add(new Opportunity(Id = student.Id, Pricebook2Id = pricebookId));
			}
		}
	}

	try {
		update opportunities;
	}
	catch(Exception e) {
		// Do no error. If we fail to set the default pricebook, the user gets the chance to set it themselves.
	}
}