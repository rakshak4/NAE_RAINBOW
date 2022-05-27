@isTest
private class VFC01_ReEnrollment_TEST {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test Apex class for Controller of VFP01_ReEnrollment
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 17-JUL-2018  CRA    1.0     Initial version
--------------------------------------------------------------------------------------
***************************************************************************************/
    static Map<string,Id> mapRecordType = new Map<String, Id>();
    static User usrTestAdmin;
    static Opportunity opp;
    static Account acc;
    static {
        //creating user
        usrTestAdmin = TestFactory.createUser('testUserAdmin',TestFactory.getProfileAdminId());
        insert usrTestAdmin;

        System.runAs(usrTestAdmin){
            mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.oppObject});
            //creating account
            acc = TestFactory.createAccount('Henry Family');
            insert acc;

            //creating opportunity
            opp = TestFactory.createOpportunity('Junior Henry - Enrolment', acc.Id, AP_Constant.oppStageNameEnquiry,
                                                mapRecordType.get(AP_Constant.oppRecordTypeEnrolment), null);
            insert opp;
        }
    }
    @isTest
    static void submitReEnrollmentTest() {
        System.runAs(usrTestAdmin) {
            opp.StageName = AP_Constant.oppStageNameReenrolment;
            Test.startTest();
            VFC01_ReEnrollment.submitReEnrollment(opp);
            Test.stopTest();
        }

        Opportunity oppResult = [SELECT StageName FROM Opportunity WHERE Id =: opp.Id LIMIT 1 ][0];
        System.assertEquals(AP_Constant.oppStageNameReenrolment, oppResult.StageName);
    }
}