global with sharing class ScheduleUserPhotoUpdate implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        boolean flag = false;
        for(User u:[Select Id, Name, Photo_Attachment_Id__c from User where  Photo_Attachment_Id__c != null limit 1]){
        	flag = true;
        }
        if(flag){
	        Batch_UserPhotoUpdate big = new Batch_UserPhotoUpdate();
	        Database.executeBatch(big, 1);
        }
    }
    
    public static void setup() {
        
        ScheduleUserPhotoUpdate job = new ScheduleUserPhotoUpdate();
        String sch = '0 15 * * * ?';
        
        system.schedule('User Photo Update', sch, job);
    }
}