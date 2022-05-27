public with sharing class AnnualRolloverTriggerTest {
        
        //Setup model
        /*Pricebook2 stdPB = [Select Id, isStandard from Pricebook2 Where isStandard =: true];
        Pricebook2 pb = new Pricebook2(Name = 'Test PB');
        insert pb;
        System.debug('## pb.Id : ' +pb.Id);
        
        Opportunity student = new Opportunity(Name = 'Test Student', StageName = 'Stage Name', Year_Group__c = 'Y1', CloseDate = System.today().addDays(10), 
                                                Student_Name__c = 'Morgan', Payer__c = payer.Id, Pricebook2Id = pb.Id);
        insert student;
        student = [Select Id, Year_Group__c, Payer__c From Opportunity Where Id =: student.Id];
        
        // Create a fee for year group 1
        Product2 prod1 = new Product2(
            IsActive = true,
            Name = 'prod1',
            Year_Group__c = 'Y1',
            Invoice_Currency__c = 'TEST'
        );
        insert prod1;
        prod1 = [select Id from Product2 Where Id =: prod1.Id];
        // the standard price book entry for Y1
        PricebookEntry stdPbe = new PriceBookEntry(
            isActive = true,
            UnitPrice = 1.0,
            Pricebook2Id = stdPB.Id,
            Product2Id = prod1.Id
        );
        insert stdPbe;
        // the test price book entry for Y1
        PricebookEntry pbe = new PriceBookEntry(
            isActive = true,
            UnitPrice = 1.0,
            Pricebook2Id = pb.Id,
            Product2Id = prod1.Id
        );
        insert pbe;
        pbe = [Select Id, UnitPrice from PriceBookEntry Where Id =: pbe.Id ];
        
        // Create a fee for year group 2
        Product2 prod2 = new Product2(
            IsActive = true,
            Name = 'prod2',
            Year_Group__c = 'Y2',
            Invoice_Currency__c = 'TEST'
        );
        insert prod2;
        System.debug('## prod2.Id : ' +prod2.Id);
        // the standard price book entry for Y2
        PricebookEntry stdPbe2 = new PriceBookEntry(
            isActive = true,
            UnitPrice = 1.0,
            Pricebook2Id = stdPb.Id,
            Product2Id = prod2.Id
        );
        insert stdPbe2;
        // the test price book entry for Y2
        PricebookEntry pbe2 = new PriceBookEntry(
            isActive = true,
            UnitPrice = 1.0,
            Pricebook2Id = pb.Id,
            Product2Id = prod2.Id
        );
        insert pbe2;*/
    
    @isTest(seeAllData=true)
    public static void feeAssignmentTest() {
        
        PricebookEntry pbe = [
            Select p.Product2.Invoice_Currency__c, p.Product2.Year_Group__c, p.Product2Id, UnitPrice, Pricebook2Id
            From PricebookEntry p 
            Where p.Product2.Year_Group__c = 'Y1' and p.Product2.Invoice_Currency__c = 'EUR' 
            limit 1
        ];
        
        Account payer = new Account(
            Name = 'Test'
        );
        insert payer;
        
        //insert related financial info
        Financial_Information__c fi = new Financial_Information__c();
        fi.Related_to__c = payer.Id;
        fi.Invoice_Currency__c = 'MYR';
        fi.Invoice_Frequency__c = 'Monthly';
        fi.Fees_Responsible_For__c = 'All Applicable;';
        fi.RecordTypeId = [select Id from RecordType where DeveloperName = 'Company_Financial_Information'].Id;
        insert fi;
        
        Opportunity student = new Opportunity(
            Name = 'Test Student',
            Gender__c = 'Male',
            StageName = 'A/ Testing', 
            Year_Group__c = 'Y1', 
            CloseDate = System.today().addDays(10),
            Student_Name__c = 'Morgan', 
            
            Pricebook2Id = pbe.Pricebook2Id
        );
        insert student;
        student.StageName = 'Enrolled';
        update student;
        
        OpportunityLineItem oli = new OpportunityLineItem(
            PricebookEntryId = pbe.Id,
            OpportunityId = student.Id,
            Quantity = 1,
            TotalPrice = pbe.UnitPrice,
            Current__c = true,
            Tuition__c = true,
            
            Months_In_Year__c = '10',
            Invoicing_Term__c = 'Monthly'
        );
        insert oli;
        
        //change the year.
        student.Year_Group__c = 'Y2';
        update student;
        
        List<OpportunityLineItem> studentOLIs = [
            Select Id, OpportunityId
            From OpportunityLineItem
            Where OpportunityId =: student.Id
        ]; 
        
        System.assertequals(2, studentOLIs.size());
    }
}