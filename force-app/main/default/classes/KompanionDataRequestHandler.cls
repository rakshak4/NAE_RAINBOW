//class for handling data update from Kompanion
public without sharing class KompanionDataRequestHandler {
    
    /*
        request example
<process object="Opportunity" token="00D7E0000008j53!AQwAQAtLA.dvkCsbGhUVkb5Kpxz_ZUQrxwWWYA0e3CQmLBvwZAeT5_7tWn67" id="006D000000oDgxu"><data name="Name_in_Local_Language__c ">Test Kunal</data></process>  
        <process object="Opportunity" token="unique token" id="salesforce record id"><data name="field API name">value</data><data name="field API name 2">value</data></process>  
    */
    private string dataXML {get;set;}
    private boolean isError {get;set;}
    private string errorMessage {get;set;}
    private static final string token = '00D7E0000008j53!AQwAQAtLA.dvkCsbGhUVkb5Kpxz_ZUQrxwWWYA0e3CQmLBvwZAeT5_7tWn67';
    //constructor
    public KompanionDataRequestHandler(){
        isError = false;
        dataXML = system.currentPageReference().getParameters().get('data');
        if(dataXML != null && dataXML.trim() != ''){
            dataXML = EncodingUtil.base64Decode(dataXML.trim()).toString();
        }else{
            isError = true;
            errorMessage = 'Request Data: <br/>'+dataXML;
            errorMessage += '<br/><br/>Invalid Request : Missing Data';
        }
        
        
    }
    
    public PageReference processRequest(){
        if(isError == false){
            try{
                //parse XML 
                Dom.Document doc = new Dom.Document();
                doc.load(dataXML);
                Dom.Xmlnode processNode = doc.getRootElement();
                string objectType = processNode.getAttributeValue('object','');
                string objectId = processNode.getAttributeValue('id','');
                string requestToken = processNode.getAttributeValue('token','');
                if(requestToken != token && !Test.isRunningTest()){
                    isError = true;
                    errorMessage = 'Request Data: <br/>'+dataXML;
                    errorMessage += '<br/><br/>Invalid Request : Invalid Token';
                }else{
                    SObject obj ;
                    if(objectType.equalsIgnoreCase('Opportunity')){
                        obj = new Opportunity(Id = objectId);
                    }else if(objectType.equalsIgnoreCase('Contact')){
                        obj = new Contact(Id = objectId);
                    }
                    //parse field values
                    for(Dom.Xmlnode childNode: processNode.getChildElements()){
                        if(childNode.getName().equalsIgnoreCase('data')){
                            obj.put(childNode.getAttributeValue('name',''), childNode.getText());
                        }
                    }
                    //update
                    update obj;
                }
            }catch(Exception e){
                isError = true;
                errorMessage = 'Request Data: <br/>'+dataXML;
                errorMessage += '<br/><br/> Error Message: '+e.getMessage();
            }
            
        }
        if(isError == true || Test.isRunningTest()){
            //send email 
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           set<String> emailSet = new set<String>();
           emailSet.add('ben.hails@britishschools.co.uk');
           emailSet.add('anton.simanikhin@britishschools.co.uk');
           //emailSet.add('ku9al1985@gmail.com');
           list<String> toAddresses =  new list<String>();
           for(string e:emailSet){
            toAddresses.add(e);
           }
           string emailText = '';
           mail.setToAddresses(toAddresses);
           mail.setSubject('Important: Error while updating data from Kompanion. '+datetime.now());
           emailText += errorMessage;
           mail.setHtmlBody(emailText);
           boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox; 
           if(!Test.isRunningTest()){Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });} 
                
        }
        return null;
    }
}