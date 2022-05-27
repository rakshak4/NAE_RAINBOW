public with sharing class SingleInvoiceFee {

	//Variables
	public Boolean tuition			{ get; set; }
	public String pricebook2Id		{ get; set; }
	public List<Student> students	{ get; set; }
	
	public String fee				{ get; set; }
	public String term				{ get; set; }
	public String discount			{ get; set; }

	private List<String> allMonths = new List<String> { 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' };
	
	//fee = PriceBookEntryId (fee can be null), oppor = The student that owns this fee, Tuition = if this fee is tuition or other. 
	public class Student
	{
		public Boolean isSelected 	{ get; set; }
		public Opportunity opp		{ get; set; }
		
		public Student( Opportunity opp ) 
		{
			this.opp 		= opp;
			this.isSelected	= false;	
		}
	}
	
	public SingleInvoiceFee( Boolean tuition, String Pricebook2Id, List<Opportunity> opportunities ) 
	{
		this.fee 			= '';
		this.tuition		= tuition;
		this.pricebook2Id 	= pricebook2Id;
		this.students 		= new List<Student>();
		
		for( Opportunity opp : opportunities ) 
		{
			students.add( new Student( opp ) );
		}
		
		//initialize to a 10 monthly fee 
		if(this.tuition == true){
			this.term = 'Recurring';
		}else{
			this.term 		= 'One_Off';
		}
		this.discount 	= '0';
	}
	
	//Get the list of fees avaliable filtered by the selected Term, month and the current Opportunites year group
	public List<SelectOption> getFeeOptions() 
	{
		List<SelectOption> options = new List<SelectOption>{
			new SelectOption('', '--None--')
		};
		
		List<PricebookEntry> pbes = new List<PricebookEntry>(); 
		String yrGroup = ( this.tuition && this.students.size() == 1 ) ? this.students.get(0).opp.Invoice_Year_Group__c : null;
		boolean isOppHalfPNN = ( this.tuition && this.students.size() == 1 ) ? this.students.get(0).opp.Half_Day_PN_N_CheckBox__c : false;
		if( this.term == 'Recurring' )
		{
			pbes.addAll([ 
				SELECT Id, Name, PriceBook2Id, UnitPrice, Product2Id, Product2.Year_Group__c, Product2.Fee_Frequency__c,
						Product2.Description_of_fee__c, Product2.Half_Day__c 
				  FROM PriceBookEntry 
				 WHERE Product2.Fee_Frequency__c !=: 'One Off'
				   AND Product2.Year_Group__c =: yrGroup 
				   AND PriceBook2Id =: this.pricebook2Id
			     order by Name
			]);
		}
		else if( this.term == 'One_Off' ) 
		{
			pbes.addAll([ 
				SELECT Id, Name, PriceBook2Id, UnitPrice, Product2Id, Product2.Year_Group__c, Product2.Fee_Frequency__c,
						Product2.Description_of_fee__c,  Product2.Half_Day__c 
				  FROM PriceBookEntry 
				 WHERE Product2.Fee_Frequency__c =: 'One Off'
				   AND Product2.Year_Group__c =: yrGroup 
				   AND PriceBook2Id =: this.pricebook2Id
			     order by Name
			]);
		}
		
		//Setup all the other products
		for(PriceBookEntry pbe : pbes) 
		{ 
			if(tuition == true ){
				if(isOppHalfPNN == true && pbe.Product2.Half_Day__c == true){
					options.add(new SelectOption( pbe.Id, pbe.Name ));
				}else if(isOppHalfPNN != true && pbe.Product2.Half_Day__c == false){
					options.add(new SelectOption( pbe.Id, pbe.Name ));
				}
			}else{
				options.add(new SelectOption( pbe.Id, pbe.Name ));
			}
		}
		return options;
	}
	
	//Returns the choice of Monthly, Termly or Yearly invoicing term
	public List<SelectOption> getTermOptions() 
	{	
		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('One_Off', 'One Off'));
		options.add(new SelectOption('Recurring', 'Recurring'));
		return options;
	}
}