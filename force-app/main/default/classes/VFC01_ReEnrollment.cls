global without sharing class VFC01_ReEnrollment{
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Controller class for VFP01_ReEnrollment
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 08-JAN-2018  SBH   1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/

    @RemoteAction
    public static void submitReEnrollment(Opportunity opp){ //controller method to save opportunity to database from survey
        update opp;
    }
}