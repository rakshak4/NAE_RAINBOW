//scheduler class for Batch_SendKompanionOutboundMessage
global class Schedule_SendKompanionOutboundMessage implements Schedulable{
    global void execute(SchedulableContext SC) {
        Batch_SendKompanionOutboundMessage b = new Batch_SendKompanionOutboundMessage();
        database.executeBatch(b,1);
   }
}