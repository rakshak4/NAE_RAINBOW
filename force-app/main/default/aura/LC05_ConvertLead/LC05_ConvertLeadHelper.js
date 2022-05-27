({
    handleClose: function() {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    },
    viewRecord: function(recId) {
        var navEvent = $A.get("e.force:navigateToSObject");
        if (navEvent) {
            navEvent.setParams({
                "recordId": recId
            });
            navEvent.fire();
        }
    },

    displayToast: function(title, message, type) {
        var toastEvent = $A.get("e.force:showToast");
        if (!$A.util.isUndefinedOrNull(toastEvent)) {
            toastEvent.setParams({
                "title": title,
                "message": message,
                "type": type
            });
            toastEvent.fire();
        }
    },

    handleErrors: function(errors) {
        // Configure error toast
        var toastParams = {
            title: "Error",
            message: "Unknown error", // Default error message
            type: "error"
        };
        // Pass the error message if any
        if (errors && Array.isArray(errors) && errors.length > 0) {
            toastParams.message = errors[0].message;
        }
        // Fire error toast
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(toastParams);
        toastEvent.fire();
    }
})