({
    doInit : function(component, event, helper) {
        window.open('/apex/vfp02_applicationform?Id='+component.get("v.recordId")+'&isHTML=true',  '_blank');
    },
    destroyMyself : function(component,event,helper){
    	var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    }
})