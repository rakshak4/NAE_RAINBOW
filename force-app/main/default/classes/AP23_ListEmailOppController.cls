/**
 * @File Name          : AP23_ListEmailOppController.cls
 * @Description        : - Get Template mail
                         - Get mail Adress
                         - Send Email
                         - 
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : ZHR
 * @Last Modified On   : 10/07/2019, 19:07:21
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author                    Modification
 *==============================================================================
 * 1.0    10/07/2019, 14:59:46           ZHR                     Initial Version
**/
public class AP23_ListEmailOppController {
    @AuraEnabled
    public static list<EmailTemplate> getTemplates(){
        list<EmailTemplate> emailTemp = new list<EmailTemplate>();
        emailTemp = [SELECT Id, Name, Subject,Folder.DeveloperName, TemplateType FROM EmailTemplate where Folder.DeveloperName = 'NAE'];
        return emailTemp;
    }
    
    @AuraEnabled 
    public static list<Account> getAccountsOfOpportunity(string accIds){
        list<string> accIdsList = string.isNotBlank(accIds) ? accIds.split(',') : new list<string>();
        list<Account> accRecords = accIdsList.size()>0 ? [SELECT Id, Name, Email__c FROM Account WHERE ID IN:accIdsList] : new list<Account>();        
        return accRecords;
    }
    @AuraEnabled 
    public static EmailTemplate getTemplateDetails(string templteId){
        
        EmailTemplate emailTemp = new EmailTemplate();
        list<EmailTemplate> emailTempLst = new list<EmailTemplate>();
        emailTempLst = [SELECT Id, Name, Subject, TemplateType, body FROM EmailTemplate WHERE ID =: templteId];
        
        emailTemp = emailTempLst.size()>0 ? emailTempLst[0] : emailTemp;
        return emailTemp;
        
    }
    
    @AuraEnabled
    public static sucesMsg sendAnEmailMsg(string templateId, opportunity opty, string subj, string [] oppIds){
        System.debug('#### Début sendAnEmailMsg ####');
        try {
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            list<Opportunity> oppList = new list<Opportunity>();
            list<string> oppIdList = oppIds != null && oppIds.size() > 0 ? oppIds : new list<string>();
            
            system.debug('---templateId--- ' + templateId);
            system.debug('---oppIdList--- ' + oppIdList);
            
            if(oppIdList.size()>0)
            {
                oppList = [select id, AccountId, Account.Email__c, Account.PrimaryContact__c from Opportunity WHERE ID IN: oppIdList];

                for(opportunity oppRec : oppList) {                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    
                    if(string.isNotBlank(templateId) && oppRec.Account.PrimaryContact__c != null) {
                        String accid = oppRec.AccountId;
                        mail.setTemplateId(ID.valueOf(templateId));
                        mail.setTargetObjectId(oppRec.Account.PrimaryContact__c);
                        mail.saveAsActivity=true;
                        mail.setWhatId(oppRec.id); 
                        mails.add(mail);
                    }
                    else if (string.isNotBlank(opty.SampleRichText__c) && oppRec.Account.Email__c != null) {
                        mail.setSubject(string.isNotBlank(subj) ? subj : '');
                        List<String> sendTo = new List<String>();
                        sendTo.add(oppRec.Account.Email__c);
                        mail.setToAddresses(sendTo);
                        mail.setHtmlBody(opty.SampleRichText__c);
                        mail.saveAsActivity=true;
                        mail.setWhatId(oppRec.id);
                        mails.add(mail);
                    }                    
                    
                }
            }
            /*test*/
            
            if(mails.size()>0) {
                
                try {                    
                    Messaging.sendEmail(mails);
                    return new sucesMsg(true, 'Success!');
                    
                } catch(Exception e) {
                    system.debug('*************--Exception @SendEmail method ---*********');
                    System.debug('****--Exception type caught: ' + e.getTypeName());    
                    System.debug('****--Message: ' + e.getMessage());    
                    System.debug('****--Cause: ' + e.getCause());    
                    System.debug('****--Line number: ' + e.getLineNumber());    
                    System.debug('****--Stack trace: ' + e.getStackTraceString());    
                    
                    return new sucesMsg(false, e.getMessage()+' - '+e.getCause()+' - '+e.getStackTraceString()+' - '+e.getLineNumber());
                }
            }
            return new sucesMsg(true, 'Success!');
        }
        catch(Exception e) {
            system.debug('*************--Exception @sendAnEmailMsg method ---*********');
            System.debug('****--Exception type caught: ' + e.getTypeName());    
            System.debug('****--Message: ' + e.getMessage());    
            System.debug('****--Cause: ' + e.getCause());    
            System.debug('****--Line number: ' + e.getLineNumber());    
            System.debug('****--Stack trace: ' + e.getStackTraceString());    
            
            return new sucesMsg(false, e.getMessage()+' - '+e.getCause()+' - '+e.getStackTraceString()+' - '+e.getLineNumber());
        }
    }    
    
    public class sucesMsg {
        
        @AuraEnabled public boolean isSuccess;
        @AuraEnabled public string errMsg;
        
        public sucesMsg(boolean isSuccess, string errMsg){
            this.isSuccess = isSuccess;
            this.errMsg = errMsg;
        }
        
    }
}