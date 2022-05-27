public class ConvertLead_Controller {
    public SObject lead {get;set;}
    public Id lead_id {get;set;}
    private List<LeadConversionMapping> mappingList ;
    public Lead forParent {get;set;}
    private LeadConversionMapping mapping0;
    private Map<String,String> settingsMap;
    public string existingParentWarning {get;set;}
    public boolean isError{get;set;}
    public string lead_query {get;set;}
    //for opportunity duplication
    private set<Id> child1DuplicateIds {get;set;}
    private set<Id> child2DuplicateIds {get;set;}
    private set<Id> child3DuplicateIds {get;set;}
    private set<Id> child4DuplicateIds {get;set;}
    private set<Id> child5DuplicateIds {get;set;}
    
    public boolean accountFound {get;set;}
    public string accountFoundName {get;set;}
    public Id accountFoundId {get;set;}
    public boolean duplicationProcessed {get;set;}
    public boolean agreementToAccountFound {get;set;}
    
    public ConvertLead_Controller(ApexPages.StandardController controller) {
        isError = false;
        duplicationProcessed = false;
        agreementToAccountFound = true;
        accountFound = false;
        //check for logged in User school
        User loogedInUser = [select Id,School__c from User where Id=:UserInfo.getUserId()];
        if(loogedInUser.School__c == 'The British Schools Foundation' || loogedInUser.School__c == 'NAE'){
            isError = true;
        }
        if(!isError || Test.isRunningTest()){
            lead_id = controller.getId();
            //fetch custom settings
            settingsMap = new Map<String,String>();
            List<Account_Owner_Mapping__c> settings = Account_Owner_Mapping__c.getall().values(); 
            for(Account_Owner_Mapping__c sttng:settings){
                if(sttng.Account_Id__c != null && sttng.Account_Id__c != ''){
                    settingsMap.put(sttng.School_Name__c,sttng.Account_Id__c);
                }
            }
            
            string l_fields = null;
            set<String> l_fields_set = new set<String>();
            for(LeadConvertMapping__c mapping:LeadConvertMapping__c.getall().values()){
                if(mapping.Lead_Field__c != null && mapping.Lead_Field__c != ''){
                    l_fields_set.add(mapping.Lead_Field__c);
                }
            } 
            for(Lead_Contact_Mapping__c mapping:Lead_Contact_Mapping__c.getall().values()){
                if(mapping.Lead_Field__c != null && mapping.Lead_Field__c != ''){
                    l_fields_set.add(mapping.Lead_Field__c);
                }
            }
            l_fields_set.add('School_Applying__c');
            for(string l_fld:l_fields_set){
                if(l_fields == null){
                    l_fields = ' '+l_fld;
                }else{
                    l_fields += ' , '+l_fld;
                }
            }
            
            string query = 'select '+l_fields +'  from Lead where Id = \''+controller.getId()+'\'';
            lead_query = query;
            //lead = [Select l.Child_1_Special_Note__c, l.xsms__SMS_Opt_Out__c, l.xsms__Mobile_Phone_Country__c, l.xsms__Mobile_Phone_Country_Code__c, l.xsms__Last_SMS_received__c, l.xsms__Inbound_MobilePhone_Format__c, l.xsms__Clean_Mobile_Phone__c, l.iContactforSF__iContact_Contact_Id__c, l.FirstNameSecondChild__c, l.Year_Group_s_of_Children_in_Enquiry__c, l.Website_Form_Type__c, l.Website, l.Walkin__c, l.User__c, l.User_School__c, l.Title, l.Territory__c, l.SystemModstamp, l.Subject_of_enquiry__c, l.Street, l.Stay_in_Touch__c, l.Status, l.State, l.Starting_Term__c, l.Starting_Date__c, l.Second_Parent_Employment_Sector__c, l.Second_Parent_CPF_ID__c, l.School__c, l.School_Website__c, l.School_Applying__c, l.Salutation, l.Rating_Visual__c, l.Rating, l.Quick_Note__c, l.Primary_Contact__c, l.PostalCode, l.Phone_Number__c, l.Phone_Call__c, l.Phone_2__c, l.Phone, l.Parent_Company__c, l.Parent_2_Salutation__c, l.Parent_2_Relationship__c, l.Parent_2_Phone_2__c, l.Parent_2_Phone_1__c, l.Parent_2_Name__c, l.Parent_2_Last_Name__c, l.Parent_2_Full_Name__c, l.Parent_2_Employer_Optional__c, l.Parent_2_Email_Opt_Out__c, l.Parent_2_Email_2__c, l.Parent_2_Email_1__c, l.Parent_1_Relationship__c, l.Parent_1_Phone_2__c, l.Parent_1_Phone_1__c, l.Parent_1_Employer_Optional__c, l.Owner_Copy__c, l.OwnerId, l.Online__c, l.Online_Enquiry__c, l.Online_Application_Submission__c, l.Online_App_T_Cs_Accepted__c, l.Number_of_Children_in_Enquiry_Value__c, l.NumberOfEmployees, l.Non_English_Salutation__c, l.Name_s_of_Children_in_Enquiry__c, l.Name_of_Company_to_Invoice__c, l.Name_of_Company_to_Invoice_Actual__c, l.Name, l.MobilePhone, l.MasterRecordId, l.Mass_Email__c, l.Main_Address__c, l.Link_to_Online_Application__c, l.Link_to_Newsletter__c, l.Link_to_Declaration_Form__c, l.Link_to_Contact_Us__c, l.Link_to_Admissions_Booklet__c, l.Link_Online_Application__c, l.Lead_owner__c, l.LeadSource, l.LastName, l.LastModifiedDate, l.LastModifiedById, l.LastActivityDate, l.JigsawContactId, l.Jigsaw, l.IsUnreadByOwner, l.IsDeleted, l.IsConverted, l.Invoicing_Instructions__c, l.Invoice_to__c, l.Industry, l.Include_Email2_in_Mass_Emails_del__c, l.Id, l.HasOptedOutOfFax, l.HasOptedOutOfEmail, l.First_Sentence_Email_Reply__c, l.First_Parent_Employment_Sector__c, l.First_Parent_CPF_ID__c, l.FirstName, l.Fax_Number__c, l.Fax, l.Enquiry_ID__c, l.Enquiry_Date__c, l.Email_Address__c, l.EmailBouncedReason, l.EmailBouncedDate, l.Email, l.Description, l.Department__c, l.CurrencyIsoCode, l.CreatedDate, l.CreatedById, l.Create_a_New_Company__c, l.Country, l.Copy_Parent__c, l.ConvertedOpportunityId, l.ConvertedDate, l.ConvertedContactId, l.ConvertedAccountId, l.Contact_Note__c, l.Confirm_Email__c, l.Company_Contact_Person__c, l.Company_CNPJ_ID__c, l.Company, l.Combined_Campus_Text_ISM__c, l.Combined_Campus_Text_BCB__c, l.City, l.Child_4_Year_Group__c, l.Child_4_Year_Group_Abb__c, l.LastNameFourthChild__c, l.Child_4_Nationality__c, l.FirstNameFourthChild__c, l.Child_4_Medical_or_Special_Needs__c, l.GenderFourthChild__c, l.Child_4_Full_Name__c, l.Child_4_File__c, l.Child_4_Description__c, l.DateOfBirthFourthChild__c, l.Child_4_DOB_Year__c, l.Child_4_DOB_Month__c, l.Child_4_DOB_Day__c, l.Child_4_Class_Derived_from_Campus__c, l.Child_4_Campus__c, l.Child_4_Application_Fee_Paid__c, l.Child_3_Year_Group__c, l.Child_3_Year_Group_Abb__c, l.LastNameThirdChild__c, l.Child_3_Nationality__c, l.FirstNameThirdChild__c, l.GenderThirdChild__c, l.Child_3_Full_Name__c, l.Child_3_File__c, l.Child_3_Description__c, l.DateOfBirthThirdChild__c, l.Child_3_DOB_Year__c, l.Child_3_DOB_Month__c, l.Child_3_DOB_Day__c, l.Child_3_Class_Derived_from_Campus__c, l.Child_3_Campus__c, l.Child_3_Application_Fee_Paid__c, l.Child_2_Year_Group__c, l.Child_2_Year_Group_Abb__c, l.LastNameSecondChild__c, l.Child_2_Nationality__c, l.GenderSecondChild__c, l.Child_2_Full_Name__c, l.Child_2_File__c, l.Child_2_Description__c, l.DateOfBirthSecondChild__c, l.Child_2_DOB_Year__c, l.Child_2_DOB_Month__c, l.Child_2_DOB_Day__c, l.Child_2_Class_Derived_from_Campus__c, l.Child_2_Campus__c, l.Child_2_Application_Fee_Paid__c, l.Child_1_Year_Group__c, l.Child_1_Year_Group_Abb__c, l.LastNameFirstChild__c, l.Child_1_Nationality__c, l.FirstNameFirstChild__c, l.GenderFirstChild__c, l.Child_1_Full_Name__c, l.Child_1_File__c, l.Child_1_Description__c, l.DateOfBirthFirstChild__c, l.Child_1_DOB_Year__c, l.Child_1_DOB_Month__c, l.Child_1_DOB_Day__c, l.Child_1_Class_Derived_from_Campus__c, l.Child_1_Campus__c, l.Child_1_Application_Fee_Paid__c, l.Child4_Medical_or_Special_Needs_NIU__c, l.Child3_Medical_or_Special_Needs__c, l.Child2_Medical_or_Special_Needs__c, l.Child1_Medical_or_Special_Needs__c, l.Campuses_Text__c, l.Bus_Service_Likely_Required__c, l.Auto_reply_Language__c, l.AppliedVNotApplied__c, l.Application_Date__c, l.AnnualRevenue, l.Alternate_Email__c, l.Additional_Contact_Information__c, l.A_Testing__c From Lead l where l.Id=:controller.getId()];
            lead = Database.query(query);
            forParent = new Lead();
            //fetch and parse settings
            handleConversionSettings();
            System.debug('***ConvertLead_Controller***mappingList='+mappingList);
            //check for existing parent records
            //existingParentWarning = checkForExistingParents();
        }else{
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'Users with School "The British Schools Foundation" can not convert enquiries.');
            ApexPages.addMessage(errorMessage);
        }
    }
    
    public PageReference existingOpportunitiesCheck(){
        duplicationProcessed = false;
        accountFound = false;
        agreementToAccountFound = true;
        Lead temp_lead = [select School__c, LastNameFirstChild__c, LastNameSecondChild__c, LastNameThirdChild__c, LastNameFourthChild__c, LastNameFifthChild__c, FirstNameFirstChild__c, FirstNameSecondChild__c, FirstNameThirdChild__c, FirstNameFourthChild__c, FirstNameFifthChild__c, DateOfBirthFirstChild__c, DateOfBirthSecondChild__c, DateOfBirthThirdChild__c, DateOfBirthFourthChild__c, DateOfBirthFifthChild__c, Authorise_Convert__c, Id, Alternate_Email__c, Email, Parent_2_Email_1__c, Parent_2_Email_2__c from Lead where Id=:lead_id];
        map<string, list<Opportunity>> duplicateOpportunities = checkForExistingOpportunities(temp_lead);
        
        list<Opportunity> sameSchoolOpportunityList = new list<Opportunity>();
        list<Opportunity> differentSchoolOpportunityList = new list<Opportunity>();
        
        if(duplicateOpportunities != null){
            for(String school : duplicateOpportunities.keySet()){
                for(Opportunity student:duplicateOpportunities.get(school)){
                    if(student.School__c == temp_lead.School__c){
                        sameSchoolOpportunityList.add(student);
                    }else{
                        differentSchoolOpportunityList.add(student);
                    }
                }
            }
        }
        child1DuplicateIds = new set<Id>();
        child2DuplicateIds = new set<Id>();
        child3DuplicateIds = new set<Id>();
        child4DuplicateIds = new set<Id>();
        child5DuplicateIds = new set<Id>();
        //populate exisiting opportunities info for different school opportunities
        for(Opportunity student:differentSchoolOpportunityList){
                if(temp_lead.DateOfBirthFirstChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFirstChild__c,temp_lead.LastNameFirstChild__c,student.First_Name_Last_Name__c )){
                    child1DuplicateIds.add(student.Id);
                }
                if(temp_lead.DateOfBirthSecondChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameSecondChild__c,temp_lead.LastNameSecondChild__c,student.First_Name_Last_Name__c )){
                    child2DuplicateIds.add(student.Id);
                }
                if(temp_lead.DateOfBirthThirdChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameThirdChild__c,temp_lead.LastNameThirdChild__c,student.First_Name_Last_Name__c )){
                    child3DuplicateIds.add(student.Id);
                }
                if(temp_lead.DateOfBirthFourthChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFourthChild__c,temp_lead.LastNameFourthChild__c,student.First_Name_Last_Name__c )){
                    child4DuplicateIds.add(student.Id);
                } 
                if(temp_lead.DateOfBirthFifthChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFifthChild__c,temp_lead.LastNameFifthChild__c,student.First_Name_Last_Name__c )){
                    child5DuplicateIds.add(student.Id);
                }
        }
        //for same school opportunities , check for multiple account Ids 
        set<Id> accountIds = new set<Id>();
        for(Opportunity student:sameSchoolOpportunityList){
            accountIds.add(student.AccountId);
            
        }
        //if for same school multiple students are found
        if(accountIds.size() > 0){
            for(Opportunity student:sameSchoolOpportunityList){
                if(temp_lead.DateOfBirthFirstChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFirstChild__c,temp_lead.LastNameFirstChild__c,student.First_Name_Last_Name__c )){
                    child1DuplicateIds.add(student.Id);
                }
                if(temp_lead.DateOfBirthSecondChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameSecondChild__c,temp_lead.LastNameSecondChild__c,student.First_Name_Last_Name__c )){
                    child2DuplicateIds.add(student.Id);
                }
                if(temp_lead.DateOfBirthThirdChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameThirdChild__c,temp_lead.LastNameThirdChild__c,student.First_Name_Last_Name__c )){
                    child3DuplicateIds.add(student.Id);
                }
                if(temp_lead.DateOfBirthFourthChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFourthChild__c,temp_lead.LastNameFourthChild__c,student.First_Name_Last_Name__c )){
                    child4DuplicateIds.add(student.Id);
                }
                if(temp_lead.DateOfBirthFifthChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFifthChild__c,temp_lead.LastNameFifthChild__c,student.First_Name_Last_Name__c )){
                    child5DuplicateIds.add(student.Id);
                }  
            } 
        }
        //populate lead fields with duplicate opportunity Ids
        temp_lead.Child_1_Possible_Duplicate_Opportunities__c = getIdString(child1DuplicateIds);
        temp_lead.Child_2_Possible_Duplicate_Opportunities__c = getIdString(child2DuplicateIds);
        temp_lead.Child_3_Possible_Duplicate_Opportunities__c = getIdString(child3DuplicateIds);
        temp_lead.Child_4_Possible_Duplicate_Opportunities__c = getIdString(child4DuplicateIds);
        temp_lead.Child_5_Possible_Duplicate_Opportunities__c = getIdString(child5DuplicateIds);
        update temp_lead;
        
        //if more then one account found show fatal error message
        if(accountIds.size() > 1){
            forParent = null;
            string fatalMessage = 'It appears that you are trying to convert an enquiry that contains a student or students who already have a student record against multiple existing parent accounts. This is a very rare scenario and you must contact your system administrator to resolve it. Please include in the message a screenshot of this page and a link to the enquiry you are trying to convert.';
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, fatalMessage);
            ApexPages.addMessage(errorMessage);
        }else if(accountIds.size() == 1){//if only one account found promt only one account selection 
            accountFound = true;
            agreementToAccountFound = false;
            Id accId ;
            for(Id aid:accountIds){
                accId = aId;
                accountFoundId = accId;
                accountFoundName = [select Name from Account where Id=:accountFoundId].Name;
            }
            forParent.Mass_Email__c = accId;
            string warningMessage = '';
            
            warningMessage += 'It appears that you are trying to convert an enquiry that contains students who already have a student record. You have two options:';
            warningMessage += '<br/>'+'1) Click the parent name to view the record in a new window. If this is the same family then tick the box next to the parent account name below and click ‘Convert’ to link the new students to the existing parent account OR';
            warningMessage += '<br/>'+'2) If you need to create a new parent account then please contact your system administrator, including in the message a screenshot of this page, a link to the enquiry you are trying to convert and the reason, then click ‘Cancel’ above.';
            
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.WARNING , warningMessage);
            ApexPages.addMessage(errorMessage);
        }else{//if no account found show account selection
            //do nothing
        }
        duplicationProcessed = true;
        return null;
    }
    
    private string getIdString(set<Id> Idset){
        string final_s = null;
        string sf_url = 'https://ap4.salesforce.com';
        for(Id tid:Idset){
            if(final_s == null){
                final_s = sf_url+'/'+tid;
            }else{
                final_s += '\n'+sf_url+'/'+tid;
            }
        }
        return final_s;
    }
    
    //function to compare names of students
    public static boolean compareStudentName(string firstName, string lastName, string compareString){
        boolean isDuplicate = false;
        set<String> nameList = new set<String>();
        for(string s:compareString.toLowerCase().split(' ')){
            nameList.add(s);
        }
        if(firstName != null){
            for(String s:firstName.toLowerCase().split(' ')){
                if(nameList.contains(s)){
                    isDuplicate = true;
                }
            }
        }
        if(lastName != null){
            for(String s:lastName.toLowerCase().split(' ')){
                if(nameList.contains(s)){
                    isDuplicate = true;
                }
            }
        }
        return isDuplicate;
    }
    
    //return value map<school name, list of matching students>
    private map<string, list<Opportunity>> checkForExistingOpportunities(Lead temp_lead){
        map<string, list<Opportunity>> duplicateOpportunitiesMap = new map<string, list<Opportunity>>();
        //fetch details from Lead
        
        //if Authorise_Convert__c is checked on Lead do not process duplication logic
        if(!temp_lead.Authorise_Convert__c){
            for(Opportunity student:[select Id, School__c, AccountId, Account.Name, Birth_Date__c, First_Name_Last_Name__c from Opportunity where Birth_Date__c != null AND (Birth_Date__c =: temp_lead.DateOfBirthFirstChild__c   OR Birth_Date__c =: temp_lead.DateOfBirthSecondChild__c   OR Birth_Date__c =: temp_lead.DateOfBirthThirdChild__c   OR Birth_Date__c =: temp_lead.DateOfBirthFourthChild__c   OR Birth_Date__c =: temp_lead.DateOfBirthFifthChild__c )]){
                boolean isDuplicate = false;
                set<String> nameList = new set<String>();
                for(string s:student.First_Name_Last_Name__c.toLowerCase().split(' ')){
                    nameList.add(s);
                }
                //check for child 1
                if(temp_lead.DateOfBirthFirstChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFirstChild__c,temp_lead.LastNameFirstChild__c,student.First_Name_Last_Name__c )){
                    isDuplicate = true;
                }
                //check for child 2
                if(temp_lead.DateOfBirthSecondChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameSecondChild__c,temp_lead.LastNameSecondChild__c,student.First_Name_Last_Name__c )){
                    isDuplicate = true;
                }
                //check for child 3
                if(temp_lead.DateOfBirthThirdChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameThirdChild__c,temp_lead.LastNameThirdChild__c,student.First_Name_Last_Name__c )){
                    isDuplicate = true;
                }
                //check for child 4
                if(temp_lead.DateOfBirthFourthChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFourthChild__c,temp_lead.LastNameFourthChild__c,student.First_Name_Last_Name__c )){
                    isDuplicate = true;
                }
                //check for child 5
                if(temp_lead.DateOfBirthFifthChild__c == student.Birth_Date__c && compareStudentName(temp_lead.FirstNameFifthChild__c,temp_lead.LastNameFifthChild__c,student.First_Name_Last_Name__c )){
                    isDuplicate = true;
                }
                
                if(isDuplicate){
                    if(duplicateOpportunitiesMap.containsKey(student.School__c)){
                        duplicateOpportunitiesMap.get(student.School__c).add(student);
                    }else{
                        list<Opportunity> tempList = new list<Opportunity>();
                        tempList.add(student);
                        duplicateOpportunitiesMap.put(student.School__c, tempList);
                    }
                }
            }
        }
        if(duplicateOpportunitiesMap.size() == 0){
            duplicateOpportunitiesMap = null;
        }
        return duplicateOpportunitiesMap;
    }
    /* 
    private string checkForExistingParents(){
        string message;
        set<string> emailsOnLead = new set<string>();
        Lead temp_lead = [select Authorise_Convert__c, Id,Alternate_Email__c, Email, Parent_2_Email_1__c, Parent_2_Email_2__c from Lead where Id=:lead_id];
        if(temp_lead.Email != null){
            emailsOnLead.add(temp_lead.Email);          
        }
        if(temp_lead.Alternate_Email__c != null){
            emailsOnLead.add(temp_lead.Alternate_Email__c);         
        }
        if(temp_lead.Parent_2_Email_1__c != null){
            emailsOnLead.add(temp_lead.Parent_2_Email_1__c);        
        }
        if(temp_lead.Parent_2_Email_2__c != null){
            emailsOnLead.add(temp_lead.Parent_2_Email_2__c);        
        }
        if(emailsOnLead.size() > 0){ 
            //fetch user school
            User u = [select School__c , Id from User where Id=:UserInfo.getUserId()];
                    
            //check for parents
            list<Account> existingAccounts = new list<Account>();
            for(Account parent:[select Id, Name from Account where RecordType.DeveloperName='PersonAccount' AND (SchoolText__pc =:u.School__c OR  Company_School__c =: u.School__c) AND  (PersonEmail IN:emailsOnLead OR Contact_Alternate_Email__pc IN:emailsOnLead OR Account_Main_Email_Formula__c IN:emailsOnLead OR Account_Alternate_Email_Formula__c IN:emailsOnLead) order by Name asc]){
                existingAccounts.add(parent);
            }
            
            if(existingAccounts.size() > 0){
                message = 'WARNING: Email addresses in this enquiry have been found on an existing parent record. This could mean the parent already has a child in school in which case you should link this new application to the existing record.';
                //message = 'One of the email addresses in this enquiry has been found on an existing parent record. This could mean the parent already has a child in school and you may want to link this new application to that record. What do you want to do now?" Available buttons: \'Cancel Conversion\' OR \'Create Completely New Parent Record\'';
                message += '</br>';
                message += '- Click the link(s) below to view the relevant parent records (open in a new tab)';
                message += '</br>';
                for(Account acc:existingAccounts){
                    message += '<a href="/'+acc.Id+'" target="_blank">'+acc.Name+'</a></br>';                   
                }
                message += '- Select an existing parent in the box below then click \'Convert\' to link any students in the enquiry to the existing parent record';
                message += '</br>';
                message += '- Click \'Convert\' to continue and create a completely new parent record regardless';
                message += '</br>';
                message += '- Click \'Cancel\' to cancel the conversion process';
                                
            }
        }
        return message;
    }*/
    
    //fetch and parse settings
    private void handleConversionSettings(){
        mappingList  = new List<LeadConversionMapping>();
        mapping0 = new LeadConversionMapping(1);
        LeadConversionMapping mapping1 = new LeadConversionMapping(1);
        LeadConversionMapping mapping2 = new LeadConversionMapping(2);
        LeadConversionMapping mapping3 = new LeadConversionMapping(3);
        LeadConversionMapping mapping4 = new LeadConversionMapping(4);
        LeadConversionMapping mapping5 = new LeadConversionMapping(5);
        for(LeadConvertMapping__c mapping:LeadConvertMapping__c.getall().values()){
            if(mapping.Opportunity_Num__c == 1){
                mapping1.mappings.add(mapping);
            }else if(mapping.Opportunity_Num__c == 2){
                mapping2.mappings.add(mapping);
            }else if(mapping.Opportunity_Num__c == 3){
                mapping3.mappings.add(mapping);
            }else if(mapping.Opportunity_Num__c == 4){
                mapping4.mappings.add(mapping);
            }else if(mapping.Opportunity_Num__c == 5){
                mapping5.mappings.add(mapping);
            }else if(mapping.Opportunity_Num__c == 0){
                mapping0.mappings.add(mapping);
            } 
        }
        mappingList.add(mapping1);
        mappingList.add(mapping2);
        mappingList.add(mapping3);
        mappingList.add(mapping4);
        mappingList.add(mapping5);
    }
    
    //function to convert lead
    public PageReference convertLead(){
        //fire query again to get updated information on lead
        lead = Database.query(lead_query);
        PageReference pg;
        if(agreementToAccountFound){
            try{
                //convert lead
                System.debug('***ConvertLead_Controller***convertLead***mappingList='+mappingList);
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(lead.id);
                LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
                lc.setConvertedStatus(convertStatus.MasterLabel);
                lc.setDoNotCreateOpportunity(true);
                if(forParent.Mass_Email__c != null){
                    lc.setAccountId(forParent.Mass_Email__c);
                }
                System.debug('***ConvertLead_Controller***convertLead***lc='+lc);
                Database.LeadConvertResult lcr = Database.convertLead(lc);
                if(lcr.isSuccess()){                
                    //create opportunities
                    List<SObject> studentList =  new List<SObject>();
                    for(LeadConversionMapping conversionMapping:mappingList){
                        System.debug('***ConvertLead_Controller***convertLead***conversionMapping='+conversionMapping);
                        SObject opp =  new Opportunity();
                        opp.put('AccountId',lcr.getAccountId());
                        boolean processOpp = false;
                        boolean mandatoryCheck = true;
                        //process mapping for defined 
                        for(LeadConvertMapping__c mapping:conversionMapping.mappings){
                            System.debug('***ConvertLead_Controller***convertLead***mapping='+mapping);
                            if(mapping.Lead_Field__c != null && mapping.Opportunity_Field__c != null){
                                if(mapping.Is_Required__c == true){
                                    if(lead.get(mapping.Lead_Field__c) == null){
                                        mandatoryCheck = false;
                                    }
                                }
                                
                                opp.put(mapping.Opportunity_Field__c,lead.get(mapping.Lead_Field__c));
                                processOpp = true;
                                
                            }else if(mapping.Static_Value__c != null && mapping.Opportunity_Field__c != null && mapping.Is_Required__c == false){
                                opp.put(mapping.Opportunity_Field__c,mapping.Static_Value__c);
                                processOpp = true;
                            }
                        }
                        
                        if(processOpp == true && mandatoryCheck == true){
                            //process for all mapping setting 0
                            for(LeadConvertMapping__c mapping:mapping0.mappings){
                                System.debug('***ConvertLead_Controller***convertLead***mapping0='+mapping);
                                if(mapping.Lead_Field__c != null && mapping.Opportunity_Field__c != null){
                                    opp.put(mapping.Opportunity_Field__c,lead.get(mapping.Lead_Field__c));
                                }else if(mapping.Static_Value__c != null && mapping.Opportunity_Field__c != null){
                                    opp.put(mapping.Opportunity_Field__c,mapping.Static_Value__c);
                                }
                            }
                            studentList.add(opp);
                        }
                    }
                    System.debug('***ConvertLead_Controller***convertLead***studentList='+studentList);
                    if(studentList.size()  > 0){
                        insert studentList;
                    }
                    /*
                    //edit opportunities to update siblings
                    //fetch all opportunities against account
                    List<Opportunity> accountAllStudents  =  new List<Opportunity>();
                    for(Opportunity o:[select Id from Opportunity where AccountId=:lcr.getAccountId() order by CreatedDate]){
                        accountAllStudents.add(o);
                    }
                    //assign sibling to opportunities
                    for(Opportunity o:accountAllStudents){
                        integer counter = 1;
                        for(Opportunity sibling:accountAllStudents){
                            if(sibling.Id != o.Id){
                                if(counter == 1){
                                    o.Sibling_1__c = sibling.Id;
                                    counter ++;
                                }else if(counter == 2){
                                    o.Sibling_2__c = sibling.Id;
                                    counter ++;
                                }else if(counter == 3){
                                    o.Sibling_3__c = sibling.Id;
                                    counter ++;
                                }else if(counter == 4){
                                    o.Sibling_4__c = sibling.Id;
                                    counter ++;
                                }   
                            }
                        }
                    }
                    if(accountAllStudents.size() > 0){
                        update accountAllStudents;
                    }
                    */
                    //create second contact
                    if(forParent.Mass_Email__c == null){
                        createSecondContact(lcr.getAccountId());
                    }
                    //redirect to account
                    pg  =  new PageReference('/'+lcr.getAccountId());
                }else{
                    String message = 'Enquiry Conversion Failed : '+lcr.getErrors();
                    ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, message);
                    ApexPages.addMessage(errorMessage);
                }
            }catch(Exception e){
                throw e;
            }
        }else{
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.FATAL, 'You must tick the box below to confirm you have checked and are happy to link the new students to the existing parent account.');
            ApexPages.addMessage(errorMessage);
            if(accountFound == true){
                string warningMessage = '';
            
                warningMessage += 'It appears that you are trying to convert an enquiry that contains students who already have a student record. You have two options:';
                warningMessage += '<br/>'+'1) Click the parent name to view the record in a new window. If this is the same family then tick the box next to the parent account name below and click ‘Convert’ to link the new students to the existing parent account OR';
                warningMessage += '<br/>'+'2) If you need to create a new parent account then please contact your system administrator, including in the message a screenshot of this page, a link to the enquiry you are trying to convert and the reason, then click ‘Cancel’ above.';
                
                ApexPages.Message warningMessage1 = new ApexPages.Message(ApexPages.severity.WARNING , warningMessage);
                ApexPages.addMessage(warningMessage1);
            }
        }
        return pg;
    }
        
    private void createSecondContact(Id aid){
        boolean mandatoryCheck = true;
        boolean doProcess = false;
        SObject secondContact =  new Contact();
        secondContact.put('Main_Parent_File__c',aid);
        //fetch mass email account id
        string school = (string)lead.get('School_Applying__c');
        string massEmailAccountId  =  settingsMap.get(school);
        if(massEmailAccountId != null && massEmailAccountId != ''){
            secondContact.put('AccountId',massEmailAccountId);
        }
        //set record type
        Id additionalParentRecordType = [select Id from RecordType where SObjectType='Contact' AND DeveloperName = 'Additional_Parent' limit 1].Id;
        secondContact.put('RecordTypeId',additionalParentRecordType);
        
        //fetch mapping setting
        map<String,Lead_Contact_Mapping__c> leadContactMapping =  new map<String,Lead_Contact_Mapping__c>();
        for(Lead_Contact_Mapping__c lcm:Lead_Contact_Mapping__c.getall().values()){
            if(lcm.Contact_Field__c != null && lcm.Contact_Field__c != ''){
                leadContactMapping.put(lcm.Contact_Field__c,lcm);
            }
        }
        //populate contact fields
        for(String contactField:leadContactMapping.keySet()){
            Lead_Contact_Mapping__c lcm = leadContactMapping.get(contactField);
            //check for lead field
            if(lcm.Lead_Field__c != null && lcm.Lead_Field__c != ''){
                //get lead value
                object leadValue = lead.get(lcm.Lead_Field__c);
                // required check
                if(lcm.Is_Required__c && (leadValue == null)){
                    mandatoryCheck = false;
                }else{
                    secondContact.put(contactField,leadValue);
                    doProcess = true;
                }
            }else if(lcm.Static_Value__c != null && lcm.Static_Value__c != ''){
                secondContact.put(contactField,lcm.Static_Value__c);
                doProcess = true;
            }
        }
        if(mandatoryCheck && doProcess){
            insert secondContact;
            //update main parent
            Account a = new Account(Id=aid);
            a.Related_Contact_Record_P2__c = secondContact.Id;
            update a; 
        }   
    }
    
    public PageReference cancel(){
        return new PageReference('/'+lead.Id);
    }
    
    public class LeadConversionMapping{
        public List<LeadConvertMapping__c> mappings {get;set;}
        public integer num {get;set;}
        public LeadConversionMapping(integer i ){
            mappings =  new List<LeadConvertMapping__c>();
            num = i;
        }
        
    }   
    
    //wrapper class for duplicate student records 
     
}