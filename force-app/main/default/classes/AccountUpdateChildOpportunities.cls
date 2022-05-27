public class AccountUpdateChildOpportunities{
	/*
    public static void UpdatePayerField(List<Account> oldAccs, List<Account> newAccs){

        Map<String, Account> accsForUpdate = new Map<String, Account>();
        for (Integer i = 0; i < oldAccs.size(); i++){
            if (oldAccs[i].F_Info_Company_Name__c != newAccs[i].F_Info_Company_Name__c){
                accsForUpdate.put(newAccs[i].Id, newAccs[i]);
            }
        }
        Set<String> accIds = accsForUpdate.keySet();
        List<Opportunity> oppsForUpdate = [Select Id, AccountId, Payer__c
                                             From Opportunity
                                             Where AccountId IN :accIds];
        
        for (Opportunity o : oppsForUpdate){
        	o.Payer__c = accsForUpdate.get(o.AccountId).F_Info_Company_Name__c;   
        }
        
        List<Database.SaveResult> results = Database.update(oppsForUpdate,false);
        
    }
    
    @isTest
        public static void testUpdatePayerField(){
           
            Account parent =  new Account();
			parent.FirstName =  'First Name';
			parent.LastName =  'Last Name';
			parent.PersonEmail = 'test@test.com';
			parent.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='PersonAccount'].Id;
			insert parent;
            
            //create company account account
			Account company =  new Account();
			company.Name =  'Company Account';
			company.RecordTypeId = [Select Id from RecordType where SObjectType='Account' AND DeveloperName='Company_Account'].Id;
			insert company;  
		
		
            
            Opportunity student = new Opportunity(Name = 'Student',
                                                  Payer__c = company.Id,
                                                  AccountId = parent.Id,
                                                  Year_Group__c='Y3',
                                                  StageName = 'A/ Testing', 
                                                  CloseDate = Date.Today(), 
                                                  Student_Name__c = 'Student');
                
            insert student;
            student.StageName = 'Enrolled';
            update student;
            
            parent.F_Info_Company_Name__c = company.Id;
            update parent;
            
            System.assertEquals(company.Id, [Select Payer__c from Opportunity Where Id = :student.Id].Payer__c);
                
        }
    
    */
}