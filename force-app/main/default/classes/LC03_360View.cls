public with sharing class LC03_360View {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : Apex Controller for lightning component LC03_360View
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 14-DEC-2017  RRAJ    1.0     Initial version
-- 14-MAY-2018  AMU     2.0     Updated version with relationship for family and contacts
-- 12-DEC-2018  ANA     2.1     Modified updatePrimaryContact to allow multiple primary contacts (C1504)
--------------------------------------------------------------------------------------
***************************************************************************************/

   /**
    * retrieve list of opportunities and contacts based on recordId
    * @param      recordId  The record identifier
    * @return     Map of contacts, opportunities and accounts.
    */
    @AuraEnabled
    public static Object getfamilyView(Id recordId) {
        List<Opportunity> lstOpp;
        List<AccountContactRelation> lstContacts;
        Set<String> setAccName;
        Map<String, Object> mapResult = new Map<String, Object>();

        String sObjectType = String.valueOf(recordId.getsObjectType());

        if(sObjectType == AP_Constant.accObject) {
            lstOpp = getOpp(new Set<String>{recordId});
            mapResult = getContacts(new Set<String>{recordId});

        } else if(sObjectType == AP_Constant.conObject) {
            Set<String> setAccId = getSetAccId(recordId);
            lstOpp = getOpp(setAccId);
            mapResult = getContacts(setAccId);

        } else if(sObjectType == AP_Constant.oppObject) {
            List<Opportunity> lstSingleOpp = [SELECT Id, Child__c, Child__r.Birthdate FROM Opportunity WHERE Id = :recordId];
            if (lstSingleOpp.size()>0){
                if(String.isNotBlank(lstSingleOpp[0].Child__c)) {
                    Set<String> setAccId = getSetAccId(lstSingleOpp[0].Child__c);
                    lstOpp = getOpp(setAccId);
                    mapResult = getContacts(setAccId);
                }
            }
        }
        
        mapResult.put('lstOpp', lstOpp);
        return mapResult;
    }



    /**
    * update primary contact
    * @param      accContStr  The acc container string
    * @param      contactId   The contact identifier
    * @param      isPrimary   Indicates if primary
    * @return     Map of results 
    */
    @AuraEnabled
    public static Object updatePrimaryContact(String accId, String contId, Integer isPrimaryCounter) {
        try {

            List<Account> lstAcc = new List<Account>();

            if(Integer.valueOf(isPrimaryCounter) == 1 ){ 
            //set PrimaryContact's value to ContId and set secondaryContact's value to null
                lstAcc.add(new Account(Id = accId, PrimaryContact__c = contId, SecondaryContact__c = null));
            }

            if(Integer.valueOf(isPrimaryCounter) == 2){
            //Set secondaryContact value (PrimaryContact Value is already set when counter is 2)
                lstAcc.add(new Account(Id = accId, SecondaryContact__c = contId));
            }

            if(Integer.valueOf(isPrimaryCounter) == 0){
            //isPrimaryCounter == 0 --> Set PrimaryContact And SecondaryContact to Null
                lstAcc.add(new Account(Id = accId, PrimaryContact__c = null, SecondaryContact__c = null));
            }           
            
            if(lstAcc.size() > 0) {
                update lstAcc;
            }

            return new Map<String,Object>{'success' => true, 'message' => ''};
        } catch(Exception e) {
            System.debug('/// Error Primary Contact '+e.getMessage());
            return new Map<String,Object>{'success' => false, 'message' => e.getMessage()};
        }
    }
    

    /**
     * Update financial contact
     * @param      accContStr  List of ContactCustom in JSON 
     * @return     Map of results.
     */
    @AuraEnabled
    public static Object updateFinancialContact(String accId, String contId, Integer isFinancialCounter) {
        try {
            List<Account> lstAcc = new List<Account>();

            if(Integer.valueOf(isFinancialCounter) == 1 ){ 
            //set PrimaryContact's value to ContId and set secondaryContact's value to null
                lstAcc.add(new Account(Id = accId, FinancialContact__c = contId, SecondaryFinancialContact__c = null));
            }

            if(Integer.valueOf(isFinancialCounter) == 2){
            //Set secondaryContact value (PrimaryContact Value is already set when counter is 2)
                lstAcc.add(new Account(Id = accId, SecondaryFinancialContact__c = contId));
            }

            if(Integer.valueOf(isFinancialCounter) == 0){
            //isPrimaryCounter == 0 --> Set PrimaryContact And SecondaryContact to Null
                lstAcc.add(new Account(Id = accId, FinancialContact__c = null, SecondaryFinancialContact__c = null));
            }           
            
            if(lstAcc.size() > 0) {
                system.debug(lstAcc);
                update lstAcc;
            }

            return new Map<String,Object>{'success' => true, 'message' => ''};
    } catch(Exception e) {
            System.debug('/// Error Financial Contact '+e.getMessage());
            return new Map<String,Object>{'success' => false, 'message' => e.getMessage()};
        }
    }

    
    /**
    * @description 
    * @author CRA | 04/11/2019 
    * @param accId 
    * @param contId 
    * @param isMergedCounter 
    * @return Object 
    **/
    // @AuraEnabled //CRA20200723 - Comment due to Merge Functionality Non usage
    // public static Object updateFamilyContact(String accId, String contId, String contSecondId, Integer isMergedCounter, Boolean status) {
    //     try {
    //         AP26_FamilyContact.mergeContact(contId, contSecondId, accId, status);

    //         return new Map<String,Object>{'success' => true, 'message' => ''};
    // } catch(Exception e) {
    //         System.debug('/// Error Merged Contact '+e.getMessage());
    //         return new Map<String,Object>{'success' => false, 'message' => e.getMessage()};
    //     }
    // }

    @AuraEnabled
    public static Boolean getProfileInfo(){
        try{
            List<Profile> lstSingleProfile = [SELECT Id, Name FROM Profile WHERE Id =:UserInfo.getProfileId() AND (Name = 'Admissions Officer' OR Name = 'Champion/Super User')];
            if (lstSingleProfile.size()>0 && lstSingleProfile[0]!=null){
                 return false;
            }
            else {
                return true;
            }
        }catch(Exception e){
            return true;
        }
    }

   /**
    * Gets the set acc identifier.
    * @param      contactId  The contact identifier
    * @return     The set acc identifier.
    */
   public static Set<String> getSetAccId(String contactId) {
        Set<String> setAccId = new Set<String>();
        for(AccountContactRelation accCont : [SELECT AccountId FROM AccountContactRelation WHERE ContactId = :contactId]) {
            setAccId.add(accCont.AccountId);
        }
        return setAccId;
   }

   /**
    * Gets the list of opp associated with the accounts.
    * @param      setAccId  The set account identifier
    * @return     List of opportunities.
    */
    public static List<Opportunity> getOpp(Set<String> setAccId) {
        return [SELECT Id, Name, AccountId, Account.Name, StageName, CloseDate, RecordType.Name, ReferredBy__r.Name, Child__c, Child__r.Birthdate, YearGrade__r.Name, YearGrade__c,
                        ReferredBy__c, Waitlisted__c 
                FROM Opportunity 
                WHERE AccountId IN :setAccId
                ORDER BY CreatedDate desc //ANA20181312 : Case 1471 
                ];
    }

   /**
    * Gets the contacts with a set of their account names.
    * @param      setAccId  The set acc identifier
    * @return     Map of contacts and set of account names.
    */
    public static Map<String, Object> getContacts(Set<String> setAccId) {
        Map<String, String> mapAcc = new Map<String, String>();
        List<AccountCustom> lstAcc = new List<AccountCustom>();
        List<ContactCustom> lstContacts = new List<ContactCustom>();

        Map<String, String> mapAccIdToPrimaryCont = new Map<String, String>();
        Map<String, String> mapAccIdToSecondaryCont = new Map<String, String>();        
        Map<String, String> mapAccIdToFinancialCont = new Map<String, String>();
        Map<String, String> mapAccIdToSecondaryFinancialCont = new Map<String, String>(); 
        Map<String, String> mapConIdToFamilyCont = new Map<String, String>(); 

        for(AccountContactRelation accCont: [SELECT Id, Roles, AccountId, Account.Name, Account.FinancialContact__c, Account.SecondaryFinancialContact__c, Account.PrimaryContact__c, Account.SecondaryContact__c,  Contact.Gender__c,
                                                  ContactId, Contact.FirstName, Contact.LastName, Contact.PreferredName__c, Contact.MiddleName, Contact.NatureOfRelationship__c, Contact.TECH_FamilyContact__c, Contact.TECH_RecordTypeName__c, Contact.MidTiercontactID__c
                                            FROM AccountContactRelation WHERE AccountId IN :setAccId 
                                            ORDER BY Account.Name, Contact.NatureOfRelationship__c DESC]){

           Boolean hasDuplicates = false;
           Boolean isDisabled = false;
           String className = '';
            for(Datacloud.FindDuplicatesResult findDupeResult : Datacloud.FindDuplicatesByIds.findDuplicatesByIds(new List<Id>{accCont.ContactId})){
                if(findDupeResult.isSuccess()){
                    for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()){
                        if(hasDuplicates) break; //afo case 1696
                        for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                            hasDuplicates = matchResult.getMatchRecords().size() > 0? true : false;
                        }
                    }
                }
            }    

            // if (accCont.Contact.TECH_RecordTypeName__c == 'Child' || accCont.Contact.TECH_RecordTypeName__c == 'Family' || (accCont.Contact.MidTierContactID__c != null) && (accCont.Contact.MidTierContactID__c.contains('.'))) {
            //     isDisabled = true;
            //     if (accCont.Contact.MidTierContactID__c != null && accCont.Contact.MidTierContactID__c.contains('.') && accCont.Contact.TECH_FamilyContact__c != null) {
            //         className = 'backgroundBlue';
            //     }
            // }        //CRA20200723 - Comment due to Merge Functionality Non usage 

            lstContacts.add(new ContactCustom(accCont.Id, accCont.ContactId, accCont.AccountId, accCont.Contact.FirstName, accCont.Contact.LastName, 
                                                accCont.Contact.MiddleName, accCont.Roles, false, false, accCont.Contact.Gender__c, hasDuplicates, accCont.Contact.PreferredName__c, false, isDisabled, accCont.Contact.MidTierContactID__c, className));

            if(!mapAcc.containsKey(accCont.AccountId)) {
                mapAcc.put(accCont.AccountId, accCont.Account.Name);
                lstAcc.add(new AccountCustom(accCont.Account.Name, accCont.AccountId));
            }

            if(String.isNotBlank(accCont.Account.PrimaryContact__c)) {
                if(!mapAccIdToPrimaryCont.containsKey(accCont.AccountId)) {
                    mapAccIdToPrimaryCont.put(accCont.AccountId, accCont.Account.PrimaryContact__c);
                }
            }

            //ANA20181112: C1504 & W477
            if(String.isNotBlank(accCont.Account.SecondaryContact__c)) {
                if(!mapAccIdToSecondaryCont.containsKey(accCont.AccountId)) {
                    mapAccIdToSecondaryCont.put(accCont.AccountId, accCont.Account.SecondaryContact__c);
                }
            }

            if(String.isNotBlank(accCont.Account.FinancialContact__c)) {
                if(!mapAccIdToFinancialCont.containsKey(accCont.AccountId)) {
                    mapAccIdToFinancialCont.put(accCont.AccountId, accCont.Account.FinancialContact__c);
                }
            }

            //ANA20181112: C1504 & W477
            if(String.isNotBlank(accCont.Account.SecondaryFinancialContact__c)) {
                if(!mapAccIdToSecondaryFinancialCont.containsKey(accCont.AccountId)) {
                    mapAccIdToSecondaryFinancialCont.put(accCont.AccountId, accCont.Account.SecondaryFinancialContact__c);
                }
            }

            //CRA20190411: Case 00002087
            if(String.isNotBlank(accCont.Contact.TECH_FamilyContact__c)) {
                if(!mapConIdToFamilyCont.containsKey(accCont.ContactId)) {
                    mapConIdToFamilyCont.put(accCont.ContactId, accCont.Contact.TECH_FamilyContact__c);
                }
            }
        }

        for(ContactCustom cont: lstContacts) {
            if(cont.contId == mapAccIdToPrimaryCont.get(cont.accId) || cont.contId == mapAccIdToSecondaryCont.get(cont.accId)) {
                cont.isPrimary = true;
            }else{
                cont.isPrimary = false;
            }
            

            if(cont.contId == mapAccIdToFinancialCont.get(cont.accId) || cont.contId == mapAccIdToSecondaryFinancialCont.get(cont.accId)) {
                cont.isFinancial = true;
            } else {
                cont.isFinancial = false;
            }

            //CRA20190411: Case 00002087 //CRA20200723 - Comment due to Merge Functionality Non usage
            // if (mapConIdToFamilyCont.containsKey(cont.contId)) {
            //     cont.isMerged = true;
            // }
        }
        return new Map<String, Object>{'lstContacts' => lstContacts,'lstAcc' => lstAcc};
    }

    /**
     * Class for custom Contact
     */
    public class ContactCustom {
        @AuraEnabled public String accContId;
        @AuraEnabled public String contId;
        @AuraEnabled public String accId;
        @AuraEnabled public String fname;
        @AuraEnabled public String lname;
        @AuraEnabled public String pname;
        @AuraEnabled public String gender;
        @AuraEnabled public String relationship;
        @AuraEnabled public Boolean isPrimary;
        @AuraEnabled public Boolean isFinancial;
        @AuraEnabled public Boolean hasDuplicates;
        @AuraEnabled public String prname;
        @AuraEnabled public Boolean isMerged;
        @AuraEnabled public Boolean isDisabled;       
        @AuraEnabled public String midTierID;   
        @AuraEnabled public String className;

        public ContactCustom(String accContId, String contId, String accId, String fname, String lname, String pname, String relationship, 
                             Boolean isPrimary, Boolean isFinancial, String gender, Boolean hasDuplicates, String prname, Boolean isMerged, Boolean isDisabled, String midTierID, String className){
                                 this.accContId = accContId;
                                 this.contId = contId;
                                 this.accId = accId;
                                 this.fname = fname;
                                 this.lname = lname;
                                 this.pname = pname;
                                 this.relationship = relationship;
                                 this.isPrimary = isPrimary;
                                 this.isFinancial = isFinancial;
                                 this.gender = gender;
                                 this.hasDuplicates = hasDuplicates;
                                 this.prname = prname;
                                 this.isMerged = isMerged;
                                 this.isDisabled = isDisabled;
                                 this.midTierID = midTierID;
                                 this.className = className;
                             }
    }

    /**
     * Class for custom Account
     */
    public class AccountCustom {
        @AuraEnabled public String name;
        @AuraEnabled public String accId;

        public AccountCustom(String name, String accId){
            this.name = name;
            this.accId = accId;
        }
    }
}