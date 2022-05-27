@RestResource(urlMapping='/WeChat/*')
global with sharing class WS01_InsertWeChatLead{
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Exposed webservice to created Leads and campaigns from WeChat
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 27-APR-2018  RRAJ   1.0     Initial Version
-- 13-DEC-2018   ANA   1.0     W-489
-- 28-JUL-2020   CRA   1.2     Implement Case00002530 - Update Upsert key to use Parent1 Phone Number
-- 26-AUG-2020   CRA   1.3     Set Lead Status to New if the existing one is Unqualified
--------------------------------------------------------------------------------------
**************************************************************************************/

    /**
     * Post method to insert/update leads on salesforce
     * Webservice method used for inputting leads into Salesforce from WeChat
     * @param  leads List of leads to be inserted
     * @return       Response of Http request
     */
    @HttpPost
    global static List<Map<String, String>> updateCreateLead(List<Lead> leads){
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.AssignmentRuleHeader.useDefaultRule = true;
        System.debug('##leads ' +leads);
        
		Set<String> setCampaignName     = new Set<String>();
        Set<String> setExternalId       = new Set<String>();
        Set<String> setExtIdUnqualified = new Set<String>(); //set of external Id of Unqualified Lead
        List<String> lstLedSchlCode     = new List<String>();
        Map<String, Id> mapSchlCodeToSchlId = new Map<String, Id>();   //map of school code to school id
        for(Lead led : leads){
            led.setOptions(dmo);
            lstLedSchlCode.add(led.School_Code__c);
            led.WeChatExternalID__c = led.School_Code__c + led.Parent1MobilePhone__c; //CRA20200728 - Case2530
            setExternalId.add(led.WeChatExternalID__c);
        }

        for(School__c schl : [SELECT Id, SchoolCode__c FROM School__c WHERE SchoolCode__c IN :lstLedSchlCode AND SchoolCode__c != null]){
            mapSchlCodeToSchlId.put(schl.SchoolCode__c, schl.Id);
        }

        for(Lead existingled : [SELECT Id, Status, WeChatExternalID__c FROM Lead WHERE WeChatExternalID__c IN :setExternalId AND isConverted = false AND Status = :AP_Constant.ledStatusUnqualified]){
            setExtIdUnqualified.add(existingled.WeChatExternalID__c);
        }

        for(Lead led : leads){
            if(mapSchlCodeToSchlId.containsKey(led.School_Code__c)){
                led.SchoolOfInterest__c = mapSchlCodeToSchlId.get(led.School_Code__c);
            }

            led.isExternalSource__c               = true;
            led.LeadMethod__c                     = AP_Constant.ledMethodEvent;
            led.MarketingQualifiedFirstChild__c   = led.LastNameFirstChild__c != null ? true : led.MarketingQualifiedFirstChild__c;
            led.MarketingQualifiedSecondChild__c  = led.LastNameSecondChild__c != null ? true : led.MarketingQualifiedSecondChild__c;
            led.MarketingQualifiedThirdChild__c   = led.LastNameThirdChild__c != null ? true : led.MarketingQualifiedThirdChild__c;
            led.MarketingQualifiedFourthChild__c  = led.LastNameFourthChild__c != null ? true : led.MarketingQualifiedFourthChild__c;
            led.MarketingQualifiedFifthChild__c   = led.LastNameFifthChild__c != null ? true : led.MarketingQualifiedFifthChild__c;         
            led.Nationality__c                    = led.Nationality__c == null ? AP_Constant.ledNationalityChinese : led.Nationality__c;
            led.LeadMethod__c                     = led.LeadMethod__c == null ? AP_Constant.ledMethodWeb : led.LeadMethod__c;
            led.Number_of_children__c             = led.Number_of_children__c == null ? AP_Constant.ledNumChildOne : led.Number_of_children__c;
            led.LeadSource                        = led.LeadSource == null ? AP_Constant.ledSrcOnline : led.LeadSource;
            led.LeadSubSource__c                  = led.LeadSubSource__c == null ? AP_Constant.ledMethodSocialMedia : led.LeadSubSource__c;
            led.Country_of_residence__c           = led.Country_of_residence__c == null ? AP_Constant.ledCountryChina : led.Country_of_residence__c;
            if(setExtIdUnqualified.contains(led.WeChatExternalID__c)) { //CRA20200826 - Set Lead Status to New if the existing one is Unqualified
                led.Status = AP_Constant.ledStatusNew;
            }                         
            if(led.WeChatCampaignName__c != null){
                setCampaignName.add(led.WeChatCampaignName__c);
            }
        }
        
        //Schema.SObjectField extId = Lead.Fields.WeChatUserId__c; //CRA20200728 - Case2530
        Schema.SObjectField extId = Lead.Fields.WeChatExternalID__c;
        System.debug('@@@extId: ' + extId);
        List<Database.UpsertResult> lstUpsertRes = Database.upsert(leads, extId, false);
        System.debug(lstUpsertRes);

        //Create Campaign members
        if(setCampaignName.size()>0){
            //List<Lead> lstLeads = [SELECT ID, ExternalId__c from Lead where ExternalId__c =: extId];
            createCampaignMembers(leads, setCampaignName);
        }

        List<Map<String, String>> lstResp = new List<Map<String, String>>();
        for(Database.UpsertResult upsertRes : lstUpsertRes){
            Map<String, String> resp = new Map<String, String>();
            //Response handling
            if(upsertRes.isSuccess()){
                resp.put('status', '200');
                resp.put('id', String.valueOf(upsertRes.getId()));
                System.debug(resp);

                if(upsertRes.isCreated()){
                    resp.put('success', Label.RecordCreateSuccessMessage);
                    system.debug('lead created');
                }else{
                    resp.put('success', Label.RecordUpdateSuccessMessage);
                   
                }
            }else{
                resp.put('status', '500');
                resp.put('error', upsertRes.getErrors()[0].getMessage());
                 system.debug(upsertRes.getErrors());
            }
            lstResp.add(resp);
        }

        //System.debug('#### lstResp: '+lstResp);
        return lstResp;
    }
	
    public static void createCampaignMembers(List<Lead> leads, set<String> setCampaignName){//ANA20181312: W-489
        System.debug('$$$$$ Enterred createCampaignMembers');
        List<CampaignMember> lstCampaignMembers = new List<CampaignMember>();
        Map<String, Id> mapLeadCampaign = new Map<String, Id>();	
        
        Set<String> setWeChatUserIds = new Set<String>();
        for(lead led : leads){
            //setWeChatUserIds.add(led.WeChatUserId__c); //CRA20200728 - Case2530
            setWeChatUserIds.add(led.WeChatExternalID__c);
        }
        
        //Selecting existing campaigns
        for(Campaign cmp : [SELECT Name, Id FROM Campaign WHERE Name IN :setCampaignName]){
            mapLeadCampaign.put(cmp.Name, cmp.Id);
        }
        
        if(mapLeadCampaign.size() > 0){ // create campaign members if there campaigns exist
            //for(Lead ldcmp : [select ID, WeChatUserId__c, WeChatCampaignName__c from Lead where WeChatUserId__c IN :setWeChatUserIds]){
            for(Lead ldcmp : [SELECT ID, WeChatExternalID__c, WeChatCampaignName__c FROM Lead WHERE WeChatExternalID__c IN :setWeChatUserIds]){
                if(ldcmp.WeChatCampaignName__c != null && mapLeadCampaign.containsKey(ldcmp.WeChatCampaignName__c)){
                    //System.debug('$$$$$ lstCampaignMembers:' + lstCampaignMembers);
                    lstCampaignMembers.add(new CampaignMember(CampaignId = mapLeadCampaign.get(ldcmp.WeChatCampaignName__c), LeadId = ldcmp.Id ));
                }
            }
            //System.debug('$$$$$ lstCampaignMembers2:' + lstCampaignMembers);
            //Database.upsert(lstCampaignMembers, false);
            List<Database.SaveResult> lstInsertRes = Database.insert(lstCampaignMembers, false);
            for(Database.SaveResult insertRes : lstInsertRes){
                Map<String, String> resp = new Map<String, String>();
                //Response handling
                if(insertRes.isSuccess()){
                    system.debug('success record created');
                
                }else{
                    system.debug(InsertRes.getErrors());
                }
            }
        }
    }

}