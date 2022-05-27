public with sharing class AP05_SendLeadToMailChimp {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Trigger class for sending leads to mailchimp using REST API
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 16-APR-2018  RRAJ    1.0     Initial version
-- 04-Jul-2018  AMU    1.1      Dynamically call the mailchimp API for each school
--------------------------------------------------------------------------------------
**************************************************************************************/

    /**
     * Sends contacts details to Mailchimp.
     * @param      lstLed  List of newly created lead.
     */
    public static void sendToMailChimp(List<Lead> lstLed){
        //System.debug('/// lstLead '+lstLed);

        Map<String, MailChimpPatchBody> mapApiToMailChimpPatchBody = new Map<String, MailChimpPatchBody>();
        Map<String, Mailchimp__c> mapSchoolIdToMailchimp = new Map<String, Mailchimp__c>();
        Map<String, Set<Id>> mapApiToSetLeadId = new Map<String, Set<Id>>();
        Set<String> setSchoolId = new Set<String>();
        Map<String, String> mapApiKeyToUrl = new Map<String, String>();

        for(Lead lead: lstLed) {
            setSchoolId.add(lead.SchoolOfInterest__c); 
        }

        for(Mailchimp__c mailchimp: [SELECT Id, ApiKey__c, EnquiryGroupId__c, ListId__c, School__c, URL__c
                                        FROM Mailchimp__c WHERE School__c IN :setSchoolId]) {
            mapSchoolIdToMailchimp.put(mailchimp.School__c, mailchimp);
            mapApiKeyToUrl.put(mailchimp.ApiKey__c, mailchimp.URL__c);
        }

        //System.debug('/// mapSchool '+mapSchoolIdToMailchimp);

        for(Lead led : lstLed) {
            Set<Id> setLedId;
            Mailchimp__c mailchimp = mapSchoolIdToMailchimp.get(led.SchoolOfInterest__c);

            if(mailchimp != null) {
                if(mapApiToSetLeadId.containsKey(mailchimp.ApiKey__c)) {
                    setLedId = mapApiToSetLeadId.get(mailchimp.ApiKey__c);
                    setLedId.add(led.Id);
                } else {
                    setLedId = new Set<Id>{led.Id};
                }
                mapApiToSetLeadId.put(mailchimp.ApiKey__c, setLedId);

                if(String.isNotBlank(led.Parent1PrimaryEmail__c)) {
                    mapApiToMailChimpPatchBody = getMapApiToMailChimpPatchBody(led.Parent1PrimaryEmail__c, led.Parent1FirstName__c,
                                                    led.Parent1LastName__c, mailchimp, mapApiToMailChimpPatchBody); 
                }

                if(String.isNotBlank(led.Parent2PrimaryEmail__c)) {
                    mapApiToMailChimpPatchBody = getMapApiToMailChimpPatchBody(led.Parent2PrimaryEmail__c, led.Parent2FirstName__c,
                                                    led.Parent2LastName__c, mailchimp, mapApiToMailChimpPatchBody);        
                }
            }
        }

        if(mapApiToMailChimpPatchBody.size() > 0) {
            sendMailChimpBatch(JSON.serialize(mapApiToMailChimpPatchBody), JSON.serialize(mapApiToSetLeadId), JSON.serialize(mapApiKeyToUrl));
        }
    }

    /**
     * Gets the map api to mail chimp patch body.
     *
     * @param      email                       contact email
     * @param      fname                       contact first name
     * @param      lname                       contact last name
     * @param      mailchimp                   mailchimp object
     * @param      mapApiToMailChimpPatchBody  The map api to mail chimp patch body
     * @return     The map api to mail chimp patch body.
     */
    public static Map<String, MailChimpPatchBody> getMapApiToMailChimpPatchBody(String email, String fname, String lname, Mailchimp__c mailchimp,
                                                                            Map<String, MailChimpPatchBody> mapApiToMailChimpPatchBody) {
        MailChimpPatchBody mailChimpBody;
        Map<String,Boolean> interest;

        if(String.isNotBlank(mailchimp.EnquiryGroupId__c)) {
            interest = new Map<String,Boolean>{mailchimp.EnquiryGroupId__c => true};
        }
        
        AP05_MailChimpMember member  = new AP05_MailChimpMember(email, fname, lname, interest);
        String md5Hash = EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(email.trim())));

        MailChimpOperation opp = new MailChimpOperation();
        opp.method = 'PUT';
        opp.body = JSON.serialize(member, true);
        opp.path = '/lists/' + mailchimp.ListId__c +'/members/' + md5Hash;

        if(mapApiToMailChimpPatchBody.containsKey(mailchimp.ApiKey__c)) {
            mailChimpBody = mapApiToMailChimpPatchBody.get(mailchimp.ApiKey__c);
        } else {
            mailChimpBody = new MailChimpPatchBody();
        }

        mailChimpBody.operations.add(opp);
        mapApiToMailChimpPatchBody.put(mailchimp.ApiKey__c, mailChimpBody);  
        return mapApiToMailChimpPatchBody;
    }

    /**
     * Callout to send mailchimp in batch
     * @param      mapApiStr  Map api JSON
     * @param      setLedStr  Set of lead JSON
     */
    @future (callout = true)
    public static void sendMailChimpBatch(String mapApiStr, String setLedStr, String mapApiToUrl){
        List<MailChimpResponse> lstResponse = new List<MailChimpResponse>();

        Map<String, String> mapApiKeyToUrl = (Map<String, String>) JSON.deserialize(mapApiToUrl, Map<String, String>.class);

        Map<String, MailChimpPatchBody> mapApiToMailChimpPatchBody = (Map<String, MailChimpPatchBody>) JSON.deserialize(mapApiStr, 
                                                                        Map<String, MailChimpPatchBody>.class);

        Map<String, Set<Id>> mapApiToSetLeadId = (Map<String, Set<Id>>) JSON.deserialize(setLedStr, Map<String, Set<Id>>.class);

        for(String key: mapApiToMailChimpPatchBody.keySet()) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(mapApiKeyToUrl.get(key));
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setHeader('Authorization', 'apikey '+ key);
            request.setBody(JSON.serialize(mapApiToMailChimpPatchBody.get(key), true));
            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                lstResponse.add(new MailChimpResponse('Lead parent details sent to MailChimp successfully', mapApiToSetLeadId.get(key)));
            } else {
                if(String.isNotBlank(response.getBody())) {
                     Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                     lstResponse.add(new MailChimpResponse('An error occured while synchronising parent details with MailChimp, Error: '+ (String)results.get('detail'), mapApiToSetLeadId.get(key)));
                } else {
                    lstResponse.add(new MailChimpResponse('An error occured while synchronising parent details with MailChimp', mapApiToSetLeadId.get(key)));
                }
            }
        }

        if(lstResponse.size() > 0) {
           saveMailChimpResponse(lstResponse); 
        }
    }

    /**
     * Saves mail chimp response.
     * @param      lstResponse  The list Mailchimp response
     */
    public static void saveMailChimpResponse(List<MailChimpResponse> lstResponse){
        List<Lead> lstLedToUpdate = new List<Lead>();

        for(MailChimpResponse mailChimpResp: lstResponse) {
            for(Id ledId : mailChimpResp.setLedId){
                Lead led = new Lead(Id = ledId, TECH_MCResponse__c = mailChimpResp.response);
                lstLedToUpdate.add(led);
            }
        }

        if(lstLedToUpdate.size()>0){
           List<Database.SaveResult> lstSR = Database.update(lstLedToUpdate, false);
        }
    }

    /**
     * Class for mailchimp patch body.
     */
    private class MailChimpPatchBody{
        private List<MailChimpOperation> operations {get; set;}

        private MailChimpPatchBody(){
            this.operations = new List<MailChimpOperation>();
        }
    }

    /**
     * Class for mailchimp operation.
     */
    private class MailChimpOperation{
        private String method {get; set;}
        private String path {get; set;}
        //private String operation_id {get; set;}
        //private Object params {get; set;}
        private String body {get; set;}
    }

    /**
     * Class for mail chimp response.
     */
    private class MailChimpResponse {
        private String response {get; set;}
        private Set<Id> setLedId {get; set;}

        public MailChimpResponse(String response, Set<Id> setLedId){
            this.response = response;
            this.setLedId = setLedId;
        }
    }
}