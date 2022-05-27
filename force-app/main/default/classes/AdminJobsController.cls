public with sharing class AdminJobsController {

    public PageReference generateInvoices(){
        BatchInvoiceGeneration big = new BatchInvoiceGeneration();
        Database.executeBatch(big, 1);
        return null;
    }
    
    public PageReference sendToXero(){
        BatchInvoiceSending bis = new BatchInvoiceSending();
        Database.executeBatch(bis,1);
        return null;
    }    

}