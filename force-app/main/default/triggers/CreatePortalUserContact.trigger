//create portal user when contact.Contact_Trigger_Parent_User_Creation__c equals true and contact.User__c equals null
//populate contact.user__c after portal user creation
//8 April 2014 **** syncing portal user
trigger CreatePortalUserContact on Contact (after insert, after update) {     
	system.debug('***CreatePortalUserContact***start:'+trigger.newMap);
	boolean doProcess = false;
	for(Contact con:trigger.new){
		if(trigger.isInsert){
			if(con.Contact_Trigger_Parent_User_Creation__c ==  true && con.User__c == null){
				doProcess = true;
				
			}
		}else if(trigger.isUpdate){
			if(con.Contact_Trigger_Parent_User_Creation__c ==  true && con.User__c == null && con.Contact_Portal_User_Creation_Error__c == false){
				doProcess = true;
				
			}
		}
	}
	
	
	if(doProcess){
		set<Id> contactIds =  new set<Id>();
		Id additionalParentTypeId =  [select Id from RecordType where SObjectType='Contact' AND DeveloperName = 'Additional_Parent' limit 1].Id;
		//fetch settings
	    Map<String,School_Logo_Mapping__c>schoolSettingMap =  new Map<String,School_Logo_Mapping__c>();
	    List<School_Logo_Mapping__c> settings = School_Logo_Mapping__c.getall().values(); 
	    for(School_Logo_Mapping__c setting:settings){
	        schoolSettingMap.put(setting.School_Full_Name__c,setting);
	    }
		for(Contact con:trigger.new){
			if(con.RecordTypeId == additionalParentTypeId){
				boolean flag = false;
				System.debug('***CreatePortalUserContact***con.Contact_Trigger_Parent_User_Creation__c='+con.Contact_Trigger_Parent_User_Creation__c);
				System.debug('***CreatePortalUserContact***con.User__c='+con.User__c);
				System.debug('***CreatePortalUserContact***con.Contact_Portal_User_Creation_Error__c='+con.Contact_Portal_User_Creation_Error__c);
				if(trigger.isInsert){
					if(con.Contact_Trigger_Parent_User_Creation__c ==  true && con.User__c == null){
						flag = true;
						
					}
				}else if(trigger.isUpdate){
					if(con.Contact_Trigger_Parent_User_Creation__c ==  true && con.User__c == null && con.Contact_Portal_User_Creation_Error__c == false){
						flag = true;
						
					}
				}
				if(flag){
					//check for setting
					if(schoolSettingMap.keySet().contains(con.CSchool__c)){
						if(schoolSettingMap.get(con.CSchool__c).Auto_Portal_User_Creation__c){
							contactIds.add(con.Id);
						}
					}
				}
			}
		}
	
	
		if(contactIds.size()  > 0){ 
	        map<Id,User> contactUserMap =  new map<Id,User>();
	        //check for existing users
	        for(User u:[select Id,ContactId,AccountId from User where ContactId IN:contactIds]){
	        	contactUserMap.put(u.ContactId,u);
	        }
			map<Id,Contact> contactMap =  new map<Id,Contact>([select SchoolText__c, MobilePhone,  Main_Parent_File__r.User_TimezoneSidKey__c, Main_Parent_File__r.User_LocaleSidKey__c, Main_Parent_File__r.User_Profile_Id__c ,OwnerId, Owner.Primary_Invoice_Currency__c, Main_Parent_File__r.User_School_Hub_Video_Link__c from Contact where Id IN:contactIds]); 
			for(Id conId:contactIds){
				Contact con  =  trigger.newMap.get(conId);
				User u =  new User();
				u.FirstName =  con.FirstName;
				u.LastName =  con.LastName;
				u.Alias =  con.Contact_Alias__c;
				//u.Email =  con.Email;
				u.Email =  'blog-add-notifications@britishschools.co.uk';
				u.CommunityNickname =  con.Name;
				//u.School__c =  contactMap.get(con.Id).Main_Parent_File__r.SchoolText__c;
				u.School__c =  con.SchoolText__c;
				u.TimeZoneSidKey =  contactMap.get(con.Id).Main_Parent_File__r.User_TimezoneSidKey__c;
	            u.LocaleSidKey =  contactMap.get(con.Id).Main_Parent_File__r.User_LocaleSidKey__c;
	            u.LanguageLocaleKey = 'en_US';
	            u.EmailEncodingKey = 'ISO-8859-1'; 
				u.Primary_Invoice_Currency__c =  contactMap.get(con.Id).Owner.Primary_Invoice_Currency__c;
				u.ProfileId =  contactMap.get(con.Id).Main_Parent_File__r.User_Profile_Id__c;
				u.School_Hub_Video__c =  contactMap.get(con.Id).Main_Parent_File__r.User_School_Hub_Video_Link__c;
				u.ContactId =  con.Id;
				u.CompanyName =  'Parent';
				u.Username = con.Email;
				//u.Portal_Account_Id__c = con.Main_Parent_File_Id__c;
				//u.MobilePhone = contactMap.get(con.Id).MobilePhone;
			    contactUserMap.put(con.Id,u);	
			}
			//insert users
			if(contactUserMap.size() > 0){ 
				System.debug('***CreatePortalUserContact***contactUserMap='+contactUserMap);
	            list<Database.UpsertResult> upsertResults = Database.upsert(contactUserMap.values(),false);
	            System.debug('***CreatePortalUserContact***upsertResults='+upsertResults);
	            //populate account user field and error
	            list<Contact> conToBeUpdated =  new list<Contact>();
	            map<Id,Contact> tempContactMap =  new map<Id,Contact>([select Id, User__c from Contact where Id=:contactUserMap.keySet()]);
	            set<Id> createdUserIds =  new set<Id>();
	            for(Id conId:contactUserMap.keySet()){
	                if(conId != null){
		                Contact con=  tempContactMap.get(conId);
		                if(con != null){
			                if(con.User__c == null){
				                if(contactUserMap.get(conId).Id != null){
				                    con.User__c = contactUserMap.get(conId).Id;
				                    con.Contact_Portal_User_Creation_Error__c = false;
				                    createdUserIds.add(con.User__c);
				                }else if(contactUserMap.get(conId).Id == null){
				                    //populate error field on contact
				                    con.Contact_Portal_User_Creation_Error__c = true;
				                }
				                conToBeUpdated.add(con);
			                }
		                }
	                }
	            }
	            if(conToBeUpdated.size() > 0){
	                update conToBeUpdated;
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
		list<Contact> toBeProcessedForUserPassword =  new list<Contact>();
		for(Contact con:trigger.new){
			if(trigger.isInsert){
				if(con.User__c != null && con.Portal_User_Password__c != null){
					toBeProcessedForUserPassword.add(con);
				}
			}else if(trigger.isUpdate){
				if(con.User__c != null && (con.Portal_User_Password__c != trigger.oldMap.get(con.Id).Portal_User_Password__c || con.Resend_Portal_Login_Info__c == true)){
					toBeProcessedForUserPassword.add(con);
				}
			}	
		}
		if(toBeProcessedForUserPassword.size() > 0){
			for(Contact con:toBeProcessedForUserPassword){
				system.setPassword(con.User__c, con.Portal_User_Password__c);
			}
		}
	/****end 4 March 2014 **** set user password*******/
	/****start 8 April 2014 **** syncing portal user*******/
		//sync portal user when email, firstname, lastname or mobile phone is updated
		if(trigger.isUpdate){
			set<Id> parentIdsForUserSync =  new set<Id>();
			for(Contact additionalParent:trigger.new){
				if(additionalParent.RT_Developer_Name__c == 'Additional_Parent' && additionalParent.User__c != null){
					if(additionalParent.Email != trigger.oldMap.get(additionalParent.Id).Email || additionalParent.FirstName != trigger.oldMap.get(additionalParent.Id).FirstName || additionalParent.LastName != trigger.oldMap.get(additionalParent.Id).LastName || additionalParent.MobilePhone != trigger.oldMap.get(additionalParent.Id).MobilePhone){
						parentIdsForUserSync.add(additionalParent.Id);
					}
				}
			}
			if(parentIdsForUserSync.size() > 0){
				PortalUtility.syncPortalUserAccount(parentIdsForUserSync,true);
			}
			
		}
	/****end 8 April 2014 **** syncing portal user*******/
	
	/****changes for for syncing opportunity on update of contact*****/
		if(trigger.isAfter){
			list<Opportunity> oppsToBeUpdated  = new list<Opportunity>();
			for(Contact con:trigger.new){
				if(trigger.isUpdate){
					if(con.Admissions_File__c != trigger.oldMap.get(con.Id).Admissions_File__c){
						if(con.Admissions_File__c == null){
							oppsToBeUpdated.add(new Opportunity(Id = trigger.oldMap.get(con.Id).Admissions_File__c, Student_Academic_File__c = null));
						}else if(con.Admissions_File__c != null){
							oppsToBeUpdated.add(new Opportunity(Id = con.Admissions_File__c, Student_Academic_File__c = con.Id));
							if(trigger.oldMap.get(con.Id).Admissions_File__c != null){
								//oppsToBeUpdated.add(new Opportunity(Id = trigger.oldMap.get(con.Id).Admissions_File__c, Student_Academic_File__c = null));
							}
						}
					}
				}
				if(trigger.isInsert){
					if(con.Admissions_File__c != null){
						oppsToBeUpdated.add(new Opportunity(Id = con.Admissions_File__c, Student_Academic_File__c = con.Id));
					}
				}
			}
			if(oppsToBeUpdated.size() > 0){
				update oppsToBeUpdated;
			}
		}
	/*****end changes for for syncing opportunity on update of contact****/
	system.debug('***CreatePortalUserContact***end:'+trigger.newMap);
}