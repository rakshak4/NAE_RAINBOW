/**
 * @File Name          : TestFactory.cls
 * @Description        : 
 * @Author             : FKH
 * @Group              : 
 * @Last Modified By   : FKH
 * @Last Modified On   : 22/10/2021, 14:10:42
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    04/07/2019, 14:04:07   CRA     Initial Version
 * 1.1    02/03/2021, 10:00:00   VJA     Added EmailMessage Create Method
 * 1.2    22/10/2021, 10:00:00   FKH     Added Contract Create Method

**/
@isTest
public class TestFactory {  
/**************************************************************************************
-- - Author        : Spoon consulting
-- - Description   : Class to factorise creation of data in test classes
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 19-JAN-2017  RRAJ    1.0      Initial version  
-- 09-JUL-2017  WCH     1.1      function to create family account
-- 16-JUL-2018  RAC     1.2      Function to create application document
-- 18-JUL-2018  RAC     1.3      Function to create document checklist
-- 18-JUL-2018  AMU     1.4      Function to create enrolment period, year group, school program
--------------------------------------------------------------------------------------
**************************************************************************************/ 
    //get for system administrator profile id
    public static Id getProfileAdminId(){
        return ([Select Id From Profile 
                Where name = 'Administrateur système' 
                    OR name = 'System Administrator'
                    OR name = 'Amministratore del sistema'
                    OR name = 'Systemadministrator'
                    OR name = 'Systemadministratör'
                    OR name = 'Administrador do sistema'
                    OR name = 'Systeembeheerder'
                    OR name = 'Systemadministrator'].Id);
    }
    
    //get random unique string 
    public static String randomizeString(String name){
        if(String.isNotBlank(name)){
            String charsForRandom = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
            String randStr = '';
            while (randStr.length() < 6) {
               Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), charsForRandom.length());
               randStr += charsForRandom.substring(idx, idx+1);
            }
            return name+randStr;
        }
        return null;
    }
    
    //create user
    public static User createUser(String name, Id profId){
        return new User(
            Username = randomizeString(name) +'@test.com',
            LastName = 'Ballack',
            FirstName = 'Jean',
            Email = 'Jean@test.com',
            Alias = 'JBAL',
            LanguageLocaleKey = 'en_US',
            TimeZoneSidKey = 'Europe/Paris',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = profId
        );
    }

    //create account
    public static Account createAccount(String name){
        return new Account(
            Name = name
        );
    }
    //create family account
    public static Account createFamilyAccount(String name){
        return new Account(
            Name = name,
            RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get(AP_Constant.accNatureOfRelationshipFamily).getRecordTypeId()
        );
    }

    //create contact
    public static Contact createContact(String name, String accId, String recordtypeId){
        return new Contact(
            LastName = name,
            AccountId = accId,
            RecordTypeId = recordtypeId,
            Nationality__c = 'Afghani',
            Nationality2__c= 'Afghani'
        );
    }

    //create opportunity
    public static Opportunity createOpportunity(String name, String accId, String stage, String recordId, String SchoolOfInterestId){
        return new Opportunity(
            Name = name,
            AccountId = accId,
            StageName = stage,
            CloseDate = Date.newInstance(2010, 12, 22),
            RecordTypeId = recordId,
            SchoolOfInterest__c = SchoolOfInterestId
        );
    }
    
    //method to create lead
    public static Lead createLead(Id recTypeId, String lastName, String firstName, String firstChildFirstName, String firstChildLastName, 
                                    String firstChildGender, Date firstChildDoB){
        return new Lead(
            FirstName = firstName,
            LastName = lastName,
            Parent1FirstName__c = firstName,
            Parent1LastName__c = lastName,
            Parent1Nationality__c='Australian',
            Parent1NatureOfRelationship__c = AP_Constant.ledNatureOfRelationshipFather,
            Parent1HomePhone__c = '+852 9999-9999',
            Parent1PrimaryEmail__c = lastName+'@mail.com',
            Parent1CountryOfResidence__c = 'France',
            //RecordTypeId = recTypeId,
            Number_of_Children__c = '1',
            
            FirstNameFirstChild__c = firstChildFirstName,
            LastNameFirstChild__c = firstChildLastName,
            GenderFirstChild__c = firstChildGender,
            DateOfBirthFirstChild__c = firstChildDoB,
            EnrollmentDateFirstChild__c = Date.newInstance(2019, 2, 2)
        );
    }

    //public static Lead createLeadWithParentChild(Id recTypeId, String lastName, String firstName, Id schoolId){
    //    return new Lead(
    //        FirstName = randomizeString(lastName),
    //        LastName = randomizeString(lastName),
    //        //RecordTypeId = recTypeId,
    //        Email = randomizeString(lastName) + '@mail.com',
    //        SchoolOfInterest__c = schoolId,
    //        //parent details
    //        Parent1FirstName__c = randomizeString('test'),
    //        Parent1LastName__c = randomizeString('Parent 1'),
    //        //Parent1NatureOfRelationship__c = AP_Constant.ledNatureOfRelationshipFather,
    //        //Parent1MobilePhone__c = '2345433433',
    //        //Parent2FirstName__c = randomizeString('test'),
    //        //Parent2LastName__c = randomizeString('Parent 2'),
    //        //Parent2NatureOfRelationship__c = AP_Constant.ledNatureOfRelationshipMother,
    //        //Parent2MobilePhone__c = '2342498643',
    //        //child details
    //        FirstNameFirstChild__c = randomizeString('firstChildFirstName'),
    //        LastNameFirstChild__c = randomizeString('firstChildLastName'),
    //        GenderFirstChild__c = AP_Constant.ledGenderMale,
    //        DateOfBirthFirstChild__c = Date.newInstance(2010, 2, 3),
    //        FirstNameSecondChild__c = randomizeString('secondChildFirstName'),
    //        LastNameSecondChild__c = randomizeString('secondChildLastName'),
    //        GenderSecondChild__c = AP_Constant.ledGenderFemale,
    //        DateOfBirthSecondChild__c = Date.newInstance(2012, 7, 5),
    //        FirstNameThirdChild__c = randomizeString('thirdChildFirstName'),
    //        LastNameThirdChild__c = randomizeString('thirdChildLastName'),
    //        GenderThirdChild__c = AP_Constant.ledGenderMale,
    //        DateOfBirthThirdChild__c = Date.newInstance(2010, 6, 21),
    //        FirstNameFourthChild__c = randomizeString('fourthChildFirstName'),
    //        LastNameFourthChild__c = randomizeString('fourthChildLastName'),
    //        GenderFourthChild__c = AP_Constant.ledGenderFemale,
    //        DateOfBirthFourthChild__c = Date.newInstance(2014, 10, 8),
    //        FirstNameFifthChild__c = randomizeString('fifthChildFirstName'),
    //        LastNameFifthChild__c = randomizeString('fifthChildLastName'),
    //        GenderFifthChild__c = AP_Constant.ledGenderMale,
    //        DateOfBirthFifthChild__c = Date.newInstance(2013, 6, 10)
    //        /*,
    //        FirstNameSixthChild__c = randomizeString('sixthChildFirstName'),
    //        LastNameSixthChild__c = randomizeString('sixthChildLastName'),
    //        GenderSixthChild__c = AP_Constant.ledGenderFemale,
    //        DateOfBirthSixthChild__c = Date.newInstance(2015, 1, 30)*/
    //    );
    //}

    //method to create school
    public static School__c createSchool(String name, String address, Boolean isNae, String schoolCode ){
        return new School__c(
            Name = name,
            Address__c = address,
            IsNAESchool__c = isNae,
            SchoolCode__c = schoolCode,
            BedrockSchool__c = true,
            OptInAutomatedTask__c = true,
            OptInLeadFollowUp__c = true
        );
    }

    //create year grade
    public static YearGrade__c createYearGrade(String name, String schoolId, Integer minAge, Integer maxAge, String enrolmntId){
        return new YearGrade__c(
            Name = name,
            SchoolName__c = schoolId,
            MinimumAge__c = minAge,
            MaximumAge__c = maxAge,
            EnrolmentPeriod__c = enrolmntId,
            NCYear__c = 1
        );
    }

    //create enrolment period
    public static EnrolmentPeriod__c createEnrolmentPeriod(String name, String schoolId, String schoolYearCode, Date startDate, Date endDate){
        return new EnrolmentPeriod__c(
            Name = name
            ,SchoolName__c = schoolId
            ,SchoolYearCode__c  = schoolYearCode
            ,StartDate__c = startDate
            ,EndDate__c = endDate
            ,Active__c = true
        );
    }

    //create class
    public static Class__c createClass(String name, Integer capacity, String yearGradeId, String schoolId){
        return new Class__c(
            Name = name
            ,Capacity__c = capacity
            ,YearGrade__c = yearGradeId
            ,MaleCount__c = 0
            ,FemaleCount__c = 0
            ,SchoolName__c = schoolId
        );
    }

    //create Contract
    public static Contract createContract(Id accId, Date StartDate, Integer ContractTerm, String region){
        return new Contract(
            AccountId = accid
            ,StartDate = StartDate
            ,ContractTerm = ContractTerm
            ,region__c = region
        );
    }

    //create mailchimp
    public static Mailchimp__c createMailChimp(String schoolId, String apiKey, String listId, String groupId){
        return new Mailchimp__c(
            ApiKey__c = apiKey,
            EnquiryGroupId__c = groupId,
            School__c = schoolId,
            ListId__c = listId
        );
    }

    //create application document
    public static ApplicationDocument__c createApplicationDoc(String name, String schoolId, Boolean required, String stage) {
        return new ApplicationDocument__c(
            Name = name,
            School__c = schoolId,
            Required__c = required == null ? false : required,
            Stage__c = stage == null ? 'Application' : stage 
        );
    }

    //create document checklist
    public static DocumentChecklist__c createDocChecklist(String name, String opportunityId, String appDocId) {
        return new DocumentChecklist__c(
            Name = name,
            Opportunity__c = opportunityId,
            ApplicationDocument__c = appDocId
        );
    }
    
    //create event
    public static Event createEvent(String subject, Integer duration, Datetime activityDate) {
        return new Event(
            Subject = subject,
            DurationInMinutes = duration,
            ActivityDateTime = activityDate
        );
    }
    
    //create task
    public static Task createTask(String subject) {
        return new Task(
            Subject = subject
        );
    }

    //create content 
    public static ContentVersion createContentVersion(String title) {
        return new ContentVersion(
            Title = title,
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
    }

    //create contentodocumentlink
    public static ContentDocumentLink createContentDocumentLink(String linkedId, String cntDocId) {
        return new ContentDocumentLink(
            LinkedEntityId=linkedId,
            ShareType= 'V',        
            ContentDocumentId=cntDocId,
            Visibility = 'AllUsers'
        );
    }

    //create EmailMessage //VJA20210302
    public static EmailMessage createEmailMessage(String strSubject, String strBody){
        return new EmailMessage(
            Status = '3',
            Subject = strSubject,
            htmlbody = strBody,
            fromAddress = 'naeFrom@example.com',
            toAddress = 'naeTo@example.com'
        );
    }

        //create class
        public static ClassCapacity__c createClassCapacity(String name, Integer totalCapacity, String classId, Date endDate, Date startDate){
            return new ClassCapacity__c(
                Name = name
                ,CapacityTotal__c = totalCapacity
                ,Class__c = classId
                ,EndDate__c = endDate
                ,StartDate__c = startDate
            );
        }

}