({
    handleOpenChecklist: function(component, event, helper) {
        var checklistId = component.get("v.docCheck").Id;
        helper.viewChecklist(component, event, checklistId);
    },

    displayDatePicker: function(component, event, helper) {
        var output = component.find("outputDate").getElement("div");
        var input = component.find("inputDate").getElement("div");
        $A.util.addClass(output, "slds-hide");
        $A.util.removeClass(input, "slds-hide");
    },

    hideDatePicker: function(component, event, helper) {
        var output = component.find("outputDate").getElement("div");
        var input = component.find("inputDate").getElement("div");
        $A.util.removeClass(output, "slds-hide");
        $A.util.addClass(input, "slds-hide");
    },

    saveDate: function(component, event, helper) {
        var docChk = component.get("v.docCheck");

        if ($A.util.isEmpty(docChk.DateReceived__c)) {
            docChk.DateReceived__c = null;
            docChk.Status__c = "Requested";
        } else {
            docChk.Status__c = "Received";
        }
        console.log('### lstDocCheck[i] ', JSON.stringify(docChk));
        helper.saveDocChklst(component);
        // component.set("v.docCheck", docChk);

    },

    handleStatusChange: function(component, event, helper) {
        var today = new Date();
        today = $A.localizationService.formatDate(today, "YYYY-MM-DD");
        var docChk = component.get("v.docCheck");
        if (docChk.Status__c == "Requested") {
            docChk.Status__c = "Received";
            docChk.DateReceived__c = today;
        } else {
            docChk.DateReceived__c = null;
            docChk.Status__c = "Requested";
        }
        helper.saveDocChklst(component);
    },
})