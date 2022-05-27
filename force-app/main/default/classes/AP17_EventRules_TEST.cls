/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for AP17_EventRules
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 05-Nov-2018  AMU    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public class AP17_EventRules_TEST {
	static List<User> lstUser;
	static List<Event> lstEvents;
    static List<Account> lstAcc;
    static List<Opportunity> lstOpp;  
    static List<School__c> lstSchool; 
    static Map<string,Id> mapRecordType;

    static {
    	mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        lstUser = new List<User>{TestFactory.createUser('TestUserAd', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
        	lstSchool = new List<School__c>{
                TestFactory.createSchool('TestUser1', 'Mauritius', false, 'TST')
            };
            insert lstSchool;

        	lstAcc = new List<Account>{
                TestFactory.createFamilyAccount('Acc')
            };
            insert lstAcc;

        	lstEvents = new List<Event>{
                TestFactory.createEvent('event1', 10, Datetime.newInstanceGmt(2018, 8, 1)),
                TestFactory.createEvent('event2', 15, Datetime.newInstanceGmt(2019, 8, 1))
            };
            lstEvents[0].whatid = lstAcc[0].Id;
            lstEvents[1].whatid = lstAcc[0].Id;
            insert lstEvents;

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testOpp01', lstAcc[0].Id, AP_Constant.oppStageNameActive,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
            insert lstOpp;
        }
    }

    @isTest public static void updateLastVisitDateTest(){
    	System.runAs(lstUser[0]){
    		test.startTest();
    			lstEvents[0].Status__c = AP_Constant.tskStatusCompleted;
    			lstEvents[1].Status__c = AP_Constant.tskStatusCompleted;
    			update lstEvents;
    		test.stopTest();
    	}
    }
}