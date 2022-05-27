@isTest
private class TestWebContent{
    //test delete validations
    static testMethod void testWebContentDeletion(){
        Group_Website__c gw = new Group_Website__c(Name='Test',Order__c =1 );
        gw.RecordTypeId = [select Id from RecordType where SObjectType = 'Group_Website__c' AND DeveloperName = 'Home_Page_2'].Id;
        insert gw;
        //create web content
        Web_Content__c wc = new Web_Content__c();
        wc.RecordTypeId = [select Id from RecordType where SObjectType = 'Web_Content__c' AND DeveloperName = 'Home_Page_Picture_Carrousel'].Id;
        wc.Name = 'Test';
        wc.Order__c  = 1;
        wc.Parent_Item__c = gw.Id;
        wc.Section_1_Main_Text_English__c = 'Test';
        insert wc;
        
        //create available under web content 
        Web_Content__c wc1 = new Web_Content__c();
        wc1.Language__c = 'EN';
        wc1.RecordTypeId = [select Id from RecordType where SObjectType = 'Web_Content__c' AND DeveloperName = 'Groupable'].Id;
        wc1.Name = 'wc1';
        wc1.Order__c = 55;
        wc1.Section_1_Main_Text_English__c = 'Test';
        wc1.Parent_Item__c = gw.Id;
        insert wc1;
        //create web content translation
        Web_Content__c wc2 = new Web_Content__c();
        wc2.RecordTypeId = [select Id from RecordType where SObjectType = 'Web_Content__c' AND DeveloperName = 'Home_Page_Picture_Carousel_Translation'].Id;
        wc2.Name = 'Test';
        wc2.Order__c  = 1;
        wc2.Language__c = 'ES';
        wc2.Assigned_Translator__c = 'Emma Watkins (Spanish 2)';
        //wc2.Parent_Item__c = gw.Id;
        wc2.Section_1_Main_Text_English__c = 'Test';
        //wc2.Available_Under_Web_Content__c = wc1.Id;
        wc2.English_Parent__c = wc.Id;
        //wc2.Internal_Link__c = wc.Id;
        //wc2.Related_to_Web_Content__c = wc.Id;        
        insert wc2;
        
        Test.startTest();
            try{
                delete wc;
            }catch(Exception e){
                
            }
        Test.stopTest();
        
    }
    
    static testMethod void testNewsEventDeletion(){
        News_Events__c newsEvent = new News_Events__c();
        newsEvent.RecordTypeId = [select Id from RecordType where SObjectType='News_Events__c' AND DeveloperName='Event'].Id;
        newsEvent.Name = 'Test Event';
        
        newsEvent.Event_Start_Date__c = date.today();
        //newsEvent.Publish_in_Portal_School_Hub__c = true;
        //newsEvent.Post_Entry_in_Related_Blog__c = 'Yes - And tag as Essential Communication'; 
        newsEvent.Subtitle__c = 'Teaser Text';          
        insert newsEvent;
        
        News_Events__c newsEventChild = new News_Events__c();
        newsEventChild.RecordTypeId = [select Id from RecordType where SObjectType='News_Events__c' AND DeveloperName='Event_Translation'].Id;
        newsEventChild.Name = 'Test Event';
        
        newsEventChild.Event_Start_Date__c = date.today();
        //newsEvent.Publish_in_Portal_School_Hub__c = true;
        //newsEventChild.Post_Entry_in_Related_Blog__c = 'Yes - And tag as Essential Communication'; 
        newsEventChild.Subtitle__c = 'Teaser Text';    
        newsEventChild.English_Parent__c =   newsEvent.Id;  
        newsEventChild.Language__c = 'ES';
        //newsEventChild.Assigned_Translator__c = 'Emma Watkins (Spanish 2)';
        insert newsEventChild;  
        Test.startTest();
            try{
                delete newsEvent;
            }catch(Exception e){
                
            }
        Test.stopTest();
            
    }
}