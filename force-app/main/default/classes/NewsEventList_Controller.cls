public with sharing class NewsEventList_Controller {   
    private Id groupId {get;set;}
    private string groupName {get;set;}
    private boolean pageLoad {get;set;}
    public string pageURL {get{
        return '/apex/Tabbed_Group_Detail?id='+groupId+'&stab=calendar&st='+selectedTermFilter+'&stab=calendar';
    }}
    //for filter
    public list<SelectOption> termOptions {get;set;}
    public String selectedTermFilter {get;set;}
    public List<News_Events__c> records {get{
        return paginationSet.getRecords();
    }set;}
    private ApexPages.StandardSetController paginationSet {get;set;} 
    public integer totalRegistrations {get{
        return paginationSet.getResultSize();
    }}
    public integer totalPages {get{
        return Integer.valueOf((totalRegistrations/decimal.valueOf(pageSize)).round(System.RoundingMode.CEILING));
    }}
    public integer pageNum {get;set;}
    private integer pageSize {get;set;}
    //for status filtering
    public list<SelectOption> statusOptions {get;set;}
    public string selectedStatus {get;set;}
    //for owner filtering
    public list<SelectOption> ownerOptions {get;set;}
    public string selectedOwner {get;set;}
    public NewsEventList_Controller(ApexPages.StandardController controller){
        pageLoad = true;
        pageSize = 20;
        groupId = controller.getId();
        groupName = [select Name from Group__c where Id=:groupId].Name;
        termOptions = new list<SelectOption>();
        termOptions.add(new SelectOption('Past','Past'));
        termOptions.add(new SelectOption('This Term','This Term'));
        termOptions.add(new SelectOption('This Year','This Year')); 
        termOptions.add(new SelectOption('More','More'));
        string sterm = system.currentPageReference().getParameters().get('st');
        if(sterm == null | sterm == ''){
            selectedTermFilter = 'This Term';
        }else{
            selectedTermFilter = sterm;
        }
        //for status options
        statusOptions = new list<SelectOption>();
        statusOptions.add(new SelectOption('All','All'));
        statusOptions.add(new SelectOption('Published','Published'));
        statusOptions.add(new SelectOption('Cancelled','Not Published / Cancelled'));
        selectedStatus = 'Published';
        
        //for owner options
        ownerOptions = new list<SelectOption>();
        ownerOptions.add(new SelectOption('All','All Events'));
        ownerOptions.add(new SelectOption('My','My Events Only'));
        selectedOwner = 'All';
        
        //fetch events
        fetchEvents();
        pageNum = paginationSet.getPageNumber();
    }
    
    
    public PageReference fetchEvents(){
        records = new list<News_Events__c>();
        string query = 'Select n.CreatedById, n.Publish_on_Group_Site__c,  n.Publish_on_School_Site__c, n.Publish_in_Portal_School_Hub__c, n.Language__c, n.Video_4_URL__c, n.Video_4_TITLE__c, n.Video_3_URL__c, n.Video_3_TITLE__c, n.Video_2_URL__c, n.Video_2_TITLE__c, n.Video_1_URL__c, n.Video_1_TITLE__c, n.Subtitle__c, n.Student_Group__c, n.School__c, n.RecordType.Name, n.RecordTypeId, n.OwnerId, n.Name, n.Main_Text__c, n.Link_3__c, n.Link_3_Title__c, n.Link_2__c, n.Link_2_Title__c, n.Link_1__c, n.Link_1_Title__c, n.Id, n.Event_Start_Month__c, n.Event_Start_Date__c, n.Event_End_Month__c, n.Event_End_Date__c, n.CreatedDate, n.Academic_Year__c From News_Events__c n where n.Student_Group__c =:groupId  ';
        system.debug('****NewsEventList_Controller***fetchEvents****selectedTermFilter='+selectedTermFilter);   
        if(selectedTermFilter != null){
            if(selectedTermFilter == 'This Term'){
                query += ' AND Is_This_Term_Record__c  = true ';
            }else if(selectedTermFilter == 'This Year'){
                query += ' AND Is_This_Year_Record__c  = true ';
            }else if(selectedTermFilter == 'More'){
                query += ' AND Is_More_Date__c   = true ';
            }else if(selectedTermFilter == 'Past'){
                query += ' AND Is_This_Term_Record__c  = false ';
                query += ' AND Is_This_Year_Record__c  = false ';
                query += ' AND Is_More_Date__c   = false ';
            }
        }
        if(selectedStatus != null){
            if(selectedStatus == 'Published'){
                query += ' AND Publish_in_Portal_School_Hub__c   = true ';  
            }else if(selectedStatus == 'Cancelled'){
                query += ' AND Publish_in_Portal_School_Hub__c   = false ';
            }
        }
        
        if(selectedOwner != null){
            if(selectedOwner == 'My'){
                query += ' AND Is_my_record__c   =  true ';
            }
        }
        /*
        if(selectedFilters != null){
            set<String> temp_set = new set<String>();
            for(String s:selectedFilters){
                temp_set.add(s);                
            }
            if(temp_set.contains('Published')){
                query += ' AND Publish_in_Portal_School_Hub__c   = true ';  
            }else{
                query += ' AND Publish_in_Portal_School_Hub__c   = false ';
            }
            if(temp_set.contains('Cancelled')){
                query += ' AND Notification_Type__c   = \'Cancelled\' ';
            }else{
                query += ' AND Notification_Type__c   != \'Cancelled\' ';
            }
            if(temp_set.contains('My Events Only')){
                query += ' AND Is_my_record__c   =  true ';
            }else{
                //query += ' AND Is_my_record__c   = false ';
            }
            
        }*/
        
        if(selectedTermFilter == 'Past'){       
            query += 'order by Event_Start_Date__c desc ';
        }else{
            query += 'order by Event_Start_Date__c asc ';
        }
        system.debug('****NewsEventList_Controller***fetchEvents****query='+query);
        paginationSet = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        paginationSet.setPageSize(pageSize);
                
        /*PageReference pg  = Page.Tabbed_Group_Detail ; 
        pg.getParameters().put('id',groupId);
        pg.getParameters().put('stab','calendar');
        pg.getParameters().put('st',selectedTermFilter);
        pg.setRedirect(true);
        return pg;*/
        if(pageLoad){
            pageLoad = false;
        }else{
            system.currentPageReference().getParameters().put('stab','calendar');
        }
        return null; 
    }
    
    //function to delete folder
    public PageReference deleteRecord(){
        //fetch id of the folder to be deleted
        try{
            String recordIdToBeDeleted =  System.currentPageReference().getParameters().get('rid');
            if(recordIdToBeDeleted != null){
                
                News_Events__c ne = new News_Events__c(Id=recordIdToBeDeleted);
                delete ne;
                PageReference pg  = Page.Tabbed_Group_Detail ; 
                pg.getParameters().put('id',groupId);
                pg.getParameters().put('stab','calendar');
                pg.getParameters().put('st',selectedTermFilter);
                pg.setRedirect(true);
                return pg;
            }
        }catch(Exception e){
            
        }
        return null;
    }
    
    public PageReference newNotice(){
        PageReference pg  = new PageReference('/a2C/e') ; 
        pg.getParameters().put('CF00N6F00000M2zYQ',groupName);
        pg.getParameters().put('CF00N6F00000M2zYQ_lkid',groupId);
        pg.getParameters().put('nooverride','1');
        pg.getParameters().put('retURL',pageURL);
        pg.getParameters().put('cancelURL',pageURL);
        pg.getParameters().put('saveURL',pageURL);
        Id rid = [select Id from RecordType where SObjectType='News_Events__c' AND DeveloperName='Reminder'].Id;
        pg.getParameters().put('RecordType',rid);
        
        pg.setRedirect(true);
        return pg;
    }
    
    public PageReference newSchoolEvent(){
        PageReference pg  = new PageReference('/a2C/e') ; 
        pg.getParameters().put('CF00N6F00000M2zYQ',groupName);
        pg.getParameters().put('CF00N6F00000M2zYQ_lkid',groupId);
        pg.getParameters().put('nooverride','1');
        pg.getParameters().put('retURL',pageURL);
        pg.getParameters().put('cancelURL',pageURL);
        pg.getParameters().put('saveURL',pageURL);
        Id rid = [select Id from RecordType where SObjectType='News_Events__c' AND DeveloperName='Event'].Id;
        pg.getParameters().put('RecordType',rid);
        
        pg.setRedirect(true);
        return pg;
    }
    
    public PageReference newTermDate(){
        PageReference pg  = new PageReference('/a2C/e') ; 
        pg.getParameters().put('CF00N6F00000M2zYQ',groupName);
        pg.getParameters().put('CF00N6F00000M2zYQ_lkid',groupId);
        pg.getParameters().put('nooverride','1');
        pg.getParameters().put('retURL',pageURL);
        pg.getParameters().put('cancelURL',pageURL);
        pg.getParameters().put('saveURL',pageURL);
        pg.getParameters().put('Name','Auto-Complete');
        pg.getParameters().put('00N6F00000M2zY6','1');
        Id rid = [select Id from RecordType where SObjectType='News_Events__c' AND DeveloperName='Term'].Id;
        pg.getParameters().put('RecordType',rid);
        
        pg.setRedirect(true);
        return pg;
    }
    
    public PageReference newHolidayDate(){
        PageReference pg  = new PageReference('/a2C/e') ; 
        pg.getParameters().put('CF00N6F00000M2zYQ',groupName);
        pg.getParameters().put('CF00N6F00000M2zYQ_lkid',groupId);
        pg.getParameters().put('nooverride','1');
        pg.getParameters().put('retURL',pageURL);
        pg.getParameters().put('cancelURL',pageURL);
        pg.getParameters().put('saveURL',pageURL);
        pg.getParameters().put('00N6F00000M2zY6','1');
        Id rid = [select Id from RecordType where SObjectType='News_Events__c' AND DeveloperName='Holiday'].Id;
        pg.getParameters().put('RecordType',rid);
        
        pg.setRedirect(true);
        return pg;
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
    
    

}