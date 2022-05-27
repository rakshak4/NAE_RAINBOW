/**
 * Tests for SelectDefaultPricebookTest.
 * 
 * @author Logan (Trineo)
 * @date September 2013
 */
@isTest
private class SelectDefaultPricebookTest {
    
    @isTest(SeeAllData=True) static void testPositive() {
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
        //fi.Company_Name__c = companyAccount.Id;
        insert fi;
        

        // Insert a new student
        Opportunity student = new Opportunity(
            Name = 'Test Student', 
            Gender__c = 'Male',
            StageName = 'A/ Testing', 
            Year_Group__c = 'Y1', 
            CloseDate = System.today().addDays(10), 
            Student_Name__c = 'Morgan', 
            AccountId = parentAccount.Id
        );
        insert student;

        // Assert that the pricebook has been set correctly
        student = [Select Id, Price_Book_to_Allocate__c, Pricebook2.Name From Opportunity Where Id =: student.Id];
        System.assertEquals(student.Price_Book_to_Allocate__c, student.Pricebook2.Name, 'Expected Pricebook to match Price_Book_to_Allocate__c after student created');
    }
}