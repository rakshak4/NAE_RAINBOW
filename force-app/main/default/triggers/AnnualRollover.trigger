trigger AnnualRollover on Opportunity (after update) {
	/*
	system.debug('***AnnualRollover***start:'+trigger.newMap);
	for(String opId : trigger.newMap.keySet()) {
		
		Opportunity newOp = trigger.newMap.get(opId);
		Opportunity oldOp = trigger.oldMap.get(opId);
		
		Map<String, String> opportunities = new Map<String, String>();
		// if the year group has been changed then set all current fees to noncurrent and create a new Tuition fee
		if(oldOp !=null && oldOp.Year_Group__c != newOp.Year_Group__c) 
		{
			// if so add it to the map for changing it to the new year
			opportunities.put(newOp.Id, newOp.Year_Group__c);
		}
		
		if(opportunities.size() > 0) {
			IncrementTuitionFee.execute(opportunities);
		}
	}
	system.debug('***AnnualRollover***end:'+trigger.newMap);*/
}
	
	/*//Objects to update or insert
	List<OpportunityLineItem> 	oliToUpdate = new List<OpportunityLineItem>();
	//Objects needed during for-loops
	Map<String, List<OpportunityLineItem>> oppLineItems = new Map<String, List<OpportunityLineItem>>();
	Map<String, PriceBookEntry> allPBEs	= new Map<String, PriceBookEntry>();
	List<Product2> allProducts = [Select Id, Year_Group__c, Fee_Frequency__c, Fee_Season__c, Description_of_Fee__c, Invoice_Currency__c From Product2];
	
	//Set up the maps of data
	for(OpportunityLineItem oli : [Select Id, PricebookEntryId, OpportunityId, Current__c, Payer__c, Months_In_Year__c, Invoicing_Term__c From OpportunityLineItem Where OpportunityId in: trigger.newMap.keySet()]) {
		if(oppLineItems.get(oli.OpportunityId) == null)
			oppLineItems.put(oli.OpportunityId, new List<OpportunityLineItem>());
		oppLineItems.get(oli.OpportunityId).add(oli);
	}
	for(PricebookEntry pbe : [Select Id, Product2Id, Product2.Year_Group__c, Product2.Invoice_Currency__c From PricebookEntry]) {
		allPBEs.put(pbe.Id, pbe);
	}
	
	for(String opId : trigger.newMap.keySet()) {
		
		Opportunity newOp = trigger.newMap.get(opId);
		Opportunity oldOp = trigger.oldMap.get(opId);
		//If the year group has been changed then set all current fees to noncurrent and create a new Tuition fee
		if(oldOp !=null && oldOp.Year_Group__c != newOp.Year_Group__c) 
		{
			String invoiceCurrency = null;
			OpportunityLineItem oldTuitionFee = null;
			if(oppLineItems.get(newOp.Id) != null) {
				for(OpportunityLineItem currOli : oppLineItems.get(newOp.Id)) {
					//Set old tuition line item to non current so they're still stored in the system
					PricebookEntry pbe = allPBEs.get(currOli.PricebookEntryId);
					if(currOli.Current__c && pbe.Product2.Year_Group__c != null) 
					{
						currOli.Current__c = false;
						oliToUpdate.add(currOli);
						oldTuitionFee = currOli;
						invoiceCurrency = pbe.Product2.Invoice_Currency__c;
					}
				}
			}
			//Create the opportunity line item
			if(invoiceCurrency != null && oldTuitionFee != null)
			{
				Product2 tuitionFee = null; 
				for(Product2 p : allProducts)
				{
					if(p.Year_Group__c == newOp.Year_Group__c && p.Invoice_Currency__c == invoiceCurrency && p.Fee_Frequency__c == oldTuitionFee.Invoicing_Term__c 
							&& p.Fee_Season__c == oldTuitionFee.Months_In_Year__c)
						tuitionFee = p;
				}
				
				if(tuitionFee != null && newOp.Pricebook2Id != null)
				{
					PriceBookEntry pbe = [Select Id, Product2Id, UnitPrice, Pricebook2Id From PricebookEntry Where Product2Id =: tuitionFee.Id and Pricebook2Id =: newOp.Pricebook2Id];
					if(pbe != null)
					{
						OpportunityLineItem oli = new OpportunityLineItem();
						oli.PricebookEntryId = pbe.Id; 
						oli.OpportunityId = newOp.Id;
						oli.Quantity = 1;
						oli.TotalPrice = pbe.UnitPrice;
						oli.Current__c = true;
						oli.Payer__c = oldTuitionFee.Payer__c;
						oli.Months_In_Year__c = tuitionFee.Fee_Season__c;
						oli.Invoicing_Term__c = tuitionFee.Fee_Frequency__c;
						oli.Tuition__c = true;
						oliToUpdate.add(oli);
					}
				}
			}
		}
	}
	
	upsert oliToUpdate;
}*/