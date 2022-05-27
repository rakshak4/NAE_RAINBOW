@isTest
public class BAT03_DeleteDuplicateRecordSet_TEST {
 static List<User> lstUser;
    static List<Account> lstAcc;
    static List<Lead> lstLead;
    static List<Contact> lstContact;
    static Map<String, Id> mapRecordType = AP_Constant.getDeveloperIdMap(new Set<String>{AP_Constant.ledObject, AP_Constant.conObject});

    static{  
        System.debug('mapRecordType: ' + mapRecordType);    

        lstUser = new List<User>{TestFactory.createUser('Test', TestFactory.getProfileAdminId())};
        insert lstUser;

        System.runAs(lstUser[0]){
            lstAcc = new List<Account>{
                TestFactory.createAccount('testAcc')
                ,TestFactory.createAccount('testAcc')
            };

            insert lstAcc;

            lstContact = new List<Contact>{
                TestFactory.createContact('TestAccount', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild)),
                    TestFactory.createContact('TestAccount', lstAcc[0].Id, mapRecordType.get(AP_Constant.conRecordTypeChild))
                    };
            insert lstContact;                        
            
            Lead ld= new Lead(RecordTypeId =mapRecordType.get(AP_Constant.ledRecordTypeEnrolment) , LastName = 'Test', FirstName='Tester', phone= '234324', email = 'sdf@sd.s');
            insert ld;
          
        }
    }
    
    @isTest public static void test1(){

        System.runAs(lstUser[0]) {
            DuplicateRule dR = [select id from DuplicateRule where DeveloperName = 'CustomAccountDuplicateRule' LIMIT 1];
            DuplicateRecordSet dupRS = new DuplicateRecordSet(DuplicateRuleId = dR.id);
            insert dupRS;

            Account acc = new Account(name = 'TestAccount', phone='9898787878');
            Database.DMLOptions insertDML = new Database.DMLOptions(); 
            insertDML.DuplicateRuleHeader.AllowSave = true; 
            Database.SaveResult sr = Database.insert(acc, insertDML);
            DuplicateRecordItem dup = new DuplicateRecordItem(DuplicateRecordSetId = dupRS.id, RecordId=acc.id);
            insert dup;

            test.StartTest();  
            BAT03_DeleteDuplicateRecordSet batchObj = new BAT03_DeleteDuplicateRecordSet();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
            
           List<Account> lstAccountUpdated = [SELECT Id, Name FROM Account WHERE Name ='TestAccount' ];
           //System.assertEquals(1, lstAccountUpdated.size());
            
        }
    }

    @isTest public static void test2(){

        System.runAs(lstUser[0]) {
            DuplicateRule dR = [select id from DuplicateRule where DeveloperName = 'CustomChildContactDuplicateRule' LIMIT 1];
            DuplicateRecordSet dupRS = new DuplicateRecordSet(DuplicateRuleId = dR.id);
            insert dupRS;

            Contact con = new Contact(LastName = 'TestAccount', AccountId = lstAcc[0].Id, RecordTypeId= mapRecordType.get(AP_Constant.conRecordTypeChild));
            Database.DMLOptions insertDML = new Database.DMLOptions(); 
            insertDML.DuplicateRuleHeader.AllowSave = true; 
            Database.SaveResult sr = Database.insert(con, insertDML);
            DuplicateRecordItem dup = new DuplicateRecordItem(DuplicateRecordSetId = dupRS.id, RecordId=con.id);
            insert dup;

            test.StartTest();  
            BAT03_DeleteDuplicateRecordSet batchObj = new BAT03_DeleteDuplicateRecordSet();
            Database.executeBatch(batchObj , 200);
            test.StopTest();
           
            List<Contact> lstContactUpdated = [SELECT Id, Name FROM Contact WHERE Name ='TestAccount'];
            //System.assertEquals(1, lstContactUpdated.size());  
            
        }
    }
    @isTest public static void test3(){

        System.runAs(lstUser[0]) {
            DuplicateRule dR = [select id from DuplicateRule where DeveloperName = 'CustomLeadDuplicateRule' LIMIT 1];
            DuplicateRecordSet dupRS = new DuplicateRecordSet(DuplicateRuleId = dR.id);
            insert dupRS;

            Lead ld= new Lead(RecordTypeId =mapRecordType.get(AP_Constant.ledRecordTypeEnrolment) , LastName = 'Test', FirstName='Tester', phone= '234324', email = 'sdf@sd.s');
        
            Database.DMLOptions insertDML = new Database.DMLOptions(); 
            insertDML.DuplicateRuleHeader.AllowSave = true; 
            Database.SaveResult sr = Database.insert(ld, insertDML);
            DuplicateRecordItem dup = new DuplicateRecordItem(DuplicateRecordSetId = dupRS.id, RecordId= ld.id);
            insert dup;

            test.StartTest();  
                BAT03_DeleteDuplicateRecordSet batchObj = new BAT03_DeleteDuplicateRecordSet();
                Database.executeBatch(batchObj , 200);
            test.StopTest();

            List<Lead> lstLeadUpdated = [SELECT Id, LastName FROM Lead WHERE email = 'sdf@sd.s'];
            //System.assertEquals(1, lstLeadUpdated.size());
            
        }
    }
}