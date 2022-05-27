global class BatchInvoiceSending implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    global BatchInvoiceSending() {    }
    
    //Batch Interface Methods
    global Database.QueryLocator start(Database.BatchableContext BC)         
    {
        String  q =  'Select Id, Xero_Id__c, Payer__c, Reference__c, Generated_Date__c, Invoice_Date__c, School__c, Single_Invoice__c,';
                //q += 'Payer__r.Add_Invoicing_Contact_Email__c,  Payer__r.Add_Invoicing_Contact_First_Name__c, Payer__r.Add_Invoicing_Contact_Last_Name__c,  ';
                //for parent address fields 
                q += 'Payer__r.Address_Apartment_Condo_Name_Number__pc, Payer__r.Address_Street_Name_Number__pc, Payer__r.Address_Line_2__pc,  Payer__r.Address_City__pc, Payer__r.Address_State_Province__pc, Payer__r.Address_Zip_Postal_Code__pc, Payer__r.Address_Country__pc, ';
               
                q += 'Payer__r.RecordType.DeveloperName, Payer__r.Email_Addresses_to_Include_in_Xero__c, Payer__r.PersonEmail,Payer__r.Contact_Alternate_Email__pc, Payer__r.PersonHasOptedOutOfEmail, Payer__r.Contact_Alternate_Email_Opt_Out__pc, Payer__r.Account_Main_Email_Formula__c, Payer__r.Account_Email_Opt_Out_Formula__c, Payer__r.Account_Alternate_Email_Formula__c, Payer__r.Account_Alternate_Email_Opt_Out_Formula__c, '; 
                q += 'Payer__r.Company_Contact_Person_1_First_Name__c, Payer__r.Company_Contact_Person_1_Last_Name__c, Payer__r.Company_Contact_Person_2_First_Name__c, Payer__r.Company_Contact_Person_2_Last_Name__c, Payer__r.Company_Email__c, Payer__r.Company_Email_2__c, ';
                q += 'Payer__r.Primary_Invoicing_Contact_Full_Name__c, Payer__r.Primary_Invoicing_Contact_First_Name__c, Payer__r.Primary_Invoicing_Contact_Last_Name__c, Payer__r.Primary_Invoicing_Contact_Email__c, Payer__r.Primary_Invoicing_Contact_Country_Code__c, Payer__r.Primary_Invoicing_Contact_Phone_Number__c,';
                q += 'Payer__r.Account_UID_Formula__c, Payer__r.Xero_Contact_ID__c, Payer__r.RecordTypeId, Payer__r.RecordType.Name,Payer__r.Phone, Payer__r.Main_Address__c, Currency__c,';
                q += 'Payer__r.FirstName, Payer__r.LastName, Payer__r.Name, Payer__r.Related_Contact_Record_P2__r.FirstName, Payer__r.Related_Contact_Record_P2__r.LastName  '; 
                q += 'From Invoice_Statement__c Where Xero_Id__c = null and Single_Invoice__c = false';
        return Database.getQueryLocator(q);
    }
     
    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {   
        //Get all invoices that have no xero id (means havent been sent yet)
        List<Invoice_Statement__c> newInvoices = new List<Invoice_Statement__c>();
        for(sObject so : scope) {
            newInvoices.add((Invoice_Statement__c)so);
        }
        
        sendInvoices(newInvoices);
    }
    
    public void sendInvoices(List<Invoice_Statement__c> newInvoices) { 
        
        System.debug('### newInvoices ' +newInvoices);
        
        //Map of line items 
        Map<String, List<Line_Item__c>> lineItems = new Map<String, List<Line_Item__c>>();
        for(Line_Item__c item : [Select Id, Tracking_1__c, Tracking__c, Invoice_Statement__c, Unit_Price__c, Description__c, Students_Info__c,  Student_Full_Name__c, Fee_Type__c From Line_Item__c Where Invoice_Statement__c in: newInvoices]) {
            if(!lineItems.containsKey(item.Invoice_Statement__c))
                lineItems.put(item.Invoice_Statement__c, new List<Line_Item__c>());
            lineItems.get(item.Invoice_Statement__c).add(item);
        }
        
        //Run through all invoice statements and their line items to send them to xero.
        list<Account> payersForUpdatingXeroContactId = new list<Account>();
        for(Invoice_Statement__c invoice : newInvoices) 
        {
            //Retrieve the Xero Credentials which depend on the school being used.
            Xero_Key__c xeroKey = null;
            try {
                // The school Pamplona uses the same xero org as Navarra
                String school = invoice.School__c;
                if(school == 'Pamplona') {
                    school = 'Navarra'; 
                }
                // Get the Xero key for the given school
                xeroKey = [
                    SELECT Id, Name, Private_Key__c, Consumer_Key__c, Consumer_Secret__c, 
                        AccCode_Tuition__c, AccCode_Lunch__c, AccCode_Bus__c, AccCode_Other__c,
                        AccCode_Enrolment__c, AccCode_Application__c, AccCode_EAL__c, Tracking_Category_1_Company__c, Tracking_Category_2_Campus_Misc__c
                      FROM Xero_Key__c 
                     WHERE Name =: school limit 1
                 ];
            }
            catch(Exception e) { }
            
            if(xeroKey == null) {
                //Xero key missing
                invoice.Error_Message__c = 'Xero Credentials not found for ' +invoice.School__c;
            }
            else if(lineItems.get(invoice.Id) == null) {
                //invoice has no line items
                invoice.Error_Message__c = 'No line items found.';
            }
            else {
                set<string> addedEmails = new set<string>();
                //Create the contact
                sfXero.XeroContact xeroContact = new sfXero.XeroContact();
                //if(invoice.Payer__r.Xero_Contact_ID__c != null){
                   // xeroContact.contactId = invoice.Payer__r.Xero_Contact_ID__c;
                //}//else{
                    xeroContact.contactNumber = invoice.Payer__r.Account_UID_Formula__c;
                //}
                    if(invoice.Payer__r.Primary_Invoicing_Contact_First_Name__c != null && invoice.Payer__r.Primary_Invoicing_Contact_First_Name__c != ''){
                        xeroContact.firstName   = invoice.Payer__r.Primary_Invoicing_Contact_First_Name__c;
                    }else{
                        xeroContact.firstName   = '';
                    }
                    xeroContact.lastName    = invoice.Payer__r.Primary_Invoicing_Contact_Last_Name__c;
                    xeroContact.orgName     = invoice.Payer__r.Primary_Invoicing_Contact_Full_Name__c;
                    if(invoice.Payer__r.Primary_Invoicing_Contact_Email__c != null && invoice.Payer__r.Primary_Invoicing_Contact_Email__c != ''){
                        xeroContact.emailAddress = invoice.Payer__r.Primary_Invoicing_Contact_Email__c;
                        addedEmails.add(invoice.Payer__r.Primary_Invoicing_Contact_Email__c);
                    }else{
                        xeroContact.emailAddress = '';
                    }
                    //for additional xero contacts
                    if(invoice.Payer__r.Primary_Invoicing_Contact_Email__c != null && invoice.Payer__r.Primary_Invoicing_Contact_Email__c != ''){
                        if(invoice.Payer__r.RecordType.DeveloperName == 'PersonAccount' ){
                            if(invoice.Payer__r.Email_Addresses_to_Include_in_Xero__c != null){
                                list<string> emailAddressesToBeIncluded = invoice.Payer__r.Email_Addresses_to_Include_in_Xero__c.split(';');
                                for(string e:emailAddressesToBeIncluded){
                                    if(e != null && e != ''){
                                        if(e == 'Parent 1 Main Email' && invoice.Payer__r.PersonEmail != null &&!addedEmails.contains(invoice.Payer__r.PersonEmail)){
                                            sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                                            if(invoice.Payer__r.FirstName != null){
                                                person1.firstName = invoice.Payer__r.FirstName;
                                            }else{
                                                person1.firstName = '';
                                            }
                                            person1.lastName = invoice.Payer__r.LastName;
                                            if(invoice.Payer__r.PersonEmail != null){
                                                person1.emailAddress = invoice.Payer__r.PersonEmail;
                                            }else{
                                                person1.emailAddress = '';
                                            }
                                            if(invoice.Payer__r.PersonHasOptedOutOfEmail == false && invoice.Payer__r.PersonEmail != null){
                                                person1.includeInEmails = true;
                                                addedEmails.add(invoice.Payer__r.PersonEmail);
                                            }else{
                                                person1.includeInEmails = false;
                                            }
                                            xeroContact.contactPersons.add(person1);
                                        }else if(e == 'Parent 1 Alternate Email'  && invoice.Payer__r.Contact_Alternate_Email__pc != null && !addedEmails.contains(invoice.Payer__r.Contact_Alternate_Email__pc)){
                                            sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                                            if(invoice.Payer__r.FirstName != null){
                                                person1.firstName = invoice.Payer__r.FirstName;
                                            }else{
                                                person1.firstName = '';
                                            }
                                            person1.lastName = invoice.Payer__r.LastName;
                                            if(invoice.Payer__r.Contact_Alternate_Email__pc != null){
                                                person1.emailAddress = invoice.Payer__r.Contact_Alternate_Email__pc;
                                            }else{
                                                person1.emailAddress = '';
                                            }
                                            if(invoice.Payer__r.Contact_Alternate_Email_Opt_Out__pc == false && invoice.Payer__r.Contact_Alternate_Email__pc != null){
                                                person1.includeInEmails = true;
                                                addedEmails.add(invoice.Payer__r.Contact_Alternate_Email__pc);
                                            }else{
                                                person1.includeInEmails = false;
                                            }
                                            xeroContact.contactPersons.add(person1);
                                        }else if(e == 'Parent 2 Main Email' &&  invoice.Payer__r.Account_Main_Email_Formula__c != null && invoice.Payer__r.Account_Main_Email_Formula__c != '' &&  !addedEmails.contains(invoice.Payer__r.Account_Main_Email_Formula__c)){
                                            sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                                            if(invoice.Payer__r.Related_Contact_Record_P2__r.FirstName != null){
                                                person1.firstName = invoice.Payer__r.Related_Contact_Record_P2__r.FirstName;
                                            }else{
                                                person1.firstName = '';
                                            }
                                            person1.lastName = invoice.Payer__r.Related_Contact_Record_P2__r.LastName;
                                            if(invoice.Payer__r.Account_Main_Email_Formula__c != null && invoice.Payer__r.Account_Main_Email_Formula__c != ''){
                                                person1.emailAddress = invoice.Payer__r.Account_Main_Email_Formula__c;
                                            }else{
                                                person1.emailAddress = '';
                                            }  
                                            if(invoice.Payer__r.Account_Email_Opt_Out_Formula__c == false && invoice.Payer__r.Account_Main_Email_Formula__c != null && invoice.Payer__r.Account_Main_Email_Formula__c != ''){
                                                person1.includeInEmails = true;
                                                addedEmails.add(invoice.Payer__r.Account_Main_Email_Formula__c);
                                            }else{
                                                person1.includeInEmails = false;
                                            }
                                            xeroContact.contactPersons.add(person1);
                                        }else if(e == 'Parent 2 Alternate Email' && invoice.Payer__r.Account_Alternate_Email_Formula__c != null && invoice.Payer__r.Account_Alternate_Email_Formula__c != '' &&  !addedEmails.contains(invoice.Payer__r.Account_Alternate_Email_Formula__c)){
                                            sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                                            if(invoice.Payer__r.Related_Contact_Record_P2__r.FirstName != null){
                                                person1.firstName = invoice.Payer__r.Related_Contact_Record_P2__r.FirstName;
                                            }else{
                                                person1.firstName = '';
                                            }
                                            person1.lastName = invoice.Payer__r.Related_Contact_Record_P2__r.LastName;
                                            if(invoice.Payer__r.Account_Alternate_Email_Formula__c != null && invoice.Payer__r.Account_Alternate_Email_Formula__c != ''){
                                                person1.emailAddress = invoice.Payer__r.Account_Alternate_Email_Formula__c;
                                            }else{
                                                person1.emailAddress = '';
                                            }
                                            if(invoice.Payer__r.Account_Alternate_Email_Opt_Out_Formula__c == false && invoice.Payer__r.Account_Alternate_Email_Formula__c != null && invoice.Payer__r.Account_Alternate_Email_Formula__c != ''){
                                                person1.includeInEmails = true;
                                                addedEmails.add(invoice.Payer__r.Account_Alternate_Email_Formula__c);
                                            }else{
                                                person1.includeInEmails = false;
                                            }
                                            xeroContact.contactPersons.add(person1);
                                        }
                                    }
                                }
                            }
                      }else if(invoice.Payer__r.RecordType.DeveloperName == 'Company_Account'){
                            if((invoice.Payer__r.Company_Contact_Person_1_First_Name__c != null || invoice.Payer__r.Company_Contact_Person_1_Last_Name__c != null || invoice.Payer__r.Company_Email__c != null) && !addedEmails.contains(invoice.Payer__r.Company_Email__c)){
                                sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                                if(invoice.Payer__r.Company_Contact_Person_1_First_Name__c != null){
                                    person1.firstName = invoice.Payer__r.Company_Contact_Person_1_First_Name__c;
                                }else{
                                    person1.firstName = '';
                                }
                                if(invoice.Payer__r.Company_Contact_Person_1_Last_Name__c != null){
                                    person1.lastName = invoice.Payer__r.Company_Contact_Person_1_Last_Name__c;
                                }else{
                                    person1.lastName = '';
                                }
                                
                                if(invoice.Payer__r.Company_Email__c != null){
                                    person1.emailAddress = invoice.Payer__r.Company_Email__c;
                                    person1.includeInEmails = true;
                                }else{
                                    person1.emailAddress = '';
                                    person1.includeInEmails = false;
                                }
                                
                                addedEmails.add(invoice.Payer__r.Company_Email__c);
                                xeroContact.contactPersons.add(person1);
                            }
                            if((invoice.Payer__r.Company_Contact_Person_2_First_Name__c != null || invoice.Payer__r.Company_Contact_Person_2_Last_Name__c != null || invoice.Payer__r.Company_Email_2__c != null)  && !addedEmails.contains(invoice.Payer__r.Company_Email_2__c)){
                                sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                                if(invoice.Payer__r.Company_Contact_Person_2_First_Name__c != null){
                                    person1.firstName = invoice.Payer__r.Company_Contact_Person_2_First_Name__c;
                                }else{
                                    person1.firstName = '';
                                }
                                if(invoice.Payer__r.Company_Contact_Person_2_Last_Name__c != null){
                                    person1.lastName = invoice.Payer__r.Company_Contact_Person_2_Last_Name__c;
                                }else{
                                    person1.lastName = '';
                                }
                                if(invoice.Payer__r.Company_Email_2__c != null){
                                    person1.emailAddress = invoice.Payer__r.Company_Email_2__c;
                                    person1.includeInEmails = true;
                                }else{
                                    person1.emailAddress = '';
                                    person1.includeInEmails = false;
                                }
                                addedEmails.add(invoice.Payer__r.Company_Email_2__c);
                                xeroContact.contactPersons.add(person1);
                            }
                                
                        }
                        
                    }else{
                        xeroContact.contactPersons.clear();
                    }
                    if(xeroContact.contactPersons.size() == 0 && invoice.Payer__r.Primary_Invoicing_Contact_Email__c != null && invoice.Payer__r.Primary_Invoicing_Contact_Email__c != ''){
                        sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                        person1.firstName = 'Define in Salesforce';
                        person1.includeInEmails = false;
                        xeroContact.contactPersons.add(person1);
                    }
                    /*
                    //for additional xero contacts
                    if(invoice.Payer__r.Add_Invoicing_Contact_Email__c != null && invoice.Payer__r.Add_Invoicing_Contact_Email__c != ''){
                        sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                        person1.firstName = invoice.Payer__r.Add_Invoicing_Contact_First_Name__c;
                        person1.lastName = invoice.Payer__r.Add_Invoicing_Contact_Last_Name__c;
                        if(invoice.Payer__r.Add_Invoicing_Contact_Email__c != null && invoice.Payer__r.Add_Invoicing_Contact_Email__c != ''){
                            person1.emailAddress = invoice.Payer__r.Add_Invoicing_Contact_Email__c;
                            person1.includeInEmails = true;
                        }else{
                            person1.includeInEmails = false;
                        }
                        xeroContact.contactPersons.add(person1);
                    }else{//set default for integration
                        sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                        person1.firstName = 'DO NOT DELETE (Reserved for Salesforce sync)';
                        xeroContact.contactPersons.add(person1);
                    }*/
                    /*
                    sfXero.XeroContact.XeroContactPerson person1 = new sfXero.XeroContact.XeroContactPerson();
                    person1.firstName = 'Test1';
                    person1.lastName = 'Last1';
                    person1.emailAddress = 'test1@last1.com';
                    person1.includeInEmails = true;
                    xeroContact.contactPersons.add(person1);
                    */
                    /*
                    //Setup an email address
                    if(invoice.Payer__r.PersonEmail != null && invoice.Payer__r.PersonEmail != '') {
                        xeroContact.emailAddress = invoice.Payer__r.PersonEmail;
                    }
                    else if(invoice.Payer__r.Company_Email__c != null && invoice.Payer__r.Company_Email__c != '') {
                        xeroContact.emailAddress = invoice.Payer__r.Company_Email__c;
                    }
                    else if(invoice.Payer__r.Account_Main_Email_Formula__c != null && invoice.Payer__r.Account_Main_Email_Formula__c != '') {
                        xeroContact.emailAddress = invoice.Payer__r.Account_Main_Email_Formula__c;
                    }
                    //setup phone
                    if(invoice.Payer__r.Phone != null && invoice.Payer__r.Phone != '') {
                        xeroContact.addPhone(createPhone(invoice.Payer__r.Phone));
                        System.debug('### phone one');
                    }
                    if(invoice.Payer__r.Phone_2__c != null && invoice.Payer__r.Phone_2__c != '') {
                        xeroContact.addPhone(createPhone(invoice.Payer__r.Phone_2__c));
                        System.debug('### phone two');
                    }*/
                    if(invoice.Payer__r.Primary_Invoicing_Contact_Phone_Number__c != null && invoice.Payer__r.Primary_Invoicing_Contact_Phone_Number__c != '') {
                        xeroContact.addPhone(createPhone(invoice.Payer__r.Primary_Invoicing_Contact_Phone_Number__c, invoice.Payer__r.Primary_Invoicing_Contact_Country_Code__c));
                        System.debug('### phone two');
                    }else{
                        xeroContact.addPhone(createPhone('',''));
                        
                    }
                    
                    //and addresses
                    if(invoice.Payer__r.Main_Address__c != null && invoice.Payer__r.RecordType.DeveloperName == 'Company_Account')
                    {
                        List<String> address = invoice.Payer__r.Main_Address__c.split('\n', 4);
                        sfXero.XeroContact.XeroAddress xeroAddress = new sfXero.XeroContact.XeroAddress();
                        xeroAddress.addressLine1 = address.size() > 0 ? address.get(0) : '';
                        xeroAddress.addressLine2 = address.size() > 1 ? address.get(1) : '';
                        xeroAddress.addressLine3 = address.size() > 2 ? address.get(2) : '';
                        xeroAddress.addressLine4 = address.size() > 3 ? address.get(3) : '';
                        xeroAddress.addressType = sfXero.XeroContact.XeroAddressType.POBOX;                     
                        xeroContact.addAddress(xeroAddress);
                        
                        sfXero.XeroContact.XeroAddress xeroAddress2 = new sfXero.XeroContact.XeroAddress();
                        xeroAddress2.addressLine1 = address.size() > 0 ? address.get(0) : '';
                        xeroAddress2.addressLine2 = address.size() > 1 ? address.get(1) : '';
                        xeroAddress2.addressLine3 = address.size() > 2 ? address.get(2) : '';
                        xeroAddress2.addressLine4 = address.size() > 3 ? address.get(3) : '';
                        xeroAddress2.addressType = sfXero.XeroContact.XeroAddressType.STREET;                       
                        xeroContact.addAddress(xeroAddress2);
                    }else if(invoice.Payer__r.RecordType.DeveloperName == 'PersonAccount'){ 
                         
                        
                        sfXero.XeroContact.XeroAddress xeroAddress = new sfXero.XeroContact.XeroAddress();
                        xeroAddress.addressLine1 = invoice.Payer__r.Address_Apartment_Condo_Name_Number__pc != null ? invoice.Payer__r.Address_Apartment_Condo_Name_Number__pc : '';
                        xeroAddress.addressLine2 = invoice.Payer__r.Address_Street_Name_Number__pc != null ? invoice.Payer__r.Address_Street_Name_Number__pc : '';
                        xeroAddress.addressLine3 = invoice.Payer__r.Address_Line_2__pc != null ? invoice.Payer__r.Address_Line_2__pc : '';
                        xeroAddress.addressLine4 = '';
                        xeroAddress.city = invoice.Payer__r.Address_City__pc != null ? invoice.Payer__r.Address_City__pc : '';
                        xeroAddress.region = invoice.Payer__r.Address_State_Province__pc != null ? invoice.Payer__r.Address_State_Province__pc : '';
                        xeroAddress.postalCode = invoice.Payer__r.Address_Zip_Postal_Code__pc != null ? invoice.Payer__r.Address_Zip_Postal_Code__pc : '';
                        xeroAddress.country = invoice.Payer__r.Address_Country__pc != null ? invoice.Payer__r.Address_Country__pc : '';
                        xeroAddress.addressType = sfXero.XeroContact.XeroAddressType.POBOX;                     
                        xeroContact.addAddress(xeroAddress); 
                        
                        sfXero.XeroContact.XeroAddress xeroAddress2 = new sfXero.XeroContact.XeroAddress();
                        xeroAddress2.addressLine1 = invoice.Payer__r.Address_Apartment_Condo_Name_Number__pc != null ? invoice.Payer__r.Address_Apartment_Condo_Name_Number__pc : '';
                        xeroAddress2.addressLine2 = invoice.Payer__r.Address_Street_Name_Number__pc != null ? invoice.Payer__r.Address_Street_Name_Number__pc : '';
                        xeroAddress2.addressLine3 = invoice.Payer__r.Address_Line_2__pc != null ? invoice.Payer__r.Address_Line_2__pc : '';
                        xeroAddress2.addressLine4 = '';
                        xeroAddress2.city = invoice.Payer__r.Address_City__pc != null ? invoice.Payer__r.Address_City__pc : '';
                        xeroAddress2.region = invoice.Payer__r.Address_State_Province__pc != null ? invoice.Payer__r.Address_State_Province__pc : '';
                        xeroAddress2.postalCode = invoice.Payer__r.Address_Zip_Postal_Code__pc != null ? invoice.Payer__r.Address_Zip_Postal_Code__pc : '';
                        xeroAddress2.country = invoice.Payer__r.Address_Country__pc != null ? invoice.Payer__r.Address_Country__pc : '';
                        xeroAddress2.addressType = sfXero.XeroContact.XeroAddressType.STREET;                     
                        xeroContact.addAddress(xeroAddress2);
                        
                        
                    }else{
                        sfXero.XeroContact.XeroAddress xeroAddress = new sfXero.XeroContact.XeroAddress();
                        xeroAddress.addressLine1 = '';
                        xeroAddress.addressLine2 = '';
                        xeroAddress.addressLine3 = '';
                        xeroAddress.addressLine4 = '';
                        xeroAddress.addressType = sfXero.XeroContact.XeroAddressType.POBOX;                     
                        xeroContact.addAddress(xeroAddress);
                        
                        sfXero.XeroContact.XeroAddress xeroAddress2 = new sfXero.XeroContact.XeroAddress();
                        xeroAddress2.addressLine1 = '';
                        xeroAddress2.addressLine2 = '';
                        xeroAddress2.addressLine3 = '';
                        xeroAddress2.addressLine4 = '';
                        xeroAddress2.addressType = sfXero.XeroContact.XeroAddressType.STREET;                       
                        xeroContact.addAddress(xeroAddress2);
                    }
                
                
                    
                //Create the invoice
                sfXero.XeroInvoice xeroInvoice  = new sfXero.XeroInvoice();
                xeroInvoice.invoiceType         = sfXero.XeroInvoice.XeroInvoiceType.ACCREC;
                xeroInvoice.contact             = xeroContact;
                xeroInvoice.reference           = invoice.Reference__c;
                xeroInvoice.currencyCode        = invoice.Currency__c;
                xeroInvoice.issuedDate          = invoice.Invoice_Date__c;
                xeroInvoice.dueDate             = invoice.Generated_Date__c;
                xeroInvoice.lineAmountTypes     = sfXero.XeroInvoice.XeroLineAmountType.Inclusive;
                //and finally the invoice line items
                for(Line_Item__c lineItem : lineItems.get(invoice.Id)) {
                    //setup the line item infor
                    sfXero.XeroLineItem xeroLineItem = new sfXero.XeroLineItem();
                    xeroLineItem.description = lineItem.Description__c +' - ' +lineItem.Students_Info__c;
                    xeroLineItem.quantity = 1;
                    xeroLineItem.unitAmount = lineItem.Unit_Price__c;
                    
                    //Depending on what type of fee it is assign a predefied (in the xeroKey) or default account code
                    if(lineItem.Fee_Type__c == 'Tuition') {
                        xeroLineItem.accountCode = (xeroKey.AccCode_Tuition__c == null) ? '100' : xeroKey.AccCode_Tuition__c;
                    }
                    else if(lineItem.Fee_Type__c == 'Lunch') {
                        xeroLineItem.accountCode = (xeroKey.AccCode_Lunch__c == null) ? '101' : xeroKey.AccCode_Lunch__c;
                    }
                    else if(lineItem.Fee_Type__c == 'Bus') {
                        xeroLineItem.accountCode = (xeroKey.AccCode_Bus__c == null) ? '102' : xeroKey.AccCode_Bus__c;
                    }
                    else if(lineItem.Fee_Type__c == 'Enrolment') {
                         xeroLineItem.accountCode = (xeroKey.AccCode_Enrolment__c == null) ? '104' : xeroKey.AccCode_Enrolment__c;
                  }
                      else if(lineItem.Fee_Type__c == 'Application') {
                           xeroLineItem.accountCode = (xeroKey.AccCode_Application__c == null) ? '105' : xeroKey.AccCode_Application__c;
                  }
                      else if(lineItem.Fee_Type__c == 'EAL') {
                            xeroLineItem.accountCode = (xeroKey.AccCode_EAL__c == null) ? '106' : xeroKey.AccCode_EAL__c;
                    }
                    else {
                        xeroLineItem.accountCode = (xeroKey.AccCode_Other__c == null) ? '107' : xeroKey.AccCode_Other__c;
                    }
                    //changes made by Kunal - for pushing tracking
                    //list<sfXero.XeroTrackingCategory> clist = new list<sfXero.XeroTrackingCategory>();
                    if(xeroKey.Tracking_Category_1_Company__c != null && lineItem.Tracking_1__c != null && lineItem.Tracking_1__c != ''){
                        sfXero.XeroTrackingCategory tc = new sfXero.XeroTrackingCategory();
                        //tc.id = xeroKey.Tracking_Category_1_Company__c;
                        tc.name = xeroKey.Tracking_Category_1_Company__c;
                        tc.status = 'ACTIVE';
                        //put category option
                        sfXero.XeroTrackingCategory.XeroTrackingCategoryOption xeroTypeOfWorkOption = new sfXero.XeroTrackingCategory.XeroTrackingCategoryOption();
                        xeroTypeOfWorkOption.name = lineItem.Tracking_1__c;
                        tc.options.add(xeroTypeOfWorkOption);
                        xeroLineItem.trackingCategories.add(tc);
                    }
                    if(xeroKey.Tracking_Category_2_Campus_Misc__c != null && lineItem.Tracking__c != null && lineItem.Tracking__c != ''){
                        sfXero.XeroTrackingCategory tc = new sfXero.XeroTrackingCategory();
                        //tc.id = xeroKey.Tracking_Category_2_Campus_Misc__c;
                        tc.name = xeroKey.Tracking_Category_2_Campus_Misc__c;
                        tc.status = 'ACTIVE';
                        //put category option
                        sfXero.XeroTrackingCategory.XeroTrackingCategoryOption xeroTypeOfWorkOption = new sfXero.XeroTrackingCategory.XeroTrackingCategoryOption();
                        xeroTypeOfWorkOption.name = lineItem.Tracking__c;
                        tc.options.add(xeroTypeOfWorkOption);
                        xeroLineItem.trackingCategories.add(tc);
                    }
                    //add it to the list
                    xeroInvoice.addLineItem(xeroLineItem);
                }
                
                if(Test.isRunningTest()) {
                    invoice.Error_Message__c = 'Test Pass';
                }
                else {
                    try {
                        System.debug('### *****xeroInvoice ' +xeroInvoice);
                        //Setup the xeroCredentials and then post the invoices to xero
                        String consumerSecret = (xeroKey.Consumer_Secret__c == null) ? '' : xeroKey.Consumer_Secret__c;
                        sfXero.XeroCredentials xeroCreds = new sfXero.XeroCredentials(xeroKey.Consumer_Key__c, consumerSecret, xeroKey.Private_Key__c);
                        sfXero.XeroInvoiceResponse response = sfXero.XeroAPI.postInvoices( new List<sfXero.XeroInvoice>{ xeroInvoice }, xeroCreds);
                        System.debug('### *****response ' +response);
                        
                        if(response.status == 'OK') {
                            invoice.Xero_Id__c = response.invoices[0].invoiceId;
                            invoice.Error_Message__c = '';
                            invoice.Xero_Invoice_Number__c = response.invoices[0].invoiceNumber;
                        
                            invoice.Xero_Value__c = response.invoices[0].total;
                            invoice.Xero_Status__c = String.valueOf(response.invoices[0].status);
                            invoice.Xero_Invoice_Date__c = response.invoices[0].issuedDate;
                            invoice.Xero_Invoice_Currency__c = response.invoices[0].currencyCode;
                            //update contact Id
                            if(response.invoices[0].contact.contactID != null){
                                //if(invoice.Payer__r.Xero_Contact_ID__c == null){
                                    Account payerAccount = new Account(Id=invoice.Payer__c);
                                    payerAccount.Xero_Contact_ID__c = response.invoices[0].contact.contactID;
                                    payersForUpdatingXeroContactId.add(payerAccount);
                                //}
                            }
                        }
                        else { 
                            //if the failure message can be extracted from the response try to do so 
                            if(response.badrequest != null && response.badrequest.errorType == 'ValidationException') {
                                String error = '';
                                for(String str : response.badrequest.requestValidations) {
                                    error += str;
                                }
                                invoice.Error_Message__c = error;
                            }
                            else {
                                invoice.Error_Message__c = response.xmlResponse;
                            }
                        }
                    }
                    catch(Exception e) {
                        invoice.Error_Message__c = 'Sending to xero failed ' +e.getMessage();
                    }
                }
            }  
        }
        
        update newInvoices;
        
        if(payersForUpdatingXeroContactId.size() > 0){
             list<Database.SaveResult> srList = Database.update(payersForUpdatingXeroContactId,false);
                integer i = 0;
                list<Account> errorRecords = new list<Account>();
                for(Database.Saveresult sr:srlist){
                    if(!sr.isSuccess()){
                        string errorMessage = sr.getErrors()[0].getMessage();
                        if(errorMessage.length() > 254){
                            errorMessage = errorMessage.subString(errorMessage.length()-254,errorMessage.length());
                        }
                        errorRecords.add(new Account(Id=payersForUpdatingXeroContactId[i].Id,Failed_to_Update_Xero_Id__c=true,Error_Message__c = errorMessage));
                    }
                    i++;
                }
                if(errorRecords.size() > 0){
                    update errorRecords;
                }
        }
    }
    
    private  sfXero.XeroContact.XeroPhone createPhone(String phone, String countryCode)
    {
         sfXero.XeroContact.XeroPhone xeroPhone = new sfXero.XeroContact.XeroPhone();
         xeroPhone.phoneType = sfXero.XeroContact.XeroPhoneType.DEFAULTPHONE;
         xeroPhone.phoneNumber = phone;
         if(countryCode == null){
            xeroPhone.countryCode = '';
         }else{
            xeroPhone.countryCode = countryCode;
         }
         return xeroPhone;
    }
     
    global void finish(Database.BatchableContext BC){ }
}