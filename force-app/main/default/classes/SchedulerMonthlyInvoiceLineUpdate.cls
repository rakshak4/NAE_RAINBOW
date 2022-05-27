//scheduler class to update invoice line on 1st of every month
global class SchedulerMonthlyInvoiceLineUpdate implements Schedulable{
	
	global void execute(SchedulableContext sc) {
        
        BatchMonthlyInvoiceLineUpdate big = new BatchMonthlyInvoiceLineUpdate();
        Database.executeBatch(big, 200);
    }
}