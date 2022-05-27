@isTest
public class BAT02_AccountFollowUpTask_TEST {
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
                lstAcc[0].SchoolOfInterest__c =  lstSchool[0].id;  
            insert lstAcc;
            
            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testopp1', lstAcc[0].Id, AP_Constant.oppStageEnquiry, 
                                              mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
                    
                    ,TestFactory.createOpportunity('testopp2', lstAcc[0].Id, AP_Constant.oppStageEnquiry, 
                                                   mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)
                    };
                        
            insert lstOpp;
        }
    }
    
    @isTest public static void test1(){
        System.runAs(lstUser[0]) {
            
            Date DateTodayMinus8 = system.now().date() - 8 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus8);
            
            test.StartTest();  
            BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
           List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId =: lstAcc[0].Id ];
           
            
        }
    }
    
    @isTest public static void test2(){
        System.runAs(lstUser[0]) {
            
            Task tsk = new Task();
            tsk.whatId = lstAcc[0].Id;
            tsk.ActivityDate = system.now().date() - 9;
            tsk.isAutomated__c = true;
            tsk.Status = 'Open';
            tsk.subject = '8 day follow up';
            tsk.TECH_FollowUpCount__c = 1;
            insert tsk;
            
            Task tsk2 = new Task();
            tsk2.whatId = lstAcc[0].Id;
            tsk2.ActivityDate = system.now().date();
            tsk2.TaskCompletionDateTime__c = system.now().date() - 16;
            tsk2.Status = 'Open';
            insert tsk2;
            
            Date DateTodayMinus18 = system.now().date() - 18 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus18);
            Date DateTodayMinus9 = system.now().date() - 9 ;  
            Test.setCreatedDate(tsk.id, DateTodayMinus9);
            Date DateTodayMinus16 = system.now().date() - 16 ; 
            Test.setCreatedDate(tsk2.id, DateTodayMinus16);
            
            test.StartTest();  
            BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
            List<Task> lstTask = [SELECT Id, Subject FROM Task WHERE WhatId =: lstAcc[0].Id ];
            System.assertEquals(3, lstTask.size());

        }
    }
    
    @isTest public static void test3(){
        System.runAs(lstUser[0]) {
            
            Task tsk = new Task();
            tsk.whatId = lstAcc[0].Id;
            tsk.ActivityDate = system.now().date() - 9;
            tsk.isAutomated__c = true;
            tsk.Status = 'Open';
            tsk.subject = '8 day follow up';
            tsk.TECH_FollowUpCount__c = 1;
            insert tsk;
            
            Task tsk2 = new Task();
            tsk2.whatId = lstAcc[0].Id;
            tsk2.ActivityDate = system.now().date();
            tsk2.Status = 'Open';
            insert tsk2;
            
            Date DateTodayMinus18 = system.now().date() - 18 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus18);
            Date DateTodayMinus9 = system.now().date() - 9 ;  
            Test.setCreatedDate(tsk.id, DateTodayMinus9);
            Date DateTodayMinus16 = system.now().date() - 16 ; 
            Test.setCreatedDate(tsk2.id, DateTodayMinus16);
            
            test.StartTest();  
            BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
                        
        }
    }
    
     @isTest public static void test4(){
        System.runAs(lstUser[0]) {
            
            Task tsk = new Task();
            tsk.whatId = lstAcc[0].Id;
            tsk.ActivityDate = system.now().date() - 9;
            tsk.isAutomated__c = true;
            tsk.Status = 'Open';
            tsk.subject = '8 day follow up';
            tsk.TECH_FollowUpCount__c = 2;
            insert tsk;
            
            Task tsk2 = new Task();
            tsk2.whatId = lstAcc[0].Id;
            tsk2.ActivityDate = system.now().date();
            tsk2.Status = 'Open';
            insert tsk2;
            
            Date DateTodayMinus28 = system.now().date() - 28 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus28);
            Date DateTodayMinus22 = system.now().date() - 22 ;  
            Test.setCreatedDate(tsk.id, DateTodayMinus22);
            Date DateTodayMinus23 = system.now().date() - 23 ; 
            Test.setCreatedDate(tsk2.id, DateTodayMinus23);
            
            test.StartTest();  
            BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
                        
        }
    }
    
    @isTest public static void test5(){
        System.runAs(lstUser[0]) {
            
            Task tsk = new Task();
            tsk.whatId = lstAcc[0].Id;
            tsk.ActivityDate = system.now().date() - 8;
            tsk.isAutomated__c = true;
            tsk.Status = 'Open';
            tsk.subject = '8 day follow up';
            tsk.TECH_FollowUpCount__c = 1;
            insert tsk;
            
            Event evt = new Event();
            evt.whatId = lstAcc[0].Id;
            evt.ActivityDateTime = system.now() + 3;
            evt.DurationInMinutes = 10;
            tsk.subject = 'evt';
            insert evt;
            
            Task tsk2 = new Task();
            tsk2.whatId = lstAcc[0].Id;
            tsk2.ActivityDate = system.now().date();
            tsk2.Status = 'Open';
            insert tsk2;
            
            Date DateTodayMinus8 = system.now().date() - 8 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus8);
            Date DateTodayMinus22 = system.now().date() - 22 ;  
            Test.setCreatedDate(tsk.id, DateTodayMinus22);
            Date DateTodayMinus23 = system.now().date() - 23 ; 
            Test.setCreatedDate(tsk2.id, DateTodayMinus23);
            
            test.StartTest();  
            BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
        }
    }
    
    @isTest public static void test6(){
        System.runAs(lstUser[0]) {
            
            Task tsk = new Task();
            tsk.whatId = lstAcc[0].Id;
            tsk.ActivityDate = system.now().date() - 8;
            tsk.isAutomated__c = true;
            tsk.Status = 'Open';
            tsk.subject = '8 day follow up';
            tsk.TECH_FollowUpCount__c = 1;
            insert tsk;
            
            Event evt = new Event();
            evt.whatId = lstAcc[0].Id;
            evt.ActivityDateTime = system.now() - 3;
            evt.DurationInMinutes = 10;
            tsk.subject = 'evt';
            insert evt;
            
            Task tsk2 = new Task();
            tsk2.whatId = lstAcc[0].Id;
            tsk2.ActivityDate = system.now().date();
            tsk2.Status = 'Open';
            insert tsk2;
            
            Date DateTodayMinus8 = system.now().date() - 8 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus8);
            Date DateTodayMinus22 = system.now().date() - 22 ;  
            Test.setCreatedDate(tsk.id, DateTodayMinus22);
            Date DateTodayMinus23 = system.now().date() - 23 ; 
            Test.setCreatedDate(tsk2.id, DateTodayMinus23);
            
            test.StartTest();  
            BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
        }
    }
    
        @isTest public static void test7(){
        System.runAs(lstUser[0]) {
            
            Task tsk = new Task();
            tsk.whatId = lstAcc[0].Id;
            tsk.ActivityDate = system.now().date() - 65;
            tsk.isAutomated__c = true;
            tsk.Status = 'Open';
            tsk.subject = '8 day follow up';
            tsk.TECH_FollowUpCount__c = 3;
            insert tsk;
            
            Task tsk2 = new Task();
            tsk2.whatId = lstAcc[0].Id;
            tsk2.ActivityDate = system.now().date()- 65;
            tsk2.Status = 'Open';
            insert tsk2;
            
            Date DateTodayMinus68 = system.now().date() - 68 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus68);
            Date DateTodayMinus57 = system.now().date() - 57 ;  
            Test.setCreatedDate(tsk.id, DateTodayMinus57);
            Date DateTodayMinus56 = system.now().date() - 56 ; 
            Test.setCreatedDate(tsk2.id, DateTodayMinus56);
            
            test.StartTest();  
            BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
                        
        }
    }
    
    @isTest public static void test8(){
        System.runAs(lstUser[0]) {
            
            Task tsk = new Task();
            tsk.whatId = lstAcc[0].Id;
            tsk.ActivityDate = system.now().date() - 9;
            tsk.isAutomated__c = true;
            tsk.Status = 'Open';
            tsk.subject = '8 day follow up';
            tsk.TECH_FollowUpCount__c = 1;
            insert tsk;
            
            Task tsk2 = new Task();
            tsk2.whatId = lstAcc[0].Id;
            tsk2.ActivityDate = system.now().date()- 65;
            tsk2.Status = 'Open';
            insert tsk2;
            
            Date DateTodayMinus8 = system.now().date() - 8 ;  
            Test.setCreatedDate(lstAcc[0].Id, DateTodayMinus8);
            Test.setCreatedDate(tsk.id, DateTodayMinus8);
            Test.setCreatedDate(tsk2.id, DateTodayMinus8);
            
            test.StartTest();  
            BAT02_AccountFollowUpTask batchObj = new BAT02_AccountFollowUpTask();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
        }
    }

}