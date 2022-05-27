public without sharing class LC06_ViewDuplicate {
    /**************************************************************************************
    -- - Author        : Spoon Consulting
    -- - Description   : Apex controller for LC06_ViewDuplicates
    --
    -- Maintenance History: 
    --
    -- Date         Name  Version  Remarks 
    -- -----------  ----  -------  ------------------------------------------------------- 
    -- 11-JUN-2018  RRAJ   1.0     Initial Version
    -- 21-APR-2021  FKH    1.1     Case 3305 FKH - business account contacts rule
    -- 25-MAY-2021  VJA    1.2     Added public access to attributes
    --------------------------------------------------------------------------------------
    **************************************************************************************/
     
        public static List<Id> lstRecIdCon = new List<Id>();
        public static List<Id> lstRecId = new List<Id>();


        public static void fillDuplicateList(List<ID> globalList, ID recordId, Boolean isLC24){ //identify duplicates
            for(Datacloud.FindDuplicatesResult findDupeResult : Datacloud.FindDuplicatesByIds.findDuplicatesByIds(new List<Id>{ recordId })){
                if(findDupeResult.isSuccess()){
                    for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()){
                        for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                            for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                                globalList.add(matchRecord.getRecord().Id);
                                if(isLC24)
                                    globalList.add(recordId); // need to see the contact itself along with duplicates
                            }
                        }
                    }
                }
            }
        }
        @AuraEnabled
        public static List<DupRecord> getDuplicates(Id recordId){
    
            fillDuplicateList (lstRecId, recordId, false);

    
            List<DupRecord> lstDupRec = new List<DupRecord>();
    
            if(lstRecId.size() > 0){
                Set<String> setSchoolCode = new Set<String>();
                Set<String> setLeadUser = new Set<String>();
                Map<String, String> mapUserIdSchoolCode = new Map<String, String>();
                Map<String, School__c> mapSchCodeToSch = new Map<String, School__c>();
    
                for(Account acc : [SELECT Id, Name, OwnerId, Owner.Name, Owner.SchoolCode__c FROM Account WHERE Id IN :lstRecId]){
                    setSchoolCode.add(acc.Owner.SchoolCode__c);
                    lstDupRec.add(new DupRecord(acc.Name, acc.Id, acc.Owner.Name, acc.OwnerId, 'standard:account', acc.Owner.SchoolCode__c));
                    System.debug('OLAA');
                }
    
                for(Lead led : [SELECT Id, Name, OwnerId, Owner.Name FROM Lead WHERE Id IN :lstRecId]){
                    setLeadUser.add(led.OwnerId);
                    lstDupRec.add(new DupRecord(led.Name, led.Id, led.Owner.Name, led.OwnerId, 'standard:lead', null));
                }
    
                for(Contact con : [SELECT Id, Name, OwnerId, Owner.Name, Owner.SchoolCode__c  FROM Contact WHERE Id IN :lstRecId]){
                    setSchoolCode.add(con.Owner.SchoolCode__c);
                    lstDupRec.add(new DupRecord(con.Name, con.Id, con.Owner.Name, con.OwnerId, 'standard:contact', con.Owner.SchoolCode__c));   
                }
    
                for(User usr :[SELECT Id, SchoolCode__c FROM User WHERE Id IN :setLeadUser]){
                    setSchoolCode.add(usr.SchoolCode__c);
                    mapUserIdSchoolCode.put(usr.Id, usr.SchoolCode__c);
                }
    
                for(School__c school : [SELECT Id, Name, SchoolCode__c FROM School__c WHERE SchoolCode__c IN : setSchoolCode]){
                    mapSchCodeToSch.put(school.SchoolCode__c, school);
                }
    
                for(DupRecord dup : lstDupRec) {
                    if(String.isNotEmpty(dup.schoolCode)) {
                        dup.schoolName = mapSchCodeToSch.get(dup.schoolCode).Name;
                        dup.schoolId = mapSchCodeToSch.get(dup.schoolCode).Id;
                    } else {
                        if(mapUserIdSchoolCode.size() > 0) {
                            String schoolCode = mapUserIdSchoolCode.get(dup.ownerId);
                            if(String.isNotBlank(schoolCode)) {
                                dup.schoolName = mapSchCodeToSch.get(schoolCode).Name;
                                dup.schoolCode = schoolCode;
                                dup.schoolId = mapSchCodeToSch.get(dup.schoolCode).Id;
                            }   
                        }
                    }
                }
            }
    
            return lstDupRec;
        }    

        @AuraEnabled
        public static List<DupRecord> getDuplicatesCon(Id recordId){
            List <Contact> lstCon1= new List <Contact>();
            List <Account> lstAcc= new List <Account>();
            lstAcc = [select id, (select id from Contacts) from account where id =: recordId limit 1];
            lstCon1 = lstAcc[0].Contacts;
            system.debug('lstCon1' + lstCon1);

            for (Contact c: lstCon1){
                fillDuplicateList (lstRecIdCon, c.id, true);
            }
            system.debug('lstRecIdCon' + lstRecIdCon);

            List<DupRecord> lstDupRec = new List<DupRecord>();
    
            if(lstRecIdCon.size() > 0){  
                for(Contact con : [SELECT Id, Name, SchoolofInterest__c, SchoolofInterest__r.Name, SchoolofInterest__r.SchoolCode__c, OwnerId, Owner.Name, Owner.SchoolCode__c  FROM Contact WHERE Id IN :lstRecIdCon]){
                    DupRecord dup = new DupRecord(con.Name, con.Id, con.Owner.Name, con.OwnerId, 'standard:contact', con.SchoolofInterest__r.SchoolCode__c);
                    dup.schoolName = con.SchoolofInterest__r.Name;
                    dup.schoolId = con.SchoolofInterest__c;
                    lstDupRec.add(dup);   
                }
            }
    
            return lstDupRec;
        }

        //VJA20210525 - Added public access to attributes
        public class DupRecord{
            @AuraEnabled public String iconType {get; set;}
            @AuraEnabled public String name {get; set;}
            @AuraEnabled public Id recordId {get; set;}
            @AuraEnabled public String ownerName {get; set;}
            @AuraEnabled public Id ownerId {get; set;}
            @AuraEnabled public String schoolCode {get; set;}
            @AuraEnabled public String schoolName {get; set;}
            @AuraEnabled public Id schoolId {get; set;}
    
            public DupRecord(String name, Id recordId, String ownerName, Id ownerId, String iconType, String schoolCode){
                this.iconType = iconType;
                this.name = name;
                this.recordId = recordId;
                this.ownerName = ownerName;
                this.ownerId = ownerId;
                this.schoolCode = schoolCode;
            }
        }
    }