{!REQUIRESCRIPT("/soap/ajax/20.0/connection.js")}

function sayHelloFromAnotherJS(){

var LeadObj = new sforce.SObject("Lead");
LeadObj.Id = '{!Lead.Id}';
LeadObj.Rating = 'hot';

// assign values to fields using LeadObj variable

var result = sforce.connection.update([LeadObj]);
window.location.href=window.location.href;}
