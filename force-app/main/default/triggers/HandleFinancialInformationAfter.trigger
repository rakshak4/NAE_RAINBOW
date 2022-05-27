trigger HandleFinancialInformationAfter on Financial_Information__c (after insert, after update, before delete) {
	if(trigger.isInsert || trigger.isUpdate){
		set<Id> accountIds = new set<Id>();
		for(Financial_Information__c f:trigger.new){
			if(f.Related_To__c != null){
				accountIds.add(f.Related_To__c);
			}
		}
		if(accountIds.size() > 0){
			map<Id,Account> accountMap = new map<Id,Account>();
			for(Account acc:[select Id, (select Id from Opportunities where Related_Financial_Info__c = null) from Account where Id IN:accountIds]){
				accountMap.put(acc.Id,acc);
			}
			list<Opportunity> opportunityForUpdate = new list<Opportunity>();
			for(Financial_Information__c f:trigger.new){
				Account acc = accountMap.get(f.Related_To__c);
				if(acc != null){
					for(Opportunity o:acc.Opportunities){
						o.Related_Financial_Info__c = f.Id;
						opportunityForUpdate.add(o);
					}
				}
			}
			if(opportunityForUpdate.size() > 0){
				update opportunityForUpdate;
			}
		}
	}
	if(trigger.isDelete){
		set<Id> accountIds = new set<Id>();
		set<Id> financialInformationIds = new set<Id>();
		for(Financial_Information__c f:trigger.old){
			if(f.Related_To__c != null){
				accountIds.add(f.Related_To__c);
				financialInformationIds.add(f.Id);
			}
		}
		if(accountIds.size() > 0){
			map<Id,Account> accountMap = new map<Id,Account>();
			for(Account acc:[select Id, (Select Id From Financial_Information__r where Id NOT IN:financialInformationIds order by LastModifiedDate desc limit 1 ) ,(select Id from Opportunities where Related_Financial_Info__c IN: financialInformationIds) from Account where Id IN:accountIds]){
				accountMap.put(acc.Id,acc);
			}
			list<Opportunity> opportunityForUpdate = new list<Opportunity>();
			for(Financial_Information__c f:trigger.old){
				Account acc = accountMap.get(f.Related_To__c);
				if(acc != null){
					for(Opportunity o:acc.Opportunities){
						for(Financial_Information__c fi:acc.Financial_Information__r){
							o.Related_Financial_Info__c = fi.Id;
							opportunityForUpdate.add(o);
							break;
						}
					}
				}
			}
			if(opportunityForUpdate.size() > 0){
				update opportunityForUpdate;
			}
		}
	}
}