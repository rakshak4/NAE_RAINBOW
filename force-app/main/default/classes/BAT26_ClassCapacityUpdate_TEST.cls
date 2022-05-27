/**
 * @description       : BAT25 Test Class
 * @author            : Spoon Consulting
 * @group             : 
 * @last modified on  : 01-12-2021
 * @last modified by  : Spoon Consulting
 * Modifications Log 
 * Ver   Date         Author             Modification
 * 1.0   30-03-2021   FKH                Initial Version
**/
@isTest
public with sharing class BAT26_ClassCapacityUpdate_TEST {

    static List<User> lstUser;
    static List<School__c> lstSchool;
    static List<YearGrade__c> lstYearGrade;
    static List<Class__c> lstClass;
    static List<ClassCapacity__c> lstClassCapacity;
    static List<EnrolmentPeriod__c> lstEnrolmentPeriod;
    static List<Account> lstAcc;
    static List<Contact> lstContact;
    static List<Opportunity> lstOpp; 
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static {
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;        
        System.runAs(lstUser[0]){         
            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject});

            lstSchool = new List<School__c>{
                TestFactory.createSchool('School1', 'Address1', true, 'SC1'),
                TestFactory.createSchool('School2', 'Address2', true, 'SC2'),
                TestFactory.createSchool('School3', 'Address3', true, 'SC3')
            }; 
            lstSchool[0].Reference_Date__c = Date.newInstance(2012, 2, 2);
            lstSchool[1].Reference_Date__c = Date.newInstance(2012, 2, 2);
            
            insert lstSchool;
    
            lstAcc = new List<Account>{
                TestFactory.createAccount('test Acc 0')
                ,TestFactory.createAccount('test Acc 1')
                ,TestFactory.createAccount('test Acc 2')
            };
            
            insert lstAcc;

            lstEnrolmentPeriod = new List<EnrolmentPeriod__c>{
                TestFactory.createEnrolmentPeriod('EP1', lstSchool[0].id,'SC1EP1', Date.newInstance(2010, 2, 2), Date.newInstance(2011, 2, 2)),
                TestFactory.createEnrolmentPeriod('EP2', lstSchool[1].id,'SC2EP1', Date.newInstance(2010, 2, 2), Date.newInstance(2011, 2, 2)),
                TestFactory.createEnrolmentPeriod('EP3', lstSchool[2].id,'SC2EP3', Date.newInstance(2010, 2, 2), Date.newInstance(2011, 2, 2))
            };

            insert lstEnrolmentPeriod;

            lstYearGrade = new List<YearGrade__c>{
                TestFactory.createYearGrade('YG1',lstSchool[0].id,12,14,lstEnrolmentPeriod[0].id),
                TestFactory.createYearGrade('YG2',lstSchool[1].id,13,15,lstEnrolmentPeriod[1].id),
                TestFactory.createYearGrade('YG3',lstSchool[2].id,13,15,lstEnrolmentPeriod[2].id)
            }; 

            insert lstYearGrade;

            lstClass = new List<Class__c>{
                TestFactory.createClass('Class1S1',30 , lstYearGrade[0].id,lstSchool[0].id),
                TestFactory.createClass('Class2S2',60 , lstYearGrade[1].id,lstSchool[1].id),
                TestFactory.createClass('Class3S3',10 , lstYearGrade[2].id,lstSchool[2].id)
            }; 

            insert lstClass;

            lstClassCapacity = new List<ClassCapacity__c>{
                TestFactory.createClassCapacity('Class1S1Cap1',30 , lstClass[0].id,Date.newInstance(2026, 1, 1),Date.newInstance(2025, 1, 1)),
                TestFactory.createClassCapacity('Class3S3Cap1',30 , lstClass[1].id,Date.newInstance(2026, 2, 2),Date.newInstance(2025, 2, 2))
            }; 
            insert lstClassCapacity;
  
            lstOpp = new List<Opportunity>{
                TestFactory.createOpportunity('testOpp01', lstAcc[0].Id, AP_Constant.oppStageNameStarted,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp02', lstAcc[0].Id, AP_Constant.oppStageNameEnrolled,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[0].Id)

                ,TestFactory.createOpportunity('testOpp03', lstAcc[0].Id, AP_Constant.oppStageNameAcceptance,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id)

                ,TestFactory.createOpportunity('testOpp04', lstAcc[0].Id, AP_Constant.oppStageNameApplication,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id)

                ,TestFactory.createOpportunity('testOpp05', lstAcc[0].Id, AP_Constant.oppStageNameActive,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id)
                ,TestFactory.createOpportunity('testOpp06', lstAcc[0].Id, AP_Constant.oppStageNameActive,
                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), lstSchool[1].Id)
            };

            lstOpp[3].Waitlisted__c= true;

            lstOpp[0].YearGrade__c = lstYearGrade[0].id;
            lstOpp[1].YearGrade__c = lstYearGrade[0].id;
            lstOpp[2].YearGrade__c = lstYearGrade[1].id;
            lstOpp[3].YearGrade__c = lstYearGrade[1].id;
            lstOpp[4].YearGrade__c = lstYearGrade[1].id;

            lstOpp[0].Class__c = lstClass[0].id;
            lstOpp[1].Class__c = lstClass[0].id;
            lstOpp[2].Class__c = lstClass[1].id;
            lstOpp[3].Class__c = lstClass[1].id;
            lstOpp[4].Class__c = lstClass[1].id;

            lstOpp[0].CloseDate= Date.newInstance(2025, 12, 12);
            lstOpp[1].CloseDate= Date.newInstance(2025, 12, 12);
            lstOpp[2].CloseDate= Date.newInstance(2025, 12, 12);
            lstOpp[3].CloseDate= Date.newInstance(2025, 12, 12);            
            lstOpp[4].CloseDate= Date.newInstance(2025, 12, 12);

            insert lstOpp;
        }
           
    }

    @isTest public static void test1() { // run batch usual method
        System.runAs(lstUser[0]) {

            Test.StartTest();  
                BAT26_ClassCapacityUpdate batchObj = new BAT26_ClassCapacityUpdate();
                Database.executeBatch(batchObj , 10);
            Test.StopTest();

            List<Class__c> lstInsertedClassClass= [SELECT Id, Name, SchoolName__c, SchoolName__r.Reference_Date__c, (SELECT Id, Name, StartDate__c, EndDate__c, CapacityUsed__c, CapacityTotal__c, CapacityAvailable__c, CurrentYear__c,EnrolmentYear__c  FROM Class_Capacities__r ORDER BY EndDate__c Desc), (SELECT Id, StageName, Enrolment_Year__c,EnrolledStartDate__c FROM Opportunities1__r) FROM Class__c WHERE SchoolName__c != null AND SchoolName__r.IsNAESchool__c = true];
            System.assertEquals(2, lstInsertedClassClass[0].Class_Capacities__r[0].CapacityUsed__c);
            System.assertEquals(1, lstInsertedClassClass[1].Class_Capacities__r[0].CapacityUsed__c);

        
        }
    }

    @isTest public static void test2() { // on update
        System.runAs(lstUser[0]) {

            Test.StartTest();  
                lstOpp[4].StageName = AP_Constant.oppStageNameAcceptance;
                update lstOpp;
            Test.StopTest();

            List<Class__c> lstInsertedClassClass= [SELECT Id, Name, SchoolName__c, SchoolName__r.Reference_Date__c, (SELECT Id, Name, StartDate__c, EndDate__c, CapacityUsed__c, CapacityTotal__c, CapacityAvailable__c, CurrentYear__c,EnrolmentYear__c  FROM Class_Capacities__r ORDER BY EndDate__c Desc), (SELECT Id, StageName, Enrolment_Year__c,EnrolledStartDate__c FROM Opportunities1__r) FROM Class__c WHERE SchoolName__c != null AND SchoolName__r.IsNAESchool__c = true];
            System.assertEquals(2, lstInsertedClassClass[0].Class_Capacities__r[0].CapacityUsed__c);
            System.assertEquals(2, lstInsertedClassClass[1].Class_Capacities__r[0].CapacityUsed__c);
        }
    }

    @isTest public static void test3() { // on update
        System.runAs(lstUser[0]) {

            Test.StartTest();  
                lstOpp[3].Class__c = null;
                lstOpp[3].YearGrade__c = null;
                update lstOpp;
            Test.StopTest();

            List<Class__c> lstInsertedClassClass= [SELECT Id, Name, SchoolName__c, SchoolName__r.Reference_Date__c, (SELECT Id, Name, StartDate__c, EndDate__c, CapacityUsed__c, CapacityTotal__c, CapacityAvailable__c, CurrentYear__c,EnrolmentYear__c  FROM Class_Capacities__r ORDER BY EndDate__c Desc), (SELECT Id, StageName, Enrolment_Year__c,EnrolledStartDate__c FROM Opportunities1__r) FROM Class__c WHERE SchoolName__c != null AND SchoolName__r.IsNAESchool__c = true];
            System.assertEquals(2, lstInsertedClassClass[0].Class_Capacities__r[0].CapacityUsed__c);
            System.assertEquals(1, lstInsertedClassClass[1].Class_Capacities__r[0].CapacityUsed__c);
        }
    }

    @isTest public static void test4() { // on update
        System.runAs(lstUser[0]) {

            Test.StartTest();  
                lstOpp[0].Class__c = null;
                lstOpp[0].YearGrade__c = null;
                lstOpp[1].Class__c = null;
                lstOpp[1].YearGrade__c = null;
                lstOpp[2].Class__c = null;
                lstOpp[2].YearGrade__c = null;
                lstOpp[3].Class__c = null;
                lstOpp[3].YearGrade__c = null;
                lstOpp[4].Class__c = null;
                lstOpp[4].YearGrade__c = null;
            update lstOpp;
            Test.StopTest();

            List<Class__c> lstInsertedClassClass= [SELECT Id, Name, SchoolName__c, SchoolName__r.Reference_Date__c, (SELECT Id, Name, StartDate__c, EndDate__c, CapacityUsed__c, CapacityTotal__c, CapacityAvailable__c, CurrentYear__c,EnrolmentYear__c  FROM Class_Capacities__r ORDER BY EndDate__c Desc), (SELECT Id, StageName, Enrolment_Year__c,EnrolledStartDate__c FROM Opportunities1__r) FROM Class__c WHERE SchoolName__c != null AND SchoolName__r.IsNAESchool__c = true];
            System.assertEquals(0, lstInsertedClassClass[0].Class_Capacities__r[0].CapacityUsed__c);
            System.assertEquals(0, lstInsertedClassClass[1].Class_Capacities__r[0].CapacityUsed__c);
        }
    }
}