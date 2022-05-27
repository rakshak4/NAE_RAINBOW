//controller class for User sub-tab for staff directory
public without sharing class UserStaffDirectory_Controller{
    
    public User contextUser {get;set;}
    public boolean hasEditAccess {get;set;}
    public list<SelectOption> departmentOptions {get;set;}
    public boolean canEdit {get{
        boolean flag = false;
        if(hasEditAccess || (loggedInUser.Manage_Chatter_Free_Users__c != null && loggedInUser.School__c == contextUser.School__c) || loggedInUser.Manage_Chatter_Free_Users__c == 'As Web Dev'){
            flag = true;
        }
        return flag;
    }}
    public boolean isEditMode {get;set;}
    public Attachment photo {get;set;}
    public string reload {get;set;}
    public User loggedInUser {get;set;}
    public UserFields userField {get;set;}
    public Account userAccount {get;set;}
    public boolean calledFromWebsite {get;set;}
    public boolean updateFlag {get;set;}
    public string schoolLogoURL {get;set;}
    public boolean allowUpdate {get{
        return !contextUser.Staff_Directory_Info_Received__c || updateFlag;
    }}
    
    public boolean showDefaultView{get{
        boolean flag = false;
        if(isEditMode && !calledFromWebsite &&contextUser != null && (!contextUser.Is_Chatter_Free_User__c || loggedInUser.Profile.Name == 'System Administrator')){
            flag = true;
        }
        return flag;
    }}
    
    public boolean showOverriddenView{get{
        boolean flag = false;
        if(isEditMode && ((contextUser != null && contextUser.Is_Chatter_Free_User__c && loggedInUser.Profile.Name != 'System Administrator') || calledFromWebsite)){
            flag = true;
        }
        return flag;
    }}
    
    public UserStaffDirectory_Controller(ApexPages.StandardController controller){
        reload = '0';
        isEditMode = false;
        hasEditAccess = false;
        calledFromWebsite = false;
        updateFlag = false;
        photo = new Attachment();
        loggedInUser = [select Id, School__c, Profile.Name ,Manage_Chatter_Free_Users__c from User where Id =:UserInfo.getUserId()];
        //system.debug('****UserStaffDirectory_Controller***constructor***params='+system.currentPageReference().getParameters());
        string userId = system.currentPageReference().getParameters().get('sfdc.userId');
        string webrequest = system.currentPageReference().getParameters().get('w');
        string isUpdate = system.currentPageReference().getParameters().get('uf');
        if(webrequest == '1'){
            calledFromWebsite = true;
            isEditMode = true;
        }
        if(isUpdate == '1'){
            updateFlag = true;
        }
        if(userId != null){
            contextUser = [select Staff_Directory_Info_Received__c, Is_Chatter_Free_User__c, Profile.Name, Staff_Directory_Info_Additional_Notes__c, Related_Contact_Id__c, Id,School__c, Override_Manually__c, Link_to_Related_Contact__c, S_Dir_Department__c,S_Dir_Profile_Approved_by_Admin__c,S_Dir_Status__c,S_Dir_Name__c,Publish_on_School_Site__c,S_Dir_Title_New__c,S_Dir_Positioning__c ,S_Dir_Degree__c, S_Dir_Personal_Interests__c from User where Id=:userId];
            hasEditAccess = [SELECT RecordId, HasEditAccess FROM UserRecordAccess WHERE UserId =: UserInfo.getUserId() AND RecordId = :contextUser.Id].HasEditAccess;
            try{
                userAccount = [select Id from Account where User__pc =: contextUser.Id];
            }catch(Exception e){}
            initialize();
        }
    }
    
    
    private void initialize(){ 
        //fetch school's logo
        for(School_Logo_Mapping__c setting:School_Logo_Mapping__c.getall().values()){
            if(contextUser.School__c == setting.School_Full_Name__c){
                schoolLogoURL = setting.School_Logo_URL__c;
                break;
            }
        }
        
        userField = new UserFields();
        userField.name = new Field_Text(contextUser.S_Dir_Name__c);
        userField.positioning = new Field_Decimal(contextUser.S_Dir_Positioning__c);
        userField.override_manually = new Field_Boolean(contextUser.Override_Manually__c);
        userField.title = new Field_Text(contextUser.S_Dir_Title_New__c);
        userField.status = new Field_Text(contextUser.S_Dir_Status__c);
        userField.school_department = new Field_Text(contextUser.S_Dir_Department__c);
        userField.profile_approved = new Field_Boolean(contextUser.S_Dir_Profile_Approved_by_Admin__c);
        //userField.origin = new Field_Text(contextUser.S_Dir_Origin__c);
        //userField.expirience = new Field_Decimal(contextUser.S_Dir_Years_of_Experience__c);
        userField.degree = new Field_Text(contextUser.S_Dir_Degree__c);
        //userField.other_qualifications = new Field_Text(contextUser.S_Dir_Other_Qualifications__c);
        userField.personal_Interest = new Field_Text(contextUser.S_Dir_Personal_Interests__c);
        
        userField.notes = new Field_Text(contextUser.Staff_Directory_Info_Additional_Notes__c);
        
        //check for access
        if(!calledFromWebsite && (hasEditAccess || (loggedInUser.Manage_Chatter_Free_Users__c == 'As Admin' && loggedInUser.School__c == contextUser.School__c) || loggedInUser.Manage_Chatter_Free_Users__c == 'As Web Dev')){
            userField.positioning.editAccess = true;
            userField.override_manually.editAccess = true;
            userField.title.editAccess = true;
            if(hasEditAccess && loggedInUser.Profile.Name == 'System Administrator'){
                userField.status.editAccess = true;
                userField.school_department.editAccess = true;
                //userField.origin.editAccess = true;
            }else{
                userField.status.editAccess = false;
                userField.school_department.editAccess = false;
                //userField.origin.editAccess = false;
            }
            userField.profile_approved.editAccess = true;
            //userField.origin.editAccess = true;
            //userField.expirience.editAccess = true;
            userField.degree.editAccess = true;
            //userField.other_qualifications.editAccess = true;
            userField.personal_Interest.editAccess = true;
        }else if(!calledFromWebsite && loggedInUser.Manage_Chatter_Free_Users__c == 'As Academic' && loggedInUser.School__c == contextUser.School__c){
            userField.positioning.editAccess = false;
            userField.override_manually.editAccess = false;
            userField.title.editAccess = true;
            userField.status.editAccess = false;
            userField.school_department.editAccess = false;
            userField.profile_approved.editAccess = false;
            //userField.origin.editAccess = false;
            //userField.expirience.editAccess = true;
            userField.degree.editAccess = true;
            //userField.other_qualifications.editAccess = true;
            userField.personal_Interest.editAccess = true;
        }else if(calledFromWebsite){
            userField.positioning.editAccess = false;
            userField.override_manually.editAccess = false;
            userField.title.editAccess = false;
            userField.status.editAccess = false;
            userField.school_department.editAccess = false;
            userField.profile_approved.editAccess = false;
            //userField.origin.editAccess = false;
            //userField.expirience.editAccess = true;
            userField.degree.editAccess = true;
            //userField.other_qualifications.editAccess = true;
            userField.personal_Interest.editAccess = true;
        }
        
        //check department options
        departmentOptions = new list<SelectOption>();
        for(Schema.PicklistEntry entry:User.S_Dir_Department__c.getDescribe().getPicklistValues()){
            departmentOptions.add(new SelectOption(entry.getValue(),entry.getLabel()));
        }
    }
    
    public PageReference showEditMode(){
        isEditMode = true;
        return null;
    }
    
    public PageReference saveUser(){
        try{
            string successMessageStr;
            
            if(calledFromWebsite){
                successMessageStr = 'Your details have been successfully submitted to the school. Thank you for taking the time to complete this form.';
            }else{
                successMessageStr = 'Your details have been successfully submitted to the school. Thank you for taking the time to complete this form.';
            }
            reload = '1';
            if(!showDefaultView){
                isEditMode = false;
                //populate user fields
                contextUser.S_Dir_Positioning__c = userField.positioning.value;
                contextUser.Override_Manually__c = userField.override_manually.value;
                contextUser.S_Dir_Title_New__c = userField.title.value;
                contextUser.S_Dir_Status__c = userField.status.value;
                contextUser.S_Dir_Department__c = userField.school_department.value;
                contextUser.S_Dir_Profile_Approved_by_Admin__c = userField.profile_approved.value;
                //contextUser.S_Dir_Origin__c = userField.origin.value;
                //contextUser.S_Dir_Years_of_Experience__c = userField.expirience.value;
                contextUser.S_Dir_Degree__c = userField.degree.value;
                //contextUser.S_Dir_Other_Qualifications__c = userField.other_qualifications.value;
                contextUser.S_Dir_Personal_Interests__c = userField.personal_Interest.value;
                if(calledFromWebsite){
                    contextUser.Staff_Directory_Info_Additional_Notes__c = userField.notes.value;
                    contextUser.Staff_Directory_Info_Received__c = true; 
                }
                //check for photo
                system.debug('****UserStaffDirectory_Controller***saveUser***photo.ContentType='+photo.ContentType);
                if(photo.body != null && photo.ContentType != null){
                    //check for content type
                    
                    if(photo.ContentType.equalsIgnoreCase('image/gif') || photo.ContentType.equalsIgnoreCase('image/jpeg') || photo.ContentType.equalsIgnoreCase('image/jpg' ) || photo.ContentType.equalsIgnoreCase('image/png')){
                        
                        
                        //ConnectApi.BinaryInput bi =  new ConnectApi.BinaryInput(photo.body,photo.ContentType,photo.Name);
                        //ConnectApi.Photo cPhoto = ConnectApi.ChatterUsers.setPhoto(null, contextUser.Id , bi);
                        
                        
                        //check for account
                        try{
                            
                            if(userAccount != null){
                                Attachment att = new Attachment();
                                att.ParentId = userAccount.Id;
                                att.Body = photo.body;
                                att.Name = photo.Name;
                                att.ContentType = photo.ContentType;
                                insert att;
                                //update user
                                contextUser.Photo_Attachment_Id__c = att.Id; 
                                contextUser.Has_Profile_Photo__c = true;
                                
                            }
                        }catch(Exception e){
                            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Failed to process uploaded photo.  - '+e.getMessage());
                            ApexPages.addMessage(errorMessage);
                        }
                        
                        //PortalUtility.updateProfilePhoto(photo.body,photo.ContentType,photo.Name,contextUser.Id);
                        //contextUser.Has_Profile_Photo__c = true;
                        update contextUser; 
                        
                        ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, successMessageStr);
                        ApexPages.addMessage(successMessage);
                        //photo = new Attachment();
                         
                    }else{
                        update contextUser; 
                        ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.WARNING, successMessageStr+' Failed to update photo as provided file is a invalid photo.');
                        ApexPages.addMessage(successMessage);
                        reload = '0';
                        //photo = new Attachment();
                    }
                }else{
                    update contextUser; 
                    ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, successMessageStr);
                    ApexPages.addMessage(successMessage);
                    //photo = new Attachment();
                    
                }
            }else{
                if(photo.body != null && photo.ContentType != null){
                    //check for content type
                    
                    if(photo.ContentType.equalsIgnoreCase('image/gif') || photo.ContentType.equalsIgnoreCase('image/jpeg') || photo.ContentType.equalsIgnoreCase('image/jpg' ) || photo.ContentType.equalsIgnoreCase('image/png')){
                        ConnectApi.BinaryInput bi =  new ConnectApi.BinaryInput(photo.body,photo.ContentType,photo.Name);
                        ConnectApi.Photo cPhoto = ConnectApi.ChatterUsers.setPhoto(null, contextUser.Id , bi);
                        
                        contextUser.Has_Profile_Photo__c = true;
                        update contextUser; 
                        ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, successMessageStr);
                        ApexPages.addMessage(successMessage);
                        //photo = new Attachment();
                         
                    }else{
                        update contextUser; 
                        ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.WARNING, successMessageStr+' Failed to update photo as provided file is a invalid photo.');
                        ApexPages.addMessage(successMessage);
                        reload = '0';
                        //photo = new Attachment();
                    }
                }else{
                    update contextUser; 
                    ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, successMessageStr);
                    ApexPages.addMessage(successMessage);
                    //photo = new Attachment();
                    
                }
            }
             
        }catch(Exception e){
            isEditMode = true;
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Failure: Error - '+e.getMessage());
            ApexPages.addMessage(errorMessage);
            reload = '0';
            photo = new Attachment();
        }
        photo = new Attachment();
        updateFlag = false;
        return null;
    }
    
    public PageReference cancel(){
        isEditMode = false;
        reload = '0';
        return null;
    }
    
    public class UserFields{
        public Field_Text name {get;set;}
        public Field_Decimal positioning {get;set;}
        public Field_Boolean override_manually {get;set;} 
        public Field_Text title {get;set;}
        public Field_Text status {get;set;}
        public Field_Text school_department {get;set;}
        public Field_Boolean profile_approved {get;set;}
        //public Field_Text origin {get;set;}  
        //public Field_Decimal expirience {get;set;}  
        public Field_Text degree {get;set;}  
        //public Field_Text other_qualifications {get;set;}  
        public Field_Text personal_Interest {get;set;} 
        public  Field_Text notes {get;set;}
    }
    
    public class Field_Text{
        public string value {get;set;}
        public boolean editAccess {get;set;}
        public Field_Text(string v){
            value = v;
            editAccess = false;
        }
    }
    
    public class Field_Decimal{
        public decimal value {get;set;}
        public boolean editAccess {get;set;}
        public Field_Decimal(decimal v){
            value = v;
            editAccess = false;
        }
    }
    
    public class Field_Boolean{
        public boolean value {get;set;}
        public boolean editAccess {get;set;}
        public Field_Boolean(boolean v){
            value = v;
            editAccess = false;
        }
    }
    
}