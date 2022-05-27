/**
 * @File Name          : AP29_LeadConvertTransposeRules_TEST.cls
 * @Description        : Test class for AP29_LeadConvertTransposeRules
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 02-FEB-2021, 2:20 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    02-FEB-2021, 10:00 am         VJA         Initial Version
**/
@isTest
public with sharing class AP29_LeadConvertTransposeRules_TEST {

    static List<User> lstUser;
    static List<Lead> lstLead;
    static List<School__c> lstSchool;
    static List<Task> lstTasks;
    static List<Event> lstEvents;
    static List<Account> lstAcc;
    static List<AP29_LeadConvertTransposeRules.FlowInputs> lstFlowInputs;

    static {
        lstUser = new List<User>{TestFactory.createUser('TestUserAd', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstSchool = new List<School__c>{
                TestFactory.createSchool('Test', 'Mauritius', false, 'TST')
            };
            insert lstSchool;

            lstLead = new List<Lead>{
                TestFactory.createLead(
                    null, 'Test', 'Tester', 'childlname', 'childfname', 'Male', Date.newInstance(2010, 2, 2)
                )
            };
            insert lstLead;

            lstAcc = new List<Account>{
                TestFactory.createFamilyAccount('Acc')
            };
            insert lstAcc;

            lstEvents = new List<Event>{
                TestFactory.createEvent('event1', 10, Datetime.newInstanceGmt(2018, 8, 1)),
                TestFactory.createEvent('event2', 15, Datetime.newInstanceGmt(2019, 8, 1))
            };

            lstTasks = new List<Task>{
                TestFactory.createTask('task1'),
                TestFactory.createTask('task2')
            };

            lstEvents[0].WhoId = lstLead[0].Id;
            lstEvents[1].WhoId = lstLead[0].Id;
            lstTasks[0].WhoId = lstLead[0].Id;
            lstTasks[1].WhoId = lstLead[0].Id;

            insert lstEvents;
            insert lstTasks;

            lstFlowInputs = new List<AP29_LeadConvertTransposeRules.FlowInputs>();

        }
    }

    @isTest public static void testCloneLeadActivities(){
        AP29_LeadConvertTransposeRules.FlowInputs flowInputs = new AP29_LeadConvertTransposeRules.FlowInputs();
        flowInputs.leadId = lstLead[0].Id;
        flowInputs.accountId = lstAcc[0].Id;

        test.StartTest();
            lstFlowInputs.add(flowInputs);
            AP29_LeadConvertTransposeRules.cloneLeadActivities(lstFlowInputs);
        test.StopTest();

        List<Event> lstEvts = [SELECT WhatId FROM Event WHERE Subject =:lstEvents[0].Subject AND WhatId != null];
        System.assertEquals(lstEvts[0].WhatId, lstAcc[0].Id);
    }

}