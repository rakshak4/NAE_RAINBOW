/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Controller for C03_ApplicationDocuments
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 27-JUL-2018  AMU     1.0     Get list of Application documents for a particular school
--------------------------------------------------------------------------------------
***************************************************************************************/
public with sharing class VFC03_ApplicationDocuments {

	public List<ApplicationDocument__c> getAppDocs(){
		List<ApplicationDocument__c> lstAppDocs = new List<ApplicationDocument__c>();
		User user = [SELECT SchoolCode__c FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];

		if(String.isNotBlank(user.SchoolCode__c)) {
			School__c school = [SELECT Id, (SELECT Name FROM ApplicationDocuments__r) FROM School__c WHERE SchoolCode__c =: user.SchoolCode__c.trim()];
			lstAppDocs = school.ApplicationDocuments__r;
		}

		return lstAppDocs;
	}
}