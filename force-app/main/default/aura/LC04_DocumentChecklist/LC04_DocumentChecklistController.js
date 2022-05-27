({
    doInit: function(component, event, helper) {
        // console.log("### chklst component", component);
        component.set("v.displaySpinner", false);
        var recordId = component.get("v.recordId");
        helper.fetchDocChk(component, recordId);
    },

    refresh:function(component, event, helper){
        var recordId = component.get("v.recordId");
        helper.fetchDocChk(component, recordId);
    },

    gotoRelatedList: function(component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "DocumentChecklists__r",
            "parentRecordId": component.get("v.recordId")
        });
        relatedListEvent.fire();
    },

    spinnerChange: function(component, event, helper){
        helper.toggleSpinner(component);
    }

})