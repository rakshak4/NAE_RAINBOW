/**
 * @File Name          : AP23_ListEmailOpportunity_TEST.cls
 * @Description        : Test Class for AP23_ListEmailOpportunity
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 12/12/2019, 12:47:56
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    12/12/2019         CRA                    Initial Version
**/
@isTest
public with sharing class AP23_ListEmailOpportunity_TEST {
    static User testUserAdmin;
    static List<Account> lstAccount;
    static List<Contact> lstContact;
    static List<Opportunity> lstOpp;   
    static List<School__c> lstSchool;
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
            insert lstAccount;

            lstOpp = new List<Opportunity> {
                TestFactory.createOpportunity('child1 opp', lstAccount[0].Id, AP_Constant.oppStageNameEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
                ,TestFactory.createOpportunity('child2 opp', lstAccount[0].Id, AP_Constant.oppStageNameEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
                ,TestFactory.createOpportunity('child1Acc2 opp', lstAccount[1].Id, AP_Constant.oppStageNameEnquiry, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
            insert lstOpp;
        }
    }

    @IsTest
    static void testPage(){
        System.runAs(testUserAdmin){
            List<Opportunity> lstOppRes = [SELECT id, AccountId, Name FROM Opportunity];
            Test.startTest();
            Pagereference testPage = Page.VFP23_ListEmail;
            Test.setCurrentPage(testPage);
            //Apexpages.currentPage().getParameters().put('id', lstOpp[0].Id);
            ApexPages.StandardSetController pageCtrl = new ApexPages.StandardSetController(lstOppRes);
            pageCtrl.setSelected(lstOppRes);
            AP23_ListEmailOpportunity controller = new AP23_ListEmailOpportunity(pageCtrl);
            PageReference pageRes = controller.doSomething();
            Test.stopTest();

            System.assertEquals(null, pageRes);
        }
    }
}