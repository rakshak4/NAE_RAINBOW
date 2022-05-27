//scheduler class for BatchContactReminderEmail
global class SchedulerContactReminderEmail implements Schedulable{
	global void execute(SchedulableContext sc) {   
        BatchContactReminderEmail b = new BatchContactReminderEmail();
        Database.executeBatch(b, 20);  
    }
}