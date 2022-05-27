/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for VF10_EmailTemplateController_TEST to generate
                     an application form
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 17-DEC-2021  FKH   1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/
@isTest
public class VF10_EmailTemplateController_TEST {
	static Map< string,Id > mapLedRecordType = new Map< String, Id >();
    static User usrTestAdmin;
    static List< School__c > lstSchool = new List< School__c >();
    static List<Lead> lstLead;
    static List<User> lstUser;
    static Map<String,Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject}); 

    static{

        lstUser = new List<User>{
            TestFactory.createUser('Test', TestFactory.getProfileAdminId())
            ,TestFactory.createUser('Test1', TestFactory.getProfileAdminId())
        };
        insert lstUser;
        
        System.runAs(lstUser[0]){

            lstSchool = new List<School__c>{
                TestFactory.createSchool('TestUser1', 'Mauritius', false, 'CBS')
            };

            lstSchool[0].SummerApplicationEmailBody__c='test';
            lstSchool[0].SummerApplicationEmailBodyBilingual__c='test';
            lstSchool[0].SummerEnquiryEmailBodyBilingual__c='test';
            lstSchool[0].SummerEnquiryEmailBody__c='test';
            lstSchool[0].facebook__c='fb.com';
            insert lstSchool;

            lstLead = new List<Lead>{
                TestFactory.createLead( null, 'Test', 'Tester', 'childfname', 'childlname', 'Male', Date.newInstance(2010, 2, 2)),
                TestFactory.createLead( null, 'Teest', 'eTester', 'cheildfname', 'cheildlname', 'Male', Date.newInstance(2010, 2, 2))
            };      
            
            lstLead[0].FirstName ='lread0r3';
            lstLead[0].LastName ='leard0r3';
            lstLead[0].Parent1FirstName__c = 'leradr03';
            lstLead[0].Parent1LastName__c = 'leard0r3';
            lstLead[0].Parent1Nationality__c='Australian';
            lstLead[0].Parent1NatureOfRelationship__c = AP_Constant.ledNatureOfRelationshipMother;
            lstLead[0].Parent1HomePhone__c = 'lead03';
            lstLead[0].Parent1PrimaryEmail__c = 'fatimah.khodadin@sc-mauritius.com';
            lstLead[0].Parent1CountryOfResidence__c ='France';
            lstLead[0].recordtypeid = mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts);

            lstLead[0].Parent2FirstName__c = 'lefard0s3';
            lstLead[0].Parent2LastName__c = 'legadr03s';
            lstLead[0].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[0].Parent2HomePhone__c = '+85g2 lead03e-9999';
            lstLead[0].Parent2CountryOfResidence__c = 'France';
            lstLead[0].Parent2PrimaryEmail__c = 'fatimah.khodadin@sc-mauritius.com';
            lstLead[0].Parent2Nationality__c = 'French';

            lstLead[0].Number_of_Children__c = '2';

            lstLead[0].FirstNameFirstChild__c ='lgeadv031';
            lstLead[0].LastNameFirstChild__c ='legard031';
            lstLead[0].GenderFirstChild__c ='Male';
            lstLead[0].DateOfBirthFirstChild__c = Date.newInstance(2010, 2, 2);
            lstLead[0].MarketingQualifiedFirstChild__c = true;
            lstLead[0].EnrollmentDateFirstChild__c = Date.newInstance(2019, 2, 2);        
            lstLead[0].DayOrBoardingSchoolFirstChild__c = 'Day'; 

            lstLead[0].FirstNameSecondChild__c ='letavd0312';
            lstLead[0].LastNameSecondChild__c ='ltead0v312';
            lstLead[0].GenderSecondChild__c ='Male';
            lstLead[0].DateOfBirthSecondChild__c = Date.newInstance(2012, 2, 2);
            lstLead[0].MarketingQualifiedSecondChild__c = true;
            lstLead[0].EnrollmentDateSecondChild__c = Date.newInstance(2012, 2, 2);        
            lstLead[0].DayOrBoardingSchoolSecondChild__c = 'Day'; 
            lstLead[0].email = 'fatimah.khodadin@sc-mauritius.com';

            lstLead[0].Company = 'John9 Company';
            lstLead[0].Status = 'new';
            lstLead[0].School_Code__c = 'CBS';
            lstLead[0].lead_origin__c = 'Baidu PPC H5';
            lstLead[0].Send_Acknowledgement__c = true;

            
            lstLead[1].FirstName ='lread0r3';
            lstLead[1].LastName ='leard0r3';
            lstLead[1].Parent1FirstName__c = 'leradr03';
            lstLead[1].Parent1LastName__c = 'leard0r3';
            lstLead[1].Parent1Nationality__c='Australian';
            lstLead[1].Parent1NatureOfRelationship__c = AP_Constant.ledNatureOfRelationshipMother;
            lstLead[1].Parent1HomePhone__c = 'lead03';
            lstLead[1].Parent1PrimaryEmail__c = 'fatimah.khodadin@sc-mauritius.com';
            lstLead[1].Parent1CountryOfResidence__c ='France';
            lstLead[1].recordtypeid =mapRecordType.get(AP_Constant.ledRecordTypeJulliardSummerArts);

            lstLead[1].Parent2FirstName__c = 'lefard0s3';
            lstLead[1].Parent2LastName__c = 'legadr03s';
            lstLead[1].Parent2NatureOfRelationship__c= AP_Constant.ledNatureOfRelationshipFather;
            lstLead[1].Parent2HomePhone__c = '+85g2 lead03e-9999';
            lstLead[1].Parent2CountryOfResidence__c = 'France';
            lstLead[1].Parent2PrimaryEmail__c = 'fatimah.khodadin@sc-mauritius.com';
            lstLead[1].Parent2Nationality__c = 'French';

            lstLead[1].Number_of_Children__c = '2';

            lstLead[1].FirstNameFirstChild__c ='lgeadv031';
            lstLead[1].LastNameFirstChild__c ='legard031';
            lstLead[1].GenderFirstChild__c ='Male';
            lstLead[1].DateOfBirthFirstChild__c = Date.newInstance(2010, 2, 2);
            lstLead[1].MarketingQualifiedFirstChild__c = true;
            lstLead[1].EnrollmentDateFirstChild__c = Date.newInstance(2019, 2, 2);        
            lstLead[1].DayOrBoardingSchoolFirstChild__c = 'Day'; 

            lstLead[1].FirstNameSecondChild__c ='letavd0312';
            lstLead[1].LastNameSecondChild__c ='ltead0v312';
            lstLead[1].GenderSecondChild__c ='Male';
            lstLead[1].DateOfBirthSecondChild__c = Date.newInstance(2012, 2, 2);
            lstLead[1].MarketingQualifiedSecondChild__c = true;
            lstLead[1].EnrollmentDateSecondChild__c = Date.newInstance(2012, 2, 2);        
            lstLead[1].DayOrBoardingSchoolSecondChild__c = 'Day'; 
            lstLead[1].email = 'fatimah.khodadin@sc-mauritius.com';
            lstLead[1].School_Code__c = '123';

            lstLead[1].Company = 'John9 Company';
            lstLead[1].Status = 'new';
            lstLead[1].lead_origin__c = 'Baidu PPC H5';
            lstLead[1].Send_Acknowledgement__c = true;
        }
    }

    @isTest public static void callFunctions(){
        System.runAs(lstUser[0]) {
			VF10_EmailTemplateController vfEmail = new VF10_EmailTemplateController();
            vfEmail.getEnhancedEmailBody();
            vfEmail.getLogoName();
            vfEmail.getListSchoolSocialMedia();
            vfEmail.getImageUrl();
			VF10_EmailTemplateController.SocialMediaWrapper socialwrapper = new VF10_EmailTemplateController.SocialMediaWrapper('d','d','d');
            socialwrapper.getDocumentName();
            socialwrapper.getSocialMediaURL();
        }
    }
    
    @isTest public static void insertLead(){
        System.runAs(lstUser[0]) {
            test.StartTest();
                insert lstLead;
            test.StopTest();
        }
    }
}