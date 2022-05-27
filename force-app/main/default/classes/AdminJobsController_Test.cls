/********

Developed By : Vedi Technologies (Ashutosh)
Date         : Aug 6, 2018
Description  : To cover AdminJobsController class.
 
********/

@isTest
private class AdminJobsController_Test
{
    
    static testMethod void AdminJobsControllerTest1()
    {
        //setup
        String substitStr = '*****';
        String badword = 'foozle';
        
        Blacklisted_Word__c blw = new Blacklisted_Word__c();
        blw.Word__c = badword;
        blw.Match_Whole_Words_Only__c = true;
        blw.Prevent_Post_on_Breach__c = false;
        blw.Substitution__c = substitStr;
        insert blw;
        
        Blacklisted_Word__c blw2 = new Blacklisted_Word__c();
        blw2.Word__c = badword;
        blw2.Match_Whole_Words_Only__c = true;
        blw2.Prevent_Post_on_Breach__c = false;
        blw2.Substitution__c = substitStr;
        blw2.Custom_Expression__c = 'test';
        insert blw2;
        
        Test.StartTest();
        
        AdminJobsController cont = new AdminJobsController();
        cont.generateInvoices();
        cont.sendToXero();
        
        Test.StopTest();
        
    }
    /*
    static testMethod void AdminJobsControllerTest2()
    {
        //setup
        String substitStr = '*****';
        String badword = 'foozle';
        
        Blacklisted_Word__c blw = new Blacklisted_Word__c();
        blw.Word__c = badword;
        blw.Match_Whole_Words_Only__c = true;
        blw.Prevent_Post_on_Breach__c = false;
        blw.Substitution__c = substitStr;
        insert blw;
        
        Blacklisted_Word__c blw2 = new Blacklisted_Word__c();
        blw2.Word__c = badword;
        blw2.Match_Whole_Words_Only__c = true;
        blw2.Prevent_Post_on_Breach__c = false;
        blw2.Substitution__c = substitStr;
        blw2.Custom_Expression__c = 'test2';
        insert blw2;
        
        Test.StartTest();
        
        AdminJobsController cont = new AdminJobsController();
        //cont.generateInvoices();
        cont.sendToXero();
        
        Test.StopTest();
        
    }*/
}