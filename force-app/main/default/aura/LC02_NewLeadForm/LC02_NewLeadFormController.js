({
    init: function(component, event, helper) {
        helper.doInit(component);
        helper.setRecordTypeName(component);
    }

    ,
    handleCountryChangeParent1: function(component, event, helper) {
        var mapCountry = component.get("v.mapCountry");
        var lead = component.get("v.lead");

        if (mapCountry != null) {
            var phoneCode = mapCountry[lead.Parent1CountryOfResidence__c];

            if (phoneCode != undefined && phoneCode != null) {
                component.find("Parent1HomePhone__c").set("v.placeholder", phoneCode);
            }
        }
    }

    ,
    handleCountryChangeParent2: function(component, event, helper) {
        var mapCountry = component.get("v.mapCountry");
        var lead = component.get("v.lead");

        if (mapCountry != null) {
            var phoneCode = mapCountry[lead.Parent2CountryOfResidence__c];
            if (phoneCode != undefined && phoneCode != null) {
                component.find("Parent2HomePhone__c").set("v.placeholder", phoneCode);
            }
        }
    }

    ,

    populateParent1Phone: function(component, event, helper){
        var mapCountry = component.get("v.mapCountry");
        var lead = component.get("v.lead");
        if (mapCountry != null) {
            var phoneCode = mapCountry[lead.Parent1CountryOfResidence__c];
            if (phoneCode != undefined && phoneCode != null) {
                if($A.util.isEmpty(lead.Parent1HomePhone__c)){
                    lead.Parent1HomePhone__c = phoneCode;
                    component.set("v.lead", lead);
                }
            }
        }
    }
    ,
    populateParent2Phone: function(component, event, helper){
        var mapCountry = component.get("v.mapCountry");
        var lead = component.get("v.lead");
        if (mapCountry != null) {
            var phoneCode = mapCountry[lead.Parent2CountryOfResidence__c];
            if (phoneCode != undefined && phoneCode != null) {
                if($A.util.isEmpty(lead.Parent2HomePhone__c)){
                    lead.Parent2HomePhone__c = phoneCode;
                    component.set("v.lead", lead);
                }
            }
        }
    }
    ,

    validateParent2Phone: function(component, event, helper){
        var mapCountry = component.get("v.mapCountry");
        var lead = component.get("v.lead");
        if (mapCountry != null) {
            var phoneCode = mapCountry[lead.Parent2CountryOfResidence__c];
            if (phoneCode != undefined && phoneCode != null) {
                if(lead.Parent2HomePhone__c == phoneCode){
                    lead.Parent2HomePhone__c = null;
                    component.set("v.lead", lead);
                }
            }
        }
    },

    validateParent1Phone: function(component, event, helper){
        var mapCountry = component.get("v.mapCountry");
        var lead = component.get("v.lead");
        if (mapCountry != null) {
            var phoneCode = mapCountry[lead.Parent1CountryOfResidence__c];
            if (phoneCode != undefined && phoneCode != null) {
                if(lead.Parent1HomePhone__c == phoneCode){
                    lead.Parent1HomePhone__c = null;
                    component.set("v.lead", lead);
                }
            }
        }
    },

    handleChangeSource: function(component, event, helper) {
        var lead = component.get("v.lead");
        var source = component.find("LeadSource").get("v.value");
        var mapDepPicklist = component.get("v.mapDepPicklist");
        var lstSubSrc = mapDepPicklist[source];

        //if (lstSubSrc !== undefined) {
            //lead.LeadSubSource__c = lstSubSrc[lstSubSrc.length - 1];
        //}
        if (lstSubSrc === undefined) {
            lead.LeadSubSource__c = null;
            lstSubSrc = [];
        }
        component.set("v.lstSubSource", lstSubSrc);
        component.set("v.lead", lead);
    }

    ,
    updateRelationship: function(component, event, helper) {
        var lead = component.get("v.lead");

        // VJA

        /*if (lead.Parent1NatureOfRelationship__c != 'Other') {
            lead.Parent1OtherRelationship__c = '';
        }

        if (lead.Parent2NatureOfRelationship__c != 'Other') {
            lead.Parent2OtherRelationship__c = '';
        }
        component.set("v.lead", lead);*/
       
        //ANA20191701: W459
        component.set("v.Required", (lead.Parent1NatureOfRelationship__c == 'Agent' || lead.Parent1NatureOfRelationship__c == 'Child' ) ? false : true);
        component.set("v.sldsRequired", lead.Parent1NatureOfRelationship__c == 'Agent' || lead.Parent1NatureOfRelationship__c == 'Child' ? "slds-required" : "slds-hide");
        component.set("v.sldsRequired2", (lead.Parent1NatureOfRelationship__c == 'Agent' || lead.Parent1NatureOfRelationship__c == 'Child' ) ? "slds-required" : "slds-hide");
        component.set("v.Required2", (lead.Parent1NatureOfRelationship__c == 'Agent' || lead.Parent1NatureOfRelationship__c == 'Child' ) ? false : true); 
        component.set("v.Required3", (lead.Parent1NatureOfRelationship__c == 'Agent' || lead.Parent1NatureOfRelationship__c == 'Child' ) ? true : false); 
        if(lead.Parent1NatureOfRelationship__c != 'Agent' && lead.Parent1NatureOfRelationship__c != 'Child'){
            component.set("v.Required", lead.Status == 'New' ? false : true);
            component.set("v.Required3", lead.Status == 'New' ? false : true);
            component.set("v.sldsRequired", lead.Status == 'New' ? "slds-hide" : "slds-required");
            component.set("v.sldsRequired2", lead.Status == 'New' ? "slds-hide" : "slds-required");
            console.log("StatusChanged");  
        }
    
    },
    
    statusChanged: function(component, event, helper) {
        var lead = component.get("v.lead");
        console.log(lead.Status);
        if(lead.Parent1NatureOfRelationship__c != 'Agent' && lead.Parent1NatureOfRelationship__c != 'Child'){
            component.set("v.Required", lead.Status == 'New' ? false : true);
            component.set("v.Required3", lead.Status == 'New' ? false : true);
            component.set("v.sldsRequired", lead.Status == 'New' ? "slds-hide" : "slds-required");
            component.set("v.sldsRequired2", lead.Status == 'New' ? "slds-hide" : "slds-required");
            console.log("StatusChanged");  
        }

    },
    
    updateChild: function(component, event, helper) {
        var lead = component.get("v.lead");
        var numChild = lead.number_of_children__c;

        var child1active = component.get("v.child1active");
        var child2active = component.get("v.child2active");
        var child3active = component.get("v.child3active");
        var child4active = component.get("v.child4active");
        var child5active = component.get("v.child5active");
        //var child6active = component.get("v.child6active");

        if (numChild == 1) {
            helper.updateChildVisibility(component, true, false, false, false, false, false);
            helper.removeChild2(component, lead);
            helper.removeChild3(component, lead);
            helper.removeChild4(component, lead);
            helper.removeChild5(component, lead);
            //helper.removeChild6(component, lead);
        } else if (numChild == 2) {
            helper.updateChildVisibility(component, true, true, false, false, false, false);
            helper.removeChild3(component, lead);
            helper.removeChild4(component, lead);
            helper.removeChild5(component, lead);
            //helper.removeChild6(component, lead);
        } else if (numChild == 3) {
            helper.updateChildVisibility(component, true, true, true, false, false, false);
            helper.removeChild4(component, lead);
            helper.removeChild5(component, lead);
            //helper.removeChild6(component, lead);
        } else if (numChild == 4) {
            helper.updateChildVisibility(component, true, true, true, true, false, false);
            helper.removeChild5(component, lead);
            //helper.removeChild6(component, lead);
        } else if (numChild == 5) {
            helper.updateChildVisibility(component, true, true, true, true, true, false);
            //helper.removeChild6(component, lead);
        } //else if (numChild == 6) {
            //helper.updateChildVisibility(component, true, true, true, true, true, true);
        //}
    }

    ,
    copyPhone: function(component, event, helper) {
        var lead = component.get("v.lead");
        lead.Parent2HomePhone__c = lead.Parent1HomePhone__c;
        component.set("v.lead", lead);
    }

    ,
    copyLastName: function(component, event, helper) {
        var lead = component.get("v.lead");
        lead.Parent2LastName__c = lead.Parent1LastName__c;
        component.set("v.lead", lead);
    }

    ,
    copyNationality: function(component, event, helper) {
        var lead = component.get("v.lead");
        lead.Parent2Nationality__c = lead.Parent1Nationality__c;
        component.set("v.lead", lead);
    }

    ,
    copyPrimaryEmail: function(component, event, helper) {
        var lead = component.get("v.lead");
        lead.Parent2PrimaryEmail__c = lead.Parent1PrimaryEmail__c;
        component.set("v.lead", lead);
    }

    //VJA
    /*,
    copySecondaryEmail: function(component, event, helper) {
        var lead = component.get("v.lead");
        lead.Parent2SecondaryEmail__c = lead.Parent1SecondaryEmail__c;
        component.set("v.lead", lead);
    }*/

    ,
    copyAddress: function(component, event, helper) {
        var lead = component.get("v.lead");
        lead.Parent2Street__c = lead.Parent1Street__c;
        //fkh Case 3374
        lead.Parent2AddLine2__c=lead.Parent1AddLine2__c;
        lead.Parent2AddLine3__c=lead.Parent1AddLine3__c;

        lead.Parent2City__c = lead.Parent1City__c;
        lead.Parent2State__c = lead.Parent1State__c;
        lead.Parent2ZipPostalCode__c = lead.Parent1ZipPostalCode__c;
        lead.Parent2CountryOfResidence__c = lead.Parent1CountryOfResidence__c;
        component.set("v.lead", lead);
        helper.popParent2(component);
    }

    ,
    save: function(component, event, helper) {
        component.set("v.showSpinner", true);
        var lead = component.get("v.lead");
        console.log('### lead',JSON.stringify(lead));

        helper.capitalizeAll(component);
        var errors = helper.validateFields(lead);

        var unsaved = component.find("unsaved");

        if (errors.length > 0) {
            component.set("v.showSpinner", false);
            for (var i = 0; i < errors.length; i++) {
                helper.showToastMessage('ERROR', 'error', errors[i].message);
                unsaved.setUnsavedChanges(true);
            }
        } else {
            helper.updateLeadToSave(component, lead, event);  
            unsaved.setUnsavedChanges(false);  
        }
    },
    cancel: function(component, event, helper) {
        var unsaved = component.find('unsaved');
        unsaved.setUnsavedChanges(false);
        helper.closeFocusedTab(component, event);
    }

    ,

    //CRA20190611 - W-000518
    valueChanged : function(component, event, helper) {
        var unsaved = component.find("unsaved");
        unsaved.setUnsavedChanges(true, { label: 'New Lead' });
    }
    
})