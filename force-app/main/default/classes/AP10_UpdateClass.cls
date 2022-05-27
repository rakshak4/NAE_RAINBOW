/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : School Capacity - Maintain Database for School Term/Programs on a per school level
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 31-JUL-2018  AMU   1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/
public with sharing class AP10_UpdateClass {

    /**
     * Update class when opportunity changes class.
     * @param      mapOldToNewOpp  Map old opp to new opp
     */
     
    public static void updateClass(Map<Opportunity, Opportunity> mapOldToNewOpp) {
        Map<Id, Class__c> mapIdToClass = getMapClass(mapOldToNewOpp);
        Map<String, String> mapOppIdToGender = getMapOppIdToGender(mapOldToNewOpp.keySet());
        Map<Id, Class__c> mapIdToClassUpd = new Map<Id, Class__c>(); 

        try {
             for(Opportunity oldOpp: mapOldToNewOpp.keySet()) {
                String gender = mapOppIdToGender.get(oldOpp.Id);
                String oldClassId = oldOpp.Class__c;
                String newClassId = mapOldToNewOpp.get(oldOpp).Class__c;

                if(mapIdToClass.containsKey(oldClassId)) {
                    if(gender == AP_Constant.conGenderFemale) {
                        if(mapIdToClass.get(oldClassId).FemaleCount__c > 0) {
                            mapIdToClass.get(oldClassId).FemaleCount__c -= 1;
                        }
                    }

                    else if(gender == AP_Constant.conGenderMale) {
                        if(mapIdToClass.get(oldClassId).MaleCount__c > 0) {
                            mapIdToClass.get(oldClassId).MaleCount__c -= 1;
                        }
                    }
                    mapIdToClassUpd.put(oldClassId, mapIdToClass.get(oldClassId));
                }

                if(mapIdToClass.containsKey(newClassId)) {
                    mapIdToClass.get(newClassId).FemaleCount__c = mapIdToClass.get(newClassId).FemaleCount__c != null? mapIdToClass.get(newClassId).FemaleCount__c : 0;
                    mapIdToClass.get(newClassId).MaleCount__c = mapIdToClass.get(newClassId).MaleCount__c != null? mapIdToClass.get(newClassId).MaleCount__c : 0;

                   // if((mapIdToClass.get(newClassId).MaleCount__c + mapIdToClass.get(newClassId).FemaleCount__c) < mapIdToClass.get(newClassId).Capacity__c) {
                         if(gender == AP_Constant.conGenderFemale) {
                            mapIdToClass.get(newClassId).FemaleCount__c += 1;
                        }

                        else if(gender == AP_Constant.conGenderMale) {
                            mapIdToClass.get(newClassId).MaleCount__c += 1;
                        }
                        mapIdToClassUpd.put(newClassId, mapIdToClass.get(newClassId));
                    //}
                }
            }

            if(mapIdToClassUpd.size() > 0) {
                update new List<Class__c>(mapIdToClassUpd.values());
            }
        } catch(Exception e) {
            System.debug(e.getMessage());
        }
    }

    /**
     * Get Map of classes.
     * @param      mapOldToNewOpp  Map of old to new opp
     * @return     Map of classes
     *
     **/ 
    public static Map<Id, Class__c> getMapClass(Map<Opportunity, Opportunity> mapOldToNewOpp){
         Set<Id> setAllClassesId = new Set<Id>();

        for(Opportunity oldOpp: mapOldToNewOpp.keySet()) {
            if(String.isNotBlank(oldOpp.Class__c)) {
                setAllClassesId.add(oldOpp.Class__c);
            }
            
            if(String.isNotBlank(mapOldToNewOpp.get(oldOpp).Class__c)) {
               setAllClassesId.add(mapOldToNewOpp.get(oldOpp).Class__c); 
            }
        }

        return new Map<Id, Class__c>([SELECT Id, FemaleCount__c, MaleCount__c, Capacity__c
                                                FROM Class__c WHERE Id IN :setAllClassesId]);
    }

    /**
     * Get the map opp to gender.
     * @param      setOpp  The set opp
     * @return     The map opp to gender.
     *
     **/
    public static Map<String, String> getMapOppIdToGender(Set<Opportunity> setOpp){
        Map<String, String> mapOppIdToGender = new Map<String, String>();

        for(Opportunity opp: [SELECT Child__r.Gender__c FROM Opportunity WHERE Id IN: setOpp]) {
            mapOppIdToGender.put(opp.Id, opp.Child__r.Gender__c);
        }
        return mapOppIdToGender;
    }
    
}