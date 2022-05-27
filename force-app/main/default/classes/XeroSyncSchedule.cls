/**
 * Schedulable class to trigger XeroSync periodicly.
 *
 * @author Logan Moore
 * @created August 2013
 */
global class XeroSyncSchedule implements Schedulable {

	global static void schedule() {
		String name = Test.isRunningTest() ? 'XeroSyncTest' : 'XeroSync';
		String cron = '0 0 * * * ?'; // Every, every hour
		XeroSyncSchedule job = new XeroSyncSchedule();
		System.schedule(name, cron, job);
	}

	global void execute(SchedulableContext sc) {
		//XeroSyncLogic.syncAll();
		if(!Test.isRunningTest()){Database.executeBatch(new XeroSyncBatch(), 1);}
	}
}