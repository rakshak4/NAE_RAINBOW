public with sharing class IncrementTuitionFee {
	
	// exception class
	public class IncrementException extends Exception { } 
	
	// Takes a Map of Opportunitie ids and the new year group the tuition fee is to be set to
	public static boolean execute(Map<String, String> opportunityMap, boolean isFromBatch, map<Id,Opportunity> newOppMap) {
		boolean isSuccess = true;
		
		System.debug('## excuting increment tuition fee');
		// get the opportunity objects
		List<Opportunity> opportunities = [Select Id, Half_Day_PN_N__c, Half_Day_PN_N_Checkbox__c ,Next_Year_Half_Day_PN_N__c , Half_Day_PN_N_NY_Checkbox__c, Pricebook2Id from Opportunity Where Id in: opportunityMap.keySet()];
		
		// Objects needed during for-loops
		Map<String, PriceBookEntry> allPBEs	= new Map<String, PriceBookEntry>();
		Map<String, List<OpportunityLineItem>> oppLineItems = new Map<String, List<OpportunityLineItem>>();
		
		// Get the opportunity line items that are yearly/termly & tuition
		for(OpportunityLineItem oli : [Select Id, PricebookEntryId, Tuition__c, OpportunityId, Discount,
										Invoice_Date__c, Next_Generated_Invoice__c, Current__c, 
										Payer__c, Months_In_Year__c, Invoicing_Term__c 
										From OpportunityLineItem 
										Where OpportunityId in: opportunityMap.keySet()
											and Current__c =: true
											and Tuition__c =: true]) 
		{
			if(oppLineItems.get(oli.OpportunityId) == null) {
				
				oppLineItems.put(oli.OpportunityId, new List<OpportunityLineItem>());
			}
			
			oppLineItems.get(oli.OpportunityId).add(oli);
			allPBEs.put(oli.PricebookEntryId ,null);
		}
		
		List<String> currencies = new List<String>();
		// get all the price book entries related to the opp line items
		for(PricebookEntry pbe : [Select Id, Product2Id, Product2.Invoice_Currency__c, Product2.Year_Group__c, Product2.Half_Day__c
									From PricebookEntry Where Id in: allPBEs.keySet()]) 
		{
			allPBEs.put(pbe.Id, pbe);
			currencies.add(pbe.Product2.Invoice_Currency__c);
		}
		
		List<Product2> allProducts = [
			SELECT Id, Year_Group__c, Fee_Frequency__c, Fee_Season__c, 
				Description_of_Fee__c, Invoice_Currency__c, Half_Day__c, IsActive
			  From Product2
			 WHERE Year_Group__c in: opportunityMap.values()
			   AND Invoice_Currency__c in: currencies
		];
											
		System.debug('## opportunityMap.values() ' +opportunityMap.values());
		System.debug('## currencies ' +currencies);
		System.debug('## allProducts ' +allProducts);

		// Objects to update or insert
		List<OpportunityLineItem> oliToUpdate = new List<OpportunityLineItem>();
		
		for(Opportunity opp : opportunities) {
			
			String yearGroup = opportunityMap.get(opp.Id);
			
			// Should only be 1 tuition fee.
			if(oppLineItems.get(opp.Id) != null && oppLineItems.get(opp.Id).size() == 1) {
				
				// Set old tuition line item to non current so they're still stored in the system
				OpportunityLineItem oldTuitionFee = oppLineItems.get(opp.Id).get(0);
				PricebookEntry pbe = allPBEs.get(oldTuitionFee.PricebookEntryId);
				boolean isOpportunityHalfDay = false; 
				if(opp.Half_Day_PN_N_Checkbox__c == true){
					isOpportunityHalfDay = true;
				}
				boolean isOpportunityNextHalfDay = false; 
				if(opp.Half_Day_PN_N_NY_Checkbox__c == true){
					isOpportunityNextHalfDay = true;
				}
				if(pbe.Product2.Year_Group__c != yearGroup || (!isFromBatch && isOpportunityHalfDay != pbe.Product2.Half_Day__c) || (isFromBatch && isOpportunityNextHalfDay != pbe.Product2.Half_Day__c)) {
						
					oldTuitionFee.Current__c = false; 
					//oliToUpdate.add(oldTuitionFee);
					String invoiceCurrency = pbe.Product2.Invoice_Currency__c;
					
					// Create the new tuition fee incremented one year.
					Product2 firstTuitionFee = null; // first = matching half day checkbox
					Product2 secondTuitionFee = null; // second = non-matching half day checkbox
					for(Product2 p : allProducts)
					{
						if(p.Year_Group__c == yearGroup && p.Invoice_Currency__c == invoiceCurrency 
							&& p.Fee_Frequency__c == oldTuitionFee.Invoicing_Term__c 
								&& (oldTuitionFee.Invoicing_Term__c != 'Monthly' || p.Fee_Season__c == oldTuitionFee.Months_In_Year__c))
						{
							if(p.Half_Day__c == true && ((isFromBatch && opp.Half_Day_PN_N_NY_Checkbox__c == true) || (!isFromBatch && opp.Half_Day_PN_N_Checkbox__c == true)) ) { 
								firstTuitionFee = p;
							}
							else if((isFromBatch && opp.Half_Day_PN_N_NY_Checkbox__c != true) || (!isFromBatch && opp.Half_Day_PN_N_Checkbox__c != true)){
								secondTuitionFee = p;
							}
						}
						
						if(firstTuitionFee != null || secondTuitionFee != null){
							break;
						}
					}
					System.debug('****IncrementTutuionFee**** opp.Id= ' +opp.Id);
					System.debug('****IncrementTutuionFee**** firstTuitionFee= ' +firstTuitionFee);
					System.debug('****IncrementTutuionFee**** secondTuitionFee= ' +secondTuitionFee);
					if(firstTuitionFee != null || secondTuitionFee != null)
					{
						
						
						
						Product2 tuitionFee = null; // second = non-matching half day checkbox

						System.debug('## opp.Pricebook2Id ' +opp.Pricebook2Id);
						List<PriceBookEntry> newPbes = [
							Select Id, Product2Id, UnitPrice, Pricebook2Id, IsActive
							  From PricebookEntry 
							Where (Product2Id =: ((firstTuitionFee == null) ? null : firstTuitionFee.Id)
								OR Product2Id =: ((secondTuitionFee == null) ? null : secondTuitionFee.Id))
							  AND IsActive = true AND Pricebook2.IsActive = true 
							  AND Pricebook2Id =: opp.Pricebook2Id 
						];
						
						if(newPbes != null && newPbes.size() > 0){
						    oliToUpdate.add(oldTuitionFee);
							PriceBookEntry newPbe = null;
							if(newPbes.size() > 1) {
								if(firstTuitionFee != null) {
									if(newPbes.get(0).Product2Id == firstTuitionFee.Id) {
										newPbe = newPbes.get(0);
										tuitionFee = firstTuitionFee;
									}
									else if(newPbes.get(1).Product2Id == firstTuitionFee.Id) {
										newPbe = newPbes.get(1);
										tuitionFee = firstTuitionFee;
									}
								}
							}
							else if(newPbes.size() == 1) {
								newPbe = newPbes.get(0);
								if(firstTuitionFee != null && newPbe.Product2Id == firstTuitionFee.Id) {
									tuitionFee = firstTuitionFee;
								}
								else if(secondTuitionFee != null && newPbe.Product2Id == secondTuitionFee.Id) {
									tuitionFee = secondTuitionFee;
								}
							}
	
							if(newPbe != null) {
								OpportunityLineItem oli = new OpportunityLineItem();
								oli.PricebookEntryId = newPbe.Id; 
								oli.OpportunityId = opp.Id;
								oli.Quantity = 1;
								oli.Tuition__c = true;
								oli.Current__c = true;
								oli.UnitPrice = /*(oldTuitionFee.Discount == 100) ? null :*/ newPbe.UnitPrice;
								
								oli.Discount		 	= oldTuitionFee.Discount;
								oli.Payer__c 			= oldTuitionFee.Payer__c;
								oli.Months_In_Year__c 	= tuitionFee.Fee_Season__c;
								oli.Invoicing_Term__c 	= tuitionFee.Fee_Frequency__c;
								oli.Invoice_Date__c 	= oldTuitionFee.Invoice_Date__c;
								oli.Next_Generated_Invoice__c = oldTuitionFee.Next_Generated_Invoice__c;
								
								oliToUpdate.add(oli);
							}
						}else{
							isSuccess = false;
							if(!isFromBatch && newOppMap != null){
								newOppMap.get(opp.Id).addError('A corresponding fee for this \'Year Group / Grade\' and \'Half Day? (PN/N)\' option cannot be found. Please select a different combination or ask your finance department to set up a new fee.');
							}
						}
					}else{
						isSuccess = false;
						if(!isFromBatch && newOppMap != null){
							newOppMap.get(opp.Id).addError('A corresponding fee for this \'Year Group / Grade\' and \'Half Day? (PN/N)\' option cannot be found. Please select a different combination or ask your finance department to set up a new fee.');
						}
					}
				}
			}
		}
		
		upsert oliToUpdate;
		return isSuccess;
	}
}