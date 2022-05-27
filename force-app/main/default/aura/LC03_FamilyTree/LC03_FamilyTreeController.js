({ 
    doInit: function(component, event) {
        var action = component.get("c.getProfileInfo");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == "SUCCESS" && component.isValid()){
                console.log("success") ;
                var result = response.getReturnValue();
                component.set("v.show", result);
        
            }else{
                console.error("fail:" + response.getError()[0].message); 
            }
        });
        $A.enqueueAction(action);
    }
    ,handleClick: function(component, event, helper) {
        var contactId = event.target.getAttribute("data-contact");
        helper.viewContact(component, event, contactId);
    }
    ,handlePrimaryContact : function(component, event, helper) {
        console.log("#######")
    	var lstFamily = component.get("v.lstFamily");
                console.log("lstFamily: ", lstFamily)
    	var accContId = event.getSource().get("v.text");  
    	var isPrimary = event.getSource().get("v.value"); 

        helper.updatePrimary(component, lstFamily, accContId, isPrimary);
    }
    ,handleFinancialContact : function(component, event, helper) {
        var lstFamily = component.get("v.lstFamily");
        var accContId = event.getSource().get("v.text");  
        var isFinancial = event.getSource().get("v.value"); 

        helper.updateFinancial(component, lstFamily, accContId, isFinancial);
    }  
    // ,handleMergeContact : function (component, event, helper) { //CRA20200723 - Comment due to Merge Functionality Non usage
    //     var lstFamily = component.get("v.lstFamily");
    //     var contId = event.getSource().get("v.text");  
    //     var isChecked = event.getSource().get("v.value"); 

    //     helper.updateFamilyContact(component, lstFamily, contId, isChecked);
    // }
})