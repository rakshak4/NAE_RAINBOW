trigger HandleGroupMemberAfterInsert on CollaborationGroupMember (after insert, before insert, before delete) {
    if(trigger.isAfter){
        list<CollaborationGroupMember> updateList = new list<CollaborationGroupMember>();
        set<Id> userIds = new set<Id>();
        for(CollaborationGroupMember cgm:trigger.new){
            userIds.add(cgm.MemberId);  
        }
        if(userIds.size() > 0){
            Map<Id,User> userMap  = new Map<Id,User>([select Id, Default_Digest_Frequency__c  from User where Id IN:userIds]);
            for(CollaborationGroupMember cgm:trigger.new){
                if(userMap.get(cgm.MemberId) != null){
                    CollaborationGroupMember c = new CollaborationGroupMember(Id=cgm.Id);
                    c.NotificationFrequency =   userMap.get(cgm.MemberId).Default_Digest_Frequency__c ;     
                    //c.NotificationFrequency =   'N';      
                    updateList.add(c);
                }
            }
        }
        if(updateList.size() > 0){
            update updateList;
        }
    }
    if(trigger.isBefore){
        
        //check for logged in user record 
        User loggedInUser = [select Name, Is_Portal_User__c, Id, Profile.Name from User where Id=:UserInfo.getUserId()];
        //member id set
        set<Id> memberUserIds = new set<Id>();
        if(trigger.isInsert){
            for(CollaborationGroupMember cgm:trigger.new){
                memberUserIds.add(cgm.MemberId);
            }
        }else if(trigger.isDelete){
            for(CollaborationGroupMember cgm:trigger.old){
                memberUserIds.add(cgm.MemberId);
            } 
        }
        
        //map of member user
        map<Id,User> memberUserMap =  new map<Id,User>([select Name, Is_Portal_User__c, Id, Profile.Name from User where Id IN:memberUserIds ]);
        
        //do validation 
        if(trigger.isInsert){
            for(CollaborationGroupMember cgm:trigger.new){
                if(memberUserMap.get(cgm.MemberId).Profile.Name == 'Parent Portal User - High Volume' && loggedInUser.Profile.Name  != 'System Administrator' && Network.getNetworkId() != null){
                    cgm.addError('You cannot directly add or remove parents from a Blog / group. Please add / remove their child(ren) from the related student group in order to do this.');
                }
            }
        }else if(trigger.isDelete){
            for(CollaborationGroupMember cgm:trigger.old){
                if(memberUserMap.get(cgm.MemberId).Profile.Name == 'Parent Portal User - High Volume' && loggedInUser.Profile.Name  != 'System Administrator' && Network.getNetworkId() != null){
                    cgm.addError('You cannot directly add or remove parents from a Blog / group. Please add / remove their child(ren) from the related student group in order to do this.');
                }
            }
        }
    }
}