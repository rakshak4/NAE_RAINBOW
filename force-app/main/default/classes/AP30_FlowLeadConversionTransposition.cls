/**
 * @File Name          : AP30_FlowLeadConversionTransposition
 * @Description        : Called from flow for lead conversion
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : FKH
 * @Last Modified On   : 26-JAN-2021, 2:20 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    26-JAN-2021, 10:00 am         VJA         Initial Version
**/
public without sharing class AP30_FlowLeadConversionTransposition {

    /**
     * Represents wrapper class for batch lead convert request
     */
    public class LeadConvertRequest {

        @InvocableVariable(
            label = 'List of lead records to convert'
            description = 'List of lead records to convert'
            required = true
        )
        public List<Lead> lstLead;

        @InvocableVariable(
            label = 'Converted Status'
            description = 'Lead status picklist value that indicates this Lead is converted'
            required = true
        )
        public String convertedStatus;

        @InvocableVariable(
            label = 'Account ID'
            description = 'The specific Account to convert Lead into. If blank then creates new Account.'
            required = true
        )
        public ID accountId;

        @InvocableVariable(
            label = 'Create Opportunity?'
            description = 'Create an Opportunity? Default is true.'
        )
        public Boolean createOpportunity = true;
        
    }

    /**
     * Represents wrapper class for batch lead convert result
     */
    public class LeadConvertResult {

        @InvocableVariable( label = 'List of Opportunities' )
        public List<Opportunity> lstOpportunity;

    }

    /**
     * Represents wrapper class for batch lead convert
     */
    public class LeadConvertWrapper {

        public ID leadId;
        public ID accountId;
        public ID contactId;
        public String convertedStatus;
        public Boolean createOpportunity;
        public String opportunityName;

    }

    // Invocable method called from flow to convert leads in batch
    @InvocableMethod(
        label = 'Batch Convert Lead Records'
    )
    public static List<LeadConvertResult> convertLeads( List<LeadConvertRequest> requests ) {

        List<Lead> lstLead = new List<Lead>();
        List<LeadConvertWrapper> lstLeadConvertWrapper = new List<LeadConvertWrapper>();
        List<LeadConvertResult> results = new List<LeadConvertResult>();
        LeadConvertResult result = new LeadConvertResult();
        List<ID> lstOpportunityId = new List<ID>();
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        List<Database.LeadConvert> convertRequests = new List<Database.LeadConvert>();
        Savepoint sp = Database.setSavepoint();

        //get list of leads from parameters
        if(requests != null && requests.size() > 0){
            lstLead = requests[0].lstLead;
        }

        //transform list of leads into wrapper class for lead convert 
        for(Lead lead : lstLead){
            LeadConvertWrapper leadConvertWrapper = new LeadConvertWrapper();

            leadConvertWrapper.leadId = lead.Id;
            leadConvertWrapper.contactId = lead.TECH_ContactId__c;
            leadConvertWrapper.accountId = requests[0].accountId;
            leadConvertWrapper.convertedStatus = requests[0].convertedStatus;
            leadConvertWrapper.createOpportunity = !lead.TECH_IsNDM__c;

            System.debug('###leadConvertWrapper.leadId' + leadConvertWrapper.leadId ); 
            System.debug('###leadConvertWrapper.contactId' + leadConvertWrapper.contactId ); 
            System.debug('###leadConvertWrapper.accountId' + leadConvertWrapper.accountId ); 
            System.debug('###leadConvertWrapper.convertedStatus' + leadConvertWrapper.convertedStatus ); 
            System.debug('###leadConvertWrapper.createOpportunity' + leadConvertWrapper.createOpportunity ); 
            
            if(leadConvertWrapper.createOpportunity){
                if(lead.FirstName == null){
                    leadConvertWrapper.opportunityName = lead.lastName;
                }else{
                    leadConvertWrapper.opportunityName = lead.FirstName + ' ' + lead.lastName;
                }
            }

            lstLeadConvertWrapper.add(leadConvertWrapper);
        }

        try{
            //transform wrapper into lead convert request
            for(LeadConvertWrapper leadConvertWrapper : lstLeadConvertWrapper){
                convertRequests.add( transform( leadConvertWrapper ) );
            }

            // if any has error then exception is thrown automatically and changes rolled back
            List<Database.LeadConvertResult> convertResults;
            convertResults = Database.convertLead( convertRequests, true );            
               
            //transform result for output to flow
            for ( Database.LeadConvertResult convertResult : convertResults ) {
                if(convertResult.isSuccess()){
                    if(convertResult.getOpportunityId() != null){
                        lstOpportunityId.add(convertResult.getOpportunityId());
                    }
                }
            }

            //getListOfOpportunity //SOQL Optimisation
            lstOpportunity = getListOfOpportunity(lstOpportunityId);
            result.lstOpportunity = lstOpportunity;
            results.add(result);

        }catch(Exception e){
            Database.rollback(sp);
            throw new ConvertLeadException(e.getMessage());
        }

        return results;
    }

    // method to convert LeadConvertWrapper to Database.LeadConvert
    private static Database.LeadConvert transform( LeadConvertWrapper leadConvertWrapper ) {
                
        Database.LeadConvert convertRequest = new Database.LeadConvert();
                
        convertRequest.setLeadId( leadConvertWrapper.leadId );
        convertRequest.setConvertedStatus( leadConvertWrapper.convertedStatus );

        if ( leadConvertWrapper.accountId != null ){convertRequest.setAccountId( leadConvertWrapper.accountId ); }
        
        if ( leadConvertWrapper.contactId != null ){ convertRequest.setContactId( leadConvertWrapper.contactId );}

        if ( leadConvertWrapper.createOpportunity == true){ 
            convertRequest.setDoNotCreateOpportunity(false);
            if ( leadConvertWrapper.opportunityName != null ){ 
                convertRequest.setOpportunityName( leadConvertWrapper.opportunityName );
            }
        }else{
            convertRequest.setDoNotCreateOpportunity(true);
        }
        convertRequest.setSendNotificationEmail( false );

        return convertRequest;
    }

    public static List<Opportunity> getListOfOpportunity(List<Id> lstOppIds){
        if(lstOppIds.size() == 0){
            return new List<Opportunity>();
        }

        String strQuery = getCreatableFieldsSOQL('Opportunity', 'Id in:lstOppIds');
        List<Opportunity> lstOpportunity = (List<Opportunity>) Database.query(strQuery);

        return lstOpportunity;
    }

    public static String getCreatableFieldsSOQL(String objectName, String whereClause) {
        String selects = '';
         
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        Set<String> selectFields = new Set<string>();
         
        if (fMap != null) {
            for (Schema.SObjectField ft : fMap.values()) { 
                Schema.DescribeFieldResult fd = ft.getDescribe();
                if (fd.isCreateable()) {
                    selectFields.add(fd.getName());
                }
            }
        }
         
        if (!selectFields.isEmpty()) {
            if(!selectFields.contains('CreatedDate')) {
                selectFields.add('CreatedDate');
            }

            for (String s:selectFields) {
                selects += s + ',';
            }
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
        }
         
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
    }

    public class ConvertLeadException extends Exception {}
}