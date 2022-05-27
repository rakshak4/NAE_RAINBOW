({
    init : function(component, oppId){
        var getOpp = component.get("c.getOpp");
        getOpp.setParams({
            'oppId': oppId
        });

         getOpp.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                component.set('v.Opp', result.opp);
                component.set('v.lstLostReasons', result.lstLostReasons);
                var value = component.find("stage").get("v.value");
                component.set("v.Opp.StageName",value);
            }
        });
        $A.enqueueAction(getOpp);
    },

	closePopUp: function() {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    },

    cloneOpp: function(component, event, oppId) {
    	component.set("v.showSpinner", true);
        var opp = component.get("v.Opp");

        opp.StageName = component.find("stage").get("v.value");     //ANA20181207: Work-Item 495
        
        var cloneOpportunity = component.get("c.cloneOpportunity");
        cloneOpportunity.setParams({
        	'oppId': oppId, 'oldOpp' : opp, 'close' : true
        });

        cloneOpportunity.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                
                component.set("v.showSpinner", false);
                this.showToastMessage(result.type, result.type, result.message);

                if (result.type == 'success') {
                	this.viewOpp(event, result.cloneOppId);
                }
            }else{
                let errors = response.getError();
                let message = '';
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                this.showToastMessage('Error', 'Error', message);
                component.set("v.showSpinner", false);
            }
        });
        $A.enqueueAction(cloneOpportunity);
    },

    viewOpp: function(event, oppId) {
        var navEvent = $A.get("e.force:navigateToSObject");
        if (navEvent) {
            navEvent.setParams({
                "recordId": oppId
            });
            navEvent.fire();
        }
    },

    showToastMessage: function(messageTitle, messageType, messageText) {
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": messageTitle,
            "type": messageType,
            "message": messageText,
            "duration": (messageType === 'error' ? 10000 : 5000)
        });
        resultsToast.fire();
    }
})