global class BAT03_DeleteDuplicateRecordSet implements Database.Batchable<sObject>  , Database.Stateful, Schedulable {
    global String query;
    global String results = '';
    
    global BAT03_DeleteDuplicateRecordSet () {
        query = 'Select id, DuplicateRecordSetId, recordid from duplicaterecorditem'; 
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<duplicaterecorditem> lstdri = new List<duplicaterecorditem>();
        lstdri = scope; 
        Set<duplicaterecorditem> setToDel = new Set< duplicaterecorditem>();
        for(duplicaterecorditem DRI:  lstdri ){
            Id sid = DRI.recordid;
            if(sid.getSObjectType().getDescribe().getName() == 'Lead'){
                try{
                    setToDel.add(DRI);
                    List<Lead> l=new List<Lead>();
                    l.add(new Lead(id = DRI.recordid));
                    System.debug(l);
                    Datacloud.FindDuplicatesResult[] results = Datacloud.FindDuplicates.findDuplicates(l);
                    for (Datacloud.FindDuplicatesResult findDupeResult : results) {
                        for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()) {
                            for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                                for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                                    setToDel.remove(DRI);
                                    System.debug('##');
                                    System.debug(matchRecord);
                                }
                            }
                        }
                    }
                }catch(Exception e) {}
            }

            if(sid.getSObjectType().getDescribe().getName() == 'Account'){
                try{
                    setToDel.add(DRI);
                    List<Account> l=new List<Account>();
                    l.add(new Account(id = DRI.recordid));
                    System.debug(l);
                    Datacloud.FindDuplicatesResult[] results = Datacloud.FindDuplicates.findDuplicates(l);
                    for (Datacloud.FindDuplicatesResult findDupeResult : results) {
                        for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()) {
                            for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                                for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                                    setToDel.remove(DRI);
                                    System.debug('##');
                                    System.debug(matchRecord);
                                }
                            }
                        }
                    }
                }catch(Exception e) {}
            }
           
            if(sid.getSObjectType().getDescribe().getName() == 'Contact'){
                try{
                    setToDel.add(DRI);    
                    List<Contact> l=new List<Contact>();
                    l.add(new Contact(id = DRI.recordid));
                    System.debug(l);
                    Datacloud.FindDuplicatesResult[] results = Datacloud.FindDuplicates.findDuplicates(l);
                    for (Datacloud.FindDuplicatesResult findDupeResult : results) {
                        for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()) {
                            for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                                for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                                    setToDel.remove(DRI);
                                    System.debug('##');
                                    System.debug(matchRecord);
                                }
                            }
                        }
                    }
                }catch(Exception e) {}
            }

            try{
                if(setToDel.size()> 0){
                    List<duplicaterecorditem> lstd = new List<duplicaterecorditem>();
                    lstd.addAll(setToDel);
                    //Delete lstd;
                    Database.delete(lstd, false);
                } 
            }catch(Exception e) {}
        }
    }    
    
    global void finish(Database.BatchableContext BC) {
        
    }   
    
    global void execute (SchedulableContext sc){
        BAT03_DeleteDuplicateRecordSet batchObj = new BAT03_DeleteDuplicateRecordSet();
        Database.executeBatch(batchObj , 1);
    }
}