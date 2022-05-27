/**
 * @File Name          : LWC01_DashboardListController_TEST.cls
 * @Description        : Test class for LWC01_DashboardListController.cls
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : FKH
 * @Last Modified On   : 23-FEB-2022, 10:00 am
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    23-FEB-2022, 10:00 am         FKH         Initial Version
**/
@isTest
public with sharing class LWC01_DashboardListController_TEST {
    
    @isTest (SeeAllData=true) //see all data true since cannot insert dashboard in test class
    public static void testDisplayDashboards(){
        LWC01_DashboardListController lwc = new LWC01_DashboardListController();
        Test.StartTest();
            LWC01_DashboardListController.getAllDashboards();
        Test.StopTest();
    }

}