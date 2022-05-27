/***
    Author: Kunal Sharma
    Created Date: 26th August 2013
    Desc: handles chatter group memberships based on student group registration
    
***/
trigger HandleRegistartionsInsertUpdate on Registration__c (after insert, after update, after delete) {
    system.debug('***HandleRegistartionsInsertUpdate***start:'+trigger.newMap);
    List<Registration__c> processForAddition = new List<Registration__c>();
    List<Registration__c> processForDeletion = new List<Registration__c>();
    //fetch settings
    Map<String,School_Logo_Mapping__c>schoolSettingMap =  new Map<String,School_Logo_Mapping__c>();
    List<School_Logo_Mapping__c> settings = School_Logo_Mapping__c.getall().values(); 
    for(School_Logo_Mapping__c setting:settings){
        schoolSettingMap.put(setting.School_Full_Name__c,setting);
    }
    
    //set for student's parent account
    Set<Id> parentAccountIds =  new Set<Id>();
    //set of student's parent account Id marked to be deleted
    Set<Id> parentAccountToBeDeletedIds =  new Set<Id>();
    //set of chatter group Ids
    Set<Id> studentIdsForDeletion =  new Set<Id>();
    Set<Id> collabrationGroupIds =  new Set<Id>();
    if(trigger.isInsert || trigger.isUpdate){
        for(Registration__c r : trigger.new){
             if(r.Is_Valid_Group__c){
                    if(r.Parent_File_Id__c != null && r.Parent_File_Id__c != ''){
                        if(trigger.isInsert){
                            System.debug('****HandleRegistartionsInsertUpdate***trigger.isInsert='+trigger.isInsert);
                            System.debug('****HandleRegistartionsInsertUpdate***r.Active__c='+r.Active__c);
                            System.debug('****HandleRegistartionsInsertUpdate***r.School__c='+r.School__c);
                            System.debug('****HandleRegistartionsInsertUpdate***schoolSettingMap.get(r.School__c)='+schoolSettingMap.get(r.School__c));
                            System.debug('****HandleRegistartionsInsertUpdate***r.Chatter_Group_Id__c='+r.Chatter_Group_Id__c);
                            if(r.Active__c == true && schoolSettingMap.get(r.School__c) != null && r.Chatter_Group_Id__c != null && r.Chatter_Group_Id__c != ''){
                                System.debug('****HandleRegistartionsInsertUpdate***schoolSettingMap.get(r.School__c).Community_Id__c='+schoolSettingMap.get(r.School__c).Community_Id__c);
                                if(schoolSettingMap.get(r.School__c).Community_Id__c != null){
                                    processForAddition.add(r);
                                    parentAccountIds.add(r.Parent_File_Id__c);  
                                    collabrationGroupIds.add(r.Chatter_Group_Id__c);
                                }
                            }
                        }else if(trigger.isUpdate){
                            if(schoolSettingMap.get(r.School__c) != null && r.Chatter_Group_Id__c != null && r.Chatter_Group_Id__c != ''){
                                if(r.Active__c == true && trigger.oldMap.get(r.Id).Active__c == false){
                                    processForAddition.add(r);
                                    parentAccountIds.add(r.Parent_File_Id__c);
                                    collabrationGroupIds.add(r.Chatter_Group_Id__c); 
                                }else if(r.Active__c == false && trigger.oldMap.get(r.Id).Active__c == true){
                                    processForDeletion.add(r);
                                    parentAccountIds.add(r.Parent_File_Id__c);
                                    parentAccountToBeDeletedIds.add(r.Parent_File_Id__c);
                                    studentIdsForDeletion.add(r.Student__c);    
                                    collabrationGroupIds.add(r.Chatter_Group_Id__c);
                                }
                            }
                        }
                 }
            }
        }
    }else if(trigger.isDelete){
        for(Registration__c r:trigger.old){
           if(r.Is_Valid_Group__c){
               if(r.Parent_File_Id__c != null && r.Parent_File_Id__c != ''){
                    if(trigger.oldMap.get(r.Id).Active__c == true){
                        processForDeletion.add(r);
                        parentAccountIds.add(r.Parent_File_Id__c);
                        parentAccountToBeDeletedIds.add(r.Parent_File_Id__c);
                        studentIdsForDeletion.add(r.Student__c);
                        collabrationGroupIds.add(r.Chatter_Group_Id__c); 
                    }
               }
           }
        }
    }
    System.debug('****HandleRegistartionsInsertUpdate***processForAddition='+processForAddition);
    System.debug('****HandleRegistartionsInsertUpdate***processForDeletion='+processForDeletion);
    System.debug('****HandleRegistartionsInsertUpdate***schoolSettingMap='+schoolSettingMap);
    System.debug('****HandleRegistartionsInsertUpdate***parentAccountIds='+parentAccountIds);
    System.debug('****HandleRegistartionsInsertUpdate***parentAccountToBeDeletedIds='+parentAccountToBeDeletedIds);
    System.debug('****HandleRegistartionsInsertUpdate***studentIdsForDeletion='+studentIdsForDeletion);
    System.debug('****HandleRegistartionsInsertUpdate***collabrationGroupIds='+collabrationGroupIds);
    
    //fetch parent user
    Map<Id,set<Id>> parentAccountUserMap = new Map<Id,set<Id>>();
    Set<Id> userIds = new Set<Id>();
    for(User u:[select Id,AccountId,Family_File_Id__c from User where IsActive = true AND Is_Portal_User__c = true AND Family_File_Id__c IN:parentAccountIds]){
        if(parentAccountUserMap.get(u.Family_File_Id__c) != null){
            parentAccountUserMap.get(u.Family_File_Id__c).add(u.Id);
        }else{
            set<Id> uidset =  new set<Id>();
            uidset.add(u.Id);
            parentAccountUserMap.put(u.Family_File_Id__c, uidset);
        }
        userIds.add(u.Id); 
    } 
    System.debug('****HandleRegistartionsInsertUpdate***parentAccountUserMap='+parentAccountUserMap);
    //fetch existing membership records for found users
    Map<String,CollaborationGroupMember> existingMembershipMap = new Map<String,CollaborationGroupMember>(); //key = userid-groupid
    for(CollaborationGroupMember member:[select Id, CollaborationGroupId, MemberId from CollaborationGroupMember where MemberId IN:userIds AND CollaborationGroupId IN: collabrationGroupIds]){
        String gid_str = member.CollaborationGroupId;
        String key = member.MemberId+'-'+gid_str;  
        existingMembershipMap.put(key,member);
    } 
    System.debug('****HandleRegistartionsInsertUpdate***existingMembershipMap='+existingMembershipMap);
    //handle process for addition
    List<CollaborationGroupMember> newMembers =  new List<CollaborationGroupMember>();
    Set<String> addedMembershipSet =  new Set<String>();
    for(Registration__c r:processForAddition){ 
        //check if portal user is created for student's parent account
        if(parentAccountUserMap.keySet().contains(r.Parent_File_Id__c)){
            //iterate parent users
            for(Id portalUserId:parentAccountUserMap.get(r.Parent_File_Id__c)){
                //form key to fetch existing membership
                String key = portalUserId+'-'+r.Chatter_Group_Id__c;
                if(!existingMembershipMap.keySet().contains(key)){
                    if(!addedMembershipSet.contains(key)){
                        CollaborationGroupMember member =  new CollaborationGroupMember();
                        member.CollaborationGroupId = r.Chatter_Group_Id__c;
                        member.CollaborationRole = 'Standard';
                        member.MemberId = portalUserId;
                        member.NotificationFrequency = 'W';
                        newMembers.add(member);
                        addedMembershipSet.add(key);
                    }
                }
            }
        }
    }
    System.debug('****HandleRegistartionsInsertUpdate***newMembers='+newMembers);
    if(newMembers.size() > 0){
        insert newMembers;
    }
    //handle process for deletion
    //check the members to be deletd if they have other active registered student within same group
    System.debug('****HandleRegistartionsInsertUpdate***parentAccountToBeDeletedIds='+parentAccountToBeDeletedIds);
    System.debug('****HandleRegistartionsInsertUpdate***studentIdsForDeletion='+studentIdsForDeletion);
    Set<String> activeRegistrationsKeySet = new Set<String>();//key= parent account id-Community_Chatter_Group__c
    if(parentAccountToBeDeletedIds.size() > 0 && studentIdsForDeletion.size() > 0){
        for(Registration__c r:[Select Id,Active__c,Group__c,Parent_File_Id__c,Chatter_Group_Id__c,Student__c,Student__r.Main_Parent_File__c from Registration__c where Active__c = true AND Student__r.Main_Parent_File__c IN:parentAccountToBeDeletedIds AND Chatter_Group_Id__c != null  AND Chatter_Group_Id__c != '' AND Student__c NOT IN:studentIdsForDeletion]){
            System.debug('****HandleRegistartionsInsertUpdate***active student='+r.Student__c);
            if(parentAccountUserMap.keySet().contains(r.Parent_File_Id__c)){
                for(Id uid:parentAccountUserMap.get(r.Parent_File_Id__c)){
                    activeRegistrationsKeySet.add(uid+'-'+r.Chatter_Group_Id__c);   
                }
            }
            
        }
    }
    System.debug('****HandleRegistartionsInsertUpdate***activeRegistrationsKeySet='+activeRegistrationsKeySet);
    List<CollaborationGroupMember> deleteMembers =  new List<CollaborationGroupMember>();
    Set<Id> addedIds = new Set<Id>();
    for(Registration__c r:processForDeletion){
        //check if portal user is created for student's parent account
        if(parentAccountUserMap.keySet().contains(r.Parent_File_Id__c)){
            for(Id uid:parentAccountUserMap.get(r.Parent_File_Id__c)){
                //form key to fetch existing membership
                String key = uid+'-'+r.Chatter_Group_Id__c;
                String keyForOtherActiveRegistration = uid+'-'+r.Chatter_Group_Id__c;
                System.debug('****HandleRegistartionsInsertUpdate***key='+key);
                if(existingMembershipMap.keySet().contains(key)){
                    if(!addedIds.contains(existingMembershipMap.get(key).Id) && !activeRegistrationsKeySet.contains(keyForOtherActiveRegistration)){
                        deleteMembers.add(existingMembershipMap.get(key));
                        addedIds.add(existingMembershipMap.get(key).Id);
                    }
                }
            }
        }
    }
    System.debug('****HandleRegistartionsInsertUpdate***deleteMembers='+deleteMembers);
    if(deleteMembers.size() > 0){
        delete deleteMembers;
    }
    
    //for populating tutor group on student
    map<Id,Contact> studentMap = new map<Id,Contact>();
    if(trigger.isInsert || trigger.isUpdate){
        for(Registration__c r:trigger.new){
            if(r.Is_Valid_Group__c){
                if(trigger.isInsert){
                    if(r.Active__c == true && r.Group_Type__c == 'Tutor Group'){
                        Contact student = new Contact(Id=r.Student__c);
                        student.Tutor_Group__c = r.Group__c;
                        studentMap.put(r.Student__c, student);
                    }
                }else if(trigger.isUpdate){
                    if(r.Active__c == true && trigger.oldMap.get(r.Id).Active__c == false && r.Group_Type__c == 'Tutor Group'){
                        if(studentMap.containsKey(r.Student__c)){
                            if(studentMap.get(r.Student__c).Tutor_Group__c == null){
                                studentMap.get(r.Student__c).Tutor_Group__c = r.Group__c;
                            }
                        }else{
                            Contact student = new Contact(Id=r.Student__c);
                            student.Tutor_Group__c = r.Group__c;
                            studentMap.put(r.Student__c, student);
                        }   
                    }else if((r.Group_Type__c != 'Tutor Group' && trigger.oldMap.get(r.Id).Group_Type__c == 'Tutor Group')  || ( r.Active__c == false && trigger.oldMap.get(r.Id).Active__c == true && r.Group_Type__c == 'Tutor Group') ){
                        if(!studentMap.containsKey(r.Student__c)){
                            Contact student = new Contact(Id=r.Student__c);
                            student.Tutor_Group__c = null;
                            studentMap.put(r.Student__c, student);
                        }
                    }
                }
            }
        }
    }else if(trigger.isDelete){
        set<Id> studentIds =  new set<Id>();
        for(Registration__c r:trigger.old){
            if(r.Is_Valid_Group__c){
                if(r.Group_Type__c == 'Tutor Group'){
                    studentIds.add(r.Student__c);
                }
            }
        }
        if(studentIds.size() > 0){
            map<Id,Contact> smap = new map<Id,Contact>([select Id,Tutor_Group__c from Contact where Id IN:studentIds]);
            for(Registration__c r:trigger.old){
                if(r.Group_Type__c == 'Tutor Group'){
                    Contact s =smap.get(r.Student__c);
                    if(s != null){
                        if(s.Tutor_Group__c == r.Group__c){
                            Contact student = new Contact(Id=r.Student__c);
                            student.Tutor_Group__c = null;
                            studentMap.put(r.Student__c, student);
                        }
                    }
                }
            }   
        }
    }
    if(studentMap.size() > 0){
        update studentMap.values();
    }
    system.debug('***HandleRegistartionsInsertUpdate***end:'+trigger.newMap);
}