({
    doInit: function(component) {
        component.set("v.showSpinner", true);
        component.set("v.isLoaded", false);
        var action = component.get("c.getDetails");
        var user;
        
        
        component.set("v.Required", false );
        component.set("v.Required3",false );
        component.set("v.sldsRequired", "slds-hide");
        component.set("v.sldsRequired2", "slds-hide");
        console.log("StatusChanged");

        action.setCallback(this, function(response) {
             console.log('response ' + response.getState());

            if (response.getState() == "SUCCESS") {
                var mapDetails = response.getReturnValue();

                if (mapDetails.success) {
                    mapDetails.lead.sObjectType = 'Lead';

                    console.log('#### mapDetails', mapDetails);
                    console.log('#### component', component);

                    component.set("v.lead", mapDetails.lead);
                    component.set("v.mapCountry", mapDetails.mapCountry);
                    component.set("v.mapPicklist", mapDetails.mapPickList);
                    component.set("v.lstMethod", mapDetails.mapPickList.LeadMethod__c);
                    component.set("v.lstDayBoarding", mapDetails.mapPickList.DayOrBoardingSchoolFirstChild__c); //cra20190603-W000535
                    component.set("v.lstCampus", mapDetails.mapPickList.Campus__c); //CRA20200324 - Case 00002295
                    component.set("v.mapDepPicklist", mapDetails.mapDepPicklist);
                    component.set("v.isVisible", mapDetails.fieldVisible);
                    //VJA component.set("v.interestOptions", mapDetails.lstInterest);
                    component.set("v.isLoaded", true);
                    component.find("ownerLookup").set("v.value", mapDetails.userDetail.label);
                    component.set("v.dayBoardingDefaulted" , mapDetails.dayBoarding);
                    // //CRA20191210
                    // var leadMethod = mapDetails.mapPickList.LeadMethod__c;
                    // if (leadMethod != null && leadMethod != undefined) {
                    //     component.find("LeadMethod__c").set("v.value", leadMethod[0]);
                    // }
                    //console.log('picklist '+JSON.stringify(mapDetails.mapPickList.LeadMethod__c));
                    //console.log('Interestpicklist '+JSON.stringify(mapDetails.lstInterest));
                } else{
                    console.log('error '+mapDetails.message);
                }
                component.set("v.showSpinner", false);
            }
        });
        

        $A.enqueueAction(action)
    },
    updateLeadToSave: function(component, lead, event) {
        lead.Parent1LastName__c = (component.get("v.lead.Parent1NatureOfRelationship__c") == 'Agent' || component.get("v.lead.Parent1NatureOfRelationship__c") == 'Child') ? component.get("v.lead.LastNameFirstChild__c") : component.get("v.lead.Parent1LastName__c"); //ANA20191501: W459
        lead.ReferredBy__r = null;
        lead.ReferredByContact__r = null;
        lead.SchoolOfInterest__r = null;
        //CRA 20181206:W-000465 
        lead.ExpectedYearGradeFirstChild__r = null;
        lead.ExpectedYearGradeSecondChild__r = null;
        lead.ExpectedYearGradeThirdChild__r = null;
        lead.ExpectedYearGradeFourthChild__r = null;
        lead.ExpectedYearGradeFifthChild__r = null;
        //lead.ExpectedYearGradeSixthChild__r = null;
        //End CRA 20181206:W-000465 
        lead.Owner = null;
        //VJA lead.InterestsFirstChild__c = component.find("interest1").get("v.value");
        //VJA lead.InterestsSecondChild__c = component.find("interest2").get("v.value");
        //VJA lead.InterestsThirdChild__c = component.find("interest3").get("v.value");
        //VJA lead.InterestsFourthChild__c = component.find("interest4").get("v.value");
        //VJA lead.InterestsFifthChild__c = component.find("interest5").get("v.value");
        //lead.InterestsSixthChild__c = component.find("interest6").get("v.value");

        var numChild = lead.number_of_children__c;

        if (numChild == 1) {
            lead.MarketingQualifiedSecondChild__c = null;
            lead.MarketingQualifiedThirdChild__c = null;
            lead.MarketingQualifiedFourthChild__c = null;
            lead.MarketingQualifiedFifthChild__c = null;
            //lead.MarketingQualifiedSixthChild__c = null;
        }

        if (numChild == 2) {
            lead.MarketingQualifiedThirdChild__c = null;
            lead.MarketingQualifiedFourthChild__c = null;
            lead.MarketingQualifiedFifthChild__c = null;
            //lead.MarketingQualifiedSixthChild__c = null;
        }

        if (numChild == 3) {
            lead.MarketingQualifiedFourthChild__c = null;
            lead.MarketingQualifiedFifthChild__c = null;
            //lead.MarketingQualifiedSixthChild__c = null;
        }

        if (numChild == 4) {
            lead.MarketingQualifiedFifthChild__c = null;
            //lead.MarketingQualifiedSixthChild__c = null;
        }

        //if (numChild == 5) {
            //lead.MarketingQualifiedSixthChild__c = null;
        //}
		
        var url_string = window.location.href;
        var recordTypeId = url_string.substring(url_string.indexOf("recordTypeId") + 13,url_string.indexOf("recordTypeId") + 28);

        var doSave = component.get("c.saveLead");
        doSave.setParams({
            'lead': lead,
            'RecordTypeId' : recordTypeId
        });

        doSave.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                var messageTitle = result.type.toUpperCase();

                component.set("v.showSpinner", false);

                this.showToastMessage(messageTitle, result.type, result.message);

                if (result.type == "success") {
                    this.closeFocusedTab(component, event);
                    this.focusNewTab(component, event, result.leadId);
                }
            }
        });

        $A.enqueueAction(doSave);
    },

    focusNewTab: function(component, event, leadId) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.openTab({
                url: '/lightning/r/Lead/' + leadId + '/view',
                label: 'Global Media'
            }).then(function(response) {
                workspaceAPI.focusTab({
                    tabId: response
                });
            })
            .catch(function(error) {
                console.log(error);
            });
    },

    viewLead: function(component, event, leadId) {
        var navEvent = $A.get("e.force:navigateToSObject");
        if (navEvent) {
            navEvent.setParams({
                "recordId": leadId
            });
            navEvent.fire();

        }
    },

    closeFocusedTab: function(component, event) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getFocusedTabInfo().then(function(response) {
                var focusedTabId = response.tabId;
                workspaceAPI.closeTab({
                    tabId: focusedTabId
                });
            })
            .catch(function(error) {
                console.log(error);
            });
    },

    popParent2: function(component) {
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
    updateChildVisibility: function(component, child1active, child2active, child3active, child4active, child5active) {
        component.set("v.child1active", child1active);
        component.set("v.child2active", child2active);
        component.set("v.child3active", child3active);
        component.set("v.child4active", child4active);
        component.set("v.child5active", child5active);
        //component.set("v.child6active", child6active);
    },
    removeChild2: function(component, lead) {
        lead.FirstNameSecondChild__c = null;
        lead.DateOfBirthSecondChild__c = null;
        lead.LastNameSecondChild__c = null;
        lead.NationalitySecondChild__c = null;
        lead.GenderSecondChild__c = null;
        lead.EnrollmentDateSecondChild__c = null;
        lead.Preferred_Name_Second_Child__c = null;
        lead.MarketingQualifiedSecondChild__c = true;
        //VJA lead.LanguageSkillsSecondChild__c = null;
        //VJA lead.InterestsSecondChild__c = null;
        lead.Child_2_Notes__c = null;
        lead.Native_Language_of_Second_Child__c = null;
        lead.ExpectedYearGradeSecondChild__c = null;
        //VJA lead.EthnicitySecondChild__c = null;
        //CRA 20181206:W-000465 
        lead.ExpectedStartYearSecondChild__c = null;
        //End CRA 20181206:W-000465 
        //VJA component.find("interest2").set("v.value", null);
        component.set("v.lead", lead);
    },
    removeChild3: function(component, lead) {
        lead.FirstNameThirdChild__c = null;
        lead.DateOfBirthThirdChild__c = null;
        lead.LastNameThirdChild__c = null;
        lead.NationalityThirdChild__c = null;
        lead.GenderThirdChild__c = null;
        lead.EnrollmentDateThirdChild__c = null;
        lead.Preferred_Name_Third_Child__c = null;
        lead.MarketingQualifiedThirdChild__c = true;
        //VJA lead.LanguageSkillsThirdChild__c = null;
        //VJA lead.InterestsThirdChild__c = null;
        lead.Child_3_Notes__c = null;
        //VJA lead.EthnicityThirdChild__c = null;
        lead.Native_Language_of_Third_Child__c = null;
        lead.DayOrBoardingSchoolThirdChild__c = null;
        //CRA 20181206:W-000465 
        lead.ExpectedStartYearThirdChild__c = null;
        //End CRA 20181206:W-000465 
        //VJA component.find("interest3").set("v.value", null);
        component.set("v.lead", lead);
    },
    removeChild4: function(component, lead) {
        lead.FirstNameFouthChild__c = null;
        lead.DateOfBirthFourthChild__c = null;
        lead.LastNameFourthChild__c = null;
        lead.NationalityFourthChild__c = null;
        lead.GenderFourthChild__c = null;
        lead.EnrollmentDateFourthChild__c = null;
        lead.Preferred_Name_Fourth_Child__c = null;
        lead.MarketingQualifiedFourthChild__c = true;
        //VJA lead.LanguageSkillsFourthChild__c = null;
        //VJA lead.InterestsFourthChild__c = null;
        lead.Child_4_Notes__c = null;
        //VJA lead.EthnicityFourthChild__c = null;
        lead.DayOrBoardingSchoolFourthChild__c = null;
        lead.Native_Language_of_Fourth_Child__c = null;
        //CRA 20181206:W-000465 
        lead.ExpectedYearGradeFourthChild__c = null;
        //End CRA 20181206:W-000465 
        //VJA component.find("interest4").set("v.value", null);
        component.set("v.lead", lead);
    },
    removeChild5: function(component, lead) {
        lead.FirstNameFifthChild__c = null;
        lead.DateOfBirthFifthChild__c = null;
        lead.LastNameFifthChild__c = null;
        lead.NationalityFifthChild__c = null;
        lead.GenderFifthChild__c = null;
        lead.EnrollmentDateFifthChild__c = null;
        lead.Preferred_Name_Fifth_Child__c = null;
        lead.MarketingQualifiedFifthChild__c = true;
        //VJA lead.LanguageSkillsFifthChild__c = null;
        //VJA lead.InterestsFifthChild__c = null;
        lead.Child_5_Notes__c = null;
        //VJA lead.EthnicityFifthChild__c = null;
        lead.DayOrBoardingSchoolFifthChild__c = null;
        lead.Native_Language_of_Fifth_Child__c = null;
        //CRA 20181206:W-000465 
        lead.ExpectedYearGradeFifthChild__c = null;
        //End CRA 20181206:W-000465 
        //VJA component.find("interest5").set("v.value", null);
        component.set("v.lead", lead);
    },
    /*removeChild6: function(component, lead) {
        lead.FirstNameSixthChild__c = null;
        lead.DateOfBirthSixthChild__c = null;
        lead.LastNameSixthChild__c = null;
        lead.NationalitySixthChild__c = null;
        lead.GenderSixthChild__c = null;
        lead.EnrollmentDateSixthChild__c = null;
        lead.Preferred_Name_Sixth_Child__c = null;
        lead.MarketingQualifiedSixthChild__c = true;
        lead.LanguageSkillsSixthChild__c = null;
        lead.InterestsSixthChild__c = null;
        lead.Child_6_Notes__c = null;
        lead.Native_Language_of_Sixth_Child__c = null;
        lead.EthnicitySixthChild__c = null;
        lead.DayOrBoardingSchoolSixthChild__c = null;
        //CRA 20181206:W-000465 
        lead.ExpectedYearGradeSixthChild__c = null;
        //End CRA 20181206:W-000465 
        component.find("interest6").set("v.value", null);
        component.set("v.lead", lead);
    },*/
    showToastMessage: function(messageTitle, messageType, messageText) {
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": messageTitle,
            "type": messageType,
            "message": messageText,
            "duration": (messageType === 'error' ? 10000 : 5000)
        });
        resultsToast.fire();
    },

    validateFields: function(lead) {
        var errors = [];

        function error(field, message) {
            this.field = field;
            this.message = message;
        }

        //validate lead system fields
        if ($A.util.isEmpty(lead.Status)) {
            errors.unshift(new error('Status', 'Please enter Lead Status'));
        }
		//afo added
        if(lead.Status == 'New' && lead.Parent1NatureOfRelationship__c != 'Agent' && lead.Parent1NatureOfRelationship__c != 'Child'){ // AFO
            if ($A.util.isEmpty(lead.Parent1Title__c)) {
                errors.unshift(new error('Contact 1 Title', 'Please enter Contact 1 Title'));
            }
            if ($A.util.isEmpty(lead.Parent1LastName__c)) {
                errors.unshift(new error('Contact 1 Last Name', 'Please enter Contact 1 Last Name'));
            }
            if ($A.util.isEmpty(lead.Parent1PrimaryEmail__c) && $A.util.isEmpty(lead.Parent1HomePhone__c)) {
                errors.unshift(new error('Contact 1 Primary Email/Phone', 'Please enter Contact 1 Primary Email / Phone'));
            }
        }
		
        //Contact1
        if(lead.Status != 'New'){ // AFO
            if(lead.Parent1NatureOfRelationship__c != 'Agent' && lead.Parent1NatureOfRelationship__c != 'Child'){ //ANA20191701 : W459 
                var regex = RegExp('^(\\+?\\d{1,3})((( |-)?\\d){1,15})$');
                //validate lead contact fields
                if ($A.util.isEmpty(lead.Parent1Title__c)) {
                    errors.unshift(new error('Contact 1 Title', 'Please enter Contact 1 Title'));
                }
                
                if ($A.util.isEmpty(lead.Parent1FirstName__c)) {
                    errors.unshift(new error('Contact 1 First Name', 'Please enter Contact 1 First Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.Parent1FirstName__c) ) {
                //         errors.unshift(new error('Contact 1 First Name', 'Contact 1 First Name can only contain text'));   
                //     }
                // }
                if ($A.util.isEmpty(lead.Parent1LastName__c)) {
                    errors.unshift(new error('Contact 1 Last Name', 'Please enter Contact 1 Last Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.Parent1LastName__c) ) {
                //         errors.unshift(new error('Contact 1 Last Name', 'Contact 1 Last Name can only contain text'));   
                //     }
                // }
                // if ($A.util.isEmpty(lead.Parent1Nationality__c)) {
                //     errors.unshift(new error('Contact 1 Nationality', 'Please enter Contact 1 Nationality'));
                // }
                
                //if ($A.util.isEmpty(lead.Parent1CountryOfResidence__c) && lead.LeadSource != 'External Relationships') {
                //   errors.unshift(new error('Contact 1 Country', 'Please enter Contact 1 Country'));
                //}
                if(lead.Status != 'New'){ // AFO
                    if ($A.util.isEmpty(lead.Parent1PrimaryEmail__c) && $A.util.isEmpty(lead.Parent1HomePhone__c) && lead.LeadSource != 'External Relationships') {
                        errors.unshift(new error('Contact 1 Primary Email/Home Phone', 'Please enter Contact 1 Primary Email / Home Phone'));
                    }
                    if (!$A.util.isEmpty(lead.Parent1HomePhone__c)) {
                        if (!regex.test(lead.Parent1HomePhone__c)) {
                            errors.unshift(new error('Contact 1 Primary Email/Home Phone', 'Please enter a valid Contact 1 Home Phone Ex:+852 9999-9999'));
                        }
                    }
                }
            }
        }
        
        //check contact 1 Preferred name fields
        // if (/[0-9]/.test(lead.Parent1PreferredName__c) ) {
        //     errors.unshift(new error('Contact 1 Preferred Name', 'Contact 1 Preferred Name can only contain text'));   
        // }
        
        //Contact1 - ANA20191501 : W-459
       // if(lead.Status != 'New'){ // AFO
            if(lead.Parent1NatureOfRelationship__c == 'Agent'){
                console.log('Lead.Parent1NatureOfRelationship: ', lead.Parent1NatureOfRelationship__c);
                if($A.util.isEmpty(lead.ReferredBy__c)) {
                    errors.unshift(new error('Referred By (Account)', 'Referred By (Account) is mandatory when Nature of Relationship of Contact 1 is Agent'));
                }
                if($A.util.isEmpty(lead.ReferredByContact__c)) {
                    errors.unshift(new error('Referred By (Contact)', 'Referred By (Contact) is mandatory when Nature of Relationship of Contact 1 is Agent'));
                }   
            }
      //  }
            

        //Contact2
        if(lead.Status != 'New'){ // AFO
            if (!$A.util.isEmpty(lead.Parent2FirstName__c) || !$A.util.isEmpty(lead.Parent2LastName__c)) {
                if ($A.util.isEmpty(lead.Parent2FirstName__c)) {
                    errors.unshift(new error('Contact 2 First Name', 'Please enter Contact 2 First Name'));
                }
                if ($A.util.isEmpty(lead.Parent2LastName__c)) {
                    errors.unshift(new error('Contact 2 Last Name', 'Please enter Contact 2 Last Name'));
                }
                // if ($A.util.isEmpty(lead.Parent2Nationality__c)) {
                //     errors.unshift(new error('Contact 2 Nationality', 'Please enter Contact 2 Nationality'));
                // }
                //if ($A.util.isEmpty(lead.Parent2CountryOfResidence__c) && lead.LeadSource != 'External Relationships') {
                //    errors.unshift(new error('Contact 2 Country', 'Please enter Contact 2 Country'));
                //} //ANA20193101: QA asked to remove
                if (!$A.util.isEmpty(lead.Parent2HomePhone__c)) {
                    if (!regex.test(lead.Parent2HomePhone__c)) {
                        errors.unshift(new error('Contact 2 Primary Email/Home Phone', 'Please enter a valid Contact 2 Home Phone Ex:+852 9999-9999'));
                    }
                }
            }
        }
        //check Preferred name fields
        // if ( /[0-9]/.test(lead.Parent2FirstName__c) ) {
        //     errors.unshift(new error('Contact 2 First Name', 'Contact 2 First Name can only contain text'));   
        // }
        // if (/[0-9]/.test(lead.Parent2LastName__c) ) {
        //     errors.unshift(new error('Contact 2 Last Name', 'Contact 2 Last Name can only contain text'));   
        // }
        // if (/[0-9]/.test(lead.Parent2PreferredName__c) ) {
        //     errors.unshift(new error('Contact 2 Preferred Name', 'Contact 2 Preferred Name can only contain text'));   
        // }

        var numChild = lead.number_of_children__c;

        var today = new Date();
        if((lead.Parent1NatureOfRelationship__c == 'Agent' || lead.Parent1NatureOfRelationship__c == 'Child') || lead.Status != 'New'){ // AFO
            
            //validate child fields
            //child1
            if (numChild >= 1) {
                if ($A.util.isEmpty(lead.FirstNameFirstChild__c)) {
                    errors.unshift(new error('Child 1 First Name', 'Please enter Child 1 First Name'));
                }
                // else{
                // if (/[0-9]/.test(lead.FirstNameFirstChild__c) ) {
                //     errors.unshift(new error('Child 1 First Name', 'Child 1 First Name can only contain text'));   
                // }
                // }
                if ($A.util.isEmpty(lead.LastNameFirstChild__c)) {
                    errors.unshift(new error('Child 1 Last Name', 'Please enter Child 1 Last Name'));
                }
                // else{
                // if (/[0-9]/.test(lead.LastNameFirstChild__c) ) {
                //     errors.unshift(new error('Child 1 Last Name', 'Child 1 Last Name can only contain text'));   
                // }
                // }
                //if ($A.util.isEmpty(lead.DateOfBirthFirstChild__c)) {
                 //   errors.unshift(new error('Child 1 Date Of Birth', 'Please enter Child 1 Date Of Birth'));
                //}
                if ($A.util.isEmpty(lead.EnrollmentDateFirstChild__c)) {
                    errors.unshift(new error('Child 1 Expected Start Date', 'Please enter Child 1 Expected Start Date'));
                }
                if ($A.util.isEmpty(lead.GenderFirstChild__c)) {
                    errors.unshift(new error('Child 1 Gender', 'Please enter Child 1 Gender'));
                }
                //check Child 1 Preferred name fields
                // if (/[0-9]/.test(lead.PreferredNameFirstChild__c) ) {
                //     errors.unshift(new error('Child 1 Preferred Name', 'Child 1 Preferred Name can only contain text'));   
                // }
                
                // check DOB is past
                if (Date.parse(lead.DateOfBirthFirstChild__c) >= Date.parse(today)) {
                    errors.unshift(new error('Child 1 DateOfBirth', 'Child 1 DateOfBirth should be in the past'));
                }
            }
            //child2
            if (numChild >= 2) {
                if ($A.util.isEmpty(lead.FirstNameSecondChild__c)) {
                    errors.unshift(new error('Child 2 First Name', 'Please enter Child 2 First Name'));
                }
                // else{
                // if (/[0-9]/.test(lead.FirstNameSecondChild__c) ) {
                //     errors.unshift(new error('Child 2 First Name', 'Child 2 First Name can only contain text'));   
                // }
                // }
                if ($A.util.isEmpty(lead.LastNameSecondChild__c)) {
                    errors.unshift(new error('Child 2 Last Name', 'Please enter Child 2 Last Name'));
                }
                // else{
                // if (/[0-9]/.test(lead.LastNameSecondChild__c) ) {
                //     errors.unshift(new error('Child 2 Last Name', 'Child 2 Last Name can only contain text'));   
                // }
                // }
               // if ($A.util.isEmpty(lead.DateOfBirthSecondChild__c)) {
                //    errors.unshift(new error('Child 2 Date Of Birth', 'Please enter Child 2 Date Of Birth'));
                //}
                if ($A.util.isEmpty(lead.EnrollmentDateSecondChild__c)) {
                    errors.unshift(new error('Child 2 Expected Start Date', 'Please enter Child 2 Expected Start Date'));
                }
                if ($A.util.isEmpty(lead.GenderSecondChild__c)) {
                    errors.unshift(new error('Child 2 Gender', 'Please enter Child 2 Gender'));
                }
                //check Child2 preferred name fields
                // if (/[0-9]/.test(lead.PreferredNameSecondChild__c) ) {
                //     errors.unshift(new error('Child 2 Preferred Name', 'Child 2 Preferred Name can only contain text'));   
                // }
                // check DOB is past
                if (Date.parse(lead.DateOfBirthSecondChild__c) >= Date.parse(today)) {
                    errors.unshift(new error('Child 2 DateOfBirth', 'Child 2 DateOfBirth should be in the past'));
                }
            }
            //child3
            if (numChild >= 3) {
                if ($A.util.isEmpty(lead.FirstNameThirdChild__c)) {
                    errors.unshift(new error('Child 3 First Name', 'Please enter Child 3 First Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.FirstNameThirdChild__c) ) {
                //         errors.unshift(new error('Child 3 First Name', 'Child 3 First Name can only contain text'));   
                //     }
                // }
                if ($A.util.isEmpty(lead.LastNameThirdChild__c)) {
                    errors.unshift(new error('Child 3 Last Name', 'Please enter Child 3 Last Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.LastNameThirdChild__c) ) {
                //         errors.unshift(new error('Child 3 Last Name', 'Child 3 Last Name can only contain text'));   
                //     }
                // }
                //if ($A.util.isEmpty(lead.DateOfBirthThirdChild__c)) {
                  //  errors.unshift(new error('Child 3 Date Of Birth', 'Please enter Child 3 Date Of Birth'));
                //}
                if ($A.util.isEmpty(lead.EnrollmentDateThirdChild__c)) {
                    errors.unshift(new error('Child 3 Expected Start Date', 'Please enter Child 3 Expected Start Date'));
                }
                if ($A.util.isEmpty(lead.GenderThirdChild__c)) {
                    errors.unshift(new error('Child 3 Gender', 'Please enter Child 3 Gender'));
                }
                //check Child3 preferred name fields
                // if (/[0-9]/.test(lead.PreferredNameThirdChild__c) ) {
                //     errors.unshift(new error('Child 3 Preferred Name', 'Child 3 Preferred Name can only contain text'));   
                // }
                if (Date.parse(lead.DateOfBirthThirdChild__c) >= Date.parse(today)) {
                    errors.unshift(new error('Child 3 DateOfBirth', 'Child 3 DateOfBirth should be in the past'));
                }
            }
            //child4
            if (numChild >= 4) {
                if ($A.util.isEmpty(lead.FirstNameFourthChild__c)) {
                    errors.unshift(new error('Child 4 First Name', 'Please enter Child 4 First Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.FirstNameFourthChild__c) ) {
                //         errors.unshift(new error('Child 4 First Name', 'Child 4 First Name can only contain text'));   
                //     }
                // }
                if ($A.util.isEmpty(lead.LastNameFourthChild__c)) {
                    errors.unshift(new error('Child 4 Last Name', 'Please enter Child 4 Last Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.LastNameFourthChild__c) ) {
                //         errors.unshift(new error('Child 4 Last Name', 'Child 4 Last Name can only contain text'));   
                //     }
                // }
                //if ($A.util.isEmpty(lead.DateOfBirthFourthChild__c)) {
                 //   errors.unshift(new error('Child 4 Date Of Birth', 'Please enter Child 4 Date Of Birth'));
                //}
                if ($A.util.isEmpty(lead.EnrollmentDateFourthChild__c)) {
                    errors.unshift(new error('Child 4 Expected Start Date', 'Please enter Child 4 Expected Start Date'));
                }
                if ($A.util.isEmpty(lead.GenderFourthChild__c)) {
                    errors.unshift(new error('Child 4 Gender', 'Please enter Child 4 Gender'));
                }
                //check Child4 preferred name fields
                // if (/[0-9]/.test(lead.PreferredNameFourthChild__c) ) {
                //     errors.unshift(new error('Child 4 Preferred Name', 'Child 4 Preferred Name can only contain text'));   
                // }
                if (Date.parse(lead.DateOfBirthFourthChild__c) >= Date.parse(today)) {
                    errors.unshift(new error('Child 4 DateOfBirth', 'Child 4 DateOfBirth should be in the past'));
                }
            }
            //child5
            if (numChild >= 5) {
                if ($A.util.isEmpty(lead.FirstNameFifthChild__c)) {
                    errors.unshift(new error('Child 5 First Name', 'Please enter Child 5 First Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.FirstNameFifthChild__c) ) {
                //         errors.unshift(new error('Child 5 First Name', 'Child 5 First Name can only contain text'));   
                //     }
                // }
                if ($A.util.isEmpty(lead.LastNameFifthChild__c)) {
                    errors.unshift(new error('Child 5 Last Name', 'Please enter Child 5 Last Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.LastNameFifthChild__c) ) {
                //         errors.unshift(new error('Child 5 Last Name', 'Child 5 Last Name can only contain text'));   
                //     }
                // }
              //  if ($A.util.isEmpty(lead.DateOfBirthFifthChild__c)) {
                 //   errors.unshift(new error('Child 5 Date Of Birth', 'Please enter Child 5 Date Of Birth'));
               // }
                if ($A.util.isEmpty(lead.EnrollmentDateFifthChild__c)) {
                    errors.unshift(new error('Child 5 Expected Start Date', 'Please enter Child 5 Expected Start Date'));
                }
                if ($A.util.isEmpty(lead.GenderFifthChild__c)) {
                    errors.unshift(new error('Child 5 Gender', 'Please enter Child 5 Gender'));
                }
                //check Child5 preferred name fields
                // if (/[0-9]/.test(lead.PreferredNameFifthChild__c) ) {
                //     errors.unshift(new error('Child 5 Preferred Name', 'Child 5 Preferred Name can only contain text'));   
                // }
                if (Date.parse(lead.DateOfBirthFifthChild__c) >= Date.parse(today)) {
                    errors.unshift(new error('Child 5 DateOfBirth', 'Child 5 DateOfBirth should be in the past'));
                }
            }
            //child6
            /*if (numChild == 6) {
                if ($A.util.isEmpty(lead.FirstNameSixthChild__c)) {
                    errors.unshift(new error('Child 6 First Name', 'Please enter Child 6 First Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.FirstNameSixthChild__c) ) {
                //         errors.unshift(new error('Child 6 First Name', 'Child 6 First Name can only contain text'));   
                //     }
                // }
                if ($A.util.isEmpty(lead.LastNameSixthChild__c)) {
                    errors.unshift(new error('Child 6 Last Name', 'Please enter Child 6 Last Name'));
                }
                // else{
                //     if (/[0-9]/.test(lead.LastNameSixthChild__c) ) {
                //         errors.unshift(new error('Child 6 Last Name', 'Child 6 Last Name can only contain text'));   
                //     }
                // }
                if ($A.util.isEmpty(lead.DateOfBirthSixthChild__c)) {
                    errors.unshift(new error('Child 6 Date Of Birth', 'Please enter Child 6 Date Of Birth'));
                }
                if ($A.util.isEmpty(lead.EnrollmentDateSixthChild__c)) {
                    errors.unshift(new error('Child 6 Expected Start Date', 'Please enter Child 6 Expected Start Date'));
                }
                if ($A.util.isEmpty(lead.GenderSixthChild__c)) {
                    errors.unshift(new error('Child 6 Gender', 'Please enter Child 6 Gender'));
                }
                //check Child6 preferred name fields
                // if (/[0-9]/.test(lead.PreferredNameSixthChild__c) ) {
                //     errors.unshift(new error('Child 6 Preferred Name', 'Child 6 Preferred Name can only contain text'));   
                // }
                if (Date.parse(lead.DateOfBirthSixthChild__c) >= Date.parse(today)) {
                    errors.unshift(new error('Child 6 DateOfBirth', 'Child 6 DateOfBirth should be in the past'));
                }
            }*/
        }
        
        return errors;
    },
    capitalizeAll: function(component) {
        var lead = component.get("v.lead");
        var numChild = lead.number_of_children__c;

        var fields = [lead.Parent1FirstName__c, lead.Parent1LastName__c, lead.Parent1PreferredName__c,
            lead.Parent2FirstName__c, lead.Parent2LastName__c,
            lead.FirstNameFirstChild__c, lead.LastNameFirstChild__c, lead.PreferredNameFirstChild__c,
            lead.FirstNameSecondChild__c, lead.LastNameSecondChild__c, lead.PreferredNameSecondChild__c,
            lead.FirstNameThirdChild__c, lead.LastNameThirdChild__c, lead.PreferredNameThirdChild__c,
            lead.FirstNameFourthChild__c, lead.LastNameFourthChild__c, lead.PreferredNameFourthChild__c,
            lead.FirstNameFifthChild__c, lead.LastNameFifthChild__c, lead.PreferredNameFifthChild__c,
            //lead.FirstNameSixthChild__c, lead.LastNameSixthChild__c, lead.PreferredNameSixthChild__c
        ];

        for (var i = 0; i < fields.length; i++) {
            if (fields[i] != null) {
                var value = fields[i];
                var str = value.toLowerCase().replace(/\b[a-z]/g, function(letter) {
                    return letter.toUpperCase();
                });

                fields[i] = str;
            }
        }

        component.set("v.lead.Parent1FirstName__c", fields[0]);
        component.set("v.lead.Parent1LastName__c", fields[1]);
        component.set("v.lead.Parent1PreferredName__c", fields[2]);
        component.set("v.lead.Parent2FirstName__c", fields[3]);
        component.set("v.lead.Parent2LastName__c", fields[4]);
        //VJA component.set("v.lead.Parent2PreferredName__c", fields[5]);

        if (numChild >= 1) {
            component.set("v.lead.FirstNameFirstChild__c", fields[5]);
            component.set("v.lead.LastNameFirstChild__c", fields[6]);
            component.set("v.lead.PreferredNameFirstChild__c", fields[7]);
        }
        if (numChild >= 2) {
            component.set("v.lead.FirstNameSecondChild__c", fields[8]);
            component.set("v.lead.LastNameSecondChild__c", fields[9]);
            component.set("v.lead.PreferredNameSecondChild__c", fields[10]);
        }
        if (numChild >= 3) {
            component.set("v.lead.FirstNameThirdChild__c", fields[11]);
            component.set("v.lead.LastNameThirdChild__c", fields[12]);
            component.set("v.lead.PreferredNameThirdChild__c", fields[13]);
        }
        if (numChild >= 4) {
            component.set("v.lead.FirstNameFourthChild__c", fields[14]);
            component.set("v.lead.LastNameFourthChild__c", fields[15]);
            component.set("v.lead.PreferredNameFourthChild__c", fields[16]);
        }
        if (numChild >= 5) {
            component.set("v.lead.FirstNameFifthChild__c", fields[17]);
            component.set("v.lead.LastNameFifthChild__c", fields[18]);
            component.set("v.lead.PreferredNameFifthChild__c", fields[19]);
        }
        /*if (numChild >= 6) {
            component.set("v.lead.FirstNameSixthChild__c", fields[21]);
            component.set("v.lead.LastNameSixthChild__c", fields[22]);
            component.set("v.lead.PreferredNameSixthChild__c", fields[23]);
        }*/
    },
    
    setRecordTypeName: function (component, event, helper){
        
        var url_string = window.location.href;
        var recordTypeId = url_string.substring(url_string.indexOf("recordTypeId") + 13,url_string.indexOf("recordTypeId") + 28);

        var action = component.get("c.getRecordTypeNameById");
        action.setParams({
            "objectName" :  "Lead",
            "strRecordTypeId" : recordTypeId
        });

        action.setCallback(this, function(response) {       
            if (response.getState() === "SUCCESS") {
              component.set("v.RecordTypeName", response.getReturnValue());
            }
            else{
                console.log('error when retrieving RecordTypeID');
            }
        });

        $A.enqueueAction(action);
    }
    
})