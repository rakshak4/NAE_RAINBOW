global class InvoiceDateGeneration {
	
	//Get the next Invoice Generation Date from the given Date relative to the term and months in year 
	global static Date getNextGeneratedDate(String invoiceTerm, String monthsInYear, Date dt) {
		
		Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getValues('Default');
		Map<String, Integer> months = getMonthMap();
		
		Integer day 	= dt.day();
		Integer month 	= dt.month();
		Integer year 	= dt.year();
		
		//Monthly term is handled differently than Termly or Yearly
		if(invoiceTerm == 'Monthly') {
			if(day > settings.Mth_Gen_Day__c)
			{
				month++;
				if(month == 13) {
					month = 1;
					year ++;
				}
			}
		    
            // Skip June + July if months in year is 10
			if(monthsInYear == '10' && (month == 6 || month == 7))
				month = 8;
			
            // Skip July if months in year is 11
            else if(monthsInYear == '11' && month == 7)
                month = 8;

			day = Integer.valueOf(settings.Mth_Gen_Day__c);
		}
		else if(invoiceTerm == 'Termly') {
			//Get variables to make the next part more readable
			Integer t1Mth = months.get(settings.T1_Gen_Mth__c);
			Integer t1Day = Integer.valueOf(settings.T1_Gen_Day__c);
			Integer t2Mth = months.get(settings.T2_Gen_Mth__c);
			Integer t2Day = Integer.valueOf(settings.T2_Gen_Day__c);
			Integer t3Mth = months.get(settings.T3_Gen_Mth__c);
			Integer t3Day = Integer.valueOf(settings.T3_Gen_Day__c);
			//Now get the correct month & day
			if((month > t3Mth || (month == t3Mth && day > t3Day)) || (month < t1Mth || (month == t1Mth && day <= t1Day))) {
				if((month > t3Mth) || (month == t3Mth && day > t3Day)) 
					year ++;
				month 	= t1Mth;
				day 	= t1Day;
			}
			else if(((month > t1Mth) || (month == t1Mth && day > t1Day)) && (month < t2Mth || (month == t2Mth && day <=t2Day))) {
				month 	= t2Mth;
				day 	= t2Day;
			}
			else if(((month > t2Mth) || (month == t2Mth && day > t2Day)) && (month < t3Mth || (month == t3Mth && day <= t3Day))) {
				month 	= t3Mth;
				day 	= t3Day;
			}
		}
		else if(invoiceTerm == 'Yearly') {
			// if yearly run invocie generation equivalent to 3 terms
			Date incrementDate = dt;
			incrementDate = InvoiceDateGeneration.getNextGeneratedDate('Termly', '', incrementDate);
			incrementDate = InvoiceDateGeneration.getNextGeneratedDate('Termly', '', incrementDate.addDays(1));
			incrementDate = InvoiceDateGeneration.getNextGeneratedDate('Termly', '', incrementDate.addDays(1));
			
			return incrementDate;
		}
		return Date.newInstance(year, month, day);
	}
	
	global static Date getNextInvoiceDate(String invoiceTerm, Date dt) {
		
		if(dt != null) {
			Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getValues('Default');
			Map<String, Integer> months = getMonthMap();
			Integer day 	= dt.day();
			Integer month 	= dt.month();
			Integer year 	= dt.year();
			
			if(invoiceTerm == 'Monthly') {
				day = Integer.valueOf(settings.Mth_Inv_Day__c);
				month++;
				if(month == 13) {
					month = 1;
					year ++;
				}
			}
			else {
				//Get variables to make the next part more readable
				Integer t1Mth = months.get(settings.T1_Gen_Mth__c);			Integer t1InvMth = months.get(settings.T1_Inv_Mth__c);
				Integer t1Day = Integer.valueOf(settings.T1_Gen_Day__c);	Integer t1InvDay = Integer.valueOf(settings.T1_Inv_Day__c);
				Integer t2Mth = months.get(settings.T2_Gen_Mth__c);			Integer t2InvMth = months.get(settings.T2_Inv_Mth__c);
				Integer t2Day = Integer.valueOf(settings.T2_Gen_Day__c);	Integer t2InvDay = Integer.valueOf(settings.T2_Inv_Day__c);
				Integer t3Mth = months.get(settings.T3_Gen_Mth__c);			Integer t3InvMth = months.get(settings.T3_Inv_Mth__c);
				Integer t3Day = Integer.valueOf(settings.T3_Gen_Day__c);	Integer t3InvDay = Integer.valueOf(settings.T3_Inv_Day__c);
				//Get which term the date is equal to
				if(month == t1Mth && day == t1Day) {
					month = t1InvMth;
					day = t1InvDay;
					if(t1InvMth < t1Mth)
						year++;
				}
				else if(month == t2Mth && day == t2Day) {
					month = t2InvMth;
					day = t2InvDay;
					if(t2InvMth < t2Mth)
						year++;
				}
				else if(month == t3Mth && day == t3Day) {
					month = t3InvMth;
					day = t3InvDay;
					if(t3InvMth < t3Mth)
						year++;
				}
			}
			
			return Date.newInstance(year, month, day);
		}
		else
			return null;
	}
	
	//Get a map of Month strings to their respective Integer values
	private static Map<String, Integer> getMonthMap()
	{
		Map<String, Integer> months = new Map<String, Integer>();
		months.put('January', 1);	months.put('July', 7);
		months.put('Febuary', 2);	months.put('August', 8);
		months.put('March', 3);		months.put('September', 9);
		months.put('April', 4);		months.put('October', 10);
		months.put('May', 5);		months.put('November', 11);
		months.put('June', 6);		months.put('December', 12);
		return months;
	}
	
	/**				TEST METHODS			**/
    @IsTest(SeeAllData=true)
	static void testCoverage() { 
		
		//setup model
		Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getInstance('Default');
		settings.Inc_Leave_Date__c = 40;		settings.Inc_Leave_sign__c = '>';
		settings.Inc_Start_Date__c = 90;		settings.Inc_Start_sign__c = '<=';
		settings.Inc_Month_Leave_Date__c = 40;	settings.Inc_Month_Leave_sign__c = '>';
		settings.Inc_Month_Start_Date__c = 90;	settings.Inc_Month_Start_sign__c = '<=';
		settings.Mth_Gen_Day__c = 25;			settings.Mth_Inv_Day__c = 1;
		settings.T1_Gen_Day__c = 15;	settings.T1_Gen_Mth__c = 'March';	settings.T1_Inv_Day__c = 15;	settings.T1_Inv_Mth__c = 'April';
		settings.T2_Gen_Day__c = 15;	settings.T2_Gen_Mth__c = 'July';	settings.T2_Inv_Day__c = 1;		settings.T2_Inv_Mth__c = 'August';
		settings.T3_Gen_Day__c = 15;	settings.T3_Gen_Mth__c = 'October';	settings.T3_Inv_Day__c = 15;	settings.T3_Inv_Mth__c = 'November';
		update settings;
		
		Date gen1 = getNextGeneratedDate('Monthly', '10', Date.newInstance(2011, 6, 1));
		Date inv1 = getNextInvoiceDate('Monthly', gen1);
		System.assertEquals(gen1, Date.newInstance(2011, 8, 25));
		System.assertEquals(inv1, Date.newInstance(2011, 9, 1));
		
		Date gen2 = getNextGeneratedDate('Termly', '', Date.newInstance(2011, 1, 1));
		Date inv2 = getNextInvoiceDate('Termly', gen2);
		System.assertEquals(gen2, Date.newInstance(2011, 3, 15));
		System.assertEquals(inv2, Date.newInstance(2011, 4, 15));
		
		Date gen3 = getNextGeneratedDate('Yearly', '', Date.newInstance(2011, 8, 1));
		Date inv3 = getNextInvoiceDate('Yearly', gen3);
		System.assertEquals(gen3, Date.newInstance(2012, 7, 15));
		System.assertEquals(inv3, Date.newInstance(2012, 8, 1));
	}
}