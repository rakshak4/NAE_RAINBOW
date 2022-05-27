/**
* @author Spoon
* @date 28/06/2018
* @description [User Story: W-000141]
* Ability to seamlessly allow family to apply during the visit 
* Make an online Application form (Rich) 
* Enable the Application form to map and push data into salesforce (Lead) 
* Create a button on Opportunity detail page to manually create this PDF 
* In Salesforce, when "Generate PDF" button is clicked, open a new window that shows the PDF version of the Application that can be manually saved by the user and sent as attachment to an email. 
* Format of the PDF specs to follow
*/
global with sharing class VFC02_ApplicationForm{
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Controller class for VFP02_ApplicationForm
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  ------------------------------------------------------- 
-- 28-JUN-2018  WCH   1.0     Initial Version[User Story: W-000141]
-- 10-JUL-2018  WCH   1.1     New requirements, template should change wrt to school of interest on opportunity
-- 12-DEC-2018  CRA   1.2     Use a component that is called also in email template[User Story: W-000344]
--------------------------------------------------------------------------------------
**************************************************************************************/

    public integer noOfParents {get;set;}
    public boolean hasFinancialContact {get;set;}
    public Opportunity theOpp {get;set;}
    public Contact theChild {get;set;}
    public Contact thePrimaryContact {get;set;}
    public String theSchoolOfInterest {get;set;}
    public String renderedAs {get;set;}
    public Map<String,List<Contact>> thefamily {get;set;}
    public Boolean isFormAvailable {get;set;}
    public String lang {get;set;}


    public VFC02_ApplicationForm(ApexPages.StandardController sc) {
        //fetch opportunity details                                               
        theOpp = [SELECT    id
                            ,StageName
                            ,Name
                            ,AccountId
                  			,SchoolOfInterest__c
                  			,SchoolOfInterest__r.ActivateApplicationForm__c
                            ,Child__c
                            ,Account.Name
                            ,Account.FinancialContact__c
                            ,Account.PrimaryContact__c
                            ,SchoolOfInterest__r.Bilingual__c
                            ,SchoolOfInterest__r.SchoolCode__c
                            ,Account.TECH_ApplicationFormLang__c
                            FROM Opportunity
               WHERE id = :((Opportunity)sc.getRecord()).Id];
        
        isFormAvailable = false;
        lang='en-US';
        
        if(theOpp.SchoolOfInterest__c != null){
            isFormAvailable = theOpp.SchoolOfInterest__r.ActivateApplicationForm__c; 
            lang = AP_Constant.getLanguage(String.isNotBlank(theOpp.Account.TECH_ApplicationFormLang__c) ? theOpp.Account.TECH_ApplicationFormLang__c : theOpp.SchoolOfInterest__r.Bilingual__c);
        }
        
        renderedAs = (apexpages.currentpage().getparameters().get('isHTML')=='true'|| isFormAvailable == false)  ? '': 'advanced_pdf';
        if(theOpp.SchoolOfInterest__r.SchoolCode__c == 'BPX' ) {
            Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename='+ theOpp.Account.Name + '_' + Datetime.now().format('YYYYMMdd')+'.pdf');
        }
        else {
            Apexpages.currentPage().getHeaders().put('content-disposition', 'inline; filename=NAE_'+theOpp.SchoolOfInterest__r.SchoolCode__c+'_'+Datetime.now().format('YYYYMMdd')+'.pdf');
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

    //     return code;
    // }
}