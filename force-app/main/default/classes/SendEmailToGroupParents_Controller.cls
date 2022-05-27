/**
    Author: Kunal Sharma
    Created Date: 07 Mar 2012
    Desc: VF controller used to send email to all active students parent's in a group.
**/
public with sharing class SendEmailToGroupParents_Controller {

    private Id groupId ;
    private Group__c grp;
    private String emailPageURLprefix ;
    public SendEmailToGroupParents_Controller(ApexPages.StandardController controller) {
        groupId = controller.getId();
        grp =  [Select Id,Name from Group__c where Id=:groupId];
        
        emailPageURLprefix = '/_ui/core/email/author/EmailAuthor';
        
    }
    
    public PageReference reDirectToEmailPage(){
        //fetch all active student registration against selected group
        String emailString ;
        Set<String> emailSet =  new Set<String>();
        Set<Id> parentIds =  new Set<Id>();
        for(Registration__c registration:[Select a.Student__r.Main_Parent_File__c, a.Student__r.Primary_Parent_Email__c ,a.Student__c, a.Id, a.Group__c, a.Active__c From Registration__c a where Active__c = true AND Group__c=:groupId order by Student__r.Name]){
            //if(registration.Student__r.Primary_Parent_Email__c != null && registration.Student__r.Primary_Parent_Email__c != ''){
                //emailSet.add(registration.Student__r.Primary_Parent_Email__c);
                parentIds.add(registration.Student__r.Main_Parent_File__c);
            //}
        }
        
        for(Account acc:[Select a.PrimaryContactEmail__c, a.PersonEmail, a.PersonHasOptedOutOfEmail ,(Select Email, HasOptedOutOfEmail From Emails__r where  HasOptedOutOfEmail = false AND RecordType.DeveloperName != 'Student') From Account a where a.Id IN:parentIds]){
            //if(acc.PrimaryContactEmail__c != null && acc.PrimaryContactEmail__c != ''){
                //emailSet.add(acc.PrimaryContactEmail__c);
            //}
            if(acc.PersonHasOptedOutOfEmail == false && acc.PersonEmail != null){
                emailSet.add(acc.PersonEmail);
            }
            //fetch from mass email records
            for(Contact c:acc.Emails__r){
                if(c.Email != null){
                    emailSet.add(c.Email);
                }
            } 
        }
        
        for(String email:emailSet){
            if(emailString == null){
                emailString = email;
            }else{
                emailString += ';'+email;
            }
        }
        //fetch email template 
        Id templateId ; 
        for(EmailTemplate e:[Select e.Name, e.Id, e.DeveloperName From EmailTemplate e where e.DeveloperName = 'Generic_Parent_Email_Template']){
            templateId = e.Id;
        }
        //fetch current user's email
        String userEmail = [Select Id, Email from User where Id=:UserInfo.getUserId()].Email;
        //create pageReference
        PageReference pg =  new PageReference(emailPageURLprefix);
        pg.getParameters().put('p24',userEmail);
        pg.getParameters().put('p5',emailString);
        pg.getParameters().put('p3_lkid',groupId);
        pg.getParameters().put('p3',grp.Name);
        if(templateId != null){
            pg.getParameters().put('template_id',templateId);
        }
        pg.getParameters().put('retURL','/'+groupId);
        return pg;
        
    }
     
}