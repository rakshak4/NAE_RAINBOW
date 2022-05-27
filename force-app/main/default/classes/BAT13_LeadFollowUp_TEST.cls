/**
 * @File Name          : BAT13_LeadFollowUp_TEST.cls
 * @Description        : Test Class for the batch BAT13_LeadFollowUp
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : CRA
 * @Last Modified On   : 05/12/2019, 14:27:41
 * @Modification Log   : 
 * Ver       Date            Author      	Modification
 * 1.0    12/09/2018         KZE            Initial Version
 * 1.1    05/12/2019         CRA            Add Coverage     
**/
@isTest
public with sharing class BAT13_LeadFollowUp_TEST {
    static List<User> lstUser;
    static List<Lead> lstLead;
    static List<School__c> lstSchool;       
    static List<Task> lstTask;   
    static List<Event> lstEvent;  
    static List<EmailMessage> lstEmsg;   
    static {
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
            insert lstUser;
        
        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST')
            };
            lstSchool[0].AdmissionsQueueCoordinator__c = lstUser[0].Id;
            lstSchool[0].BedrockSchool__c = true;
            lstSchool[0].OptInLeadFollowUp__c = true;
            insert lstSchool;
            
            lstLead = new List<Lead>{
                TestFactory.createLead(
                    null, 'Test1', 'Tester', 'childfname1', 'childlname1', 'Male', Date.newInstance(2010, 2, 2)
                ),
                TestFactory.createLead(
                    null, 'Test2', 'Tester', 'childfname2', 'childlname2', 'Male', Date.newInstance(2010, 2, 2)
                ),
                TestFactory.createLead(
                    null, 'Test3', 'Tester', 'childfname3', 'childlname3', 'Male', Date.newInstance(2010, 2, 2)
                ),
                TestFactory.createLead(
                    null, 'Test4', 'Tester', 'childfname4', 'childlname4', 'Male', Date.newInstance(2010, 2, 2)
                )
                    };                     
                        
            lstLead[0].Parent1PrimaryEmail__c = 'user@test.com';
            lstLead[0].Parent1CountryOfResidence__c = 'France';           
            lstLead[0].Parent2FirstName__c = 'Jean';
            lstLead[0].Parent2LastName__c = 'Curi';
            lstLead[0].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[0].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[0].Parent2CountryOfResidence__c = 'France';
            lstLead[0].Parent2Nationality__c = 'French';           
            lstLead[0].Number_of_Children__c = '1';
            lstLead[0].MarketingQualifiedFirstChild__c = true;
            lstLead[0].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[0].Company = 'testComp';
            lstLead[0].IsConverted = false;
            lstLead[0].Lead_Origin__c = 'AdmissionsStage1';
            
            lstLead[1].Parent1PrimaryEmail__c = 'user@test.com';
            lstLead[1].Parent1CountryOfResidence__c = 'France';           
            lstLead[1].Parent2FirstName__c = 'Jean1';
            lstLead[1].Parent2LastName__c = 'Curi2';
            lstLead[1].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[1].Parent2HomePhone__c = '+852 9999-9999';
            lstLead[1].Parent2CountryOfResidence__c = 'France';
            lstLead[1].Parent2Nationality__c = 'French';           
            lstLead[1].Number_of_Children__c = '1';
            lstLead[1].MarketingQualifiedFirstChild__c = true;
            lstLead[1].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[1].Company = 'testComp';
            lstLead[1].IsConverted = false;
            lstLead[1].LeadMethod__c = 'Email';
            lstLead[1].Lead_Origin__c = 'AdmissionsStage1';

            lstLead[2].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[2].Company = 'testComp';
            lstLead[2].IsConverted = false;
            lstLead[2].LeadMethod__c = 'Web';
            lstLead[2].Lead_Origin__c = 'AdmissionsStage2';

            lstLead[3].SchoolOfInterest__c = lstSchool[0].Id;
            lstLead[3].Company = 'testComp';
            lstLead[3].IsConverted = false;
            lstLead[3].LeadMethod__c = 'Web';
            lstLead[3].Lead_Origin__c = 'AdmissionsStage1';
            
            insert lstLead;

            lstTask = new List<Task> {
                TestFactory.createTask('Activity in past for lead 0'),
                TestFactory.createTask('Activity in past for lead 1'),
                TestFactory.createTask(Label.BAT13_TaskSubject.replace('{!Leadname}', lstLead[0].Firstname+ ' ' +lstLead[0].Firstname)), //automated task for lead 0
                TestFactory.createTask('Activity in future')
            };

            lstTask[0].WhoId = lstLead[0].id;
            lstTask[0].isAutomated__c = false;
            lstTask[0].Status = 'Open';
            lstTask[0].ActivityDate = System.now().date() - 4;

            lstTask[1].WhoId = lstLead[1].id;
            lstTask[1].isAutomated__c = false;
            lstTask[1].Status = 'Open';
            lstTask[1].ActivityDate = System.now().date() - 2 ;

            lstTask[2].WhoId = lstLead[0].id;
            lstTask[2].isAutomated__c = true;
            lstTask[2].Status = 'Open';
            lstTask[2].TECH_FollowUpCount__c = 1;
            lstTask[2].ActivityDate = System.now().date() - 2;

            lstTask[3].WhoId = lstLead[2].id;
            lstTask[3].isAutomated__c = false;
            lstTask[3].Status = 'Open';
            lstTask[3].ActivityDate = System.now().date() + 2 ;

            lstEvent = new List<Event> {
                TestFactory.createEvent('Activitydate In future', 60, System.now().date() + 2),
                TestFactory.createEvent('With Qualified lead', null, System.now().date() - 4),
                TestFactory.createEvent('Activitydate In past', 60, System.now().date() - 4),
                TestFactory.createEvent('Activity null', null, null)
            };

            lstEvent[0].WhoId = lstLead[0].Id;
            lstEvent[0].isAutomated__c = false;
            lstEvent[1].WhoId = lstLead[1].Id;
            lstEvent[1].isAutomated__c = false;
            lstEvent[1].EndDateTime = System.now().date() - 3;
            lstEvent[2].WhoId = lstLead[3].Id;
            lstEvent[2].isAutomated__c = false;
            lstEvent[3].WhoId = lstLead[2].Id;
            lstEvent[3].isAutomated__c = false;
            lstEvent[3].StartDateTime = System.now().date() - 2;
            lstEvent[3].IsAllDayEvent = true;

            lstEmsg = new List<EmailMessage>{
                new EmailMessage(FromAddress = 'test@abc.org'
                                , ToAddress= 'test@xyz.org'
                                , Subject = 'Test email'
                                , HtmlBody = 'Test email body'
                                , MessageDate = System.now().date() - 2
                                )
            };
        }
    }

    @isTest public static void H24WithTaskFollowUpTest() {
        System.runAs(lstUser[0]) {
            lstLead[0].Status = Label.BAT13_statusNew;  
            lstLead[1].Status = Label.BAT13_statusNew; 
            lstLead[2].Status = Label.BAT13_statusNew;
            update lstLead; 

            insert lstTask;

            Date DateTodayMinus8 = System.now().date() - 8 ;  
            Test.setCreatedDate(lstLead[0].Id, DateTodayMinus8);
            Test.setCreatedDate(lstLead[1].Id, DateTodayMinus8);
            Test.setCreatedDate(lstLead[2].Id, DateTodayMinus8);

            Test.StartTest();  
                BAT13_LeadFollowUp batchObj = new BAT13_LeadFollowUp();
                Database.executeBatch(batchObj , 200);
            Test.StopTest();

            List<Task> lstTaskRes = [SELECT Id FROM Task];
            System.assertEquals(5, lstTaskRes.size());
        }
    }
    
    @isTest public static void H24WithEventFollowUpTest() {
        System.runAs(lstUser[0]) {
            lstLead[0].Status = Label.BAT13_statusNew;  
            lstLead[1].Status = Label.BAT13_statusQualified; 
            lstLead[1].EnrollmentDateFirstChild__c = System.now().date() + 3;
            lstLead[1].DayOrBoardingSchoolFirstChild__c = AP_Constant.ledFullBoarding;
            lstLead[2].Status = Label.BAT13_statusNew;
            lstLead[3].Status = Label.BAT13_statusNew;
            update lstLead; 

            insert lstEvent;

            lstEmsg[0].toIds = new List<Id> {lstLead[0].Id};
            insert lstEmsg;

            Date DateTodayMinus8 = System.now().date() - 8 ;  
            Test.setCreatedDate(lstLead[0].Id, DateTodayMinus8);
            Test.setCreatedDate(lstLead[1].Id, DateTodayMinus8);
            Test.setCreatedDate(lstLead[2].Id, DateTodayMinus8);
            Test.setCreatedDate(lstLead[3].Id, DateTodayMinus8);
            Test.setCreatedDate(lstEvent[2].Id, System.now().date() - 2);

            Test.StartTest();  
                BAT13_LeadFollowUp batchObj = new BAT13_LeadFollowUp();
                Database.executeBatch(batchObj , 200);
            Test.StopTest();

            Map<Id, Task> mapTask = new Map<Id, Task>();
            for (Task tsk : [SELECT Id, WhoId FROM Task]) {
                mapTask.put(tsk.WhoId, tsk);
            }

            System.assertEquals(2, mapTask.size());
            System.assertEquals(true, mapTask.containsKey(lstLead[2].Id));
            System.assertEquals(true, mapTask.containsKey(lstLead[3].Id));
            
        }
    }  
    
}