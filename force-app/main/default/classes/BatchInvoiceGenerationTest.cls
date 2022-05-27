@isTest
public with sharing class BatchInvoiceGenerationTest {
    
    @isTest(seeAllData=true)
    static void testMultipleInvoiceGeneration() {
         System.debug('### testMultipleInvoiceGeneration');
        List<String> scope = new List<String>();
        list<Account> alist = new list<Account>();
        //setup model
        Account payer = new Account(Name = 'Test' );
        alist.add(payer);
          
        Account payer2 = new Account(Name = 'Test2');
        alist.add(payer2);
        
        insert alist;
        scope.add(payer.Id);
        scope.add(payer2.Id);
        
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
        //fi.Company_Name__c = payer.Id;
        insert fi;
        
       
        
        
        
        
        try {
            Pricebook2 pb = [Select Id From Pricebook2 where IsStandard = true limit 1];
            Opportunity studentOne = new Opportunity(Name = 'Student', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                    Student_Name__c = 'Morgan', AccountId = parentAccount.Id,
                                                    Leaving_date__c = System.today().addYears(1), Pricebook2Id = pb.Id);
                                                    
            insert studentOne;
            studentOne.StageName = 'Enrolled';
            update studentOne;
            studentOne = [Select Id, Year_Group__c, Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c From Opportunity Where Id =: studentOne.Id];
            
            list<Product2> productList = new list<Product2>();
            Product2 prod1 = new Product2();
            prod1.IsActive = true;
            prod1.Name = 'prod1 Monthly, Termly or Yearly';
            prod1.Year_Group__c = 'Y1';
            prod1.Invoice_Currency__c = 'TST';
            prod1.Description = 'Monthly, Termly or Yearly';
            prod1.Fee_Frequency__c = 'Monthly';
            prod1.Description_of_fee__c = 'Tuition';
            productList.add(prod1);
            
            Product2 prod2 = new Product2();
            prod2.IsActive = true;
            prod2.Name = 'prod2 Monthly, Termly or Yearly';
            prod2.Year_Group__c = 'Y1';
            prod2.Invoice_Currency__c = 'TST';
            prod2.Description = 'Monthly, Termly or Yearly';
            prod2.Fee_Frequency__c = 'Monthly';
            prod2.Description_of_fee__c = 'Tuition';
            productList.add(prod2);
            
            
            Product2 prod3 = new Product2();
            prod3.IsActive = true;
            prod3.Name = 'prod3 Monthly, Termly or Yearly';
            prod3.Year_Group__c = 'Y1';
            prod3.Invoice_Currency__c = 'TST';
            prod3.Description = 'Monthly, Termly or Yearly';
            prod3.Fee_Frequency__c = 'Monthly';
            prod3.Description_of_fee__c = 'Tuition';
            productList.add(prod3);
            
            insert productList;
            
            list<PricebookEntry> pbEntryList = new list<PricebookEntry>();
            PricebookEntry pbe1 = new PriceBookEntry();
            pbe1.isActive = true;
            pbe1.UnitPrice = 1.0;
            pbe1.Pricebook2Id = pb.Id;
            pbe1.Product2Id = prod1.Id;
            pbEntryList.add(pbe1);
            PricebookEntry pbe2 = new PriceBookEntry();
            pbe2.isActive = true;
            pbe2.UnitPrice = 1.0;
            pbe2.Pricebook2Id = pb.Id;
            pbe2.Product2Id = prod2.Id;
            pbEntryList.add(pbe2);
            PricebookEntry pbe3 = new PriceBookEntry();
            pbe3.isActive = true;
            pbe3.UnitPrice = 1.0;
            pbe3.Pricebook2Id = pb.Id;
            pbe3.Product2Id = prod3.Id;
            pbEntryList.add(pbe3);
            insert pbEntryList;
            
            List<PricebookEntry> pbes = [Select Id, Product2Id, Product2.Invoice_Currency__c, Pricebook2Id from PricebookEntry where Product2.Invoice_Currency__c =: 'TST' and Pricebook2Id =: pb.Id limit 3];
            OpportunityLineItem oli = new OpportunityLineItem();
            oli.PricebookEntryId = pbes.remove(0).Id;
            oli.OpportunityId = studentOne.Id;
            oli.Quantity = 1;
            oli.TotalPrice = 1.0;
            oli.Current__c = true;
            oli.Tuition__c = true;
            oli.Payer__c = payer2.Id;
            oli.Invoicing_Term__c = 'Monthly';
            oli.Months_In_Year__c = '10';
            oli.Next_Generated_Invoice__c = System.today();
            oli.Invoice_Date__c = System.today().addDays(1);
            insert oli;
            
            Integer i =0;
            for(PricebookEntry pbe : pbes)
            {
                i++;
                OpportunityLineItem oli2 = new OpportunityLineItem();
                oli2.PricebookEntryId = pbe.Id;
                oli2.OpportunityId = studentOne.Id;
                oli2.Quantity = 1;
                oli2.TotalPrice = 1.0;
                oli2.Current__c = true;
                oli2.Tuition__c = false;
                oli2.Payer__c = payer.Id;
                oli2.Invoicing_Term__c = 'Monthly';
                oli2.Months_In_Year__c = '10';
                oli2.Next_Generated_Invoice__c = System.today();
                oli2.Invoice_Date__c = System.today().addDays(i);
                insert oli2;
            }
        }
        catch(Exception e) {
            System.debug('### error : ' +e.getMessage());
        }
        
        //run the batch test
        BatchInvoiceGeneration batch = new BatchInvoiceGeneration();
        batch.createInvoices(scope); 
        /*
        //asserts
        {
            List<Invoice_Statement__c> invoices = [Select Id, Payer__c from Invoice_Statement__c where Payer__c =: payer.Id];
            System.assertEquals(2, invoices.size());
            List<Line_Item__c> lineItems = [Select Id, Invoice_Statement__c from Line_Item__c where Invoice_Statement__c =: invoices.get(0).Id];
            System.assertEquals(1, lineItems.size());
            List<Line_Item__c> lineItems2 = [Select Id, Invoice_Statement__c from Line_Item__c where Invoice_Statement__c =: invoices.get(1).Id];
            System.assertEquals(1, lineItems2.size());
        }
        {
            List<Invoice_Statement__c> invoices = [Select Id, Payer__c from Invoice_Statement__c where Payer__c =: payer2.Id];
            System.assertEquals(1, invoices.size());
            List<Line_Item__c> lineItems = [Select Id, Invoice_Statement__c from Line_Item__c where Invoice_Statement__c =: invoices.get(0).Id];
            System.assertEquals(1, lineItems.size());
        }*/
    }
    
    @isTest(seeAllData=true)
    static void testSingleInvoiceGeneration() {
        
        System.debug('### testSingleInvoiceGeneration');
        List<String> scope = new List<String>();
        
        //setup model
        Account payer = new Account(Name = 'Test');
        insert payer;
        scope.add(payer.Id);
         //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        try {
            Pricebook2 pb = [Select Id From Pricebook2 where IsStandard = true limit 1];
            list<Opportunity> studentList = new list<Opportunity>();
            Opportunity studentOne = new Opportunity(
                Name = 'Morgan', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                Student_Name__c = 'Morgan', 
                Leaving_date__c = System.today().addYears(1), Pricebook2Id = pb.Id
            );
            
            studentOne.StageName = 'Enrolled';
            studentList.add(studentOne);
            
            Opportunity studentTwo = new Opportunity(
                Name = 'James', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                Student_Name__c = 'James', 
                Leaving_date__c = System.today().addYears(1), Pricebook2Id = pb.Id
            );
            //insert studentTwo;
            studentTwo.StageName = 'Enrolled';
            studentList.add(studentOne);
            
            insert studentList;
            list<Opportunity> studentList2 = new list<Opportunity>();
            studentTwo.StageName = 'Enrolled';
            studentOne.StageName = 'Enrolled';
            studentList2.add(studentTwo);
            studentList2.add(studentOne);
            update studentList2;
            
            
            studentOne = [
                Select Id, Year_Group__c, Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c
                  From Opportunity 
                 Where Id =: studentOne.Id
            ];
            
            Product2 prod1 = new Product2();
            prod1.IsActive = true;
            prod1.Name = 'prod1 Monthly, Termly or Yearly';
            prod1.Year_Group__c = 'Y1';
            prod1.Invoice_Currency__c = 'TST';
            prod1.Description = 'Monthly, Termly or Yearly';
            prod1.Fee_Frequency__c = 'Monthly';
            prod1.Description_of_fee__c = 'Tuition';
            insert prod1;
            PricebookEntry pbe1 = new PriceBookEntry();
            pbe1.isActive = true;
            pbe1.UnitPrice = 1.0;
            pbe1.Pricebook2Id = pb.Id;
            pbe1.Product2Id = prod1.Id;
            insert pbe1;
            
            Product2 prod2 = new Product2();
            prod2.IsActive = true;
            prod2.Name = 'prod2 Monthly, Termly or Yearly';
            prod2.Year_Group__c = 'Y1';
            prod2.Invoice_Currency__c = 'TST';
            prod2.Description = 'Monthly, Termly or Yearly';
            prod2.Fee_Frequency__c = 'Monthly';
            prod2.Description_of_fee__c = 'Tuition';
            insert prod2;
            PricebookEntry pbe2 = new PriceBookEntry();
            pbe2.isActive = true;
            pbe2.UnitPrice = 1.0;
            pbe2.Pricebook2Id = pb.Id;
            pbe2.Product2Id = prod2.Id;
            insert pbe2;
            
            Product2 prod3 = new Product2();
            prod3.IsActive = true;
            prod3.Name = 'prod3 Monthly, Termly or Yearly';
            prod3.Year_Group__c = 'Y1';
            prod3.Invoice_Currency__c = 'TST';
            prod3.Description = 'Monthly, Termly or Yearly';
            prod3.Fee_Frequency__c = 'Monthly';
            prod3.Description_of_fee__c = 'Tuition';
            insert prod3;
            PricebookEntry pbe3 = new PriceBookEntry();
            pbe3.isActive = true;
            pbe3.UnitPrice = 1.0;
            pbe3.Pricebook2Id = pb.Id;
            pbe3.Product2Id = prod3.Id;
            insert pbe3;
            
            Boolean f = true;
            for(PricebookEntry pbe : [Select Id, Product2Id, Product2.Invoice_Currency__c, Pricebook2Id from PricebookEntry where Product2.Invoice_Currency__c =: 'TST' and Pricebook2Id =: pb.Id limit 3])
            {
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.PricebookEntryId = pbe.Id;
                if(f)
                    oli.OpportunityId = studentOne.Id;
                else
                    oli.OpportunityId = studentTwo.Id;
                oli.Quantity = 1;
                oli.TotalPrice = 1.0;
                oli.Current__c = true;
                oli.Tuition__c = true;
                oli.Payer__c = payer.Id;
                oli.Invoicing_Term__c = 'Monthly';
                oli.Months_In_Year__c = '10';
                oli.Next_Generated_Invoice__c = System.today();
                oli.Invoice_Date__c = System.today().addDays(7);
                insert oli;
                f = false;
            }
        }
        catch(Exception e) {
            System.debug('### error : ' +e.getMessage());
        }
        
        //run the batch test
        BatchInvoiceGeneration batch = new BatchInvoiceGeneration();
        batch.createInvoices(scope);
        
        //asserts
        List<Invoice_Statement__c> invoices = [
            SELECT Id, Payer__c//, Reference__c 
              FROM Invoice_Statement__c 
             WHERE Payer__c =: payer.Id
        ];
        
        //System.assertEquals(1, invoices.size());
        
        String ref = 'Morgan, James';
        /*if(invoices.get(0).Reference__c != ref) {
            ref = 'James, Morgan';
        }*/
        //System.assertEquals(ref, invoices.get(0).Reference__c);
        
        /*List<Line_Item__c> lineItems = [
            SELECT Id, Invoice_Statement__c 
              FROM Line_Item__c 
             WHERE Invoice_Statement__c =: invoices.get(0).Id
        ];*/
        //System.assertEquals(3, lineItems.size());
    }
    
    @isTest(seeAllData=true)
    static void testStartLeaveDateInclusion() {
        
        System.debug('### testStartLeaveDateInclusion');
        List<String> scope = new List<String>();
        
        //Setup custom settings
        Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getValues('Default');
        settings.Inc_Leave_Date__c = 1;
        //setup model
        Account payer = new Account(Name = 'Test'); 
        insert payer;
        scope.add(payer.Id);
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        
        
        //try {
            Pricebook2 pb = [Select Id From Pricebook2 where IsStandard = true limit 1];
            Opportunity studentOne = new Opportunity(Name = 'One', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                    Student_Name__c = 'James', AccountId = parentAccount.Id, 
                                                    Leaving_date__c = System.today().addYears(1), Reason_Leaving__c = 'Relocation (out of city)', Pricebook2Id = pb.Id);
            insert studentOne;
            studentOne.StageName = 'Enrolled';
            update studentOne;
            
            Product2 prod1 = new Product2();
            prod1.IsActive = true;
            prod1.Name = 'Monthly, Termly or Yearly prod1';
            prod1.Year_Group__c = 'Y1';
            prod1.Invoice_Currency__c = 'TST';
            prod1.Description = 'Monthly, Termly or Yearly';
            prod1.Fee_Frequency__c = 'Monthly';
            prod1.Description_of_fee__c = 'Tuition';
            insert prod1;

            PricebookEntry pbe = new PriceBookEntry();
            pbe.isActive = true;
            pbe.UnitPrice = 1.0;
            pbe.Pricebook2Id = pb.Id;
            pbe.Product2Id = prod1.Id;
            insert pbe;
            
            OpportunityLineItem oli = new OpportunityLineItem(
                PricebookEntryId = pbe.Id,
                OpportunityId = studentOne.Id,
                Quantity = 1,
                UnitPrice = 1.0,
                Current__c = true,
                Tuition__c = true,
                Payer__c = payer.Id,
                Invoicing_Term__c = 'Monthly',
                Months_In_Year__c = '10',
                Next_Generated_Invoice__c = System.today(),
                Invoice_Date__c = System.today().addDays(7),
                Discount = 10
            );
            insert oli;
            
            OpportunityLineItem oli2 = new OpportunityLineItem(
                PricebookEntryId = pbe.Id,
                OpportunityId = studentOne.Id,
                Quantity = 1,
                UnitPrice = 1.0,
                Current__c = true,
                Tuition__c = true,
                Payer__c = payer.Id,
                Invoicing_Term__c = 'Termly',
                Months_In_Year__c = '10',
                Next_Generated_Invoice__c = System.today(),
                Invoice_Date__c = System.today().addDays(14),
                Discount = 10
            );
            insert oli2;
            
            oli = [Select Id, TotalPrice from OpportunityLineItem where Id =: oli.Id];
            System.assertEquals(0.9, oli.TotalPrice);
        //}
        //catch(Exception e) {
            //System.debug('### error : ' +e.getMessage());
        //}
        
        //run the batch test
        BatchInvoiceGeneration batch = new BatchInvoiceGeneration();
        batch.createInvoices(scope);

        //asserts
        /*List<Invoice_Statement__c> invoices = [Select Id, Payer__c, Reference__c, Invoice_Date__c, Total_Invoice_Value__c from Invoice_Statement__c where Payer__c =: payer.Id];
        for (Invoice_Statement__c inv : invoices) {
            System.debug('Invoice: ' + inv.Id + ' | ' + inv.Reference__c + ' | ' + inv.Invoice_Date__c + ' | ' + inv.Total_Invoice_Value__c);
        }
        System.assertEquals(1, invoices.size());
        List<Line_Item__c> lineItems = [Select Id, Invoice_Statement__c from Line_Item__c where Invoice_Statement__c =: invoices.get(0).Id];
        System.assertEquals(2, lineItems.size());*/
    }
    
    @isTest(seeAllData=true)
    static void testMultipleInvoiceGenerationSeparateFamilies() {
         System.debug('### testMultipleInvoiceGeneration');
        List<String> scope = new List<String>();
        list<Account> alist = new list<Account>();
        Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getValues('Default');
        settings.Inc_Leave_Date__c = 1;
        
        //setup model
        Account payer = new Account(Name = 'Test'); 
        payer.Company_Email__c = 'company@test.com';
        payer.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert payer;
        scope.add(payer.Id);
        
        //create parent account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;

        //create parent2 account
        Account parentAccount2 =  new Account();
        parentAccount2.FirstName =  'First Name';
        parentAccount2.LastName =  'Last Name';
        parentAccount2.PersonEmail = 'test2@test.com';
        parentAccount2.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount2;        

        //insert related parent financial info
        Financial_Information__c fi = new Financial_Information__c();
        fi.Related_to__c = parentAccount.Id;
        fi.Invoice_Currency__c = 'MYR';
        fi.Invoice_Frequency__c = 'Termly';
        fi.Fees_Responsible_For__c = 'All Applicable;';
        fi.RecordTypeId = [select Id from RecordType where DeveloperName = 'Parent_Financial_Information'].Id;
        insert fi;

        //insert related parent2 financial info
        Financial_Information__c fi2 = new Financial_Information__c();
        fi2.Related_to__c = parentAccount2.Id;
        fi2.Invoice_Currency__c = 'MYR';
        fi2.Invoice_Frequency__c = 'Termly';
        fi2.Fees_Responsible_For__c = 'All Applicable;';
        fi2.RecordTypeId = [select Id from RecordType where DeveloperName = 'Parent_Financial_Information'].Id;
        insert fi2;        
        
        //insert related company financial info
        Financial_Information__c cfi = new Financial_Information__c();
        cfi.Related_to__c = payer.Id;
        cfi.Invoice_Currency__c = 'MYR';
        cfi.Invoice_Frequency__c = 'Termly';
        cfi.Fees_Responsible_For__c = 'All Applicable;';
        cfi.RecordTypeId = [select Id from RecordType where DeveloperName = 'Company_Financial_Information'].Id;
        cfi.Separate_Invoices_by_Family__c = true;
        insert cfi;
        
        try {
            //add a student
            Pricebook2 pb = [Select Id From Pricebook2 where IsStandard = true limit 1];
            Opportunity studentOne = new Opportunity(Name = 'Student', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                    Student_Name__c = 'Morgan', AccountId = parentAccount.Id,
                                                    Leaving_date__c = System.today().addYears(1), Reason_Leaving__c = 'Relocation (out of city)', Pricebook2Id = pb.Id);                                                   
            insert studentOne;
            studentOne.StageName = 'Enrolled';
            update studentOne;
            studentOne = [Select Id, Year_Group__c, Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c From Opportunity Where Id =: studentOne.Id];

            //add another student
            Opportunity studentTwo = new Opportunity(Name = 'Student2', Gender__c = 'Male', StageName = 'A/ Testing', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                    Student_Name__c = 'Stanley', AccountId = parentAccount2.Id,
                                                    Leaving_date__c = System.today().addYears(1), Reason_Leaving__c = 'Relocation (out of city)', Pricebook2Id = pb.Id);

            insert studentTwo;
            studentTwo.StageName = 'Enrolled';
            update studentTwo;
            studentTwo = [Select Id, Year_Group__c, Related_Financial_Info__r.Related_Company_Financial_Info__r.Related_to__c From Opportunity Where Id =: studentTwo.Id];        
            
            //create opportunity products
            list<Product2> productList = new list<Product2>();
            Product2 prod1 = new Product2();
            prod1.IsActive = true;
            prod1.Name = 'prod1 Monthly, Termly or Yearly';
            prod1.Year_Group__c = 'Y1';
            prod1.Invoice_Currency__c = 'TST';
            prod1.Description = 'Monthly, Termly or Yearly';
            prod1.Fee_Frequency__c = 'Monthly';
            prod1.Description_of_fee__c = 'Tuition';
            productList.add(prod1);
            
            insert productList;
            
            list<PricebookEntry> pbEntryList = new list<PricebookEntry>();
            PricebookEntry pbe1 = new PriceBookEntry();
            pbe1.isActive = true;
            pbe1.UnitPrice = 1.0;
            pbe1.Pricebook2Id = pb.Id;
            pbe1.Product2Id = prod1.Id;
            pbEntryList.add(pbe1);
            insert pbEntryList;
            
            List<PricebookEntry> pbes = [Select Id, Product2Id, Product2.Invoice_Currency__c, Pricebook2Id from PricebookEntry where Product2.Invoice_Currency__c =: 'TST' and Pricebook2Id =: pb.Id limit 3];
            OpportunityLineItem oli = new OpportunityLineItem();
            oli.PricebookEntryId = pbes.remove(0).Id;
            oli.OpportunityId = studentOne.Id;
            oli.Quantity = 1;
            oli.TotalPrice = 1.0;
            oli.Current__c = true;
            oli.Tuition__c = true;
            oli.Payer__c = payer.Id;
            oli.Invoicing_Term__c = 'Monthly';
            oli.Months_In_Year__c = '10';
            oli.Next_Generated_Invoice__c = System.today();
            oli.Invoice_Date__c = System.today().addDays(1);
            insert oli;
            
            Integer i =0;
            for(PricebookEntry pbe : pbes)
            {
                i++;
                OpportunityLineItem oli2 = new OpportunityLineItem();
                oli2.PricebookEntryId = pbe.Id;
                oli2.OpportunityId = studentOne.Id;
                oli2.Quantity = 1;
                oli2.TotalPrice = 1.0;
                oli2.Current__c = true;
                oli2.Tuition__c = false;
                oli2.Payer__c = payer.Id;
                oli2.Invoicing_Term__c = 'Monthly';
                oli2.Months_In_Year__c = '10';
                oli2.Next_Generated_Invoice__c = System.today();
                oli2.Invoice_Date__c = System.today().addDays(i);
                insert oli2;
            }

            list<Product2> productList2 = new list<Product2>();
            Product2 prod4 = new Product2();
            prod4.IsActive = true;
            prod4.Name = 'prod4 Monthly, Termly or Yearly';
            prod4.Year_Group__c = 'Y1';
            prod4.Invoice_Currency__c = 'TST';
            prod4.Description = 'Monthly, Termly or Yearly';
            prod4.Fee_Frequency__c = 'Monthly';
            prod4.Description_of_fee__c = 'Tuition';
            productList2.add(prod4);
            
            insert productList2;
            
            list<PricebookEntry> pbEntryList2 = new list<PricebookEntry>();
            PricebookEntry pbe4 = new PriceBookEntry();
            pbe4.isActive = true;
            pbe4.UnitPrice = 1.0;
            pbe4.Pricebook2Id = pb.Id;
            pbe4.Product2Id = prod4.Id;
            pbEntryList2.add(pbe4);
            insert pbEntryList2;
            
            List<PricebookEntry> pbes2 = [Select Id, Product2Id, Product2.Invoice_Currency__c, Pricebook2Id from PricebookEntry where Product2.Invoice_Currency__c =: 'TST' and Pricebook2Id =: pb.Id limit 3];
            OpportunityLineItem oli3 = new OpportunityLineItem();
            oli3.PricebookEntryId = pbes2.remove(0).Id;
            oli3.OpportunityId = studentTwo.Id;
            oli3.Quantity = 1;
            oli3.TotalPrice = 1.0;
            oli3.Current__c = true;
            oli3.Tuition__c = true;
            oli3.Payer__c = payer.Id;
            oli3.Invoicing_Term__c = 'Monthly';
            oli3.Months_In_Year__c = '10';
            oli3.Next_Generated_Invoice__c = System.today();
            oli3.Invoice_Date__c = System.today().addDays(1);
            insert oli3;
            
            Integer j =0;
            for(PricebookEntry pbe : pbes2)
            {
                j++;
                OpportunityLineItem oli4 = new OpportunityLineItem();
                oli4.PricebookEntryId = pbe.Id;
                oli4.OpportunityId = studentTwo.Id;
                oli4.Quantity = 1;
                oli4.TotalPrice = 1.0;
                oli4.Current__c = true;
                oli4.Tuition__c = false;
                oli4.Payer__c = payer.Id;
                oli4.Invoicing_Term__c = 'Monthly';
                oli4.Months_In_Year__c = '10';
                oli4.Next_Generated_Invoice__c = System.today();
                oli4.Invoice_Date__c = System.today().addDays(j);
                insert oli4;
            }

        }
        catch(Exception e) {
            System.debug('### error : ' +e.getMessage());
        }
        
        //run the batch test
        BatchInvoiceGeneration batch = new BatchInvoiceGeneration();
        batch.createInvoices(scope); 

        /*
        //asserts
        {
            List<Invoice_Statement__c> invoices = [Select Id, Payer__c from Invoice_Statement__c where Payer__c =: payer.Id];
            System.assertEquals(2, invoices.size());
            List<Line_Item__c> lineItems = [Select Id, Invoice_Statement__c from Line_Item__c where Invoice_Statement__c =: invoices.get(0).Id];
            System.assertEquals(1, lineItems.size());
            List<Line_Item__c> lineItems2 = [Select Id, Invoice_Statement__c from Line_Item__c where Invoice_Statement__c =: invoices.get(1).Id];
            System.assertEquals(1, lineItems2.size());
        }
        {
            List<Invoice_Statement__c> invoices = [Select Id, Payer__c from Invoice_Statement__c where Payer__c =: payer.Id];
            System.assertEquals(1, invoices.size());
            List<Line_Item__c> lineItems = [Select Id, Invoice_Statement__c from Line_Item__c where Invoice_Statement__c =: invoices.get(0).Id];
            System.assertEquals(1, lineItems.size());
        };
        
        List<Invoice_Statement__c> invoices = [
            SELECT Id, Payer__c//, Reference__c 
              FROM Invoice_Statement__c 
             WHERE Payer__c =: payer.Id
        ];*/
        
        
    }
    
}