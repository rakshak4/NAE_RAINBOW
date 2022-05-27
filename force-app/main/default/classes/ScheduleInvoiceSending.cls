global with sharing class ScheduleInvoiceSending implements Schedulable {

    global void execute(SchedulableContext sc) {
        
        BatchInvoiceSending bis = new BatchInvoiceSending();
        Database.executeBatch(bis, 1);
    }
    
    public static void setup() {
        
        ScheduleInvoiceSending job = new ScheduleInvoiceSending();
        String sch = '0 0 8 * * ?';
        
        system.schedule('Invoice Sending', sch, job);
    }
}