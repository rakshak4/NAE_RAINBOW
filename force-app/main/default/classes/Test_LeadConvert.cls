@isTest
private class Test_LeadConvert{
    static testMethod void test_CustomLeadConversion(){
        //create system admin user
        User u = new User();
        u.FirstName = 'Test';
        u.LastName = 'Test';
        u.Email = 'test@testhb.com';
        u.Username = 'test@testvgh.com';
        u.ProfileId =[select Id from Profile where Name = 'System Administrator'].Id;
        u.School__c = 'The British School of Tashkent';
        u.Alias = 'test766';
        u.TimeZoneSidKey =  'Asia/Kuala_Lumpur';
        u.LocaleSidKey =  'en_GB';
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'ISO-8859-1'; 
        insert u;
        System.runAs(u){
            //create test data
            Lead l =  new Lead();
            l.Status = 'New';
            l.Website_Form_Type__c = 'NAE Admissions Enquiry';
            l.Primary_Contact__c = 'First Parent';
            //parent 1
            l.FirstName = 'FN';
            l.LastName = 'LN';
            l.Main_Email__c = 'test3333@test.com';
            l.Alternate_Email__c = 'alt4444@test.com';
            l.Parent_1_Relationship__c = 'Father';
            //parent 2
            l.Parent_2_Name__c = 'FN2';
            l.Parent_2_Last_Name__c = 'LN2';
            l.Parent_2_Relationship__c = 'Mother';
            l.Parent_2_Email_1__c = 'test244444@test.com';
            l.Parent_2_Email_2__c = 'alt255555@test.com';
            //dates
            l.Application_Date__c = Date.today().addDays(-20);
            l.Starting_Date__c = Date.today();
            l.ExpectedStartMonth__c = 'January';
            l.ExpectedStartYear__c = String.valueOf(Date.today().addYears(1).Year());
            
            //child 1
            l.FirstNameFirstChild__c= 'Child1';
            l.LastNameFirstChild__c = 'Surname1';
            l.GenderFirstChild__c = 'Male';
            l.Child_1_Year_Group__c = 'Year 1'; 
            l.DateOfBirthFirstChild__c = Date.today().addYears(-9);
            
            //child 2
            l.FirstNameSecondChild__c= 'Child2';
            l.LastNameSecondChild__c = 'Surname2';
            l.GenderSecondChild__c = 'Male';
            l.Child_2_Year_Group__c = 'Year 2';
            l.DateOfBirthSecondChild__c = Date.today().addYears(-9);
            
            //child 3
            l.FirstNameThirdChild__c= 'Child3';
            l.LastNameThirdChild__c = 'Surname3';
            l.GenderThirdChild__c = 'Male';
            l.Child_3_Year_Group__c = 'Year 3';
            l.DateOfBirthThirdChild__c = Date.today().addYears(-9);
            //child 4
            l.FirstNameFourthChild__c= 'Child4';
            l.LastNameFourthChild__c = 'Surname4';
            l.Child_4_Year_Group__c = 'Year 3';
            l.DateOfBirthFourthChild__c = Date.today().addYears(-9);
            //child 5
            l.FirstNameFifthChild__c= 'Child5';
            l.LastNameFifthChild__c = 'Surname5';
            l.DateOfBirthFifthChild__c = Date.today().addYears(-9);
            
            insert l;
            
            
            //create school mapping
            String schoolName = [Select Id, School__c from User where Id=:UserInfo.getUserId()].School__c;
            Id networkId;
            //System.debug('***TestChatterMethods***testStudentGroupChatterMethods***networks='+[Select Id,Name from Network]);
            for(Network n:[Select Id,Name from Network limit 1]){
                networkId = n.Id;
            }
            
            //create chatter group
            CollaborationGroup chatterGroup =  new CollaborationGroup();
            chatterGroup.Name = 'Chatter Group';
            chatterGroup.NetworkId = networkId;
            chatterGroup.CollaborationType = 'Private';
            chatterGroup.OwnerId = UserInfo.getUserId();
            insert chatterGroup;
            
            //create whole school group
            Group__c grp  =  new Group__c();
            grp.Name = 'Test Whole School Group';
            grp.Group_Type__c = 'School Group';
            grp.Auto_Add_Parents_To_Group__c = true;
            grp.Chatter_Group_Id__c = chatterGroup.Id;
            grp.Year_Group_Control__c = 'Non-Tutor Group';
            //grp.Year_Group__c = 'Year 1';
            insert grp;
            
            School_Logo_Mapping__c schoolMapping =  new School_Logo_Mapping__c();
            schoolMapping.Name = 'Test Mapping';
            schoolMapping.Logo_URL__c = 'test';
            schoolMapping.School_Full_Name__c = schoolName;
            schoolMapping.All_Student_Group_Id__c = grp.Id;
            schoolMapping.Community_Id__c = networkId;
            schoolMapping.Auto_Portal_User_Creation__c = true;
            insert schoolMapping;
            
            
            //create custom setting
            List<LeadConvertMapping__c> mappingList =  new List<LeadConvertMapping__c>();
            
            LeadConvertMapping__c mapping01 = new LeadConvertMapping__c(Name='Application Date',Opportunity_Num__c = 0, Opportunity_Field__c ='Application_Date__c', Lead_Field__c = 'Application_Date__c', Is_Required__c = false);mappingList.add(mapping01);
            LeadConvertMapping__c mapping02 = new LeadConvertMapping__c(Name='Starting Date',Opportunity_Num__c = 0, Opportunity_Field__c ='CloseDate', Lead_Field__c = 'Starting_Date__c', Is_Required__c = false);mappingList.add(mapping02);
            LeadConvertMapping__c mapping03 = new LeadConvertMapping__c(Name='Stage',Opportunity_Num__c = 0, Opportunity_Field__c ='StageName', Static_Value__c = 'A/ Testing', Is_Required__c = false);mappingList.add(mapping03);
            //child1
            LeadConvertMapping__c mapping11 = new LeadConvertMapping__c(Name='Child 1 Application Fee',Opportunity_Num__c = 1, Opportunity_Field__c ='Assessment_Fee__c', Lead_Field__c = 'Child_1_Application_Fee_Paid__c', Is_Required__c = false);mappingList.add(mapping11);
            LeadConvertMapping__c mapping12 = new LeadConvertMapping__c(Name='Child 1 DOB',Opportunity_Num__c = 1, Opportunity_Field__c ='Birth_Date__c', Lead_Field__c = 'DateOfBirthFirstChild__c', Is_Required__c = false);mappingList.add(mapping12);
            LeadConvertMapping__c mapping13 = new LeadConvertMapping__c(Name='Child 1 Class',Opportunity_Num__c = 1, Opportunity_Field__c ='Class__c', Lead_Field__c = 'Child_1_Class_Derived_from_Campus__c', Is_Required__c = false);mappingList.add(mapping13);
            //LeadConvertMapping__c mapping14 = new LeadConvertMapping__c(Name='Child 1 Needs Extended',Opportunity_Num__c = 1, Opportunity_Field__c ='Extended_Needs_Description__c', Lead_Field__c = 'Child_1_Description__c', Is_Required__c = false);mappingList.add(mapping14);
            LeadConvertMapping__c mapping15 = new LeadConvertMapping__c(Name='Child 1 Gender',Opportunity_Num__c = 1, Opportunity_Field__c ='Gender__c', Lead_Field__c = 'GenderFirstChild__c', Is_Required__c = false);mappingList.add(mapping15);
            //LeadConvertMapping__c mapping16 = new LeadConvertMapping__c(Name='Child 1 Needs',Opportunity_Num__c = 1, Opportunity_Field__c ='Medical_Special_Needs_Condition__c', Lead_Field__c = 'Child1_Medical_or_Special_Needs__c', Is_Required__c = false);mappingList.add(mapping16);
            LeadConvertMapping__c mapping17 = new LeadConvertMapping__c(Name='Child 1 Full Name',Opportunity_Num__c = 1, Opportunity_Field__c ='Name', Lead_Field__c = 'Child_1_Full_Name__c', Is_Required__c = false);mappingList.add(mapping17);
            LeadConvertMapping__c mapping18 = new LeadConvertMapping__c(Name='Child 1 Nationality',Opportunity_Num__c = 1, Opportunity_Field__c ='Nationality__c', Lead_Field__c = 'Child_1_Nationality__c', Is_Required__c = false);mappingList.add(mapping18);
            LeadConvertMapping__c mapping19 = new LeadConvertMapping__c(Name='Child 1 First Name',Opportunity_Num__c = 1, Opportunity_Field__c ='Student_Name__c', Lead_Field__c = 'FirstNameFirstChild__c', Is_Required__c = false);mappingList.add(mapping19);
            LeadConvertMapping__c mapping110 = new LeadConvertMapping__c(Name='Child 1 Surname',Opportunity_Num__c = 1, Opportunity_Field__c ='Student_Surname__c', Lead_Field__c = 'LastNameFirstChild__c', Is_Required__c = false);mappingList.add(mapping110);
            //LeadConvertMapping__c mapping111 = new LeadConvertMapping__c(Name='Child 1 Year Group',Opportunity_Num__c = 1, Opportunity_Field__c ='Year_Group__c', Lead_Field__c = 'Child_1_Year_Group_Abb__c', Is_Required__c = false);mappingList.add(mapping111);
            //child 2
            LeadConvertMapping__c mapping21 = new LeadConvertMapping__c(Name='Child 2 Application Fee',Opportunity_Num__c = 2, Opportunity_Field__c ='Assessment_Fee__c', Lead_Field__c = 'Child_2_Application_Fee_Paid__c', Is_Required__c = false);mappingList.add(mapping21);
            LeadConvertMapping__c mapping22 = new LeadConvertMapping__c(Name='Child 2 DOB',Opportunity_Num__c = 2, Opportunity_Field__c ='Birth_Date__c', Lead_Field__c = 'DateOfBirthSecondChild__c', Is_Required__c = false);mappingList.add(mapping22);
            LeadConvertMapping__c mapping23 = new LeadConvertMapping__c(Name='Child 2 Class',Opportunity_Num__c = 2, Opportunity_Field__c ='Class__c', Lead_Field__c = 'Child_2_Class_Derived_from_Campus__c', Is_Required__c = false);mappingList.add(mapping23);
            //LeadConvertMapping__c mapping24 = new LeadConvertMapping__c(Name='Child 2 Needs Extended',Opportunity_Num__c = 2, Opportunity_Field__c ='Extended_Needs_Description__c', Lead_Field__c = 'Child_2_Description__c', Is_Required__c = false);mappingList.add(mapping24);
            LeadConvertMapping__c mapping25 = new LeadConvertMapping__c(Name='Child 2 Gender',Opportunity_Num__c = 2, Opportunity_Field__c ='Gender__c', Lead_Field__c = 'GenderSecondChild__c', Is_Required__c = false);mappingList.add(mapping25);
            //LeadConvertMapping__c mapping26 = new LeadConvertMapping__c(Name='Child 2 Needs',Opportunity_Num__c = 2, Opportunity_Field__c ='Medical_Special_Needs_Condition__c', Lead_Field__c = 'Child2_Medical_or_Special_Needs__c', Is_Required__c = false);mappingList.add(mapping26);
            LeadConvertMapping__c mapping27 = new LeadConvertMapping__c(Name='Child 2 Full Name',Opportunity_Num__c = 2, Opportunity_Field__c ='Name', Lead_Field__c = 'Child_2_Full_Name__c', Is_Required__c = true);mappingList.add(mapping27);
            LeadConvertMapping__c mapping28 = new LeadConvertMapping__c(Name='Child 2 Nationality',Opportunity_Num__c = 2, Opportunity_Field__c ='Nationality__c', Lead_Field__c = 'Child_2_Nationality__c', Is_Required__c = false);mappingList.add(mapping28);
            LeadConvertMapping__c mapping29 = new LeadConvertMapping__c(Name='Child 2 First Name',Opportunity_Num__c = 2, Opportunity_Field__c ='Student_Name__c', Lead_Field__c = 'FirstNameSecondChild__c', Is_Required__c = false);mappingList.add(mapping29);
            LeadConvertMapping__c mapping210 = new LeadConvertMapping__c(Name='Child 2 Surname',Opportunity_Num__c = 2, Opportunity_Field__c ='Student_Surname__c', Lead_Field__c = 'LastNameSecondChild__c', Is_Required__c = false);mappingList.add(mapping210);
            //LeadConvertMapping__c mapping211 = new LeadConvertMapping__c(Name='Child 2 Year Group',Opportunity_Num__c = 2, Opportunity_Field__c ='Year_Group__c', Lead_Field__c = 'Child_2_Year_Group_Abb__c', Is_Required__c = false);mappingList.add(mapping211);
            
            insert mappingList;
            
            //create company account account
            Account companyAccount =  new Account();
            companyAccount.Name =  'Company Account';
            companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
            insert companyAccount;
            //create account mapping
            Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
            mapping.Account_Id__c = companyAccount.Id;
            mapping.Name =  UserInfo.getName();
            mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
            insert mapping;
            
            
            //create lead contact mapping
            List<Lead_Contact_Mapping__c> mappingListLeadContact =  new List<Lead_Contact_Mapping__c>();
            
            Lead_Contact_Mapping__c lcontactmapping0 = new Lead_Contact_Mapping__c(Name='Alternate Email',Lead_Field__c='Parent_2_Email_2__c',Contact_Field__c='Contact_Alternate_Email__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping1 = new Lead_Contact_Mapping__c(Name='Alternate Phone',Lead_Field__c='Parent_2_Phone_2__c',Contact_Field__c='Contact_Alternate_Phone__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping2 = new Lead_Contact_Mapping__c(Name='Alternate Phone Country Code',Lead_Field__c='Alternate_Phone_Country_CodePL_P2__c',Contact_Field__c='Contact_Alternate_Phone_Country_CodePL__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping3 = new Lead_Contact_Mapping__c(Name='Email Opt Out',Lead_Field__c='Parent_2_Email_Opt_Out__c',Contact_Field__c='HasOptedOutOfEmail',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping4 = new Lead_Contact_Mapping__c(Name='Employer',Lead_Field__c='Parent_2_Employer_Optional__c',Contact_Field__c='Contact_Employer__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping5 = new Lead_Contact_Mapping__c(Name='Employment Sector',Lead_Field__c='Second_Parent_Employment_Sector__c',Contact_Field__c='Contact_Employment_Sector__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping6 = new Lead_Contact_Mapping__c(Name='First Name',Lead_Field__c='Parent_2_Name__c',Contact_Field__c='FirstName',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping7 = new Lead_Contact_Mapping__c(Name='Last Name',Lead_Field__c='Parent_2_Last_Name__c',Contact_Field__c='LastName',Is_Required__c=true);
            Lead_Contact_Mapping__c lcontactmapping8 = new Lead_Contact_Mapping__c(Name='Main Email',Lead_Field__c='Parent_2_Email_1__c',Contact_Field__c='Email',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping9 = new Lead_Contact_Mapping__c(Name='Mobile/Main PhoneFirst Name',Lead_Field__c='Parent_2_Phone_1__c',Contact_Field__c='MobilePhone',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping10 = new Lead_Contact_Mapping__c(Name='Mobile/Main Phone Country Code',Lead_Field__c='Mobile_Main_Phone_Country_CodePL_P2__c',Contact_Field__c='Contact_Mobile_Main_Phone_Country_CodePL__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping12 = new Lead_Contact_Mapping__c(Name='Passport/Other ID#',Lead_Field__c='Second_Parent_CPF_ID__c',Contact_Field__c='Contact_Passport_Other_ID__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping13 = new Lead_Contact_Mapping__c(Name='Relationship',Lead_Field__c='Parent_2_Relationship__c',Contact_Field__c='Contact_Relationship__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping14 = new Lead_Contact_Mapping__c(Name='Salutation',Lead_Field__c=null,Contact_Field__c='Salutation',Is_Required__c=false,Static_Value__c='Mr.');
            mappingListLeadContact.add(lcontactmapping0);
            mappingListLeadContact.add(lcontactmapping1);
            mappingListLeadContact.add(lcontactmapping2);
            mappingListLeadContact.add(lcontactmapping3);
            mappingListLeadContact.add(lcontactmapping4);
            mappingListLeadContact.add(lcontactmapping5);
            mappingListLeadContact.add(lcontactmapping6);
            mappingListLeadContact.add(lcontactmapping7);
            mappingListLeadContact.add(lcontactmapping8);
            mappingListLeadContact.add(lcontactmapping9);
            mappingListLeadContact.add(lcontactmapping10);
            mappingListLeadContact.add(lcontactmapping12);
            mappingListLeadContact.add(lcontactmapping13);
            mappingListLeadContact.add(lcontactmapping14);
            
            insert mappingListLeadContact;
            
            Test.startTest();
                ApexPages.StandardController s = new ApexPages.StandardController(l);
                ConvertLead_Controller controller =  new ConvertLead_Controller(s);
                controller.existingOpportunitiesCheck();
                controller.cancel();
                controller.convertLead();
                
            Test.stopTest();
            //fetch all registrations and mark them as active
                list<Registration__c> rlist =  new list<Registration__c>();
                for(Registration__c r:[select Id from Registration__c]){
                    r.Active__c =  true;
                    rlist.add(r);
                }
                if(rlist.size() > 0){
                    update rlist;
                }
                system.debug('***Test_LeadConvert***test_CustomLeadConversion***rlist='+rlist);
            //fetch all opportunities and update them to enrolld
                list<Opportunity> olist = new list<Opportunity>();
                for(Opportunity o: [select Id from Opportunity]){
                    o.StageName = 'Enrolled';
                    o.Starting_Date__c = date.today().addDays(-45);
                    olist.add(o);
                }
                system.debug('***Test_LeadConvert***test_CustomLeadConversion***olist='+olist);
                if(olist.size() > 0){
                    update olist;
                }
            //update all contacts
                list<Contact> clist =  new list<Contact>();
                for(Contact c:[select Id from Contact where RecordType.DeveloperName = 'Additional_Parent']){
                    //c.Contact_Trigger_Parent_User_Creation__c = true;
                    clist.add(c);
                }
                system.debug('***Test_LeadConvert***test_CustomLeadConversion***clist='+clist);
                if(clist.size() > 0){
                    update clist;
                }
            //fetch all registrations and mark them as in active
                list<Registration__c> rlist2 =  new list<Registration__c>();
                for(Registration__c r:[select Id from Registration__c]){
                    r.Active__c =  false;
                    rlist2.add(r);
                }
                if(rlist2.size() > 0){
                    update rlist2;
                }
            //fetch all registrations and mark them as in active
                list<Registration__c> rlist3 =  new list<Registration__c>();
                for(Registration__c r:[select Id from Registration__c]){
                    r.Active__c =  true;
                    rlist3.add(r);
                }
                if(rlist3.size() > 0){
                    update rlist3;
                }   
            //fetch all registrations and delete
                list<Registration__c> rlist4 =  new list<Registration__c>();
                for(Registration__c r:[select Id from Registration__c]){
                    
                    rlist4.add(r);
                }
                if(rlist4.size() > 0){
                    delete rlist4;
                }
            //test additonal parent list
            Account parentAccount = [select Id,Name from Account where RecordType.DeveloperName = 'PersonAccount' limit 1];
            ApexPages.StandardController s1 = new ApexPages.StandardController(parentAccount);
            AdditionalParentList_Controller controller_plist =  new AdditionalParentList_Controller(s1);        
            //test student list
            ApexPages.StandardController s2 = new ApexPages.StandardController(parentAccount);
            StudentListController controller_slist =  new StudentListController(s2);    
        }   
            
    }
    
    static testMethod void test_CustomLeadConversion_DuplicateCheck(){
        //create test data
        //create system admin user
        User u = new User();
        u.FirstName = 'Test';
        u.LastName = 'Test';
        u.Email_Domain_Extension__c = '@britishschools.co.uk';
        u.Email = 'test@testhb.com';
        u.Username = 'test@testvgh.com';
        u.ProfileId =[select Id from Profile where Name = 'System Administrator'].Id;
        u.School__c = 'The British School of Tashkent';
        u.Alias = 'test766';
        u.TimeZoneSidKey =  'Asia/Kuala_Lumpur';
        u.LocaleSidKey =  'en_GB';
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'ISO-8859-1'; 
        insert u;
        System.runAs(u){
            //create school mapping
            String schoolName = [Select Id, School__c from User where Id=:UserInfo.getUserId()].School__c;
            
            School_Logo_Mapping__c schoolMapping =  new School_Logo_Mapping__c();
            schoolMapping.Name = 'Test Mapping';
            schoolMapping.Logo_URL__c = 'test';
            schoolMapping.School_Full_Name__c = schoolName;
            schoolMapping.Auto_Portal_User_Creation__c = false;
            insert schoolMapping;
            
            
            //create custom setting
            List<LeadConvertMapping__c> mappingList =  new List<LeadConvertMapping__c>();
            
            LeadConvertMapping__c mapping01 = new LeadConvertMapping__c(Name='Application Date',Opportunity_Num__c = 0, Opportunity_Field__c ='Application_Date__c', Lead_Field__c = 'Application_Date__c', Is_Required__c = false);mappingList.add(mapping01);
            LeadConvertMapping__c mapping02 = new LeadConvertMapping__c(Name='Starting Date',Opportunity_Num__c = 0, Opportunity_Field__c ='CloseDate', Lead_Field__c = 'Starting_Date__c', Is_Required__c = false);mappingList.add(mapping02);
            LeadConvertMapping__c mapping03 = new LeadConvertMapping__c(Name='Stage',Opportunity_Num__c = 0, Opportunity_Field__c ='StageName', Static_Value__c = 'A/ Testing', Is_Required__c = false);mappingList.add(mapping03);
            //child1
            LeadConvertMapping__c mapping11 = new LeadConvertMapping__c(Name='Child 1 Application Fee',Opportunity_Num__c = 1, Opportunity_Field__c ='Assessment_Fee__c', Lead_Field__c = 'Child_1_Application_Fee_Paid__c', Is_Required__c = false);mappingList.add(mapping11);
            LeadConvertMapping__c mapping12 = new LeadConvertMapping__c(Name='Child 1 DOB',Opportunity_Num__c = 1, Opportunity_Field__c ='Birth_Date__c', Lead_Field__c = 'DateOfBirthFirstChild__c', Is_Required__c = false);mappingList.add(mapping12);
            LeadConvertMapping__c mapping13 = new LeadConvertMapping__c(Name='Child 1 Class',Opportunity_Num__c = 1, Opportunity_Field__c ='Class__c', Lead_Field__c = 'Child_1_Class_Derived_from_Campus__c', Is_Required__c = false);mappingList.add(mapping13);
            //LeadConvertMapping__c mapping14 = new LeadConvertMapping__c(Name='Child 1 Needs Extended',Opportunity_Num__c = 1, Opportunity_Field__c ='Extended_Needs_Description__c', Lead_Field__c = 'Child_1_Description__c', Is_Required__c = false);mappingList.add(mapping14);
            LeadConvertMapping__c mapping15 = new LeadConvertMapping__c(Name='Child 1 Gender',Opportunity_Num__c = 1, Opportunity_Field__c ='Gender__c', Lead_Field__c = 'GenderFirstChild__c', Is_Required__c = false);mappingList.add(mapping15);
            //LeadConvertMapping__c mapping16 = new LeadConvertMapping__c(Name='Child 1 Needs',Opportunity_Num__c = 1, Opportunity_Field__c ='Medical_Special_Needs_Condition__c', Lead_Field__c = 'Child1_Medical_or_Special_Needs__c', Is_Required__c = false);mappingList.add(mapping16);
            LeadConvertMapping__c mapping17 = new LeadConvertMapping__c(Name='Child 1 Full Name',Opportunity_Num__c = 1, Opportunity_Field__c ='Name', Lead_Field__c = 'Child_1_Full_Name__c', Is_Required__c = false);mappingList.add(mapping17);
            LeadConvertMapping__c mapping18 = new LeadConvertMapping__c(Name='Child 1 Nationality',Opportunity_Num__c = 1, Opportunity_Field__c ='Nationality__c', Lead_Field__c = 'Child_1_Nationality__c', Is_Required__c = false);mappingList.add(mapping18);
            LeadConvertMapping__c mapping19 = new LeadConvertMapping__c(Name='Child 1 First Name',Opportunity_Num__c = 1, Opportunity_Field__c ='Student_Name__c', Lead_Field__c = 'FirstNameFirstChild__c', Is_Required__c = false);mappingList.add(mapping19);
            LeadConvertMapping__c mapping110 = new LeadConvertMapping__c(Name='Child 1 Surname',Opportunity_Num__c = 1, Opportunity_Field__c ='Student_Surname__c', Lead_Field__c = 'LastNameFirstChild__c', Is_Required__c = false);mappingList.add(mapping110);
            //LeadConvertMapping__c mapping111 = new LeadConvertMapping__c(Name='Child 1 Year Group',Opportunity_Num__c = 1, Opportunity_Field__c ='Year_Group__c', Lead_Field__c = 'Child_1_Year_Group_Abb__c', Is_Required__c = false);mappingList.add(mapping111);
            //child 2
            LeadConvertMapping__c mapping21 = new LeadConvertMapping__c(Name='Child 2 Application Fee',Opportunity_Num__c = 2, Opportunity_Field__c ='Assessment_Fee__c', Lead_Field__c = 'Child_2_Application_Fee_Paid__c', Is_Required__c = false);mappingList.add(mapping21);
            LeadConvertMapping__c mapping22 = new LeadConvertMapping__c(Name='Child 2 DOB',Opportunity_Num__c = 2, Opportunity_Field__c ='Birth_Date__c', Lead_Field__c = 'DateOfBirthSecondChild__c', Is_Required__c = false);mappingList.add(mapping22);
            LeadConvertMapping__c mapping23 = new LeadConvertMapping__c(Name='Child 2 Class',Opportunity_Num__c = 2, Opportunity_Field__c ='Class__c', Lead_Field__c = 'Child_2_Class_Derived_from_Campus__c', Is_Required__c = false);mappingList.add(mapping23);
            //LeadConvertMapping__c mapping24 = new LeadConvertMapping__c(Name='Child 2 Needs Extended',Opportunity_Num__c = 2, Opportunity_Field__c ='Extended_Needs_Description__c', Lead_Field__c = 'Child_2_Description__c', Is_Required__c = false);mappingList.add(mapping24);
            LeadConvertMapping__c mapping25 = new LeadConvertMapping__c(Name='Child 2 Gender',Opportunity_Num__c = 2, Opportunity_Field__c ='Gender__c', Lead_Field__c = 'GenderSecondChild__c', Is_Required__c = false);mappingList.add(mapping25);
            //LeadConvertMapping__c mapping26 = new LeadConvertMapping__c(Name='Child 2 Needs',Opportunity_Num__c = 2, Opportunity_Field__c ='Medical_Special_Needs_Condition__c', Lead_Field__c = 'Child2_Medical_or_Special_Needs__c', Is_Required__c = false);mappingList.add(mapping26);
            LeadConvertMapping__c mapping27 = new LeadConvertMapping__c(Name='Child 2 Full Name',Opportunity_Num__c = 2, Opportunity_Field__c ='Name', Lead_Field__c = 'Child_2_Full_Name__c', Is_Required__c = true);mappingList.add(mapping27);
            LeadConvertMapping__c mapping28 = new LeadConvertMapping__c(Name='Child 2 Nationality',Opportunity_Num__c = 2, Opportunity_Field__c ='Nationality__c', Lead_Field__c = 'Child_2_Nationality__c', Is_Required__c = false);mappingList.add(mapping28);
            LeadConvertMapping__c mapping29 = new LeadConvertMapping__c(Name='Child 2 First Name',Opportunity_Num__c = 2, Opportunity_Field__c ='Student_Name__c', Lead_Field__c = 'FirstNameSecondChild__c', Is_Required__c = false);mappingList.add(mapping29);
            LeadConvertMapping__c mapping210 = new LeadConvertMapping__c(Name='Child 2 Surname',Opportunity_Num__c = 2, Opportunity_Field__c ='Student_Surname__c', Lead_Field__c = 'LastNameSecondChild__c', Is_Required__c = false);mappingList.add(mapping210);
            //LeadConvertMapping__c mapping211 = new LeadConvertMapping__c(Name='Child 2 Year Group',Opportunity_Num__c = 2, Opportunity_Field__c ='Year_Group__c', Lead_Field__c = 'Child_2_Year_Group_Abb__c', Is_Required__c = false);mappingList.add(mapping211);
            
            insert mappingList;
            
            //create company account account
            Account companyAccount =  new Account();
            companyAccount.Name =  'Company Account';
            companyAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
            insert companyAccount;
            //create account mapping
            Account_Owner_Mapping__c mapping =  new Account_Owner_Mapping__c();
            mapping.Account_Id__c = companyAccount.Id;
            mapping.Name =  UserInfo.getName();
            mapping.School_Name__c = [select School__c,Id from User where Id=:UserInfo.getUserId()].School__c;
            insert mapping;
            
            
            //create lead contact mapping
            List<Lead_Contact_Mapping__c> mappingListLeadContact =  new List<Lead_Contact_Mapping__c>();
            
            Lead_Contact_Mapping__c lcontactmapping0 = new Lead_Contact_Mapping__c(Name='Alternate Email',Lead_Field__c='Parent_2_Email_2__c',Contact_Field__c='Contact_Alternate_Email__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping1 = new Lead_Contact_Mapping__c(Name='Alternate Phone',Lead_Field__c='Parent_2_Phone_2__c',Contact_Field__c='Contact_Alternate_Phone__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping2 = new Lead_Contact_Mapping__c(Name='Alternate Phone Country Code',Lead_Field__c='Alternate_Phone_Country_CodePL_P2__c',Contact_Field__c='Contact_Alternate_Phone_Country_CodePL__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping3 = new Lead_Contact_Mapping__c(Name='Email Opt Out',Lead_Field__c='Parent_2_Email_Opt_Out__c',Contact_Field__c='HasOptedOutOfEmail',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping4 = new Lead_Contact_Mapping__c(Name='Employer',Lead_Field__c='Parent_2_Employer_Optional__c',Contact_Field__c='Contact_Employer__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping5 = new Lead_Contact_Mapping__c(Name='Employment Sector',Lead_Field__c='Second_Parent_Employment_Sector__c',Contact_Field__c='Contact_Employment_Sector__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping6 = new Lead_Contact_Mapping__c(Name='First Name',Lead_Field__c='Parent_2_Name__c',Contact_Field__c='FirstName',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping7 = new Lead_Contact_Mapping__c(Name='Last Name',Lead_Field__c='Parent_2_Last_Name__c',Contact_Field__c='LastName',Is_Required__c=true);
            Lead_Contact_Mapping__c lcontactmapping8 = new Lead_Contact_Mapping__c(Name='Main Email',Lead_Field__c='Parent_2_Email_1__c',Contact_Field__c='Email',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping9 = new Lead_Contact_Mapping__c(Name='Mobile/Main PhoneFirst Name',Lead_Field__c='Parent_2_Phone_1__c',Contact_Field__c='MobilePhone',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping10 = new Lead_Contact_Mapping__c(Name='Mobile/Main Phone Country Code',Lead_Field__c='Mobile_Main_Phone_Country_CodePL_P2__c',Contact_Field__c='Contact_Mobile_Main_Phone_Country_CodePL__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping12 = new Lead_Contact_Mapping__c(Name='Passport/Other ID#',Lead_Field__c='Second_Parent_CPF_ID__c',Contact_Field__c='Contact_Passport_Other_ID__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping13 = new Lead_Contact_Mapping__c(Name='Relationship',Lead_Field__c='Parent_2_Relationship__c',Contact_Field__c='Contact_Relationship__c',Is_Required__c=false);
            Lead_Contact_Mapping__c lcontactmapping14 = new Lead_Contact_Mapping__c(Name='Salutation',Lead_Field__c=null,Contact_Field__c='Salutation',Is_Required__c=false,Static_Value__c='Mr.');
            mappingListLeadContact.add(lcontactmapping0);
            mappingListLeadContact.add(lcontactmapping1);
            mappingListLeadContact.add(lcontactmapping2);
            mappingListLeadContact.add(lcontactmapping3);
            mappingListLeadContact.add(lcontactmapping4);
            mappingListLeadContact.add(lcontactmapping5);
            mappingListLeadContact.add(lcontactmapping6);
            mappingListLeadContact.add(lcontactmapping7);
            mappingListLeadContact.add(lcontactmapping8);
            mappingListLeadContact.add(lcontactmapping9);
            mappingListLeadContact.add(lcontactmapping10);
            mappingListLeadContact.add(lcontactmapping12);
            mappingListLeadContact.add(lcontactmapping13);
            mappingListLeadContact.add(lcontactmapping14);
            
            insert mappingListLeadContact;
            
            //create duplicate opportunities
            
            //create parent account accounts
            list<Account> parentAccounts = new list<Account>();
            
            Account parentAccount =  new Account();
            parentAccount.FirstName =  'First Name1';
            parentAccount.LastName =  'Last Name2';
            parentAccount.PersonEmail = 'testunique44444@test.com';
            parentAccount.Contact_Alternate_Email__pc = 'testunique999999@test.com';
            parentAccount.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
            parentAccount.Primary_Contact__c = 'First Parent';
            parentAccounts.add(parentAccount);
            
            Account parentAccount2 =  new Account();
            parentAccount2.FirstName =  'First Name12';
            parentAccount2.LastName =  'Last Name22';
            parentAccount2.PersonEmail = 'testunique255555@test.com';
            parentAccount2.Contact_Alternate_Email__pc = 'testunique888888@test.com';
            parentAccount2.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
            parentAccount2.Primary_Contact__c = 'First Parent';
            parentAccounts.add(parentAccount2);
            
            Account parentAccount3 =  new Account();
            parentAccount3.FirstName =  'First Name123';
            parentAccount3.LastName =  'Last Name223';
            parentAccount3.PersonEmail = 'testunique2366666@test.com';
            parentAccount3.Contact_Alternate_Email__pc = 'testunique3377777@test.com';
            parentAccount3.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
            parentAccount3.Primary_Contact__c = 'First Parent';
            parentAccount3.SchoolText__pc = 'The British College of Brazil';
            parentAccounts.add(parentAccount3);
            
            
            insert parentAccounts;
            
            //create students
            list<Opportunity> studentList = new list<Opportunity>();
            Opportunity o =  new Opportunity();
            o.Student_Number_Override__c = '12345';
            o.Student_Surname__c =  'Surname2';
            o.Name = 'Child2';
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
            studentList.add(o);
            
            
            Opportunity o0 =  new Opportunity();
            o0.Student_Number_Override__c = '12345-1';
            o0.Student_Surname__c =  'Surname2';
            o0.Name = 'Child2';
            o0.Gender__c = 'Male';
            o0.Year_Group__c = 'PN1';
            o0.Birth_Date__c =  Date.today().addYears(-10);
            o0.Application_Date__c = Date.today().addDays(-20);
            o0.Starting_Date__c =  Date.today().addDays(-10);
            o0.StageName = 'A/ Testing';
            o0.AccountId = parentAccount.Id;
            //o.Payer__c = companyAccount.Id;
            o0.CloseDate =  Date.today();
            o0.Student_Name__c = 'SN';
            o0.Class__c = 'A';
            studentList.add(o0);
            
            Opportunity o1 =  new Opportunity();
            o1.Student_Number_Override__c = '12345-2';
            o1.Student_Surname__c =  'Surname1';
            o1.Name = 'Child1';
            o1.Gender__c = 'Male';
            o1.Year_Group__c = 'PN1';
            o1.Birth_Date__c =  Date.today().addYears(-9);
            o1.Application_Date__c = Date.today().addDays(-20);
            o1.Starting_Date__c =  Date.today().addDays(-10);
            o1.StageName = 'A/ Testing';
            o1.AccountId = parentAccount2.Id;
            //o.Payer__c = companyAccount.Id;
            o1.CloseDate =  Date.today();
            o1.Student_Name__c = 'SN';
            o1.Class__c = 'A';
            studentList.add(o1);
            
            Opportunity o2 =  new Opportunity();
            o2.Student_Number_Override__c = '162345789';
            o2.Student_Surname__c =  'Surname1';
            o2.Name = 'Child1';
            o2.Gender__c = 'Male';
            o2.Year_Group__c = 'PN1';
            o2.Birth_Date__c =  Date.today().addYears(-9);
            o2.Application_Date__c = Date.today().addDays(-20);
            o2.Starting_Date__c =  Date.today().addDays(-10);
            o2.StageName = 'A/ Testing';
            o2.AccountId = parentAccount3.Id;
            //o.Payer__c = companyAccount.Id;
            o2.CloseDate =  Date.today();
            o2.Student_Name__c = 'SN';
            o2.Class__c = 'A';
            studentList.add(o2);
            
            insert studentList;
            o.StageName = 'Enrolled';
            update o;
            o1.StageName = 'Enrolled';
            update o1;
            
            //create lead 
            Lead l =  new Lead();
            l.Status = 'Open'; 
            l.Primary_Contact__c = 'First Parent';
            //parent 1
            l.FirstName = 'First Name';
            l.LastName = 'Last Name';
            l.Email = 'test88878787@test.com';
            l.Alternate_Email__c = 'alt4554545@test.com';
            l.Parent_1_Relationship__c = 'Father';
            //parent 2
            l.Parent_2_Name__c = 'FN2';
            l.Parent_2_Last_Name__c = 'LN2';
            l.Parent_2_Relationship__c = 'Mother';
            l.Parent_2_Email_1__c = 'test4545323242@test.com';
            l.Parent_2_Email_2__c = 'alt2009897@test.com';
            //dates
            l.Application_Date__c = Date.today().addDays(-20);
            l.Starting_Date__c = Date.today();
            l.ExpectedStartMonth__c = 'January';
            l.ExpectedStartYear__c = String.valueOf(Date.today().addYears(1).Year());
            
            //child 1
            l.FirstNameFirstChild__c= 'Child1';
            l.LastNameFirstChild__c = 'Surname1';
            l.GenderFirstChild__c = 'Male';
            l.Child_1_Year_Group__c = 'Year 1'; 
            l.DateOfBirthFirstChild__c = Date.today().addYears(-9);
            
            //child 2
            l.FirstNameSecondChild__c= 'Child2';
            l.LastNameSecondChild__c = 'Surname2';
            l.GenderSecondChild__c = 'Male';
            l.Child_2_Year_Group__c = 'Year 2';
            l.DateOfBirthSecondChild__c = Date.today().addYears(-10);
            
            //child 3
            l.FirstNameThirdChild__c= 'Child3';
            l.LastNameThirdChild__c = 'Surname3';
            l.GenderThirdChild__c = 'Male';
            l.Child_3_Year_Group__c = 'Year 3';
            l.DateOfBirthThirdChild__c = Date.today().addYears(-9);
            
            //child 4
            l.FirstNameFourthChild__c= 'Child4';
            l.LastNameFourthChild__c = 'Surname4';
            l.GenderFourthChild__c = 'Male';
            l.Child_4_Year_Group__c = 'Year 3';
            l.DateOfBirthFourthChild__c = Date.today().addYears(-9);

            //child 5
            l.FirstNameFifthChild__c= 'Child5';
            l.LastNameFifthChild__c = 'Surname5';
            l.GenderFifthChild__c = 'Male';
            l.DateOfBirthFifthChild__c = Date.today().addYears(-9);
            
            insert l;
            
            //start Test
            Test.startTest();
                ApexPages.StandardController s = new ApexPages.StandardController(l);
                ConvertLead_Controller controller =  new ConvertLead_Controller(s);
                //this scenario should fail with fatal error
                controller.existingOpportunitiesCheck();
                //now delete one of the opportunities to have only one parent identified 
                delete o1;
                //this scenario should mimic one student warning
                controller =  new ConvertLead_Controller(s);
                controller.existingOpportunitiesCheck();
                //this scenario should fail because chekbox is not checked
                //controller.agreementToAccountFound = false;
                controller.convertLead();
                //now check checkbox and convert lead again
                controller.agreementToAccountFound = true;
                controller.convertLead();
                
            Test.stopTest(); 
            //stop Test 
            
        }
    }
}