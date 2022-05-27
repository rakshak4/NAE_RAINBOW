//for duplicate email check
trigger HandleContactBeforeUpdate on Contact (before update) {
    /* logic for email duplication check */
        if(trigger.isUpdate && trigger.isBefore){
            set<Id> accountsForEmailChange =  new set<Id>();
            set<Id> contactsForEmailChange =  new set<Id>();
            for(Contact con:trigger.new){
                if(con.RT_Developer_Name__c == 'Additional_Parent'){
                    if((con.Email != trigger.oldMap.get(con.Id).Email && con.Email != null) || (con.Contact_Alternate_Email__c != trigger.oldMap.get(con.Id).Contact_Alternate_Email__c && con.Contact_Alternate_Email__c != null)){
                        accountsForEmailChange.add(con.Main_Parent_File__c);
                        contactsForEmailChange.add(con.Id);
                    }
                }
            }
            if(contactsForEmailChange.size() > 0){
                //fetch additional parets details 
                map<Id,Account> accountMap =  new map<Id,Account>([Select a.Id, PersonEmail,Contact_Alternate_Email__pc,  (Select Id, Email, Contact_Alternate_Email__c  From Emails__r where RecordType.DeveloperName = 'Additional_Parent') From Account a where Id IN:accountsForEmailChange]);
                //check for duplicate
                for(Contact con:trigger.new){
                    if(accountsForEmailChange.contains(con.Main_Parent_File__c)){
                        //check for account
                        Account parent = accountMap.get(con.Main_Parent_File__c);
                        
                        if(((con.Email ==  parent.PersonEmail || con.Email == parent.Contact_Alternate_Email__pc) && con.Email != null) || (con.Contact_Alternate_Email__c != null && (con.Contact_Alternate_Email__c == parent.PersonEmail || con.Contact_Alternate_Email__c == parent.Contact_Alternate_Email__pc))){
                            con.Has_Duplicate_Email__c = true;
                        }else{
                            con.Has_Duplicate_Email__c = false;
                        }
                        //check for all addtional parents
                        if(con.Has_Duplicate_Email__c == false){
                            for(Contact additionalParent:accountMap.get(con.Main_Parent_File__c).Emails__r){
                                if(additionalParent.Id !=  con.Id){
                                    if((con.Email != null && (con.Email == additionalParent.Email || con.Email == additionalParent.Contact_Alternate_Email__c)) || (con.Contact_Alternate_Email__c != null && (con.Contact_Alternate_Email__c == additionalParent.Email || con.Contact_Alternate_Email__c == additionalParent.Contact_Alternate_Email__c))){
                                        con.Has_Duplicate_Email__c = true;
                                        break;
                                    }else{
                                        con.Has_Duplicate_Email__c = false;
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    
    /* end logic for email duplication check */
}