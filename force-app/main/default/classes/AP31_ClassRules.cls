/**
 * @File Name          : AP31_ClassRules.cls
 * @Description        : Class Rules
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 10-FEB-2021, 2:20 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    15-MAR-2021, 10:00 am         VJA         Initial Version
**/
public with sharing class AP31_ClassRules {

    //Method to update class capacity
    public static void updateClassCapacity(Set<Id> setClassId){
        System.debug('##AP31_ClassRules setClassId.size(): ' + setClassId.size());
        System.debug('###AP31 batch 26 execution');
        Id batchJobId = Database.executeBatch(new BAT26_ClassCapacityUpdate(setClassId));
    }

    //Method to create class capacity
    public static void createClassCapacity(Set<Id> setClassId){
        Id batchJobId = Database.executeBatch(new BAT25_ClassCapacityInsert(setClassId));
    }


}