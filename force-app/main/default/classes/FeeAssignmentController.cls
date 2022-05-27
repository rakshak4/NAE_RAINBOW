public with sharing class FeeAssignmentController {
    
    public Opportunity      student     { get; set; }
    
    //Selectable fields
    public Boolean          priceBookUnset { get; set; }
    public String           priceBook   { get; set; }
    
    //Fields for selecting all fees and their payers
    public OtherFee         tuitionFee          { get; set; }
    public OtherFee         newOtherFee         { get; set; }
    public OtherFee         newCustomYearlyFee  { get; set; }
    public List<OtherFee>   otherFees           { get; set; }
    public List<OtherFee>   customYearlyFees    { get; set; }
    
    //Constructor
    public FeeAssignmentController(ApexPages.StandardController sc) {
        
        this.student   = (Opportunity)sc.getRecord();
        this.student   = [Select Id, Half_Day_PN_N__c,Half_Day_PN_N_Checkbox__c, AccountId, Pricebook2Id, Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c, Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__r.Name, Year_Group__c From Opportunity Where Id =: student.Id];
        this.priceBook = student.Pricebook2Id;

        // If a pricebook hasn't been set, we set the priceBookUnset variable to true so that the pricbook selection
        // will be displayed and maintained until the user sets a pricebook.
        if (this.priceBook == null || this.priceBook == '') {
            priceBookUnset = true;
        }
        
        initOtherFees();

        //Create a new fee so items can be added
        this.newOtherFee        = new OtherFee(null, 0 ,this.student, false);

        //Create a new custom yearly fee so items can be added
        this.newCustomYearlyFee = new OtherFee(null, 0 ,this.student, OtherFee.FeeType.All); 
        this.newCustomYearlyFee.term = 'Yearly';
        this.newCustomYearlyFee.months = null;

        //and a tuition fee if one doesnt exist yet
        if(this.tuitionFee == null)
            this.tuitionFee = new OtherFee(null, 0 ,this.student, true);
    }
    
    private void initOtherFees()
    {
        //Run through all Opportunity Line Items related to the Opportunity and create a fee object for it
        this.otherFees = new List<OtherFee>();
        this.customYearlyFees = new List<OtherFee>();
        for(OpportunityLineItem oli : [Select Id, PricebookEntryId, Current__c, Custom__c, Next_Year_Fee__c, Due_Date__c, Payer__c, Invoice_Date__c, Invoicing_Term__c, Months_In_Year__c, Next_Generated_Invoice__c, Tuition__c,
                                         Discount from OpportunityLineItem Where OpportunityId =: this.student.id and Current__c =: true])
        {
            OtherFee.FeeType feeType = oli.Custom__c ? OtherFee.FeeType.All : oli.Tuition__c ? OtherFee.FeeType.Tuition : OtherFee.FeeType.Other;
            System.debug('## oli : ' + oli);
            OtherFee fee = new OtherFee(oli.PricebookEntryId, oli.Discount, student, feeType); 
            fee.payer = oli.Payer__c;
            fee.months = oli.Months_In_Year__c;
            fee.term = oli.Invoicing_Term__c;
            fee.nextGenInvoice = fee.dateToString(oli.Next_Generated_Invoice__c);
            //Differentiate between tuition & other & custom fee
            if(oli.Tuition__c)
                this.tuitionFee = fee;
            else if( oli.Custom__c == true ) {
                fee.dateSource.Next_Generated_Invoice__c = oli.Next_Generated_Invoice__c;
                fee.dateSource.Invoice_Date__c = oli.Invoice_Date__c;
                fee.dateSource.Due_Date__c = oli.Due_Date__c;
                fee.nextYearFee = oli.Next_Year_Fee__c;

                this.customYearlyFees.add(fee);
            }
            else
                this.otherFees.add(fee);
        }
    }

    public Boolean getOppHasPriceBook()
    {
        return (this.student.priceBook2Id != null);
    }
    
    public Boolean getDifferingPriceBook()
    {
        //If the pricebook has been changed clear all currently selected fees
        if(this.student.priceBook2Id != null && this.student.priceBook2Id != this.priceBook)
        {
            this.tuitionFee.fee = null;
            for(OtherFee fee : this.otherFees)
            {
                fee.fee = null;
            }
            getOtherFeesView();
            return true;
        }
        else
        {
            return false;
        }
    }
    
    //Get the two possible Accounts related to the Opportunity
    public List<SelectOption> getPayerOptions() {
        
        List<SelectOption> options = new List<SelectOption>();
        if(student.Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c != null)
            options.add(new SelectOption(student.Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c, student.Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__r.Name));
        if(student.AccountId != null)
        {
            Account acc = [Select Id, Name From Account Where Id =: student.AccountId limit 1];
            options.add(new SelectOption(acc.Id, acc.Name));
        }
        return options;
    }
    
    //Get a list of the pricebooks avaliable 
    public List<SelectOption> getPriceBookOptions() {
        
        List<SelectOption> options = new List<SelectOption>();
        for(PriceBook2 pb : [ Select Id, Name, IsActive From PriceBook2 Where isActive =: true]) {
            options.add(new SelectOption( pb.Id, pb.Name ));
        }
        return options;
    }
    
    //Load the list of Other fees, if there is any fees set to null then remove them
    //If a fee has been selected for new fee the add it to the list and empty new fee.
    public List<OtherFee> getOtherFeesView()
    {
        //Add a new fee if one has been selected
        if(this.newOtherFee.fee != null)
        {
            otherFees.add(this.newOtherFee);
            this.newOtherFee = new OtherFee(null, 0, this.student, false);
        }
        //Remove any fees that are now --None--
        List<OtherFee> nonNullFees = new List<OtherFee>();
        for(OtherFee fee : otherFees)
        {
            if(fee.fee != null) nonNullFees.add(fee);
        }
        otherFees.clear();
        otherFees.addAll(nonNullFees);
        
        return otherFees;
    }

    //Load the list of Custom Yearly fees, if there is any fees set to null then remove them
    //If a fee has been selected for new fee the add it to the list and empty new fee.
    public List<OtherFee> getCustomYearlyFeesView()
    {
        //Add a new fee if one has been selected
        if(this.newCustomYearlyFee.fee != null)
        {
            customYearlyFees.add(this.newCustomYearlyFee);
            this.newCustomYearlyFee = new OtherFee(null, 0, this.student, OtherFee.FeeType.All);
            this.newCustomYearlyFee.term = 'Yearly';
            this.newCustomYearlyFee.months = null;
        }
        //Remove any fees that are now --None--
        List<OtherFee> nonNullFees = new List<OtherFee>();
        for(OtherFee fee : customYearlyFees)
        {
            if(fee.fee != null) nonNullFees.add(fee);
        }
        customYearlyFees.clear();
        customYearlyFees.addAll(nonNullFees);
        
        return customYearlyFees;
    }
    
    //Save methods and redirect to the Opportunity page.
    public PageReference saveDontRedirect() {
        
        String error = saveOpp();
        if(error != null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, error));
        }
        return null;
    }
    public PageReference saveRedirect() {
        
        String error = saveOpp();
        if(error == null)
            return redirect();
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, error));
            return null;
        }
    }
    public PageReference redirect()
    {
        return new PageReference('/' + student.Id);
    }
    
    //Save all variables to the opportunite, remove all old opportunity line itmes and add all new opportunity line items
    public String saveOpp() {
        
        try {
            getOtherFeesView();
            getCustomYearlyFeesView();
            
            Map<String, PriceBookEntry> allPBEs = new Map<String, PriceBookEntry>();
            for(PriceBookEntry pbe : [Select Id, Product2Id, PriceBook2Id, UnitPrice from PriceBookEntry where PriceBook2Id =:student.Pricebook2Id])
            {
                allPBEs.put(pbe.Id, pbe);
            } 
            
            List<OpportunityLineItem> newOLIs = new List<OpportunityLineItem>();

            //Create new Line Items for each Other item thats been selected
            for(OtherFee fee : otherFees)
            {
                if(fee.fee != null)
                {
                    PriceBookEntry pbe = allPbes.get(fee.fee);
                    OpportunityLineItem oli = new OpportunityLineItem();
                    oli.PricebookEntryId = pbe.Id;
                    oli.UnitPrice = pbe.UnitPrice;
                    oli.Quantity = 1;
                    oli.OpportunityId = this.student.Id;
                    oli.Current__c = true;
                    oli.Custom__c = false;
                    oli.Due_Date__c = null;
                    
                    oli.Discount = Decimal.valueOf(fee.discount);
                    oli.Tuition__c = fee.tuition;
                    oli.Payer__c = fee.payer;
                    oli.Invoicing_Term__c = fee.term;
                    oli.Months_In_Year__c = fee.months;
                    oli.Next_Generated_Invoice__c = fee.dateMap.get(fee.nextGenInvoice);
                    oli.Invoice_Date__c = InvoiceDateGeneration.getNextInvoiceDate(fee.term, fee.dateMap.get(fee.nextGenInvoice));
                    newOLIs.add(oli);
                } 
                
            }
            //Create new Line Items for each Custom Yearly item thats been selected
            for(OtherFee fee : customYearlyFees)
            {
                if(fee.fee != null)
                {
                    PriceBookEntry pbe = allPbes.get(fee.fee);
                    OpportunityLineItem oli = new OpportunityLineItem();
                    oli.PricebookEntryId = pbe.Id;
                    oli.UnitPrice = pbe.UnitPrice;
                    oli.Quantity = 1;
                    oli.OpportunityId = this.student.Id;
                    oli.Current__c = true;
                    oli.Custom__c = true;
                    oli.Tuition__c = false;
                    oli.Invoicing_Term__c = 'Yearly';

                    oli.Discount = Decimal.valueOf(fee.discount);
                    oli.Next_Year_Fee__c = fee.nextYearFee;
                    oli.Payer__c = fee.payer;
                    oli.Due_Date__c = fee.dateSource.Due_Date__c;
                    oli.Next_Generated_Invoice__c = fee.dateSource.Next_Generated_Invoice__c;
                    oli.Invoice_Date__c = fee.dateSource.Invoice_Date__c;

                    newOLIs.add(oli);
                }
                
            }
            //Create a new Line Item for the current Tuition fee
            if(this.tuitionFee.fee != null)
            {
                PriceBookEntry pbe = [Select Id, Name, PriceBook2Id, UnitPrice, Product2Id, Product2.Year_Group__c, Product2.Fee_Frequency__c From PriceBookEntry Where Id =: this.tuitionFee.fee ];
                if(pbe != null)
                {
                    OpportunityLineItem oli = new OpportunityLineItem();
                    oli.PricebookEntryId = pbe.Id;
                    oli.OpportunityId = this.student.Id;
                    oli.Quantity = 1;
                    oli.UnitPrice = pbe.UnitPrice;
                    oli.Current__c = true;
                    oli.Custom__c = false;
                    oli.Due_Date__c = null;
                    
                    oli.Discount = (tuitionFee.discount == null) ? 0 : Decimal.valueOf(tuitionFee.discount);
                    oli.Tuition__c = tuitionFee.tuition;
                    oli.Payer__c = tuitionFee.payer;
                    oli.Invoicing_Term__c = tuitionFee.term;
                    oli.Months_In_Year__c = tuitionFee.months;
                    oli.Next_Generated_Invoice__c = tuitionFee.dateMap.get(tuitionFee.nextGenInvoice);
                    oli.Invoice_Date__c = InvoiceDateGeneration.getNextInvoiceDate(tuitionFee.term, tuitionFee.dateMap.get(tuitionFee.nextGenInvoice));

                    newOLIs.add(oli);
                }
            }
            
            //Get the OLIs that are currently related to the Case and remove them
            List<OpportunityLineItem> currOLIs = new List<OpportunityLineItem>();
            currOLIs.addAll([Select Id, PricebookEntryId, Current__c, Payer__c from OpportunityLineItem Where OpportunityId =: this.student.id and Current__c =: true]);
            delete currOLIs;
            
            //If the pricebook is being changed then all OpplineItems must be deleted
            if(student.Pricebook2Id != priceBook)
            {
                delete [Select Id, OpportunityId from OpportunityLineItem Where OpportunityId =: this.student.id];
            }
            
            //Perform insertions/update
            student.Pricebook2Id = priceBook;
            update student;
            insert newOLIs;
            
            initOtherFees();
            return null;
        }
        catch (Exception e) {
            System.debug('### err ' +e.getMessage());
            return e.getMessage();
        }
    }
    
    /**             TEST METHODS            **/
    @IsTest(SeeAllData=True)
    static void testOpportunitySave() {
        
        //Setup model
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
        Opportunity student = new Opportunity(Name = 'Test Student', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                Student_Name__c = 'Morgan',  PriceBook2Id = pb.Id);
        insert student;
        student.StageName = 'Enrolled';
        update student;
        
        student = [Select Id, Year_Group__c From Opportunity Where Id =: student.Id];
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(student);
        FeeAssignmentController fac = new FeeAssignmentController(sc);
        
        Product2 prod1 = new Product2();
        prod1.IsActive = true;
        prod1.Name = 'prod1 Monthly, Termly or Yearly';
        prod1.Year_Group__c = ' 1 Monthly, Termly or Yearly';
        prod1.Invoice_Currency__c = 'EUR';
        prod1.Description = 'Monthly, Termly or Yearly';
        prod1.Fee_Frequency__c = 'Monthly';
        prod1.Description_of_fee__c = 'Tuition';
        insert prod1;
        prod1 = [select Id from Product2 Where Id =: prod1.Id];
        
        PricebookEntry pbe1 = new PriceBookEntry();
        pbe1.isActive = true;
        pbe1.UnitPrice = 1.0;
        pbe1.Pricebook2Id = pb.Id;
        pbe1.Product2Id = prod1.Id;
        insert pbe1;
        pbe1 = [Select Id, UnitPrice from PriceBookEntry Where Id =: pbe1.Id ];
        fac.otherFees.add(new OtherFee(pbe1.Id, 0.0, student, false));
        fac.getOtherFeesView();

        Product2 prod2 = new Product2();
        prod2.IsActive = true;
        prod2.Name = 'prod2 Monthly, Termly or Yearly';
        prod2.Year_Group__c = 'Y2';
        prod2.Invoice_Currency__c = 'EUR';
        prod2.Description = 'Monthly, Termly or Yearly';
        prod2.Fee_Frequency__c = 'Monthly';
        prod2.Description_of_fee__c = 'Tuition';
        insert prod2;
        prod2 = [select Id from Product2 Where Id =: prod2.Id];
        
        PricebookEntry pbe2 = new PriceBookEntry();
        pbe2.isActive = true;
        pbe2.UnitPrice = 1.0;
        pbe2.Pricebook2Id = pb.Id;
        pbe2.Product2Id = prod2.Id;
        insert pbe2;
        fac.tuitionFee.fee = pbe2.Id;
        
        fac.saveRedirect();
        
        List<OpportunityLineItem> oli = [Select Id, OpportunityId from OpportunityLineItem where OpportunityId =: student.Id];
        System.assertEquals(2, oli.size());
    }
    
    @IsTest(SeeAllData=True)
    static void testFeeLoading()
    {
        //Setup model
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
        Opportunity student = new Opportunity(Name = 'Test Student', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                Student_Name__c = 'Morgan',  PriceBook2Id = pb.Id);
        insert student;
        student.StageName = 'Enrolled';
        update student;
        
        student = [Select Id, Year_Group__c  From Opportunity Where Id =: student.Id];
        //Preload a tuition line item
        Product2 prod1 = new Product2();
        prod1.IsActive = true;
        prod1.Name = 'Monthly, Termly or Yearly';
        prod1.Year_Group__c = 'Y1';
        prod1.Invoice_Currency__c = 'EUR';
        prod1.Description = 'Monthly, Termly or Yearly';
        prod1.Fee_Frequency__c = 'Monthly';
        prod1.Description_of_fee__c = 'Tuition';
        insert prod1;
        prod1 = [select Id from Product2 Where Id =: prod1.Id];
        
        PricebookEntry pbe1 = new PriceBookEntry();
        pbe1.isActive = true;
        pbe1.UnitPrice = 1.0;
        pbe1.Pricebook2Id = pb.Id;
        pbe1.Product2Id = prod1.Id;
        insert pbe1;
        pbe1 = [Select Id, UnitPrice from PriceBookEntry Where Id =: pbe1.Id ];
        
        OpportunityLineItem tuition = new OpportunityLineItem();
        tuition.PricebookEntryId = pbe1.Id;
        tuition.OpportunityId = student.Id;
        tuition.Quantity = 1;
        tuition.UnitPrice = pbe1.UnitPrice;
        tuition.Current__c = true;
        tuition.Tuition__c = true;
        insert tuition;
        
        //And an other line item
        Product2 prod2 = new Product2();
        prod2.IsActive = true;
        prod2.Name = 'prod2 Monthly, Termly or Yearly';
        prod2.Year_Group__c = 'Y2';
        prod2.Invoice_Currency__c = 'EUR';
        prod2.Description = 'Monthly, Termly or Yearly';
        prod2.Fee_Frequency__c = 'Monthly';
        prod2.Description_of_fee__c = 'Tuition';
        insert prod2;
        prod2 = [select Id from Product2 Where Id =: prod2.Id];
        
        PricebookEntry pbe2 = new PriceBookEntry();
        pbe2.isActive = true;
        pbe2.UnitPrice = 1.0;
        pbe2.Pricebook2Id = pb.Id;
        pbe2.Product2Id = prod2.Id;
        insert pbe2;
        
        OpportunityLineItem other = new OpportunityLineItem();
        other.PricebookEntryId = pbe2.Id;
        other.OpportunityId = student.Id;
        other.Quantity = 1;
        other.UnitPrice = pbe2.UnitPrice;
        other.Current__c = true;
        other.Tuition__c = false;
        insert other;
        
        //And the controller
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(student);
        FeeAssignmentController fac = new FeeAssignmentController(sc);
        //assert the tuition item exists
        System.assertEquals(pbe1.Id, fac.tuitionFee.fee);
        //and the other item
        System.assertEquals(1, fac.otherFees.size());
    }
    
    @IsTest(SeeAllData=True)
    static void boostCoverage()
    {
        //Setup model
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
        Opportunity student = new Opportunity(Name = 'Test Student', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                Student_Name__c = 'Morgan',   PriceBook2Id = pb.Id);
        insert student;
        
        Product2 prod1 = new Product2();
        prod1.IsActive = true;
        prod1.Name = 'Monthly, Termly or Yearly prod1';
        prod1.Year_Group__c = 'Y1';
        prod1.Invoice_Currency__c = 'EUR';
        prod1.Description = 'Monthly, Termly or Yearly';
        prod1.Fee_Frequency__c = 'Monthly';
        prod1.Description_of_fee__c = 'Tuition';
        insert prod1;
        prod1 = [select Id from Product2 Where Id =: prod1.Id];
        
        PricebookEntry pbe = new PriceBookEntry();
        pbe.isActive = true;
        pbe.UnitPrice = 1.0;
        pbe.Pricebook2Id = pb.Id;
        pbe.Product2Id = prod1.Id;
        insert pbe;
        pbe = [Select Id, UnitPrice from PriceBookEntry Where Id =: pbe.Id ];
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(student);
        FeeAssignmentController fac = new FeeAssignmentController(sc);
        fac.getOppHasPriceBook();
        fac.getPayerOptions();
        fac.getPriceBookOptions();
    } 
}