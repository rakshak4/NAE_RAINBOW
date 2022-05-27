/**************************************************************************************
-- - Author        : akaCRM
-- - Description   : Tuition, Fees and Discounts
--
-- Maintenance History:
--
-- Date         Name  Version  Remarks
-- -----------  ----  -------  -------------------------------------------------------
-- 09-AUG-2021  FJO    1.0     Initial version
-- 19-AUG-2021  FJO    1.1     New Enrolment Boarding specific fees added
-- 04-OCT-2021  FJO    1.2     Reenrolment Boarding specific fees added
-- 04-MAR-2022  FJO    1.3     Additional Record Types Included
-- 21-APR-2022  FJO    1.4     Field mappings from Products to Opp Products
-- 28-APR-2022  FJO    1.5     Payment Plan Calculation Updates
-- 29-APR-2022  FJO    1.6     Payment Plan Percentage School field set
--------------------------------------------------------------------------------------
**************************************************************************************/
public class BF_EnrollmentTuition {
	public Enum ProductType {PAYMENT_PLAN, STANDARD}

	public Set<Id> schoolSet = new Set<Id>();
	public Set<String> enrollmentYearSet = new Set<String>();
	public Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>();
	public Map<Id, Opportunity> opportunityDiscountMap = new Map<Id, Opportunity>();
	public Map<Id, Opportunity> opportunityDiscountOnlyMap = new Map<Id, Opportunity>();

	public Map<Id, Schema.SObjectField> opportunityPaymentFieldMap = new Map<Id, SObjectField>();
	public Map<Id, Opportunity> opportunityPaymentMap = new Map<Id, Opportunity>();
	public Map<Id, Opportunity> opportunityDiscountAndPaymentMap = new Map<Id, Opportunity>();
	public Map<Id, Opportunity> opportunityPaymentOnlyMap = new Map<Id, Opportunity>();
	public Map<Id,Map<String, Map<String, List<Product2>>>> subKeyPatternProducts = new Map<Id, Map<String, Map<String, List<Product2>>>>();


	public BF_EnrollmentTuition(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap) {
		this.getOpportunities(newOpportunities, oldOpportunitiesMap);
		this.setProducts();
	}

	public void applyTuitionAndFees(){
		List<OpportunityLineItem> opportunityLineItems = new List<OpportunityLineItem>();
		for(Opportunity o : opportunityMap.values()){
			Map<String, List<Product2>> productList = subKeyPatternProducts.get(o.SchoolOfInterest__c).get(o.Enrolment_Year__c);

			Set<Product2> tuitionAndFees = new Set<Product2>();
			String year = String.isBlank(o.YearGrade__c) ? '': o.YearGrade__c;
			String period = String.isBlank(o.EnrolmentPeriod__c) ? '': o.EnrolmentPeriod__c;
			String curriculum = String.isBlank(o.CurriculumName__c) ? '': o.CurriculumName__c;
			String boarding = String.isBlank(o.DayOrBoardingSchool__c) ? '': o.DayOrBoardingSchool__c;

			// Key Patterns to match to
			String key = o.SchoolOfInterest__c + o.Enrolment_Year__c;
			String keyYearGradeSpecificFees = key + year;
			String keyYearGradeDaySpecificFees = key + year + boarding;
			String keyCurriculumAsAFee = key + curriculum;
			String keyBoardingSpecificFees = key + boarding;
			String keyBoardingAndTuitionFees = key + period + year + boarding;
			String keyTuitionCurriculumFees = key + period + year + boarding + curriculum;
			String type = BF_EnrollmentOpportunityConstants.ENROLMENT_RECORD_TYPE_IDS.contains(o.RecordTypeId ) ? 'New Student Fee' : 'Reenrolment Fee';


			// School Fees
			tuitionAndFees.addAll(new List<Product2>(productList.get(key)));
			tuitionAndFees.addAll(new List<Product2>(productList.get(keyBoardingAndTuitionFees)));
			tuitionAndFees.addAll(new List<Product2>(productList.get(keyTuitionCurriculumFees)));
			tuitionAndFees.addAll(new List<Product2>(productList.get(keyCurriculumAsAFee)));
			tuitionAndFees.addAll(new List<Product2>(productList.get(keyBoardingSpecificFees)));
			tuitionAndFees.addAll(new List<Product2>(productList.get(keyYearGradeSpecificFees)));
			tuitionAndFees.addAll(new List<Product2>(productList.get(keyYearGradeDaySpecificFees)));
			tuitionAndFees.addAll(new List<Product2>(productList.get(key+type)));
			tuitionAndFees.addAll(new List<Product2>(productList.get(key+boarding+type)));

			Decimal baseTuition = 0;
			for(Product2 p: tuitionAndFees){
				if(p.Type__c == 'Tuition' || p.Type__c == 'Boarding'){
					baseTuition += p.Unit_Price__c;
				}
				opportunityLineItems.add(createOpportunityLineItems(p, o.Id, p.Unit_Price__c));
			}

			// Per Client Request this discount calculation *DOES NOT* use Single Equivalent Discount
			Set<OpportunityLineItem> discountItems = new Set<OpportunityLineItem>();
			if(opportunityDiscountMap.containsKey(o.Id)){
				//Discount are only applied to the base tuition
				discountItems.addAll(getDiscounts(o, baseTuition));
				opportunityLineItems.addAll(discountItems);
			}

			// This logic add the payment plan discount/fees
			// Possible to remove this logic since the Payment Plan discount/fees are applied after contract has been signed
			if(opportunityPaymentMap.containsKey(o.Id)){
				Decimal netTuition = baseTuition;
				for(opportunityLineItem d : discountItems){
					netTuition += d.TotalPrice;
				}
				opportunityLineItems.addAll(getPaymentPlanItem(o, netTuition));
			}

		}
		if(!opportunityLineItems.isEmpty()){
			insert opportunityLineItems;
		}
	}

	public void applyScholarshipsAndDiscounts(){
		if(!opportunityDiscountOnlyMap.isEmpty()){
			insert getDiscounts(opportunityDiscountOnlyMap);
		}
	}

	public void applyPaymentPlanFeeOrDiscount(){
		if(!opportunityPaymentOnlyMap.isEmpty()){
			List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();
			for(Opportunity o : opportunityPaymentOnlyMap.values()){
				// Payment Plan discounts/Fees are applied after discounts
				lineItems.addAll(getPaymentPlanItem(o, o.Net_Tuition__c));
			}
			if(!lineItems.isEmpty()){
				insert lineItems;
			}
		}
	}

	public List<OpportunityLineItem> getDiscounts(Map<Id, Opportunity> opportunities){
		List<OpportunityLineItem> opportunityLineItems = new List<OpportunityLineItem>();
		for(Opportunity o : opportunities.values()){

			Set<OpportunityLineItem> discountItems = new Set<OpportunityLineItem>();
			discountItems.addAll(getDiscounts(o, 0)); // setting to 0 because base tuition should already be calculated.
			opportunityLineItems.addAll(discountItems);

			if(opportunityDiscountAndPaymentMap.containsKey(o.Id)){
				Decimal netTuition = o.Base_Tuition__c;
				for(opportunityLineItem d : discountItems){
					netTuition += d.TotalPrice;
				}
				opportunityLineItems.addAll(getPaymentPlanItem(o, netTuition));
			}
		}
		return opportunityLineItems;
	}

	public Set<OpportunityLineItem> getDiscounts(Opportunity opp, Decimal total){
		Set<OpportunityLineItem> opportunityLineItems = new Set<OpportunityLineItem>();
		Map<String, List<Product2>> productList = subKeyPatternProducts.get(opp.SchoolOfInterest__c).get(opp.Enrolment_Year__c);
		String key = opp.SchoolOfInterest__c + opp.Enrolment_Year__c + 'Discount';

		for(Schema.SObjectField discountType : BF_EnrollmentOpportunityConstants.DISCOUNT_FIELDS){
			if(discountType == Opportunity.Staff_Type__c && !opp.Staff__c){
				continue;
			}
			if(!String.isBlank((String) opp.get(discountType)) && productList.containsKey(key + BF_EnrollmentOpportunityConstants.DISCOUNT_KEY_MAP.get(discountType))){
				Product2 p1 = productList.get(key+ BF_EnrollmentOpportunityConstants.DISCOUNT_KEY_MAP.get(discountType))[0];
				Decimal amount = 0;
				Boolean percentageUsed = false;
				Map<Schema.SObjectField, Schema.SObjectField> amountFieldMap = BF_EnrollmentOpportunityConstants.DISCOUNT_AMOUNT_FIELD_MAP;
				Map<Schema.SObjectField, Schema.SObjectField> percentageFieldMap = BF_EnrollmentOpportunityConstants.DISCOUNT_PERCENTAGE_FIELD_MAP;

				if((String) opp.get(discountType) == 'Fixed $ Amount'){
					amount = opp.get(amountFieldMap.get(discountType)) == null ? 0 : -((Decimal) opp.get(amountFieldMap.get(discountType)));
				}else{
					percentageUsed = true;
					Decimal percentage = opp.get(percentageFieldMap.get(discountType)) == null ? 0 : ((Double) opp.get(percentageFieldMap.get(discountType)))/100;
					amount = -(percentage * (opp.Base_Tuition__c + total));
				}
				OpportunityLineItem ol = createOpportunityLineItems(p1, opp.Id, amount);
				ol.Discount_Type__c = p1.Discount_Type__c;
				if(percentageUsed){
					ol.Discount__c = p1.Discount__c;
				}
				opportunityLineItems.add(ol);
			}
		}

		if((Integer)opp.Sibling_Number__c >= 1 && productList.containsKey(key+ 'Sibling'+ (Integer)opp.Sibling_Number__c)){
			Product2 p1 = productList.get(key+'Sibling'+ (Integer)opp.Sibling_Number__c)[0];
// 			opportunityLineItems.add(createLineItem(p1, opp, (opp.Base_Tuition__c + total), false, ProductType.STANDARD));
			Decimal amount = 0;
			Boolean percentageUsed = false;
			if(p1.Unit_Price__c > 0.0){
				amount = -p1.Unit_Price__c;
			}else{
				percentageUsed = true;
				Decimal percentage = p1.Discount__c == null ? 0 : p1.Discount__c/100;
				amount = -(percentage * (opp.Base_Tuition__c + total));
			}
			OpportunityLineItem ol = createOpportunityLineItems(p1, opp.Id, amount);
			ol.Discount_Type__c = p1.Discount_Type__c;
			if(percentageUsed){
				ol.Discount__c = p1.Discount__c;
			}
			opportunityLineItems.add(ol);
		}
		return opportunityLineItems;
	}

	public List<OpportunityLineItem> getPaymentPlanItem(Opportunity opp, Decimal total){
		List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();
		Map<String, List<Product2>> productList = subKeyPatternProducts.get(opp.SchoolOfInterest__c).get(opp.Enrolment_Year__c);
		Set<Product2> p = new Set<Product2>();
		String key = opp.SchoolOfInterest__c + opp.Enrolment_Year__c;
		String type = 'Discount';
		String discountType = '';
		String paymentPlan = '';

		if(opportunityPaymentFieldMap.get(opp.Id) == Opportunity.Early_Pay_Discount_460__c){
			discountType = 'Early Payment';
			p.addAll(new List<Product2>(productList.get(key + type + discountType + paymentPlan)));

		}else if(opportunityPaymentFieldMap.get(opp.Id) == Opportunity.X1_Pay_Discount_460__c){
			discountType = 'Payment';
			paymentPlan = '1';
			p.addAll(new List<Product2>(productList.get(key + type + discountType + paymentPlan)));

		}else if(opportunityPaymentFieldMap.get(opp.Id) == Opportunity.X2_Pay_Standard__c){
			discountType = 'Payment';
			paymentPlan = '2';
			if(productList.containsKey(key + type + discountType + paymentPlan)){
				p.addAll(new List<Product2>(productList.get(key + type + discountType + paymentPlan)));
			}else{
				discountType = '';
				type = 'Fee';
				p.addAll(new List<Product2>(productList.get(key + type + discountType + paymentPlan)));
			}
		}else if(opportunityPaymentFieldMap.get(opp.Id) == Opportunity.X10_Pay_Fee_340__c){
			type = 'Fee';
			paymentPlan = '10';
			p.addAll(new List<Product2>(productList.get(key + type + discountType + paymentPlan)));
		}
		if(!p.isEmpty()){
			Product2 p1 = (new List<Product2>(p))[0];
			Boolean isFee = type == 'Fee';
			lineItems.add(createLineItem(p1, opp, total, isFee, ProductType.PAYMENT_PLAN));
		}

		return lineItems;
	}

	private OpportunityLineItem createLineItem(Product2 p, Opportunity opp, Decimal total, Boolean isFee, ProductType type ){
		Decimal amount = p.Unit_Price__c;
		Boolean percentageUsed = (p.Discount__c <> 0 && p.Discount__c <> null) && (p.Unit_Price__c == 0 || p.Unit_Price__c == null);

		if(percentageUsed){
			Decimal percentage = p.Discount__c == null ? 0 : p.Discount__c/100;
			amount = (percentage * (total));
		}

		amount = isFee ? amount : -amount;
		OpportunityLineItem ol = createOpportunityLineItems(p, opp.Id, amount);
		ol.Discount_Type__c = p.Discount_Type__c;
		if(percentageUsed){
			ol.Discount__c = p.Discount__c;
			if(type == ProductType.PAYMENT_PLAN){
				ol.Percent_School_Finance_Fee__c = true;
			}
		}
		return ol;
	}

	private OpportunityLineItem createOpportunityLineItems(Product2 p, Id oppId, Decimal amount){
		OpportunityLineItem lineItem = new OpportunityLineItem();
		lineItem.OpportunityId = oppId;
		lineItem.PricebookEntryId = p.PricebookEntries[0]?.Id;
		lineItem.Quantity = 1;
		lineItem.Product2Id = p.Id;
		lineItem.Resource_No__c = p.Resource_No__c;
		lineItem.Shortcut_Dimension_1_Code__c = p.Shortcut_Dimension_1_Code__c;
		lineItem.Shortcut_Dimension_2_Code__c = p.Shortcut_Dimension_2_Code__c;
		lineItem.Override__c = p.Override__c;
		lineItem.Type__c = p.Type__c;
		lineItem.TotalPrice = amount;
		lineItem.Description = p.Description;
		lineItem.School__c = p.School__c;
		lineItem.Enrolment_Term__c = p.Enrolment_Term__c;
		lineItem.Year_Grade__c = p.Year_Grade__c;
		lineItem.Number_of_Installments__c = p.Number_of_Installments__c;
		lineItem.Finance_Fee__c = p.Finance_Fee__c;
		lineItem.Installment_Specified__c = p.Installment_Specified__c;
		return lineItem;
	}

	public void setProducts(){
 		if(opportunityMap.isEmpty() && opportunityDiscountOnlyMap.isEmpty() && opportunityPaymentFieldMap.isEmpty()){
			return;
		}

		List<Product2> product2List =[SELECT Id, Description, School__c, Enrollment_Year__c, Enrolment_Term__c, Year_Grade__c, Boarding__c, Curriculum__c, Type__c, Unit_Price__c, Discount_Type__c, Discount__c, Sibling__c,
		Resource_No__c, Shortcut_Dimension_1_Code__c, Shortcut_Dimension_2_Code__c,Override__c, Payment_Plan__c, Number_of_Installments__c, Finance_Fee__c, Installment_Specified__c,(SELECT Id, UnitPrice FROM PricebookEntries WHERE IsActive = TRUE)
		FROM Product2
		WHERE IsActive = TRUE
		AND (School__c IN :schoolSet)
		AND (Enrollment_Year__c IN :enrollmentYearSet)];

		for(Product2 p : product2List){
			if(!subKeyPatternProducts.get(p.School__c).containsKey(p.Enrollment_Year__c)){
				continue;
			}
			String term = String.isBlank(p.Enrolment_Term__c) ? '': p.Enrolment_Term__c;
			String year = String.isBlank(p.Year_Grade__c) ? '': p.Year_Grade__c;
			String boarding = String.isBlank(p.Boarding__c) ? '': p.Boarding__c;
			String curriculum = String.isBlank(p.Curriculum__c) ? '': p.Curriculum__c;

			String keyPattern = p.School__c + p.Enrollment_Year__c + term + year + boarding + curriculum;

			if(p.Type__c == 'New Student Fee' || p.Type__c == 'Reenrolment Fee' || p.Type__c =='Discount'){
				keyPattern = p.Type__c == 'Discount' ? p.School__c + p.Enrollment_Year__c + p.Type__c: p.School__c + p.Enrollment_Year__c + boarding + p.Type__c;
				if(p.Type__c == 'Discount'){
					keyPattern = keyPattern + p.Discount_Type__c;
					if(p.Discount_Type__c == 'Sibling'){
						keyPattern = keyPattern + p.Sibling__c;
					}
					if(p.Discount_Type__c == 'Payment'){
						keyPattern += String.isBlank(p.Payment_Plan__c) ? '' : p.Payment_Plan__c;
					}
				}
			}else if(!String.isBlank(p.Payment_Plan__c) && p.Type__c == 'Fee'){
				keyPattern = p.School__c + p.Enrollment_Year__c + p.Type__c +p.Payment_Plan__c;
			}

			if(!subKeyPatternProducts.get(p.School__c).get(p.Enrollment_Year__c).containsKey(keyPattern)){
				subKeyPatternProducts.get(p.School__c).get(p.Enrollment_Year__c).put(keyPattern, new List<Product2>());
			}
			subKeyPatternProducts.get(p.School__c).get(p.Enrollment_Year__c).get(keyPattern).add(p);
		}
	}

	// Opportunities to apply tuition and fees
	private void getOpportunities(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap){

		Set<Id> recordTypes = BF_EnrollmentOpportunityConstants.ENROLMENT_SETTING_LIST_IDS;

		if(newOpportunities<>null){
			for(Opportunity opp : newOpportunities){
				if(recordTypes.contains(opp.RecordTypeId)){
					Boolean add = false;
					if(opp.Applied_Costs__c && !oldOpportunitiesMap.get(opp.Id)?.Applied_Costs__c){
						add = true;
						opportunityMap.put(opp.Id, opp);
					}
					if(opp.Apply_Discounts__c && !oldOpportunitiesMap.get(opp.Id)?.Apply_Discounts__c){
						if(opportunityMap.containsKey(opp.Id)){
							opportunityDiscountMap.put(opp.Id, opp);
						}else{
							add = true;
							opportunityDiscountOnlyMap.put(opp.Id, opp);
						}
					}

					Boolean fieldChange = !oldOpportunitiesMap.get(opp.Id)?.Early_Pay_Discount_460__c && !oldOpportunitiesMap.get(opp.Id)?.X1_Pay_Discount_460__c && !oldOpportunitiesMap.get(opp.Id)?.X2_Pay_Standard__c && !oldOpportunitiesMap.get(opp.Id)?.X10_Pay_Fee_340__c;
					fieldChange &= opp.Early_Pay_Discount_460__c || opp.X1_Pay_Discount_460__c || opp.X2_Pay_Standard__c || opp.X10_Pay_Fee_340__c;

					if(fieldChange){
						Schema.SObjectField field = opp.Early_Pay_Discount_460__c ? Opportunity.Early_Pay_Discount_460__c : opp.X1_Pay_Discount_460__c ? Opportunity.X1_Pay_Discount_460__c : opp.X2_Pay_Standard__c ? Opportunity.X2_Pay_Standard__c : opp.X10_Pay_Fee_340__c ? Opportunity.X10_Pay_Fee_340__c : null;
						opportunityPaymentFieldMap.put(opp.Id, field);

						if(opportunityDiscountMap.containsKey(opp.Id)){
							opportunityPaymentMap.put(opp.Id, opp);
						} else if(opportunityDiscountOnlyMap.containsKey(opp.Id)){
							opportunityDiscountAndPaymentMap.put(opp.Id, opp);
						} else{
							add = true;
							opportunityPaymentOnlyMap.put(opp.Id, opp);
						}
					}

					if(add){
						if(!subKeyPatternProducts.containsKey(opp.SchoolOfInterest__c)){
							subKeyPatternProducts.put(opp.SchoolOfInterest__c, new Map<String, Map<String, List<Product2>>>());
							schoolSet.add(opp.SchoolOfInterest__c);
						}
						if(!subKeyPatternProducts.get(opp.SchoolOfInterest__c).containsKey(opp.Enrolment_Year__c)){
							subKeyPatternProducts.get(opp.SchoolOfInterest__c).put(opp.Enrolment_Year__c, new Map<String, List<Product2>>());
							enrollmentYearSet.add(opp.Enrolment_Year__c);
						}
					}
				}
			}
		}
	}
}