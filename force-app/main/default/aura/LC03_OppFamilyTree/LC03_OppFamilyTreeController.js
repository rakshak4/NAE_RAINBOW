({
    view : function(component, event, helper) {
         var navEvent = $A.get("e.force:navigateToSObject");
         var id = event.target.getAttribute('data-index');
         if(navEvent){
             navEvent.setParams({
                  recordId: id,
             });
             navEvent.fire(); 
         }
    },

    sortByName: function(component, event, helper) {
        helper.sortBy(component, "Name");
    },

    sortByReferredBy: function(component, event, helper) {
        helper.sortBy(component, "ReferredBy");
    },

    sortByExpectedStartDate: function(component, event, helper) {
        helper.sortBy(component, "CloseDate");
    },

    sortByStage : function(component, event, helper) {
        helper.sortBy(component, "StageName");
    },

    sortByDOB: function(component, event, helper) {
        helper.sortBy(component, "DOB");
    },

    sortByYearGrade : function(component, event, helper) {
        helper.sortBy(component, "YearGrade");
    },

    // sortByName: function(component, event, helper) {
    //     console.log("SortByName")

    //     var currentOrder = component.get("v.sortAsc"),
    //         currentList = component.get("v.opportunities");
    //     currentOrder = !currentOrder;
    //     currentList.sort(function(a,b) {
    //         var t1 = a.Name == b.Name, t2 = a.Name < b.Name;
    //         return t1? 0: (currentOrder?-1:1)*(t2?1:-1);
    //     });
    //     component.set("v.sortAsc", currentOrder);
    //     component.set("v.opportunities", currentList);
    //     if(currentOrder) 
    //         component.set("v.icon", "utility:arrowup");
    //     else
    //         component.set("v.icon", "utility:arrowdown");
    // }

})