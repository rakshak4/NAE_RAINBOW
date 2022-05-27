public class TranslateWebContent{
    public Web_Content__c webContentRecord {get;set;}
    public string requestDescription {get;set;}
    public boolean notify {get;set;}
    public boolean isSuccess {get;set;}
    //constructor
    public TranslateWebContent(ApexPages.StandardController controller){
        isSuccess = false;
        webContentRecord = (Web_Content__c)controller.getRecord(); 
        notify = false;
    }
    //function to update calendarRecord
    public PageReference submitTranslationRequest(){
    	try{
	    	webContentRecord.Translation_Status__c = 'Requested';
	    	webContentRecord.Update_Request_Description__c = requestDescription;
	    	webContentRecord.Send_Update_Request_Email__c = true;
	    	webContentRecord.Notify_Me_When_Translation_is_Complete__c = notify;
	    	update webContentRecord;
	    	isSuccess = true;
    	}catch(Exception e){
    		isSuccess = false;
    		ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'There were errors when sending the Updated Translation Request email. Please report this error to the system administrator, including the URL of the record in your email. Error Message: '+e.getMessage());
			ApexPages.addMessage(errorMessage);	
    	}
        return null;
    }
}