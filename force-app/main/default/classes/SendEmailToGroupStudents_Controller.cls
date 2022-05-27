/**
    Author: Kunal Sharma
    Created Date: 07 Mar 2012
    Desc: VF controller used to send email to all students in a group.
**/
public with sharing class SendEmailToGroupStudents_Controller {
    private Id groupId ;
    private Group__c grp; 
    private String emailPageURLprefix ;
    public SendEmailToGroupStudents_Controller(ApexPages.StandardController controller) {
        groupId = controller.getId();
        grp =  [Select Id,Name from Group__c where Id=:groupId];
        
        emailPageURLprefix = '/_ui/core/email/author/EmailAuthor';
        
    }
   
    public PageReference reDirectToEmailPage(){ 
        //fetch all active student registration against selected group 
        String emailString ;
        Set<String> emailSet =  new Set<String>();
        for(Registration__c registration:[Select a.Student__r.Email, a.Student__r.Student_Email_Formula__c, a.Student__c, a.Id, a.Group__c, a.Active__c From Registration__c a where Active__c = true AND Group__c=:groupId order by Student__r.Name]){
            if(registration.Student__r.Student_Email_Formula__c != null && registration.Student__r.Student_Email_Formula__c != ''){
                emailSet.add(registration.Student__r.Student_Email_Formula__c);
                
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
        for(EmailTemplate e:[Select e.Name, e.Id, e.DeveloperName From EmailTemplate e where e.DeveloperName = 'Generic_Student_Email_Template']){
            templateId = e.Id;
        }
        //create pageReference
        //fetch current user's email
        String userEmail = [Select Id, Email from User where Id=:UserInfo.getUserId()].Email;
        
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