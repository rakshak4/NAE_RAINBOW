({
    viewContact: function(component, event, contactId) {
        var navEvent = $A.get("e.force:navigateToSObject");
        if (navEvent) {
            navEvent.setParams({
                "recordId": contactId
            });
            navEvent.fire();
        }
    }
    ,updatePrimary: function(component, lstFamily, accContId, isPrimary) {
        var primaryAccId = "";
        var primaryConId = "";
        var isPrimaryCounter = 0;
		console.log('lstFam');
        console.log(lstFamily);
        for (var i = 0; i < lstFamily.length; i++) {
            var family = lstFamily[i];
            if (family.accContId == accContId) {
                primaryAccId = family.accId;
                primaryConId = family.contId;
            }
        }

        for (var i = 0; i < lstFamily.length; i++) {
            var family = lstFamily[i]
            if (family.isPrimary)
                isPrimaryCounter++
        }

    	for (var i = 0; i < lstFamily.length; i++) {
    		var family = lstFamily[i];

            if(isPrimaryCounter <= 2 ) {
                if (family.accContId == accContId){
                    family.isPrimary = isPrimary;
                }
           
    	    }else{
                if(family.accContId == accContId)
                    family.isPrimary = false
            }
    	}

    	component.set("v.lstFamily", lstFamily);


        if(isPrimaryCounter == 1){
        //When there were two primary contacts, and one is removed..
        //parse in primary contact that remains not the one that was unchecked
            for (var i = 0; i < lstFamily.length; i++) {
            var family = lstFamily[i];
            if(family.isPrimary)
                primaryConId = family.contId;

             }
        }


        if(isPrimaryCounter <= 2){
        //Call APEX when No. of primary contacts is less or equal to 2 
            var action = component.get("c.updatePrimaryContact");
            action.setParams({
                "accId" : primaryAccId,
                "contId" : primaryConId,
                "isPrimaryCounter" : isPrimaryCounter,
            });

            action.setCallback(this, function(response){
                 if (response.getState() == "SUCCESS") {
                    var result = response.getReturnValue();
                    if (result.success) {
                        this.showToast('success', 'Primary contact has been updated.')
                        $A.get('e.force:refreshView').fire();
                    } else {
                        this.showToast('error', result.message);
                    }
                 }
            });

            $A.enqueueAction(action);
        }
    }

     ,updateFinancial: function(component, lstFamily, accContId, isFinancial) { //CRA20200723 - Comment due to Merge Functionality Non usage
        var primaryAccId = "";
        var primaryConId = "";
        var isFinancialCounter = 0;

        for (var i = 0; i < lstFamily.length; i++) {
            var family = lstFamily[i];
            if (family.accContId == accContId) {
                primaryAccId = family.accId;
                primaryConId = family.contId;
            }
        }

        for (var i = 0; i < lstFamily.length; i++) {
            var family = lstFamily[i]
            if (family.isFinancial)
                isFinancialCounter++
        }

        for (var i = 0; i < lstFamily.length; i++) {
            var family = lstFamily[i];

            if(isFinancialCounter <= 2 ) {
                if (family.accContId == accContId){
                    family.isFinancial = isFinancial;
                }
           
            }else{
                if(family.accContId == accContId)
                    family.isFinancial = false
            }
        }


        component.set("v.lstFamily", lstFamily);

        if(isFinancialCounter == 1){
        //When there were two Financial contacts, and one is removed..
        //pass in Financial contact that remains not the one that was unchecked
            for (var i = 0; i < lstFamily.length; i++) {
            var family = lstFamily[i];
            if(family.isFinancial)
                primaryConId = family.contId;

             }
        }

        if(isFinancialCounter <= 2){
            var action = component.get("c.updateFinancialContact");
            action.setParams({
                "accId" : primaryAccId,
                "contId" : primaryConId,
                "isFinancialCounter" : isFinancialCounter,
            });

            action.setCallback(this, function(response){
                 if (response.getState() == "SUCCESS") {
                    var result = response.getReturnValue();
                    if (result.success) {
                        this.showToast('success', 'Financial contact has been updated.')
                        $A.get('e.force:refreshView').fire();
                    } else {
                        this.showToast('error', result.message);
                    }
                 }
            });

            $A.enqueueAction(action);
        }
    }
    ,showToast : function(type, message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type": type,
            "title": type,
            "message": message
        });
        toastEvent.fire();
    }

    // ,updateFamilyContact: function(component, lstFamily, contId, isChecked) {
    //     var mergedAccId = "";
    //     var mergedConId = "";
    //     var mergedConId2 = "";
    //     var status = true;
    //     var isMergedCounter = 0;

    //     for (var i = 0; i < lstFamily.length; i++) {
    //         var family = lstFamily[i];
    //         if (family.contId == contId) {
    //             mergedAccId = family.accId;
    //             mergedConId = family.contId;
    //             console.log('mergedConId 1 ' +mergedConId);
    //             console.log('fname 1 ' +family.fname);
    //         }

    //         if (family.isMerged) {
    //             isMergedCounter ++;  
    //             if (family.contId != contId) {
    //                 mergedConId2 = family.contId;
    //                 console.log('mergedConId2 1 ' +mergedConId2);
                    
    //             console.log('fname 2 ' +family.fname);
    //             }             
    //         }
            
    //     }

    //     for (var i = 0; i < lstFamily.length; i++) {
    //         var family = lstFamily[i];

    //         if(isMergedCounter <= 2 ) {
    //             if (family.contId == contId){
    //                 family.isMerged = true;
    //                 if(isMergedCounter == 1){
    //                     mergedConId = family.contId;
    //                     //mergedConId2 = "";
    //                     if(!isChecked) {
    //                         status = false;
    //                         //mergedConId2 = contId;
    //                     }                      
    //                     console.log('mergedConId 2 ' +mergedConId);
    //                     console.log('mergedConId2 2 ' +mergedConId2);
    //                 }
                    
    //             }
    //             if (isMergedCounter == 0 && !isChecked) {
    //                 mergedConId = contId;
    //                 mergedConId2 = "";
    //                 mergedAccId = family.accId;
    //                 status = false;
    //                 console.log('mergedConId 3 ' +mergedConId);
    //                 console.log('mergedConId2 3 ' +mergedConId2);
    //             }
    //         }else{
    //             if(family.contId == contId) {
    //                 family.isMerged = false;
    //             }                   
    //         }
            
    //     }
    //     component.set("v.lstFamily", lstFamily);
    //     console.log('mergedConId ' +mergedConId);
    //     console.log('mergedConId2 ' +mergedConId2);
    //     console.log('status ' +status);

    //     if(isMergedCounter <= 2){
    //         var action = component.get("c.updateFamilyContact");
    //         action.setParams({
    //             "accId" : mergedAccId,
    //             "contId" : mergedConId,
    //             "contSecondId" : mergedConId2,
    //             "isMergedCounter" : isMergedCounter,
    //             "status" : status
    //         });

    //         action.setCallback(this, function(response){
    //              if (response.getState() == "SUCCESS") {
    //                 var result = response.getReturnValue();
    //                 if (result.success) {
    //                     if (status) {
    //                         this.showToast('success', 'Contact has been merged.');
    //                     }
    //                     else {
    //                         this.showToast('success', 'Contact has been unmerged.');
    //                     }
                        
    //                     $A.get('e.force:refreshView').fire();
    //                 } else {
    //                     this.showToast('error', result.message);
    //                 }
    //              }
    //         });

    //         $A.enqueueAction(action);
    //     }
    // }
})