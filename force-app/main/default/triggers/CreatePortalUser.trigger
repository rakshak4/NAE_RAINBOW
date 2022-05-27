//create portal user when account.Trigger_Parent_User_Creation__c equals true and account.User__pc equals null
//populate account.user__pc after portal user creation
//7 April 2014 - Changes related to new portal user email 
//8 April 2014 - Changes related to syncing portal user 
trigger CreatePortalUser on Account (after insert, after update) {
	system.debug('***CreatePortalUser***start:'+trigger.newMap);

	boolean doProcess = false;
	for(Account acc:trigger.new){
		if(trigger.isInsert){
			if(acc.Trigger_Parent_User_Creation__c ==  true && acc.User__pc == null){
				doProcess = true;
				
			}
		}else if(trigger.isUpdate){
			if(acc.Trigger_Parent_User_Creation__c ==  true && acc.User__pc == null && acc.Portal_User_Creation_Error__c == false){
				doProcess = true;
				
			}
		}
	}
	if(doProcess){
		set<Id> accIds =  new set<Id>();
		//fetch settings
	    Map<String,School_Logo_Mapping__c>schoolSettingMap =  new Map<String,School_Logo_Mapping__c>();
	    List<School_Logo_Mapping__c> settings = School_Logo_Mapping__c.getall().values(); 
	    for(School_Logo_Mapping__c setting:settings){
	        schoolSettingMap.put(setting.School_Full_Name__c,setting);
	    }
		for(Account acc:trigger.new){
			boolean flag = false;
			System.debug('***CreatePortaluser***acc.Trigger_Parent_User_Creation__c='+acc.Trigger_Parent_User_Creation__c);
			System.debug('***CreatePortaluser***acc.User__pc='+acc.User__pc);
			System.debug('***CreatePortaluser***acc.Portal_User_Creation_Error__c='+acc.Portal_User_Creation_Error__c);
			if(trigger.isInsert){
				if(acc.Trigger_Parent_User_Creation__c ==  true && acc.User__pc == null){
					flag = true;
					
				}
			}else if(trigger.isUpdate){
				if(acc.Trigger_Parent_User_Creation__c ==  true && acc.User__pc == null && acc.Portal_User_Creation_Error__c == false){
					flag = true;
					
				}
			}
			if(flag){
				
				//check for setting
				if(schoolSettingMap.keySet().contains(acc.School__c)){
					if(schoolSettingMap.get(acc.School__c).Auto_Portal_User_Creation__c){
						accIds.add(acc.Id);
					}
				}
			}
		}
	
		if(accIds.size()  > 0){ 
	        map<Id,User> accountUserMap =  new map<Id,User>();
	        //check for existing users
	        for(User u:[select Id, AccountId from User where AccountId IN:accIds]){
	        	accountUserMap.put(u.AccountId,u);
	        }
			map<Id,Account> accountMap =  new map<Id,Account>([select PersonMobilePhone,Name,OwnerId, Owner.Primary_Invoice_Currency__c from Account where Id IN:accIds]); 
			for(Id accId:accIds){
				Account acc  =  trigger.newMap.get(accId);
				User u =  new User();
				u.FirstName =  acc.FirstName;
				u.LastName =  acc.LastName;
				u.Alias =  acc.Contact_Alias__pc;
				//u.Email =  acc.PersonEmail;
				u.Email = 'blog-add-notifications@britishschools.co.uk';
				u.CommunityNickname =  acc.Name;
				u.School__c =  acc.SchoolText__pc;
				u.TimeZoneSidKey =  acc.User_TimezoneSidKey__c;
	            u.LocaleSidKey =  acc.User_LocaleSidKey__c;
	            u.LanguageLocaleKey = 'en_US';
	            u.EmailEncodingKey = 'ISO-8859-1'; 
				u.Primary_Invoice_Currency__c =  accountMap.get(acc.Id).Owner.Primary_Invoice_Currency__c;
				u.ProfileId =  acc.User_Profile_Id__c;
				u.School_Hub_Video__c =  acc.User_School_Hub_Video_Link__c;
				u.ContactId =  acc.PersonContactId;
				u.CompanyName =  'Parent';
				u.Username = acc.PersonEmail;
				//u.MobilePhone = accountMap.get(acc.Id).PersonMobilePhone;
			    accountUserMap.put(acc.Id,u);	
			}
			System.debug('***CreatePortaluser***accountUserMap='+accountUserMap);
			//insert users
			if(accountUserMap.size() > 0){ 
	            list<Database.UpsertResult> upsertResults = Database.upsert(accountUserMap.values(),false);
	            System.debug('***CreatePortaluser***upsertResults='+upsertResults);
	            //populate account user field and error
	            list<Account> accToBeUpdated =  new list<Account>();
	            map<Id,Account> tempAccountMap =  new map<Id,Account>([select Id, User__pc from Account where Id=:accountUserMap.keySet()]);
	            for(Id accId:accountUserMap.keySet()){
	                if(accId != null){
		                Account acc=  tempAccountMap.get(accId);
		                if(acc != null){
			                if(acc.User__pc == null){
				                if(accountUserMap.get(accId).Id != null){
				                    acc.User__pc = accountUserMap.get(accId).Id;
				                    acc.Portal_User_Creation_Error__c = false;
				                }else if(accountUserMap.get(accId).Id == null){
				                    //populate error field on account
				                    acc.Portal_User_Creation_Error__c = true;
				                }
				                accToBeUpdated.add(acc);
			                }
		                }
	                }
	            }
	            if(accToBeUpdated.size() > 0){
	                update accToBeUpdated;
	            }
				/*
				list<Database.Saveresult> saveResults = Database.upsert(accountUserMap.values(),false);
				//populate account user field and error
				list<Account> accToBeUpdated =  new list<Account>();
				for(Id accId:accountUserMap.keySet()){
					if(accountUserMap.get(accId).Id != null){
						Account acc=  new Account(Id=accId);
						acc.User__pc = accountUserMap.get(accId).Id;
						accToBeUpdated.add(acc);
					}else if(accountUserMap.get(accId).Id == null){
						trigger.newMap.get(accId).addError('Data Error: Failed to create portal user. Please check with your System Administrator for more information');
					}
				}*/
			}
			
		}
	}
	
	/****start 4 March 2014 **** set user password*******/
		list<Account> toBeProcessedForUserPassword =  new list<Account>();
		for(Account acc:trigger.new){
			if(trigger.isInsert){
				if(acc.User__pc != null && acc.Portal_User_Password__pc != null){
					toBeProcessedForUserPassword.add(acc);
				}
			}else if(trigger.isUpdate){
				if(acc.User__pc != null && (acc.Portal_User_Password__pc != trigger.oldMap.get(acc.Id).Portal_User_Password__pc || acc.Resend_Portal_Login_Info__pc == true)){
					toBeProcessedForUserPassword.add(acc);
				}
			}	
		}
		if(toBeProcessedForUserPassword.size() > 0){
			for(Account acc:toBeProcessedForUserPassword){
				if(acc.Portal_User_Password__pc != null){
					system.setPassword(acc.User__pc, acc.Portal_User_Password__pc);
				}
			}
		}
	/****end 4 March 2014 **** set user password*******/
	
	
	/****start 8 April 2014 **** syncing portal user*******/
		//sync portal user when email, firstname, lastname or mobile phone is updated
		if(trigger.isUpdate){
			set<Id> parentIdsForUserSync =  new set<Id>();
			set<Id> staffIdsForUserSync =  new set<Id>();
			for(Account parent:trigger.new){
				if(parent.Record_Type__c == 'Parent' && parent.User__pc != null){
					if(parent.PersonEmail != trigger.oldMap.get(parent.Id).PersonEmail || parent.FirstName != trigger.oldMap.get(parent.Id).FirstName || parent.LastName != trigger.oldMap.get(parent.Id).LastName || parent.PersonMobilePhone != trigger.oldMap.get(parent.Id).PersonMobilePhone){
						parentIdsForUserSync.add(parent.Id);
					}
				}else if(parent.Record_Type__c == 'Staff Member' && parent.User__pc != null ){
                	if(parent.Campus__c !=  trigger.oldMap.get(parent.Id).Campus__c  || parent.School_Department__c !=  trigger.oldMap.get(parent.Id).School_Department__c || parent.Status__c !=  trigger.oldMap.get(parent.Id).Status__c || parent.Salutation !=  trigger.oldMap.get(parent.Id).Salutation || parent.Nationality__c !=  trigger.oldMap.get(parent.Id).Nationality__c || parent.Staff_Directory_Positioning__c !=  trigger.oldMap.get(parent.Id).Staff_Directory_Positioning__c || parent.User__pc !=  trigger.oldMap.get(parent.Id).User__pc){
                		staffIdsForUserSync.add(parent.Id);
                	}
                }
			}
			if(parentIdsForUserSync.size() > 0 && !system.isFuture()){
				PortalUtility.syncPortalUserAccount(parentIdsForUserSync,false);
			}
			if(staffIdsForUserSync.size() > 0 && !system.isFuture()){
            	PortalUtility.syncStaffUserAccount(staffIdsForUserSync);
            }
			
		}
	/****end 8 April 2014 **** syncing portal user*******/
	system.debug('***CreatePortalUser***end:'+trigger.newMap);
}