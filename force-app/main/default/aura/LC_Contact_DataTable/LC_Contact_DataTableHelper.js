({
    sortBy: function(field, reverse, primer) {
        var key = primer
            ? function(x) {
                  return primer(x[field]);
              }
            : function(x) {
                  return x[field];
              };

        return function(a, b) {
            a = key(a);
            b = key(b);

            if(a == undefined){
                return reverse;
            }
            if(b == undefined){
                return reverse * -1;
            }

            return reverse * ((a > b) - (b > a));
        };
    },

    handleSort: function(cmp, event) {
        var sortedBy = event.getParam('fieldName');
        var tempSortedBy = sortedBy;
        console.log('Sortby: ' + sortedBy);
        if(sortedBy != null && sortedBy.startsWith('link') && sortedBy.endsWith('Name')){
            sortedBy = sortedBy.replace('link', '');
        }
        console.log('Sortby After: ' + sortedBy);

        var sortDirection = event.getParam('sortDirection');
        var mydata = cmp.get('v.mydata');

        var cloneData = mydata.slice(0); //Slice for shallow copy
        cloneData.sort((this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1)));
        
        cmp.set('v.selectedRows', new Array()); //reset selected data
        cmp.set('v.mydata', cloneData); //sorted data
        cmp.set('v.sortDirection', sortDirection); //asc or desc
        cmp.set('v.sortedBy', tempSortedBy); //sort by fieldname
    },

    //load fieldset + records
    loadDataTable: function (cmp, event, help) { 

        var recordList = cmp.get('v.objectList');
        if(recordList == null){
            recordList = [];
        }

        this.setNumberOfItems(cmp, recordList.length);

        for(var i = 0 ; i < recordList.length ; i++){
            Object.assign(recordList[i], {
                attributes: {
                    type: cmp.get('v.objectApiName')
                }
            });
        }

        var action = cmp.get('c.loadDataTable');

        action.setParams({
            'objectApiName': cmp.get('v.objectApiName'),
            'fieldSetName': cmp.get('v.fieldSetName'),
            'strObjectList' : JSON.stringify(recordList)
        }); 

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                if(result){

                    cmp.set('v.mycolumns', result['lstFields']);                   
                    cmp.set('v.mydata', result['lstObject']);

                    console.log(result['lstFields']);
                    console.log(result['lstObject']);
                }
                cmp.set('v.tableLoaded', true);

            } else if (state === "ERROR") {
                let errors = response.getError();
                let message = '';
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                    cmp.set('v.errorMessage', message);
                    cmp.set('v.errorFlag', true);
                }                
            }
        }));
        $A.enqueueAction(action);
    },

    //check if height parameter is valid
    verifyHeight: function (cmp, event, help) { 
        var height = cmp.get('v.dataTableHeight');
        if(height<=0){
            cmp.set('v.errorMessage', 'Invalid table height.');
            cmp.set('v.errorFlag', true);
        }
    },

    setNumberOfItems: function(cmp, numberOfItems){

        if(numberOfItems == 0 || numberOfItems == 1){
            cmp.set('v.numberOfItems', (numberOfItems + ' item'));
        }
        if(numberOfItems > 1){
            cmp.set('v.numberOfItems', (numberOfItems + ' items'));
        }

    }
})