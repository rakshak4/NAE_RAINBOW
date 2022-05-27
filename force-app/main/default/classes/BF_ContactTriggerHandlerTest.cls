/**************************************************************************************
-- - Author        : akaCRM
-- - Description   : Contact Trigger Handler test class
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  -------------------------------------------------------
-- 09-AUG-2021  FJO    1.0     Initial version
-- 11-OCT-2021  FJO    1.1     Bulk Update
--------------------------------------------------------------------------------------
**************************************************************************************/
@IsTest
private class BF_ContactTriggerHandlerTest {
	@TestSetup
 	static void setup(){
		School__c s = new School__c();
		s.Name = 'Test School';
		s.Re_Enrolment_Close_Date__c = Date.today();
		Insert s;

		Account a = new Account();
		a.Name = 'Test Family';
		a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Family').getRecordTypeId();
		a.SchoolOfInterest__c = s.Id;
		Insert a;

		Contact c = new Contact();
		c.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Child').getRecordTypeId();
		c.lastName = 'Test_LastName';
 		c.AccountId = a.Id;
		c.SchoolOfInterest__c = s.Id;
		c.Day_or_Boarding_Student__c = 'Day';
		insert c;

		List<Account> familyAccounts = new List<Account>();
		Integer count = 200;
		for(Integer x =0; x<count; x++){
			Account acc = new Account();
			acc.Name = 'Test Family #' + x;
			acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Family').getRecordTypeId();
			acc.SchoolOfInterest__c = s.Id;
			familyAccounts.add(acc);
		}
		insert familyAccounts;


	}

	@IsTest
	static void testOppCreateOnPromotedYear(){
		Contact child = [select Id, Promoted_Year_Grade__c, SchoolOfInterest__c from Contact limit 1];
		List<Opportunity> priorOppList = [select Id from Opportunity where Child__c =:child.Id];

		YearGrade__c yearGrade = new YearGrade__c();
		yearGrade.Name = 'Promoted Year';
		yearGrade.SchoolName__c = child.SchoolOfInterest__c;
		yearGrade.NCYear__c = 3.0;
		insert yearGrade;
		child.Promoted_Year_Grade__c = yearGrade.Id;
		update child;

		List<Opportunity> opportunityList = [select Id, RecordType.DeveloperName from Opportunity where Child__c =:child.Id];

		// Assert one and only one opportunity is created.
		System.assert(!opportunityList.isEmpty());
		System.assert(priorOppList.size() + 1 == opportunityList.size());

		// Assert at least One ReEnrolment Opp is created.
		Boolean reEnrollment = false;
		for(Opportunity o : opportunityList){
			if(o.RecordType.DeveloperName == 'Reenrolment'){
				reEnrollment = true;
				break;
			}
		}
		System.assert(reEnrollment);
	}

	@IsTest
	static void testOppCloneOnPromotedYear(){
		Contact child = [select Id, Promoted_Year_Grade__c, SchoolOfInterest__c, AccountId from Contact limit 1];

		List<YearGrade__c> yearGradeList = new List<YearGrade__c>();
		YearGrade__c yearGrade = new YearGrade__c();
		yearGrade.Name = 'Promoted Year';
		yearGrade.SchoolName__c = child.SchoolOfInterest__c;
		yearGrade.NCYear__c = 3.0;
		yearGradeList.add(yearGrade);

		YearGrade__c yearGrade2 = new YearGrade__c();
		yearGrade2.Name = 'Promoted Year 2';
		yearGrade2.SchoolName__c = child.SchoolOfInterest__c;
		yearGrade2.NCYear__c = 4.0;
		yearGradeList.add(yearGrade2);

		insert yearGradeList;

		Opportunity enrolmentOpp = new Opportunity();
		enrolmentOpp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Enrolment').getRecordTypeId();
		enrolmentOpp.Name = 'Enrolment Opportunity';
		enrolmentOpp.AccountId = child.AccountId;
		enrolmentOpp.ContactId = child.Id;
		enrolmentOpp.CloseDate = Date.today();
		enrolmentOpp.Child__c = child.Id;
		enrolmentOpp.DayOrBoardingSchool__c = 'Day'; // Value should be cloned
		insert enrolmentOpp;

		child.Promoted_Year_Grade__c = yearGrade.Id;
		update child;

		List<Opportunity> opportunityList = [select Id, DayOrBoardingSchool__c,RecordType.DeveloperName from Opportunity where Child__c =:child.Id and RecordType.DeveloperName = 'Reenrolment'];

		// Assert one and only one opportunity is created.
		System.assert(!opportunityList.isEmpty() && opportunityList.size() == 1);
		// Assert Opportunity created was cloned from enrolment opportunity.
		System.assert(enrolmentOpp.DayOrBoardingSchool__c == opportunityList[0].DayOrBoardingSchool__c);

		// Assert at least additional ReEnrolment Opp are cloned from last Opp.
		opportunityList[0].DayOrBoardingSchool__c = 'Boarding';
		update opportunityList;
		// Promote Year Grade to trigger ReEnrolment
		child.Promoted_Year_Grade__c = yearGrade2.Id;
		update child;

		List<Opportunity> opportunityList2 = [select Id, DayOrBoardingSchool__c,RecordType.DeveloperName from Opportunity where Child__c =:child.Id];
		System.debug(opportunityList2);
		System.debug(opportunityList2.size());

		List<Opportunity> newOppList = [select Id, DayOrBoardingSchool__c,RecordType.DeveloperName from Opportunity where Child__c =:child.Id and RecordType.DeveloperName = 'Reenrolment'];
		System.assert(newOppList.size() == 2);
	}

	@IsTest
	static void testBulkPromotedContacts(){
		School__c s = [select id from School__c limit 1];
		Integer count = 10;
		List<Account> familyAccounts = [select Id from account limit :count];

		List<Contact> contactList = new List<Contact>();
		for(Integer x =0; x<count; x++){
			Contact c = new Contact();
			c.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Child').getRecordTypeId();
			c.lastName = 'Test_LastName_' + x;
			c.AccountId = familyAccounts[x].Id;
			c.SchoolOfInterest__c = s.Id;
			c.Day_or_Boarding_Student__c = 'Day';
			contactList.add(c);
		}
		insert contactList;
		List<Opportunity> priorOppList = [select Id from Opportunity where Child__c in :contactList];

		YearGrade__c yearGrade = new YearGrade__c();
		yearGrade.Name = 'Promoted Year';
		yearGrade.SchoolName__c = s.Id;
		yearGrade.NCYear__c = 3.0;
		insert yearGrade;

		for(Contact c : contactList){
			c.Promoted_Year_Grade__c = yearGrade.Id;
		}
		Test.startTest();
		update contactList;
		Test.stopTest();
		List<Opportunity> opportunityList = [select Id, RecordType.DeveloperName from Opportunity where Child__c in :contactList];

		// Assert one and only one opportunity is created for each contact updated.
		System.assert(!opportunityList.isEmpty());
		System.assert(priorOppList.size() + contactList.size() == opportunityList.size());


	}

	@IsTest
	static void testNoOpportunityOnContactCreate(){
		List<Contact> c = [select LastName, AccountId from Contact];
		List<Opportunity> o = [select id from Opportunity];
		System.assert(!c.isEmpty() && o.isEmpty());
	}

}