public with sharing class ManagePastorals {
	public list<Conduct__c> pastoralFolders {get;set;}
    private Id gid{get;set;}
    public ManagePastorals(ApexPages.StandardController controller) {
    	pastoralFolders = new list<Conduct__c>();
		gid = controller.getId();
		for(Conduct__c pastoralFolder:[select CreatedById, Student_Group__c, CreatedDate,LastModifiedDate , Id,Folder_Title__c, Folder_Type__c, Folder_Description__c, Name, Pastoral_Date__c, Parent_Portal_Visibility__c from Conduct__c where RecordType.DeveloperName = 'Pastoral_Folder' AND Student_Group__c=:controller.getId() order by CreatedDate desc]){
			pastoralFolders.add(pastoralFolder);
		}
    }
    public PageReference deleteFolder(){ 
    	string fid = system.currentPageReference().getParameters().get('dfid');
    	if(fid != null && fid != ''){
    		list<Conduct__c> pastorals = new list<Conduct__c>();
    		for(Conduct__c c:[select Id from Conduct__c where Folder__c=:fid]){
    			pastorals.add(c);
    		}
    		if(pastorals.size() >0){
    			delete pastorals;
    		}
    		Conduct__c folder = new Conduct__c(Id=fid);
    		delete folder;
    		PageReference pg  = Page.Tabbed_Group_Detail ; 
    		pg.getParameters().put('id',gId);
    		pg.getParameters().put('stab','pastorals');
    		pg.setRedirect(true);
        	return pg;    		
    	}
    	return null;
    }
    
    public PageReference newFolder(){
    	//string fid = system.currentPageReference().getParameters().get('mfid');
    	PageReference pg  = Page.CreatePastorals ; 
		pg.getParameters().put('id',gId);
		//pg.getParameters().put('fid',fid);
		pg.setRedirect(true);
    	return pg;
    }

}