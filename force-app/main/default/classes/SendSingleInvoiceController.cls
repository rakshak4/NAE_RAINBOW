public class SendSingleInvoiceController{
    
    public ApexPages.StandardController controller {get; set;} 
    
    public SendSingleInvoiceController(ApexPages.StandardController sc){
        this.controller = sc;
    }
    
    public PageReference sendToXero(){
        
        try {
            Invoice_Statement__c invoice = [
                Select Payer__r.Primary_Invoicing_Contact_Full_Name__c, Payer__r.Primary_Invoicing_Contact_First_Name__c, Payer__r.Primary_Invoicing_Contact_Last_Name__c, Payer__r.Primary_Invoicing_Contact_Email__c, Payer__r.Primary_Invoicing_Contact_Country_Code__c, Payer__r.Primary_Invoicing_Contact_Phone_Number__c,  Id, Payer__r.Xero_Contact_Id__c, Xero_Id__c, Payer__c, Payer__r.Account_UID_Formula__c, Reference__c, Generated_Date__c, Invoice_Date__c, School__c, Single_Invoice__c,
                    //Payer__r.Add_Invoicing_Contact_Email__c,  Payer__r.Add_Invoicing_Contact_First_Name__c, Payer__r.Add_Invoicing_Contact_Last_Name__c,
                    Payer__r.RecordType.DeveloperName, Payer__r.Email_Addresses_to_Include_in_Xero__c, Payer__r.PersonEmail, Payer__r.Contact_Alternate_Email__pc, Payer__r.PersonHasOptedOutOfEmail, Payer__r.Contact_Alternate_Email_Opt_Out__pc, Payer__r.Account_Main_Email_Formula__c, Payer__r.Account_Email_Opt_Out_Formula__c, Payer__r.Account_Alternate_Email_Formula__c, Payer__r.Account_Alternate_Email_Opt_Out_Formula__c, 
                    Payer__r.Company_Contact_Person_1_First_Name__c, Payer__r.Company_Contact_Person_1_Last_Name__c, Payer__r.Company_Contact_Person_2_First_Name__c, Payer__r.Company_Contact_Person_2_Last_Name__c, Payer__r.Company_Email__c, Payer__r.Company_Email_2__c, 
                    Payer__r.RecordTypeId, Payer__r.RecordType.Name,Payer__r.Phone, Payer__r.Main_Address__c, Currency__c,
                    //Payer__r.FirstName, Payer__r.LastName, Payer__r.Name, Payer__r.PersonEmail, Payer__r.Account_Main_Email_Formula__c, Payer__r.Company_Email__c 
                    Payer__r.FirstName, Payer__r.LastName, Payer__r.Name, Payer__r.Related_Contact_Record_P2__r.FirstName, Payer__r.Related_Contact_Record_P2__r.LastName,  
                    Payer__r.Address_Apartment_Condo_Name_Number__pc, Payer__r.Address_Street_Name_Number__pc, Payer__r.Address_Line_2__pc,  Payer__r.Address_City__pc, Payer__r.Address_State_Province__pc, Payer__r.Address_Zip_Postal_Code__pc, Payer__r.Address_Country__pc
                  From Invoice_Statement__c 
                 Where Id =: this.controller.getId()
            ];
            if(invoice.Xero_Id__c != null){
                //fetch invoice status
                String school = invoice.School__c;
                if(school == 'Pamplona') {
                    school = 'Navarra'; 
                }
                // Get the Xero key for the given school
                Xero_Key__c xeroKey = [
                    SELECT Id, Name, Private_Key__c, Consumer_Key__c, Consumer_Secret__c, 
                        AccCode_Tuition__c, AccCode_Lunch__c, AccCode_Bus__c, AccCode_Other__c,
                        AccCode_Enrolment__c, AccCode_Application__c, AccCode_EAL__c, Tracking_Category_1_Company__c, Tracking_Category_2_Campus_Misc__c
                      FROM Xero_Key__c 
                     WHERE Name =: school limit 1
                 ];
                String consumerSecret = (xeroKey.Consumer_Secret__c == null) ? '' : xeroKey.Consumer_Secret__c;
                sfXero.XeroCredentials xeroCreds = new sfXero.XeroCredentials(xeroKey.Consumer_Key__c, consumerSecret, xeroKey.Private_Key__c);
                sfXero.XeroInvoiceResponse response = sfXero.XeroAPI.getInvoiceById(xeroCreds,invoice.Xero_Id__c );
                System.debug('### ***SendSingleInvoiceController**response ' +response);
                if(response.status == 'OK' && !test.isRunningTest()) {
                    string invoiceStatus = String.valueOf(response.invoices[0].status);
                    if(invoiceStatus != null){
                        if(!invoiceStatus.equalsIgnoreCase('voided') && !invoiceStatus.equalsIgnoreCase('deleted')){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You cannot send this invoice to Xero again until the current one is deleted or voided in Xero. To view the Xero invoice you can use the \'Link to Xero Invoice\' field on invoice record.'));
                            return null;
                        }
                    }
                }
            }
            
            
            List<Invoice_Statement__c> invoices = new List<Invoice_Statement__c>();
            invoices.add(invoice);
            
            BatchInvoiceSending bis = new BatchInvoiceSending();
            bis.sendInvoices(invoices);
            
            return new PageReference('/' + invoice.Id);
        }
        catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Failure during sending : ' + e.getMessage()));
            return null;
        }
    }    
    
    public PageReference returnToInvoice(){
        return this.controller.view();
    }
    
    
    
}