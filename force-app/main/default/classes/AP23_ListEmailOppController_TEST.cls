/**
 * @File Name          : AP23_ListEmailOppController_TEST.cls
 * @Description        : Test Class for AP23_ListEmailOppController
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 12/12/2019, 10:24:07
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    12/12/2019          CRA                   Initial Version
**/
@isTest
public with sharing class AP23_ListEmailOppController_TEST {
    static User testUserAdmin;
    static List<Account> lstAccount;
    static List<Contact> lstContact;
    static List<Opportunity> lstOpp;   
    static List<School__c> lstSchool;
    static List<EmailTemplate> lstEmailTemplate;
    static Map<string,Id> mapRecordType = new Map<String, Id>();

    static{
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        testUserAdmin.SchoolCode__c = 'TST';
        insert testUserAdmin;

        System.runAs(testUserAdmin){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('TestUser1', 'Mauritius', false, 'TST'),
                TestFactory.createSchool('TestUser2', 'Mauritius', false, 'LOL')
            };
            insert lstSchool;

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject, AP_Constant.accObject});

            lstAccount = new List<Account> {
                 TestFactory.createAccount('testAcc1')
                ,TestFactory.createAccount('testAcc2')
            };
            lstAccount[0].Email__c = 'test@testAcc1Email.com';
            lstAccount[0].Phone = '55555555555';
            lstAccount[1].Email__c = 'test@testAcc2Email.com';
            lstAccount[1].Phone = '22222222222';
            insert lstAccount;

            //creating primary contact in account
            lstContact = new List<Contact>{
                TestFactory.createContact('parent1', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //0
                ,TestFactory.createContact('parent2', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //1
                ,TestFactory.createContact('child1', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))   //2
                ,TestFactory.createContact('child2', lstAccount[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))   //3
                ,TestFactory.createContact('parent1Acc2', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //4
                ,TestFactory.createContact('parent2Acc2', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)) //5
                ,TestFactory.createContact('child1Acc2', lstAccount[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))   //6
            };
            lstContact[0].Email = 'test@test.com';
            insert lstContact;

            lstAccount[0].PrimaryContact__c = lstContact[0].Id;
            update lstAccount;

            lstOpp = new List<Opportunity> {
                TestFactory.createOpportunity('child1 opp', lstAccount[0].Id, AP_Constant.oppStageNameEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
                ,TestFactory.createOpportunity('child2 opp', lstAccount[0].Id, AP_Constant.oppStageNameEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
                ,TestFactory.createOpportunity('child1Acc2 opp', lstAccount[1].Id, AP_Constant.oppStageNameEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
            lstOpp[2].SampleRichText__c = 'test';
            insert lstOpp;

            lstEmailTemplate = new List<EmailTemplate>{
                new EmailTemplate(isActive = true, Name = 'testTemplate', DeveloperName = 'testTemplate' + System.now().getTime(), TemplateType = 'text', FolderId = UserInfo.getUserId(), Subject = 'Your Subject Here')
            };
            insert lstEmailTemplate;
        }
    }
    
    @isTest
    static void testListEmailOpp(){        
        List<EmailTemplate> lstEmailTemp = new List<EmailTemplate>();
        System.runAs(testUserAdmin){
            Test.startTest();
            lstEmailTemp = AP23_ListEmailOppController.getTemplates();
            Test.stopTest();
        }

        System.assertEquals(true, lstEmailTemp.size() > 0 ? true : false);
    }

    @IsTest
    static void testGetAccountsOfOpportunity(){        
        System.runAs(testUserAdmin){  
            List<Account> lstAccRes = new List<Account>();
            Test.startTest();
            lstAccRes = AP23_ListEmailOppController.getAccountsOfOpportunity((String) lstAccount[0].Id);
            Test.stopTest();

            System.assertEquals(1, lstAccRes.size());
        }        
    }

    @IsTest
    static void testGetTemplateDetails(){
        EmailTemplate emailTemplateRes;
        System.runAs(testUserAdmin){
            Test.startTest();
            emailTemplateRes = AP23_ListEmailOppController.getTemplateDetails(lstEmailTemplate[0].Id);
            Test.stopTest();
        }
        System.assertEquals(true, emailTemplateRes != null ? true : false);
    }

    @IsTest
    static void testSendAnEmailMsgSuccess(){
        System.runAs(testUserAdmin){
            Test.startTest();
            AP23_ListEmailOppController.sucesMsg message = AP23_ListEmailOppController.sendAnEmailMsg(lstEmailTemplate[0].Id, lstOpp[0], 'test email', new String[] {lstOpp[0].Id, lstOpp[1].Id});
            AP23_ListEmailOppController.sucesMsg message2 = AP23_ListEmailOppController.sendAnEmailMsg(lstEmailTemplate[0].Id, lstOpp[0], 'test email', null );
            AP23_ListEmailOppController.sucesMsg message3 = AP23_ListEmailOppController.sendAnEmailMsg(lstEmailTemplate[0].Id, lstOpp[2], 'test email', new String[] {lstOpp[2].Id});
            Test.stopTest();

            System.assertEquals(true, message.isSuccess);
            System.assertEquals(true, message2.isSuccess);
            System.assertEquals(true, message3.isSuccess);
        }
    }

}