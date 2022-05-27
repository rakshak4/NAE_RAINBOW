({
	doInit : function(component, event) {
        console.log('LC11 doinit');
        var recordId = component.get("v.recordId");
        
        if(recordId == null || recordId == undefined){
            console.log('LC11 recId: ' + recordId);
            return;
        }

        var action = component.get("c.getDetails");
        action.setParams({"oppId":recordId});
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var opp = response.getReturnValue();

                if(opp == null || opp == undefined){
                    console.log('LC11 result: ' + opp);
                    return ;
                }

                if(opp.SchoolOfInterest__c == null ||opp.SchoolOfInterest__c == '' || opp.SchoolOfInterest__c == undefined || opp.SchoolOfInterest__c == 'undefined'){
                    component.set("v.region", '');
                }
                else{
                    component.set("v.region", opp.SchoolOfInterest__r.Region__c); 
                }
                
                component.set("v.thisOpp", opp);
            }
        });
        $A.enqueueAction(action);
        
	}
})