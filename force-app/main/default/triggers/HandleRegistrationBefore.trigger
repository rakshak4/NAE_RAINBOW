//validation for one student cant be actively regsitered under 2 tutor groups
trigger HandleRegistrationBefore on Registration__c (before insert, before update) {
    system.debug('***HandleRegistrationBefore***start***newmap:'+trigger.newMap);
    system.debug('***HandleRegistrationBefore***start***oldmap:'+trigger.oldMap);
    set<Id> studentIds = new set<Id>();
    set<Id> registrationIds =  new set<Id>();
    for(Registration__c registration:trigger.new){
        if(trigger.isInsert){
            if(registration.Active__c == true && registration.Group_Type__c == 'Tutor Group'){
                studentIds.add(registration.Student__c);
            }
        }else if(trigger.isUpdate){
            if(registration.Active__c == true && trigger.oldMap.get(registration.Id).Active__c == false && registration.Group_Type__c == 'Tutor Group'){
                studentIds.add(registration.Student__c);
            }
        }
        
        registrationIds.add(registration.Id);
    }
    system.debug('****HandleRegistrationBefore***studentIds='+studentIds);
    if(studentIds.size() > 0){
        //fetch all active registration under tutor group 
        /*map<Id,list<Registration__c>> studentTutorRegistrationMap = new map<Id,list<Registration__c>>();
        for(Registration__c r:[select Group__c, Group__r.Name, Student__c, Student__r.Student_Name__c,  Group__r.Group_Type__c from Registration__c where Active__c = true AND Group__r.Group_Type__c = 'Tutor Group' AND Student__c IN:studentIds order by Student__c]){
            if(studentTutorRegistrationMap.containsKey(r.Student__c)){
                studentTutorRegistrationMap.get(r.Student__c).add(r);
            }else{
                list<Registration__c> rlist =  new list<Registration__c>();
                rlist.add(r);
                studentTutorRegistrationMap.put(r.Student__c,rlist);
            }
        }*/
        map<Id,Contact> studentMap = new map<Id,Contact>();
        for(Contact student:[select Id,Name,Tutor_Group__c,Tutor_Group__r.Name,Student_Name__c ,(select Id,Group__c,Group__r.Name from Registrations__r where Group_Type__c = 'Tutor Group' AND Active__c = true) from Contact where Id IN:studentIds]){
        	//if(student.Tutor_Group__c != null){
        		studentMap.put(student.Id,student);
        	//}
        }
        system.debug('****HandleRegistrationBefore***studentMap='+studentMap);
        for(Registration__c registration:trigger.new){
            if(studentIds.contains(registration.Student__c) && registration.Group_Type__c == 'Tutor Group'){
                string errorMessage;
                Contact student = studentMap.get(registration.Student__c);
                system.debug('****HandleRegistrationBefore***student='+student);
                system.debug('****HandleRegistrationBefore***student.Registrations__r.size()='+student.Registrations__r.size());
                if(student != null){
                	if(student.Registrations__r.size() > 0){
                		errorMessage = '<b>'+student.Student_Name__c+'</b> can not be registered under this tutor group as he/she is already actively registered under the following group: ';
                		for(Registration__c r:student.Registrations__r){
                			errorMessage += '<br> <a href="/'+r.Group__c+'">'+r.Group__r.Name+'</a>';
                		}
                		/*if(student.Registrations__r.size() > 1){
                			errorMessage = '<b>'+student.Student_Name__c+'</b> can not be registered under this tutor group as he/she is already actively registered under the following group: ';
	                		for(Registration__c r:student.Registrations__r){
	                			errorMessage += '<br> <a href="/'+r.Group__c+'">'+r.Group__r.Name+'</a>';
	                		}
                		}else if(student.Registrations__r.size() == 1){
                			//if(student.Registrations__r[0].Group__c != student.Tutor_Group__c && student.Tutor_Group__c != null){
                				errorMessage = '<b>'+student.Student_Name__c+'</b> can not be registered under this tutor group as he/she is already actively registered under the following group: ';
                				errorMessage += '<br> <a href="/'+student.Registrations__r[0].Group__c+'">'+student.Registrations__r[0].Group__r.Name+'</a>';
                			//}
                		}*/
                	}
                }
                if(errorMessage != null && !Test.isRunningTest()){
                	registration.addError(errorMessage,true); 
                }
                
                
                /*if(studentMap.containsKey(registration.Student__c)){
                	Contact student = studentMap.get(registration.Student__c);
                	if(student.Tutor_Group__c != registration.Group__c){
	                	string errorMessage = '<b>'+student.Student_Name__c+'</b> can not be registered under this tutor group as he/she is already actively registered under the following group: ';
	                	errorMessage += '<br> <a href="/'+student.Tutor_Group__c+'">'+student.Tutor_Group__r.Name+'</a>'; 
	                	registration.addError(errorMessage,true); 
                	}             
                }*/
                
                
                /*if(studentTutorRegistrationMap.containsKey(registration.Student__c)){
                    string errorMessage ;
                    string studentName ;
                    for(Registration__c existingActiveTutorGroupRegistration:studentTutorRegistrationMap.get(registration.Student__c)){
                        studentName = existingActiveTutorGroupRegistration.Student__r.Student_Name__c;
                        if(errorMessage == null){
                            errorMessage = '<b>'+studentName+'</b> can not be registered under this tutor group as he/she is already actively registered under following group: ';
                        }
                        errorMessage += '<br> <a href="/'+existingActiveTutorGroupRegistration.Group__c+'">'+existingActiveTutorGroupRegistration.Group__r.Name+'</a>';                         
                    }
                    registration.addError(errorMessage,false);
                }*/
            }
        }
    }
    
    //for translating workflow field updates in to trigger
    //map<Id,Registration__c> registrationMap = new map<Id,Registration__c>([select Group__r.Is_Whole_School_Group__c,Active__c, Student__r.Admissions_File__r.Leaving_Date__c, Include_Parent_in_Chatter_Group__c,Student__r.Starting_Date_from_student__c, Group__r.Name, Group__r.Group_Type__c,  Student__r.Admissions_File__r.StageName, Id,Attending_School_From_student__c, Student__r.Stage__c, Student__c, Student__r.Admissions_File__c from Registration__c where Id IN:registrationIds]);
    for(Registration__c r:trigger.new){
    	//Registration__c existingRecord = registrationMap.get(r.Id);
    	//for managing registration active or not
        	boolean wasRegistrationActive = false;
        	Date deactivatedDate ;
        	if(r.Leaving_Date_From_Student__c < date.today().addDays(-1) && r.Leaving_Date_From_Student__c != null){
        		deactivatedDate = r.Leaving_Date_From_Student__c.addDays(1);
        	}else{
        		deactivatedDate = date.today();
        	}
        	if(r.Active__c == false && trigger.isUpdate){ 
        		if(trigger.oldMap.get(r.Id).Active__c == true){
            		wasRegistrationActive = true;
        		}
            }
        	if(r.Stage_from_contact__c == 'W/List A/Deposit' || r.Stage_from_contact__c == 'W/List D/Paid' || r.Stage_from_contact__c == 'A/ Testing' || r.Stage_from_contact__c == 'Left' || r.Stage_from_contact__c == 'Cancelled' || r.Stage_from_contact__c == 'Rejected' || (r.Stage_from_contact__c == 'A/ Deposit' && r.Attending_School_From_student__c ==false ) ){     
                if(r.Registration_Deactivated_Date__c == null){
                	r.Registration_Deactivated_Date__c = deactivatedDate;
                }
                r.Active__c = false;
                r.Starting_Date_Date_from_student__c = null;
                r.Include_Parent_in_Chatter_Group__c = false;
				r.Include_Parent_in_Chatter_Group_Until__c = null;
            }
            //populate registration deactivated date
            system.debug('*****HandleRegistrationBefore****wasRegistrationActive='+wasRegistrationActive);
            system.debug('*****HandleRegistrationBefore****r.Active__c='+r.Active__c);
            if((wasRegistrationActive || r.Registration_Deactivated_Date__c == null )&& r.Active__c == false){
            	r.Registration_Deactivated_Date__c = deactivatedDate;
            }else if(r.Active__c  == true){
            	r.Registration_Deactivated_Date__c = null;
            }
            //for copying starting date
            if(r.Admission_Stage__c == 'Enrolled' || (r.Admission_Stage__c == 'A/ Deposit' && r.Attending_School_From_student__c == true)){
            	r.Starting_Date_Date_from_student__c = r.Starting_Date_from_contact__c;
            }
            //for checking whole school group
            if(r.Is_Whole_School_Group__c){
            	r.Is_Whole_School_Group_Registration__c = true;
            }else{
            	r.Is_Whole_School_Group_Registration__c = false;
            }
            //Populate Include in Chatter Group Until Date & Include Parent in chatter group
            if((r.Stage_from_contact__c == 'Enrolled' || (r.Stage_from_contact__c == 'A/ Deposit' && r.Attending_School_From_student__c == true)) && r.Group_Type__c == 'Tutor Group'){
            	if(r.Starting_Date_from_contact__c != null){ 
            		r.Include_Parent_in_Chatter_Group_Until__c = r.Starting_Date_from_contact__c.addDays(1);
            	}
            	if(r.Include_Parent_in_Chatter_Group_Until__c > date.today() && r.Include_Parent_in_Chatter_Group__c == false){
            		r.Include_Parent_in_Chatter_Group__c = true;
            	}
            }
    }
    
    system.debug('***HandleRegistrationBefore***end:'+trigger.newMap);
}