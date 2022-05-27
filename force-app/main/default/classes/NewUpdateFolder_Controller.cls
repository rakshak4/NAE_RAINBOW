public with sharing class NewUpdateFolder_Controller {
	private Id folderId;
	public Id groupId {get;set;}
	public boolean isNew {get;set;}
	
	public Assesment__c folder{get;set;}
    public NewUpdateFolder_Controller(ApexPages.StandardController controller) {
		folderId = controller.getId();
		groupId = System.currentPageReference().getParameters().get('grpid');
		Id folderRTId = [Select Id from RecordType where SObjectType='Assesment__c' AND DeveloperName='Assessment_Folder' limit 1].Id;
		if(folderId ==  null){
			isNew =  true;
			folder =  new Assesment__c();
			folder.RecordTypeId = folderRTId;
			folder.Group__c = groupId;
		}else{
			isNew =  false;
			folder = [Select Include_Target_Predicted_Grade__c,Grade_Type__c, Exam_Type__c,Id,Assessment_Date__c, Name, Auto_Publish__c, Group__c, Title__c, Type__c ,Description__c from Assesment__c where Id=:folderId];			
		}
		
    }
    
    public PageReference folderTypeChange(){
    	
    	folder.Type__c = system.currentPageReference().getParameters().get('ft');
    	
    	system.debug('****NewUpdateFolder_Controller***folderTypeChange***folder.Type__c='+folder.Type__c);
    	return null;
    }
    
    //navigation to be changed
    public PageReference saveNewFolder(){
    	
    	try{
    		insert folder;
    	}catch(Exception e){
    		ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, e.getMessage());
			ApexPages.addMessage(errorMessage);	
    	}
    	
    	return null;
    }
    //navigation to be changed
    public PageReference updateExistingFolder(){
    	
    	try{
    		if(folder.Type__c != 'Examination' && folder.Type__c != 'Progress Report'){
    			folder.Include_Target_Predicted_Grade__c = null;
    		}
    		update folder;
    	}catch(Exception e){
    		ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, e.getMessage());
			ApexPages.addMessage(errorMessage);	
    	}
    	
    	return null;
    }
    
    
    public PageReference editExistingFolder(){
    	PageReference pg  =  Page.NewUpdateFolder;
    	pg.getParameters().put('id',folder.Id);
    	pg.getParameters().put('grpid',groupId);
    	pg.setRedirect(true);
    	return pg;
    }
	
}