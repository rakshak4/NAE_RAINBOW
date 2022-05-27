/**
 * @File Name          : LC12_DataTableController.cls
 * @Description        : Controller for LC12_DataTableController component
 * @Author             : Spoon Consulting
 * @Group              : 
 * @Last Modified By   : FKH
 * @Last Modified On   : 18-JAN-2021, 2:20 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      Modification
 *==============================================================================
 * 1.0    06-JAN-2021, 10:00 am         VJA         Initial Version
 * 1.1    18-JAN-2021, 2:20 PM          FKH         Cater for fields accessibility and visibility in data table
**/
public without sharing class LC12_DataTableController {
    @AuraEnabled
    public static Set<String> setFieldsToQuery { get;set; }
    @AuraEnabled
    public static Map<String, String> mapCustomFieldtoFieldApiName { get;set; }

    //Method to load DataTable Header(columns) from fieldSetName & objectApiName
    @AuraEnabled
    public static ResultWrapper loadDataTable ( String objectApiName, String fieldSetName, List<String> objectRecordIdsList){

        if(!Schema.getGlobalDescribe().containsKey(objectApiName)){
            throw new AurahandledException(objectApiName + ' is not a valid object API name.');
        }
        
        List<FieldsWrapper> lstFieldsetWrapper = new List<FieldsWrapper>();
        List<SObject> lstSObject;
        mapCustomFieldtoFieldApiName = new Map<String, String>();
        setFieldsToQuery = new set<String>();

		SObjectType sObjectType = Schema.getGlobalDescribe().get(objectApiName);
        Map<String,Schema.SObjectField> mapObjectToFields = sObjectType.getDescribe().fields.getMap();	// FKH - get all fields of the objects
        
        //Load columns from fieldset
        for(Schema.FieldSetMember fieldSetMemberObj : readFieldSet(objectApiName, fieldSetName)) {
            SObjectField field = mapObjectToFields.get(fieldSetMemberObj.getFieldPath());
            
            if(field.getDescribe().isAccessible()){  // FKH - Add column if user has access to field
                lstFieldsetWrapper.add(new FieldsWrapper(fieldSetMemberObj.getFieldPath(), fieldSetMemberObj.getLabel(),String.valueOf(fieldSetMemberObj.getType())));
                setFieldsToQuery.add(fieldSetMemberObj.getFieldPath().toLowerCase());
            }
        }

        //Query records using fieldset + object api name
        String queryString = 'Select id, ';
        setFieldsToQuery.remove('id');
        queryString += String.join( new List<String>(setFieldsToQuery), ',');
        queryString.removeEnd(',');
        queryString += ' FROM ' + objectApiName+' WHERE id in :objectRecordIdsList';

        //Try catch for query error
        try{
            lstSObject = Database.query(queryString);
        }catch(Exception e){
            throw new AurahandledException(objectApiName + ' record(s) query error. Please contact your system administrator.');
        }

        //Linkification of reference type
        List<Map<String, Object>> lstObject = addUrlAttributes(lstSObject);

        return new ResultWrapper(lstObject,lstFieldsetWrapper);
    }

    //Method to retrieve fieldSet
    private static List<Schema.FieldSetMember> readFieldSet(String objectApiName, String fieldSetName) {
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectApiName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);

        if(fieldSetObj == null){
            throw new AurahandledException(fieldSetObj + ' is not a valid field set for ' + objectApiName + '.');
        }
        
        return fieldSetObj.getFields(); 
    }

    //method for linkification
    public static List<Map<String, Object>> addUrlAttributes(list<SObject> lstSObject){
        List<Map<String, Object>> lstMapofObject = new List<Map<String, Object>>();
                
        if(lstSObject.size() == 0){
            return lstMapofObject;
        }

        for(SObject obj : lstSObject){
            Map<String, Object> mapFieldtoValue = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(obj)); //Obj to Map
            
            //Loop to add additional attributes for linkification
            for(String key : mapCustomFieldtoFieldApiName.keySet()){ 
                String fieldApiName = mapCustomFieldtoFieldApiName.get(key); 

                if(key.startsWith('link')){
                    Object recordId = mapFieldtoValue.get(fieldApiName); //(linkOwnerName, OwnerId)
                    if(recordId != null){
                        mapFieldtoValue.put(key, '/' + mapFieldtoValue.get(fieldApiName));
                    }
                }else{
                    String strfieldApiNames = String.valueOf(fieldApiName);
                    List<String> lookupElement = strfieldApiNames.split('\\.'); //eg split Opportunity.Name to Opportunity and Name

                    Map<String, Object> mapOflookupData = (Map<String, Object>) mapFieldtoValue.get(lookupElement[0]); //eg get map of Opportunity values

                    if(mapOflookupData != null){
                        Object lookupFieldValue = mapOflookupData.get(lookupElement[1]); // eg get value of Name from Opportunity values map
                        if(lookupFieldValue != null){
                            mapFieldtoValue.put(key, lookupFieldValue);
                        }
                    }
                }
            }

            lstMapofObject.add(mapFieldtoValue);

        }
        
        return lstMapofObject;
    }

    //Wrapper Class for data table columns
    public class FieldsWrapper {
        @AuraEnabled
        public String fieldName { get;set; }
        @AuraEnabled
        public String label { get;set; }
        @AuraEnabled
        public String type { get; set; }
        @AuraEnabled
        public Boolean sortable { get; set; }
        @AuraEnabled
        public Map<String, Object> typeAttributes { get; set; }

        public FieldsWrapper(String fieldName, String strLabel, String strType) {
            this.fieldName = fieldName;
            this.label = strLabel;
            this.type = strType;
            this.sortable = true;
            this.typeAttributes = new Map<String, Object>();

            //Fields attributes modification
            modifyFieldAttributes();
        }

        //Method to modify field attributes
        public void modifyFieldAttributes(){

            //Object Name or ID Field
            if(this.fieldName == 'Name' || (this.fieldName == 'Id' && this.type == 'ID')){

                String originalFieldApiName = 'Id';
                String dataTableFieldName = this.fieldName;

                this.type = 'url';
                this.typeAttributes.put('target', '_blank');
                this.typeAttributes.put('label', new Map<String, Object>{'fieldName' => dataTableFieldName});
                this.fieldName = 'link' + dataTableFieldName; //change fieldname to linkname

                mapCustomFieldtoFieldApiName.put(this.fieldName, originalFieldApiName); //eg (linkName, OwnerId) to replace linkOwnerName value with OwnerId value later
            }

            //Standard & Custom Lookup Fields
            if((this.fieldName.endsWith('Id') || this.fieldName.endsWith('__c'))  && this.type == 'reference'){ 
                String originalFieldApiName = this.fieldName;
                String fieldApiName; 
                String dataTableFieldName;

                // Removes ' Id'/ 'Id' from reference field's label
                if(this.label.endsWithIgnoreCase(' Id')){
                    this.label = this.label.removeEndIgnoreCase(' Id');
                }
                else if(this.label.endsWithIgnoreCase('Id')){
                    this.label = this.label.removeEndIgnoreCase(' Id');
                }

                if(this.fieldName.endsWith('Id')){
                    fieldApiName = this.fieldName.replace('Id', '.Name');
                    dataTableFieldName = this.fieldName.replace('Id', 'Name');
                }else if(this.fieldName.endsWith('__c')){
                    fieldApiName = this.fieldName.replace('__c', '__r.Name');
                    dataTableFieldName = this.fieldName.replace('__c', 'Name');
                }
                
                this.type = 'url';
                this.typeAttributes.put('target', '_blank');
                this.typeAttributes.put('label', new Map<String, Object>{'fieldName' => dataTableFieldName});
                this.fieldName = 'link' + dataTableFieldName;
                setFieldsToQuery.add(fieldApiName.toLowerCase()); //Add lookupField.Name to list of fields to query

                mapCustomFieldtoFieldApiName.put(this.fieldName, originalFieldApiName);//eg (linkOwnerName, OwnerId) to replace linkOwnerName value with OwnerId value later
                mapCustomFieldtoFieldApiName.put(dataTableFieldName, fieldApiName); //eg (OwnerName, Owner.Name) to replace OwnerName value with Owner.Name value later

            }

            //Date & DateTime Formatting
            if(this.type == 'datetime' || this.type == 'date'){

                if(this.type == 'datetime'){
                    this.typeAttributes.put('hour', '2-digit');  
                    this.typeAttributes.put('minute', '2-digit');  
                    this.typeAttributes.put('second', '2-digit');  
                    this.typeAttributes.put('hour12', true);
                }

                this.type = 'date';
                this.typeAttributes.put('day', 'numeric');  
                this.typeAttributes.put('month', 'numeric');  
                this.typeAttributes.put('year', 'numeric');  
            }
        }
    }

    //Wrapper Class for result (list of objects + list of fields)
    public class ResultWrapper {
        @AuraEnabled
        public List<Map<String, Object>> lstObject;
        @AuraEnabled
        public list<FieldsWrapper> lstFields;
        
        public ResultWrapper(List<Map<String, Object>> lstObject, list<FieldsWrapper> lstFields) {    
            this.lstObject = lstObject;
            this.lstFields  = lstFields;
        }
    }
}