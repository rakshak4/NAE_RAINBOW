({
    init: function(component, event, helper) {
        helper.doInit(component, event);
    },
    refresh:function(component, event, helper){
        console.log('LC11 Refresh');
        helper.doInit(component, event);
    },
    saveOpp: function(component, event, helper) {
        console.log('LC11 saveOpp');
        var thisOpp = component.get("v.thisOpp");

        if(thisOpp == null || thisOpp == undefined){
            console.log('LC11 thisOpp: ' + thisOpp);
            return;
        }

        var action = component.get("c.saveDetails");
        action.setParams({"opp":thisOpp});
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                console.log('Saved successfully');
                $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(action);

    }
})