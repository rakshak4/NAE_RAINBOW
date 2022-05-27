({
    doInit: function(component, event, helper) {
        helper.getDupes(component);
    },

    handleClick: function (component, event, helper) {
        var recId = event.target.getAttribute("data-recId");
        helper.navigateToRecord(recId);
    }
})