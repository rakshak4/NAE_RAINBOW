/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Test class for VF10_EmailTemplateController to generate
                     an application form
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 17-DEC-2021  FKH   1.0     Initial Version
--------------------------------------------------------------------------------------
**************************************************************************************/
global class VF10_EmailTemplateController {

    public String ctrlEmailBody {get;set;}
    public String schoolRecordId {get;set;}
    // public String schoolSchoolCode {get;set;}
    // public Boolean isSummer {get;set;}
    public String schoolNAECode {get;set;}
    public String fileName {get;set;}
    public String customImageWidth {get;set;}
    public String customImageAlignment {get;set;}
    public String customImagePadding {get;set;}
    // public String website {get;set;}

    public VF10_EmailTemplateController(){
        ctrlEmailBody = 'test';
        schoolNAECode = 'CBS';
        schoolRecordId ='a010O000029E9XBQA0';
        fileName = 'instagram_CBS';
        customImageWidth = '10';
        customImageAlignment = '10';
        customImagePadding = '10';
    }
    
    public String getEnhancedEmailBody(){
        String strEnhancedEmail = ' ';
        if(ctrlEmailBody != null){
            strEnhancedEmail = ctrlEmailBody.replaceAll('<p>', '<p style="margin:0;color:black !important;font-family: HelveticaNeue-Light;font-size: 12">');
        }
        return strEnhancedEmail;
    }

    public String getLogoName(){
        // if(!isSummer){ // uncomment when developing for non-summer camps schools - vyas dev
        //     return  schoolNAECode+ '_Logo';
        // }   
        return schoolNAECode + '_Logo_SC';
    }

    public List<SocialMediaWrapper> getListSchoolSocialMedia() {
        List<SocialMediaWrapper> lstSchoolSocialMedia = new List<SocialMediaWrapper>();

            List<String> lstSocialMediaFieldApiName = new List<String> {'instagram__c','facebook__c', 'youtube__c','Tiktok__c','linkedin__c', 'Twitter__c','SinaWeibo__c', 'Vimeo__c', 'WeChat__c', 'Youku__c'}; 
            List<School__c> lstSchool = new List<School__c>();
            
            String strQuery = 'select id, website__c,schoolcode__c, ' + String.join(lstSocialMediaFieldApiName, ', ') + ' FROM School__c where Id = \'' + schoolRecordId + '\'';
            lstSchool = Database.query(strQuery);

            // try{
            //     lstSchool = Database.query(strQuery);
            // }catch(Exception e){
            //     lstSchool = new List<School__c>();
            // }

            System.debug('####lstSchool: ' + lstSchool);

            if(!lstSchool.isEmpty()){
                for(String socialMediaFieldApiName : lstSocialMediaFieldApiName){
                    String socialMediaName = socialMediaFieldApiName.replace('__c', '');
                    String socialMediaDocumentName = socialMediaName.toLowerCase() + '_'+lstSchool[0].schoolcode__c;

                    if(lstSchool[0].get(socialMediaFieldApiName) != null){
                        lstSchoolSocialMedia.add(new SocialMediaWrapper(socialMediaDocumentName, String.valueOf(lstSchool[0].get(socialMediaFieldApiName)), socialMediaName));
                    } 
                }

                //website = lstSchool[0].website__c != null ? lstSchool[0].website__c: 'nordangliaeducation.com';
            }
            
         return lstSchoolSocialMedia;
    }

    public String getImageUrl() {
        List<Document> lstDocument = [SELECT LastModifiedDate FROM Document WHERE DeveloperName = :fileName];
        System.debug('###lstDocument: ' + JSON.serialize(lstDocument));
        if(lstDocument.isEmpty()) {
            return null;
        } else {
            return Url.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+lstDocument[0].Id+'&oid='+UserInfo.getOrganizationId()+'&lastMod='+lstDocument[0].LastModifiedDate.getTime();
        }
    }

    global class SocialMediaWrapper {
        public String documentName;
        public String socialMediaURL;
        public String socialMediaAlt;

        public SocialMediaWrapper(String documentName, String socialMediaURL, String socialMediaAlt){
            this.documentName = documentName;
            this.socialMediaURL = socialMediaURL;
            this.socialMediaAlt = socialMediaAlt;
        }

        public String getDocumentName (){
            return this.documentName;
        }

        public String getSocialMediaURL (){
            return this.socialMediaURL;
        }
    }
    
}