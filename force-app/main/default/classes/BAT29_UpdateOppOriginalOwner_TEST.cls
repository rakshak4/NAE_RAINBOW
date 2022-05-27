/**
 * @description       : BAT29 Test Class
 * @author            : Spoon Consulting
 * @group             : 
 * @last modified on  : 02-12-2021
 * @last modified by  : Spoon Consulting
 * Modifications Log 
 * Ver   Date         Author             Modification
 * 1.0   02-12-2021   YRA                Initial Version
**/
@isTest
public with sharing class BAT29_UpdateOppOriginalOwner_TEST {
    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Opportunity> lstOpp;
    static List<School__c> lstSchool;
    static Map<String,Id> mapRecordType;

    static {
        //creating user
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject});
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId()),
                                TestFactory.createUser('Test2', TestFactory.getProfileAdminId())
        };
        insert lstUser;
        
        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('TestSchool', 'Mauritius', false, 'TST')
            };
            lstSchool[0].AdmissionsQueueCoordinator__c = lstUser[0].Id;
            insert lstSchool;
            //creating account
            lstAcc = new List<Account>{TestFactory.createAccount('test')};
            insert lstAcc;
            //creating opportunity
            lstOpp= new List<Opportunity>{
                TestFactory.createOpportunity('testopp1', lstAcc[0].Id, AP_Constant.oppStageEnquiry,mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id),
                TestFactory.createOpportunity('testopp2', lstAcc[0].Id, AP_Constant.oppStageEnquiry,mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
			lstOpp[0].OwnerId =lstUser[0].Id;
            lstOpp[1].OwnerId =lstUser[0].Id;
			lstOpp[1].OriginalOwner__c =lstUser[1].Id;
            insert lstOpp;    
        }
    }
	
	@isTest
    static void testUpdateOriginalOwnerField(){
	    System.runAs(lstUser[0]) {
            Test.StartTest();  
            BAT29_UpdateOppOriginalOwner batchObj = new BAT29_UpdateOppOriginalOwner();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();
            List<Opportunity> lstUpdatedOpp = [SELECT  id,OwnerId, OriginalOwner__c FROM Opportunity];
            System.assertEquals(lstUpdatedOpp[0].OriginalOwner__c,lstOpp[0].OwnerId);   
	    }
    }

    @isTest
    static void testUpdateOriginalOwnerField2(){
	    System.runAs(lstUser[0]) {
            Test.StartTest();  
            BAT29_UpdateOppOriginalOwner batchObj = new BAT29_UpdateOppOriginalOwner();
            Database.executeBatch(batchObj , 10);
            Test.StopTest();
            List<Opportunity> lstUpdatedOpp = [SELECT  id,OwnerId, OriginalOwner__c FROM Opportunity];
            System.assertEquals(lstUpdatedOpp[1].OriginalOwner__c,lstUser[1].Id);   
	    }
    }

}