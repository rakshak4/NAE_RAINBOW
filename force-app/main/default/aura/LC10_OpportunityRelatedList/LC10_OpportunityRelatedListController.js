({
    doInit: function(component, event, helper) {
        helper.doInit(component);
    },
    handleSelectEditDelete: function (component, event, helper) {
        var parcedValue = event.getParam("value").split(',');
		var oppId = parcedValue[0];
		var operation = parcedValue[1];

		switch (operation){
	      case "Edit": 
	      	helper.doEdit(oppId); 
	      	break;
	      case "Delete": 
	      	helper.doDelete(component, oppId); 
	      	break;
	    }

    },
    gotToRelatedOppList: function (component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "Opportunities__r",
            "parentRecordId": component.get("v.recordId")
        });
        relatedListEvent.fire();
    },  
    handleSelectNew: function(component, event, helper){
        var recName = event.getParam("value");
        helper.doNew(component, recName);
    }  
})