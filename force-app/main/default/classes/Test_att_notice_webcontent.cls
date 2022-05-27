@isTest
private class Test_att_notice_webcontent  {
        
        static testMethod void myUnitTest() {
            test.starttest();
            
            Group_Website__c parent =new Group_Website__c();
            parent.Name = 'test parent';
            parent.Order__c =  10;
            insert parent;
            
            Web_Content__c objWeb_Content=new Web_Content__c(Name='test child');
            objWeb_Content.Parent_Item__c=parent.Id;
            objWeb_Content.Content_Subtitle__c = 'title';
            objWeb_Content.Order__c =10;
            insert objWeb_Content;
            list<Attachment> listAttachment = new list<Attachment>();
            
            Attachment attach=new Attachment();    
            attach.Name='Unit Test Attachment';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            attach.body=bodyBlob;
            attach.parentId=parent.id;
            listAttachment.add(attach);
            
            Attachment attach1=new Attachment();    
            attach1.Name='Unit Test Attachment1';
            Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
            attach1.body=bodyBlob1;
            attach1.parentId=parent.id;
            listAttachment.add(attach1);
            
            insert listAttachment;
            
            test.stoptest();
            
            list<Group_Website__c> parentList =[Select id,Attachment_Id__c from Group_Website__c  where id=:parent.Id];
            //system.assert(parentList.get(0).Attachment_Id__c <> null);
        }
        
        static testMethod void myUnitTest_delete() {
            test.starttest();
            
            Group_Website__c parent =new Group_Website__c();
            parent.Name = 'test parent';
            parent.Order__c =  10;
            insert parent;
            
            Web_Content__c objWeb_Content=new Web_Content__c(Name='test child');
            objWeb_Content.Parent_Item__c=parent.Id;
            objWeb_Content.Content_Subtitle__c = 'title';
            objWeb_Content.Order__c =10;
            insert objWeb_Content;
            list<Attachment> listAttachment = new list<Attachment>();
            
            Attachment attach=new Attachment();    
            attach.Name='Unit Test Attachment';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            attach.body=bodyBlob;
            attach.parentId=parent.id;
            listAttachment.add(attach);
            
            Attachment attach1=new Attachment();    
            attach1.Name='Unit Test Attachment1';
            Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
            attach1.body=bodyBlob1;
            attach1.parentId=parent.id;
            listAttachment.add(attach1);
            
            insert listAttachment;
            delete listAttachment;
            test.stoptest();
            
            list<Group_Website__c> parentList =[Select id,Deleted_Attachment_Id__c from Group_Website__c  where id=:parent.Id];
            //system.assert(parentList.get(0).Deleted_Attachment_Id__c <> null);
        }
        
}