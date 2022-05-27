@isTest
private class Test_InvoiceLineUpdate{
     static testMethod void testInvoiceLineUpdateBatch(){
         Test.StartTest();
		   BatchMonthlyInvoiceLineUpdate Capture = new BatchMonthlyInvoiceLineUpdate();
		   ID batchprocessid = Database.executeBatch(Capture);
		 Test.StopTest();
     }
     
      static testMethod void testInvoiceLineUpdateSchedule(){
         Test.StartTest();
		   SchedulerMonthlyInvoiceLineUpdate sh1 = new SchedulerMonthlyInvoiceLineUpdate();
		   String sch = '0 0 23 * * ?'; 
		   system.schedule('Test Territory Check', sch, sh1); 
		 Test.StopTest();
     }
}