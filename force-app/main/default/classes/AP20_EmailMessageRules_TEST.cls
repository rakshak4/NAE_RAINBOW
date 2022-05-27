/**
 * @File Name          : AP20_EmailMessageRules_TEST.cls
 * @Description        : Test class for AP20_EmailMessageRules
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 09/12/2019, 12:34:46
 * @Modification Log   : 
 * Ver       Date            Author            Modification
 * ---    -----------       -------           ------------------------ 
 * 1.0    09/12/2019         CRA               Initial Version
 * ---    -----------       -------           ------------------------ 
**/
@isTest
public with sharing class AP20_EmailMessageRules_TEST {
    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
    static List<Opportunity> lstOpp;
    static Map<String,Id> mapRecordType;
    static List<EmailMessage> lstEMsgToUpdate;
    static List<School__c> lstSchool;

    static {
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('le cateau vert', 'St pierre', true, 'PPE')};
            insert lstSchool;

            lstAcc = new List<Account>{
                TestFactory.createAccount('test'),
                TestFactory.createAccount('test2')
            };
            insert lstAcc;

            lstContact = new List<Contact>{
                TestFactory.createContact('Smith', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            lstContact[0].FirstName = 'John';
            insert lstContact; 

            lstAcc[0].PrimaryContact__c = lstContact[0].Id;
            lstAcc[0].Name= 'John Smith Family';
            lstAcc[1].Name= 'John Smith Family';
            update lstAcc;

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('opptest', lstAcc[0].Id, AP_Constant.oppStageEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
            lstOpp[0].Child__c = lstContact[0].Id;
            insert lstOpp;

            lstEMsgToUpdate = new List<EmailMessage>{
                new EmailMessage(FromAddress = 'test@abc.org'
                                , ToAddress= 'test@xyz.org'
                                , Subject = 'Test email'
                                , HtmlBody = 'Test email body'
                                //, toIds = new String[] {lstContact[0].Id}
                                )
            };
        }
    }

    @isTest static void insertEmailMessageOppTest() {
        System.runAs(lstUser[0]) {
            lstEmsgToUpdate[0].RelatedToId = lstOpp[0].Id;

            Test.startTest();
            insert lstEmsgToUpdate;
            Test.stopTest();

            List<EmailMessage> lstEms = [SELECT RelatedToId FROM EmailMessage WHERE Id =: lstEmsgToUpdate[0].Id];
            System.assertEquals(lstAcc[0].Id, lstEms[0].RelatedToId);
        }
    }

     @isTest static void insertEmailMessageAccTest() {
        System.runAs(lstUser[0]) {
            lstEmsgToUpdate[0].RelatedToId = lstAcc[0].Id;

            Test.startTest();
            insert lstEmsgToUpdate;
            Test.stopTest();

            List<Account> lstAccount = [SELECT TECH_LastActivityDate__c FROM Account WHERE Id =: lstAcc[0].Id];
            System.assertEquals(true, lstAccount[0].TECH_LastActivityDate__c != null ? true : false);
        }
    }

    @isTest static void updateEmailMessagesTest() {
        System.runAs(lstUser[0]) {
            lstEmsgToUpdate[0].RelatedToId = lstAcc[0].Id;    
            insert lstEmsgToUpdate;

            lstEmsgToUpdate[0].HtmlBody = 'Test email body updated';            

            Test.startTest();
            update lstEmsgToUpdate;
            Test.stopTest();

            List<Account> lstAccount = [SELECT TECH_LastActivityDate__c FROM Account WHERE Id =: lstAcc[0].Id];
            System.assertEquals(true, lstAccount[0].TECH_LastActivityDate__c != null ? true : false);
        }       
    }
}