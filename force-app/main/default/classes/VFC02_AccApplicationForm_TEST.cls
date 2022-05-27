/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for VFC02_AccApplicationForm_TEST
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 20-FEB-2019  CRA    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
@isTest
private class VFC02_AccApplicationForm_TEST {

    Static Opportunity opp;

    @testSetup static void setup(){
        Id idSysAdmin= TestFactory.getProfileAdminId();

        User usr = TestFactory.createUser(TestFactory.randomizeString('test_lname'),idSysAdmin);

        insert usr;
        
        Map<string,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject});

        //creating school
        School__c testSchl = TestFactory.createSchool('testSchool', 'Port Louis', true, 'XXX');
        testSchl.SchoolCode__c = 'tst';
        insert testSchl;

        //creating leads
        List<Lead> leadList= new List<Lead>();
        leadList.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), 'test1', 'AP02', 'child1FN', 'child1LN', AP_Constant.ledGenderMale, Date.newInstance(2002, 1,5)));

        //leadList[0].Parent1PrimaryEmail__c = 'user@test.com';
        leadList[0].Parent1CountryOfResidence__c = 'France';

        leadList[0].Parent2FirstName__c = 'firstName';
        leadList[0].Parent2LastName__c = 'lastName';
        leadList[0].Parent2PrimaryEmail__c = 'user@test.com';
        leadList[0].Parent2HomePhone__c = '+852 9999-9999';
        leadList[0].Parent2CountryOfResidence__c = 'France';
        leadList[0].Parent2Nationality__c = 'Afghani';
        leadList[0].Parent2NatureOfRelationship__c = AP_Constant.ledNatureOfRelationshipFather;
        leadList[0].MarketingQualifiedFirstChild__c = true;
        leadList[0].EnrollmentDateFirstChild__c = Date.newInstance(2019, 2, 2);
        leadList[0].PreferredNameFirstChild__c = 'tom';
        leadList[0].DateOfBirthFirstChild__c = Date.newInstance(2002, 10, 23);
        
        leadList[0].Number_of_Children__c = '1';
        leadList[0].Lead_Origin__c = AP_Constant.ledOriginAdmissionsStage1;
        leadList[0].LeadSource='Offline';

        //leadList[0].DateOfBirthSecondChild__c = Date.newInstance(2010, 12, 5);
        //leadList[0].DateOfBirthThirdChild__c = Date.newInstance(2014, 5, 28);
        //leadList[0].DateOfBirthFourthChild__c = Date.newInstance(2013, 7, 17);
        //leadList[0].DateOfBirthFifthChild__c = Date.newInstance(2005, 8, 30);
        
        leadList[0].SchoolOfInterest__c = testSchl.Id;
        leadList[0].Company = 'testComp';
        leadList[0].isExternalSource__c=true;
        leadList[0].Status = AP_Constant.ledStatusQualified;

        insert leadList;

        //creating leads
        List<Account> AccountList= new List<Account>();
        for(Lead theLead : leadList){
          AccountList.add(new Account(Id=LC05_ConvertLead.convertLead(theLead.Id)));
        }

        List<Opportunity> oppList = new List<Opportunity>{TestFactory.createOpportunity('test_opp',AccountList[0].id,'Qualification',Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(AP_Constant.oppRecordTypeDeveloperNameEnrolment).getRecordTypeId(), null)
        };

        List<Contact> ContactList=new List<Contact>();
        for(Contact theContact :[select id,recordtype.name,name,AccountId,NatureOfRelationship__c from contact order by AccountId desc limit 10]){
            if(theContact.recordtype.name.equals(AP_Constant.conRecordTypeDeveloperNameParent) && theContact.NatureOfRelationship__c.equals('Father')){
                theContact.isPrimaryContact__c=true;
                theContact.isFinancialContact__c=true;
                ContactList.add(theContact);
            }
            if(theContact.AccountId.equals(AccountList[0].id) && theContact.recordtype.name.equals(AP_Constant.conRecordTypeDeveloperNameChild)){
                oppList[0].Child__c=theContact.Id;
            }
        }
        update ContactList;

        insert oppList;

    }


    @isTest static void generateApplicationForm() {
        PageReference pageRef = Page.VFP02_AccApplicationForm;
        Test.setCurrentPage(pageRef);

        Opportunity currentOpp=[select id from Opportunity order by createddate desc limit 1];
        List<Account> acclist=[select id,name,recordtype.name from Account order by createddate desc limit 2];
        List<Contact> ContactList=[select id,recordtype.name,name,AccountId,NatureOfRelationship__c from contact order by createddate desc limit 10];
        system.debug('currentOpp>>'+currentOpp);
        system.debug('acclist>>'+acclist);
        system.debug('contactList>>'+ContactList);
        ApexPages.StandardController accController = new ApexPages.StandardController(acclist[0]);
        VFC02_AccApplicationForm controller = new VFC02_AccApplicationForm(accController);

        //controller.theOpp= oppList[0];

    }

}