/***
    Author: Kunal Sharma
    Created Date: 10 Apr 2013
    Desc: Test methods for teacher portal
***/
@isTest
private class TestTeacherPortal {
    
    //test method for weekly attendance page
    static testMethod void testWeeklyAttendancePage(){
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
        
        //insert related financial info
        Financial_Information__c fi = new Financial_Information__c();
        fi.Related_to__c = parentAccount.Id;
        fi.Invoice_Currency__c = 'MYR';
        fi.Invoice_Frequency__c = 'Monthly';
        fi.Fees_Responsible_For__c = 'All Applicable;';
        fi.RecordTypeId = [select Id from RecordType where DeveloperName = 'Parent_Financial_Information'].Id;
        insert fi;
        
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
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        for(integer i=11;i<16;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today().addDays(-90);
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        insert  oppList;
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
        
        //test student stage change
            /*for(Opportunity o :[Select Id,StageName from Opportunity where StageName = 'Enrolled' limit 2]){
                o.StageName = 'A/ Testing';
                update o;
            }*/
        //start test
        Test.startTest();
            PageReference pageRef = Page.WeeklyAttendancePage; 
            pageRef.getParameters().put('id', grp.Id);
            pageRef.getParameters().put('w', '0');
            pageRef.getParameters().put('rindex','0');
            Test.setCurrentPageReference(pageRef);
            ApexPages.StandardController sc =  new ApexPages.StandardController(grp);
            WeeklyAttendancePageController controller  =  new WeeklyAttendancePageController(sc);
            controller.performSave();
            controller.back();
            controller.currentWeek();
            controller.getHasPreviousWeek();
            controller.nextWeek();
            controller.populateSecRow();
            controller.performSave();
            controller.unpopulateSecRow();
            controller.performSave();
            controller.previousWeek();
            controller.reset();
            
            //initiate another controller to have exiting event data 
            WeeklyAttendancePageController controller1  =  new WeeklyAttendancePageController(sc);
            //test email classes
            SendEmailToGroupParents_Controller parent =  new SendEmailToGroupParents_Controller(sc);
            parent.reDirectToEmailPage();
            SendEmailToGroupStudents_Controller student =  new SendEmailToGroupStudents_Controller(sc);
            student.reDirectToEmailPage();
            
            
        Test.stopTest();    
        //stop test
    }
    
    //test method for daily attendance page
    static testMethod void testDailyAttendancePage(){
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
            o.Application_Date__c = Date.today();
            o.Starting_Date__c =  Date.today();
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today();
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        for(integer i=11;i<16;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today();
            o.Starting_Date__c =  Date.today();
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today();
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        insert  oppList;
        //insert related financial info
        Financial_Information__c fi = new Financial_Information__c();
        fi.Related_to__c = parentAccount.Id;
        fi.Invoice_Currency__c = 'MYR';
        fi.Invoice_Frequency__c = 'Monthly';
        fi.Fees_Responsible_For__c = 'All Applicable;';
        fi.RecordTypeId = [select Id from RecordType where DeveloperName = 'Parent_Financial_Information'].Id;
        
        insert fi;
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
        
        //start test
        Test.startTest();
            PageReference pageRef = Page.DailyAttendancePage; 
            Test.setCurrentPageReference(pageRef);
            ApexPages.StandardController sc =  new ApexPages.StandardController(grp);
            DailyAttendancePageController controller  =  new DailyAttendancePageController(sc);
            controller.saveAttandences();
            controller.fetchAttandences();
            //initiate another controller to have exiting event data 
            DailyAttendancePageController controller1  =  new DailyAttendancePageController(sc);
            
        Test.stopTest();    
        //stop test
    }
    
    //test method for Bulk Registration page
    static testMethod void testBulkRegistration(){
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
        
        //insert related financial info
        Financial_Information__c fi = new Financial_Information__c();
        fi.Related_to__c = parentAccount.Id;
        fi.Invoice_Currency__c = 'MYR';
        fi.Invoice_Frequency__c = 'Monthly';
        fi.Fees_Responsible_For__c = 'All Applicable;';
        fi.RecordTypeId = [select Id from RecordType where DeveloperName = 'Parent_Financial_Information'].Id;
        
        insert fi;
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
            o.Application_Date__c = Date.today().addDays(-90);
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        for(integer i=11;i<16;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today().addDays(-90);
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        insert  oppList;
        
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
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled' limit 3] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        
        //start test
        Test.startTest();
            PageReference pageRef = Page.BulkRegistration; 
            pageRef.getParameters().put('id', grp.Id);
            Test.setCurrentPageReference(pageRef);
            ApexPages.StandardController sc =  new ApexPages.StandardController(grp);
            BulkRegistration_Controller controller  =  new BulkRegistration_Controller(sc);
            controller.saveRegistrations();
            controller.showInActive();
            controller.showActive();
            controller.sortByField();
            controller.sortByField();
            boolean flag = controller.hasNext;
            flag = controller.hasPrevious;
            controller.next();
            controller.first();
            controller.last();
            controller.previous();
            integer i = controller.pageNum;
            i = controller.pageNumber;
            i = controller.totalPages;
            List<Registration__c> l = controller.existingRegistrations;         
        Test.stopTest();    
        //stop test
    }
    
    //test method for Add Registration page
    static testMethod void testAddRegistration(){
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
            o.Application_Date__c = Date.today().addDays(-90);
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        for(integer i=11;i<16;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today().addDays(-90);
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        insert  oppList;
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
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled' limit 3] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        } 
        insert rList;
        
        //start test
        Test.startTest();
            PageReference pageRef = Page.AddRegistrations; 
            pageRef.getParameters().put('id', grp.Id);
            Test.setCurrentPageReference(pageRef);
            ApexPages.StandardController sc =  new ApexPages.StandardController(grp);
            AddRegistrations_Controller controller  =  new AddRegistrations_Controller(sc);
            controller.searchContacts();
            for(AddRegistrations_Controller.ContactWrapper wrapper:controller.fetchedContacts){
                wrapper.selected =  true;
            }
            controller.saveRegistration();
            controller.sortByField();
            controller.sortByField();
            controller.selectedClass = 'B';   
            controller.selectedYearGroup = 'PN1';
            controller.searchContacts(); 
                                
        Test.stopTest();    
        //stop test
    }
    
    //test method for ManageGroupAssessments page
    static testMethod void testManageGroupAssessments(){
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
            o.Application_Date__c = Date.today().addDays(-90);
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        for(integer i=11;i<16;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Gender__c = 'Male';
            o.Year_Group__c = 'PN1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today().addDays(-90);
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        insert  oppList;
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
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled' limit 10] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        }   
        insert rList;
        
        //start test
        Test.startTest(); 
            PageReference pageRef = Page.NewUpdateFolder; 
            pageRef.getParameters().put('grpid', grp.Id);
            Test.setCurrentPageReference(pageRef);
            ApexPages.StandardController sc =  new ApexPages.StandardController(new Assesment__c());
            NewUpdateFolder_Controller controller  =  new NewUpdateFolder_Controller(sc);
            controller.folder.Title__c = 'New Folder';
            controller.folder.Type__c = 'Subject';
            controller.folder.Assessment_Date__c =  Date.today();
            controller.folder.Description__c = 'ddd';
            controller.saveNewFolder();
            controller.updateExistingFolder();
            controller.editExistingFolder();
            pageRef.getParameters().put('fid', controller.folder.Id);
            //test BulkAssessments
            ApexPages.StandardController sc2 =  new ApexPages.StandardController(grp);
            BulkAssessments_Controller controller2  =  new BulkAssessments_Controller(sc2);
            for(BulkAssessments_Controller.AssessmentRecord ar:controller2.assessments){
                ar.assessment.Grade__c = '1';
            }
            controller2.saveAssessments();
            for(BulkAssessments_Controller.AssessmentRecord ar:controller2.assessments){
                ar.assessment.Grade__c = null;
            }
            controller2.saveAssessments();
            
            //test ManageGroupAssessments
            ApexPages.StandardController sc1 =  new ApexPages.StandardController(grp);
            ManageGroupAssessments_Controller controller1  =  new ManageGroupAssessments_Controller(sc1);
            boolean flag = controller1.hasNext;
            flag = controller1.hasPrevious;
            controller1.next();
            controller1.first();
            controller1.last();
            controller1.previous();
            integer i = controller1.pageNum;
            i = controller1.pageNumber;
            i = controller1.totalPages;
            List<Assesment__c> li = controller1.assessmentFolders;
            controller1.deleteFolder();
            
            try{
                delete grp;
            }catch(Exception e){
                //no action
            }
            
        Test.stopTest();    
        //stop test
    }
    
    //test method for ManagePastorals
    static testMethod void testManagePastorals(){
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
            o.Application_Date__c = Date.today().addDays(-90);
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            o.House__c = 'Pending';
            oppList.add(o);
        }
        insert  oppList;
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
        for(Contact c : [Select Id from Contact where RecordTypeId=:studentRTId AND Stage__c = 'Enrolled' limit 10] ){
            Registration__c r  = new Registration__c();
            r.Group__c =  grp.Id;
            r.Student__c = c.Id;
            r.Active__c = true;
            rList.add(r);
        }   
        insert rList;
        
        //start test
        Test.startTest(); 
            PageReference pageRef = Page.CreatePastorals; 
            pageRef.getParameters().put('id', grp.Id);
            pageRef.getParameters().put('s', '1');
            Test.setCurrentPageReference(pageRef);
            ApexPages.StandardController sc =  new ApexPages.StandardController(grp);
            CreatePastorals controller  =  new CreatePastorals(sc);
            controller.folder.Folder_Title__c = 'Test';
            controller.folder.Folder_Type__c = 'Achievements';
            controller.studentKeyword = 'Name';
            controller.selectedYearGroup = 'PN1';
            controller.selectedClass = 'A';
            controller.selectedHouse = 'Pending';
            controller.searchStudents();
            system.debug('***TestTeacherPortal***testManagePastorals***searchedStudents='+controller.searchedStudents);
            controller.selectedStudents = new list<SelectOption>();
            for(SelectOption so:controller.searchedStudents){
                controller.selectedStudents.add(so);
            }
            boolean t =  controller.showPastoralLines;
            controller.createPastorals();
            t =  controller.showPastoralLines;
            for(CreatePastorals.PastoralWrapper pw : controller.pastorals){
                //pw.pastoral.Award_Type__c = 'Test';
            }
            controller.savePastorals();
            system.currentPageReference().getParameters().put('fid', controller.folder.Id);
            CreatePastorals controller2  =  new CreatePastorals(sc);
            controller2.selectedStudents.remove(1);
            controller2.savePastorals();
            controller2.back();     
            
            //test manage pastorals
            ManagePastorals controller3 = new ManagePastorals(sc);
            controller3.newFolder();
            system.currentPageReference().getParameters().put('dfid', controller.folder.Id);
            controller3.deleteFolder(); 
            
        Test.stopTest();    
        //stop test
    }
    
    //test method for assessment approval 
    static testMethod void testAssessmentsApproval(){
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
            o.Application_Date__c = Date.today();
            o.Starting_Date__c =  Date.today();
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
        grp.Approver__c = [Select Id from User where IsActive=true AND (Profile.Name = 'Teacher' OR Profile.Name = 'Headteacher / of Admin / of Finance') limit 1].Id;
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
            assessment.Is_Approved__c =  false;
            assessment.Approval_Comments__c =  'comments';
            assessments.add(assessment);
        }
        if(assessments.size() > 0) {
            insert assessments;
        }
        Test.startTest();
            //set page reference 
            PageReference pg = Page.AssessmentApproval;
            Test.setCurrentPageReference(pg);
            AssessmentApproval_Controller controller =  new AssessmentApproval_Controller();
            controller.selectedGroup = grp.Id;
            controller.fetchFolders();
            controller.selectedFolder = progressReport.Id;
            controller.fetchAssessments();
            controller.selectAllAssessments();
            controller.saveAssessments();
        Test.stopTest();
        
    }
    
    //test method for assessment reports 
    static testMethod void testNewsEventsTab(){
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
        
        Test.startTest();
            //set page reference 
            PageReference pg = Page.NewsEventList;
            pg.getParameters().put('st','This Term');
            Test.setCurrentPageReference(pg);
            ApexPages.StandardController s = new ApexPages.StandardController(grp);
            NewsEventList_Controller controller =  new NewsEventList_Controller(s);
            controller.newHolidayDate();
            controller.newNotice();
            controller.newSchoolEvent();
            controller.newTermDate();
            controller.first();
            controller.last();
            boolean flag = controller.hasNext;
            flag = controller.hasPrevious;
            controller.next();
            controller.previous();
            integer i = controller.pageNumber;
            controller.setPageNumber();
            pg.getParameters().put('rid',reminder.Id);
            controller.deleteRecord();
        Test.stopTest();
        
    }
    
}