/***
    Author: Kunal 
    Created Date: 06 July 2013
    Desc: VF controller for PortalContact Page
***/
public class PortalContactPage_Controller extends PortalReportFilter {
    public Account parentAccount {get;set;}
    //constructor
    public  PortalContactPage_Controller(){
        parentAccount  = [Select a.Account_Alternate_Phone_Formula__c, a.Account_Mobile_Main_Phone_Formula__c, a.Account_Alternate_Email_Formula__c, a.Primary_Contact__c, a.Phone, a.PersonEmail, a.Second_Parent_Full_Name__c, a.First_Parent_Full_Name__c, a.Contact_Alternate_Phone__pc, a.Contact_Alternate_Email__pc, a.Account_Main_Email_Formula__c From Account a where a.Id=:parentAccountId];
    }
    
    public PageReference saveAccount(){
        try{
            //validate parent selection
            String message ;
            if(parentAccount.Primary_Contact__c == 'First Parent' && parentAccount.PersonEmail == null){
                message = 'Invalid input: Please provide main email for First Parent !';
            }else if(parentAccount.Primary_Contact__c == 'Second Parent' && parentAccount.Account_Main_Email_Formula__c == null){
                message = 'Invalid input: Please provide main email for Second Parent !';
            }
            if(message == null){
                update parentAccount;
                ApexPages.Message successMessage = new ApexPages.Message(ApexPages.severity.CONFIRM, 'Changes Saved. Thanks for updating your contact details.');
                ApexPages.addMessage(successMessage);
            }else{
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, message);
                ApexPages.addMessage(errorMessage);
            }
        }catch(Exception e){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Ooops something went wrong. Error Message: '+e.getMessage());
            ApexPages.addMessage(errorMessage);
        }
        return null;
    }
}