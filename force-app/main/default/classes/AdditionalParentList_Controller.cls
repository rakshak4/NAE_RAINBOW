public with sharing class AdditionalParentList_Controller {
    public list<Contact> additionalParentList {get;set;}
    public AdditionalParentList_Controller(ApexPages.StandardController controller) {
        additionalParentList =  new list<Contact>();
        //fetch additional parents 
        for(Contact c:[Select c.Staff_Member_Parent_Number_Formula__c, c.Contact_Relationship__c, c.Phone, c.xsms__Mobile_Phone_Country_Code__c, c.Name, c.MobilePhone, c.Main_Parent_File__c, c.Id, c.Email, c.Contact_Alternate_Phone__c, c.Contact_Alternate_Email__c, c.Contact_Alternate_Email_Opt_Out__c, c.AccountId From Contact c where Main_Parent_File__c =:controller.getId() AND RecordType.DeveloperName='Additional_Parent' order by Name]){
            additionalParentList.add(c);
        }
    }

}