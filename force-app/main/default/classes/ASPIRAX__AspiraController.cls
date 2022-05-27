/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class AspiraController {
    global Boolean alwaysUseManualStrategy {
        get;
        set;
    }
    global List<System.SelectOption> availableDispatchers {
        get;
    }
    global List<System.SelectOption> availableLookups {
        get;
    }
    global List<System.SelectOption> availableObjects {
        get;
    }
    global String compilingStrategy {
        get;
        set;
    }
    global String dispatcher {
        get;
        set;
    }
    global String enterpriseURL {
        get;
        set;
    }
    global Boolean isFreeEdition {
        get;
    }
    global Boolean isLimitReached {
        get;
    }
    global String listener {
        get;
        set;
    }
    global String lookupField {
        get;
        set;
    }
    global String lookupType {
        get;
        set;
    }
    global Id relationToDelete {
        get;
        set;
    }
    global String triggerName {
        get;
        set;
    }
    global AspiraController() {

    }
    global System.PageReference addRelation() {
        return null;
    }
    global Boolean anyOfTriggersExists(List<ASPIRAX__Relation__c> relations) {
        return null;
    }
    @Deprecated
    global void compileTriggers(List<ASPIRAX__Relation__c> relations) {

    }
    global System.PageReference deleteRelation() {
        return null;
    }
    global List<ASPIRAX__Relation__c> getRelations() {
        return null;
    }
    global void invalidateData() {

    }
    global void parseResponse(String response, List<ASPIRAX__Relation__c> relations) {

    }
    global System.PageReference rerender() {
        return null;
    }
global class AspiraException extends Exception {
}
global class RunTestFailure {
    global String className;
    global String message;
    global String methodName;
    global String namespace;
    global RunTestFailure() {

    }
}
}
