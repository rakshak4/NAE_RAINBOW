global with sharing class ScheduleInvoiceGeneration implements Schedulable {
	
    global void execute(SchedulableContext sc) {
        
        BatchInvoiceGeneration big = new BatchInvoiceGeneration();
        Database.executeBatch(big, 1);
    }
    
    public static void setup() {
        
        ScheduleInvoiceGeneration job = new ScheduleInvoiceGeneration();
        String sch = '0 0 6 * * ?';
        
        system.schedule('Invoice Generation', sch, job);
    }
}