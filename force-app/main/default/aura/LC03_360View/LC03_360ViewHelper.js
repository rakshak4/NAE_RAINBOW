({
	doInit : function(component, recordId) {
		var action = component.get("c.getfamilyView");
		action.setParams({"recordId":recordId});

		action.setCallback(this, function(response){
			 if (response.getState() == "SUCCESS") {
			 	var familyView = response.getReturnValue();
			 	component.set("v.lstFamily", familyView.lstContacts);
			 	component.set("v.lstOpp", familyView.lstOpp);
			 	component.set("v.lstAcc", familyView.lstAcc);

			 //ANA20181312: Done to ease sorting of table in lstOppFamily 
			 	var lstOpp = familyView.lstOpp;
                console.log('##B1');
                //CRA20190412 Case 00001730
                if(lstOpp != null) {
                    for (var i = 0; i < lstOpp.length ; i++){
                    console.log('##B2');
                    if(lstOpp[i].Child__c != undefined && lstOpp[i].Child__c != '' && lstOpp[i].Child__c != 'undefined' && lstOpp[i].Child__c != null ){
                        console.log('##B3');
                        console.log(lstOpp[i].Child__c );
                        if (lstOpp[i].Child__r != undefined && lstOpp[i].Child__r != null && lstOpp[i].Child__r.Birthdate != undefined){
                        //if (lstOpp[i].Child__r.Birthdate != undefined){
                            console.log('##B4');
                            lstOpp[i].DOB = lstOpp[i].Child__r.Birthdate;
                            console.log('##B5');
                        }else{
                            lstOpp[i].DOB = "";
                        }
                        if(lstOpp[i].YearGrade__r != null){
                              lstOpp[i].YearGrade = lstOpp[i].YearGrade__r.Name;
                        }else{
                           lstOpp[i].YearGrade = ""; 
                        }
                        
                        if(lstOpp[i].ReferredBy__r != null){
                                lstOpp[i].ReferredBy = lstOpp[i].ReferredBy__r.Name;
                        }else{
                             lstOpp[i].ReferredBy = "";
                        }
                           
                    }   
                    
                }
                component.set("v.lstOpp", lstOpp)
                
             }
         }
		        
		});

		$A.enqueueAction(action);
	}
})