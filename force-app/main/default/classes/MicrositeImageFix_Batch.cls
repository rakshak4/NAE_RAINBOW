global class MicrositeImageFix_Batch implements Database.Batchable<sobject>{ 
   
   global Database.QueryLocator start(Database.BatchableContext BC){
      string query='select Id, OwnerId, Photo_Id__c from Micro_Site__c where Photo_Id__c != null';
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<Micro_Site__c> scope){
     for(Micro_Site__c ms : scope){
     	 //fetch image content from document 
     	 Document d = [Select d.Url, d.Type, d.Name, d.IsPublic, d.Id, d.FolderId, d.ContentType, d.BodyLength, d.Body From Document d where Id=:ms.Photo_Id__c];
     	 //create attachement
     	 Attachment a = new Attachment();
     	 a.ParentId = ms.Id;
     	 a.OwnerId = ms.OwnerId;
     	 a.ContentType = d.ContentType;
     	 a.Body = d.Body;
     	 a.Name = d.Name;
     	 insert a;
     	 //update microsite
     	 ms.Photo_Id__c = a.id;
     	 update ms;
     	 
     	 
     }
   }

   
   global void finish(Database.BatchableContext BC){
   
   }
}