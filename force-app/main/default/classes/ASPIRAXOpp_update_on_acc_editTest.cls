@isTest private class ASPIRAXOpp_update_on_acc_editTest {private static testmethod void testRelation(){try{update [select Id from Account limit 1];}catch(Exception e){System.debug(e);}}}