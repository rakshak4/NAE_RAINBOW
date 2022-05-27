/**
    Author: Kunal Sharma
    Dated: 03 March 2013
    Desc: Once Student(opportunity) stage changes from "Enrolled" to anything else, mark all respective group registrations as inactive.
    Audited By:
    Audit Date:
    
    Change Log:
    9 Oct 2013: Logic added to update students name on contact
    7 Oct 2013: Changes related to new Year Group fields and updating line items when opportunity close date is updated
    Kunal on 12 th July : to send Kompanion outbound message
**/
trigger HandleStudentStageUpdate on Opportunity (after update, after delete, after insert, after undelete) {  
    
    system.debug('****HandleStudentStageUpdate***start='+trigger.newMap); 
    //Set<Id> studentsToBeProcessedForStage =  new Set<Id>();
    //Set<Id> studentsToBeProcessedForEnrolled =  new Set<Id>();
    Set<Id> studentsToBeProcessedForNameOrYearGroup =  new Set<Id>();
    Set<Id> allStudentId =  new Set<Id>();
    Set<Id> allAccountId =  new Set<Id>();
    Set<Id> accountIdsForRollUp =  new Set<Id>();
    if(trigger.isUpdate){
        for(Opportunity student:trigger.new){
            
            allAccountId.add(student.AccountId);
            allAccountId.add(trigger.oldMap.get(student.Id).AccountId);
            /*if(!student.StageName.equalsIgnoreCase('Enrolled') && trigger.oldMap.get(student.Id).StageName.equalsIgnoreCase('Enrolled')){
                studentsToBeProcessedForStage.add(student.Id);
            }
            if(student.StageName.equalsIgnoreCase('Enrolled') && !trigger.oldMap.get(student.Id).StageName.equalsIgnoreCase('Enrolled')){
                studentsToBeProcessedForEnrolled.add(student.Id);
            }*/
            if(student.Name != trigger.oldMap.get(student.Id).Name || /*student.Year_Group__c != trigger.oldMap.get(student.Id).Year_Group__c || */student.Special_Considerations_Detail__c != trigger.oldMap.get(student.Id).Special_Considerations_Detail__c){
                studentsToBeProcessedForNameOrYearGroup.add(student.Id);
            }
            
            if(student.StageName != trigger.oldMap.get(student.Id).StageName || student.Year_Group__c != trigger.oldMap.get(student.Id).Year_Group__c || student.Add_to_Register__c != trigger.oldMap.get(student.Id).Add_to_Register__c || student.PN1_or_PN__c != trigger.oldMap.get(student.Id).PN1_or_PN__c){
                accountIdsForRollUp.add(student.AccountId);
            }
            if(student.StageName != trigger.oldMap.get(student.Id).StageName || student.Add_to_Register__c != trigger.oldMap.get(student.Id).Add_to_Register__c || student.CloseDate != trigger.oldMap.get(student.Id).CloseDate){
                allStudentId.add(student.Id);
            }
        }
    }else if(trigger.isDelete){
        for(Opportunity student:trigger.old){
            allAccountId.add(student.AccountId);
        }
    }else if(trigger.isInsert || trigger.isUnDelete){
        for(Opportunity student:trigger.new){
            allAccountId.add(student.AccountId);
            if(student.StageName == 'Enrolled' || (student.Add_to_Register__c == 'Yes' && student.StageName == 'A/ Deposit')){
                accountIdsForRollUp.add(student.AccountId);
            }
        }
    }
    
    //update registrations
    //process for change in stage
   
    if(allStudentId.size() > 0){
        List<Registration__c> registrationsToBeUpdated = new List<Registration__c>();
        //fetch all corresponding contact Ids aginast students to be processed for stage change
        for(Registration__c r:[select Group__r.Is_Whole_School_Group__c,Active__c, Student__r.Admissions_File__r.Leaving_Date__c, Include_Parent_in_Chatter_Group__c,Student__r.Starting_Date_from_student__c, Group__r.Name, Group__r.Group_Type__c,  Student__r.Admissions_File__r.StageName, Id,Attending_School_From_student__c, Student__r.Stage__c, Student__c, Student__r.Admissions_File__c from Registration__c where Student__r.Admissions_File__c IN:allStudentId AND Group__r.Is_Valid__c = true FOR UPDATE]){
            /* the following logic is transfered to Registration before trigger
            //for managing registration active or not
            if(r.Student__r.Stage__c == 'W/List A/Deposit' || r.Student__r.Stage__c == 'W/List D/Paid' || r.Student__r.Stage__c == 'A/ Testing' || r.Student__r.Stage__c == 'Left' || r.Student__r.Stage__c == 'Cancelled' || r.Student__r.Stage__c == 'Rejected' || (r.Student__r.Stage__c == 'A/ Deposit' && r.Attending_School_From_student__c ==false ) ){
                //populate registration deactivated date
                if(r.Active__c == true){
                    Date deactivatedDate ;
                    if(r.Student__r.Admissions_File__r.Leaving_Date__c < date.today().addDays(-1) && r.Student__r.Admissions_File__r.Leaving_Date__c != null){
                        deactivatedDate = r.Student__r.Admissions_File__r.Leaving_Date__c.addDays(1);
                    }else{
                        deactivatedDate = date.today();
                    }
                    r.Registration_Deactivated_Date__c = deactivatedDate;
                }
                r.Active__c = false;
                r.Starting_Date_Date_from_student__c = null;
                
                
            }else{
                //r.Active__c = true;
            }
            //for copying starting date
            if(r.Student__r.Admissions_File__r.StageName == 'Enrolled' || (r.Student__r.Admissions_File__r.StageName == 'A/ Deposit' && r.Attending_School_From_student__c == true)){
                r.Starting_Date_Date_from_student__c = r.Student__r.Starting_Date_from_student__c;
            }
            //for checking whole school group
            if(r.Group__r.Is_Whole_School_Group__c){
                r.Is_Whole_School_Group_Registration__c = true;
            }else{
                r.Is_Whole_School_Group_Registration__c = false;
            }
            //Populate Include in Chatter Group Until Date & Include Parent in chatter group
            if((r.Student__r.Stage__c == 'Enrolled' || (r.Student__r.Stage__c == 'A/ Deposit' && r.Attending_School_From_student__c == true)) && r.Group__r.Group_Type__c == 'Tutor Group'){
                r.Include_Parent_in_Chatter_Group_Until__c = r.Student__r.Starting_Date_from_student__c;
                if(r.Include_Parent_in_Chatter_Group_Until__c > date.today() && r.Include_Parent_in_Chatter_Group__c == false){
                    r.Include_Parent_in_Chatter_Group__c = true;
                }
            }*/
            //check for group academic year
            registrationsToBeUpdated.add(r);
        }
        /*for(Contact c:[Select c.Id, c.Stage__c, c.Admissions_File__c, (Select Id, Attending_School_From_student__c, Name, Active__c From Registrations__r FOR UPDATE) From Contact c where c.Admissions_File__c IN:allStudentId]){
            for(Registration__c r: c.Registrations__r){
                //Opportunity o = trigger.newMap.get(c.Admissions_File__c);
                if(c.Stage__c == 'W/List A/Deposit' || c.Stage__c == 'W/List D/Paid' || c.Stage__c == 'A/ Testing' || c.Stage__c == 'Left' || c.Stage__c == 'Cancelled' || c.Stage__c == 'Rejected' || (c.Stage__c == 'A/ Deposit' && r.Attending_School_From_student__c ==false ) ){
                    r.Active__c = false;
                    r.Starting_Date_Date_from_student__c = null;
                }
                registrationsToBeUpdated.add(r);
            }       
        } */
        if(registrationsToBeUpdated.size() > 0){
            update registrationsToBeUpdated;
        }   
    }
    
     
    /*
    //process for change in stage
    if(studentsToBeProcessedForStage.size() > 0){
        List<Registration__c> registrationsToBeUpdated = new List<Registration__c>();
        //fetch all corresponding contact Ids aginast students to be processed for stage change
        for(Contact c:[Select c.Id, c.Admissions_File__c, (Select Id, Name, Active__c From Registrations__r where Active__c = true) From Contact c where c.Admissions_File__c IN:studentsToBeProcessedForStage]){
            for(Registration__c r: c.Registrations__r){
                r.Active__c = false;
                registrationsToBeUpdated.add(r);
            }       
        } 
        
        
        if(registrationsToBeUpdated.size() > 0){
            update registrationsToBeUpdated;
        }   
    }
    
    //process for change in stage to enrolled
    if(studentsToBeProcessedForEnrolled.size() > 0){
        List<Registration__c> registrationsToBeUpdated = new List<Registration__c>();
        //fetch all corresponding contact Ids aginast students to be processed for stage change
        for(Contact c:[Select c.Id, c.Admissions_File__c, (Select Id, Name, Active__c From Registrations__r where Active__c = false AND Group_Type__c = 'School Group') From Contact c where c.Admissions_File__c IN:studentsToBeProcessedForEnrolled]){
            for(Registration__c r: c.Registrations__r){
                r.Active__c = true;
                registrationsToBeUpdated.add(r);
            }       
        } 
        
        
        if(registrationsToBeUpdated.size() > 0){
            update registrationsToBeUpdated;
        }   
    }
    */
    //process for change in student name
    if(studentsToBeProcessedForNameOrYearGroup.size() > 0){
        List<Contact> contactsToBeUpdated = new List<Contact>();
        //fetch all corresponding contact Ids aginast students to be processed for name change
        for(Contact c:[Select c.Id, c.Admissions_File__c,FirstName, LastName From Contact c where c.Admissions_File__c IN:studentsToBeProcessedForNameOrYearGroup]){
            c.FirstName = trigger.newMap.get(c.Admissions_File__c).Student_Name__c;
            c.LastName =  trigger.newMap.get(c.Admissions_File__c).Student_Surname__c;
            c.Special_Considerations_Detail__c = trigger.newMap.get(c.Admissions_File__c).Special_Considerations_Detail__c;
            if(c.LastName == null){
                c.LastName = 'NA';
            }
            //c.Email = trigger.newMap.get(c.Admissions_File__c).Student_Email__c;
            contactsToBeUpdated.add(c); 
        }
        if(contactsToBeUpdated.size() > 0){
            update contactsToBeUpdated;
        }   
    }
    //fetch account info
    map<Id,Account> accountMap = new map<Id,Account>();
    for(Account acc:[select Id, SchoolText__pc,  (select Id, StageName, Year_Group__c, PN1_or_PN__c from Opportunities where (StageName='Enrolled' OR (Add_to_Register__c = 'Yes' AND StageName = 'A/ Deposit'))) from Account where Id IN:allAccountId]){
        accountMap.put(acc.Id,acc);
    }
    //fetch line items and update
    if(trigger.isUpdate){
        set<Id> studentIdsForInvoiceUpdate = new set<Id>();
        for(Opportunity student:trigger.new){
            if(student.Manually_Audited_To_Date__c != trigger.oldMap.get(student.Id).Manually_Audited_To_Date__c || student.CloseDate != trigger.oldMap.get(student.Id).CloseDate){
                studentIdsForInvoiceUpdate.add(student.Id);
            }else if(accountMap.get(student.AccountId) != null){
                if(student.School__c != accountMap.get(student.AccountId).SchoolText__pc){
                    studentIdsForInvoiceUpdate.add(student.Id);
                }
            }
            //check for change in local language name of student
            if(student.Name_in_Local_Language__c != trigger.oldMap.get(student.Id).Name_in_Local_Language__c){
                studentIdsForInvoiceUpdate.add(student.Id);
            }
        }
        List<Line_Item__c> lineList =  new List<Line_Item__c>();
        for(Line_Item__c l:[select Id, Student__c from Line_Item__c where Student__c IN:studentIdsForInvoiceUpdate]){
            l.Student_Local_Name__c = trigger.newMap.get(l.Student__c).Name_in_Local_Language__c;
            lineList.add(l);
        }
        if(lineList.size() > 0){
            update lineList;
        }
    }
      
    //process all accounts and update roll up fields 
    List<Account> accList =  new List<Account>();
    //for(Account acc:[select Id, (select Id, StageName, Year_Group__c, PN1_or_PN__c from Opportunities where (StageName='Enrolled' OR (Add_to_Register__c = 'Yes' AND StageName = 'A/ Deposit'))) from Account where Id IN:allAccountId]){
    for(Id aid:accountIdsForRollUp){
        Account acc = accountMap.get(aid);
        decimal pre_nursery_count = 0;
        decimal nursery_count = 0;
        decimal reception_count = 0;
        decimal year_1_count = 0;
        decimal year_2_count = 0;
        decimal year_3_count = 0;
        decimal year_4_count = 0;
        decimal year_5_count = 0;
        decimal year_6_count = 0;
        decimal year_7_count = 0;
        decimal year_8_count = 0;
        decimal year_9_count = 0;
        decimal year_10_count = 0;
        decimal year_11_count = 0;
        decimal year_12_count = 0;
        decimal year_13_count = 0;
        if(acc != null){
            for(Opportunity o:acc.Opportunities){ 
                if(o.PN1_or_PN__c == 'PN'){
                    pre_nursery_count ++;
                }
                if(o.Year_Group__c == 'N'){
                    nursery_count ++;
                }
                if(o.Year_Group__c == 'R' || o.Year_Group__c == 'PK'){
                    reception_count ++;
                }
                if(o.Year_Group__c == 'Y1' || o.Year_Group__c == 'K'){
                    year_1_count ++;
                }
                if(o.Year_Group__c == 'Y2' || o.Year_Group__c == 'G1'){
                    year_2_count ++;
                }
                if(o.Year_Group__c == 'Y3' || o.Year_Group__c == 'G2'){
                    year_3_count ++;
                }
                if(o.Year_Group__c == 'Y4' || o.Year_Group__c == 'G3'){
                    year_4_count ++;
                }
                if(o.Year_Group__c == 'Y5' || o.Year_Group__c == 'G4'){
                    year_5_count ++;
                }
                if(o.Year_Group__c == 'Y6' || o.Year_Group__c == 'G5'){
                    year_6_count ++;
                }
                if(o.Year_Group__c == 'Y7' || o.Year_Group__c == 'G6'){
                    year_7_count ++;
                }
                if(o.Year_Group__c == 'Y8' || o.Year_Group__c == 'G7'){
                    year_8_count ++;
                }
                if(o.Year_Group__c == 'Y9' || o.Year_Group__c == 'G8'){
                    year_9_count ++;
                }
                if(o.Year_Group__c == 'Y10' || o.Year_Group__c == 'G9'){
                    year_10_count ++;
                }
                if(o.Year_Group__c == 'Y11' || o.Year_Group__c == 'G310'){
                    year_11_count ++;
                }
                if(o.Year_Group__c == 'Y12' || o.Year_Group__c == 'G11'){
                    year_12_count ++;
                }
                if(o.Year_Group__c == 'Y13' || o.Year_Group__c == 'G12'){
                    year_13_count ++;
                }
            }
            //populate account
            acc.PreNursery__c = pre_nursery_count;
            acc.Nursery1__c = nursery_count;
            acc.Reception1__c = reception_count;
            acc.Year1__c = year_1_count;
            acc.Year2__c = year_2_count;
            acc.Year3__c = year_3_count;
            acc.Year4__c = year_4_count;
            acc.Year5__c = year_5_count;
            acc.Year6__c = year_6_count;
            acc.Year7__c = year_7_count;
            acc.Year8__c = year_8_count;
            acc.Year9__c = year_9_count;
            acc.Year10__c = year_10_count;
            acc.Year11__c = year_11_count;
            acc.Year12__c = year_12_count;
            acc.Year13__c = year_13_count;
            accList.add(acc);
        }
        
    }
    if(accList.size() > 0){
        update accList;
    } 
    system.debug('****HandleStudentStageUpdate***end='+trigger.newMap); 
    
    if(trigger.isAfter && trigger.isUpdate){
        system.debug('***AnnualRollover***start:'+trigger.newMap);
        Map<String, String> opportunities = new Map<String, String>();
        for(String opId : trigger.newMap.keySet()) {
            
            Opportunity newOp = trigger.newMap.get(opId);
            Opportunity oldOp = trigger.oldMap.get(opId);
            
            
            // if the year group has been changed then set all current fees to noncurrent and create a new Tuition fee
            if(oldOp !=null && oldOp.Year_Group__c != newOp.Year_Group__c || (oldOp.Half_Day_PN_N__c == null && newOp.Half_Day_PN_N__c != null) || (oldOp.Half_Day_PN_N__c != null && newOp.Half_Day_PN_N__c == null)) 
            {
                // if so add it to the map for changing it to the new year
                opportunities.put(newOp.Id, newOp.Year_Group__c);
            }
            
            
        }
        if(opportunities.size() > 0) {
            IncrementTuitionFee.execute(opportunities,false,trigger.newMap);  
        }
        system.debug('***AnnualRollover***end:'+trigger.newMap);
    }
    
    //for sending outbound message to Kompanion
    if(trigger.isAfter && trigger.isUpdate){
        set<Id> sIds =  new set<Id>();
        for(Opportunity o:trigger.new){
            if(o.Trigger_Batch_SendKompanionOutbound__c == true && trigger.oldMap.get(o.Id).Trigger_Batch_SendKompanionOutbound__c == false){
                sIds.add(o.Id);
            }
        }
        if(sIds.size() > 0){
            Batch_SendKompanionOutboundMessage b = new Batch_SendKompanionOutboundMessage(sIds);
            database.executeBatch(b,1);
        }
    }
}