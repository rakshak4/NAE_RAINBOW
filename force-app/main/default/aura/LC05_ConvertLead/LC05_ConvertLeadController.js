({
    handleConvert: function(component, event, helper) {
        component.find("btnCancel").set("v.disabled", true);
        component.find("btnConvert").set("v.disabled", true);
        component.set("v.showSpinner", true);
        var ledId = component.get("v.recordId");
        var action = component.get("c.convertLead");
        action.setParams({
            "ledId": ledId
        });

        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                component.set("v.showSpinner", false);
                component.find("btnCancel").set("v.disabled", false);
                component.find("btnConvert").set("v.disabled", false);
                var accId = response.getReturnValue();
                helper.viewRecord(accId);
                helper.displayToast("Success!", 'Lead converted successfully!', "success");
            } else {
                component.set("v.showSpinner", false);
                component.find("btnCancel").set("v.disabled", false);
                component.find("btnConvert").set("v.disabled", false);
                var errors = response.getError();
                console.log('errors: ', errors);
                helper.handleErrors(errors);
            }
            helper.handleClose();
        });
        $A.enqueueAction(action);
    },

    handleCancel: function(component, event, helper) {
        helper.handleClose();
    }
})