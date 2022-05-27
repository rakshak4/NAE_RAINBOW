public with sharing class OtherFee {

    public enum FeeType { Tuition, Other, All }
    
    //Variables
    public Opportunity student      { get; set; }
    public String fee               { get; set; }
    public String payer             { get; set; } 
    public String months            { get; set; } 
    public String term              { get; set; } 
    public String nextGenInvoice    { get; set; }
    public String discount          { get; set; }
    public Boolean tuition          { get; set; }
    public Boolean nextYearFee      { get; set; }
    public FeeType type             { get; set; }
    public Map<String,Date> dateMap { get; set; }

    // Used to provide date entry fields
    public OpportunityLineItem dateSource { get; set; }

    private List<String> allMonths = new List<String> { 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' };
    
    //fee = PriceBookEntryId (fee can be null), oppor = The student that owns this fee, Tuition = if this fee is tuition or other. 
    public OtherFee(String fee, Decimal disPerc, Opportunity oppor, Boolean tuition) 
    {
        this.fee = fee;
        this.student = oppor;
        this.tuition = tuition;
        this.nextYearFee = false;
        //initialize to a 10 monthly fee 
        this.dateMap = new Map<String, Date>();
        this.term = 'Monthly';
        this.months = '10';
        this.discount = (disPerc == null) ? '0' : String.valueOf(disPerc);

        dateSource = new OpportunityLineItem();
        dateSource.Invoice_Date__c = null;
        dateSource.Due_Date__c = null;
        dateSource.Next_Generated_Invoice__c = null;

        getNextGenInvoiceOptions();
    }

    public OtherFee(String fee, Decimal disPerc, Opportunity oppor, FeeType type) 
    {
        this.fee = fee;
        this.student = oppor;
        this.type = type;
        this.tuition = type != FeeType.Other;
        this.nextYearFee = false;
        //initialize to a 10 monthly fee 
        this.dateMap = new Map<String, Date>();
        this.term = 'Monthly';
        this.months = '10';
        this.discount = (disPerc == null) ? '0' : String.valueOf(disPerc);

        dateSource = new OpportunityLineItem();
        dateSource.Invoice_Date__c = null;
        dateSource.Due_Date__c = null;
        dateSource.Next_Generated_Invoice__c = null;
        
        getNextGenInvoiceOptions();
    }
    
    //Get the list of fees avaliable filtered by the selected Term, month and the current Opportunites year group
    public List<SelectOption> getFeeOptions() 
    {
        List<SelectOption> options = new List<SelectOption>();
        if(student.Pricebook2Id != null)
        {
            options.add(new SelectOption('', '--None--'));
            // add the current tuition fee first incase the year is different from the 
            try {
                PriceBookEntry currPbe = [ 
                    SELECT Id, Name, PriceBook2Id, UnitPrice, Product2Id, 
                            Product2.Year_Group__c, Product2.Fee_Frequency__c , Product2.Half_Day__c
                      FROM PriceBookEntry 
                     WHERE Id =: this.fee 
                     limit 1
                ];
                options.add(new SelectOption(currPbe.Id, currPbe.Name));
            }
            catch(Exception e) { }
        
            if(this.term != 'Monthly') this.months = null;
            String yrGroup = (tuition) ? student.Year_Group__c : null;
            //Setup all the other products
            List<PriceBookEntry> otherFees = new List<PricebookEntry>();
            if (type == FeeType.All) {
                otherFees = [
                    SELECT Id, Name, PriceBook2Id, UnitPrice, Product2Id, Product2.Year_Group__c, Product2.Fee_Frequency__c, Product2.Half_Day__c
                    FROM PriceBookEntry
                    WHERE PriceBook2Id =: student.Pricebook2Id
                    AND Product2.Fee_Frequency__c =: this.term
                    AND Product2.Fee_Season__c =: this.months
                    AND Id !=: this.fee Order by Name
                ];
            } else {
                otherFees = [
                    SELECT Id, Name, PriceBook2Id, UnitPrice, Product2Id, Product2.Year_Group__c, Product2.Fee_Frequency__c, Product2.Half_Day__c
                    FROM PriceBookEntry
                    WHERE PriceBook2Id =: student.Pricebook2Id
                    AND Product2.Year_Group__c =: yrGroup
                    AND Product2.Fee_Frequency__c =: this.term
                    AND Product2.Fee_Season__c =: this.months
                    AND Id !=: this.fee Order by Name
                ];
            }
            for(PriceBookEntry pbe : otherFees)
            {
                if(tuition == true){
                    if(student.Half_Day_PN_N_Checkbox__c == true && pbe.Product2.Half_Day__c == true){
                        options.add(new SelectOption( pbe.Id, pbe.Name ));
                    }else if(student.Half_Day_PN_N_Checkbox__c != true && pbe.Product2.Half_Day__c == false){
                        options.add(new SelectOption( pbe.Id, pbe.Name ));
                    }
                }else{
                    options.add(new SelectOption( pbe.Id, pbe.Name ));
                }
            }
        }
        return options;
    }
    
    //Returns the choice of either 10 or 12 months options
    public List<SelectOption> getMonthsOptions() 
    {   
        List<SelectOption> options = new List<SelectOption>();
        if(this.term == 'Monthly')
        {
            options.add(new SelectOption('10', '10'));
            options.add(new SelectOption('11', '11'));
            options.add(new SelectOption('12', '12'));
        }
        return options;
    }
    
    //Returns the choice of Monthly, Termly or Yearly invoicing term
    public List<SelectOption> getTermOptions() 
    {   
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Monthly', 'Monthly'));
        options.add(new SelectOption('Termly', 'Termly'));
        options.add(new SelectOption('Yearly', 'Yearly'));
        return options;
    }

    //Return a list of the next 3 periods avaliable for invoice generation
    public List<SelectOption> getNextGenInvoiceOptions() {
        
        List<Date> finalDates = new List<Date>();
        List<SelectOption> options = new List<SelectOption>();
        this.dateMap.clear();
        
        String invTerm = (term == 'Yearly') ? 'Termly' : term;
        finalDates.add( InvoiceDateGeneration.getNextGeneratedDate(invTerm, months, System.today()) );
        finalDates.add( InvoiceDateGeneration.getNextGeneratedDate(invTerm, months, finalDates.get(0).addDays(1)) );
        finalDates.add( InvoiceDateGeneration.getNextGeneratedDate(invTerm, months, finalDates.get(1).addDays(1)) );
        finalDates.add( InvoiceDateGeneration.getNextGeneratedDate(invTerm, months, finalDates.get(2).addDays(1)) );
        finalDates.add( InvoiceDateGeneration.getNextGeneratedDate(invTerm, months, finalDates.get(3).addDays(1)) );
        finalDates.add( InvoiceDateGeneration.getNextGeneratedDate(invTerm, months, finalDates.get(4).addDays(1)) );
        
        for(Date dt : finalDates) 
        {
            String dateStr = dateToString(dt);
            options.add(new SelectOption(dateStr, dateStr));
            this.dateMap.put(dateStr, dt);
        }
        
        if(this.nextGenInvoice != options.get(0).getLabel() && this.nextGenInvoice != options.get(1).getLabel() && 
            this.nextGenInvoice != options.get(2).getLabel() && this.nextGenInvoice != options.get(3).getLabel() &&
            this.nextGenInvoice != options.get(4).getLabel() && this.nextGenInvoice != options.get(5).getLabel())
        {
             this.nextGenInvoice = options.get(0).getLabel();
        }
        
        return options;
    }
    
    //Using the selected next generated invoice option, get the date of the next invoice
    public String getNextInvoice() 
    {
        getNextGenInvoiceOptions();
        System.debug('### start');
        if(this.nextGenInvoice != null)
        {
            System.debug('### nxtInv '+nextGenInvoice);
            return dateToString( InvoiceDateGeneration.getNextInvoiceDate(term, this.dateMap.get(this.nextGenInvoice)) );
        }
        return '';
    }
    
    //Convert a Date to a readable string.
    public String dateToString(Date dt) {
        return (dt == null) ? '' : dt.day() +(dt.day() == 1 ? 'st ' : 'th ') +allMonths.get(dt.month()-1) +' ' +dt.year();
    }
    
    /**             TEST METHODS            **/
    @IsTest(SeeAllData=true)
    static void coverage()
    {
        //setup model
        Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getInstance('Default');
        settings.Inc_Leave_Date__c = 40;        settings.Inc_Leave_sign__c = '>';
        settings.Inc_Start_Date__c = 90;        settings.Inc_Start_sign__c = '<=';
        settings.Inc_Month_Leave_Date__c = 40;  settings.Inc_Month_Leave_sign__c = '>';
        settings.Inc_Month_Start_Date__c = 90;  settings.Inc_Month_Start_sign__c = '<=';
        settings.Mth_Gen_Day__c = 25;           settings.Mth_Inv_Day__c = 1;
        settings.T1_Gen_Day__c = 15;    settings.T1_Gen_Mth__c = 'March';   settings.T1_Inv_Day__c = 15;    settings.T1_Inv_Mth__c = 'April';
        settings.T2_Gen_Day__c = 15;    settings.T2_Gen_Mth__c = 'July';    settings.T2_Inv_Day__c = 1;     settings.T2_Inv_Mth__c = 'August';
        settings.T3_Gen_Day__c = 15;    settings.T3_Gen_Mth__c = 'October'; settings.T3_Inv_Day__c = 15;    settings.T3_Inv_Mth__c = 'November';
        update settings;
        
        Account payer = new Account(Name = 'Test');
        insert payer;
        Pricebook2 pb = [Select Id, Name from Pricebook2 where IsStandard = true limit 1];
        Opportunity student = new Opportunity(Name = 'Test Student', Gender__c = 'Male',  StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                Student_Name__c = 'Morgan',  PriceBook2Id = pb.Id);
        insert student;
        student.StageName = 'Enrolled';
        update student;
        
        
        student = [Select Id, Half_Day_PN_N__c, Half_Day_PN_N_Checkbox__c, Year_Group__c,  Pricebook2Id From Opportunity Where Id =: student.Id];
        //Preload a tuition line item
        Product2 prod1 = new Product2();
        prod1.IsActive = true;
        prod1.Name = 'prod1';
        prod1.Year_Group__c = 'Y1';
        prod1.Invoice_Currency__c = 'EUR';
        prod1.Description = 'Monthly, Termly or Yearly';
        prod1.Fee_Frequency__c = 'Monthly';
        prod1.Description_of_fee__c = 'Other';
        insert prod1;
        prod1 = [select Id from Product2 Where Id =: prod1.Id];
        
        PricebookEntry pbe1 = new PriceBookEntry();
        pbe1.isActive = true;
        pbe1.UnitPrice = 1.0;
        pbe1.Pricebook2Id = pb.Id;
        pbe1.Product2Id = prod1.Id;
        insert pbe1;
        
        OtherFee fee = new OtherFee(pbe1.Id, 0.0, student, true);
        fee.getFeeOptions();
        fee.getMonthsOptions();
        fee.getNextGenInvoiceOptions();
        fee.getNextInvoice();
        fee.getTermOptions();
    }
}