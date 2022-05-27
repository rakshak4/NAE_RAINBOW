({
	handleInit : function(component, event, helper){
        var oppId = component.get("v.recordId");
        console.log('###OppId: ' + oppId);
        helper.init(component, oppId);
        
        console.log('from Lightning: ')
        console.log(component.get("v.setOppIds"))
	},

	handleClone: function(component, event, helper){
		var oppId = component.get("v.recordId");
        helper.cloneOpp(component, event, oppId);
		
	},

    handleCancel : function(component, event, helper) {
        helper.closePopUp();
    }
})