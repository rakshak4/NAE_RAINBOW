global with sharing class SchedulerEventReminderEmail implements Schedulable{
	
	global void execute(SchedulableContext sc) {   
        /*
        string query = 'Select n.Student_Group__c, n.Snd_Email_Notification_Text__c, n.Snd_Email_Notification_Preview__c, n.Snd_Email_Notification_Date_Time__c, n.Send_Second_Reminder_Email__c, n.Send_First_Reminder_Email__c, n.Second_Reminder_Email_Sent__c, n.School__c, n.RecordType.DeveloperName, n.RecordType.Name, n.RecordTypeId, n.Id, n.Fst_Email_Notification_Text__c, n.Fst_Email_Notification_Preview__c, n.Fst_Email_Notification_Date_Time__c, n.First_Reminder_Email_Sent__c, n.Event_Start_Date__c, n.Event_End_Date__c, n.Date__c From News_Events__c n where n.Send_First_Reminder_Email__c = true OR n.Send_Second_Reminder_Email__c = true';
        EventEmailReminderBatch b = new EventEmailReminderBatch(query);
        Database.executeBatch(b, 1);*/
    }
    
}