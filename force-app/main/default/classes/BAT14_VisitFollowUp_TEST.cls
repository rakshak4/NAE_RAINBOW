/**
 * @File Name          : BAT14_VisitFollowUp_TEST.cls
 * @Description        : Test class for BAT14_VisitFollowUp
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 23/06/2020, 14:09:15
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    23/06/2020           CRA                  Initial Version
**/
@isTest
public with sharing class BAT14_VisitFollowUp_TEST {
    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Contact> lstCon;
    static List<Opportunity> lstOpp;
    static List<School__c> lstSchool;       
    static List<Task> lstTask;   
    static List<Event> lstEvent;  
    static List<EmailMessage> lstEmsg; 
    static Map<String,Id> mapRecordType;  
    static {
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;
        
        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST')
            };
            lstSchool[0].BedrockSchool__c = true;
            lstSchool[0].OptIn24hrVisit__c = true;
            insert lstSchool;

            lstAcc = new List<Account>{
                TestFactory.createAccount('Family 1')
                , TestFactory.createAccount('Family 2')
            };
            lstAcc[0].SchoolOfInterest__c = lstSchool[0].Id;
            lstAcc[1].SchoolOfInterest__c = lstSchool[0].Id;
            insert lstAcc;

            lstCon = new List<Contact> {
                TestFactory.createContact('Jones Fam1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)),//0
                TestFactory.createContact('Junior Fam1', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),//1
                TestFactory.createContact('Paul Fam2', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeParent)), //2             
                TestFactory.createContact('Joe Fam2', lstAcc[1].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))   //3
            };
            insert lstCon;

            lstOpp = new List<Opportunity> {
                TestFactory.createOpportunity('Junior Fam1 - Enrolment', lstAcc[0].Id, AP_Constant.oppStageNameEnquiry,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id), 
                TestFactory.createOpportunity('Joe Fam2 - Enrolment', lstAcc[1].Id, AP_Constant.oppStageNameEnquiry,
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
            };
            // lstOpp[0].Child__c = lstCon[1].Id;
            // lstOpp[1].Child__c = lstCon[3].Id;
            insert lstOpp;

            lstTask = new List<Task> {
                TestFactory.createTask('Activity in past for fam1'),
                TestFactory.createTask('Activity in past for fam2')
            };

            lstTask[0].WhatId = lstAcc[0].id;
            lstTask[0].isAutomated__c = false;
            lstTask[0].Status = 'Open';
            lstTask[0].ActivityDate = System.now().date() - 4;

            lstTask[1].WhatId = lstAcc[1].id;
            lstTask[1].isAutomated__c = false;
            lstTask[1].Status = 'Open';
            lstTask[1].ActivityDate = System.now().date() - 2 ;

            insert lstTask;

            lstEvent = new List<Event> {
                TestFactory.createEvent('Visit', 15, System.now().date() - 10)
                , TestFactory.createEvent('Visit', 15, System.now().date() - 10)
            };

            lstEvent[0].Type = '1 on 1 visit';
            lstEvent[0].Status__c = 'Completed';
            lstEvent[0].WhatId = lstAcc[0].Id;

            lstEvent[1].Type = '1 on 1 visit';
            lstEvent[1].Status__c = 'Completed';
            lstEvent[1].WhatId = lstAcc[1].Id;

            insert lstEvent;

            lstEmsg = new List<EmailMessage>{
                new EmailMessage(FromAddress = 'test@abc.org'
                                , ToAddress= 'test@xyz.org'
                                , Subject = 'Test email'
                                , HtmlBody = 'Test email body'
                                , MessageDate = System.now().date()
                                , RelatedToId = lstAcc[0].Id
                                )
            };
        }
    }

    @isTest public static void testTaskCompleted(){
        System.runAs(lstUser[0]) {
            Date DateTodayMinus8 = System.now().date() - 8 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus8);
            Test.setCreatedDate(lstCon[0].Id, System.now().date() - 7);
            Test.setCreatedDate(lstCon[1].Id, System.now().date() - 6);
            Test.setCreatedDate(lstOpp[0].Id, System.now().date() - 5);
            Test.setCreatedDate(lstTask[0].Id, System.now().date() - 4);
            Test.setCreatedDate(lstEvent[0].Id, System.now().date() - 1);
            
            test.StartTest();  
            BAT14_VisitFollowUp batchObj = new BAT14_VisitFollowUp();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
           List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId =: lstAcc[0].Id ];
           System.debug('result ' +lstTask);
        }
    }

    @isTest public static void testEmailMessage(){
        System.runAs(lstUser[0]) {
            Date DateTodayMinus1 = System.now().date() - 1 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus1);
            Test.setCreatedDate(lstCon[0].Id, DateTodayMinus1);
            Test.setCreatedDate(lstCon[1].Id, DateTodayMinus1);
            Test.setCreatedDate(lstOpp[0].Id, DateTodayMinus1);
            Test.setCreatedDate(lstTask[0].Id, DateTodayMinus1);
            Test.setCreatedDate(lstEvent[0].Id, DateTodayMinus1);
            
            insert lstEmsg;

            lstCon[0].FirstName = 'Update';
            update lstCon;

            test.StartTest();  
            BAT14_VisitFollowUp batchObj = new BAT14_VisitFollowUp();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
           List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId =: lstAcc[0].Id ];
           System.debug('result ' +lstTask);
        }
    }

    @isTest public static void testEvent(){
        System.runAs(lstUser[0]) {
            Date DateTodayMinus1 = System.now().date() - 1 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus1);
            Test.setCreatedDate(lstTask[0].Id, DateTodayMinus1);
            Test.setCreatedDate(lstEvent[0].Id, DateTodayMinus1);
            
            insert new Event(
                Subject = 'Call',
                DurationInMinutes = 15,
                ActivityDateTime = System.now(),
                WhatId = lstAcc[0].Id
            );
            
            test.StartTest();  
            BAT14_VisitFollowUp batchObj = new BAT14_VisitFollowUp();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
           List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId =: lstAcc[0].Id ];
           System.debug('result ' +lstTask);
        }
    }
    @isTest public static void testTask(){
        System.runAs(lstUser[0]) {
            Date DateTodayMinus1 = System.now().date() - 1 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus1);
            Test.setCreatedDate(lstTask[0].Id, DateTodayMinus1);
            Test.setCreatedDate(lstEvent[0].Id, DateTodayMinus1);
            
            insert new Task(
                Subject = Label.BAT14_Subject,
                ActivityDate = System.now().date(),
                WhatId = lstAcc[0].Id,
                isAutomated__c = true,
                IsReminderSet = true,
                ReminderDateTime = System.now(),
                Status = 'Open',
                Priority = 'Normal'
            );
            
            test.StartTest();  
            BAT14_VisitFollowUp batchObj = new BAT14_VisitFollowUp();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
           List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId =: lstAcc[0].Id ];
           System.debug('result ' +lstTask);
        }
    }

    static testMethod void testSchedulePass() {
		Test.startTest();
		for (CronTrigger c: [Select Id From CronTrigger Where CronJobDetailId IN(Select Id From CronJobDetail WHERE
			JobType = '7')]) {
			System.abortJob(c.id);
		}       
		BAT14_VisitFollowUp batchObj = new BAT14_VisitFollowUp();
		String cronStr7 = '0 0 6 * * ? '; 
		Id jobId = System.schedule('Test schedule batch', cronStr7, batchObj);        
	    CronTrigger ct = [Select Id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where Id = : jobId];
	    Test.stopTest();
	    System.assertEquals(0, ct.TimesTriggered);
	}
}