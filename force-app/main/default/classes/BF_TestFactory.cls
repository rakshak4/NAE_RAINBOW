/**************************************************************************************
-- - Author        : akaCRM
-- - Description   : Test Factory class
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  -------------------------------------------------------
-- 09-AUG-2021  FJO    1.0     Initial version
-- 18-JAN-2021  FJO    1.1     Contact update
--------------------------------------------------------------------------------------
**************************************************************************************/
@IsTest
public class BF_TestFactory {
	// Create Contact
	public static List<Contact> creatContactsWithAccounts(Integer numContacts, List<School__c> schoolList){
		List<Contact> contacts = new List<Contact>();
		List<Account> accounts = new List<Account>();

		Id childRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Child').getRecordTypeId();
		Id familyRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Family').getRecordTypeId();

		for(Integer i=0; i<numContacts; i++){
			Account a = new Account();
			a.Name = 'Test Family Account #' +i;
			a.RecordTypeId = familyRecordTypeId;
			a.SchoolOfInterest__c = schoolList[Integer.valueOf((Math.random() * schoolList.size()))].Id;
			accounts.add(a);
		}
		insert accounts;

		for(Integer i=0; i<numContacts; i++){
			Contact c = new Contact();
			c.RecordTypeId = childRecordTypeId;
			c.Contact_Location__c = 'Home';
			c.lastName = 'Test_LastName #' + i;
			c.AccountId = accounts[i].Id;
			c.SchoolOfInterest__c = accounts[i].SchoolOfInterest__c;
			c.DayOrBoardingSchool__c = 'Day';
			c.Day_or_Boarding_Student__c = 'Day';
			contacts.add(c);
		}
		insert contacts;
		return contacts;
	}

	public static List<Account> createFamilyAccounts(Integer numAccounts){
		List<Account> familyAccounts = new List<Account>();
		List<School__c> schoolList = createSchools(1);

		Id familyRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Family').getRecordTypeId();

		for(Integer x =0; x<numAccounts; x++){
			Account acc = new Account();
			acc.Name = 'Test Family #' + x;
			acc.RecordTypeId = familyRecordTypeId;
			acc.SchoolOfInterest__c = schoolList[0].Id;
			familyAccounts.add(acc);
		}
		insert familyAccounts;
		return familyAccounts;
	}

	public static List<School__c> createSchools(Integer numSchools){
		List<School__c> schools = new List<School__c>();
		for(Integer i=0; i<numSchools; i++){
			School__c s = new School__c();
			s.Name = 'Test School #'+i;
			s.Re_Enrolment_Close_Date__c = Date.today();
			schools.add(s);
		}
		insert schools;
		return schools;
	}

	public static Map<Id, List<EnrolmentPeriod__c>> createEnrolmentPeriods(Integer numPeriods, List<School__c> schoolList){
		List<EnrolmentPeriod__c> enrolmentPeriods = new List<EnrolmentPeriod__c>();
		Map<Id, List<EnrolmentPeriod__c>> subEnrolmentPeriodOfSchoolId = new Map<Id, List<EnrolmentPeriod__c>>();
		for(School__c s : schoolList){
			subEnrolmentPeriodOfSchoolId.put(s.Id, new List<EnrolmentPeriod__c>());
			for(Integer i=0; i<numPeriods; i++){
				EnrolmentPeriod__c period = new EnrolmentPeriod__c();
				period.Name = 'Test Enrolment Period '+i;
				period.CurrencyIsoCode = 'USD';
				period.Active__c = true;
				period.SchoolName__c = s.Id;
				subEnrolmentPeriodOfSchoolId.get(s.Id).add(period);
				enrolmentPeriods.add(period);
			}
		}
		insert enrolmentPeriods;
		return subEnrolmentPeriodOfSchoolId;
	}

	public static Map<Id, List<YearGrade__c>> createYearGrade(Integer numYearGrades, List<School__c> schoolList){
		List<YearGrade__c> yearGradeList = new List<YearGrade__c>();
		Map<Id, List<YearGrade__c>> subYearGradeSchoolId = new Map<Id, List<YearGrade__c>>();
		for(School__c s : schoolList){
			subYearGradeSchoolId.put(s.Id, new List<YearGrade__c>());
			for(Integer i=0; i<numYearGrades; i++){
				YearGrade__c yearGrade = new YearGrade__c();
				yearGrade.Name = String.valueOf(i);
				yearGrade.SchoolName__c = s.Id;
				yearGrade.NCYear__c = 3.0;
				subYearGradeSchoolId.get(s.Id).add(yearGrade);
				yearGradeList.add(yearGrade);
			}
		}
		insert yearGradeList;
		return subYearGradeSchoolId;
	}

	public static List<Product2> createProducts(List<School__c> schoolList, Map<Id, List<EnrolmentPeriod__c>> subEnrolmentPeriodOfSchoolId, Map<Id, List<YearGrade__c>> subYearGradeSchoolId){
		List<Product2> product2List = new List<Product2>();
		for(School__c s : schoolList){
			List<EnrolmentPeriod__c> enrolmentPeriodList = subEnrolmentPeriodOfSchoolId.get(s.Id);
			List<YearGrade__c> yearGradeList = subYearGradeSchoolId.get(s.Id);
			// School Fees
			Product2 schoolFees = new Product2(
					Name = 'School Fees',
					Description = 'School Fees',
					IsActive = true,
					CurrencyIsoCode = 'USD',
					QuantityUnitOfMeasure = '1',
					Unit_Price__c = 100.0,
					Resource_No__c = 'NBP22R0061',
					Enrollment_Year__c = '2021/2022',
					School__c = s.Id,
					Type__c = 'Fee'
			);
			product2List.add(schoolFees);

			// boarding specific
			Product2 boardingSpecific = schoolFees.clone(false, true);
			boardingSpecific.Name = 'Boarding specific';
			boardingSpecific.Description = 'Boarding specific';
			boardingSpecific.Boarding__c = 'Day';
			boardingSpecific.Unit_Price__c = 10.0;
			boardingSpecific.Type__c = 'Fee';
			product2List.add(boardingSpecific);

			// New Student
			Product2 newStudent = schoolFees.clone(false, true);
			newStudent.Name = 'New Student';
			newStudent.Description = 'New Student';
			newStudent.Unit_Price__c = 1.0; // easy to verified applied if total tuition amount is odd
			newStudent.Type__c = 'New Student Fee';
			product2List.add(newStudent);

			for(YearGrade__c y : yearGradeList){
				// Year/Grade specific
				Product2 yearGradeSpecific = new Product2(
						Name = 'Year/Grade specific',
						Description = 'Year/Grade specific',
						IsActive = true,
						CurrencyIsoCode = 'USD',
						QuantityUnitOfMeasure = '1',
						Unit_Price__c = (1000.0 * Integer.valueOf(y.Name)),
						Resource_No__c = 'NBP22R0061',
						Enrollment_Year__c = '2021/2022',
						Year_Grade__c = y.Id,
						School__c = s.Id,
						Type__c = 'fee'
				);
				product2List.add(yearGradeSpecific);

				for(EnrolmentPeriod__c e : enrolmentPeriodList){
					// Tuition
					Product2 prod = new Product2(
							Name = 'Tuition: G5',
							Description = 'Tuition: G5',
							IsActive = true,
							CurrencyIsoCode = 'USD',
							QuantityUnitOfMeasure = '1',
							Unit_Price__c = (100000.0 * Integer.valueOf(y.Name)),
							Resource_No__c = 'NBP22R0061',
							Enrollment_Year__c = '2021/2022',
							Enrolment_Term__c = e.Id,
							Year_Grade__c = y.Id,
							School__c = s.Id,
							Boarding__c = 'Day',
							Type__c = 'Tuition'
					);
					product2List.add(prod);

					// Boarding
					Product2 boarding = prod.clone(false, true);
					boarding.Name = 'Boarding';
					boarding.Description = 'Boarding';
					boarding.Unit_Price__c = (10000.0 * Integer.valueOf(y.Name));
					boarding.Type__c = 'Boarding';
					product2List.add(boarding);
				}
			}
		}
		insert product2List;

		Id priceBookId = Test.getStandardPriceBookId();
		List<PricebookEntry> pricebookEntryList = new List<PricebookEntry>();

		for(Product2 p: product2List){
			PriceBookEntry standardPrice = new PriceBookEntry(
					Pricebook2Id = priceBookId, Product2Id = p.Id,
					UnitPrice = p.Unit_Price__c, IsActive = true);
			pricebookEntryList.add(standardPrice);
		}

		insert pricebookEntryList;
		return product2List;
	}

	public static List<Product2> createDiscountProducts(List<School__c> schoolList, Map<Id, List<EnrolmentPeriod__c>> subEnrolmentPeriodOfSchoolId, Map<Id, List<YearGrade__c>> subYearGradeSchoolId){
		List<Product2> product2List = new List<Product2>();
		for(School__c s : schoolList){
			List<EnrolmentPeriod__c> enrolmentPeriodList = subEnrolmentPeriodOfSchoolId.get(s.Id);
			List<YearGrade__c> yearGradeList = subYearGradeSchoolId.get(s.Id);

			Product2 earlyPay = new Product2(
					Name = 'Early Payment',
					IsActive = true,
					CurrencyIsoCode = 'USD',
					QuantityUnitOfMeasure = '1',
					Unit_Price__c = 0.0,
					Discount__c = 50.0,
					Resource_No__c = 'NBP22R0061',
					Enrollment_Year__c = '2021/2022',
					School__c = s.Id,
					Boarding__c = 'Day',
					Type__c = 'Discount',
					Discount_Type__c = 'Early Payment',
					NAV_Fee_Payment_Code__c = '1324443'
			);
			product2List.add(earlyPay);

			Product2 onePay = earlyPay.clone(false, true);
			onePay.Name = 'One Payment Plan';
			onePay.Discount__c = 1.0;
			onePay.Discount_Type__c = 'Payment';
			onePay.Payment_Plan__c = '1';
			product2List.add(onePay);


			Product2 twoPay = earlyPay.clone(false, true);
			twoPay.Name = 'Two Payment Plan (Discount)';
			twoPay.Discount__c = 2.0;
			twoPay.Discount_Type__c = 'Payment';
			twoPay.Payment_Plan__c = '2';
			product2List.add(twoPay);

			Product2 tenPay = earlyPay.clone(false, true);
			tenPay.Name = 'Ten Payment Plan';
			tenPay.Unit_Price__c = 0.5;
			tenPay.Type__c = 'Fee';
			tenPay.Discount_Type__c = null;
			tenPay.Payment_Plan__c = '10';
			product2List.add(tenPay);


			for(Integer i=0; i<enrolmentPeriodList.size(); i++){
				Product2 fAid = new Product2(
						IsActive = true,
						CurrencyIsoCode = 'USD',
						QuantityUnitOfMeasure = '1',
						Unit_Price__c = 0.0,
						Resource_No__c = 'NBP22R0061',
						Enrollment_Year__c = '2021/2022',
						Enrolment_Term__c = enrolmentPeriodList[i].Id,
						Year_Grade__c = yearGradeList[i].Id,
						School__c = s.Id,
						Boarding__c = 'Day',
						Type__c = 'Discount'
				);


				List<String> discountTypes = new List<String>{'Financial Aid', 'Scholarship', 'Corporate', 'Landlord', 'Non-Tuition', 'Other', 'Staff'};
				for(String type : discountTypes){
					Product2 discount = fAid.clone(false, true);
					discount.Name = type;
					discount.Description = type;
					discount.Discount_Type__c = type;
					product2List.add(discount);
				}


				Product2 discount = fAid.clone(false, true);
				discount.Name = 'Sibling';
				discount.Description = 'Sibling';
				discount.Discount_Type__c = 'Sibling';
				discount.Sibling__c = '1';
				discount.Unit_Price__c = 0.0;
				discount.Discount__c = 50.0;
				product2List.add(discount);

				Product2 discount2 = fAid.clone(false, true);
				discount2.Name = 'Sibling';
				discount2.Description = 'Sibling';
				discount2.Discount_Type__c = 'Sibling';
				discount2.Sibling__c = '2';
				discount2.Unit_Price__c = 100.0;
				product2List.add(discount2);


			}
		}
		insert product2List;

		Id priceBookId = Test.getStandardPriceBookId();
		List<PricebookEntry> pricebookEntryList = new List<PricebookEntry>();

		for(Product2 p: product2List){
			PriceBookEntry standardPrice = new PriceBookEntry(
					Pricebook2Id = priceBookId, Product2Id = p.Id,
					UnitPrice = p?.Unit_Price__c, IsActive = true);
			pricebookEntryList.add(standardPrice);
		}

		insert pricebookEntryList;
		return product2List;
	}
}