/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for BAT13_OpportunityFollowUp
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 26-SEP-2018  KZE    1.1      Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
public with sharing class BAT13_OpportunityFollowUp_TEST {
    static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Opportunity> lstOpp;
    static List<School__c> lstSchool;
    static Map<String,Id> mapRecordType;

    static {
        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject});
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;
        
        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('TestSchool', 'Mauritius', false, 'TST')
            };
            lstSchool[0].AdmissionsQueueCoordinator__c = lstUser[0].Id;
            insert lstSchool;

            lstAcc = new List<Account>{TestFactory.createAccount('test')};
            insert lstAcc;

            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testopp1', lstAcc[0].Id, AP_Constant.oppStageEnquiry, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testopp2', lstAcc[0].Id, AP_Constant.oppStageEnquiry, 
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
                };
        }
    }
    
    @isTest public static void createTaskForOpportunityNotEnrolledOrClosed(){
        System.runAs(lstUser[0]) {
            //stagename != 'Enrolled' OR 'Closed'
            //task should be created
            lstOpp[0].StageName = AP_Constant.oppStageEnquiry;  
            lstOpp[1].StageName = AP_Constant.oppStageEnquiry;  
            insert lstOpp;
            
            Set<Id> setOppIDs = new Set<Id>();            
            for(Opportunity opp: lstOpp){
                setOppIDs.add(opp.Id);
            }
            
            //createdDate - today must be 8 or 15 or 22 or 36
            Date DateTodayMinus8 = system.now().date() - 8 ;  
            Test.setCreatedDate(lstOpp[0].Id, DateTodayMinus8);
            Test.setCreatedDate(lstOpp[1].Id, DateTodayMinus8);
        
            test.StartTest();  
                BAT13_OpportunityFollowUp batchObj = new BAT13_OpportunityFollowUp();
                Database.executeBatch(batchObj , 200);
            test.StopTest();
            
            List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId IN :setOppIDs ];
            //System.assertEquals(2, lstTask.size());
            
        }
    }
    @isTest public static void createTaskForOpportunityStageChanged(){
        System.runAs(lstUser[0]) {
            //stagename != 'Enrolled' OR 'Closed'
            //BUT stagename is changed again thus TECH_StageLastModifiedDate__c
            //task should be not created
            lstOpp[0].StageName = AP_Constant.oppStageEnquiry;  
            lstOpp[1].StageName = AP_Constant.oppStageEnquiry;  
            insert lstOpp;
            
            Set<Id> setOppIDs = new Set<Id>();            
            for(Opportunity opp: lstOpp){
                setOppIDs.add(opp.Id);
            }
            
            //createdDate - today must be 8 or 15 or 22 or 36
            //it should not take createdDate but TECH_StageLastModifiedDate__c
            Date DateTodayMinus8 = system.now().date() - 8 ;  
            Test.setCreatedDate(lstOpp[0].Id, DateTodayMinus8);
            Test.setCreatedDate(lstOpp[1].Id, DateTodayMinus8);
        
            lstOpp[0].StageName = AP_Constant.oppStageNameVisit;  
            lstOpp[1].StageName = AP_Constant.oppStageNameVisit; 
            update lstOpp;

            test.StartTest();  
                BAT13_OpportunityFollowUp batchObj = new BAT13_OpportunityFollowUp();
                Database.executeBatch(batchObj , 200);
            test.StopTest();
            
            List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId IN :setOppIDs ];
           // System.assertEquals(0, lstTask.size());
            
        }
    }
    @isTest public static void createTaskForOpportunityEnrolled(){
        System.runAs(lstUser[0]) {
            //stagename = 'Enrolled' OR 'Closed'
            //task should not be created
            lstOpp[0].StageName = 'Enrolled';  
            lstOpp[1].StageName = 'Enrolled';  
            insert lstOpp;
                        
            Set<Id> setOppIDs = new Set<Id>();            
            for(Opportunity opp: lstOpp){
                setOppIDs.add(opp.Id);
            }
            
            //createdDate - today must be 8 or 15 or 22 or 36
            Date DateTodayMinus8 = system.now().date() - 8 ;  
            Test.setCreatedDate(lstOpp[0].Id, DateTodayMinus8);
            Test.setCreatedDate(lstOpp[1].Id, DateTodayMinus8);
        
            test.StartTest();  
                BAT13_OpportunityFollowUp batchObj = new BAT13_OpportunityFollowUp();
                Database.executeBatch(batchObj , 200);
            test.StopTest();
            
            List<Task> lstTask  = [SELECT Id, Subject FROM Task WHERE WhatId IN :setOppIDs ];
          //  System.assertEquals(0, lstTask.size());
            
        }
    }  
    @isTest public static void createTaskForOppWExistingTask(){
        System.runAs(lstUser[0]) { 
            //stagename != 'Enrolled' OR 'Closed'
            //task should be created
            lstOpp[0].StageName = AP_Constant.oppStageEnquiry;  
            lstOpp[1].StageName = AP_Constant.oppStageEnquiry;  
            insert lstOpp;
            
            Set<Id> setOppIDs = new Set<Id>();            
            for(Opportunity opp: lstOpp){
                setOppIDs.add(opp.Id);
            }
            
            Date DateTodayMinus11 = system.now().date() - 11 ; 
            Test.setCreatedDate(lstOpp[0].Id, DateTodayMinus11);
            Test.setCreatedDate(lstOpp[1].Id, DateTodayMinus11);
            
            //create an existing task for lstOpp[0]
            Task tsk = new Task();
            tsk.WhatId = lstOpp[0].id;
            tsk.isAutomated__c = true;
            tsk.IsReminderSet = true;
            tsk.ReminderDateTime = system.now();
            tsk.Subject = 'OLA';
            tsk.Status = 'Open';
            //create an existing task for lstOpp[1]
            Task tsk1 = new Task();
            tsk1.WhatId = lstOpp[1].id;
            tsk1.isAutomated__c = true;
            tsk1.IsReminderSet = true;
            tsk1.ReminderDateTime = system.now();
            tsk1.Subject = 'OLA';
            tsk1.Status = 'Open';            
            insert tsk;
            insert tsk1;   
            
            Date DateTodayMinus8 = system.now().date() - 8 ;
            Test.setCreatedDate(tsk.Id, DateTodayMinus8);
            Test.setCreatedDate(tsk1.Id, DateTodayMinus8);
     
            test.StartTest();  
                BAT13_OpportunityFollowUp batchObj = new BAT13_OpportunityFollowUp();
                Database.executeBatch(batchObj , 200);
            test.StopTest();
            
            List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId IN :setOppIDs];
           // System.assertEquals(4, lstTask.size());
            
        }
    }  
    @isTest public static void createTaskForOppWExistingEvent(){
        System.runAs(lstUser[0]) {                  
            //stagename != 'Enrolled' OR 'Closed'
            //task should be created
            lstOpp[0].StageName = AP_Constant.oppStageEnquiry;  
            lstOpp[1].StageName = AP_Constant.oppStageEnquiry;  
            insert lstOpp;
            
            Set<Id> setOppIDs = new Set<Id>();            
            for(Opportunity opp: lstOpp){
                setOppIDs.add(opp.Id);
            }

            Date DateTodayMinus11 = system.now().date() - 11 ; 
            Date DateTodayMinus8 = system.now().date() - 8 ;
            
            Test.setCreatedDate(lstOpp[0].Id, DateTodayMinus11);
            Test.setCreatedDate(lstOpp[1].Id, DateTodayMinus11);
            
            //create an existing evt for lstOpp[0]
            Event evt = new Event();
            evt.WhatId = lstOpp[0].id;
            evt.DurationInMinutes = 3;
            evt.ActivityDate = system.now().date();
            evt.ActivityDateTime = system.now();
            evt.DurationInMinutes = 3;
            
            //create an existing evt for lstOpp[1]
            Event evt1 = new Event();
            evt1.WhatId = lstOpp[1].id;
            evt1.DurationInMinutes = 3;
            evt1.ActivityDate = system.now().date();
            evt1.ActivityDateTime = system.now();
            evt1.DurationInMinutes = 3;
            
            insert evt;
            insert evt1;
            
            Test.setCreatedDate(evt.Id, DateTodayMinus8);
            Test.setCreatedDate(evt1.Id, DateTodayMinus8);
     
            test.StartTest();  
                BAT13_OpportunityFollowUp batchObj = new BAT13_OpportunityFollowUp();
                Database.executeBatch(batchObj , 200);
            test.StopTest();
            
            List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId IN :setOppIDs ];
           // System.assertEquals(2, lstTask.size());
            
        }
    }    
 }