({
    sortBy: function(component, field) {
        console.log("Sort By: " , field)
        var sortAsc = component.get("v.sortAsc"),
            sortField = component.get("v.opportunities"),
            records = component.get("v.opportunities");
        //sortAsc = field == sortField? !sortAsc: true;
        sortAsc = !sortAsc;
        records.sort(function(a,b){
            var t1 = a[field] == b[field],
                t2 = a[field] > b[field];
            return t1? 0: (sortAsc?-1:1)*(t2?-1:1);
        });
        component.set("v.sortAsc", sortAsc);
        //component.set("v.sortField", field);
        component.set("v.opportunities", records);
        component.set("v.showArrow", field);
        
        if(sortAsc) 
            component.set("v.icon", "utility:arrowup");
        else
            component.set("v.icon", "utility:arrowdown");
    }    
})