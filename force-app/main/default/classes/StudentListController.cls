public with sharing class StudentListController {
    public list<Contact> studentList {get;set;}
    public StudentListController(ApexPages.StandardController controller) {
        studentList =  new list<Contact>();
        //fetch student academic file
        for(Contact c:[Select  c.Stage__c, c.Student_Name__c, c.Nickname__c, c.Class_Name__c, House__c, Student_Email_Formula__c, c.Main_Parent_File__c, c.Id, c.Email From Contact c where Main_Parent_File__c =:controller.getId() AND RecordType.DeveloperName='Student' order by c.Student_Name__c]){
            studentList.add(c);
        }
    }

}