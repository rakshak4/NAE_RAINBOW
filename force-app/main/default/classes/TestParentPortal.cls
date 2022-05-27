/***
    Author: Kunal Sharma
    Created Date: 20 June 2013
    Desc: Test methods for parent portal
***/

@isTest
private class TestParentPortal {   
    //test method for assessment reports 
    static testMethod void testPortalAssessments(){
        //create test data 
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        
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
            o.Application_Date__c = Date.today().addDays(-45);
            o.Starting_Date__c =  Date.today().addDays(-45);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
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
        grp.Year_Group__c = 'Year 1';
        grp.Year_Group_Control__c = 'Tutor Group UK';
        insert grp;
        
        //create group registrations
        Id studentRTId  = [Select Id from RecordType where SobjectType='Contact' AND DeveloperName='Student'].Id;
        List<Registration__c> rList  =  new List<Registration__c>();
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled'] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        //create assessment folders
        Id assessmentFolderRT = [Select Id from RecordType where SobjectType='Assesment__c' AND DeveloperName='Assessment_Folder'].Id;
        Assesment__c progressReport =  new Assesment__c();
        progressReport.Title__c = 'Progress Report';
        progressReport.Type__c = 'Progress Report';
        progressReport.RecordTypeId = assessmentFolderRT;
        progressReport.Assessment_Date__c =  Date.today();
        progressReport.Description__c = 'dfdddd';
        progressReport.Group__c = grp.Id;
        //progressReport.Publish__c =  true;
        insert progressReport;
        //create assessments 
        Id assessmentRecordRT = [Select Id from RecordType where SobjectType='Assesment__c' AND DeveloperName='Assessment_Record'].Id;
        List<Assesment__c> assessments  = new List<Assesment__c>();
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled'] ){
            Assesment__c assessment =  new Assesment__c();
            assessment.Student__c =  c.Id;
            assessment.RecordTypeId = assessmentRecordRT;
            assessment.Achievement__c = 'Good';
            assessment.Assessment_Date__c =  Date.today();
            assessment.Assessment_Folder__c = progressReport.Id;
            assessment.Grade__c = 'A';
            assessment.Effort__c = 'Good';
            assessment.Comment__c = 'comments';
            assessment.Group__c =  grp.Id;
            assessment.Is_Approved__c =  true;
            assessment.Approval_Comments__c =  'comments';
            assessments.add(assessment);
        }
        if(assessments.size() > 0) {
            insert assessments;
        }
        Test.startTest();
            //set page reference 
            PageReference pg = Page.PortalAssessmentPage;
            pg.getParameters().put('accid',parentAccount.Id);
            Test.setCurrentPageReference(pg);
            ParentPortalAssessment_Controller controller =  new ParentPortalAssessment_Controller();
            controller.filterAssessments();
            controller.reset();
            controller.handleStudentChange();
            controller.handleYearChange();
            controller.printAssessments();
        Test.stopTest();
        
    }
    
    //test method for attendance reports 
    static testMethod void testPortalAttendance(){
        //create test data 
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        
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
            o.Application_Date__c = Date.today().addDays(-45);
            o.Starting_Date__c =  Date.today().addDays(-45);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
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
        grp.Year_Group__c = 'Year 1';
        grp.Year_Group_Control__c = 'Tutor Group UK';
        insert grp;
        
        //create group registrations
        Id studentRTId  = [Select Id from RecordType where SobjectType='Contact' AND DeveloperName='Student'].Id;
        List<Registration__c> rList  =  new List<Registration__c>();
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled'] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        //create attendances
        Id attendanceEvent =  [Select Id from RecordType where SObjectType='Event' AND DeveloperName='Attendance'].Id;
        List<Event> attendances =  new List<Event>();
        String flag  = 'a';
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled'] ){
            Event e  = new Event();
            e.RecordTypeId = attendanceEvent;
            e.WhoId =  c.Id;
            e.WhatId =  grp.Id;
            e.StartDateTime =  Datetime.now();
            e.EndDateTime =  Datetime.now();
            e.Attendance_Type__c = 'First';
            if(flag == 'a'){
                e.Subject = 'Absent';
                flag = 'b';
            }else if(flag == 'b'){
                e.Subject = 'Late';
                flag =  'c';
            }else if(flag  == 'c'){
                e.Subject = 'Present';
                flag =  'd';
            }else if(flag  == 'd'){
                e.Subject = 'Partial';
                flag =  'a';
            }
            
            attendances.add(e);
        }
        if(attendances.size() > 0){
            insert attendances;
        }
        Test.startTest();
            //set page reference 
            PageReference pg = Page.PortalAttendancePage;
            pg.getParameters().put('accid',parentAccount.Id);
            Test.setCurrentPageReference(pg);
            PortalAttendancePage_Controller controller =  new PortalAttendancePage_Controller();
            controller.filterAttendances();
            controller.reset();
        Test.stopTest();
        
    }
    
    //test method for conduct reports 
    static testMethod void testPortalConduct(){
        //create test data 
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        
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
            o.Application_Date__c = Date.today().addDays(-45);
            o.Starting_Date__c =  Date.today().addDays(-45);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-45);
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
        grp.Year_Group__c = 'Year 1';
        grp.Year_Group_Control__c = 'Tutor Group UK';
        insert grp;
        
        //create group registrations
        Id studentRTId  = [Select Id from RecordType where SobjectType='Contact' AND DeveloperName='Student'].Id;
        List<Registration__c> rList  =  new List<Registration__c>();
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled'] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        //create conducts
        Id awardsRT =  [Select Id from RecordType where SObjectType='Conduct__c' AND DeveloperName='Awards'].Id;
        //Id leadershipRT =  [Select Id from RecordType where SObjectType='Conduct__c' AND DeveloperName='Leadership_Roles'].Id;
        Id pastoralRT =  [Select Id from RecordType where SObjectType='Conduct__c' AND DeveloperName='Pastoral'].Id;
        Id housePointsRT =  [Select Id from RecordType where SObjectType='Conduct__c' AND DeveloperName='House_Points'].Id;
        List<Conduct__c> conducts =  new List<Conduct__c>();
        String flag  = 'a'; 
        boolean flagHealthRelated = true;   
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId] ){
            Conduct__c conduct_awards =  new Conduct__c();
            conduct_awards.RecordTypeId = awardsRT;
            conduct_awards.Title__c = flag;
            conduct_awards.Reason__c = 'dddd';
            conduct_awards.Student_Name__c = c.Id;
            conduct_awards.Student_Group__c = grp.Id;
            conduct_awards.Pastoral_Date__c = date.today();
            /*
            Conduct__c conduct_leadership =  new Conduct__c();
            conduct_leadership.RecordTypeId = leadershipRT;
            conduct_leadership.Title__c = flag;
            conduct_leadership.Reason__c = 'dddd';
            conduct_leadership.Student_Name__c = c.Id;
            */
            Conduct__c conduct_pastoral =  new Conduct__c();
            conduct_pastoral.RecordTypeId = pastoralRT;
            conduct_pastoral.Health_Related__c =  flagHealthRelated;
            flagHealthRelated =  !flagHealthRelated;
            conduct_pastoral.Title__c = flag;
            conduct_pastoral.Reason__c = 'dddd';
            conduct_pastoral.Student_Name__c = c.Id;
            conduct_pastoral.Student_Group__c = grp.Id;
            conduct_pastoral.Pastoral_Date__c = date.today();
            
            Conduct__c conduct_housepoints =  new Conduct__c();
            conduct_housepoints.RecordTypeId = housePointsRT;
            conduct_housepoints.House_Points__c = 10;
            conduct_housepoints.Title__c = flag;
            conduct_housepoints.Reason__c = 'dddd';
            conduct_housepoints.Student_Name__c = c.Id;
            conduct_housepoints.Student_Group__c = grp.Id;
            conduct_housepoints.Pastoral_Date__c = date.today();
            
            conducts.add(conduct_awards);
            //conducts.add(conduct_leadership);
            conducts.add(conduct_pastoral);
            conducts.add(conduct_housepoints);
            /*
            if(flag == 'a'){
                conduct.RecordTypeId = awardsRT;
                flag =  'b';
            }else if(flag == 'b'){
                conduct.RecordTypeId = leadershipRT;
                flag = 'c';
            }else if(flag == 'c'){
                conduct.RecordTypeId = pastoralRT;
                conduct.Health_Related__c =  flagHealthRelated;
                flagHealthRelated =  !flagHealthRelated;
                flag = 'd';
            }else if(flag == 'd'){
                conduct.RecordTypeId = housePointsRT;
                conduct.House_Points__c = 10;
                flag = 'a';
            }
            conduct.Title__c = flag;
            conduct.Reason__c = 'dddd';
            conduct.Student_Name__c = c.Id;
            conducts.add(conduct);
            */
        }
        if(conducts.size() > 0){
            insert conducts;
        }
        Test.startTest();
            //set page reference 
            PageReference pg = Page.PortalConductPage;
            pg.getParameters().put('accid',parentAccount.Id);
            Test.setCurrentPageReference(pg);
            PortalConduct_Controller controller =  new PortalConduct_Controller();
            controller.filterConducts();
            controller.reset();
        Test.stopTest();
        
    }
    
    
    
    //test method for assessment approval 
    static testMethod void testParentContactDetails(){
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        Test.startTest();
            //set page reference 
            PageReference pg = Page.PortalConductPage;
            pg.getParameters().put('accid',parentAccount.Id);
            Test.setCurrentPageReference(pg);
            PortalContactPage_Controller controller =  new PortalContactPage_Controller();
            controller.parentAccount.Primary_Contact__c = 'First Parent';
            controller.parentAccount.PersonEmail = null;
            controller.saveAccount();
            controller.parentAccount.PersonEmail = 'test@test.com';
            controller.saveAccount();
            controller.parentAccount.Primary_Contact__c = 'Second Parent';
            //controller.parentAccount.Second_Parent_Email_1__c = null;
            controller.saveAccount();
            //controller.parentAccount.Second_Parent_Email_1__c = 'test@test.com';
            controller.saveAccount();
        Test.stopTest();
    }
    
    //test method for assessment approval 
    static testMethod void testPortalMyContactDetail(){
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount; 
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.Salutation = 'Mr.';
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test999912345@test.com';
        parentAccount.Primary_Contact__c = 'First Parent';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        //insert contact
        Contact parentContact  =  new Contact();
        parentContact.Main_Parent_File__c = parentAccount.Id;
        parentContact.Salutation = 'Mrs.';
        parentContact.FirstName = 'Test';
        parentContact.LastName = 'Test';
        parentContact.Email = 'test9999123456@test.com';
        parentContact.RecordTypeId = [Select Id from RecordType where SObjectType='Contact' AND DeveloperName='Additional_Parent'].Id;
        parentContact.AccountId = companyAccount.Id;
        insert parentContact;
        //update parent account
        parentAccount.Related_Contact_Record_P2__c = parentContact.Id;
        update parentAccount;
        //create parent account user        
        User parentAccountUser =  new User();
        parentAccountUser.FirstName =  'Test';
        parentAccountUser.LastName =  'Parent';
        parentAccountUser.Alias =  'TP';
        parentAccountUser.Email = 'blog-add-notifications@britishschools.co.uk';
        parentAccountUser.CommunityNickname =  'TP';
        parentAccountUser.School__c =  'The British Schools Foundation';
        parentAccountUser.TimeZoneSidKey =  'Europe/London';
        parentAccountUser.LocaleSidKey =  'en_GB';
        parentAccountUser.LanguageLocaleKey = 'en_US';
        parentAccountUser.EmailEncodingKey = 'ISO-8859-1'; 
        parentAccountUser.Primary_Invoice_Currency__c =  'USD';
        parentAccountUser.ProfileId =  [select Id from Profile where Name = 'Parent Portal User - High Volume' limit 1].Id;
        parentAccountUser.ContactId =  [select PersonContactId from Account where Id=:parentAccount.Id].PersonContactId;
        parentAccountUser.CompanyName =  'Parent';
        parentAccountUser.Username = parentAccount.PersonEmail;
        insert parentAccountUser;
        //create parent contact user        
        User parentContactUser =  new User();
        parentContactUser.FirstName =  'Test2';
        parentContactUser.LastName =  'Parent2';
        parentContactUser.Alias =  'TP2';
        parentContactUser.Email = 'blog-add-notifications@britishschools.co.uk';
        parentContactUser.CommunityNickname =  'TP2';
        parentContactUser.School__c =  'The British Schools Foundation';
        parentContactUser.TimeZoneSidKey =  'Europe/London';
        parentContactUser.LocaleSidKey =  'en_GB';
        parentContactUser.LanguageLocaleKey = 'en_US';
        parentContactUser.EmailEncodingKey = 'ISO-8859-1'; 
        parentContactUser.Primary_Invoice_Currency__c =  'USD';
        parentContactUser.ProfileId =  [select Id from Profile where Name = 'Parent Portal User - High Volume' limit 1].Id;
        parentContactUser.ContactId =  parentContact.Id;
        parentContactUser.Portal_Account_Id__c = parentContact.Main_Parent_File__c;
        parentContactUser.CompanyName =  'Parent';
        parentContactUser.Username = parentContact.Email;
        insert parentContactUser;
        
        
            
        Test.startTest();
            //set page reference 
            PageReference pg = Page.PortalMyContactDetail;
            pg.getParameters().put('uid',parentAccountUser.Id);
            pg.getParameters().put('s','1');
            Test.setCurrentPageReference(pg);
            PortalMyContactDetail_Controller controller =  new PortalMyContactDetail_Controller();
            controller.parentAccount.PersonHasOptedOutOfEmail = true; 
            controller.parentAccount.FirstName = 'Changed Name';
            controller.parentAccount.LastName = 'Changed Name';
            controller.parentAccount.PersonEmail = 'Changedemail@test.com';
            controller.saveDetails();
            controller.parentAccount.PersonHasOptedOutOfEmail = false;
            controller.saveDetails();
            
            
            PageReference pg2 = Page.PortalMyContactDetail;
            pg2.getParameters().put('uid',parentContactUser.Id);
            Test.setCurrentPageReference(pg2);
            PortalMyContactDetail_Controller controller2 =  new PortalMyContactDetail_Controller();
            controller2.parentContact.HasOptedOutOfEmail = true;
            controller2.parentContact.FirstName = 'Changed Name';
            controller2.parentContact.LastName = 'Changed Name';
            controller2.parentContact.Email = 'Changedemail2@test.com';
            controller2.saveDetails();
            controller2.parentContact.HasOptedOutOfEmail = false;
            controller2.saveDetails();
        Test.stopTest();
    }
    
    //test method for assessment reports 
    static testMethod void testNewsEvents(){
        //create test data 
        //create company account account
        Account companyAccount =  new Account();
        companyAccount.Name =  'Company Account';
        companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
        insert companyAccount;
        
        //create parent account account
        Account parentAccount =  new Account();
        parentAccount.FirstName =  'First Name';
        parentAccount.LastName =  'Last Name';
        parentAccount.PersonEmail = 'test@test.com';
        parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
        insert parentAccount;
        
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
            o.Application_Date__c = Date.today().addDays(-45);
            o.Starting_Date__c =  Date.today().addDays(-45);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
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
        grp.Year_Group__c = 'Year 1';
        grp.Year_Group_Control__c = 'Tutor Group UK';
        insert grp;
        
        //create group registrations
        Id studentRTId  = [Select Id from RecordType where SobjectType='Contact' AND DeveloperName='Student'].Id;
        List<Registration__c> rList  =  new List<Registration__c>();
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled'] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        //create user for parent 
        map<Id,Account> accountMap =  new map<Id,Account>([select PersonContactId, FirstName,LastName,Contact_Alias__pc, SchoolText__pc,User_TimezoneSidKey__c,User_LocaleSidKey__c,User_Profile_Id__c, User_School_Hub_Video_Link__c, PersonEmail,  PersonMobilePhone,Name,OwnerId, Owner.Primary_Invoice_Currency__c from Account where Id =:parentAccount.Id]); 
        
            Account acc  =  accountMap.get(parentAccount.Id);
            User u =  new User();
            u.FirstName =  acc.FirstName;
            u.LastName =  acc.LastName;
            u.Alias =  acc.Contact_Alias__pc;
            //u.Email =  acc.PersonEmail;
            u.Email = 'blog-add-notifications@britishschools.co.uk';
            u.CommunityNickname =  acc.Name;
            u.School__c =  acc.SchoolText__pc;
            u.TimeZoneSidKey =  acc.User_TimezoneSidKey__c;
            u.LocaleSidKey =  acc.User_LocaleSidKey__c;
            u.LanguageLocaleKey = 'en_US';
            u.EmailEncodingKey = 'ISO-8859-1'; 
            u.Primary_Invoice_Currency__c =  acc.Owner.Primary_Invoice_Currency__c;
            u.ProfileId =  [Select p.Name, p.Id From Profile p where Name='Parent Portal User - High Volume'].Id;
            u.School_Hub_Video__c =  acc.User_School_Hub_Video_Link__c;
            u.ContactId =  acc.PersonContactId;
            u.CompanyName =  'Parent';
            u.Username = 'testejrhhgz@tetsc.com';
            //u.MobilePhone = accountMap.get(acc.Id).PersonMobilePhone;
            insert u;
            parentAccount.User__pc = u.Id;
            update parentAccount;
            
        
        //create news and event records
        list<News_Events__c> nelist = new list<News_Events__c>();
        
        News_Events__c event = new News_Events__c();
        event.RecordTypeId = [Select Id from RecordType where SobjectType='News_Events__c' AND DeveloperName='Event'].Id;
        event.Name = 'Test Event';
        event.Subtitle__c = 'teaser text';
        event.Main_Text__c = 'long text';
        event.Event_Start_Date__c = date.today();
        event.Event_End_Date__c = date.today().addDays(20);
        event.Student_Group__c = grp.Id;
        nelist.add(event);
        
        News_Events__c term = new News_Events__c();
        term.RecordTypeId = [Select Id from RecordType where SobjectType='News_Events__c' AND DeveloperName='Term'].Id;
        term.Name = 'Test Term';
        term.Subtitle__c = 'teaser text 1';
        term.Main_Text__c = 'long text 2';
        term.Event_Start_Date__c = date.today();
        term.Event_End_Date__c = date.today().addDays(20);
        term.Student_Group__c = grp.Id;
        nelist.add(term);
        
        News_Events__c reminder = new News_Events__c();
        reminder.RecordTypeId = [Select Id from RecordType where SobjectType='News_Events__c' AND DeveloperName='Reminder'].Id;
        reminder.Name = 'Test reminder';
        reminder.Subtitle__c = 'teaser text3';
        reminder.Main_Text__c = 'long text4';
        reminder.Event_Start_Date__c = date.today();
        //reminder.Event_End_Date__c = date.today().addDays(20);
        reminder.Student_Group__c = grp.Id;
        reminder.Link_1__c = 'test';
        reminder.Link_2__c = 'test';
        reminder.Link_3__c = 'test';
        reminder.Link_1_Title__c = 'test';
        reminder.Link_2_Title__c = 'test';
        reminder.Link_3_Title__c = 'test';
        nelist.add(reminder);
        
        insert nelist;
        //create attachment
        Attachment a =  new Attachment();
        a.ParentId = nelist[0].Id;
        a.Name = 'Test';
        a.ContentType = 'image/jpeg';
        a.Body = Blob.valueOf('dfsfdsf');
        insert a; 
        Test.startTest();
            //set page reference 
            PageReference pg = Page.PortalNewsEvents;
            pg.getParameters().put('accid',parentAccount.Id);
            Test.setCurrentPageReference(pg);
            PortalNewsEvents_Controller controller =  new PortalNewsEvents_Controller();
            controller.filterNewsEvents();
            string temp = controller.fromDateString;
            temp = controller.toDateString;
            controller.fromDateString = '08/01/2014';
            controller.toDateString = '09/01/2014';
            if(controller.wrapperList != null){
                if(controller.wrapperList.size() > 0){
                    for(PortalNewsEvents_Controller.NewsEventWrapper w:controller.wrapperList){
                        string t = w.eventStartDateMonth;
                        t = w.eventStartDateDay;
                        t = w.eventEndDateDay;
                        t = w.eventEndDateMonth;
                        boolean f = w.showMainContent;
                        f = w.showImageSection;
                    }
                }
            }
        Test.stopTest();
        
    }
}