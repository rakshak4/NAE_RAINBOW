/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Class for lightning component LC11
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 16-JAN-2019  KZE    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
public with sharing class LC11_PreNurseryTable {

    /**
     * Get opp details with id
     * @return     opp details with id
     */
    @AuraEnabled
    public static Opportunity getDetails(Id oppId) {
        try {    
            return [SELECT Id, Name, TECH_EarlyYMonAM__c,TECH_EarlyYMonPM__c,TECH_EarlyYTuesAM__c,TECH_EarlyYTuesPM__c,TECH_EarlyYWedAM__c,TECH_EarlyYWedPM__c,
            			TECH_EarlyYThurAM__c,TECH_EarlyYThurPM__c,TECH_EarlyYFriAM__c,TECH_EarlyYFriPM__c,TECH_EarlyYSunAM__c,TECH_EarlyYSunPM__c, SchoolOfInterest__c
                         ,SchoolOfInterest__r.Region__c
            	FROM Opportunity 
                WHERE Id = :oppId 
                LIMIT 1];
        }
        catch(Exception e){
        	System.debug('Error' + e.getMessage());
        	return null;
        }
    }
    @AuraEnabled
    public static void saveDetails(Opportunity opp) {
        try {  
        	System.debug('Saving:' + opp);  
            update opp;
        }
        catch(Exception e){
        	System.debug('Error' + e.getMessage());
        }
    }
}