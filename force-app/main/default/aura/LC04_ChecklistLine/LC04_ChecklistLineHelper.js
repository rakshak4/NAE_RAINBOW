({
    viewChecklist: function(component, event, checklistId) {
        var navEvent = $A.get("e.force:navigateToSObject");
        if (navEvent) {
            navEvent.setParams({
                "recordId": checklistId
            });
            navEvent.fire();
        }
    },

    toggleSpinner: function(component, event, helper) {
        var spinner = component.get("v.displaySpinner");
        if(spinner){
            component.set("v.displaySpinner", false);
        }else{
            component.set("v.displaySpinner", true);
        }
    },

    saveDocChklst: function(component) {
        var docChk = component.get("v.docCheck");
        this.toggleSpinner(component);
        var action = component.get("c.saveDocumentCheckList");

        action.setParams({
            "strJSONDocChk": JSON.stringify(docChk)
        });

        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var lstDocChk = response.getReturnValue();
                $A.get('e.force:refreshView').fire();
                this.showToastMessage("Success", "success", $A.getReference("$Label.c.RecordUpdateSuccessMessage"));
                this.toggleSpinner(component);
            } else {
                this.toggleSpinner(component);
                console.log("### error: ", response.getError()[0].message);
                this.showToastMessage("Error", "error", response.getError()[0].message);
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
})