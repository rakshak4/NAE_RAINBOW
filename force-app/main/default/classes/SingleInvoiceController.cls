public with sharing class SingleInvoiceController 
{
    public class InvoiceException extends Exception { } 
    // 
    private Account mAccount            { get; set; }
    private String pricebook2Id         { get; set; }
    public List<Opportunity> students   { get; set; }
    
    public Invoice_Statement__c invoice { get; set; }
    public boolean hasError             { get; set; }
    
    // Fields for selecting all fees and their payers
    public List<SingleInvoiceFee>   tuitionFees         { get; set; }
    public List<SingleInvoiceFee>   SingleInvoiceFees   { get; set; }
    public SingleInvoiceFee         newFee              { get; set; }
    
    // user alias name => School name - now populated from custom settings
    /*
    private Map<String, String> schoolAssignment = new Map<String, String> {
        'King\'s College Beijing'   => 'Beijing',
        'The British School of Guangzhou'   => 'Guangzhou',
        'The British International School of Kuala Lumpur'  => 'Kuala Lumpur',
        'The King\'s School Manila'   => 'Manila',
        'The British School of Marbella'   => 'Marbella',
        'The International School of Moscow'   => 'Moscow',
        'The British School of Nanjing'   => 'Nanjing',
        'The British School of Navarra'  => 'Pamplona',
        'The British College of Brazil'   => 'Sao Paulo',
        'The British School of Tashkent'   => 'Tashkent',
        'The British School Yangon'   => 'Yangon',
        'Ukraine International School'   => 'Kiev',
        'The New York International School'   => 'New York'
    };*/
    private Map<String, String> schoolAssignment {get;set;}
    
    public SingleInvoiceController( ApexPages.StandardController sc ) 
    {
        //populate school map with short name
        schoolAssignment = new Map<String,String>();
        List<Account_Owner_Mapping__c> settings = Account_Owner_Mapping__c.getall().values(); 
        for(Account_Owner_Mapping__c sttng:settings){
            if(sttng.School_Name__c != null && sttng.School_Short_Name__c != null){
                schoolAssignment.put(sttng.School_Name__c,sttng.School_Short_Name__c);
            }
        }
        // Get the Account and the Owner records
        this.mAccount = (Account) sc.getRecord();
        this.mAccount = [
            SELECT Id, OwnerId  , Invoice_Xero_Key__c
              FROM Account
             WHERE Id =: this.mAccount.Id
        ];
        
        // setup variables for the accounts
        this.hasError           = false;
        this.tuitionFees        = new List<SingleInvoiceFee>();
        this.SingleInvoiceFees  = new List<SingleInvoiceFee>();
        
        this.init();
    }
    
    private void init() 
    {
        this.invoice = new Invoice_Statement__c(
            //OwnerId = this.mAccount.OwnerId,
            Payer__c = this.mAccount.Id, 
            Invoice_Date__c = System.today(),
            Generated_Date__c = System.today()
        );
        
        // get the pricebook according to the account owner
        this.pricebook2Id = getAccountPricebook( this.mAccount.OwnerId );
        
        if( pricebook2Id != null )
        {
            this.students = [
                SELECT Half_Day_PN_N__c, Half_Day_PN_N_Checkbox__c ,StageName, Id, Tracking_2_Source_Value__c , Tracking_1_Source_Value__c, AccountId, Pricebook2Id, Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c, Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__r.Name, Year_Group__c, Invoice_Year_Group__c, Name
                  FROM Opportunity 
                 WHERE Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c =: this.mAccount.Id
                    OR AccountId =: this.mAccount.Id
            ];
            
            if( students.size() > 0 ) {
                
                this.newFee = new SingleInvoiceFee( false, this.pricebook2Id, this.students );
                
                //Create a tuition fee one for each student
                for( Opportunity student : this.students ) 
                {
                    List<Opportunity> singleStudent = new List<Opportunity>{ student };
                    SingleInvoiceFee tuitionFee = new SingleInvoiceFee( true, this.pricebook2Id, singleStudent );
                    tuitionFees.add( tuitionFee );
                }
            }
            else 
            {
                ApexPages.addMessage( 
                    new ApexPages.Message(
                        ApexPages.Severity.WARNING, 
                        'There are no students related to this account.'
                    )
                );
            }
        }
    }
    
    private String getAccountPricebook( String userId ) 
    {   
        try 
        {
            User accountOwner = [
                SELECT Id, School__c
                  FROM User
                 WHERE Id =: userId
                 limit 1
            ];
            
            String pricebookName = schoolAssignment.get( accountOwner.School__c );
            //this.invoice.School__c = ( pricebookName == null ) ? 'Invalid' : pricebookName;
            this.invoice.School__c = this.mAccount.Invoice_Xero_Key__c;
            
            Pricebook2 pb = [
                SELECT Id, Name
                  FROM Pricebook2
                 WHERE Name =: pricebookName
                 limit 1
            ];
            
            return pb.Id;
        }
        catch( Exception e )
        {
            ApexPages.addMessage( 
                new ApexPages.Message(
                    ApexPages.Severity.ERROR, 
                    'Failed to get the related pricebook: ' + e.getMessage()
                )
            );
            
            this.hasError = true;
            return null;
        }
    }
    
    public PageReference createInvoice() 
    {
        System.SavePoint savePt = Database.setSavepoint();
        try {
            
            invoice.Currency__c = 'NZD';
            invoice.Single_Invoice__c = true;
            insert invoice;
            
            Set<String> studentNames = new Set<String>();
            List<Line_Item__c> lineItems = new List<Line_Item__c>();
            List<SingleInvoiceFee> allFees = new List<SingleInvoiceFee>();
            allFees.addAll( this.tuitionFees );
            allFees.addAll( this.SingleInvoiceFees );
            
            for( SingleInvoiceFee fee : allFees )
            {
                // Create a line item for each fee that isn't empty
                if( fee.fee != null && fee.fee != '' )
                {   
                    // First selected student details
                    Id studentId = null;

                    String tracking = '';
                    String tracking2 = '';
                    String lineItemDescription_append = '';

                    for( SingleInvoiceFee.Student student : fee.students )
                    {
                        // Create aa line item for each selected student 
                        if( student.isSelected )
                        {   
                            studentId = student.opp.Id;
                            studentNames.add( student.opp.Name );
                            
                            tracking = student.opp.Tracking_2_Source_Value__c  ;
                            tracking2 = student.opp.Tracking_1_Source_Value__c  ;
                            //tracking += student.opp.Tracking_2_Source_Value__c  + ', ';
                            if(lineItemDescription_append == ''){lineItemDescription_append = student.opp.Name;}else{
                            lineItemDescription_append += ' | '+student.opp.Name;}
                        }
                    }

                    // If a student was not found, throw an error
                    if (studentId == null) {
                        throw new InvoiceException( 'You must select at least one student for each invoice line.' );
                    }
                        
                    if( tracking != '' )
                    {
                        System.debug('## ' + fee.fee);
                        PricebookEntry pbe = [
                            SELECT Id, Name, UnitPrice, Product2.Description_of_fee__c, Product2.Invoice_Currency__c
                              FROM PricebookEntry
                             WHERE Id =: fee.fee
                        ];
                        
                        this.invoice.Currency__c = pbe.Product2.Invoice_Currency__c;

                        Line_Item__c lineItem = new Line_Item__c(
                            Unit_Price__c = pbe.UnitPrice, 
                            Associated_Discount_on_Create__c = Decimal.valueOf( fee.Discount ),
                            Description__c = pbe.Name, 
                            //Tracking__c = tracking.trim().removeEndIgnoreCase(','),
                            Tracking__c = tracking,
                            Tracking_1__c = tracking2 ,
                            Students_Info__c = lineItemDescription_append ,
                            Fee_Type__c = pbe.Product2.Description_of_fee__c,
                            Student__c = studentId, // <-- added in relation to change above
                            Invoice_Statement__c = invoice.id
                        );
                        System.debug('### LINEITEM ' + lineitem);
                        lineItems.add( lineItem );
                        
                        //If the OpportunityLineItem has a discount then create a new line item for it.
                        Decimal discount = Decimal.valueOf( fee.Discount );
                        if( discount > 0 ) 
                        {
                            Line_Item__c discountLineItem = new Line_Item__c(
                                Unit_Price__c = - Math.round(( pbe.unitPrice * ( discount / 100 ) )), 
                                Description__c = discount +'% Discount on ' + pbe.Name, 
                                Tracking__c = tracking,
                                Tracking_1__c = tracking2,
                                Students_Info__c = lineItemDescription_append ,
                                Fee_Type__c = pbe.Product2.Description_of_fee__c,
                                Student__c = studentId, // <-- added in relation to change above
                                Invoice_Statement__c = invoice.id
                            );
                            System.debug('### LINEITEM ' + lineitem);                               
                            lineItems.add( discountLineItem );
                        } 
                    }
                }
            }
            insert lineItems;

            if( lineItems.size() == 0 )
            {
                throw new InvoiceException( 'No line items selected.' );
            }
            
            String reference = '';
            for( String studentName : studentNames )
            {
                if(reference == ''){
                    reference = studentName;
                }else{
                    reference += ' | '+studentName;
                }
            }
            invoice.Reference__c = reference;
            update invoice;
            
            return new PageReference( '/' + invoice.Id );
        }
        catch( Exception e )
        {
            Database.rollback( savePt );
            ApexPages.addMessage( 
                new ApexPages.Message(
                    ApexPages.Severity.ERROR, 
                    'Failed to create an invoice: ' + e.getMessage()
                )
            );
            
            this.init();
        }
            
        return null;    
    }
    
    public PageReference redirect()
    {
        PageReference pr = new PageReference( '/' + this.mAccount.Id );
        return pr;
    }
    
    //Load the list of Other fees, if there is any fees set to null then remove them
    //If a fee has been selected for new fee the add it to the list and empty new fee.
    public List<SingleInvoiceFee> getSingleInvoiceFeesView()
    {
        //Add a new fee if one has been selected
        if( this.newFee != null && this.newFee.fee != '' && this.newFee.fee != null )
        {
            System.debug( '## ' + this.newFee.fee );
            SingleInvoiceFees.add( this.newFee );
            this.newFee = new SingleInvoiceFee( false, this.pricebook2Id, this.students );
        }
        //Remove any fees that are now --None--
        List<SingleInvoiceFee> nonNullFees = new List<SingleInvoiceFee>();
        for(SingleInvoiceFee fee : SingleInvoiceFees)
        {
            if(fee.fee != null) nonNullFees.add(fee);
        }
        SingleInvoiceFees.clear();
        SingleInvoiceFees.addAll(nonNullFees);
        
        return SingleInvoiceFees;
    }
    
    @isTest(seeAllData=true)
    public static void testAll() 
    {
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        
        //insert related financial info
        Financial_Information__c fi = new Financial_Information__c();
        fi.Related_to__c = parentAccount.Id;
        fi.Invoice_Currency__c = 'MYR';
        fi.Invoice_Frequency__c = 'Monthly';
        fi.Fees_Responsible_For__c = 'All Applicable;';
        fi.RecordTypeId = [select Id from RecordType where DeveloperName = 'Parent_Financial_Information'].Id;
        //fi.Company_Name__c = companyAccount.Id;
        insert fi;
        
        Pricebook2 pb = [
            Select Id, Name, isStandard from Pricebook2 WHERE isStandard = true limit 1
        ];
        PricebookEntry pbe = [
            Select Id, Pricebook2Id from PricebookEntry WHERE Pricebook2Id =: pb.Id limit 1
        ];
        Opportunity student = new Opportunity(
            Name = 'Test Student',
            Gender__c = 'Male', 
            StageName = 'A/ Testing', 
            Year_Group__c = 'Y1', 
            CloseDate = System.today().addDays(10), 
            Student_Name__c = 'Morgan', 
            PriceBook2Id = pb.Id
        );
        insert student;
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(parentAccount);
        SingleInvoiceController controller = new SingleInvoiceController(sc);
        
        controller.tuitionFees.add( new SingleInvoiceFee( true, pb.Id, new List<Opportunity>{ student } ) );
        
        controller.tuitionFees.get(0).fee = pbe.Id;
        controller.tuitionFees.get(0).students.get(0).isSelected = true;
        
        controller.redirect();
        controller.getSingleInvoiceFeesView();
        controller.createInvoice();
        
        // single invoice fee coverage
        controller.tuitionFees.get(0).getFeeOptions();
        controller.tuitionFees.get(0).getTermOptions();
    }
}