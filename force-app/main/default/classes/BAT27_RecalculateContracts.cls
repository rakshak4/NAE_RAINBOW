/** 
 * @Description        : Batch launched from Account: Recalculate all Accounts checked fields
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : FKH
 * @Last Modified On   : 22-OCT-2021, 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    22-OCT-2021, 10:00 am         FKH         Initial Version
**/
global class BAT27_RecalculateContracts implements  Database.Batchable<sObject>, Database.Stateful{

    global String query;
    Set<ID> setAllRelatedAccIds;

    // global BAT27_RecalculateContracts(Set<ID> setAllRelatedAccIds){
    //     this.setAllRelatedAccIds = setAllRelatedAccIds;
    //     query = 'Select id, region__c,TechAccountParents__c,accountid from Contract where Status= \'Activated\' and accountid in: setAllRelatedAccIds';
    // }

    global BAT27_RecalculateContracts(){
        query = 'Select id, region__c,TechAccountParents__c,accountid from Contract where Status= \'Activated\'';
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Contract> lstContracts) {
        Ap33_ContractRules.updateAccountSpecificRegions(lstContracts);
    }

    global void finish(Database.BatchableContext bc){
        String jobName = 'BAT27_RecalculateContracts' + System.now(); 
    }

}