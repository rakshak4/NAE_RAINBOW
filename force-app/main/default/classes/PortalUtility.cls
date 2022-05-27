public class PortalUtility{  
      @future
      public static void syncStaffUserAccount(set<Id> staffIds){
        list<User> staffUserToBeUpdated = new list<User>();
        for(Account staff:[select Id, Campus__c, School_Department__c,Status__c ,Salutation,Nationality__c ,Staff_Directory_Positioning__c, User__pr.S_Dir_Positioning__c,  FirstName, LastName, PersonEmail, PersonMobilePhone, User__pc from Account where Id IN:staffIds]){
            if(staff.User__pc != null){
                User staffUser = new User(Id = staff.User__pc);
                staffUser.Campus__c =   staff.Campus__c;
                //staff directory fields
                staffUser.S_Dir_Department__c = staff.School_Department__c;
                staffUser.S_Dir_Status__c = staff.Status__c;
                staffUser.S_Dir_Salutation__c = staff.Salutation;
                staffUser.S_Dir_Origin__c = staff.Nationality__c;
                if(staff.User__pr.S_Dir_Positioning__c == null){
                    staffUser.S_Dir_Positioning__c = staff.Staff_Directory_Positioning__c;
                }
                staffUserToBeUpdated.add(staffUser);
            }
        }
        if(staffUserToBeUpdated.size() > 0){ 
            update staffUserToBeUpdated;
        }
      }
      
      @future
      public static void syncPortalUserAccount(set<Id> parentsIds, boolean isContact){
          map<Id,User> parentPortalUserMap = new map<Id,User>();
          map<Id,Id> portalUserParentMap = new map<Id,Id>();
          list<User> portalUserList = new list<User>();
          set<Id> userIds =  new set<Id>();
          if(!isContact){
              for(Account parent:[select Id, FirstName, LastName, PersonEmail, PersonMobilePhone, User__pc from Account where Id IN:parentsIds]){
                User portalUser = new User(Id = parent.User__pc);
                portalUser.FirstName =  parent.FirstName;
                portalUser.LastName =  parent.LastName;
                portalUser.Email = parent.PersonEmail;
                portalUser.Username = parent.PersonEmail;
                portalUser.MobilePhone = parent.PersonMobilePhone;
                portalUser.Synced_Apex__c = true;
                parentPortalUserMap.put(parent.Id,portalUser);
                portalUserParentMap.put(parent.User__pc,parent.Id);
                portalUserList.add(portalUser);
                userIds.add(parent.User__pc);
              }
          }else if(isContact){
                for(Contact parent:[select Id, FirstName, LastName, Email, MobilePhone, User__c from Contact where Id IN:parentsIds]){
                    User portalUser = new User(Id = parent.User__c);
                    portalUser.FirstName =  parent.FirstName;
                    portalUser.LastName =  parent.LastName;
                    portalUser.Email = parent.Email;
                    portalUser.Username = parent.Email;
                    portalUser.MobilePhone = parent.MobilePhone;
                    portalUser.Synced_Apex__c = true;
                    parentPortalUserMap.put(parent.Id,portalUser);
                    portalUserParentMap.put(parent.User__c,parent.Id);
                    portalUserList.add(portalUser);
                    userIds.add(parent.User__c);
                  }
          }
          
          
          if(portalUserList.size() > 0){
                list<User> usersToBeUpdated = new list<User>();
                list<Database.SaveResult> saveResults = Database.update(portalUserList,false);
                map<Id,User> userMap ;
                System.debug('***CreatePortaluser**portal user syncing**saveResults='+saveResults);
                integer i = 0;
                for(Database.SaveResult saveResult:saveResults){
                    User parentUser =  new User(Id = portalUserList[i].Id);
                    if(!saveResult.isSuccess()){
                        if(userMap == null){
                            userMap = new map<Id,User>([select Id, IT_Notifications_Email_User__c from User where Id IN:userIds]);
                        }
                        parentUser.Portal_Contact_Sync_Failed__c = true;
                        //send email to Ben, Kunal
                       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                       list<String> toAddresses =  new list<String>();
                       //toAddresses.add('ben.hails@britishschools.co.uk');
                       toAddresses.add('kunal.sharma@britishschools.co.uk');
                       if(userMap.get(portalUserList[i].Id) != null){
                          if(userMap.get(portalUserList[i].Id).IT_Notifications_Email_User__c != null && userMap.get(portalUserList[i].Id).IT_Notifications_Email_User__c != ''){
                            toAddresses.add(userMap.get(portalUserList[i].Id).IT_Notifications_Email_User__c);
                          }
                       } 
                       //String[] toAddresses = new String[] {'ben.hails@britishschools.co.uk','kunal.sharma@britishschools.co.uk'};
                       mail.setToAddresses(toAddresses);
                       mail.setSubject('Portal User Sync Failed - '+portalUserList[i].FirstName + ' '+portalUserList[i].LastName);
                       string emailText = 'Below user failed to get synced with respective contact.';
                       emailText += '\n';
                       emailText += 'https://ap4.salesforce.com/'+portalUserList[i].Id;
                       mail.setPlainTextBody(emailText);
                       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
                    }else{
                        parentUser.Portal_Contact_Sync_Failed__c = false;
                    }
                    usersToBeUpdated.add(parentUser);
                    i++;
                }
                if(usersToBeUpdated.size() > 0){
                    try{
                        update usersToBeUpdated;
                    }catch(Exception e){
                        
                    }
                }
          }
      }
      
      @future
      public static void userAfterInsertAccountContactUpdate(set<Id> accountIds,set<Id> contactIds,map<Id,Id> accountUserMap,map<Id,Id> contactUserMap){
            //check for account updation
            if(accountUserMap.size() > 0){
                list<Account> accList =  new list<Account>();
                for(Account acc:[Select RecordType.DeveloperName, Id,PersonEmail, Portal_User_Creation_Error__c, User__pc from Account where Id IN:accountUserMap.keySet() AND User__pc = null]){
                    Id uid = accountUserMap.get(acc.Id);
                    if(uid == null){
                        String accId =  acc.Id;
                        accId = accId.subString(0,15);
                        uid = accountUserMap.get(accId);
                    }
                    if(uid != null){
                        acc.Portal_User_Creation_Error__c = false;
                        acc.User__pc = uid; 
                        accList.add(acc);
                    }
                }
                if(accList.size() > 0){ 
                    update accList; 
                }
            }
            //check for contact updation
            if(contactUserMap.size() > 0){
                list<Contact> conList =  new list<Contact>();
                for(Contact con:[Select Id, Email, Contact_Portal_User_Creation_Error__c, User__c, RecordType.DeveloperName from Contact where Id IN:contactUserMap.keySet() AND User__c = null]){
                    Id uid = contactUserMap.get(con.Id);
                    if(uid == null){
                        String conId =  con.Id;
                        conId = conId.subString(0,15);
                        uid = contactUserMap.get(conId);
                    }
                    if(uid != null){
                        con.Contact_Portal_User_Creation_Error__c = false;
                        con.User__c = uid; 
                        conList.add(con);
                    }
                }
                if(conList.size() > 0){ 
                    update conList; 
                }
            }   
      }
      
      //year group options
      public static list<string> getYearGroupOptions(){
        boolean isUSSet = false;
        Map<String,School_Logo_Mapping__c>schoolSettingMap =  new Map<String,School_Logo_Mapping__c>();
        List<School_Logo_Mapping__c> settings = School_Logo_Mapping__c.getall().values(); 
        for(School_Logo_Mapping__c setting:settings){
            schoolSettingMap.put(setting.School_Full_Name__c,setting);
        }
        //fetch user school
        string school = [select School__c from User where Id=:UserInfo.getUserId()].School__c;
        School_Logo_Mapping__c setting = schoolSettingMap.get(school);
        if(setting != null){
            isUSSet = setting.Is_US_Year_Group__c;
        }
        list<string> ukSet = new list<string>();
        ukSet.add('PN');ukSet.add('N');ukSet.add('R');ukSet.add('Y1');ukSet.add('Y2');ukSet.add('Y3');ukSet.add('Y4');ukSet.add('Y5');ukSet.add('Y6');ukSet.add('Y7');ukSet.add('Y8');ukSet.add('Y9');ukSet.add('Y10');ukSet.add('Y11');ukSet.add('Y12');ukSet.add('Y13');
      
        list<string> usSet = new list<string>();
        usSet.add('PN');usSet.add('N');usSet.add('PK');usSet.add('K');usSet.add('G1');usSet.add('G2');usSet.add('G3');usSet.add('G4');usSet.add('G5');usSet.add('G6');usSet.add('G7');usSet.add('G8');usSet.add('G9');usSet.add('G10');usSet.add('G11');usSet.add('G12');
        
        if(isUSSet){
            return usSet;
        }
        return ukSet;
      }
}