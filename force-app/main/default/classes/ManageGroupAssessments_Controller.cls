/***
	Author: Kunal Sharma
	Created Date: 24 Mar 2013
	Description: controller class for VF page ManageGroupAssessments 
	Audit Date:
	Audited By: 
	
	COMMENTS:
***/

public with sharing class ManageGroupAssessments_Controller {
	//variables
	public Id groupId {get;set;}
	public Group__c grp{get;set;}
	private Id folderRTId;
	public List<Assesment__c> assessmentFolders {get{
		return paginationSet.getRecords();
	}set;}	
	//private List<FolderStructure> folderStruc ;  
    //public List<FolderStructure> publicFolderStruc {get;set;}  
    public Map<Id,Assesment__c> assessmentFoldersMap {get;set;}
    public boolean isEditable {get;set;} 
    //for pagination
	private ApexPages.StandardSetController paginationSet {get;set;}
	public integer totalRegistrations {get{
		return paginationSet.getResultSize();
	}}
	public integer totalPages {get{
		return Integer.valueOf((totalRegistrations/decimal.valueOf(pageSize)).round(System.RoundingMode.CEILING));
	}}
	public integer pageNum {get;set;}
	private integer pageSize {get;set;}
       
    public ManageGroupAssessments_Controller(ApexPages.StandardController controller) {
    	pageSize = 20;
		groupId =  controller.getId();
		grp = [Select Id, Name from Group__c where Id=:groupId];
		folderRTId = [Select Id from RecordType where SObjectType='Assesment__c' AND DeveloperName='Assessment_Folder' limit 1].Id;
    	checkAccess();
    	initializeFolderStructure();
    	pageNum = paginationSet.getPageNumber();
    }
    
    private void checkAccess(){
    	//fetch profile for logged in User
    	String profileName  = [Select u.Profile.Name, u.ProfileId From User u where u.Id=:UserInfo.getUserId()].Profile.Name;
    	if(profileName.equalsIgnoreCase('System Administrator')){
    		isEditable =  true;
    	}else{
    		isEditable =  false;
    	}
    }
    
    private void initializeFolderStructure(){
    	assessmentFolders =  new List<Assesment__c>();
    	assessmentFoldersMap =  new Map<Id,Assesment__c>();
    	paginationSet = new ApexPages.StandardSetController(Database.getQueryLocator([Select Parent_Portal_Visibility__c,Id, Auto_Publish__c, Name, Title__c, Type__c, Assessment_Date__c, Assessment_Display_Name_Folder__c,Description__c from Assesment__c where Group__c=:groupId AND RecordTypeId=:folderRTId order by Folder_Order__c desc]));
    	paginationSet.setPageSize(pageSize);
    	/*
    	for(Assesment__c folder:[Select Parent_Portal_Visibility__c,Id, Auto_Publish__c, Name, Title__c, Type__c, Assessment_Date__c,Description__c from Assesment__c where Group__c=:groupId AND RecordTypeId=:folderRTId order by Folder_Order__c desc]){
                assessmentFolders.add(folder);
                assessmentFoldersMap.put(folder.Id,folder);
        }*/
    }
    
    //for pagination
	// indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return paginationSet.getHasNext();
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return paginationSet.getHasPrevious();
        }
        set;
    }

    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return paginationSet.getPageNumber();
        }
        set;
    }

    // returns the first page of records
     public void first() {
         paginationSet.first();
         pageNum = paginationSet.getPageNumber();
     }

     // returns the last page of records
     public void last() {
         paginationSet.last();
         pageNum = paginationSet.getPageNumber();
     }

     // returns the previous page of records
     public void previous() {
         paginationSet.previous();
         pageNum = paginationSet.getPageNumber();
     }

     // returns the next page of records
     public void next() {
         paginationSet.next();
         pageNum = paginationSet.getPageNumber();
     }
     
     // sets page number
     public void  setPageNumber() {
         paginationSet.setPageNumber(pageNum);
     }
	
	
    //function to delete folder
    public PageReference deleteFolder(){
    	//fetch id of the folder to be deleted
    	String folderIdToBeDeleted =  System.currentPageReference().getParameters().get('fid');
    	if(folderIdToBeDeleted != null){
    		//delete all assessments under this folder
    		List<Assesment__c> assessmentsToBeDeleted =  new List<Assesment__c>();
    		for(Assesment__c a:[Select Id from Assesment__c where Assessment_Folder__c=:folderIdToBeDeleted AND RecordTypeId !=:folderRTId]){
    			assessmentsToBeDeleted.add(a);
    		}
    		if(assessmentsToBeDeleted.size() > 0){
    			delete assessmentsToBeDeleted;
    		}
    		Assesment__c a =  new Assesment__c(Id=folderIdToBeDeleted);
    		delete a;
    		
    		PageReference pg  = Page.Tabbed_Group_Detail ; 
    		pg.getParameters().put('id',groupId);
    		pg.getParameters().put('stab','assessment');
    		pg.setRedirect(true);
        	return pg;
    	}
    	return null;
    }
    
    /*
    private void initializeFolderStructure(){
        folderStruc =  new List<FolderStructure>();
        publicFolderStruc =  new List<FolderStructure>();
        assessmentFolders =  new List<Assesment__c>();
        assessmentFoldersMap =  new Map<Id,Assesment__c>();
        for(Assesment__c folder:[Select Id, Name, Title__c, Type__c, Assessment_Date__c, Assessment_Folder__c from Assesment__c where Group__c=:groupId AND RecordTypeId=:folderRTId order by Assessment_Folder__c desc ,Name asc]){
                assessmentFolders.add(folder);
                assessmentFoldersMap.put(folder.Id,folder);
        } 
        //fetch all parent folders
        for(Assesment__c folder:assessmentFolders){
            //look for top level folder
            System.debug('*********processing for folder='+folder.Name);
            FolderStructure topLevel =  getFolderStructure(folder.Id);
            System.debug('*********found topLevel='+topLevel);
            // look for subsequent parent folders
            while(topLevel.parentFolder.Assessment_Folder__c != null){
                //fetch parent folder
                System.debug('*********checking for parent************* ');
                FolderStructure pFolder =  getFolderStructure(topLevel.parentFolder.Assessment_Folder__c);
                System.debug('*********parent found*************'+pFolder);
                //check if top level folder is in child folder of parent folder
                if(pFolder.childFolders == null){
                    pFolder.childFolders = new List<FolderStructure>();
                    pFolder.childFolders.add(topLevel);
                }
                //check if child folders alreday contains folder
                boolean isThere =  false;
                for(FolderStructure f:pFolder.childFolders){
                    if(f.parentFolder.Id == topLevel.parentFolder.Id){
                        isThere =  true;
                    }
                }
                if(!isThere){
                    pFolder.childFolders.add(topLevel);
                } 
                topLevel = pFolder;             
            }
            
        }
        
        //clean folder structure
        //replicate folder structure
        //check for all parent folders if they are child in other folders
        integer index = 0;
        for(FolderStructure f:folderStruc){
            boolean isFound = isFolderChild(f.parentFolder.Id);
            if(!isFound){
                publicFolderStruc.add(f);   
            }
            index++;  
        }
    }
    
    
    //function to check if provided folder is a child of any folder
    private boolean isFolderChild(Id folderId){
        boolean isFound =  false;
        for(FolderStructure f:folderStruc){
            if(f.childFolders != null){
                for(FolderStructure cf:f.childFolders){
                    if(cf.parentFolder.Id == folderId){
                        isFound =  true;
                        break;
                    }
                }
            }
        }
        return isFound;
    }
    
    //funtion returns parent folder structure for child
    private FolderStructure getFolderStructure(Id parentFolderId){
        System.debug('*********inside******getFolderStructure');
        FolderStructure fs ;
        for(FolderStructure f:folderStruc){
            if(f.parentFolder.Id == parentFolderId){
                fs = f;
                System.debug('*********inside******getFolderStructure*****folder structure found for '+fs.parentFolder.Name);
            }
        }
        if(fs == null){
            fs =  new FolderStructure();
            fs.parentFolder = assessmentFoldersMap.get(parentFolderId);
            System.debug('*********inside******getFolderStructure*****new folder structure created for '+fs.parentFolder.Name);
            folderStruc.add(fs);
        }
        
        return fs;
    }
    
    //function to redirect to VF page to create new folders and update exiting folders
    public PageReference newFolder(){
        Id folderId =  System.currentPageReference().getParameters().get('fid');        
        PageReference pg  =  Page.NewUpdateFolder;
        pg.getParameters().put('grpid',groupId);
        if(folderId != null && folderId != ''){
            pg.getParameters().put('id',folderId);
        }
        return pg;
    }
    
    //wrapper classes
    public class FolderStructure {
        public Assesment__c parentFolder {get;set;}
        public List<FolderStructure> childFolders {get;set;}
        public boolean hasChild {get{
            if(childFolders != null){
                return true;
            }else{
                return false;
            }
        }}
    }
	*/
}