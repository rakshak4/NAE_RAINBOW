@isTest
private class TestAssessmentReview{
    //test method for assessment review and assessment approval 1
    static testMethod void testAssessmentReviewApproval(){
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
        
        //create group at school level
        Group__c grp =  new Group__c();
        grp.Name = 'All Students';
        grp.Group_Type__c = 'Tutor Group';
        grp.Year_Group__c = 'Year 1';
        grp.Year_Group_Control__c = 'Tutor Group UK';
        insert grp;
        
        //create school logo mapping setting
        String schoolName = [Select Id, School__c from User where Id=:UserInfo.getUserId()].School__c;
        School_Logo_Mapping__c schoolMapping =  new School_Logo_Mapping__c();
        schoolMapping.Name = 'Test Mapping';
        schoolMapping.Logo_URL__c = 'test';
        schoolMapping.School_Full_Name__c = schoolName;
        schoolMapping.All_Student_Group_Id__c = grp.Id;
        schoolMapping.Auto_Portal_User_Creation__c =  true;
        insert schoolMapping;
        
        //create opportunities
        //create student opportunities
        List<Opportunity> oppList =  new List<Opportunity>();
        for(integer i=1;i<14;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Year_Group__c = 'Y'+i;
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today();
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.Gender__c = 'Male';
            o.StageName = 'A/ Testing';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        for(integer i=1;i<5;i++){
            Opportunity o =  new Opportunity();
            o.Student_Surname__c =  'Surname'+i;
            o.Name = 'First Name'+i;
            o.Year_Group__c = 'Y1';
            o.Birth_Date__c =  Date.today().addYears(-10);
            o.Application_Date__c = Date.today();
            o.Starting_Date__c =  Date.today().addDays(-60);
            o.StageName = 'A/ Testing';
            o.Gender__c = 'Male';
            o.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            //o.Email_1__c = 'test@test.com';
            o.CloseDate =  Date.today().addDays(-60);
            o.Student_Name__c = 'SN';
            o.Class__c = 'A';
            oppList.add(o);
        }
        //pn
        Opportunity o1 =  new Opportunity();
        o1.Student_Surname__c =  'Surname';
        o1.Name = 'First Name - PN';
        o1.Year_Group__c = 'PN';
        o1.Birth_Date__c =  Date.today().addYears(-10);
        o1.Application_Date__c = Date.today();
        o1.Starting_Date__c =  Date.today().addDays(-60);
        o1.Gender__c = 'Male';
        o1.StageName = 'A/ Testing';
        o1.AccountId = parentAccount.Id;
        //o1.Payer__c = companyAccount.Id;
        //o.Email_1__c = 'test@test.com';
        o1.CloseDate =  Date.today().addDays(-60);
        o1.Student_Name__c = 'SN';
        o1.Class__c = 'A';
        oppList.add(o1);
        //n
        Opportunity o2 =  new Opportunity();
        o2.Student_Surname__c =  'Surname';
        o2.Name = 'First Name - N';
        o2.Year_Group__c = 'N';
        o2.Birth_Date__c =  Date.today().addYears(-10);
        o2.Application_Date__c = Date.today();
        o2.Starting_Date__c =  Date.today().addDays(-60);
        o2.Gender__c = 'Male';
        o2.StageName = 'A/ Testing';
        o2.AccountId = parentAccount.Id;
        //o2.Payer__c = companyAccount.Id;
        //o.Email_1__c = 'test@test.com';
        o2.CloseDate =  Date.today().addDays(-60);
        o2.Student_Name__c = 'SN';
        o2.Class__c = 'A';
        oppList.add(o2);
        //r
        Opportunity o3 =  new Opportunity();
        o3.Student_Surname__c =  'Surname';
        o3.Name = 'First Name - R';
        o3.Year_Group__c = 'R';
        o3.Birth_Date__c =  Date.today().addYears(-10);
        o3.Application_Date__c = Date.today();
        o3.Starting_Date__c =  Date.today().addDays(-60);
        o3.Gender__c = 'Male';
        o3.StageName = 'A/ Testing';
        o3.AccountId = parentAccount.Id;
        //o3.Payer__c = companyAccount.Id;
        //o.Email_1__c = 'test@test.com';
        o3.CloseDate =  Date.today().addDays(-60);
        o3.Student_Name__c = 'SN';
        o3.Class__c = 'A';
        oppList.add(o3);
        
        insert oppList;
        
        for(Opportunity o:oppList){
            o.StageName = 'Enrolled';
        }
        update oppList;
        
        //create subject group
        Group__c subject  = new Group__c();
        subject.Name = 'Subject Group';
        subject.Group_Type__c = 'Subject';
        subject.Subject_Name__c = 'English';
        subject.Year_Group_Control__c = 'Non-Tutor Group';
        insert subject;
        
        //create registrations
        List<Registration__c> newRList =  new List<Registration__c>();
        for(Contact con:[Select Id from Contact where RecordType.DeveloperName= 'Student']){
            Registration__c r =  new Registration__c();
            r.Group__c = subject.Id;
            r.Student__c = con.Id;
            r.Active__c = true;
            newRList.add(r);
        }
        
        if(newRList.size() > 0){
            insert newRList;
        }
        
        Test.startTest();
            AssesmentReview_Controller controller =  new AssesmentReview_Controller();
            controller.selectedYear  = 'Y1';
            controller.fetchSubjects();
            controller.selectedClass = 'A';
            controller.fetchSubjects();
            if(controller.studentList != null){ 
                if(controller.studentList.size() > 0){
                    controller.selectedStudent = controller.studentList[0];
                    controller.processStudent();
                    controller.record.Comment__c = 'dddddd';
                    controller.publishComment();
                    controller.nextStudent();
                    controller.record.Comment__c = 'dddddd';
                    controller.publishComment();
                    controller.previousStudent();
                    controller.record.Comment__c = 'dddddd';
                    controller.publishComment();
                    controller.fetchMoreAssessments();
                    controller.fetchStudents();
                    //controller.publishReports();
                    //controller.fetchStudents();
                    AssessmentApproval1_Controller controller2 = new AssessmentApproval1_Controller();
                    controller2.publishReports();
                    list<string> campusList =  new list<string>();
                    campusList.add('Campus 1');
                    campusList.add('Campus 2');
                    campusList.add('Campus 3');
                    controller2.setSelectedCampuses(campusList);
                    list<string> rtypes =  new list<string>();
                    rtypes.add('Progress Report');
                    rtypes.add('Examination');
                    rtypes.add('Effort & Attitude');
                    controller2.setSelectedReportTypes(rtypes);
                    controller2.publishReports();
                    list<string> temp = controller2.getSelectedCampuses();
                    temp = controller2.getSelectedReportTypes();
                    
                }
            }
                
        Test.stopTest();
        
    }
}