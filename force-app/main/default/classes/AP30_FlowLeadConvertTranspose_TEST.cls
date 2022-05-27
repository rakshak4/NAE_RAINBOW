/**
 * @File Name          : AP30_FlowLeadConvertTranspose_TEST.cls
 * @Description        : Test class for AP30_FlowLeadConversionTransposition
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : VJA
 * @Last Modified On   : 18-FEB-2021, 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    18-FEB-2021, 10:00 am         VJA         Initial Version
**/
@isTest
public without sharing class AP30_FlowLeadConvertTranspose_TEST {
    static List<User> lstUser;
	static List<Account> lstAcc;
	static List<Contact> lstCon;
	static List<Lead> lstLed;
	static List<School__c> lstSchool;
    static Map<String, Id> mapRecordTypeToId;
    static List<AP30_FlowLeadConversionTransposition.LeadConvertRequest> lstConvertRequest;
    static AP30_FlowLeadConversionTransposition.LeadConvertRequest convertRequest;

    static{
        lstUser = new List<User>{
            TestFactory.createUser('Test', TestFactory.getProfileAdminId())
        };
        insert lstUser;

        lstAcc = new List<Account>{
            new Account(Name = 'Sawyer Family', MidTierAccountID__c = 'test')
        };
        insert lstAcc;

        lstSchool = new List<School__c>{
            TestFactory.createSchool('le cateau vert', 'St pierre', true, 'PPE')
        };
        insert lstSchool;
        
        mapRecordTypeToId = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject, AP_Constant.conObject, AP_Constant.ledObject});

        lstCon = new List<Contact>{
            new Contact(LastName = 'Tom', FirstName = 'Sawyer', MobilePhone = null, Email = null, Phone = null, AccountId = lstAcc[0].Id, RecordTypeId = mapRecordTypeToId.get(AP_Constant.conRecordTypeChild), LeadPosition__c = 'Child 1', Gender__c = 'Male', BirthDate = Date.newInstance(2010, 2, 2)),
            new Contact(LastName = 'Sam', FirstName = 'Sawyer', MobilePhone = '123', Email = 'test@test.te', Phone = null, AccountId = lstAcc[0].Id, RecordTypeId = mapRecordTypeToId.get(AP_Constant.conRecordTypeChild), LeadPosition__c = 'Child 2', Gender__c = 'Male', BirthDate = Date.newInstance(2010, 2, 2))
        };
        insert lstCon;

        lstLed = new List<Lead>{
            new Lead(
                Company = lstAcc[0].Name, 
                LastName = lstCon[0].LastName, 
                FirstName = lstCon[0].FirstName, 
                SchoolOfInterest__c = lstSchool[0].Id,
                Child_DateOfBirth__c = lstCon[0].BirthDate,
                Child_DayOrBoardingSchool__c = AP_Constant.ledBoardingDay,
                Child_ExpectedStartDate__c = Date.newInstance(2010, 2, 2),
                Child_FirstName__c = lstCon[0].FirstName,
                Child_LastName__c = lstCon[0].LastName,
                Child_Gender__c = lstCon[0].Gender__c,
                TECH_ContactId__c = lstCon[0].Id,
                RecordTypeId = mapRecordTypeToId.get(AP_Constant.ledRecordTypeIndividualChildEnrolmentLead),
                Status = AP_Constant.ledStatusQualified
            ),
            new Lead(
                Company = lstAcc[0].Name, 
                LastName = lstCon[1].LastName, 
                FirstName = lstCon[1].FirstName, 
                SchoolOfInterest__c = lstSchool[0].Id,
                Child_DateOfBirth__c = lstCon[1].BirthDate,
                Child_DayOrBoardingSchool__c = AP_Constant.ledBoardingDay,
                Child_ExpectedStartDate__c = Date.newInstance(2010, 2, 2),
                Child_FirstName__c = lstCon[1].FirstName,
                Child_LastName__c = lstCon[1].LastName,
                Child_Gender__c = lstCon[1].Gender__c,
                TECH_ContactId__c = lstCon[1].Id,
                RecordTypeId = mapRecordTypeToId.get(AP_Constant.ledRecordTypeIndividualChildEnrolmentLead),
                Status = AP_Constant.ledStatusQualified
            )
        };
        insert lstLed;

        lstConvertRequest = new List<AP30_FlowLeadConversionTransposition.LeadConvertRequest>();
        convertRequest = new AP30_FlowLeadConversionTransposition.LeadConvertRequest();
    }

    @isTest
    public static void testLeadConvert(){
       
        convertRequest.lstLead = lstLed;
        convertRequest.convertedStatus = AP_Constant.ledStatusQualified;
        convertRequest.accountId = lstAcc[0].Id;
        convertRequest.createOpportunity = true;

        lstConvertRequest.add(convertRequest);

        Test.StartTest();
            AP30_FlowLeadConversionTransposition.convertLeads(lstConvertRequest);
        Test.StopTest();

        List<Opportunity> lstOpp = [select id, name, contactId from Opportunity where contactId != null AND accountID = :lstAcc[0].Id];
        String strLstOpp = JSON.serialize(lstOpp);
        
        System.assertEquals(2, lstOpp.size());
        System.assert(strLstOpp.contains('"ContactId":"' + lstCon[0].Id + '"'));
    }
}