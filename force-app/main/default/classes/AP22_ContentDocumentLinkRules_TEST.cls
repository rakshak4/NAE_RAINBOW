/**
 * @File Name          : AP22_ContentDocumentLinkRules_TEST.cls
 * @Description        : Test class for ContentDocumentLink
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 04/07/2019, 17:19:05
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    04/07/2019, 15:16:18          CRA                     Initial Version
**/
@isTest
public with sharing class AP22_ContentDocumentLinkRules_TEST {
    static List<User> lstUser;
	static List<Account> lstAcc;
	static List<Contact> lstCon;
	static List<Opportunity> lstOpp;
	static List<School__c> lstSchool;
    static List<ApplicationDocument__c> lstAppDoc;
    static List<ContentVersion> lstCntVer = new List<ContentVersion>();
    static List<ContentDocumentLink> lstCntDocLink = new List<ContentDocumentLink>();
	static Map<String, Id> mapRecordType;

	static{
		lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
        	lstAcc = new List<Account>{
        		TestFactory.createAccount('test12')};
            lstAcc[0].OnlineApplication__c = true;
        	insert lstAcc;

        	lstSchool = new List<School__c>{
        		TestFactory.createSchool('le cateau vert', 'St pierre', true, 'PPE')};
        	insert lstSchool;
        	
        	mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        	lstCon = new List<Contact>{
        		TestFactory.createContact('testlastname', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),
                TestFactory.createContact('testlastname', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),
                TestFactory.createContact('testlastname', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
            };
            lstCon[0].FirstName = 'Child 1';
            lstCon[1].FirstName = 'Parent';
            lstCon[2].FirstName = 'Child 2';
        	insert lstCon;

            lstAppDoc = new list < ApplicationDocument__c > {
                TestFactory.createApplicationDoc('School Report Document', lstSchool[0].Id, true, AP_Constant.ledOriginApplication),
                TestFactory.createApplicationDoc('Official ID Document', lstSchool[0].Id, true, AP_Constant.ledOriginApplication)
            };
            insert lstAppDoc;
        	
        	lstOpp = new List<Opportunity>{
        		TestFactory.createOpportunity('opptest', lstAcc[0].Id, AP_Constant.oppStageNameApplication, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id),
                TestFactory.createOpportunity('opptest1', lstAcc[0].Id, AP_Constant.oppStageNameApplication, mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };

        	lstOpp[0].Child__c = lstCon[0].Id;
            lstOpp[0].LeadOrigin__c = AP_Constant.ledOriginApplication;
            lstOpp[1].Child__c = lstCon[2].Id;
            lstOpp[1].LeadOrigin__c = AP_Constant.ledOriginApplication;
        	insert lstOpp;	

            lstCntVer = new List<ContentVersion>{
                TestFactory.createContentVersion('Child_Child 1-testlastname_SchoolReportDocument.pdf'), //lstCon[0] + lstApp[0]
                TestFactory.createContentVersion('Parent_Parent-testlastname_OfficialIDDocument.pdf'), //lstCon[1] + lstApp[1]
                TestFactory.createContentVersion('Child_Child-testlastname1_SchoolReportDocument.pdf'), //wrong child name
                TestFactory.createContentVersion('Parent_Parent-testlastname_SchoolReportDocumentTest.pdf') //wrong file name
            };
            insert lstCntVer;			

            Map<Id, ContentVersion> mapContentVersion = new Map<Id, ContentVersion>([SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :lstCntVer]);

            lstCntDocLink = new List<ContentDocumentLink> {
                TestFactory.createContentDocumentLink(lstAcc[0].Id, mapContentVersion.get(lstCntVer[0].Id).ContentDocumentId),
                TestFactory.createContentDocumentLink(lstAcc[0].Id, mapContentVersion.get(lstCntVer[1].Id).ContentDocumentId),
                TestFactory.createContentDocumentLink(lstAcc[0].Id, mapContentVersion.get(lstCntVer[2].Id).ContentDocumentId),
                TestFactory.createContentDocumentLink(lstAcc[0].Id, mapContentVersion.get(lstCntVer[3].Id).ContentDocumentId)
            };
        }
	}

    @IsTest
    /**
    * @description Testing 1 child document, result 1 documentlink + 1 received Document Checklist; 
    *              The child document is reassociated to Child opportunity             
    * @author CRA | 04/07/2019
    * @return void
    */
    static void linkChildDocument(){
        Test.startTest();
        System.runAs(lstUser[0]){
            insert lstCntDocLink[0];
        }
        Test.stopTest();

        List<Id> lstIdToCheck = new List<Id> {lstOpp[0].Id, lstAcc[0].Id, lstOpp[1].Id};
        List<ContentDocumentLink> lstCdlTocheck = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :lstIdToCheck];
        System.assertEquals(1, lstCdlTocheck.size()); 
        System.assertEquals(lstOpp[0].Id, lstCdlTocheck[0].LinkedEntityId);

        List<DocumentChecklist__c> lstDchk =[SELECT Id, Name FROM DocumentChecklist__c WHERE Status__c =: AP_Constant.docChklstStatusSubmitted];
        System.assertEquals(1, lstDchk.size());
        System.assertEquals(lstAppDoc[0].Name, lstDchk[0].Name);
    }

    @IsTest
    /**
    * @description Testing 1 parent document, result 3 documentlink + 2 received document Checklist; 
    *              The parent document needs to be attached to all opportunities (1 document checklist and 1 document link each) and to Account (1 document link)
    * @author CRA | 04/07/2019
    * @return void
    */
    static void linkParentDocument(){

        Test.startTest();
        System.runAs(lstUser[0]){
            insert lstCntDocLink[1];
        }
        Test.stopTest();
        List<Id> lstIdToCheck = new List<Id> {lstOpp[0].Id, lstAcc[0].Id, lstOpp[1].Id};
        List<ContentDocumentLink> lstCdlTocheck = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :lstIdToCheck];
        
        System.assertEquals(3, lstCdlTocheck.size());

        List<DocumentChecklist__c> lstDchk =[SELECT Id, Name FROM DocumentChecklist__c WHERE Status__c =: AP_Constant.docChklstStatusSubmitted];
        System.assertEquals(2, lstDchk.size());
        System.assertEquals(lstAppDoc[1].Name, lstDchk[0].Name);
    }

     @IsTest
    /**
    * @description Testing 1 child document, result 1 documentlink; The child document is associated to a not existing child name
                   The document is remain associated to the account 
    * @author CRA | 04/07/2019
    * @return void
    */
    static void linkParentDocumentWithWrongChild(){

        Test.startTest();
        System.runAs(lstUser[0]){
            insert lstCntDocLink[2];
        }
        Test.stopTest();
        List<Id> lstIdToCheck = new List<Id> {lstOpp[0].Id, lstAcc[0].Id};
        List<ContentDocumentLink> lstCdlTocheck = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :lstIdToCheck];
        
        System.assertEquals(1, lstCdlTocheck.size());
        System.assertEquals(lstAcc[0].Id, lstCdlTocheck[0].LinkedEntityId);
    }

     @IsTest
    /**
    * @description Testing 1 parent document, result 3 documentlink + 0 received document checklist;
    *              The document is associated to all opportunities even if the Document is not in Document Checklist
    * @author CRA | 04/07/2019
    * @return void
    */
    static void linkParentDocumentWithWrongDoc(){

        Test.startTest();
        System.runAs(lstUser[0]){
            insert lstCntDocLink[3];
        }
        Test.stopTest();
        List<Id> lstIdToCheck = new List<Id> {lstOpp[0].Id, lstAcc[0].Id, lstOpp[1].Id};
        List<ContentDocumentLink> lstCdlTocheck = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :lstIdToCheck];
        
        System.assertEquals(3, lstCdlTocheck.size());

        List<DocumentChecklist__c> lstDchk =[SELECT Id, Name FROM DocumentChecklist__c WHERE Status__c =: AP_Constant.docChklstStatusSubmitted];
        System.assertEquals(0, lstDchk.size());
    }
}