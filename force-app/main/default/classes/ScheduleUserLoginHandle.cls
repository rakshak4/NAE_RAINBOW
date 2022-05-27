global with sharing class ScheduleUserLoginHandle implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        
        Batch_UserLoginUpdate big = new Batch_UserLoginUpdate();
        Database.executeBatch(big, 200);
    }
    
    public static void setup() { 
        
        ScheduleUserLoginHandle job = new ScheduleUserLoginHandle();
        //String sch = '0 0 * * * ?';
        String sch = '0 0 0,4,8,12,16,20 * * ?';
        system.schedule('User Login Handle', sch, job);
    }
}