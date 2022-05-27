/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for LC02_NewLeadForm
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 31-MAY-2018  AMU    1.0     Initial version
-- 15-APR-2021  VJA    1.1     Lead Fail Method Removed
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
public with sharing class LC02_NewLeadForm_TEST {
    static List<User> lstUser;
    static School__c school;
    static List<YearGrade__c> lstYearGrade;
    static List<EnrolmentPeriod__c> lstEnrolmentPeriod;
    static Map<String, Id> mapRecordType;

    static {
        school = TestFactory.createSchool('Test school', 'test address', true, 'CBS');
        insert school;

        lstEnrolmentPeriod = new List<EnrolmentPeriod__c>{
            TestFactory.createEnrolmentPeriod('Semester 1', school.Id, 'YR18', Date.newInstance(2018, 1, 1), Date.newInstance(2019, 1, 1))
        };
        insert lstEnrolmentPeriod;

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        lstUser[0].SchoolCode__c = 'CBS';
        insert lstUser;

        lstYearGrade = new List<YearGrade__c>{
            TestFactory.createYearGrade('Group 2018 Junior', school.Id, 5, 15, lstEnrolmentPeriod[0].Id)
        };
        insert lstYearGrade;

        CS_CountryPhoneCode__c countryPhone = new CS_CountryPhoneCode__c(Name = 'MUR', Country_Name__c = 'Mauritius', Phone_Code__c = '+230');
        insert countryPhone;

        mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject});
    }
    
    @isTest public static void getDetailsTest() {
        System.runAs(lstUser[0]) {
            test.StartTest();
                Map<String, Object> mapDetails = LC02_NewLeadForm.getDetails();
            test.StopTest();
            Lead lead = (Lead)mapDetails.get('lead');
            System.assertEquals(lead.SchoolOfInterest__c, school.Id);
        }
    }

    @isTest public static void saveLeadTest() {
        Lead lead = TestFactory.createLead(null, 'Sammy', 'Curi', 'Tom', 'Curi', 'Male', Date.newInstance(2010, 12, 22));
        lead.Company = 'test company';
        lead.Parent1FirstName__c = 'Sammy';
        lead.Parent1LastName__c = 'Curi';
        lead.Parent1PrimaryEmail__c = 'usersammy@test.com';
        lead.Parent1HomePhone__c = '+852 9999-9999';
        lead.Parent1CountryOfResidence__c = 'France';
        lead.Parent1Nationality__c = 'French';
        lead.SchoolOfInterest__c = school.Id;
        lead.EnrollmentDateFirstChild__c = System.today() + 5; 
        lead.EnrollmentDateSecondChild__c = System.today() + 2;
        lead.EnrollmentDateThirdChild__c = System.today() + 1;
        lead.EnrollmentDateFourthChild__c = System.today() + 3;
        lead.EnrollmentDateFifthChild__c = System.today() + 2;
        //lead.EnrollmentDateSixthChild__c = System.today() + 1;
        lead.DateOfBirthSecondChild__c = Date.newInstance(2010, 12, 22);
        lead.DateOfBirthThirdChild__c = Date.newInstance(2010, 12, 22);
        lead.DateOfBirthFourthChild__c = Date.newInstance(2010, 12, 22);
        lead.DateOfBirthFifthChild__c = Date.newInstance(2010, 12, 22);
        //lead.DateOfBirthSixthChild__c = Date.newInstance(2010, 12, 22);

        System.runAs(lstUser[0]) {
            test.StartTest();
                Map<String, String> mapResult = LC02_NewLeadForm.saveLead(lead, mapRecordType.get(AP_Constant.ledRecordTypeEnrolment));
            test.StopTest();

            Lead savedLead = [SELECT ExpectedYearGradeFirstChild__c, ExpectedStartMonthFirstChild__c, ExpectedStartYearFirstChild__c FROM Lead Where 
                              FirstName =: lead.FirstName LIMIT 1];
            System.assertEquals(mapResult.get('type'), 'success');
            System.assertEquals(savedLead.ExpectedYearGradeFirstChild__c, lstYearGrade[0].Id);
            System.assertEquals(savedLead.ExpectedStartYearFirstChild__c, String.valueOf(lead.EnrollmentDateFirstChild__c.year()));
        }
    }
}