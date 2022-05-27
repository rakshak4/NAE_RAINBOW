({
    init: function (cmp, event, helper) {
        helper.verifyHeight(cmp, event, helper);
        helper.loadDataTable(cmp, event, helper)
    },
    getSelectedName: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
        if(selectedRows.length > 0){
            cmp.set('v.selectedRecordId', selectedRows[0].Id);
        }
    },
    handleSort: function(cmp, event, helper) {
        helper.handleSort(cmp, event);
    },
})