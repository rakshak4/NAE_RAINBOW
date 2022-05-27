//batch class to update invoice line on 1st of every month
global class BatchMonthlyInvoiceLineUpdate implements Database.Batchable<sObject>,Database.Stateful{
	global string errorMessage ; 
	//Batch Interface Methods
	global Database.QueryLocator start(Database.BatchableContext BC) { 
		errorMessage = '';
		String q = 'Select Id from Line_Item__c'; //to be updated
		return Database.getQueryLocator(q);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		list<Line_Item__c> allLines = scope;
		list<Database.SaveResult> srList = Database.update(allLines,false);
		integer i = 0;
        for(Database.Saveresult sr:srlist){
            if(!sr.isSuccess()){
                if(errorMessage == ''){
                    errorMessage += '\n'+'BatchMonthlyInvoiceLineUpdate - Error Occured while updating Invoice Line Item. ';
                }
                errorMessage += '\n'+'Error Occured updating invoice line item = '+allLines[i]+'. Error Message: '+sr.getErrors();
            }
            i++;
        }
	}
	
	global void finish(Database.BatchableContext BC){
		if(errorMessage != ''){
            //send email to Ben, Kunal
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           list<String> toAddresses =  new list<String>();
           toAddresses.add('ben.hails@britishschools.co.uk');
           toAddresses.add('kunal.sharma@britishschools.co.uk');
           
           //String[] toAddresses = new String[] {'ben.hails@britishschools.co.uk','kunal.sharma@britishschools.co.uk'};
           mail.setToAddresses(toAddresses);
           mail.setSubject('BatchMonthlyInvoiceLineUpdate -  Error occured');
           string emailText = 'There were errors processing invoice line item records. Find error message below:';
           emailText += '\n';
           emailText += errorMessage;
           mail.setPlainTextBody(emailText);
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        }
	}
}