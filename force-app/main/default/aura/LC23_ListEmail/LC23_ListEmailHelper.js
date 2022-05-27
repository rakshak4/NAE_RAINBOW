({
    getEmailTempaltes : function(component, event) {
        var action = component.get("c.getTemplates");
        //action.setParams({"divisionId":selectedDivision});        
        action.setCallback(this, function(response){
            var loadResponse = response.getReturnValue();
            if(!$A.util.isEmpty(loadResponse)){                
                component.set('v.templates', loadResponse);                
            }
        });
        $A.enqueueAction(action);
    },
    sendEmails : function(component, event) {
        component.set("v.shoMsg", false);
        component.set("v.showLoader", true);
        var oppRecIds = [];
        var templateId = component.get("v.selTempl");
        oppRecIds = component.get("v.oppIds");
        oppRecIds = oppRecIds.split(",");
        var subjMatter = document.getElementById("subjMatter").value;
        var emailBody = !$A.util.isEmpty(component.get("v.Opportunity").SampleRichText__c) ? component.get("v.Opportunity").SampleRichText__c : '';
        if(!$A.util.isEmpty(oppRecIds) && (!$A.util.isEmpty(emailBody) || !$A.util.isEmpty(templateId)) ){
            if(!$A.util.isEmpty(oppRecIds)){
                
                var action = component.get("c.sendAnEmailMsg");
                action.setParams({"templateId": templateId,
                                  "opty":component.get("v.Opportunity"),
                                  "subj": !$A.util.isEmpty(subjMatter) ? subjMatter : '',
                                  "oppIds": oppRecIds });
                
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var emailMsgResp = response.getReturnValue();
                        console.log('--emailMsgResp--', emailMsgResp); //isSuccess  errMsg
                        component.set("v.showLoader", false);                        
                        if(emailMsgResp.isSuccess){
                            component.set("v.shwSucesMsg", true);
                            this.cancelAction(component, event);
                        }
                        else {
                            component.set("v.shoMsg", true);
                            component.set("v.errorMsg", emailMsgResp.errMsg);
                        }
                    }
                    else if (state === "ERROR") {
                        var errors = response.getError();
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                console.log("Error message: " + errors[0].message);
                            }
                        } else {
                            console.log("Unknown error");
                        }
                    }
                        else {
                            console.log('other error');
                        }
                });
                $A.enqueueAction(action);
            }
        }
        else {
            component.set("v.showLoader", false);
            component.set("v.shoMsg", true);
            component.set("v.errorMsg", "Please provide Recipient, Template or Email Body");
        }
        
    },
    getTemplate : function(component, event) {
        
        var templId = component.get("v.selTempl");
        component.set("v.showLoader", true);
        if(!$A.util.isEmpty(templId)){
            
            var action = component.get("c.getTemplateDetails");
            action.setParams({"templteId":templId});
            
            action.setCallback(this, function(response){
                component.set("v.showLoader", false);
                var responseVal = response.getReturnValue();
                console.log('responseVal..@getTemplate ',responseVal);
                
                if(!$A.util.isEmpty(responseVal)){
                    
                    component.set("v.templDetail", responseVal);
                    component.set("v.subjTxt", responseVal.Subject);
                    if(!$A.util.hasClass(component.find("emailBodyDiv"), "slds-hide")){
                        
                        $A.util.addClass(component.find("emailBodyDiv"), 'slds-hide'); 
                    }
                    
                }
            });
            $A.enqueueAction(action);
        }
        else {
            component.set("v.showLoader", false);
            if($A.util.hasClass(component.find("emailBodyDiv"), "slds-hide")){
                
                $A.util.removeClass(component.find("emailBodyDiv"), 'slds-hide');
            }
        }
    },
    cancelAction: function(component, event){
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": '/006/o'
        });
        urlEvent.fire();
    }
})