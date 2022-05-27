/**
 * @File Name          : LWC01_DashboardListController.cls
 * @Description        : Apex to fetch dashboards to be displayed in home page component
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
public with sharing class LWC01_DashboardListController {
    private static List<String> parentRoleNames = new List<String>();

    @AuraEnabled(cacheable=true)
    public static List<DataTableWrapper> getAllDashboards() {
        List<DataTableWrapper> response = new List<DataTableWrapper>();
        List <String> lstDashboardNamesCM = new List<String>();
        Set<String> lstAccessibleDash = new Set<String>();

        Id userRoleId = userinfo.getUserRoleId();
        String userRoleName = [SELECT Id, UserRole.Name FROM User where Id=:userinfo.getUserId()].UserRole.Name;
        List<CM_RoleDashboard__mdt> lstMetaData = CM_RoleDashboard__mdt.getAll().values();
        Set<Id> allParentRoleNames = getParentRoleId(new Set<ID>{userRoleId});

        for(CM_RoleDashboard__mdt md: lstMetaData){
            if((md.IncludeSubordinates__c && parentRoleNames.contains(md.RoleName__c)) || md.RoleName__c==userRoleName){
                lstAccessibleDash.add(md.DashboardName__c);
            }    
        }

        List<Dashboard> lstDash = [SELECT Id,title FROM Dashboard where title in: lstAccessibleDash order by title]; //query dasboards soql titles

        for(Dashboard dashBd : lstDash){
            DataTableWrapper objWrap = new DataTableWrapper();
            objWrap.dashboardNameUrl = '/'+dashBd.Id;
            objWrap.dashboardName = dashBd.title;
            response.add(objWrap);
        }
        
        return response;
    }
   
    // To get all Parent Roles.
    public static Set<ID> getParentRoleId(Set<ID> roleIds) {
        Set<ID> currentRoleIds = new Set<ID>();

        for(UserRole ur :[select Id, Name, ParentRoleId from UserRole where Id IN: roleIds]) {
            currentRoleIds.add(ur.ParentRoleId);
            parentRoleNames.add(ur.Name);
        }

        if(currentRoleIds.size() > 0) {
            currentRoleIds.addAll(getParentRoleId(currentRoleIds));
        }
    
        return currentRoleIds;
    }
    
    public class DataTableWrapper {
        @AuraEnabled
        public String dashboardName {get;set;}
        @AuraEnabled
        public String dashboardNameUrl {get;set;}
    } 
}