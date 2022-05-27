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
public with sharing class BAT25_ClassCapacityInsert_TEST {
    static List<User> lstUser;
    static List<School__c> lstSchool;
    static List<YearGrade__c> lstYearGrade;
    static List<Class__c> lstClass;
    static List<ClassCapacity__c> lstClassCapacity;
    static List<EnrolmentPeriod__c> lstEnrolmentPeriod;


    static {
        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;
        
        System.runAs(lstUser[0]){
            
            lstSchool = new List<School__c>{
                TestFactory.createSchool('School1', 'Address1', true, 'SC1'),
                TestFactory.createSchool('School2', 'Address2', true, 'SC2'),
                TestFactory.createSchool('School3', 'Address3', true, 'SC3'),
                TestFactory.createSchool('School4', 'Address4', false,'SC4')
            }; 
            
            lstSchool[2].Reference_Date__c = Date.newInstance(2012, 2, 2);
            lstSchool[3].Reference_Date__c = Date.newInstance(2012, 2, 2);
            insert lstSchool;

            lstEnrolmentPeriod = new List<EnrolmentPeriod__c>{
                TestFactory.createEnrolmentPeriod('EP1', lstSchool[0].id,'SC1EP1', Date.newInstance(2010, 2, 2), Date.newInstance(2011, 2, 2)),
                TestFactory.createEnrolmentPeriod('EP2', lstSchool[1].id,'SC2EP1', Date.newInstance(2010, 2, 2), Date.newInstance(2011, 2, 2)),
                TestFactory.createEnrolmentPeriod('EP3', lstSchool[2].id,'SC2EP3', Date.newInstance(2010, 2, 2), Date.newInstance(2011, 2, 2)),
                TestFactory.createEnrolmentPeriod('EP4', lstSchool[3].id,'SC2EP4', Date.newInstance(2010, 2, 2), Date.newInstance(2011, 2, 2))

            };

            insert lstEnrolmentPeriod;

            lstYearGrade = new List<YearGrade__c>{
                TestFactory.createYearGrade('YG1',lstSchool[0].id,12,14,lstEnrolmentPeriod[0].id),
                TestFactory.createYearGrade('YG2',lstSchool[1].id,13,15,lstEnrolmentPeriod[1].id),
                TestFactory.createYearGrade('YG3',lstSchool[2].id,13,15,lstEnrolmentPeriod[2].id),
                TestFactory.createYearGrade('YG3',lstSchool[3].id,13,15,lstEnrolmentPeriod[3].id)

            }; 

            insert lstYearGrade;

            lstClass = new List<Class__c>{
                 TestFactory.createClass('Class1S1',30 , lstYearGrade[0].id,lstSchool[0].id)
                ,TestFactory.createClass('Class2S2',60 , lstYearGrade[1].id,lstSchool[1].id)
                ,TestFactory.createClass('Class3S3',10 , lstYearGrade[2].id,lstSchool[2].id)
                ,TestFactory.createClass('Class344',10 , lstYearGrade[3].id,lstSchool[3].id)
            }; 

            insert lstClass;

            lstClassCapacity = new List<ClassCapacity__c>{
                TestFactory.createClassCapacity('Class1S1Cap1',30 , lstClass[0].id,Date.newInstance(2016, 2, 2),Date.newInstance(2017, 2, 2)),
                TestFactory.createClassCapacity('Class3S3Cap1',30 , lstClass[2].id,Date.newInstance(2016, 2, 2),Date.newInstance(2017, 2, 2))
            }; 

            insert lstClassCapacity; 
        }
    }   

    @isTest public static void test2() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
                Class__c newClass = TestFactory.createClass('Class2S2',60 , lstYearGrade[0].id,lstSchool[0].id);
                insert newClass;
            Test.StopTest();

            List<Class__c> lstInsertedClass= [SELECT Id, Name, SchoolName__c, SchoolName__r.Reference_Date__c, (SELECT Id, Name, StartDate__c, EndDate__c, CapacityUsed__c, CapacityTotal__c, CapacityAvailable__c, CurrentYear__c FROM Class_Capacities__r) FROM Class__c];
            System.assertEquals(1, lstInsertedClass[4].Class_Capacities__r.size());
        
        }
    }

    @isTest public static void test1() {
        System.runAs(lstUser[0]) {

            Test.StartTest();  
                SchedulableContext sc = null;
                BAT25_ClassCapacityInsert tsc = new BAT25_ClassCapacityInsert();
                tsc.execute(sc);
            Test.StopTest();

            List<Class__c> lstInsertedClass= [SELECT Id, Name, SchoolName__c, SchoolName__r.Reference_Date__c, (SELECT Id, Name, StartDate__c, EndDate__c, CapacityUsed__c, CapacityTotal__c, CapacityAvailable__c, CurrentYear__c FROM Class_Capacities__r) FROM Class__c];
            
            System.assertEquals(3, lstInsertedClass[0].Class_Capacities__r.size());
            System.assertEquals(2, lstInsertedClass[1].Class_Capacities__r.size());
            System.assertEquals(3, lstInsertedClass[2].Class_Capacities__r.size());          
            System.assertEquals(0, lstInsertedClass[3].Class_Capacities__r.size());          
        }
    }
    

}