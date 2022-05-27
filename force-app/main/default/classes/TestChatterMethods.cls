@isTest
private class TestChatterMethods {
    //test method for assessment reports 
    static testMethod void testStudentGroupChatterMethods(){
        //create test data 
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.LastName =  'Parent Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert companyAccount;
        
        Id parentAccountId;
        Id userId;
        //for(User u:[Select Id,AccountId from User where Is_Portal_User__c=true AND IsActive = true AND AccountId != null]){
        for(User u:[Select Id,Contact.AccountId from User where Is_Portal_User__c=true AND IsActive = true AND Contact.AccountId != null]){
            parentAccountId = u.Contact.AccountId;
            userId = u.Id;
        }
        
        
        //create custom setting values
        Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
        mapping.Account_Id__c = companyAccount.Id;
        mapping.Name =  UserInfo.getName();
        mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
        insert mapping;
        
        //create student opportunities
        List<Opportunity> oppList =  new List<Opportunity>();
        for(integer i=1;i<11;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today();
            o.Starting_Date__c =  Date.today();
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccountId;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today();
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        
        insert oppList;
        for(Opportunity o:oppList){
            o.StageName = 'Enrolled';
        }
        update oppList;
        //create student group
        Group__c grp  =  new Group__c();
        grp.Name = 'Test Group';
        grp.Group_Type__c = 'Tutor Group';
        grp.Year_Group_Control__c = 'Tutor Group UK';
        grp.Year_Group__c = 'Year 1';
        insert grp;
        
        //create group registrations
        Id studentRTId  = [Select Id from RecordType where SobjectType='Contact' AND DeveloperName='Student'].Id;
        List<Registration__c> rList  =  new List<Registration__c>();
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled' AND Admissions_File__r.StageName = 'Enrolled'] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        
        
        Test.startTest();
        
            //for registration trigger
        boolean flag =  true;
        for(Opportunity o:oppList){
            if(flag == true){
                o.StageName = 'Left';
                flag = false;
            }else{
                flag = true;
            } 
        }
        update oppList;
        
        for(Opportunity o:oppList){
            o.StageName = 'Left';
        }
        update oppList;
        
        for(Opportunity o:oppList){
            o.StageName = 'Enrolled';
        }
        update oppList;
                        
        Test.stopTest();
    }
    
    //test method for assessment reports 
    static testMethod void testStudentGroupChatterMethods2(){ 
        //create test data 
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.LastName =  'Person Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert companyAccount;
        
        Id parentAccountId;
        Id userId;
        //for(User u:[Select Id,AccountId from User where Is_Portal_User__c=true AND IsActive = true AND AccountId != null]){
        for(User u:[Select Id,Contact.AccountId from User where Is_Portal_User__c=true AND IsActive = true AND Contact.AccountId != null]){
            parentAccountId = u.Contact.AccountId;
            userId = u.Id;
        }
        
        
        //create custom setting values
        Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
        mapping.Account_Id__c = companyAccount.Id;
        mapping.Name =  UserInfo.getName();
        mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
        insert mapping;
        
        //create student opportunities
        List<Opportunity> oppList =  new List<Opportunity>();
        for(integer i=1;i<11;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today();
            o.Starting_Date__c =  Date.today();
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccountId;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today();
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        
        insert oppList;
        for(Opportunity o:oppList){
            o.StageName = 'Enrolled';
        }
        update oppList;
        //create student group
        Group__c grp  =  new Group__c();
        grp.Name = 'Test Group';
        grp.Group_Type__c = 'Tutor Group';
        grp.Year_Group_Control__c = 'Tutor Group UK';
        grp.Year_Group__c = 'Year 1';
        insert grp;
        
        //create group registrations
        Id studentRTId  = [Select Id from RecordType where SobjectType='Contact' AND DeveloperName='Student'].Id;
        List<Registration__c> rList  =  new List<Registration__c>();
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled' AND Admissions_File__r.StageName = 'Enrolled'] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        
        
        Test.startTest();
            //set page reference 
            PageReference pg = Page.PortalStudentGroupChatter;
            Test.setCurrentPageReference(pg);
            ApexPages.StandardController s =  new ApexPages.StandardController(grp);
            PortalStudentGroupChatter_Controller controller0 =  new PortalStudentGroupChatter_Controller(s);
            //create school setting
            String schoolName = [Select Id, School__c from User where Id=:UserInfo.getUserId()].School__c;
            Id networkId;
            //System.debug('***TestChatterMethods***testStudentGroupChatterMethods***networks='+[Select Id,Name from Network]);
            for(Network n:[Select Id,Name from Network limit 1]){
                networkId = n.Id;
            }
            School_Logo_Mapping__c schoolMapping =  new School_Logo_Mapping__c();
            schoolMapping.Name = 'Test Mapping';
            schoolMapping.Logo_URL__c = 'test';
            schoolMapping.School_Full_Name__c = schoolName;
            schoolMapping.Auto_Portal_User_Creation__c = true;
            insert schoolMapping;
            PortalStudentGroupChatter_Controller controller1 =  new PortalStudentGroupChatter_Controller(s);
            schoolMapping.Community_Id__c = networkId;
            update schoolMapping;
            PortalStudentGroupChatter_Controller controller =  new PortalStudentGroupChatter_Controller(s);
            controller.cancel();
            controller.createChatterGroup();
            controller.addNewParents(); 
            //check for group 
            Group__c g = [select Chatter_Group_Id__c from Group__c where Id=:grp.Id];
            if(g.Chatter_Group_Id__c != null){
                CollaborationGroup cg =  new CollaborationGroup(Id = g.Chatter_Group_Id__c);
                delete cg; 
            }
                        
        Test.stopTest();
    }
}