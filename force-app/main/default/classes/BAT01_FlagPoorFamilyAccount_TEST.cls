/**
 * @author 	SC 
 * @version 1.0
 * @since	15/10/2018
 *
 * Description : This class tests the batch BAT01_FlagPoorFamilyAccount
 *                           
 *-- Maintenance History: 
 *--
 *-- Date         Name  Version  Remarks 
 *-- -----------  ----  -------  ------------------------
 *-- 15-10-2018   CRA    1.0     Initial version
 *-------------------------------------------------------
 * 
 */
@isTest
private class BAT01_FlagPoorFamilyAccount_TEST {
	static List<User> lstUser;
	static List<Account> lstAcc;
	static List<Contact> lstCon;
	static List<Opportunity> lstOpp;
	static List<School__c> lstSchool;
	static Map<String, Id> mapRecordType;

	static{
		lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
        	lstAcc = new List<Account>{
        		new Account(Name = 'Family Sam', MidTierAccountID__c = 'test'),
        		new Account(Name = 'Family Jhon', MidTierAccountID__c = 'test1'),
        		new Account(Name = 'Family Harvey', MidTierAccountID__c = 'test2'),
        		new Account(Name = 'Family Tom', MidTierAccountID__c = 'test3'),
        		new Account(Name = 'Family Shang', MidTierAccountID__c = 'test4'),
        		new Account(Name = 'Family Yves', MidTierAccountID__c = 'test5')
        	};
        	insert lstAcc;

        	lstSchool = new List<School__c>{
        		TestFactory.createSchool('le cateau vert', 'St pierre', true, 'PPE')
        	};
        	insert lstSchool;
        	
        	mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

        	lstCon = new List<Contact>{
        		new Contact(LastName = '*', FirstName = 'Bryan', MobilePhone = null, Email = null, Phone = null, AccountId = lstAcc[1].Id, RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeChild)),
        		new Contact(LastName = 'Jhon', FirstName = 'Unknown', MobilePhone = null, Email = null, Phone = null, AccountId = lstAcc[1].Id, RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeParent)),
        		new Contact(LastName = 'Unknown', FirstName = null, MobilePhone = null, Email = null, Phone = null, AccountId = lstAcc[2].Id, RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeParent)),
        		new Contact(LastName = '-', FirstName = null, MobilePhone = '123', Email = 'test@test.te', Phone = null, AccountId = lstAcc[0].Id, RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeChild)),
        		new Contact(LastName = 'Ella', FirstName = 'Tom', MobilePhone = null, Email = null, Phone = null, AccountId = lstAcc[3].Id, RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeParent)),
        		new Contact(LastName = 'Harry', FirstName = 'Tom', MobilePhone = '123', Email = 'test@test.te', Phone = null, AccountId = lstAcc[3].Id, RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeParent)),
        		new Contact(LastName = 'Lee', FirstName = 'Shang', MobilePhone = null, Email = null, Phone = null, AccountId = lstAcc[4].Id, RecordTypeId = mapRecordType.get(AP_Constant.conRecordTypeParent))
        	};
        	insert lstCon;
        	
        	lstOpp = new List<Opportunity>{
        		new Opportunity(Name = '* Bryan', 
			        			AccountId = lstAcc[1].Id, 
			        			StageName = AP_Constant.oppStageEnquiry, 
			        			RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeEnrolment),
			        			SchoolOfInterest__c = lstSchool[0].Id, 
			        			CloseDate = Date.newInstance(2010, 12, 22),
			        			ReferredByContact__c = null, 
			        			ReferredBy__c = null, 
			        			RelatedAccount__c = null
        		),
        		new Opportunity(Name = 'Jhon Unknown', 
			        			AccountId = lstAcc[1].Id, 
			        			StageName = AP_Constant.oppStageEnquiry, 
			        			RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeEnrolment),
			        			SchoolOfInterest__c = lstSchool[0].Id, 
			        			CloseDate = Date.newInstance(2010, 12, 22),
			        			ReferredByContact__c = null, 
			        			ReferredBy__c = null, 
			        			RelatedAccount__c = null
        		),
        		new Opportunity(Name = 'Unknown', 
			        			AccountId = lstAcc[2].Id, 
			        			StageName = AP_Constant.oppStageEnquiry, 
			        			RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeEnrolment),
			        			SchoolOfInterest__c = lstSchool[0].Id, 
			        			CloseDate = Date.newInstance(2010, 12, 22),
			        			ReferredByContact__c = lstCon[0].Id, 
			        			ReferredBy__c = null, 
			        			RelatedAccount__c = null
        		),
        		new Opportunity(Name = '-', 
			        			AccountId = lstAcc[0].Id, 
			        			StageName = AP_Constant.oppStageEnquiry, 
			        			RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeEnrolment),
			        			SchoolOfInterest__c = lstSchool[0].Id, 
			        			CloseDate = Date.newInstance(2010, 12, 22),
			        			ReferredByContact__c = null, 
			        			ReferredBy__c = null, 
			        			RelatedAccount__c = null
        		),
        		new Opportunity(Name = 'Tom Harry', 
			        			AccountId = lstAcc[3].Id, 
			        			StageName = AP_Constant.oppStageEnquiry, 
			        			RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeEnrolment),
			        			SchoolOfInterest__c = lstSchool[0].Id, 
			        			CloseDate = Date.newInstance(2010, 12, 22),
			        			ReferredByContact__c = lstCon[3].Id, 
			        			ReferredBy__c = null, 
			        			RelatedAccount__c = null
        		),
        		new Opportunity(Name = 'Ella Harry', 
			        			AccountId = lstAcc[3].Id, 
			        			StageName = AP_Constant.oppStageEnquiry, 
			        			RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeEnrolment),
			        			SchoolOfInterest__c = lstSchool[0].Id, 
			        			CloseDate = Date.newInstance(2010, 12, 22),
			        			ReferredByContact__c = lstCon[4].Id, 
			        			ReferredBy__c = null, 
			        			RelatedAccount__c = null
        		),
        		new Opportunity(Name = 'Lee Shang', 
			        			AccountId = lstAcc[4].Id, 
			        			StageName = AP_Constant.oppStageEnquiry, 
			        			RecordTypeId = mapRecordType.get(AP_Constant.oppRecordTypeEnrolment),
			        			SchoolOfInterest__c = lstSchool[0].Id, 
			        			CloseDate = Date.newInstance(2010, 12, 22),
			        			ReferredByContact__c = lstCon[5].Id, 
			        			ReferredBy__c = null, 
			        			RelatedAccount__c = null
        		)

        	};
        	insert lstOpp;								
        }
    }


    @isTest
    public static void flagPoorFamilyAccountTest(){
    	lstAcc[2].PoorDataQuality__c = false;
    	Test.startTest();
    	update lstAcc;
    	BAT01_FlagPoorFamilyAccount flagPoorFamilyAcc = new BAT01_FlagPoorFamilyAccount();
    	Id batchId = Database.executeBatch(flagPoorFamilyAcc);
    	Test.stopTest();

    	List<Account> lstAccResult = [SELECT Name, PoorDataQuality__c FROM Account];
    	List<Account> lstAccPoorFamily = [SELECT Name, PoorDataQuality__c FROM Account where PoorDataQuality__c = true];

    	System.assertEquals(true, lstAccResult[0].PoorDataQuality__c);
    	System.assertEquals(true, lstAccResult[1].PoorDataQuality__c);
    	System.assertEquals(false, lstAccResult[2].PoorDataQuality__c);
    	System.assertEquals(false, lstAccResult[3].PoorDataQuality__c);
    	System.assertEquals(false, lstAccResult[4].PoorDataQuality__c);
    	System.assertEquals(false, lstAccResult[5].PoorDataQuality__c);
    	System.assertEquals(2, lstAccPoorFamily.size());
    }

    static testMethod void testSchedulePass() {
		Test.startTest();
		for (CronTrigger c: [Select Id From CronTrigger Where CronJobDetailId IN(Select Id From CronJobDetail WHERE
			JobType = '7')]) {
			System.abortJob(c.id);
		}       
		BAT01_FlagPoorFamilyAccount flagPoorFamilyAcc = new BAT01_FlagPoorFamilyAccount();
		String cronStr7 = '0 0 6 * * ? '; 
		Id jobId = System.schedule('Test schedule batch', cronStr7, flagPoorFamilyAcc);        
	    CronTrigger ct = [Select Id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where Id = : jobId];
	    Test.stopTest();
	    System.assertEquals(0, ct.TimesTriggered);
	}

}