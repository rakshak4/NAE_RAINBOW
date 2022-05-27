({
    fetchDocChk: function(component, recordId) {
        this.toggleSpinner(component);
        var action = component.get("c.fetchDocumentCheklists");
        action.setParams({
            "oppId": recordId
        });

        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var lstDocChk = response.getReturnValue();
                component.set("v.lstDocCheck", lstDocChk);
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

    toggleSpinner : function(component){
        var spinner = component.find("spinner");
        $A.util.toggleClass(spinner, "slds-hide");
    },
})