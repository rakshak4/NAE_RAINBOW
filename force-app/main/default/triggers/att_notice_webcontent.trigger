trigger att_notice_webcontent on Attachment (after insert, after delete) {
system.debug('--- this is test-----');
List<sobject> listAtts = new List<sobject>();
      map<Id,set<Id>> mapAttsIds = new map<Id,set<Id>>();
      Id sobjId;
      if(trigger.isinsert){
          for(Attachment att : trigger.New){               
             if(!mapAttsIds.containskey(att.ParentId)){
                    mapAttsIds.put(att.ParentId,new set<id>());
             }
             mapAttsIds.get(att.ParentId).add(att.Id);
             sobjId=att.ParentId;
          }
          if(mapAttsIds.size()>0){
          String sObjectName = sobjId.getSobjectType().getDescribe().getName();
            try{
                for(Sobject sobj : Database.query('Select id,Attachment_Id__c from '+sObjectName+' WHERE Id=:sobjId')){
                      for(Id athid:mapAttsIds.get((Id)sobj.get('Id'))){                          
                          if(sobj.get('Attachment_Id__c')==null){                         
                              sobj.put('Attachment_Id__c',String.ValueOf(athid));    
                          }
                          else{
                          system.debug('-----------------sobj3-------------------------');
                              String s=String.ValueOf( sobj.get('Attachment_Id__c'));
                              s+=','+String.ValueOf(athid);                             
                              sobj.put('Attachment_Id__c', s); 
                          }
                      }
                      listAtts.add(sobj);                    
                                    
                }
                if(listAtts.size()>0){                
                   update listAtts;
                }
            }
            catch(exception ex){
                system.debug('----- exception ------'+ex);
            }
          }
      }
      if(trigger.isafter && trigger.isdelete){
          for(Attachment att : trigger.old){               
             if(!mapAttsIds.containskey(att.ParentId)){
                    mapAttsIds.put(att.ParentId,new set<id>());
             }
             mapAttsIds.get(att.ParentId).add(att.Id);
            sobjId=att.ParentId;
          }         
          if(mapAttsIds.size()>0){
          String sObjectName = sobjId.getSobjectType().getDescribe().getName();
            try{
                for(Sobject sobj : Database.query('Select id,Deleted_Attachment_Id__c from '+sObjectName+' WHERE Id=:sobjId')){
                      for(Id athid:mapAttsIds.get((Id)sobj.get('Id'))){                          
                          if(sobj.get('Deleted_Attachment_Id__c')==null){                         
                              sobj.put('Deleted_Attachment_Id__c',String.ValueOf(athid));    
                          }
                          else{
                          system.debug('-----------------sobj3-------------------------');
                              String s=String.ValueOf( sobj.get('Deleted_Attachment_Id__c'));
                              s+=','+String.ValueOf(athid);                             
                              sobj.put('Deleted_Attachment_Id__c', s); 
                          }
                      }
                      listAtts.add(sobj);                    
                                    
                }
                if(listAtts.size()>0){                
                   update listAtts;
                }
            }
            catch(exception ex){
                system.debug('----- exception ------'+ex);
            }
          }
      } 
}