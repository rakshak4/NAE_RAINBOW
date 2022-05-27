({
    doInit: function(component) {
        var recordId = component.get("v.recordId");

        //talking to server
        var action = component.get("c.getOpportunities");
        action.setParams({
            'contactID': recordId
        });

        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.lstOpportunities", result.lstOpp);
                component.set("v.lstRecTypes", result.lstRecTypes);
            }
        });

        $A.enqueueAction(action);
    },
    doDelete: function(component, recId) {
        //talking to server
        var action = component.get("c.deleteOpp");
        action.setParams({
            'oppId': recId
        });

        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var oppName = response.getReturnValue();
                this.showToastMessage("Deleted", "SUCESS", "Opportunity " + oppName + " was deleted.");
                $A.get('e.force:refreshView').fire();
            }
        });

        $A.enqueueAction(action);
    },
    showToastMessage: function(messageTitle, messageType, messageText) {
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": messageTitle,
            "type": messageType,
            "message": messageText,
            "duration": (messageType === 'error' ? 10000 : 5000)
        });
        resultsToast.fire();
    },
    doEdit: function(recId) {
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": recId
        });
        editRecordEvent.fire();
    },
    doNew: function(component, recTypeName) {
        var recId = component.get("v.recordId");
        var action = component.get("c.pepopulateNewOpp");
        action.setParams({
            'conId': recId,
            'recTypeName' :recTypeName
        });

        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var opp = response.getReturnValue();
                console.log('#### opp: ',opp);
                var createRecordEvent = $A.get("e.force:createRecord");
                createRecordEvent.setParams({
                    "recordTypeId": opp.RecordTypeId,
                    "entityApiName": "Opportunity",
                    "defaultFieldValues": opp
                });
                createRecordEvent.fire();
            }else{
                console.log("### error: ", response.getError()[0].message);
            }
        });
        $A.enqueueAction(action);
    }
})