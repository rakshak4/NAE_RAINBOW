global class BatchInvoiceGeneration implements Database.Batchable<sObject>{
    
    private final Date processDate;
    private Id accountId ;
    global BatchInvoiceGeneration() {
        processDate = Date.today();
    }

    global BatchInvoiceGeneration(Date processDate) {
        this.processDate = processDate;
    }
    
    global BatchInvoiceGeneration(Id aid) { 
        this.accountId = aid;
        this.processDate = Date.today();
    }
    
    //webservice function called from Account Button
    webService static string generateAccountInvoice(Id accountId) { 
        string returnMessage = 'Invoice(s) generated successfully.';
        Savepoint sp = Database.setSavepoint();

        try{
            list<String> aIds = new list<String>();
            aIds.add(accountId);
            BatchInvoiceGeneration obj = new BatchInvoiceGeneration(accountId);
            system.debug('*****BatchInvoiceGeneration***generateAccountInvoice***aIds='+aIds);
            obj.createInvoices(aIds);
        }catch(Exception e){
            returnMessage = 'Failed to generate invoice(s). Error Message: '+e.getMessage();
            Database.rollBack(sp);
        }
        return returnMessage;
    }
    
    //Batch Interface Methods
    global Database.QueryLocator start(Database.BatchableContext BC) {

        String q = 'Select Id from Account';
        if(accountId  != null){
            q += ' where Id = \''+accountId+'\'';
            
        }
        return Database.getQueryLocator(q);
    }
    
    private class MyException extends Exception {}
    private List<String> processFailures = new List<String>();
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {

        List<String> accounts = new List<String>();
        for(sObject so : scope)
        {
            Account acc = (Account) so;
            accounts.add(acc.Id);
        }
        this.createInvoices(accounts); 
    }
    
    public void createInvoices(List<String> accountIds) {
        system.debug('*****BatchInvoiceGeneration***createInvoices***processDate='+processDate);
        system.debug('*****BatchInvoiceGeneration***createInvoices***accountIds='+accountIds);
        try {
            Map<String, Account> accounts = new Map<String, Account>();
            Map<Id, set<Id>> accountPayerFamilyMap = new Map<Id, set<Id>>();
            for(Account acc : [Select Id, OwnerId, Separate_Invoices_by_Family__c from Account Where Id IN: accountIds]) {
                accounts.put(acc.Id, acc);
            }
            system.debug('*****BatchInvoiceGeneration***createInvoices***accounts='+accounts);
            List<OpportunityLineItem> opportunityLineItems = 
            [
                SELECT Id, Tuition__c, Invoicing_Term__c, Next_Generated_Invoice__c, Due_Date__c, Payer__c, OLI_Invoice_Xero_Key__c,
                    Opportunity.Year_Group_Increment__c, Opportunity.Year_Group__c,  
                    Opportunity.Invoice_Year_Group__c, Opportunity.StageName, Opportunity.AccountId, Opportunity.Tracking_2_Source_Value__c, Opportunity.Tracking_1_Source_Value__c 
                  FROM OpportunityLineItem 
                 WHERE Current__c = true 
                    and Next_Generated_Invoice__c =: processDate
                    and Payer__c IN: accountIds
                    and Opportunity.StageName =: 'Enrolled'
                    and ( (Invoicing_Term__c =: 'Termly' or Invoicing_Term__c =: 'Yearly') or (Payer__r.Separate_Invoices_by_Family__c = true) )
                    and Tuition__c =: true
            ];
            system.debug('*****BatchInvoiceGeneration***createInvoices***opportunityLineItems='+opportunityLineItems);
            //group families under payer - changes made by Kunal on 27th Oct 2014
            for(OpportunityLineItem oli:opportunityLineItems){
                if(accountPayerFamilyMap.containsKey(oli.Payer__c)){
                    accountPayerFamilyMap.get(oli.Payer__c).add(oli.Opportunity.AccountId);
                }else{
                    set<Id> familyIds = new set<Id>();
                    familyIds.add(oli.Opportunity.AccountId);
                    accountPayerFamilyMap.put(oli.Payer__c,familyIds);
                }
            }
            system.debug('*****BatchInvoiceGeneration***createInvoices***accountPayerFamilyMap='+accountPayerFamilyMap);
            //end changes by kunal
            
            // get all of the current tuition line items with invoicing : yearly & termly and increment them
            Map<String, String> opportunityMap = new Map<String, String>();
            for(OpportunityLineItem oli : opportunityLineItems) 
            {
                if(oli.Invoicing_Term__c == 'Yearly' || oli.Invoicing_Term__c == 'Termly'){
                    // only increment them if invoice year group != current year group
                    if(oli.Opportunity.Year_Group__c != oli.Opportunity.Invoice_Year_Group__c) {
                        opportunityMap.put(oli.Opportunity.Id, oli.Opportunity.Year_Group_Increment__c);
                    }
                }
            }
            System.debug('## opportunityMap : ' +opportunityMap);
            system.debug('*****BatchInvoiceGeneration***createInvoices***opportunityMap='+opportunityMap);
            boolean isIncrementSucessful = true;
            if(opportunityMap.size() > 0){
                isIncrementSucessful = IncrementTuitionFee.execute(opportunityMap,true,null);
            }
            if(isIncrementSucessful){
                // Get all opportunity line items associated with the accounts
                List<OpportunityLineItem> scope = [
                    Select o.ListPrice, o.Discount, o.SystemModstamp, o.SortOrder, o.ServiceDate, o.Quantity, o.PricebookEntryId, o.OpportunityId, o.Opportunity.StageName,
                        o.LastModifiedDate, o.LastModifiedById, o.IsDeleted, o.Id, o.Description, o.Current__c, o.CurrencyIsoCode,
                        o.CreatedDate, o.CreatedById, o.Next_Generated_Invoice__c, o.Invoice_Date__c, o.Due_Date__c, o.Months_In_Year__c, o.Invoicing_Term__c, o.Payer__c, o.Custom__c,
                        o.Include_in_Invoice_Generation_Cus_Year__c, o.OLI_Invoice_Xero_Key__c
                      From OpportunityLineItem o 
                     Where Current__c = true 
                        and o.Next_Generated_Invoice__c =: processDate
                        and o.Payer__c IN: accountIds
                        and o.Opportunity.StageName =: 'Enrolled'
                        and ((Custom__c = true AND Include_in_Invoice_Generation_Cus_Year__c = 'TRUE') OR Custom__c = false) // Logan - Custom yearly should only be queried of Include_in_Invoice_Generation_Cus_Year__c is true
                ];
                
                Map<String, Opportunity>    opportunities    = new Map<String, Opportunity>();
                Map<String, PricebookEntry> priceBookEntries = new Map<String, PricebookEntry>();
                
                for(OpportunityLineItem oli : scope)
                {
                    opportunities.put(oli.OpportunityId, null);
                    priceBookEntries.put(oli.PricebookEntryId, null);
                }
                
                //Get needed records
                for(Opportunity o : [Select Id, Name, Tracking_1_Source_Value__c, Tracking_2_Source_Value__c, CloseDate, StageName, Leaving_Date__c,AccountId from Opportunity Where Id in: opportunities.keySet()])
                {
                    opportunities.remove(o.Id);
                    opportunities.put(o.Id, o);
                }
                for(PricebookEntry pbe : [Select Id, Name, Product2Id, Product2.Description_of_fee__c, Product2.Invoice_Currency__c, Pricebook2Id, Pricebook2.Name from PricebookEntry Where Id in: priceBookEntries.keySet()])
                {
                    priceBookEntries.remove(pbe.Id);
                    priceBookEntries.put(pbe.Id, pbe);
                }
                system.debug('*****BatchInvoiceGeneration***createInvoices***scope='+scope);
                // Added due date to the chain June 2013 - Logan Moore
                //Invoice Date -> Due Date -> Account -> School -> Currency -> Opportunity -> Line Item
                Map<Date, Map<Date, Map<String, Map<String, Map<String, Map<String, List<OpportunityLineItem>>>>>>> oppLineItems = new Map<Date, Map<Date, Map<String, Map<String, Map<String, Map<String, List<OpportunityLineItem>>>>>>>();
                for(OpportunityLineItem oli : scope)
                {
                    String curr = priceBookEntries.get(oli.PricebookEntryId).Product2.Invoice_Currency__c;
                    System.debug('### '+curr);
                    system.debug('*****BatchInvoiceGeneration***createInvoices***curr='+curr);
                    String school = oli.OLI_Invoice_Xero_Key__c;
                    System.debug('### '+school);
                    system.debug('*****BatchInvoiceGeneration***createInvoices***school='+school);
    
                    // If the due date is specified, use it, otherwise assume due date = invoiced date - Logan June 2013
                    Date dueDate = oli.Due_Date__c != null ? oli.Due_Date__c : oli.Invoice_Date__c ;
    
                    //Invoice Date
                    if(!oppLineItems.containsKey(oli.Invoice_Date__c)) 
                        oppLineItems.put(oli.Invoice_Date__c, new Map<Date, Map<String, Map<String, Map<String, Map<String, List<OpportunityLineItem>>>>>>());
                    //Due Date
                    if(!oppLineItems.get(oli.Invoice_Date__c).containsKey(dueDate))
                        oppLineItems.get(oli.Invoice_Date__c).put(dueDate, new Map<String, Map<String, Map<String, Map<String, List<OpportunityLineItem>>>>>());
                    //Account
                    if(!oppLineItems.get(oli.Invoice_Date__c).get(dueDate).containsKey(oli.Payer__c))
                        oppLineItems.get(oli.Invoice_Date__c).get(dueDate).put(oli.Payer__c, new Map<String, Map<String, Map<String, List<OpportunityLineItem>>>>());
                    //School
                    if(!oppLineItems.get(oli.Invoice_Date__c).get(dueDate).get(oli.Payer__c).containsKey(school))
                        oppLineItems.get(oli.Invoice_Date__c).get(dueDate).get(oli.Payer__c).put(school, new Map<String, Map<String, List<OpportunityLineItem>>>());
                    //Currency
                    if(!oppLineItems.get(oli.Invoice_Date__c).get(dueDate).get(oli.Payer__c).get(school).containsKey(curr))
                        oppLineItems.get(oli.Invoice_Date__c).get(dueDate).get(oli.Payer__c).get(school).put(curr, new Map<String, List<OpportunityLineItem>>());
                    //Opportunity
                    if(!oppLineItems.get(oli.Invoice_Date__c).get(dueDate).get(oli.Payer__c).get(school).get(curr).containsKey(oli.OpportunityId))
                        oppLineItems.get(oli.Invoice_Date__c).get(dueDate).get(oli.Payer__c).get(school).get(curr).put(oli.OpportunityId, new List<OpportunityLineItem>());
                    //Line Item
                    oppLineItems.get(oli.Invoice_Date__c).get(dueDate).get(oli.Payer__c).get(school).get(curr).get(oli.OpportunityId).add(oli);
                }
                System.debug('### opportunities '+opportunities);
                System.debug('### all '+oppLineItems);
                system.debug('*****BatchInvoiceGeneration***createInvoices***opportunities='+opportunities);
                system.debug('*****BatchInvoiceGeneration***createInvoices***oppLineItems='+oppLineItems);
                
                //Construct Invoice & Line Items using information from Opportunities accounts and Opp Line Items
                Map<String, List<Line_Item__c>> lineItemMap = new Map<String, List<Line_Item__c>>();
                Map<String, Invoice_Statement__c> invoiceMap = new Map<String, Invoice_Statement__c>();
                List<Invoice_Statement__c> invoiceToInsert = new List<Invoice_Statement__c>();
                List<OpportunityLineItem> olisToUpdate = new List<OpportunityLineItem>();
                //Loop through each part of the mapgroup creating an invoice for each end point,
                // Invoice date
                for(Date invDate : oppLineItems.keySet())
                {
                    //Due Date
                    for(Date dueDate : oppLineItems.get(invDate).keySet())
                    {
                        //Account
                        for(String accId : oppLineItems.get(invDate).get(dueDate).keySet())
                        {
                            Account acc = accounts.get(accId);  
                            
                            if(acc.Separate_Invoices_by_Family__c == false){ //changes made by Kunal on 27th Oct 2014 for handling seperate invoices by families
                                //School
                                for(String school : oppLineItems.get(invDate).get(dueDate).get(accId).keySet())
                                {
                                    //Currency
                                    for(String curr : oppLineItems.get(invDate).get(dueDate).get(accId).get(school).keySet())
                                    {
                                        String key = invDate +(dueDate +accId +school +curr); // brackets ensure the dates are concatenated instead of calculated - Logan June 2013
                                        String reference = '';
                                        Invoice_Statement__c invoice = new Invoice_Statement__c(
                                            //OwnerId = acc.OwnerId,
                                            Currency__c = curr, 
                                            Payer__c = accId, 
                                            Invoice_Date__c = invDate,
                                            Generated_Date__c = dueDate,
                                            School__c = school
                                        );
                                        //Opportunity
                                        for(String oppId : oppLineItems.get(invDate).get(dueDate).get(accId).get(school).get(curr).keySet())
                                        {
                                            //ensure the opportunity falls within starting & leaving date periods.
                                            Opportunity opp = opportunities.get(oppId);
                                            Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getValues('Default');
                                                                    
                                            Boolean liCreated = false;
                                            for(OpportunityLineItem oli : oppLineItems.get(invDate).get(dueDate).get(accId).get(school).get(curr).get(oppId))
                                            {
                                                Boolean isMonthly = ( oli.Invoicing_Term__c == 'Monthly' );
                                                
                                                // Differnt inclusion dates for Monthy & (Yearly + Termly)
                                                String startSign = ( isMonthly ) ? settings.Inc_Month_Start_Sign__c : settings.Inc_Start_Sign__c;
                                                Integer startInc = ( isMonthly ) ? Integer.valueOf(settings.Inc_Month_Start_Date__c) : Integer.valueOf(settings.Inc_Start_Date__c);
                                                String endSign = ( isMonthly ) ? settings.Inc_Month_Leave_Sign__c : settings.Inc_Leave_Sign__c;
                                                Integer endInc = ( isMonthly ) ? Integer.valueOf(settings.Inc_Month_Leave_Date__c) : Integer.valueOf(settings.Inc_Leave_Date__c);
                                                
                                                Boolean termDateCheck = (checkDate( opp.CloseDate, startSign, invDate, startInc ) &&
                                                            (opp.Leaving_Date__c == null || checkDate( opp.Leaving_Date__c, endSign, invDate, endInc )));
                                                
                                                // if the students within the starting & leaving dates then invoice the fees            
                                                if(termDateCheck)
                                                {
                                                    System.debug('## opp line item create '+oli.Id);
                                                    
                                                    // some olis have a null unit price when the discount is set to 100, so account for that
                                                    //Decimal unitPrice = ( oli.UnitPrice == null && oli.Discount == 100 ) ? oli.ListPrice : oli.UnitPrice;
                                                    Decimal listPrice = oli.ListPrice;
                                                    
                                                    PricebookEntry pbe = priceBookEntries.get(oli.PricebookEntryId);
                                                    Line_Item__c lineItem = new Line_Item__c(
                                                        Unit_Price__c = listPrice, 
                                                        Associated_Discount_on_Create__c = oli.Discount,
                                                        Description__c = pbe.Name, 
                                                        //Tracking__c = opp.Name,
                                                        Tracking__c = opp.Tracking_2_Source_Value__c,
                                                        Tracking_1__c = opp.Tracking_1_Source_Value__c,
                                                        Students_Info__c = opp.Name,
                                                        Fee_Type__c = pbe.Product2.Description_of_fee__c,
                                                        Student__c = oppId
                                                    );
                                                
                                                    liCreated = true;
                                                    if(!lineItemMap.containsKey( key ))
                                                        lineItemMap.put(key, new List<Line_Item__c>());
                                                    lineItemMap.get(key).add(lineItem);
                                                    
                                                    //If the OpportunityLineItem has a discount then create a new line item for it.
                                                    if(oli.Discount > 0) 
                                                    {
                                                        Line_Item__c discountLineItem = new Line_Item__c(
                                                            Unit_Price__c = -1 * Math.round((listPrice * (oli.Discount/100))), 
                                                            Description__c = oli.Discount +'% Discount on ' +pbe.Name, 
                                                            //Tracking__c = opp.Name,
                                                            Tracking__c = opp.Tracking_2_Source_Value__c,
                                                            Tracking_1__c = opp.Tracking_1_Source_Value__c,
                                                            Students_Info__c = opp.Name,
                                                            Fee_Type__c = pbe.Product2.Description_of_fee__c,
                                                            Student__c = oppId
                                                        );
                                                            
                                                        lineItemMap.get(key).add(discountLineItem);
                                                    }
                                                    
                                                    //Rollover the dates
                                                    if (oli.Custom__c == true && oli.Invoicing_Term__c == 'Yearly') {
                                                        // If the invoice is custom yearly, just push it out one year
                                                        oli.Invoice_Date__c = oli.Invoice_Date__c == null ? null : oli.Invoice_Date__c.addYears(1);
                                                        oli.Next_Generated_Invoice__c = oli.Next_Generated_Invoice__c == null ? null : oli.Next_Generated_Invoice__c.addYears(1);
                                                        oli.Due_Date__c = oli.Due_Date__c == null ? null : oli.Due_Date__c.addYears(1);
                                                    } else {
                                                        //Set the opportunity line items next generated invoice & invoice date to the next value
                                                        System.debug('## Next_Generated_Invoice__c ' +oli.Next_Generated_Invoice__c);
                                                        oli.Next_Generated_Invoice__c = InvoiceDateGeneration.getNextGeneratedDate(oli.Invoicing_Term__c, oli.Months_In_Year__c, invDate.addDays(1));
                                                        System.debug('## Next_Generated_Invoice__c ' +oli.Next_Generated_Invoice__c);
                                                        oli.Invoice_Date__c = InvoiceDateGeneration.getNextInvoiceDate(oli.Invoicing_Term__c, oli.Next_Generated_Invoice__c);
                                                    }
        
                                                    olisToUpdate.add(oli);
                                                }
                                            }
                                            if(liCreated) {
                                                if(reference != '') reference += ' | ';
                                                reference += opp.Name;
                                            }
                                        }
                                        if(reference != '')
                                        {
                                            invoice.Reference__c = reference;
                                            invoiceToInsert.add(invoice); 
                                            invoiceMap.put(key, invoice);
                                        }
                                    }
                                }
                            }else{
                                //kunal on 27th Oct 2014
                                //write logic for handling seperate invoices for families
                                system.debug('****BatchInvoiceGeneration***invoiceToInsert='+invoiceToInsert); 
                                system.debug('****BatchInvoiceGeneration***accountPayerFamilyMap='+accountPayerFamilyMap);
                                set<Id> familyIds = accountPayerFamilyMap.get(acc.Id);
                                system.debug('****BatchInvoiceGeneration***familyIds='+familyIds);
                                for(Id familyId:familyIds){
                                    
                                    //School
                                    for(String school : oppLineItems.get(invDate).get(dueDate).get(accId).keySet())
                                    {
                                        //Currency
                                        for(String curr : oppLineItems.get(invDate).get(dueDate).get(accId).get(school).keySet())
                                        {
                                            String key = invDate +(dueDate +accId +school +curr)+familyId; // brackets ensure the dates are concatenated instead of calculated - Logan June 2013
                                            //String key = invDate +(dueDate +accId +school +curr); // brackets ensure the dates are concatenated instead of calculated - Logan June 2013
                                            String reference = '';
                                            Invoice_Statement__c invoice = new Invoice_Statement__c(
                                                //OwnerId = acc.OwnerId,
                                                Currency__c = curr, 
                                                Payer__c = accId, 
                                                Invoice_Date__c = invDate,
                                                Generated_Date__c = dueDate,
                                                School__c = school
                                            );
                                            //Opportunity
                                            for(String oppId : oppLineItems.get(invDate).get(dueDate).get(accId).get(school).get(curr).keySet())
                                            {
                                                //ensure the opportunity falls within starting & leaving date periods.
                                                Opportunity opp = opportunities.get(oppId);
                                                system.debug('****BatchInvoiceGeneration***opp='+opp);  
                                                system.debug('****BatchInvoiceGeneration***familyId='+familyId);    
                                                if(opp.AccountId == familyId){ //changes made by Kunal on 27th Oct for handling seperate invoices for families
                                                    system.debug('****BatchInvoiceGeneration***Processing for***='+familyId+'-'+opp.Id);    
                                                    Invoice_Date_Settings__c settings = Invoice_Date_Settings__c.getValues('Default');
                                                                        
                                                    Boolean liCreated = false;
                                                    for(OpportunityLineItem oli : oppLineItems.get(invDate).get(dueDate).get(accId).get(school).get(curr).get(oppId))
                                                    {
                                                        Boolean isMonthly = ( oli.Invoicing_Term__c == 'Monthly' );
                                                        
                                                        // Differnt inclusion dates for Monthy & (Yearly + Termly)
                                                        String startSign = ( isMonthly ) ? settings.Inc_Month_Start_Sign__c : settings.Inc_Start_Sign__c;
                                                        Integer startInc = ( isMonthly ) ? Integer.valueOf(settings.Inc_Month_Start_Date__c) : Integer.valueOf(settings.Inc_Start_Date__c);
                                                        String endSign = ( isMonthly ) ? settings.Inc_Month_Leave_Sign__c : settings.Inc_Leave_Sign__c;
                                                        Integer endInc = ( isMonthly ) ? Integer.valueOf(settings.Inc_Month_Leave_Date__c) : Integer.valueOf(settings.Inc_Leave_Date__c);
                                                        
                                                        Boolean termDateCheck = (checkDate( opp.CloseDate, startSign, invDate, startInc ) &&
                                                                    (opp.Leaving_Date__c == null || checkDate( opp.Leaving_Date__c, endSign, invDate, endInc )));
                                                        
                                                        // if the students within the starting & leaving dates then invoice the fees            
                                                        system.debug('****BatchInvoiceGeneration***termDateCheck***='+termDateCheck);
                                                        if(termDateCheck)
                                                        {
                                                            System.debug('## opp line item create '+oli.Id);
                                                            
                                                            // some olis have a null unit price when the discount is set to 100, so account for that
                                                            //Decimal unitPrice = ( oli.UnitPrice == null && oli.Discount == 100 ) ? oli.ListPrice : oli.UnitPrice;
                                                            Decimal listPrice = oli.ListPrice;
                                                            
                                                            PricebookEntry pbe = priceBookEntries.get(oli.PricebookEntryId);
                                                            Line_Item__c lineItem = new Line_Item__c(
                                                                Unit_Price__c = listPrice, 
                                                                Description__c = pbe.Name, 
                                                                //Tracking__c = opp.Name,
                                                                Tracking__c = opp.Tracking_2_Source_Value__c,
                                                                Tracking_1__c = opp.Tracking_1_Source_Value__c,
                                                                Students_Info__c = opp.Name,
                                                                Fee_Type__c = pbe.Product2.Description_of_fee__c,
                                                                Student__c = oppId
                                                            );
                                                            
                                                            liCreated = true;
                                                            system.debug('****BatchInvoiceGeneration***pbe***='+pbe);
                                                            if(!lineItemMap.containsKey( key ))
                                                                lineItemMap.put(key, new List<Line_Item__c>());
                                                            lineItemMap.get(key).add(lineItem);
                                                            system.debug('****BatchInvoiceGeneration***lineItemMap***='+lineItemMap);
                                                            //If the OpportunityLineItem has a discount then create a new line item for it.
                                                            if(oli.Discount > 0) 
                                                            {
                                                                Line_Item__c discountLineItem = new Line_Item__c(
                                                                    Unit_Price__c = -1 * Math.round((listPrice * (oli.Discount/100))), 
                                                                    Description__c = oli.Discount +'% Discount on ' +pbe.Name, 
                                                                    //Tracking__c = opp.Name,
                                                                    Tracking__c = opp.Tracking_2_Source_Value__c,
                                                                    Tracking_1__c = opp.Tracking_1_Source_Value__c,
                                                                    Students_Info__c = opp.Name,
                                                                    Fee_Type__c = pbe.Product2.Description_of_fee__c,
                                                                    Student__c = oppId
                                                                );
                                                                    
                                                                lineItemMap.get(key).add(discountLineItem);
                                                            }
                                                            
                                                            //Rollover the dates
                                                            if (oli.Custom__c == true && oli.Invoicing_Term__c == 'Yearly') {
                                                                // If the invoice is custom yearly, just push it out one year
                                                                oli.Invoice_Date__c = oli.Invoice_Date__c == null ? null : oli.Invoice_Date__c.addYears(1);
                                                                oli.Next_Generated_Invoice__c = oli.Next_Generated_Invoice__c == null ? null : oli.Next_Generated_Invoice__c.addYears(1);
                                                                oli.Due_Date__c = oli.Due_Date__c == null ? null : oli.Due_Date__c.addYears(1);
                                                            } else {
                                                                //Set the opportunity line items next generated invoice & invoice date to the next value
                                                                System.debug('## Next_Generated_Invoice__c ' +oli.Next_Generated_Invoice__c);
                                                                oli.Next_Generated_Invoice__c = InvoiceDateGeneration.getNextGeneratedDate(oli.Invoicing_Term__c, oli.Months_In_Year__c, invDate.addDays(1));
                                                                System.debug('## Next_Generated_Invoice__c ' +oli.Next_Generated_Invoice__c);
                                                                oli.Invoice_Date__c = InvoiceDateGeneration.getNextInvoiceDate(oli.Invoicing_Term__c, oli.Next_Generated_Invoice__c);
                                                            }
                                                            
                                                            olisToUpdate.add(oli);
                                                            system.debug('****BatchInvoiceGeneration***olisToUpdate***='+olisToUpdate);
                                                            system.debug('****BatchInvoiceGeneration***lineItemMap***='+lineItemMap);           
                                                        }
                                                    }
                                                    if(liCreated) {
                                                        if(reference != '') reference += ' | ';
                                                        reference += opp.Name;
                                                    }
                                                    
                                                }
                                                
                                            }
                                            system.debug('****BatchInvoiceGeneration***reference***='+reference);
                                            if(reference != '')
                                            {
                                                invoice.Reference__c = reference;
                                                invoiceToInsert.add(invoice); 
                                                invoiceMap.put(key, invoice);
                                                system.debug('****BatchInvoiceGeneration***invoiceToInsert***='+invoiceToInsert);
                                                system.debug('****BatchInvoiceGeneration***invoiceMap***='+invoiceMap);
                                                
                                            }
                                            
                                        }
                                    }   
                                }
                            }
                        }
                    }
                }
                System.debug('### num of invoiceToInsert' +invoiceToInsert.size() );
                insert invoiceToInsert;
                
                //Link up the Line Items with their Invoice Statement
                List<Line_Item__c> lineItemsTuition = new List<Line_Item__c>();
                List<Line_Item__c> lineItemsLunch = new List<Line_Item__c>();
                List<Line_Item__c> lineItemsBus = new List<Line_Item__c>();
                List<Line_Item__c> lineItemsOther = new List<Line_Item__c>();
                for(String key : lineItemMap.keySet())
                {
                    Invoice_Statement__c invoice = invoiceMap.get(key);
                    for(Line_Item__c lineItem : lineItemMap.get(key))
                    {
                        lineItem.Invoice_Statement__c = invoice.Id;
                        if(lineItem.Fee_Type__c == 'Tuition') {
                            lineItemsTuition.add(lineItem);
                        }
                        else if(lineItem.Fee_Type__c == 'Lunch') {
                            lineItemsLunch.add(lineItem);
                        }
                        else if(lineItem.Fee_Type__c == 'Bus') {
                            lineItemsBus.add(lineItem);
                        }
                        // Might need to add a custom yearly fee type here - check with Ben - Logan June 2013
                        else {
                            lineItemsOther.add(lineItem);
                        }
                    }
                }
                Integer lineItemsInserted = lineItemsTuition.size() + lineItemsLunch.size() + lineItemsBus.size() + lineItemsOther.size();
                System.debug('## lineItemsInserted ' + lineItemsInserted);
                
                insert lineItemsTuition;
                insert lineItemsLunch;
                insert lineItemsBus;
                insert lineItemsOther;
                
                //And update opportunity line items
                update olisToUpdate;
            }    
        }
            
            
        catch(IncrementTuitionFee.IncrementException e) {
            
            String accountIdsStr = '';
            for(String aId : accountIds) {
                
                if(accountIdsStr != '') accountIdsStr += '. ';
                accountIdsStr += aId;
            }
            
            String failureMessage = 'Account Ids : ( ' +accountIdsStr +' ) \n';
            failureMessage += 'Error Message : ' +e.getMessage();
            
            processFailures.add(failureMessage);
            System.debug('## failureMessage: ' + failureMessage);
        }
        catch(Exception e) {
            
            String accountIdsStr = '';
            for(String aId : accountIds) {
                
                if(accountIdsStr != '') accountIdsStr += '. ';
                accountIdsStr += aId;
            }
            
            String failureMessage = 'Account Ids : ( ' +accountIdsStr +' ) \n';
            failureMessage += 'Error Message : ' +e.getMessage();
            
            processFailures.add(failureMessage);
            System.debug('## failureMessage: ' + failureMessage);
        }
        
    }
    
    private Boolean checkDate(Date dateOne, String sign, Date dateTwo, Integer increment)
    {
        System.debug('### start date check');
        Boolean check = false;
        Date dateIncrement = dateTwo.addDays(increment);
        System.debug('### dateOne '+dateOne);
        System.debug('### sign '+sign);
        System.debug('### dateIncrement '+dateIncrement);
        if(sign == '=') {
            check = (dateOne == dateIncrement);
        }
        else if(sign == '>') {
            check = (dateOne > dateIncrement);
        }
        else if(sign == '>=') {
            check = (dateOne >= dateIncrement);
        }
        else if(sign == '<') {
            check = (dateOne < dateIncrement);
        }
        else if(sign == '<=') {
            check = (dateOne <= dateIncrement);
        }
        System.debug('### check '+check);
        return check;
    }
     
    global void finish(Database.BatchableContext BC)
    {
        // If there are failures then send an email alerting BSG of such.
        if(processFailures.size() > 0) {
            System.debug('## failures' +processFailures);
            
            // construct the message body
            String failureMessage = 'A batch processing the following accounts encountered an error \n ';
            for(String str : processFailures) {
                failureMessage += str + '\n\n';
            }
            // and send the email to trineo & john
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject( 'BSG account processing failure' );
            mail.setPlainTextBody( failureMessage );
            mail.setToAddresses( new String[] { 'sfdev@trineo.co.nz', 'anton.simanikhin@britishschools.co.uk' } );
            
            Messaging.SendEmailResult[] results = Messaging.sendEmail( new Messaging.SingleEmailMessage[]{ mail }, false);
        }
    }
}