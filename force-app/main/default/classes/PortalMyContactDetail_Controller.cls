//controller class to PortalMyContactDetail VF page
//created on 15 Aoril 2014
public class PortalMyContactDetail_Controller {      
    
    //variables
    private Id mainParentId {get;set;}
    private User portalUser {get;set;}
    public Account parentAccount {get;set;}
    public Contact parentContact {get;set;}
    public boolean isPersonAccountContact {get;set;}
    public list<SelectOption> firstPointOfContact {get;set;}
    public Id selectedFirstPointOfContact {get;set;}
    public boolean doNotReceiveEmail {get;set;}
    public string currentEmail {get;set;}
    //constructor
    public PortalMyContactDetail_Controller(){
        //check for test parameters
        string portalUserParam =  System.currentPageReference().getParameters().get('uid');
        Id portalUserId;
        if(portalUserParam != null){
            portalUserId = portalUserParam;
        }else{
            portalUserId = UserInfo.getUserId();
        }
        //check for success
        string isSuccess = System.currentPageReference().getParameters().get('s');
        if(isSuccess ==  '1'){
            ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Changes Saved. Thanks for updating your contact details.');
            ApexPages.addMessage(successMessage);
        }
        
        //check for portal account id and contact id
        portalUser =  [Select u.UserPreferencesDisableAllFeedsEmail, u.Name, u.Family_File_Id__c ,u.ContactId, u.AccountId From User u where Id=:portalUserId];
        doNotReceiveEmail = portalUser.UserPreferencesDisableAllFeedsEmail;
        initialize();
    }
    
    //create click event
    public PageReference createClickEvent(){
        Contact con = new Contact(Id=portalUser.ContactId);
        con.Portal_Contact_Page_Accessed__c = DateTime.now();
        update con;
        return null;
    }

    //intialize
    private void initialize(){
        if(portalUser.Family_File_Id__c != null && portalUser.Family_File_Id__c != ''){
            Id familyFileId = portalUser.Family_File_Id__c;
            if(familyFileId != portalUser.AccountId){
                parentAccount = [Select  a.Contact_Note__c, a.Related_Contact_Record_P2__c, a.Main_Address__c, a.Contact_Employer__pc, a.Contact_Employment_Sector__pc, a.PersonMobilePhone, a.IsPersonAccount, a.Nationality__pc, a.Contact_Mobile_Main_Phone_Country_CodePL__pc, a.Salutation, a.RT_Developer_Name__pc, a.Primary_Contact__c, a.Personal_Statement__c, a.PersonHomePhone, a.PersonHasOptedOutOfEmail, a.PersonEmail, a.Other_Responsabilities__c, a.Main_Parent_File__pc, a.LastName, a.Gender__c, a.FirstName, a.Contact_Relationship__pc, a.Contact_Nationality__pc, a.Contact_Alternate_Phone__pc, a.Contact_Alternate_Phone_Country_CodePL__pc, a.Contact_Alternate_Email__pc, a.Contact_Alternate_Email_Opt_Out__pc, a.Address__c, a.Additional_Parent__pc, a.Additional_Comments__c, a.Account_Relationship_Formula__c From Account a where a.Id=:portalUser.Family_File_Id__c];
                //parentAccount = [Select  a.Contact_Note__c, a.Related_Contact_Record_P2__c, a.Main_Address__c, a.Contact_Employer__pc,  a.PersonMobilePhone, a.IsPersonAccount, a.Nationality__pc, a.xsms__Mobile_Phone_Country_Code__pc, a.Salutation, a.RT_Developer_Name__pc, a.Primary_Contact__c, a.Personal_Statement__c, a.PersonHomePhone, a.PersonHasOptedOutOfEmail, a.PersonEmail, a.Other_Responsabilities__c, a.Main_Parent_File__pc, a.Main_Address__pc, a.LastName, a.Gender__c, a.FirstName, a.Contact_Relationship__pc, a.Contact_Nationality__pc, a.Contact_Alternate_Phone__pc, a.Contact_Alternate_Phone_Country_Code__pc, a.Contact_Alternate_Email__pc, a.Contact_Alternate_Email_Opt_Out__pc, a.Address__c, a.Additional_Parent__pc, a.Additional_Comments__c, a.Account_Relationship_Formula__c From Account a where a.Id=:portalUser.Family_File_Id__c];
                mainParentId = parentAccount.Id;
                isPersonAccountContact = false; 
                parentContact = [Select  Contact_Nationality__c, Contact_Employer__c, Contact_Employment_Sector__c, c.Nationality__c, c.Contact_Mobile_Main_Phone_Country_CodePL__c, c.Title, c.Status__c, c.Salutation, c.RT_Developer_Name__c, c.Primary_Parent__c, c.Phone, c.MobilePhone, c.Main_Parent_File__c, c.LastName, c.IsPersonAccount, c.Id, c.HasOptedOutOfEmail, c.FirstName, c.Family_Status__c, c.Email, c.Contact_Relationship__c, c.Contact_Alternate_Phone__c, c.Contact_Alternate_Phone_Country_CodePL__c, c.Contact_Alternate_Email__c, c.Contact_Alternate_Email_Opt_Out__c, c.Admissions_File__c, c.AccountId From Contact c where c.Id=:portalUser.ContactId];
                //parentContact = [Select  Contact_Nationality__c, Contact_Employer__c,  c.Nationality__c, c.xsms__Mobile_Phone_Country_Code__c, c.Title, c.Status__c, c.Salutation, c.RT_Developer_Name__c, c.Primary_Parent__c, c.Phone, c.MobilePhone, c.Main_Parent_File__c, c.LastName, c.IsPersonAccount, c.Id, c.HasOptedOutOfEmail, c.FirstName, c.Family_Status__c, c.Email, c.Contact_Relationship__c, c.Contact_Alternate_Phone__c, c.Contact_Alternate_Phone_Country_Code__c, c.Contact_Alternate_Email__c, c.Contact_Alternate_Email_Opt_Out__c, c.Admissions_File__c, c.AccountId From Contact c where c.Id=:portalUser.ContactId];
                currentEmail = parentContact.Email;
            }else{
                parentAccount = [Select  a.Contact_Note__c, a.Related_Contact_Record_P2__c, a.Main_Address__c, a.Contact_Employer__pc, a.Contact_Employment_Sector__pc, a.PersonMobilePhone, a.IsPersonAccount, a.Nationality__pc, a.Contact_Mobile_Main_Phone_Country_CodePL__pc, a.Salutation, a.RT_Developer_Name__pc, a.Primary_Contact__c, a.Personal_Statement__c, a.PersonHomePhone, a.PersonHasOptedOutOfEmail, a.PersonEmail, a.Other_Responsabilities__c,  a.Main_Parent_File__pc, a.LastName, a.Gender__c, a.FirstName, a.Contact_Relationship__pc, a.Contact_Nationality__pc, a.Contact_Alternate_Phone__pc, a.Contact_Alternate_Phone_Country_CodePL__pc, a.Contact_Alternate_Email__pc, a.Contact_Alternate_Email_Opt_Out__pc, a.Address__c, a.Additional_Parent__pc, a.Additional_Comments__c, a.Account_Relationship_Formula__c From Account a where a.Id=:portalUser.AccountId];
                //parentAccount = [Select  a.Contact_Note__c, a.Related_Contact_Record_P2__c, a.Main_Address__c, a.Contact_Employer__pc,  a.PersonMobilePhone, a.IsPersonAccount, a.Nationality__pc, a.xsms__Mobile_Phone_Country_Code__pc, a.Salutation, a.RT_Developer_Name__pc, a.Primary_Contact__c, a.Personal_Statement__c, a.PersonHomePhone, a.PersonHasOptedOutOfEmail, a.PersonEmail, a.Other_Responsabilities__c,  a.Main_Parent_File__pc, a.Main_Address__pc, a.LastName, a.Gender__c, a.FirstName, a.Contact_Relationship__pc, a.Contact_Nationality__pc, a.Contact_Alternate_Phone__pc, a.Contact_Alternate_Phone_Country_Code__pc, a.Contact_Alternate_Email__pc, a.Contact_Alternate_Email_Opt_Out__pc, a.Address__c, a.Additional_Parent__pc, a.Additional_Comments__c, a.Account_Relationship_Formula__c From Account a where a.Id=:portalUser.AccountId];
                currentEmail = parentAccount.PersonEmail;
                isPersonAccountContact = true;
                mainParentId = parentAccount.Id;
            }
            
        }/*else{
            parentAccount = [Select  a.Contact_Note__c, a.Related_Contact_Record_P2__c, a.Main_Address__c, a.Contact_Employer__pc, a.Contact_Employment_Sector__pc, a.PersonMobilePhone, a.IsPersonAccount, a.Nationality__pc, a.xsms__Mobile_Phone_Country_Code__pc, a.Salutation, a.RT_Developer_Name__pc, a.Primary_Contact__c, a.Personal_Statement__c, a.PersonHomePhone, a.PersonHasOptedOutOfEmail, a.PersonEmail, a.Other_Responsabilities__c,  a.Main_Parent_File__pc, a.LastName, a.Gender__c, a.FirstName, a.Contact_Relationship__pc, a.Contact_Nationality__pc, a.Contact_Alternate_Phone__pc, a.Contact_Alternate_Phone_Country_Code__pc, a.Contact_Alternate_Email__pc, a.Contact_Alternate_Email_Opt_Out__pc, a.Address__c, a.Additional_Parent__pc, a.Additional_Comments__c, a.Account_Relationship_Formula__c From Account a where a.Id=:portalUser.AccountId];
            currentEmail = parentAccount.PersonEmail;
            isPersonAccountContact = true;
            mainParentId = parentAccount.Id;
        }*/
        // identify first point of contact
        firstPointOfContact = new list<SelectOption>();
        Account tempParentAccount = [select Name, Salutation, FirstName, LastName, Related_Contact_Record_P2__c, Related_Contact_Record_P2__r.Name ,Related_Contact_Record_P2__r.Salutation , Related_Contact_Record_P2__r.FirstName, Related_Contact_Record_P2__r.LastName from Account where Id=:mainParentId];
        string firstParentName ;
        string secondParentName ;
        if(tempParentAccount.Salutation != null){
            firstParentName = tempParentAccount.Salutation+' '+tempParentAccount.Name;
        }else{
            firstParentName = tempParentAccount.Name;
        }
        if(tempParentAccount.Related_Contact_Record_P2__c != null){
            if(tempParentAccount.Related_Contact_Record_P2__r.Salutation != null){
                secondParentName = tempParentAccount.Related_Contact_Record_P2__r.Salutation+' '+tempParentAccount.Related_Contact_Record_P2__r.Name;
            }else{
                secondParentName = tempParentAccount.Related_Contact_Record_P2__r.Name;
            }
        }       
        firstPointOfContact.add(new SelectOption('First Parent', firstParentName));
        if(tempParentAccount.Related_Contact_Record_P2__c != null){
            firstPointOfContact.add(new SelectOption('Second Parent', secondParentName));
        }
        /*if(parentAccount.Primary_Contact__c == 'First Parent'){
            selectedFirstPointOfContact = tempParentAccount.Id;
        }else if(parentAccount.Primary_Contact__c == 'Second Parent'){
            selectedFirstPointOfContact = tempParentAccount.Additional_Parent__pc;
        }*/
    }
    
    public PageReference saveDetails(){
        try{
            if(parentAccount.PersonHasOptedOutOfEmail == true){
                parentAccount.Contact_Alternate_Email_Opt_Out__pc = true;
            }else{
                parentAccount.Contact_Alternate_Email_Opt_Out__pc = false;
            }
            //update account
            
            //update parentAccount;
            
            //list<Database.Saveresult> svResultList = DataBase.update(accList, false);
            Database.Saveresult svResult = DataBase.update(parentAccount, false);
            if(!svResult.isSuccess()){
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, svResult.getErrors()[0].getMessage());
                ApexPages.addMessage(errorMessage);
                return null;
            }
            //update contact
            if(parentContact != null){
                if(parentContact.HasOptedOutOfEmail == true){
                    parentContact.Contact_Alternate_Email_Opt_Out__c = true;
                }else{
                    parentContact.Contact_Alternate_Email_Opt_Out__c = false;
                }
                //update parentContact;
                Database.Saveresult svResultCon = DataBase.update(parentContact, false);
                if(!svResultCon.isSuccess()){
                    ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, svResultCon.getErrors()[0].getMessage());
                    ApexPages.addMessage(errorMessage);
                    return null;
                }
            }
            //update user
            //if(portalUser.UserPreferencesDisableAllFeedsEmail != doNotReceiveEmail){
                portalUser.UserPreferencesDisableAllFeedsEmail = doNotReceiveEmail;
                //update portalUser;
                Database.Saveresult svResultUser = DataBase.update(portalUser, false);
                if(!svResultUser.isSuccess()){
                    ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, svResultUser.getErrors()[0].getMessage());
                    ApexPages.addMessage(errorMessage);
                    return null;
                }
            //}
            
            PageReference pg =  new PageReference('/parents/PortalMyContactDetail');
            pg.setRedirect(true);
            pg.getParameters().put('s','1');
            return pg;
            
        }catch(Exception e){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Ooops something went wrong. Error Message: '+e.getMessage());
            ApexPages.addMessage(errorMessage);
        }
        return null;
    }

}