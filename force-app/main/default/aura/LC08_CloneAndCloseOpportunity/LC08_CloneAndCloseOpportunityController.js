({
	handleInit : function(component, event, helper){
        var oppId = component.get("v.recordId");
        component.set("v.showSpinner", true);
        helper.init(component, oppId);
	},

	handleClone: function(component, event, helper){
		var oppId = component.get("v.recordId");
        helper.cloneOpp(component, event, oppId);
	},

    handleCancel : function(component, event, helper) {
        helper.closePopUp();
    },

    handleDependentPicklist : function (component, event, helper){ //FKO20201118 - Case 2782
        var value = component.find("stage").get("v.value");
        component.set("v.Opp.StageName",value);
    },

    handleValuesLoaded : function (component, event, helper){ //VJA20201118 - Case 2782
        component.set("v.showSpinner", false);
    }

})