public with sharing class SetupDatesController {
	
	public Invoice_Date_Settings__c settings { get; set; }
	public Map<String, Integer> months = new Map<String, Integer>();
	public List<String> monthList = new List<String>{ 'January', 'Febuary', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' };
	public List<String> signList  = new List<String>{ '=', '>', '>=', '<', '<=' };
	
	public String mthGenDay { get; set; }
	public String mthInvDay { get; set; }
	public String genT1Day { get; set; }
	public String invT1Day { get; set; }
	public String genT2Day { get; set; }
	public String invT2Day { get; set; }
	public String genT3Day { get; set; }
	public String invT3Day { get; set; }
	
	//Contructor : Setup a map of months with their number of days & get custom settings
	public SetupDatesController()
	{
		settings = Invoice_Date_Settings__c.getValues('Default');
		months.put('January', 31);
		months.put('Febuary', 28);
		months.put('March', 31);
		months.put('April', 30);
		months.put('May', 31);
		months.put('June', 30);
		months.put('July', 31);
		months.put('August', 31);
		months.put('September', 30);
		months.put('October', 31);
		months.put('November', 30);
		months.put('December', 31);
		
		mthGenDay = String.valueOf(Integer.valueOf(settings.Mth_Gen_Day__c));
		mthInvDay = String.valueOf(Integer.valueOf(settings.Mth_Inv_Day__c));
		
		genT1Day = String.valueOf(Integer.valueOf(settings.T1_Gen_Day__c));
		invT1Day = String.valueOf(Integer.valueOf(settings.T1_Inv_Day__c));
		genT2Day = String.valueOf(Integer.valueOf(settings.T2_Gen_Day__c));
		invT2Day = String.valueOf(Integer.valueOf(settings.T2_Inv_Day__c));
		genT3Day = String.valueOf(Integer.valueOf(settings.T3_Gen_Day__c));
		invT3Day = String.valueOf(Integer.valueOf(settings.T3_Inv_Day__c));
	}
	
	//Save the altered custom settings
	public PageReference save()
	{
		//All values must be converted from string to Integer
		settings.Mth_Gen_Day__c = Integer.valueOf(mthGenDay);
		settings.Mth_Inv_Day__c = Integer.valueOf(mthInvDay);
		
		settings.T1_Gen_Day__c = Integer.valueOf(genT1Day);
		settings.T1_Inv_Day__c = Integer.valueOf(invT1Day);
		settings.T2_Gen_Day__c = Integer.valueOf(genT2Day);
		settings.T2_Inv_Day__c = Integer.valueOf(invT2Day);
		settings.T3_Gen_Day__c = Integer.valueOf(genT3Day);
		settings.T3_Inv_Day__c = Integer.valueOf(invT3Day);
		
		//Ensure the terms are in ascending order ( t1 < t2 < t3 )
		Map<String, Integer> monthInt = new Map<String, Integer>();
		Integer i = 1;
		for(String mth : monthList)
		{
			monthInt.put(mth, i);
			i++;
		}
		Integer t1Mth = monthInt.get(settings.T1_Gen_Mth__c);
		Integer t2Mth = monthInt.get(settings.T2_Gen_Mth__c); 
		Integer t3Mth = monthInt.get(settings.T3_Gen_Mth__c);
		
		if( ((t1Mth < t2Mth) || (t1Mth == t2Mth && settings.T1_Gen_Day__c < settings.T2_Gen_Day__c)) &&
			((t2Mth < t3Mth) || (t2Mth == t3Mth && settings.T2_Gen_Day__c < settings.T3_Gen_Day__c)) )
		{
			update settings;
		}
		else {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'The invoicing terms must be in ascending order'));
		}
		return null;
	}
	
	
	//Get a Selectable list of months
	public List<SelectOption> getMonths()
	{
		List<SelectOption> options = new List<SelectOption>();
		for(String month : monthList)
		{
			options.add(new SelectOption(month, month));
		}
		return options;
	}
	
	
	//Get a Selectable list of days given the number of days in the months
	private List<SelectOption> getMonthDays(Integer days)
	{
		List<SelectOption> options = new List<SelectOption>();
		for(Integer i=1; i<=days; i++)
		{
			options.add(new SelectOption(String.valueOf(i), String.valueOf(i)));
		}
		return options;
	}
	
	public List<SelectOption> getMonthDays() { return getMonthDays(28); }
	//Get a Selectable list of days corrosponding to each sections Selected Month 
	public List<SelectOption> getMonthDays_GenT1() { return getMonthDays(months.get(settings.T1_Gen_Mth__c)); }
	public List<SelectOption> getMonthDays_InvT1() { return getMonthDays(months.get(settings.T1_Inv_Mth__c)); }
	public List<SelectOption> getMonthDays_GenT2() { return getMonthDays(months.get(settings.T2_Gen_Mth__c)); }
	public List<SelectOption> getMonthDays_InvT2() { return getMonthDays(months.get(settings.T2_Inv_Mth__c)); }
	public List<SelectOption> getMonthDays_GenT3() { return getMonthDays(months.get(settings.T3_Gen_Mth__c)); }
	public List<SelectOption> getMonthDays_InvT3() { return getMonthDays(months.get(settings.T3_Inv_Mth__c)); }
	
	//Get a Selectable list of signs (=, >, <, >=, <=)
	public List<SelectOption> getSigns()
	{
		List<SelectOption> options = new List<SelectOption>();
		for(String sign : signList)
		{
			options.add(new SelectOption(sign, sign));
		}
		return options;
	}
	
	/**				TEST METHODS			**/
	static testMethod void testSettingsSave()
	{
		//Setup the model
		//setup model
		Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getValues('Default');
		settings.Inc_Leave_Date__c = 40;		settings.Inc_Leave_sign__c = '>';
		settings.Inc_Start_Date__c = 90;		settings.Inc_Start_sign__c = '<=';
		settings.Inc_Month_Leave_Date__c = 40;	settings.Inc_Month_Leave_sign__c = '>';
		settings.Inc_Month_Start_Date__c = 90;	settings.Inc_Month_Start_sign__c = '<=';
		settings.Mth_Gen_Day__c = 25;			settings.Mth_Inv_Day__c = 1;
		settings.T1_Gen_Day__c = 15;	settings.T1_Gen_Mth__c = 'March';	settings.T1_Inv_Day__c = 15;	settings.T1_Inv_Mth__c = 'April';
		settings.T2_Gen_Day__c = 15;	settings.T2_Gen_Mth__c = 'July';	settings.T2_Inv_Day__c = 1;		settings.T2_Inv_Mth__c = 'August';
		settings.T3_Gen_Day__c = 15;	settings.T3_Gen_Mth__c = 'October';	settings.T3_Inv_Day__c = 15;	settings.T3_Inv_Mth__c = 'November';
		update settings;
		
		SetupDatesController sdc = new SetupDatesController();
		sdc.mthGenDay = '1';
		sdc.mthInvDay = '2';
		sdc.genT1Day = '3';
		sdc.invT1Day = '4';
		sdc.genT2Day = '5';
		sdc.invT2Day = '6';
		sdc.genT3Day = '7';
		sdc.invT3Day = '8';
		
		sdc.save();
		
		settings = Invoice_Date_Settings__c.getValues('Default');
		System.assertEquals(1, settings.Mth_Gen_Day__c);
		System.assertEquals(2, settings.Mth_Inv_Day__c);
		System.assertEquals(3, settings.T1_Gen_Day__c);
		System.assertEquals(4, settings.T1_Inv_Day__c);
		System.assertEquals(5, settings.T2_Gen_Day__c);
		System.assertEquals(6, settings.T2_Inv_Day__c);
		System.assertEquals(7, settings.T3_Gen_Day__c);
		System.assertEquals(8, settings.T3_Inv_Day__c);
	}
	
	static testMethod void boostCoverage()
	{
		//setup model
		Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getValues('Default');
		settings.Inc_Leave_Date__c = 40;		settings.Inc_Leave_sign__c = '>';
		settings.Inc_Start_Date__c = 90;		settings.Inc_Start_sign__c = '<=';
		settings.Inc_Month_Leave_Date__c = 40;	settings.Inc_Month_Leave_sign__c = '>';
		settings.Inc_Month_Start_Date__c = 90;	settings.Inc_Month_Start_sign__c = '<=';
		settings.Mth_Gen_Day__c = 25;			settings.Mth_Inv_Day__c = 1;
		settings.T1_Gen_Day__c = 15;	settings.T1_Gen_Mth__c = 'March';	settings.T1_Inv_Day__c = 15;	settings.T1_Inv_Mth__c = 'April';
		settings.T2_Gen_Day__c = 15;	settings.T2_Gen_Mth__c = 'July';	settings.T2_Inv_Day__c = 1;		settings.T2_Inv_Mth__c = 'August';
		settings.T3_Gen_Day__c = 15;	settings.T3_Gen_Mth__c = 'October';	settings.T3_Inv_Day__c = 15;	settings.T3_Inv_Mth__c = 'November';
		update settings;
		
		SetupDatesController sdc = new SetupDatesController();
		sdc.getMonths();
		sdc.getMonthDays();
		sdc.getSigns();
		sdc.getMonthDays_GenT1();
		sdc.getMonthDays_InvT1();
		sdc.getMonthDays_GenT2();
		sdc.getMonthDays_InvT2();
		sdc.getMonthDays_GenT3();
		sdc.getMonthDays_InvT3();
	}
}