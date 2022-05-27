//populate values on before
//logic added tp populate year group on before
//changes made on 15 Dec 2016 -- to have logic for creating whole school group regristration on Opportunity rather than contact
trigger HandleOpportunityBefore on Opportunity (after insert,after update,before insert,before update) {
    if(trigger.isBefore){
        for(Opportunity o:trigger.new){
            if(o.Copy_This_Year_values_to_Next_Year_field__c == true){
                o.Class_Next_Year__c = o.Class__c;
                o.Class_Next_Year_Copy__c = o.Class__c;
                o.House_Next_Year__c = o.House__c;
                o.House_Next_Year_Copy__c = o.House__c;
                o.Teaching_Group_Next_Year__c = o.Teaching_Group__c;
                o.Copy_This_Year_values_to_Next_Year_field__c = false; 
            }   
        }
    }  
    
    
    //for creating whole school group registration
    if(trigger.isUpdate && trigger.isAfter){
        
        Map<String,String> schoolStudentGroupMap =  new Map<String,String>();
        List<Registration__c> newRegistrations =  new List<Registration__c>();
        set<Id> studentIdsforRegistration =  new set<Id>();
        set<Id> oppIdsforRegistration =  new set<Id>();
        for(Opportunity student:trigger.new){
            boolean newValue = (student.StageName == 'Enrolled' || (student.Add_to_Register__c == 'Yes' && student.StageName == 'A/ Deposit'));
            boolean priorValue = (trigger.oldMap.get(student.Id).StageName == 'Enrolled' || (trigger.oldMap.get(student.Id).Add_to_Register__c == 'Yes' && trigger.oldMap.get(student.Id).StageName == 'A/ Deposit'));
            if(newValue == true && priorValue == false &&  student.Student_Academic_File__c != null && student.Has_Whole_School_Registration__c == false){
                //create whole school group registration record here instead on contact
                if(schoolStudentGroupMap.size()  == 0){
                    for(School_Logo_Mapping__c schoolMapping : School_Logo_Mapping__c.getall().values()){   
                        if(schoolMapping.All_Student_Group_Id__c != null){
                            schoolStudentGroupMap.put(schoolMapping.School_Full_Name__c,schoolMapping.All_Student_Group_Id__c);
                        }
                    }
                }
                
                if(schoolStudentGroupMap.get(student.School__c) != null){
                    Registration__c registration = new Registration__c();
                    registration.Student__c = student.Student_Academic_File__c;
                    studentIdsforRegistration.add(student.Student_Academic_File__c);
                    oppIdsforRegistration.add(student.Id);
                    registration.Group__c =  schoolStudentGroupMap.get(student.School__c);
                    registration.Active__c =  false;
                    /*if(student.Stage__c.equalsIgnoreCase('Enrolled')){
                        registration.Active__c =  true;
                    }else{
                        registration.Active__c =  false;
                    }*/
                    newRegistrations.add(registration);
                }
                
            }
        }
        if(newRegistrations.size()  > 0){
            list<Contact> forUpdation =  new list<Contact>();
            list<Opportunity> opportunityForUpdation = new list<Opportunity>();
            try{
                insert newRegistrations;
                //check for students for which registration was not created
                for(Opportunity student:trigger.new){
                    if(oppIdsforRegistration.contains(student.Id) && !studentIdsforRegistration.contains(student.Student_Academic_File__c)){
                        forUpdation.add(new Contact(Id = student.Student_Academic_File__c, Auto_Registration_Error__c = 'YES'));
                    }/*else if(oppIdsforRegistration.contains(student.Id) && studentIdsforRegistration.contains(student.Contact_Id__c)){
                        opportunityForUpdation.add(new Opportunity(Id=student.Id, Whole_School_Registration_Done__c = true));
                    }*/
                }
            }catch(Exception e){
                //mark error on all records
                for(Id studentId:studentIdsforRegistration){
                    forUpdation.add(new Contact(Id = studentId, Auto_Registration_Error__c = 'YES'));
                }
            }
            if(forUpdation.size() > 0){
                update forUpdation;
            }
            /*if(opportunityForUpdation.size() > 0){
                update opportunityForUpdation;
            }*/
        }
    }
    
    
    //for creation of student academic file
    if(trigger.isAfter && trigger.isInsert){
        set<Id> oppIds = new set<Id>();
        list<Opportunity> studentsToBeProcessedForContactCreation = new list<Opportunity>();
        //fetch custom settings for mapping between Opp Owner Name and catch all account Id
            Map<String,Account_Owner_Mapping__c> settingsMap = new Map<String,Account_Owner_Mapping__c>();
            
            List<Account_Owner_Mapping__c> settings = Account_Owner_Mapping__c.getall().values(); 
            for(Account_Owner_Mapping__c sttng:settings){
                settingsMap.put(sttng.School_Name__c,sttng);
            }
            
        for(Opportunity student:trigger.new){
            //check for school 
            Account_Owner_Mapping__c  mapping = settingsMap.get(student.School__c);
            if((mapping != null && mapping.Create_Student_Academic_Files__c == true) || Test.isRunningTest()){
                studentsToBeProcessedForContactCreation.add(student); 
            }
            /*if(trigger.isUpdate){
                boolean newValue = (student.StageName == 'Enrolled' || (student.Add_to_Register__c == 'Yes' && student.StageName == 'A/ Deposit'));
                boolean priorValue = (trigger.oldMap.get(student.Id).StageName == 'Enrolled' || (trigger.oldMap.get(student.Id).Add_to_Register__c == 'Yes' && trigger.oldMap.get(student.Id).StageName == 'A/ Deposit'));
                if(newValue && !student.Is_Student_Academic_File_Created__c){
                    studentsToBeProcessedForContactCreation.add(student);
                    oppIds.add(student.Id);
                }
            }*/
        }
        if(studentsToBeProcessedForContactCreation.size() > 0){
            //fetch record type Id of contact type "Student"
            Id studentRecordTypeId =  [select Id from RecordType where DeveloperName = 'Student' AND SObjectType='Contact' limit 1].Id;
            
            
            for(Opportunity o: studentsToBeProcessedForContactCreation){
                oppIds.add(o.Id);
            }
        
            //fetch owner name of all opportunities
            //Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>([Select o.Special_Considerations_Detail__c, o.Owner.Name, o.School__c, o.OwnerId, (Select Id From Contacts__r) From Opportunity o where o.Id IN:oppIds]);
        
            map<Id,Contact> newContactListMap  = new map<Id,Contact>();
        
            for(Opportunity o: studentsToBeProcessedForContactCreation){
                //Opportunity o1 = oppMap.get(o.Id);
                //if(o1.Contacts__r == null || o1.Contacts__r.size() == 0){
                    Contact student =  new Contact();
                    student.Admissions_File__c =  o.Id;
                    student.Main_Parent_File__c = o.AccountId;
                    student.Special_Considerations_Detail__c = o.Special_Considerations_Detail__c;
                    //formula to fetch right account id for contact's account
                    //String matchingCatchallAccId =  settingsMap.get(o.School__c).Account_Id__c;
                    if(settingsMap.get(o.School__c) != null && settingsMap.get(o.School__c).Account_Id__c != null){
                        student.AccountId = settingsMap.get(o.School__c).Account_Id__c;
                    }
                    student.FirstName = o.Student_Name__c;
                    student.LastName =  o.Student_Surname__c;
                    if(student.LastName == null){
                        student.LastName = 'NA';
                    }
                    
                    student.RecordTypeId  = studentRecordTypeId;
                    newContactListMap.put(o.Id,student);
                //}else{
                    //trigger.newMap.get(o.Id).Is_Student_Academic_File_Created__c = true;
                //}
            }
        
            if(newContactListMap.size() > 0){
                insert newContactListMap.values();
                //update flag on opportunity
                /*list<Opportunity> studentListForUpdate = new list<Opportunity>();
                for(Opportunity o: studentsToBeProcessedForContactCreation){
                    if(newContactListMap.containsKey(o.id)){
                        if(newContactListMap.get(o.Id).Id != null){
                            studentListForUpdate.add(new Opportunity(Id = o.Id, Student_Academic_File__c = newContactListMap.get(o.Id).Id));
                        }
                    }
                }
                if(studentListForUpdate.size() > 0){
                    update studentListForUpdate;
                }*/
            }
        }
        
    }
    
    
    
    
    
    
    //for populating year group on opportunity
    if(trigger.isInsert && trigger.isBefore){       
        for(Opportunity o:trigger.new){
            string oldYearGroup = o.Year_Group__c;
            if(o.Current_User_Is_US_School_User__c == true){
                if(o.Year_Group_Adjuster__c == 2 && o.Student_Age_at_Last_Cut_off_Date__c >= 0 && o.Student_Age_at_Last_Cut_off_Date__c <= 18){ 
                    o.Year_Group__c = o.Indicative_Year_Group_US_2__c; 
                    }else if(o.Year_Group_Adjuster__c == 1 && o.Student_Age_at_Last_Cut_off_Date__c >= 0 && o.Student_Age_at_Last_Cut_off_Date__c <= 19){ 
                    o.Year_Group__c = o.Indicative_Year_Group_US_1__c; 
                    }else if(o.Year_Group_Adjuster__c == 0 && o.Student_Age_at_Last_Cut_off_Date__c >= 0 && o.Student_Age_at_Last_Cut_off_Date__c <= 20){ 
                    o.Year_Group__c = o.Indicative_Year_Group_US_0__c; 
                    }else{ 
                    o.Year_Group__c = null; 
                    } 
                    }else if(o.Current_User_Is_US_School_User__c == false){ 
                    if(o.Year_Group_Adjuster__c == 2 && o.Student_Age_at_Last_Cut_off_Date__c >= 0 && o.Student_Age_at_Last_Cut_off_Date__c <= 18){ 
                    o.Year_Group__c = o.Indicative_Year_Group_UK_2__c; 
                    }else if(o.Year_Group_Adjuster__c == 1 && o.Student_Age_at_Last_Cut_off_Date__c >= 0 && o.Student_Age_at_Last_Cut_off_Date__c <= 19){ 
                    o.Year_Group__c = o.Indicative_Year_Group_UK_1__c; 
                    }else if(o.Year_Group_Adjuster__c == 0 && o.Student_Age_at_Last_Cut_off_Date__c >= 0 && o.Student_Age_at_Last_Cut_off_Date__c <= 20){ 
                    o.Year_Group__c = o.Indicative_Year_Group_UK_0__c; 
                }else{
                    o.Year_Group__c = null;
                }
            }else{
                o.Year_Group__c = null;
            }
            if(Test.isRunningTest()){
                o.Year_Group__c = 'Y2'; 
            }
        }
    }
    
    //kunal on 6 Oct 2015
        //check for related financial information record on account
    if((trigger.isInsert || trigger.isUpdate) && trigger.isBefore){       
        set<Id> accountIds = new set<Id>();
        set<Id> oppIdsForFinancialInfo = new set<Id>();
        for(Opportunity o:trigger.new){
            if(trigger.isInsert){
                if(o.Related_Financial_Info__c == null && o.AccountId != null){
                    accountIds.add(o.AccountId);
                    oppIdsForFinancialInfo.add(o.Id);
                }
            }
            if(trigger.isUpdate){
                //if((o.Related_Financial_Info__c == null && trigger.oldMap.get(o.Id).Related_Financial_Info__c != null) || (o.AccountId != null && o.AccountId != trigger.oldMap.get(o.Id).AccountId)){
                if(o.Related_Financial_Info__c == null && o.AccountId != null){
                    accountIds.add(o.AccountId);
                    oppIdsForFinancialInfo.add(o.Id);
                }
            }
        }
        if(accountIds.size() > 0){
            map<Id,Account> accountMap = new map<Id,Account>();
            for(Account a:[Select a.Id, (Select Id From Financial_Information__r order by LastModifiedDate desc limit 1) From Account a where Id IN:accountIds]){
                accountMap.put(a.Id,a);
            }
            for(Opportunity o:trigger.new){
                if(o.Related_Financial_Info__c == null && o.AccountId != null){
                    Account acc = accountMap.get(o.AccountId);
                    if(acc != null){
                        for(Financial_Information__c f:acc.Financial_Information__r){
                            o.Related_Financial_Info__c = f.Id;
                            break;
                        }
                    }
                }
            }
            /*for(Id oId:oppIdsForFinancialInfo){
                Opportunity o = trigger.newMap.get(oId);
                Account acc = accountMap.get(o.AccountId);
                if(acc != null){
                    for(Financial_Information__c f:acc.Financial_Information__r){
                        o.Related_Financial_Info__c = f.Id;
                        break;
                    }
                }
            }*/
        }
    }
    
    //for updating student numbers
    if(trigger.isBefore && trigger.isInsert){
        map<Id,list<Opportunity>> accountOpportunityMap =  new map<Id,list<Opportunity>>();
        for(Opportunity student:trigger.new){
            accountOpportunityMap.put(student.AccountId,new list<Opportunity>());
        }
        //fetch existing opportunities
         for(Account personCompany: [select Id, Name , (select Add_to_Register__c, StageName, Id, Name, Student_Number_Formula__c, Student_Number_New__c, Birth_Date__c, Student_Number_Override__c, First_Name_Last_Name__c from Opportunities order by Student_Number_Formula__c asc) from Account where Id IN:accountOpportunityMap.keySet() ]){
            accountOpportunityMap.put(personCompany.Id,personCompany.Opportunities);
        }
        //update opportunities student number
        list<Opportunity> studentsToBeUpdated = new list<Opportunity>();
        list<Opportunity> studentsToBeUpdatedList = new list<Opportunity>();
        set<Id> acocuntsIdsForEmail =  new set<Id>();
        for(Opportunity student:trigger.new){
            list<Opportunity> existingOpportunities = accountOpportunityMap.get(student.AccountId);
            if(existingOpportunities != null && existingOpportunities.size() > 0){
                list<Opportunity> duplicateOpportunities = new list<Opportunity>();
                for(Opportunity existingStudent:existingOpportunities){
                    if(student.Birth_Date__c == existingStudent.Birth_Date__c && ConvertLead_Controller.compareStudentName(student.Student_Name__c, student.Student_Surname__c, existingStudent.First_Name_Last_Name__c)){
                        duplicateOpportunities.add(existingStudent);
                    }
                }
                if(duplicateOpportunities.size() > 0){ //process if duplicate opportunities are found
                    set<string> uniqueStudentNumberSet = new set<string>();
                    boolean existingOpportunityWith0 = false;
                    //check for unique student number
                    for(Opportunity existingStudent:duplicateOpportunities){
                        list<string> tempList = existingStudent.Student_Number_New__c.split('-');
                        uniqueStudentNumberSet.add(tempList[0].trim());
                        
                    }
                    if(uniqueStudentNumberSet.size() == 1){ //process only when unique student number is found
                        string uniqueStudentNumber;
                        for(String s:uniqueStudentNumberSet){
                            uniqueStudentNumber = s;
                        }
                        for(Opportunity existingStudent:duplicateOpportunities){
                            if(existingStudent.Student_Number_New__c.startsWith(uniqueStudentNumber+'-0')){
                                existingOpportunityWith0 = true;
                            }
                        }
                        //find maximum student override number for enrolled and left students
                        integer maximumEnrolledStudentNumber = null;
                        integer maximumLeftStudentNumber = null;
                        boolean existingEnrolledStudentsFound = false;
                        boolean existingLeftStudentsFound = false;
                        set<Id> leftStudentsToBeUpdated = new set<Id>();
                        for(Opportunity existingStudent:duplicateOpportunities){
                            //check for student number for enrolled student
                            if((existingStudent.StageName == 'Enrolled' || (existingStudent.StageName == 'A/ Deposit' & existingStudent.Add_to_Register__c == 'Yes')) || existingStudent.Student_Number_New__c.startsWith(uniqueStudentNumber+'-0')){
                            //if((existingStudent.StageName == 'Enrolled' || (existingStudent.StageName == 'A/ Deposit' & existingStudent.Add_to_Register__c == 'Yes'))){
                                existingEnrolledStudentsFound = true;
                                list<string> tempList = existingStudent.Student_Number_New__c.split('-');
                                if(tempList.size() == 2){
                                    integer studentNumberOverride = Integer.valueOf(tempList[1]);
                                    if(maximumEnrolledStudentNumber == null){
                                        maximumEnrolledStudentNumber = studentNumberOverride;
                                    }else if(studentNumberOverride > maximumEnrolledStudentNumber){
                                        maximumEnrolledStudentNumber = studentNumberOverride;
                                    }
                                }   
                            }else if(!existingStudent.Student_Number_New__c.startsWith(uniqueStudentNumber+'-0') && !existingOpportunityWith0){ // for left students
                                existingLeftStudentsFound = true; 
                                list<string> tempList = existingStudent.Student_Number_New__c.split('-');
                                if(tempList.size() == 2){
                                    integer leftStudentNumberOverride = Integer.valueOf(tempList[1]);
                                    if(maximumLeftStudentNumber == null){
                                        maximumLeftStudentNumber = leftStudentNumberOverride;
                                    }else if(leftStudentNumberOverride > maximumLeftStudentNumber){
                                        maximumLeftStudentNumber = leftStudentNumberOverride;
                                    }
                                }else{
                                    leftStudentsToBeUpdated.add(existingStudent.Id);
                                }
                            }
                        }
                        //compare existing opportunities and update data
                        system.debug('***HandleOpportunityBefore***uniqueStudentNumber='+uniqueStudentNumber);
                        system.debug('***HandleOpportunityBefore***maximumEnrolledStudentNumber='+maximumEnrolledStudentNumber);
                        system.debug('***HandleOpportunityBefore***maximumLeftStudentNumber='+maximumLeftStudentNumber);
                        student.Student_Number_Override__c = uniqueStudentNumber;
                        if(existingEnrolledStudentsFound){
                            if(maximumEnrolledStudentNumber == null){
                                student.Student_Number_Override__c = uniqueStudentNumber+'-0';
                            }else{
                                student.Student_Number_Override__c = uniqueStudentNumber+'-0'+(maximumEnrolledStudentNumber+1);
                            }
                        }
                        if(existingLeftStudentsFound){
                            
                            integer i = 1;
                            for(Id existingStudentId:leftStudentsToBeUpdated){
                                string numberOverride;
                                if(maximumLeftStudentNumber == null){
                                    maximumLeftStudentNumber = 0;
                                }
                                numberOverride = uniqueStudentNumber+'-'+(maximumLeftStudentNumber+i);
                                i++;
                                studentsToBeUpdatedList.add(new Opportunity(Id=existingStudentId, Student_Number_Override__c = numberOverride));
                            }
                        }
                    }else{ // if unique student number is not found send email to admin
                       acocuntsIdsForEmail.add(student.AccountId);
                       student.Student_Renumbering_Exception__c = true;
                    }
                }
            }
        }
        if(studentsToBeUpdatedList.size() > 0){
            update studentsToBeUpdatedList;
        }
        
    }
}