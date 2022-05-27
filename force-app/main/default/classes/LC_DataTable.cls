/**
 * @File Name          : LC_DataTable.cls
 * @Description        : Controller for LC_DataTable component
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
 * 1.2    27-01-2021, 10:00 AM          VJA         Replace loopkup id with table data
**/
public without sharing class LC_DataTable {
    @AuraEnabled
    public static Set<String> setFieldsToQuery { get;set; }
    @AuraEnabled
    public static Map<String, String> mapCustomFieldtoFieldApiName { get;set; }
    public static Map<String, String> mapFieldtoObject;
    public static String objectApi;

    //Method to load DataTable Header(columns) from fieldSetName & objectApiName
    @AuraEnabled
    public static ResultWrapper loadDataTable ( String objectApiName, String fieldSetName, String strObjectList){
        List<FieldsWrapper> lstFieldsetWrapper = new List<FieldsWrapper>();
        Map<String, Map<Id, SObject>> mapFieldtoMapRecords = new Map<String, Map<Id, SObject>>();
        Map<String, List<String>> mapFieldtoIds = new Map<String, List<String>>();
        mapCustomFieldtoFieldApiName = new Map<String, String>();
        mapFieldtoObject = new Map<String, String>();
        setFieldsToQuery = new set<String>();
        objectApi = objectApiName;

        //check if object exists
        if(!Schema.getGlobalDescribe().containsKey(objectApiName)){
            throw new AurahandledException(objectApiName + ' is not a valid object API name');
        }

        //deserialise JSON to list of sobject
        List<sObject> lstSObject = (List<sObject>)JSON.deserialize(strObjectList, List<sObject>.class);

		SObjectType sObjectType = Schema.getGlobalDescribe().get(objectApiName);
        Map<String,Schema.SObjectField> mapObjectToFields = sObjectType.getDescribe().fields.getMap();	// FKH - get all fields of the objects
        
        //Load columns from fieldset
        for(Schema.FieldSetMember fieldSetMemberObj : readFieldSet(objectApiName, fieldSetName)) {
            SObjectField field = mapObjectToFields.get(fieldSetMemberObj.getFieldPath());
            
            if(field.getDescribe().isAccessible()){  // FKH - Add column if user has access to field
                lstFieldsetWrapper.add(new FieldsWrapper(fieldSetMemberObj.getFieldPath(), fieldSetMemberObj.getLabel(), String.valueOf(fieldSetMemberObj.getType())));
                setFieldsToQuery.add(fieldSetMemberObj.getFieldPath().toLowerCase());
            }
        }

        //Loop records to get map<reference field, list of ids> eg <Child__c, List<String>{'121', '233'}>
        for(SObject objectRecord : lstSObject){
            for(String field : mapFieldtoObject.keySet()){
                if(objectRecord.get(field) != null){
                    if(mapFieldtoIds.containsKey(field)){
                        mapFieldtoIds.get(field).add(String.valueOf(objectRecord.get(field)));
                    }else {
                        mapFieldtoIds.put(field, new List<String> {String.valueOf(objectRecord.get(field))});
                    }
                }
            }
        }

        //Query records for each field-object eg <Child__c, Map< '123', 'Tesla Record'>>
        for(String field : mapFieldtoIds.keySet()){

            List<String> lstIds = mapFieldtoIds.get(field);
            Map<Id, SObject> mapIdtoSObject = new Map<Id, SObject>();
            List<SObject> queryResult;

            if(lstIds != null && mapFieldtoObject.get(field) != null){
                String queryString = 'Select id, name FROM ' + mapFieldtoObject.get(field) + ' WHERE id in :lstIds';

                try{
                    queryResult = Database.query(queryString);
                    for(SObject objectRecord : queryResult){
                        mapIdtoSObject.put(objectRecord.Id, objectRecord);
                    }
                }catch(Exception e){
                    System.debug('###Query Failed');
                }

            }

            mapFieldtoMapRecords.put(field, mapIdtoSObject);
        }

        //Reference linkification
        List<Map<String, Object>> lstObject = addUrlAttributes(lstSObject, mapFieldtoMapRecords);

        return new ResultWrapper(lstObject,lstFieldsetWrapper);
    }

    //Method to retrieve fieldSet
    private static List<Schema.FieldSetMember> readFieldSet(String objectApiName, String fieldSetName) {
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectApiName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);

        if(fieldSetObj == null){
            throw new AurahandledException(fieldSetObj + ' is not a valid field set for ' + objectApiName);
        }
        
        return fieldSetObj.getFields(); 
    }

    //Method for reference type linkification
    public static List<Map<String, Object>> addUrlAttributes(list<SObject> lstSObject, Map<String, Map<Id, SObject>> mapFieldtoMapRecords){
        List<Map<String, Object>> lstMapofObject = new List<Map<String, Object>>();
                
        if(lstSObject.size() == 0){
            return lstMapofObject;
        }

        Integer counter = 1;
        for(SObject obj : lstSObject){
            
            Map<String, Object> mapFieldtoValue = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(obj)); //Object Record: Map of Field to Value
            mapFieldtoValue.put('Id', counter);
            counter++;

            //Loop to add additional attributes for linkification (link and label)
            for(String key : mapCustomFieldtoFieldApiName.keySet()){ 

                String fieldApiName = mapCustomFieldtoFieldApiName.get(key); //OwnerId or OwnerName

                if(key.startsWith('link')){ // add link to object record
                    Object recordId = mapFieldtoValue.get(fieldApiName); //(linkOwnerName, OwnerId)
                    if(recordId != null){
                        mapFieldtoValue.put(key, '/' + mapFieldtoValue.get(fieldApiName));
                    }

                }else{

                    Map<Id, SObject> mapSpecificFieldtoMapRecords = mapFieldtoMapRecords.get(fieldApiName); //Get map of object Id to Record
                    String referenceFieldId = String.valueOf(mapFieldtoValue.get(fieldApiName));

                    if(mapSpecificFieldtoMapRecords != null && referenceFieldId != null){
                        SObject objectRecord = mapSpecificFieldtoMapRecords.get(referenceFieldId);
                        if(objectRecord != null){
                            mapFieldtoValue.put(key, objectRecord.get('Name'));
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

            //Fields linkification
            modifyFieldAttributes();
        }

        public void modifyFieldAttributes(){

            //Standard & Custom Lookup Fields
            if((this.fieldName.endsWith('Id') || this.fieldName.endsWith('__c'))  && this.type == 'reference'){
                
                String originalFieldApiName = this.fieldName;
                String fieldApiName; 
                String dataTableFieldName;

                //Removes ' Id'/ 'Id' from reference field's label
                 if(this.label.endsWithIgnoreCase(' Id')){
                     this.label = this.label.removeEndIgnoreCase(' Id');
                 }
                 else if(this.label.endsWithIgnoreCase('Id')){
                     this.label = this.label.removeEndIgnoreCase(' Id');
                 }

                //Get Object Api Name of reference field; eg (lookup field Child__c references to Contact object)
                Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(objectApi).getDescribe().fields.getMap().get(this.fieldName).getDescribe();

                //Get map of field (reference) and objectapiName Map<OwnerId, User>
                if(fieldResult != null){
                    for(Schema.SObjectType reference : fieldResult.getReferenceTo()){
                        mapFieldtoObject.put(this.fieldName, reference.getDescribe().getName());
                        break;
                    }
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

                mapCustomFieldtoFieldApiName.put(this.fieldName, originalFieldApiName);//eg (linkOwnerName, OwnerId) to replace linkOwnerName value with OwnerId value later
                mapCustomFieldtoFieldApiName.put(dataTableFieldName, originalFieldApiName); //eg (OwnerName, Owner.Name) to replace OwnerName value with Owner.Name value later
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