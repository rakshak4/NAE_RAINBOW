/***
    change history
    Kunal on 22nd Sep 2013 : Added logic to keep portal user record to be in sync with account changes.
    Kunal on 6th Jan 2014 : Added logic to create additional parent emails records on account insert
    Kunal on 12th March 2014 : Logic retuned to for creating mass email contact
    Kunal on 29th April 2014 : Logic to update additional parents on account update
***/
trigger AccountTrigger on Account (after insert, after update,  after delete, after undelete) {    
    system.debug('***AccountTrigger***start:'+trigger.newMap);
    // Based on the F_Info_Company_Name__c field changing, update Payer field on child opportunies
    /*if (Trigger.isAfter && Trigger.isUpdate){ 
        AccountUpdateChildOpportunities.UpdatePayerField(System.trigger.old, System.trigger.new);    
    }*/
    
    /**Kunal on 22nd Sep 2013 : Added logic to keep portal user record to be in sync with account changes.**/
     /*
     if(trigger.isAfter && trigger.isUpdate){
         Map<Id,Account> accountMap =  new Map<Id,Account>();
        //check if primary contact email is changing on account record
        for(Account a:trigger.new){
            if(a.PrimaryContactEmail__c != trigger.oldMap.get(a.Id).PrimaryContactEmail__c){
                //mark account for processing
                accountMap.put(a.Id,a);
                 
            }
        }
        if(accountMap.size() > 0){
            List<User> updateList =  new List<User>();
            //fetch user records against marked accounts
            for(User u:[Select Id,AccountId, Email from User where AccountId IN:accountMap.keySet() AND Is_Portal_User__c = true AND IsActive = true ]){
                //fetch account 
                Account a = accountMap.get(u.AccountId);
                if(a != null){
                    if(a.PrimaryContactEmail__c != u.Email && a.PrimaryContactEmail__c != null && a.PrimaryContactEmail__c != ''){
                        u.Email = a.PrimaryContactEmail__c;
                        updateList.add(u);
                    }
                }
            }
            if(updateList.size() > 0){
                update updateList;
            }
         }
     }*/
     
    /**Kunal on 22nd Sep 2013: End Changes**/
    
    /**Kunal on 6th Jan 2014: Begin Changes**/
    /* //changes commented on 12 March 2014
    if(trigger.isInsert  && trigger.isAfter){
        List<Contact> additionalParentEmails  =  new List<Contact>();
        //fetch additional parent id
        Id recordTypeIdEmail =  [select Id from RecordType where SObjectType='Contact' AND DeveloperName='Mass_Email'].Id;
        Id recordTypeIdParent =  [select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        //fetch custom settings
        Map<String,String> settingsMap = new Map<String,String>();
        List<Account_Owner_Mapping__c> settings = Account_Owner_Mapping__c.getall().values(); 
        for(Account_Owner_Mapping__c sttng:settings){
            settingsMap.put(sttng.School_Name__c,sttng.Account_Id__c);
        }
        //create additional parent email
        for(Account parent:trigger.new){
            if(parent.RecordTypeId == recordTypeIdParent){
                //for 1st parent
                if(parent.LastName != null && parent.LastName != ''){
                    //if(parent.PersonEmail != null){
                        //Contact con =  new Contact();
                        //con.RecordTypeId = recordTypeIdEmail;
                        //con.AccountId  = settingsMap.get(parent.School__c);
                        //con.Main_Parent_File__c = parent.Id;
                        //con.FirstName = parent.FirstName;
                        //con.LastName =  parent.LastName;
                        //con.Email = parent.PersonEmail;
                        //con.HasOptedOutOfEmail = parent.PersonHasOptedOutOfEmail;
                        //additionalParentEmails.add(con);
                    //}
                    if(parent.First_Parent_Email_1__c != null){
                        Contact con =  new Contact();
                        con.RecordTypeId = recordTypeIdEmail;
                        con.AccountId  = settingsMap.get(parent.School__c);
                        con.Main_Parent_File__c = parent.Id;
                        con.FirstName = parent.FirstName;
                        con.LastName =  parent.LastName;
                        con.Email = parent.First_Parent_Email_1__c;
                        con.HasOptedOutOfEmail = parent.PersonHasOptedOutOfEmail;
                        additionalParentEmails.add(con);
                    }
                }
                
                //for 2nd parent
                if(parent.Parent_2_Last_Name__c != null && parent.Parent_2_Last_Name__c != ''){
                    if(parent.Email_2__c != null){
                        Contact con =  new Contact();
                        con.RecordTypeId = recordTypeIdEmail;
                        con.AccountId  = settingsMap.get(parent.School__c);
                        con.Main_Parent_File__c = parent.Id;
                        con.FirstName = parent.Parent_2_First_Name__c;
                        con.LastName =  parent.Parent_2_Last_Name__c;
                        con.Email = parent.Email_2__c;
                        additionalParentEmails.add(con);
                    }
                    if(parent.Second_Parent_Email_1__c != null){
                        Contact con =  new Contact();
                        con.RecordTypeId = recordTypeIdEmail;
                        con.AccountId  = settingsMap.get(parent.School__c);
                        con.Main_Parent_File__c = parent.Id;
                        con.FirstName = parent.Parent_2_First_Name__c;
                        con.LastName =  parent.Parent_2_Last_Name__c;
                        con.Email = parent.Second_Parent_Email_1__c;
                        additionalParentEmails.add(con);
                    }
                }
            }
        }
        if(additionalParentEmails.size() > 0){
            insert additionalParentEmails;
        }
    }*/
    /**Kunal on 6th Jan 2014: End Changes**/
    
    /**Kunal on 12th March 2014: Start Changes**/
    if(trigger.isAfter){
        
        //fetch additional parent id
        Id recordTypeIdEmail ;
        //Id recordTypeIdParent =  [select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        //fetch custom settings
        Map<String,String> settingsMap ;
        
        if(trigger.isInsert){
            list<Contact> additionalParentEmails  =  new list<Contact>();
            for(Account parent:trigger.new){
                system.debug('***AccountTrigger***processing for parent='+parent);
                if(parent.RT_Developer_Name__c == 'PersonAccount'){
                    if(recordTypeIdEmail == null){
                        recordTypeIdEmail =  [select Id from RecordType where SObjectType='Contact' AND DeveloperName='Mass_Email'].Id;
                    }
                    if(settingsMap == null){
                        settingsMap = new Map<String,String>();
                        List<Account_Owner_Mapping__c> settings = Account_Owner_Mapping__c.getall().values(); 
                        for(Account_Owner_Mapping__c sttng:settings){
                            settingsMap.put(sttng.School_Name__c,sttng.Account_Id__c);
                        }
                    }
                    Contact con =  new Contact();
                    con.RecordTypeId = recordTypeIdEmail;
                    con.AccountId  = settingsMap.get(parent.School__c);
                    con.Main_Parent_File__c = parent.Id;
                    con.FirstName = parent.FirstName;
                    con.LastName =  parent.LastName;
                    con.Salutation = parent.Salutation;
                    con.Email = parent.Contact_Alternate_Email__pc;
                    con.HasOptedOutOfEmail = parent.Contact_Alternate_Email_Opt_Out__pc;
                    system.debug('***AccountTrigger***additional parent email='+con);
                    additionalParentEmails.add(con);
                }
            }
            system.debug('***AccountTrigger***additionalParentEmails='+additionalParentEmails);
            if(additionalParentEmails.size() > 0){
                insert additionalParentEmails;
            }
        }else if(trigger.isUpdate){
            set<Id> allParentIds =  new set<Id>();
            list<Contact> additionalParentEmails  =  new list<Contact>();
            set<Id> parentIdsToBeUpdatedForEmail =  new set<Id>();
            for(Account parent:trigger.new){
                if(parent.RT_Developer_Name__c == 'PersonAccount' && (parent.Contact_Alternate_Email__pc != trigger.oldMap.get(parent.Id).Contact_Alternate_Email__pc || parent.FirstName != trigger.oldMap.get(parent.Id).FirstName || parent.LastName != trigger.oldMap.get(parent.Id).LastName || parent.Salutation != trigger.oldMap.get(parent.Id).Salutation || parent.Contact_Alternate_Email_Opt_Out__pc != trigger.oldMap.get(parent.Id).Contact_Alternate_Email_Opt_Out__pc)){
                    parentIdsToBeUpdatedForEmail.add(parent.Id);
                }
                if(parent.RT_Developer_Name__c == 'PersonAccount'){
                    allParentIds.add(parent.Id);
                }
            }
            if(parentIdsToBeUpdatedForEmail.size() > 0){
                for(Contact con:[select HasOptedOutOfEmail,Id,Email,Main_Parent_File__c from Contact where RecordType.DeveloperName='Mass_Email' AND Main_Parent_File__c IN:parentIdsToBeUpdatedForEmail AND Additional_Parent__c = null]){
                    con.Email =  trigger.newMap.get(con.Main_Parent_File__c).Contact_Alternate_Email__pc;
                    con.HasOptedOutOfEmail  = trigger.newMap.get(con.Main_Parent_File__c).Contact_Alternate_Email_Opt_Out__pc;
                    con.FirstName = trigger.newMap.get(con.Main_Parent_File__c).FirstName;
                    con.LastName = trigger.newMap.get(con.Main_Parent_File__c).LastName;
                    con.Salutation = trigger.newMap.get(con.Main_Parent_File__c).Salutation;
                    additionalParentEmails.add(con);
                }
            }
            if(additionalParentEmails.size()  > 0){
                update additionalParentEmails;
            }
             /** Start - Kunal on 29th April: update additional parents on account update 
                Update on 5th July 2016: added function to check for primary contact change on acocunt as well
             **/
            if(trigger.isUpdate){
                set<Id> parentIdsForAdditionalParentUpdate = new set<Id>();
                set<Id> accountsToBeProcessesForPrimaryContactChange = new set<Id>();
                for(Account acc:trigger.new){
                    if(acc.RT_Developer_Name__c == 'PersonAccount'){
                        if(acc.User__pc != trigger.oldMap.get(acc.Id).User__pc || acc.Portal_User_Creation_Error__c != trigger.oldMap.get(acc.Id).Portal_User_Creation_Error__c || acc.Primary_Contact__c != trigger.oldMap.get(acc.Id).Primary_Contact__c){
                            parentIdsForAdditionalParentUpdate.add(acc.Id);
                            if(acc.Primary_Contact__c != trigger.oldMap.get(acc.Id).Primary_Contact__c){
                                accountsToBeProcessesForPrimaryContactChange.add(acc.Id);
                            }
                        }
                    }
                }
                if(parentIdsForAdditionalParentUpdate.size() > 0){
                    list<Contact> additionalParents = new list<Contact>();
                    for(Contact ap:[select Id,Main_Parent_File__c from Contact where Main_Parent_File__c IN:parentIdsForAdditionalParentUpdate AND RecordType.DeveloperName = 'Additional_Parent']){
                        if(accountsToBeProcessesForPrimaryContactChange.contains(ap.Main_Parent_File__c)){
                            ap.Send_School_Kompanion_Outbound_Message__c = true;
                        }
                        additionalParents.add(ap);
                    }
                    if(additionalParents.size() > 0){
                        update additionalParents;   
                    }
                }
            }
            
            /** End - Kunal on 29th April **/
        }
    }
    system.debug('***AccountTrigger***end:'+trigger.newMap);
}