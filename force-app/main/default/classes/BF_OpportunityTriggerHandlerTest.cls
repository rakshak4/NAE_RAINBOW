/**************************************************************************************
-- - Author        : akaCRM
-- - Description   : Opportunity Trigger Handler test class
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  -------------------------------------------------------
-- 09-AUG-2021  FJO    1.0     Initial version
-- 04-OCT-2021  FJO    1.1     Staff discount update
-- 11-OCT-2021  FJO    1.1     Update Removed due to static variable update
-- 18-JAN-2022  FJO    1.2     Contact Update
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest()
public class BF_OpportunityTriggerHandlerTest {
	@TestSetup
	static void setup(){
		List<School__c> schoolList = BF_TestFactory.createSchools(5);
		Map<Id, List<YearGrade__c>> yearGradeList = BF_TestFactory.createYearGrade(5, schoolList);
		List<Contact> contactList = BF_TestFactory.creatContactsWithAccounts(50, schoolList);
		Map<Id, List<EnrolmentPeriod__c>> enrolmentPeriodList = BF_TestFactory.createEnrolmentPeriods(5, schoolList);
		BF_TestFactory.createProducts(schoolList,enrolmentPeriodList,yearGradeList);
		BF_TestFactory.createDiscountProducts(schoolList,enrolmentPeriodList,yearGradeList);

		List<Contact> contactsToUpdate = new List<Contact>();
		for(Contact c: contactList){
			List<YearGrade__c> yearGrades = yearGradeList.get(c.SchoolOfInterest__c);
			c.Promoted_Year_Grade__c = yearGrades[Integer.valueOf((Math.random() * yearGrades.size()))].Id;
			contactsToUpdate.add(c);
		}
		update contactsToUpdate;

		// Updating product to match current Enrollment year.
 		// Hard Coding Values in the test factory. needs update

//		Opportunity o = [select id, Applied_Costs__c, Enrolment_Year__c from Opportunity limit 1];
//		List<Product2> product2List = new List<Product2>();
//		for(Product2 p : [select Id, Enrollment_Year__c from Product2]){
//			p.Enrollment_Year__c = o.Enrolment_Year__c;
//			product2List.add(p);
//		}
//		update product2List;

	}

	@isTest
	static void testApplyEnrolmentCostOnly(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c, Enrolment_Year__c from Opportunity where ContactId =:c.Id];
		System.debug('--------o:');
		System.debug(o);
		System.debug(o.Enrolment_Year__c);
		System.debug([select id, Name from Product2 where Name = 'New Student']);
		o.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Enrolment').getRecordTypeId();
//		update o;
		o.EnrolmentPeriod__c = p.Id;
		o.Applied_Costs__c = true;


		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();

		System.debug('Total CPU Time = ' + (stop - start));

		List<OpportunityLineItem> ol = [select Id from OpportunityLineItem where OpportunityId =:o.Id];
		Test.stopTest();
		System.debug('size: '+ ol.size());
		System.assert(ol.size() == 6); // 6 total product created
	}

	@isTest
	static void testApplyReEnrolmentCostOnly(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		o.EnrolmentPeriod__c = p.Id;
		o.Applied_Costs__c = true;

		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();


		System.debug('Total CPU Time = ' + (stop - start));

		List<OpportunityLineItem> ol = [select Id from OpportunityLineItem where OpportunityId =:o.Id];
		Test.stopTest();
		System.assert(ol.size() == 5); // 6 total products created, new student fee should be excluded for ReEnrolment
	}

	@isTest
	static void testDiscountPercentagesOnly(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		o.EnrolmentPeriod__c = p.Id;
		o.Apply_Discounts__c = true;
		o.Financial_Aid_Type__c = 'Percentage % Off';
		o.Financial_Aid_Percentage__c = 50.00;

		o.Scholarship_Type__c = 'Percentage % Off';
		o.Scholarship_Percentage__c = 50.00;

		o.Corporate_Type__c = 'Percentage % Off';
		o.Corporate_Percentage__c = 50.00;

		o.Landlord_Type__c = 'Percentage % Off';
		o.Landlord_Percentage__c = 50.00;

		o.Non_Tuition_Type__c = 'Percentage % Off';
		o.Non_Tuition_Percentage__c = 50.00;

		o.Other_Type__c = 'Percentage % Off';
		o.Other_Percentage__c = 50.00;

		o.Staff__c = true;
		o.Staff_Type__c = 'Percentage % Off';
		o.Staff_Percentage__c = 50.00;

		o.Sibling_Number__c = 1;


		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();

		Integer total = stop - start;
		System.debug('Total CPU Time =  ' + total);

		List<OpportunityLineItem> ol = [select Id from OpportunityLineItem];
		Test.stopTest();
		System.debug(ol.size());
		System.debug(ol);
		System.assert(ol.size() == 8);
	}

	@isTest
	static void testDiscountAmountOnly(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		o.EnrolmentPeriod__c = p.Id;
		o.Apply_Discounts__c = true;
		o.Financial_Aid_Type__c = 'Fixed $ Amount';
		o.Financial_Aid_Amount__c =  50.00;

		o.Scholarship_Type__c = 'Fixed $ Amount';
		o.Scholarship_Amount__c =  50.00;

		o.Corporate_Type__c = 'Fixed $ Amount';
		o.Corporate_Amount__c =  50.00;

		o.Landlord_Type__c = 'Fixed $ Amount';
		o.Landlord_Amount__c =  50.00;

		o.Non_Tuition_Type__c = 'Fixed $ Amount';
		o.Non_Tuition_Amount__c =  50.00;

		o.Other_Type__c = 'Fixed $ Amount';
		o.Other_Amount__c =  50.00;

		o.Staff__c = true;
		o.Staff_Type__c = 'Fixed $ Amount';
		o.Staff_Amount__c =  50.00;

		o.Sibling_Number__c = 2;

		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();

		Integer total = stop - start;
		System.debug('Total CPU Time =  ' + total);

		List<OpportunityLineItem> ol = [select Id from OpportunityLineItem];
		Test.stopTest();
		System.assert(ol.size() == 8);
	}

	@isTest
	static void testEarlyPaymentPlanOnly(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		o.EnrolmentPeriod__c = p.Id;
		o.Early_Pay_Discount_460__c = true;


		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();

		Integer total = stop - start;
		System.debug('Total CPU Time =  ' + total);

		List<OpportunityLineItem> ol = [select Id from OpportunityLineItem];
		Test.stopTest();
		System.assert(ol.size() == 1);
	}

	@isTest
	static void testOnePaymentPlanOnly(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		o.EnrolmentPeriod__c = p.Id;
		o.X1_Pay_Discount_460__c = true;


		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();

		Integer total = stop - start;
		System.debug('Total CPU Time =  ' + total);

		List<OpportunityLineItem> ol = [select Id from OpportunityLineItem];
		Test.stopTest();
		System.assert(ol.size() == 1);
	}

	@isTest
	static void testTwoPaymentPlanOnly_Discount(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		o.EnrolmentPeriod__c = p.Id;
		o.X2_Pay_Standard__c = true;

		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();

		Integer total = stop - start;
		System.debug('Total CPU Time =  ' + total);

		List<OpportunityLineItem> ol = [select Id from OpportunityLineItem];
		Test.stopTest();
		System.assert(ol.size() == 1);
	}

	@isTest
	static void testTwoPaymentPlanOnly_Fee(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		Product2 prod = [select Id, Unit_Price__c, Type__c, Discount_Type__c, Discount__c from Product2 where School__c =:c.SchoolOfInterest__c and Payment_Plan__c='2' limit 1];
		prod.Unit_Price__c = 99.9;
		prod.Type__c = 'Fee';
		prod.Discount_Type__c = null;
		prod.Discount__c = 0.0;
		update prod;

		o.EnrolmentPeriod__c = p.Id;
		o.X2_Pay_Standard__c = true;

		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();

		Integer total = stop - start;
		System.debug('Total CPU Time =  ' + total);

		List<OpportunityLineItem> ol = [select Id, TotalPrice, NAV_Fee_Payment_Code__c from OpportunityLineItem];
		Test.stopTest();
		System.debug(ol);
		System.assert(ol.size() == 1);
	}

	@isTest
	static void testTenPaymentPlanOnly_Fee(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		o.EnrolmentPeriod__c = p.Id;
		o.X10_Pay_Fee_340__c = true;

		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();

		Integer total = stop - start;
		System.debug('Total CPU Time =  ' + total);

		List<OpportunityLineItem> ol = [select Id from OpportunityLineItem];
		Test.stopTest();
		System.assert(ol.size() == 1);
	}

	@isTest
	static void testFeesDiscountsAndPaymentPlan(){
		Test.startTest();
		Contact c = [select id, SchoolOfInterest__c from contact limit 1];
		EnrolmentPeriod__c p = [select Id from EnrolmentPeriod__c where SchoolName__c =:c.SchoolOfInterest__c limit 1 ];
		Opportunity o = [select id, Applied_Costs__c from Opportunity where ContactId =:c.Id];
		o.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Enrolment').getRecordTypeId();
//		update o;
		o.EnrolmentPeriod__c = p.Id;
		o.Applied_Costs__c = true;
		o.Apply_Discounts__c = true;
		o.X10_Pay_Fee_340__c = true;

		o.Financial_Aid_Type__c = 'Fixed $ Amount';
		o.Financial_Aid_Amount__c =  50.00;

		o.Non_Tuition_Type__c = 'Percentage % Off';
		o.Non_Tuition_Percentage__c = 50.00;


		Integer start = Limits.getCpuTime();
		update o;
		Integer stop = Limits.getCpuTime();


		System.debug('Total CPU Time = ' + (stop - start));

		List<OpportunityLineItem> ol = [select FIELDS(STANDARD) from OpportunityLineItem where OpportunityId =:o.Id];
		Test.stopTest();
		System.debug(ol.size());
 		for(OpportunityLineItem ox : ol){
			System.debug(ox);
		}
//		System.assert(ol.size() == 6); // 6 total product created
	}
}