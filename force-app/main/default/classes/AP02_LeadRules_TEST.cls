@isTest
public class AP02_LeadRules_TEST {
    /**************************************************************************************
    -- - Author        : Spoon Consulting
    -- - Description   : Test class for AP02_LeadRules
    --
    -- Maintenance History: 
    --
    -- Date         Name  Version  Remarks 
    -- -----------  ----  -------  -------------------------------------------------------
    -- 25-JAN-2018  RRAJ    1.0     Initial version
    -- 17-JUL-2018  WCH     1.1     Corrections to adjust modifications done+increase code coverage
    --------------------------------------------------------------------------------------
    **************************************************************************************/
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User testUserAdmin;
    static User testUser2;
    static List<Lead> lstLed = new List<Lead>();
    static School__c testSchl = new School__c();
    static School__c testSchl2 = new School__c();

    static{
        //creating user
        testUserAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert testUserAdmin;

        //create second user to test change owner
        //creating school for second user
        testSchl2 = TestFactory.createSchool('testSchool2', 'Port Louis', true, 'XXX');
        testSchl2.SchoolCode__c = 'LOL';
        insert testSchl2;

        testUser2 = TestFactory.createUser('testUser2',TestFactory.getProfileAdminId());
        testUser2.SchoolCode__c= testSchl2.SchoolCode__c;
        insert testUser2;

        System.runAs(testUserAdmin){

            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject});

            //creating school
            testSchl = TestFactory.createSchool('testSchool', 'Port Louis', true, 'XXX');
            testSchl.SchoolCode__c = 'tst';
            testSchl.AdmissionsQueueCoordinator__c=testUserAdmin.Id;
            insert testSchl;

            //creating leads
            lstLed.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), 'test1', 'AP02', '', '', AP_Constant.ledGenderMale, Date.newInstance(2002, 1,5)));
            lstLed[0].DateOfBirthFirstChild__c = Date.newInstance(2002, 10, 23);
            lstLed[0].DateOfBirthSecondChild__c = Date.newInstance(2010, 12, 5);
            lstLed[0].DateOfBirthThirdChild__c = Date.newInstance(2014, 5, 28);
            lstLed[0].DateOfBirthFourthChild__c = Date.newInstance(2013, 7, 17);
            lstLed[0].DateOfBirthFifthChild__c = Date.newInstance(2005, 8, 30);
            lstLed[0].ExpectedStartYear__c = '2019';
            lstLed[0].ExpectedStartMonth__c='November';
            lstLed[0].LeadSource='Offline';
            lstLed[0].Parent1Street__c = 'bugs bunny street';
            lstLed[0].Parent1City__c = 'looney toons';
            lstLed[0].Parent1State__c = 'kansas';
            lstLed[0].Parent1ZipPostalCode__c = '1234';
            lstLed[0].Parent1ZipPostalCode__c = '1234';
            lstLed[0].Parent1NatureOfRelationship__c = 'Agent';
            lstLed[0].Number_of_Children__c = '2';
            lstLed[0].SchoolOfInterest__c = testSchl.Id;
            lstLed[0].Company = 'testComp';
            lstLed[0].isExternalSource__c=true;
            

            lstLed.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), 'test2', 'AP02', '', '', AP_Constant.ledGenderFemale, Date.newInstance(2009, 10,15)));
            lstLed[1].DateOfBirthFirstChild__c = Date.newInstance(2009, 9, 1);
            lstLed[1].DateOfBirthSecondChild__c = Date.newInstance(2013, 11, 8);
            lstLed[1].DateOfBirthThirdChild__c = Date.newInstance(2012, 10, 29);
            lstLed[1].DateOfBirthFourthChild__c = Date.newInstance(2010, 2, 16);
            lstLed[1].DateOfBirthFifthChild__c = Date.newInstance(2011, 4, 20);
            lstLed[1].ExpectedStartYear__c = '2019';
            lstLed[1].ExpectedStartMonth__c='November';
            lstLed[1].LeadSource='Offline';
            lstLed[1].SchoolOfInterest__c = testSchl.Id;
            //lstLed[1].DateOfBirthSixthChild__c = Date.newInstance(2013, 3, 30);
            lstLed[1].Number_of_Children__c = '5';
            lstLed[1].isExternalSource__c=true;
            lstLed[1].Lead_Origin__c= AP_Constant.ledOriginAdmissionsStage1;
            lstLed[1].School_Code__c = testSchl.SchoolCode__c;
            lstLed[1].Company = 'testComp';
            lstLed[1].Parent1NatureOfRelationship__c = 'Agent';

            lstLed.add(TestFactory.createLead(mapRecordType.get(AP_Constant.ledRecordTypeClient), 'test3', 'AP02', '', '', AP_Constant.ledGenderFemale, Date.newInstance(2009, 10,15)));
            lstLed[2].DateOfBirthFirstChild__c = Date.newInstance(2009, 9, 1);
            lstLed[2].DateOfBirthSecondChild__c = Date.newInstance(2013, 11, 8);
            lstLed[2].DateOfBirthThirdChild__c = Date.newInstance(2012, 10, 29);
            lstLed[2].DateOfBirthFourthChild__c = Date.newInstance(2010, 2, 16);
            lstLed[2].DateOfBirthFifthChild__c = Date.newInstance(2011, 4, 20);
            lstLed[2].ExpectedStartYear__c = '2019';
            lstLed[2].ExpectedStartMonth__c='November';
            lstLed[2].LeadSource='Offline';
            lstLed[2].SchoolOfInterest__c = testSchl.Id;
            //lstLed[1].DateOfBirthSixthChild__c = Date.newInstance(2013, 3, 30);
            lstLed[2].Number_of_Children__c = '2';
            lstLed[2].Interested_in_boarding_school__c = true;
            lstLed[2].isExternalSource__c=true;
            lstLed[2].Lead_Origin__c= AP_Constant.ledOriginApplication;
            lstLed[2].School_Code__c = testSchl.SchoolCode__c;
            lstLed[2].Company = 'testComp';
            lstLed[2].Parent1NatureOfRelationship__c = 'Agent';
            

        }
    }

    @isTest
    static void testFieldPopulation(){
        System.runAs(testUserAdmin){
            Test.startTest();
            insert lstled;
            Test.stopTest();

            List<Lead> lstInsertedLead = [SELECT DateOfBirthFirstChild__c, DateOfBirthSecondChild__c, DateOfBirthThirdChild__c, DateOfBirthFourthChild__c, DateOfBirthFifthChild__c FROM Lead WHERE Name = 'AP02' ORDER BY LastName ASC];
            for(Lead led : lstInsertedLead){

                System.assertEquals(led.FirstNameFirstChild__c, led.Parent1FirstName__c + '1');
                System.assertEquals(led.LastNameFirstChild__c, 'Parent-' + led.Parent1LastName__c);
                System.assertEquals(led.FirstNameSecondChild__c, led.Parent1FirstName__c + '2');
                System.assertEquals(led.LastNameSecondChild__c, 'Parent-' + led.Parent1LastName__c);
                System.assertEquals(led.FirstNameThirdChild__c, led.Parent1FirstName__c + '3');
                System.assertEquals(led.LastNameThirdChild__c, 'Parent-' + led.Parent1LastName__c);
                System.assertEquals(led.FirstNameFourthChild__c, led.Parent1FirstName__c + '4');
                System.assertEquals(led.LastNameFourthChild__c, 'Parent-' + led.Parent1LastName__c);
                System.assertEquals(led.FirstNameFifthChild__c, led.Parent1FirstName__c + '5');
                System.assertEquals(led.LastNameFifthChild__c, 'Parent-' + led.Parent1LastName__c);
            }
        }
    }
    @isTest
    static void testUpdateSchool(){
        System.runAs(testUserAdmin){
            insert lstled;
            Test.startTest();

                List<Lead> lstInsertedLead = [SELECT Id, Ownerid FROM Lead WHERE FirstName = 'AP02'];
                lstInsertedLead[0].Ownerid = testUser2.Id;
                lstInsertedLead[1].Ownerid = testUser2.Id;
                System.assertEquals(3, lstInsertedLead.size());

                update lstInsertedLead;

                List<Lead> lstUpdatedLead = [SELECT SchoolOfInterest__c FROM Lead WHERE FirstName = 'AP02'];
                System.assertEquals(testSchl2.Id, lstUpdatedLead[0].SchoolOfInterest__c);
                System.assertEquals(testSchl2.Id, lstUpdatedLead[1].SchoolOfInterest__c);

            Test.stopTest();

        }
    }

    @isTest
    static void testUpdatePickListOrigin(){
        System.runAs(testUserAdmin){
            insert lstled;
            Test.startTest();

                List<Lead> lstInsertedLead = [SELECT Id, Ownerid, Lead_Origin__c FROM Lead WHERE FirstName = 'AP02'];
                lstInsertedLead[0].Lead_Origin__c = 'WeChat';
                update lstInsertedLead;

                //List<Lead> lstUpdatedLead = [SELECT Lead_Origin__c, LeadOrigins__c FROM Lead WHERE FirstName = 'AP02'];
                List<Lead> lstUpdatedLead = [SELECT Lead_Origin__c FROM Lead WHERE FirstName = 'AP02'];

                System.assertEquals(lstInsertedLead[0].Lead_Origin__c, lstUpdatedLead[0].Lead_Origin__c);
                //System.assertEquals(lstUpdatedLead[0].LeadOrigins__c, 'WeChat');

            Test.stopTest();

        }
    }

    @isTest
    static void testUpdateFields(){
        System.runAs(testUserAdmin){
            Test.startTest();
            insert lstled;
            AP02_LeadRules.updateFields(lstled);
            Test.stopTest();            
            }
        }


        @isTest
        static void testPopulateFields(){
            System.runAs(testUserAdmin){
                Test.startTest();
                insert lstled;
                AP02_LeadRules.populateFields(lstled);
                Test.stopTest();            
                }
            }
}