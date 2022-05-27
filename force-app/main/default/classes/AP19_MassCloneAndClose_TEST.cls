/**
 * @File Name          : AP19_MassCloneAndClose_TEST.cls
 * @Description        : Test Class for AP19_MassCloneAndClose
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 19/12/2019, 14:54:43
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    19/12/2019         CRA                    Initial Version
**/
@isTest
public with sharing class AP19_MassCloneAndClose_TEST {
    static List<Opportunity> lstOpp;
    static List<Account> lstAcc;
    static List<User> lstUser;
    static List<School__c> lstSchool;
    static List<Contact> lstContact;
    static Map<string,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.conObject, AP_Constant.oppObject});
    static List<ApplicationDocument__c> lstAppDoc;

    static {
        lstUser = new List<User>{TestFactory.createUser('TestUserAd', TestFactory.getProfileAdminId())};
        lstUser[0].SchoolCode__c = 'XXX';
        insert lstUser;
        
        System.runAs(lstUser[0]){
            //creating school
            lstSchool = new List<School__c> {
                TestFactory.createSchool('testSchool', 'Port Louis', true, 'XXX')
            };
            insert lstSchool;

            lstAcc = new List<Account> {
                TestFactory.createAccount('testAcc')
                , TestFactory.createAccount('testAcc1')
            };
            lstAcc[0].SchoolOfInterest__c = lstSchool[0].Id;
            lstAcc[1].SchoolOfInterest__c = lstSchool[0].Id;
            insert lstAcc;

            //creating primary contact in account for opportunity
            lstContact = new List<Contact>{
                TestFactory.createContact('parent1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent))
                ,TestFactory.createContact('child1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                ,TestFactory.createContact('child2', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            insert lstContact; 
            
            lstAcc[0].PrimaryContact__c = lstContact[0].Id;
            update lstAcc; 

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testOpp01', lstAcc[0].Id, AP_Constant.oppStageNameVisit,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp02', lstAcc[0].Id, AP_Constant.oppStageNameAcceptance,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
            lstOpp[0].Child__c = lstContact[1].Id;
            lstOpp[1].Child__c = lstContact[2].Id;
            insert lstOpp;

            lstAppDoc = new List<ApplicationDocument__c> {
                TestFactory.createApplicationDoc('Birth Certificate', lstSchool[0].Id, true, 'Application'), //PVS //Document checklist order : 1
                TestFactory.createApplicationDoc('Transcript', lstSchool[0].Id, false, 'Acceptance') 
            };
            insert lstAppDoc;

            ContentVersion cv = new ContentVersion(
                Title = 'Test',
                PathOnClient = 'Test.jpg',
                VersionData = blob.valueof('Test Content Data'));
            insert cv;

            ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
            ContentDocumentLink contentlink=new ContentDocumentLink();
            contentlink.LinkedEntityId=lstOpp[0].id;  
            contentlink.ShareType= 'I';               
            contentlink.ContentDocumentId=documents[0].Id;
            contentlink.Visibility = 'AllUsers'; 
            insert contentlink;

        }
    }

    @isTest static void actiontest() {
        System.runAs(lstUser[0]) {
            Test.startTest();
            PageReference pageRef = Page.VFP19_MassCloneAndClose;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardSetController oppController = new ApexPages.StandardSetController(lstOpp);
            oppController.setSelected(lstOpp);
            AP19_MassCloneAndClose controller = new AP19_MassCloneAndClose(oppController);
            PageReference pageRes = controller.doAction();
            PageReference pageRes1 = controller.cancel();
            PageReference pageRes2 = controller.MassClone();
            Test.stopTest();
        }
    }

    @isTest static void clonetest() {
        System.runAs(lstUser[0]) {
            Test.startTest();
            PageReference pageRef = Page.VFP19_MassCloneAndClose;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardSetController oppController = new ApexPages.StandardSetController(lstOpp);
            oppController.setSelected(lstOpp);
            AP19_MassCloneAndClose controller = new AP19_MassCloneAndClose(oppController);
            controller.stageName = AP_Constant.oppStageNameLost;
            controller.Lost_Reason_Description = 'Lost';
            Boolean res = controller.clone(JSON.serialize(lstOpp));
            Test.stopTest();
        }
    }
}