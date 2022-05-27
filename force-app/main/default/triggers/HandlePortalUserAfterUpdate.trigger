//1. updates user email to respective contact's email address after creation - a time based workflow updates Populate_Portal_User_Email__c = true
//2. checks if portal user record is synced with respective contact, if not updates contact.Portal_User_Sync_Failed__c = true 
trigger HandlePortalUserAfterUpdate on User (before update) {  
    
    //updates portal users email address after created , logic is triggered by time based workflow rule in user create.
    if(trigger.isBefore){
        set<Id> userIds = new set<Id>();
        for(User u:trigger.new){
            userIds.add(u.Id);
            //u.CurrencyIsoCode = 'EUR';
            u.DefaultCurrencyIsoCode = 'EUR';           
            if(u.Is_Portal_User__c == true && u.Family_File_Id__c != null && u.Family_File_Id__c != '' && u.Populate_Portal_User_Email__c ==  true && trigger.oldMap.get(u.Id).Populate_Portal_User_Email__c == false){
                if(u.Email != u.Portal_Contact_Email__c){
                    u.Email = u.Portal_Contact_Email__c;
                }
            }
            if(u.LocaleSidKey == 'en_US'){
                u.Is_Us_Locale__c = true;
            }else{
                u.Is_Us_Locale__c = false;
            }
        }
        if(userIds.size() > 0){
            map<Id,User> userMap = new map<Id,User>([select Id, FullPhotoURL from User where Id IN:userIds ]);
            for(User usr:trigger.new){
                User u = userMap.get(usr.Id);
                //check for user photo
                system.debug('****HandlePortalUserAfterUpdate***FullPhotoUrl='+u.FullPhotoUrl);
                if(u.FullPhotoUrl != null){
                    system.debug('****HandlePortalUserAfterUpdate***FullPhotoUrl***Has_Profile_Photo__c='+!(u.FullPhotoUrl.endsWith('005/F')));
                    if(u.FullPhotoUrl.endsWith('005/F')){
                        usr.Has_Profile_Photo__c = false;
                    }else{
                        usr.Has_Profile_Photo__c = true; 
                    }
                }else{
                    usr.Has_Profile_Photo__c = false;
                }
            }
        }
    }
    
    
    /*
    //2. checks if portal user record is synced with respective contact, if not updates contact.Portal_User_Sync_Failed__c = true
    if(trigger.isAfter){
        set<Id> contactIdSet =  new set<Id>();
        for(User u:trigger.new){
            if(u.Is_Portal_User__c == true && u.Account_Id__c != null && u.Account_Id__c != ''){
                contactIdSet.add(u.ContactId);
            }
        }
        system.debug('***HandlePortalUserAfterUpdate***contactIdSet:'+contactIdSet);
        if(contactIdSet.size() > 0){
            map<Id,Contact>  contactMap = new map<Id,Contact>([select Id,Portal_User_Sync_Failed__c, FirstName,LastName,Email,User__c,AccountId,MobilePhone from Contact where Id IN:contactIdSet]);
            system.debug('***HandlePortalUserAfterUpdate***contactMap:'+contactMap);
            list<Contact> contactsToBeUpdated = new list<Contact>();
            for(Id cid:contactMap.keySet()){
                Contact portalContact = contactMap.get(cid);
                system.debug('***HandlePortalUserAfterUpdate***portalContact:'+portalContact);
                User portalUser =  trigger.newMap.get(portalContact.User__c);
                system.debug('***HandlePortalUserAfterUpdate***portalUser:'+portalUser);
                //check for changes
                if(portalUser.FirstName != portalContact.FirstName || portalUser.LastName != portalContact.LastName || portalUser.Email != portalContact.Email || portalUser.MobilePhone != portalContact.MobilePhone){
                    portalContact.Portal_User_Sync_Failed__c =  true;
                    contactsToBeUpdated.add(portalContact);
                }else if(portalContact.Portal_User_Sync_Failed__c == true){
                    portalContact.Portal_User_Sync_Failed__c =  false;
                    contactsToBeUpdated.add(portalContact);
                }
                system.debug('***HandlePortalUserAfterUpdate***contactsToBeUpdated:'+contactsToBeUpdated);
            }
            if(contactsToBeUpdated.size() > 0){
                update contactsToBeUpdated;
            }
        }
    }*/
    
        
}