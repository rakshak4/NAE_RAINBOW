/***
    Author: Kunal 
    Created Date: 23 August 2013
    Desc: VF controller PortalStudentGroupChatter_Controller
***/
public class PortalStudentGroupChatter_Controller {
    public boolean isChatterGroupExists {get;set;} 
    public boolean isFatalError {get;set;} 
    public CollaborationGroup chatterGroup{get;set;}
    public Group__c studentGroup {get;set;}
    public boolean addRegisteredStudentsParents {get;set;}
    private School_Logo_Mapping__c schoolSetting;
    
    //constructor
    public PortalStudentGroupChatter_Controller(ApexPages.StandardController controller) {
        isChatterGroupExists = false;
        isFatalError = false;
        addRegisteredStudentsParents = true;
        //fetch custom setting
        //populate schools setting map
        Map<String,School_Logo_Mapping__c>schoolSettingMap =  new Map<String,School_Logo_Mapping__c>();
        List<School_Logo_Mapping__c> settings = School_Logo_Mapping__c.getall().values(); 
        for(School_Logo_Mapping__c setting:settings){
            schoolSettingMap.put(setting.School_Full_Name__c,setting);
        }
        studentGroup = [Select Name,OwnerId,Owner.Name,Auto_Add_Parents_To_Group__c, Chatter_Group_Id__c, Group_Name__c,School__c, Id from Group__c where Id=:controller.getId()];
        studentGroup.Auto_Add_Parents_To_Group__c =  true;
        schoolSetting = schoolSettingMap.get(studentGroup.School__c);
        if(schoolSetting == null){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Data Error: No settings are found for "'+studentGroup.School__c+'"".');
            ApexPages.addMessage(errorMessage);
            isFatalError = true;
        }else{
            if(schoolSetting.Community_Id__c == null){
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Data Error: No community Id for "'+studentGroup.School__c+'". Please verify if Parent Community Portal is created for this school.');
                ApexPages.addMessage(errorMessage);
                isFatalError = true;
            }else{
                studentGroup.Auto_Add_Parents_To_Group__c =  true;
                if(studentGroup.Chatter_Group_Id__c != null){
                    
                    try{
                        chatterGroup = [Select c.Name, c.MemberCount, c.Description, c.CollaborationType From CollaborationGroup c where c.Id=:studentGroup.Chatter_Group_Id__c];
                        isChatterGroupExists = true;
                    }catch(Exception e){
                        isChatterGroupExists = false;
                    }
                }
                
                if(chatterGroup == null){
                    chatterGroup =  new CollaborationGroup();
                    chatterGroup.Name = studentGroup.Group_Name__c + ' - '+studentGroup.Owner.Name;
                    chatterGroup.NetworkId = schoolSetting.Community_Id__c;
                    chatterGroup.CollaborationType = 'Private';
                    chatterGroup.OwnerId = studentGroup.OwnerId;
                }
            }
        }
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference('/'+studentGroup.Id);
        return pg;
    }
    
    //create chatter group
    public PageReference createChatterGroup(){
        try{
            //insert chatter group
            insert chatterGroup;
            //update student group
            studentGroup.Chatter_Group_Id__c = chatterGroup.Id;
            update studentGroup;
            //add registered student's parents
            if(addRegisteredStudentsParents == true){
                //fetch parent id of registered students
                Set<Id> parentAccountIds = new Set<Id>();
                for(Registration__c registration:[Select r.Parent_File_Id__c, r.Student__r.Main_Parent_File__c, r.Student__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__c=:studentGroup.Id]){
                    parentAccountIds.add(registration.Parent_File_Id__c);
                }
                //fetch parent's user records
                List<CollaborationGroupMember> groupMembers =  new List<CollaborationGroupMember>(); 
                for(User u:[Select Id from User where Family_File_Id__c IN:parentAccountIds AND Is_Portal_User__c = true AND IsActive = true]){
                    CollaborationGroupMember member =  new CollaborationGroupMember();
                    member.CollaborationGroupId = chatterGroup.Id;
                    member.CollaborationRole = 'Standard';
                    member.MemberId = u.Id;
                    //member.NotificationFrequency = 'W';
                    groupMembers.add(member); 
                }
                if(groupMembers.size() > 0){
                    insert groupMembers; 
                }
                ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Community Chatter Group is created and '+groupMembers.size()+' parent(s) are successfully addedd to community chatter group. Please access school\'s community for further chatter group management.');
                ApexPages.addMessage(successMessage);
                isChatterGroupExists = true;
            }
        
        }catch(Exception e){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'System Error: Oooops system has incurred an unexpected error. Please contact system administrator and provide following error message: '+e.getMessage());
            ApexPages.addMessage(errorMessage);
        }
        return null;
    }
    
    
    
    //create chatter group
    public PageReference addNewParents(){
        try{
            //fetch parent id of registered students
            Set<String> parentAccountIds = new Set<String>();
            for(Registration__c registration:[Select r.Parent_File_Id__c, r.Student__r.Main_Parent_File__c, r.Student__c, r.Active__c From Registration__c r where r.Active__c = true AND r.Group__c=:studentGroup.Id]){
                parentAccountIds.add(registration.Parent_File_Id__c);
            }
            //fetch existing members
            set<Id> existingMembers =  new Set<Id>();
            for(CollaborationGroupMember existingMember:[Select Id, MemberId from CollaborationGroupMember where CollaborationGroupId=:chatterGroup.Id]){
                existingMembers.add(existingMember.MemberId);
            }
            //fetch parent's user records
            List<CollaborationGroupMember> groupMembers =  new List<CollaborationGroupMember>();         
            for(User u:[Select Id from User where Family_File_Id__c IN:parentAccountIds AND Is_Portal_User__c = true AND IsActive = true]){
                if(!existingMembers.contains(u.Id)){
                    CollaborationGroupMember member =  new CollaborationGroupMember();
                    member.CollaborationGroupId = chatterGroup.Id;
                    member.CollaborationRole = 'Standard';
                    member.MemberId = u.Id;
                    member.NotificationFrequency = 'W';
                    groupMembers.add(member);
                }
            }
            if(groupMembers.size() > 0){
                insert groupMembers;
                chatterGroup = [Select c.Name, c.MemberCount, c.Description, c.CollaborationType From CollaborationGroup c where c.Id=:studentGroup.Chatter_Group_Id__c];
            }
            ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, groupMembers.size()+' parent(s) are successfully addedd to community chatter group. Please access school\'s community for further chatter group management.');
            ApexPages.addMessage(successMessage);
        }catch(Exception e){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'System Error: Oooops system has incurred an unexpected error. Please contact system administrator and provide following error message: '+e.getMessage());
            ApexPages.addMessage(errorMessage);
        }
        return null;
    }
    
    
}