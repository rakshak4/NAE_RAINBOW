//checks for registration for community chatter groups when a portal user is created
//logic added to update portal user email address
//logic added to link chatter free users with staff member records
trigger HandlePortalUserAfterInsert on User (after insert,before insert,after update) { 
    System.debug('***HandlePortalUserAfterInsert***trigger.new='+trigger.new);
    //sequence 
    //1. before insert validation
    //2. after insert chatter group membership
    //3. user updation with correct email
    //4. account/contact updation with correct user
    if(trigger.isInsert){
        if(trigger.isBefore){
            //1. before insert validation
            //populate portal account id
            for(User u:trigger.new){
                u.CurrencyIsoCode = 'EUR';
                u.DefaultCurrencyIsoCode = 'EUR';
                if(u.Family_File_Id__c != null && u.Family_File_Id__c  != ''){
                    //u.Portal_Account_Id__c = u.Family_File_Id__c;
                }
                if(u.LocaleSidKey == 'en_US'){
                    u.Is_Us_Locale__c = true;
                }else{
                    u.Is_Us_Locale__c = false;
                }
            }
        }else if(trigger.isAfter){
            set<Id> portalUsers = new set<Id>();
            set<Id> accountIds =  new set<Id>();
            set<Id> contactIds =  new set<Id>();
            map<Id,Id> accountUserMap = new map<Id,Id>();
            map<Id,Id> contactUserMap = new map<Id,Id>();
            for(User u:trigger.new){
                if(u.Is_Portal_User__c == true && u.Family_File_Id__c != null && u.Family_File_Id__c != ''){
                    if(u.Family_File_Id__c != '' && u.Family_File_Id__c != null){
                        portalUsers.add(u.Id);
                        accountIds.add(u.Family_File_Id__c);
                    }
                    //accountUserMap.put(u.Account_Id__c,u.Id);
                    contactIds.add(u.ContactId);
                    contactUserMap.put(u.ContactId,u.Id);
                }
                if(u.Related_Contact_ID__c != null && u.Is_Portal_User__c == false){
                    if(u.Related_Contact_ID__c.startsWith('001')){
                        accountIds.add(u.Related_Contact_ID__c);
                        accountUserMap.put(u.Related_Contact_ID__c,u.Id);
                    }else{
                        contactIds.add(u.Related_Contact_ID__c);
                        contactUserMap.put(u.Related_Contact_ID__c,u.Id);
                    }
                }
            }
            System.debug('***HandlePortalUserAfterInsert***portalUsers='+portalUsers);
            System.debug('***HandlePortalUserAfterInsert***accountIds='+accountIds);
            System.debug('***HandlePortalUserAfterInsert***contactIds='+contactIds);
            System.debug('***HandlePortalUserAfterInsert***accountUserMap='+accountUserMap);
            System.debug('***HandlePortalUserAfterInsert***contactUserMap='+contactUserMap); 
            
            //check for portal user
            if(portalUsers.size() > 0){     
                //2. after insert chatter group membership
                //process for chatter group membership 
                //fetch all registrations and group id for portal users            
                map<Id,set<Id>> accountIdChatterGroupIdMap =  new map<Id,set<Id>>();
                
                for(Registration__c r:[Select r.Student__r.Main_Parent_File__c, r.Parent_File_Id__c, r.Name, r.Id, r.Group__r.Auto_Add_Parents_To_Group__c, r.Group__c, r.Group_Name__c, r.Chatter_Group_Id__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Chatter_Group_Id__c != null AND r.Chatter_Group_Id__c != '' AND r.Student__r.Main_Parent_File__c IN:accountIds]){
                    System.debug('***HandlePortalUserAfterInsert***registration='+r);
                    if(r.Chatter_Group_Id__c != null && r.Chatter_Group_Id__c != '' && r.Group__r.Auto_Add_Parents_To_Group__c == true){
                        if(r.Parent_File_Id__c != null && r.Parent_File_Id__c != ''){
                            //Id parentAccountId = r.Student__r.Main_Parent_File__c;
                            if(accountIdChatterGroupIdMap.keySet().contains(r.Parent_File_Id__c)){
                                accountIdChatterGroupIdMap.get(r.Parent_File_Id__c).add(r.Chatter_Group_Id__c);
                            }else{
                                set<Id> chatterGroups = new set<Id>();
                                chatterGroups.add(r.Chatter_Group_Id__c);
                                accountIdChatterGroupIdMap.put(r.Parent_File_Id__c,chatterGroups);
                            }
                        }
                    }           
                }
                System.debug('***HandlePortalUserAfterInsert***accountIdChatterGroupIdMap='+accountIdChatterGroupIdMap);
                //check for chatter group membership 
                list<CollaborationGroupMember> newMembers =  new list<CollaborationGroupMember>();
                for(Id userId:portalUsers){
                    User u = trigger.newMap.get(userId);
                    set<Id> chatterGroups  = accountIdChatterGroupIdMap.get(u.Family_File_Id__c);           
                    if(chatterGroups != null){
                        for(Id chatterGroupId:chatterGroups){
                            CollaborationGroupMember member =  new CollaborationGroupMember();
                            member.CollaborationGroupId = chatterGroupId;
                            member.CollaborationRole = 'Standard';
                            member.MemberId = u.Id;
                            member.NotificationFrequency = 'W';
                            newMembers.add(member);
                        }
                    }
                }
                System.debug('***HandlePortalUserAfterInsert***newMembers='+newMembers);
                if(newMembers.size() > 0){
                    insert newMembers;
                }
                
                
            }
            
            //4. account/contact updation with correct user
            //check for account or contact updation
            if(accountIds.size() > 0 || contactIds.size() > 0){ 
                PortalUtility.userAfterInsertAccountContactUpdate(accountIds, contactIds, accountUserMap, contactUserMap);
            }
            
        }
    }
    
    //logic for linking chatter free users with staff members
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        list<User> chatterFreeUserList = new list<User>();
        set<string> emailSet = new set<String>();
        set<string> schoolSet = new set<String>();
        for(User u:trigger.new){
            if(trigger.isInsert){
                if(u.Is_Chatter_Free_User__c && u.School__c != null){
                    chatterFreeUserList.add(u);
                    emailSet.add(u.Email);
                    schoolSet.add(u.School__c);
                }
            }
            if(trigger.isUpdate){
                if(u.Is_Chatter_Free_User__c && u.School__c != null && (u.School__c != trigger.oldMap.get(u.Id).School__c || u.Email != trigger.oldMap.get(u.Id).Email)){
                    chatterFreeUserList.add(u);
                    emailSet.add(u.Email);
                    schoolSet.add(u.School__c);
                }
            }
        }
        if(chatterFreeUserList.size() > 0){
            //fetch accounts
            map<string,list<Account>> emailStaffMemberMap = new map<string,list<Account>>();
            for(Account a:[select PersonEmail, Status__c , User__pc ,Id, School__c from Account where (RecordType.DeveloperName= 'Staff_Account' ) AND PersonEmail IN:emailSet AND School__c IN:schoolSet AND User__pc = null]){
                if(emailStaffMemberMap.keySet().contains(a.PersonEmail)){
                    emailStaffMemberMap.get(a.PersonEmail).add(a);
                }else{
                    list<Account> alist = new list<Account>();
                    alist.add(a);
                    emailStaffMemberMap.put(a.PersonEmail,alist);
                }
            }
            //check for staff member accounts
            list<User> usersToBeUpdated = new list<User>();
            list<Account> accountsToBeUpdated = new list<Account>();
                for(User u:chatterFreeUserList){
                    if(emailStaffMemberMap.keySet().contains(u.Email)){
                        list<Account> foundAccounts = new list<Account>();
                        for(Account a:emailStaffMemberMap.get(u.Email)){
                            if(a.School__c == u.School__c){
                                foundAccounts.add(a);
                            }
                        }
                        
                        if(foundAccounts.size() > 0){
                            if(foundAccounts.size() == 1){//only one account found
                                usersToBeUpdated.add(new User(Id=u.Id, Related_Contact_ID__c = foundAccounts[0].Id,Trigger_Chatter_Free_User_Created_Email__c=false));
                                accountsToBeUpdated.add(new Account(Id=foundAccounts[0].Id, User__pc=u.Id));
                            }else{
                                list<Account> furtherFilteredAccount = new list<Account>();
                                for(Account a:foundAccounts){
                                    if(a.Status__c != 'Applicant'){
                                        furtherFilteredAccount.add(a);
                                    }
                                }
                                if(furtherFilteredAccount.size() > 0){
                                    if(furtherFilteredAccount.size() == 1){
                                        usersToBeUpdated.add(new User(Id=u.Id, Related_Contact_ID__c = furtherFilteredAccount[0].Id,Trigger_Chatter_Free_User_Created_Email__c=false));
                                        accountsToBeUpdated.add(new Account(Id=furtherFilteredAccount[0].Id, User__pc=u.Id));
                                    }else{
                                        usersToBeUpdated.add(new User(Id=u.Id, Trigger_Chatter_Free_User_Created_Email__c = true));
                                    }
                                }else{
                                    usersToBeUpdated.add(new User(Id=u.Id, Trigger_Chatter_Free_User_Created_Email__c = true));
                                }
                            }
                        }else{
                            usersToBeUpdated.add(new User(Id=u.Id, Trigger_Chatter_Free_User_Created_Email__c = true));
                        }
                        
                    }else{
                        usersToBeUpdated.add(new User(Id=u.Id, Trigger_Chatter_Free_User_Created_Email__c = true));
                    }
                }
            if(usersToBeUpdated.size() > 0){
                update usersToBeUpdated;
            }
            if(accountsToBeUpdated.size() > 0){
                update accountsToBeUpdated;
            }
            
        }
    }
}