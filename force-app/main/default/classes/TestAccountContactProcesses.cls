@isTest
private class TestAccountContactProcesses {
    //test method for weekly attendance page
    static testMethod void testAccountEmailHandling(){
        Account a =  new Account();
        a.LastName = 'Last Name';
        a.RecordTypeId = [select Id from RecordType where SObjectType = 'Account' AND DeveloperName='PersonAccount'].Id;
        a.PersonEmail = 'p1@e1.com';
        a.Contact_Alternate_Email__pc = 'p1@e2.com';
        //a.Email_2__c = 'p2@e1.com';
        //a.Second_Parent_Email_1__c = 'p2@e2.com';
        insert a;
        
        Id massEmailRecordTypeId = [select Id from RecordType where SObjectType='Contact' AND DeveloperName = 'Mass_Email' limit 1].Id;
        Contact massEmail0 =  new Contact();
        massEmail0.LastName = 'LastName';
        massEmail0.Email = 'test@test.com';
        massEmail0.Main_Parent_File__c = a.Id;
        massEmail0.RecordTypeId = massEmailRecordTypeId;
        insert massEmail0;
        
        list<Contact> clist =  new List<Contact>();
        
        Contact massEmail1 =  new Contact();
        massEmail1.LastName = 'LastName';
        massEmail1.Email = 'p1@e1.com';
        massEmail1.Main_Parent_File__c = a.Id;
        massEmail1.RecordTypeId = massEmailRecordTypeId;
        clist.add(massEmail1);
        
        Contact massEmail2 =  new Contact();
        massEmail2.LastName = 'LastName';
        massEmail2.Email = 'p1@e2.com';
        massEmail2.Main_Parent_File__c = a.Id;
        massEmail2.RecordTypeId = massEmailRecordTypeId;
        clist.add(massEmail2);
        
        Contact massEmail3 =  new Contact();
        massEmail3.LastName = 'LastName';
        massEmail3.Email = 'p2@e1.com';
        massEmail3.Main_Parent_File__c = a.Id;
        massEmail3.RecordTypeId = massEmailRecordTypeId;
        clist.add(massEmail3);
        
        Contact massEmail4 =  new Contact();
        massEmail4.LastName = 'LastName';
        massEmail4.Email = 'p2@e2.com';
        massEmail4.Main_Parent_File__c = a.Id;
        massEmail4.RecordTypeId = massEmailRecordTypeId;
        clist.add(massEmail4);
        
        insert clist;
        
        delete massEmail4;
        
        undelete massEmail4;
        
    }
    
    //test method for portal user creation and chatter group membership
    static testMethod void testAccountPortalUser(){
        
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***1=');
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name1';
        parentAccount.LastName =  'Last Name2';
        parentAccount.PersonEmail = 'testunique1@test.com';
        parentAccount.Contact_Alternate_Email__pc = 'testunique2@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        parentAccount.Primary_Contact__c = 'First Parent';
        insert parentAccount;
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***2=');
        //create custom setting values
        Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
        mapping.Account_Id__c = companyAccount.Id;
        mapping.Name =  UserInfo.getName();
        mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
        insert mapping;
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***3=');
        //create setting
        User u = [select School__c,Id from User where Id=:UserInfo.getUserId()];
        School_Logo_Mapping__c portal =  new School_Logo_Mapping__c();
        portal.Name = 'Test';
        portal.School_Full_Name__c = u.School__c;
        portal.Auto_Portal_User_Creation__c = true;
        portal.Logo_URL__c = 'test';
        portal.Auto_Portal_User_Creation__c = true;
        insert portal;
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***4=');
        Id networkId;
        for(Network n:[Select Id,Name from Network limit 1]){
            networkId = n.Id;
        }
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***5=');
        //create portal chatter group
        CollaborationGroup chatterGroup =  new CollaborationGroup();
        chatterGroup.Name = 'Test Group 99999';
        chatterGroup.NetworkId = networkId;
        chatterGroup.CollaborationType = 'Private';
        chatterGroup.OwnerId = UserInfo.getUserId();
        insert chatterGroup;
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***6=');
        //create student group
        Group__c grp  =  new Group__c();
        grp.Name = 'Test Group';
        grp.Group_Type__c = 'Tutor Group';
        grp.Chatter_Group_Id__c = chatterGroup.Id;
        grp.Year_Group_Control__c = 'Tutor Group UK';
        grp.Year_Group__c = 'Year 1';
        insert grp;
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***7=');
        //create student
        Opportunity o =  new Opportunity();
        o.Student_Surname__c =  'Surname';
        o.Name = 'First Name';
        o.Gender__c = 'Male';
        o.Year_Group__c = 'PN1';
        o.Birth_Date__c =  Date.today().addYears(-10);
        o.Application_Date__c = Date.today().addDays(-20);
        o.Starting_Date__c =  Date.today().addDays(-10);
        o.StageName = 'A/ Testing';
        o.AccountId = parentAccount.Id;
        //o.Payer__c = companyAccount.Id;
        o.CloseDate =  Date.today();
        o.Student_Name__c = 'SN';
        o.Class__c = 'A';
        insert o;
        o.StageName = 'Enrolled';
        update o;
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***8=');
        Contact c = [select Id from Contact where AccountId=:parentAccount.Id];
        
        Test.startTest();
        /*
        //create registration record
        Registration__c r = new Registration__c();
        r.Student__c = c.Id;
        r.Group__c = grp.Id;
        r.Active__c = true;
        
        insert r;
        
        */ 
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***parentAccount='+[select Id,Portal_User_Creation_Error__c,Family_Status__c,Trigger_Parent_User_Creation__c, User__pc from Account where Id=:parentAccount.Id]);
        update parentAccount;
        System.debug('***TestAccountContactProcesses***testAccountPortalUser***9');
        Test.stopTest();
    }
}