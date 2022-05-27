/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Controller class for VFP02_AccApplicationForm
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 19-FEB-2019  CRA   1.0     Initial Version[User Story: W-000344]
--------------------------------------------------------------------------------------
**************************************************************************************/

global with sharing class VFC02_AccApplicationForm {

	public Account theAcc {get;set;}
    public String renderedAs {get;set;}
    public Boolean isFormAvailable {get;set;}
    public String lang {get;set;}
    public String generationType {get;set;}

    public VFC02_AccApplicationForm(ApexPages.StandardController sc) {
        
        //fetch account details                                               
        theAcc = [SELECT    id
                            ,SchoolOfInterest__r.Name
                            ,SchoolOfInterest__r.SchoolCode__c
                            ,SchoolOfInterest__r.Bilingual__c
                            ,SchoolOfInterest__r.PDFFieldVisibility__c
                            ,NumberOfChildren__c
                            ,TECH_ApplicationFormLang__c
                            ,SchoolOfInterest__r.ActivateApplicationForm__c 
                            ,Name
               FROM Account
                  WHERE id = :((Account)sc.getRecord()).Id];
        
        isFormAvailable = false;
        lang='en-US';
        generationType = apexpages.currentpage().getparameters().get('gen');        
        System.debug('gen ' + generationType);
        
        if(theAcc.SchoolOfInterest__c != null){
            isFormAvailable = theAcc.SchoolOfInterest__r.ActivateApplicationForm__c; 
            lang = AP_Constant.getLanguage(String.isNotBlank(theAcc.TECH_ApplicationFormLang__c) ? theAcc.TECH_ApplicationFormLang__c : theAcc.SchoolOfInterest__r.Bilingual__c);
        }
        
        System.debug('lang ' + lang);
        renderedAs = (apexpages.currentpage().getparameters().get('isHTML')=='true'|| isFormAvailable == false)  ? '': 'advanced_pdf';
        
        if(theAcc.SchoolOfInterest__r.SchoolCode__c == 'BPX' ) {
            Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename='+ theAcc.Name + '_' + Datetime.now().format('YYYYMMdd')+'.pdf');
        }
        else {
            Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename=NAE_'+theAcc.SchoolOfInterest__r.SchoolCode__c+'_'+Datetime.now().format('YYYYMMdd')+'.pdf');
        }
    }

    // private string getLanguage(String language) {
    //     String code = 'en_US';
    //     if(language == AP_Constant.schoolBilingualChinese || language == AP_Constant.accAppFormLangZH ){
    //         code = 'zh_CN';
    //     }
    //     else if(language == AP_Constant.schoolBilingualThai || language == AP_Constant.accAppFormLangTH) {
    //         code = 'th';
    //     }
    //     else if(language == AP_Constant.schoolBilingualFrench || language == AP_Constant.accAppFormLangFR) {
    //         code = 'fr';
    //     }
    //     else if (language == AP_Constant.schoolBilingualVietnamese || language == AP_Constant.accAppFormLangVI) {
    //         code = 'vi';
    //     }
    //     else if (language == AP_Constant.schoolBilingualSpanish ||language == AP_Constant.accAppFormLangES) {
    //         code = 'es';
    //     }

    //     return code;
    // }

}