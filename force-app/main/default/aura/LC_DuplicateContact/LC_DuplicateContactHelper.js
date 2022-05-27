({
    processDuplicates : function(cmp, event, help) {
        var lstNewContact = cmp.get('v.lstNewContact');
        var lstExistingContact = cmp.get('v.lstExistingContact');
        var lstModifiedContact = [];
        var lstVisualData = [];
        var visualData;
        var fullName;
        var htmlList;
        var modifiedContact;
        var differenceFound = false;
        var lstFields = ['Phone', 'Email'];

        if(lstNewContact == null){
            lstNewContact = [];
        } 
        
        if(lstExistingContact == null){
            lstExistingContact = [];
        }

        console.log('###lstNewContact: ' + JSON.stringify(lstNewContact));
        console.log('###lstExistingContact: ' + JSON.stringify(lstExistingContact));

        for(var i = 0 ; i < lstExistingContact.length ; i++){
            for(var j = 0 ; j < lstNewContact.length ; j++){
                differenceFound = false;
                if(lstExistingContact[i].FirstName == lstNewContact[j].FirstName &&
                    lstExistingContact[i].LastName == lstNewContact[j].LastName
                ){
                    htmlList = '<ul class="slds-list_dotted">';
                    modifiedContact = Object.assign({}, lstExistingContact[i]);

                    for(var k = 0 ; k < lstFields.length ; k++){
                        if(lstNewContact[j][lstFields[k]] != null && lstNewContact[j][lstFields[k]] != lstExistingContact[j][lstFields[k]]){

                            modifiedContact[lstFields[k]] = lstNewContact[j][lstFields[k]];

                            console.log('###Old: ' + lstExistingContact[i][lstFields[k]]);
                            console.log('###New: ' + modifiedContact[lstFields[k]]);

                            htmlList += '<br>';
                            htmlList += '<li><div class="slds-text-body_small">Old ' +lstFields[k] + ': ' + lstExistingContact[i][lstFields[k]] + '</div></li>'
                            htmlList += '<li><div class="slds-text-body_small">New ' +lstFields[k] + ': ' + modifiedContact[lstFields[k]] + '</div></li>'

                            differenceFound = true;
                            cmp.set('v.showCard', true);

                        }
                    }
                    htmlList += '</ul>';

                    if(htmlList.includes('<br>')){
                        htmlList = htmlList.replace('<br>', '');
                    }

                    if(differenceFound){
                        fullName = lstNewContact[j].FirstName + ' ' + lstNewContact[j].LastName;
                        visualData = {
                            name : fullName,
                            existingContact : lstExistingContact[i],
                            newContact : lstNewContact[j],
                            modifiedContact : modifiedContact,
                            changeDescription : htmlList
                        };
                        lstVisualData.push(visualData);
                        lstModifiedContact.push(modifiedContact);
                    }
                }

            }
        }

        console.log('###lstVisualData: ' + JSON.stringify(lstVisualData));
        cmp.set('v.lstModifiedContact', lstModifiedContact);
        cmp.set('v.lstVisualData', lstVisualData);
    }
})