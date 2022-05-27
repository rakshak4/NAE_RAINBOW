public with sharing class JobPostingSearchController { 

  public list <Job_Posting__c>    msList               {get; set;}
  public list <MsClass>          smallMsClassList     {get; set;}
  public list <MsClass>          masterMsClassList    {get; set;}
  public list <list <MsClass>>   msClassLists         {get; set;}
  public String                  searchPhrase         {get; set;}
  public String                  Department           {get; set;}
  public String                  pathVar              {get; set;}
  public Boolean                 testing              {get; set;}
  //constructor 
  public JobPostingSearchController(){
    testing = false;
    setupPathVar();
    searchPhrase=Apexpages.currentPage().getParameters().get('search');
    Department=Apexpages.currentPage().getParameters().get('search');
   msList = [Select ID, Contact_Email__c,Contact_Person__c,Department__c,Description__c,Link_to_Document__c, Name_of_Document__c, OwnerId__c,
   //msList = [Select ID, Contact_Email__c,Contact_Person__c,Department__c,Link_to_Document__c, Name_of_Document__c, OwnerId__c,
             Name,  Title__c, School__c 
             //From Job_Posting__c where Publish_Status__c = 'Publish'];
             From Job_Posting__c where  Publish_on_School_Site__c  = true];

msList.sort();
    setupMasterMsClassList();
  
    if(searchPhrase!=Null)
      doSearch();
      
    else
     setupSmallMsClassList();
    
      
  }


  //setup pathVar for any extra path variables
   private void setupPathVar(){
    String Url=Site.getDomain();
    String prefix=Site.getPrefix();
    if(prefix==null)
     prefix='';
    pathVar ='http://'+Url+prefix;
    if(Site.getDomain()==null){
      pathVar='';
      String currentSite = Apexpages.currentPage().getUrl();
      if (testing){
        currentSite = 'http://microsite-developer-edition.na7.force.com/searchpage';
      }
      Integer i;







      
      if(currentSite==null){
        return;
      }
      
      List <String> currentSiteSplit = currentSite.split('/');
      
      if(currentSiteSplit == null)
        return;
      
      for(i=0; i<currentSiteSplit.size(); i++){
        if(currentSiteSplit[i].startsWith('searchpage'))
          break;
      }
      
      i=i-1;
      
      while(i>=0 && currentSiteSplit[i] !=null && !currentSiteSplit[i].endsWith('com')){
        pathVar=currentSiteSplit[i]+'/'+pathVar;
        i=i-1;
      }
      if(pathVar.length()>0)
        pathVar=pathVar.substring(0, pathVar.length()-1);
    }
  }
  
 
   //returns a searchpage with search
  public pageReference micropageSearch(){
  
   
   if(searchPhrase!='All'){
      PageReference pageRef = new PageReference('/searchpage?search='+searchPhrase);
      return pageRef;}
      
    
      
      
      
      
    else{
 
  
  
    PageReference pageRef = new PageReference('/searchpage?search=');
    return pageRef;
  }}
  
  

  
  
  
 
  
  
  //performs search of either zip code or name
  private void doSearch(){
    smallMsClassList=new list<MsClass>();
    nameSearch();
   
    
    
   
   
  }
  
   //ensures search is made up of letters and
  //searches for name on all possible name fields
  private void nameSearch(){
    String phrase=Department.toLowerCase();
    for(MsClass ms:masterMSClassList){
      if(ms.firstName.toLowerCase().startsWith(Department.toLowerCase()))
        smallMsClassList.add(ms);
      else if(ms.lastName.toLowerCase().startsWith(Department.toLowerCase()))
        smallMsClassList.add(ms);
      else{
       List <String> splitName = ms.Department.split(' ');
       for (String s: splitName){
          if(s.toLowerCase().startsWith(Department.toLowerCase()))
            smallMsClassList.add(ms);
       }
      }
    } 
    
  }
 
  
  
  
  //returns a searchpage with search
  public pageReference micropageSearch2(){
    PageReference pageRef = new PageReference('/searchpage?search='+Department);
    return pageRef;
  }
  
  
  
  
  //performs search of either zip code or name
  private void doSearch2(){
    smallMsClassList=new list<MsClass>();
    nameSearch2();
    
    
   
   
  }
  
  //ensures search is made up of letters and
  //searches for name on all possible name fields
  private void nameSearch2(){
    String phrase=Department.toLowerCase();
    for(MsClass ms:masterMSClassList){
      if(ms.firstName.toLowerCase().startsWith(Department.toLowerCase()))
        smallMsClassList.add(ms);
      else if(ms.lastName.toLowerCase().startsWith(Department.toLowerCase()))
        smallMsClassList.add(ms);
      else{
       List <String> splitName = ms.startZip.split(' ');
       for (String s: splitName){
          if(s.toLowerCase().startsWith(Department.toLowerCase()))
            smallMsClassList.add(ms);
       }
      }
    } 
    
  }
  
 
  




  
  //sets up list used in page
  private void setupSmallMsClassList(){ 
    smallMsClassList = new list<MsClass>();
    
    //if less than 8 just add the list
    if(masterMsClassList.size()<300){
      for(MsClass mc:masterMsClassList)
       smallMsClassList.add(mc);
    }
    else{
      //get 8 random
      for (Integer i=0;i<8;i++)
        smallMsClassList.add(masterMsClassList.remove(Math.round((masterMsClassList.size()-1)*Math.random())));
      //add the 8 back to master list
      for(MsClass mc:smallMsClassList)
       masterMsClassList.add(mc);       
    }
  }
  
  //inner class of objects to display on the page
  private void setupMasterMsClassList(){
    masterMsClassList=new list<MsClass>();
    for (Job_Posting__c ms : msList)
     masterMsClassList.add(new MsClass(ms));
  }

  public Class MsClass{
    public String id             {get; set;}
    public String startZip       {get; set;}
    public String ContactEmail       {get; set;}
    public String ContactPerson          {get; set;} 
    public String name           {get; set;}
    public String Department         {get; set;}
    public String Description          {get; set;}
    public String School          {get; set;}
    public String Link     {get; set;}
    public String Document       {get; set;}
    public String OwnerId      {get; set;}
    public String Nationality    {get; set;}
    public String firstName      {get; set;}
    public String lastName       {get; set;}
    public String photoLink      {get; set;}
    public String title          {get; set;}
    public String Ext            {get; set;}
  
     
        public MsClass(Job_Posting__c ms){
      
      id          =nullCheck(ms.ID);
      startZip    =nullCheck(null);
      ContactEmail     =nullCheck(ms.Contact_Email__c);
      ContactPerson       =nullCheck(ms.Contact_Person__c);
      name        =nullCheck(ms.Name);
     Department      =nullCheck(ms.Department__c);
      Description      =nullCheck(ms.Description__c);
      
      Link  =nullCheck(ms.Link_to_Document__c);
      Document =nullCheck(ms.Name_of_Document__c);  
       School =nullCheck(ms.School__c);
       
      OwnerId    =nullCheck(ms.OwnerId__c);
      Title    =nullCheck(ms.Title__c);
     
      

    }
  public String nullCheck(String val){
    if(val==null)
     return '.';
    else 
     return val; 
  }
 }
 
 
}