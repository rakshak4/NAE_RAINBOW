({
    getDupes: function(component) {
        var recId = component.get("v.recordId");
        var action = component.get("c.getDuplicates");
        action.setParams({
            "recordId": recId
        });

        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                component.set("v.showSpinner", false);
                let lstDup = response.getReturnValue();
                 // console.log('### lstDup: ', lstDup);
                component.set("v.lstDupes", lstDup);
            } else {
                var errors = response.getError();
                console.log('errors: ', errors);
                this.handleErrors(errors);
            }
        });
        $A.enqueueAction(action);
    },

    handleErrors: function(errors) {
        // Configure error toast
        let toastParams = {
            title: "Error",
            message: "Unknown error", // Default error message
            type: "error"
        };
        // Pass the error message if any
        if (errors && Array.isArray(errors) && errors.length > 0) {
            toastParams.message = "";
            errors.forEach(function(error){
                toastParams.message += error.message + "\n";
                console.log("#### error.message:", error.message);
            });
        }
        // Fire error toast
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(toastParams);
        toastEvent.fire();
    },

    navigateToRecord: function(recordId) {
        var navEvent = $A.get("e.force:navigateToSObject");
        if (navEvent) {
            navEvent.setParams({
                "recordId": recordId
            });
            navEvent.fire();
        }
    }
})