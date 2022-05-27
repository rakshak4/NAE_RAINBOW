@isTest
private class TestTranslateWebContent{
    static testMethod void testTranslateWebContentVFInterface(){
    	Web_Content__c wc = new Web_Content__c();
    	ApexPages.StandardController s = new ApexPages.StandardController(wc);
    	TranslateWebContent controller = new TranslateWebContent(s);
    	controller.submitTranslationRequest();
    }
}