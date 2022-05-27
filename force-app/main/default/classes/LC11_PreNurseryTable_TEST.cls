@isTest
public with sharing class LC11_PreNurseryTable_TEST {
	    @isTest
	static void LC11_PreNurseryTable_TEST() {

            School__c sch= new School__c();
            sch.SchoolCode__c='NDB';
        
        insert sch;
		Opportunity opp = new Opportunity();
        
		opp.Name='text';
		opp.TECH_EarlyYMonAM__c=false;
		opp.TECH_EarlyYMonPM__c=false;
		opp.TECH_EarlyYTuesAM__c=false;
		opp.TECH_EarlyYTuesPM__c=false;
		opp.TECH_EarlyYWedAM__c=false;
		opp.TECH_EarlyYWedPM__c=false;
		opp.TECH_EarlyYThurAM__c=false;
		opp.TECH_EarlyYThurPM__c=false;
		opp.TECH_EarlyYFriAM__c=false;
		opp.TECH_EarlyYFriPM__c=false;
		opp.TECH_EarlyYSunAM__c=true;
		opp.TECH_EarlyYSunPM__c=true;
		opp.SchoolOfInterest__c=sch.id;
        opp.StageName='Visit';
        opp.CloseDate=date.today().addMonths(2);
        

        Opportunity opp1 = new Opportunity ();
        opp1.Name='text1';
        opp1.TECH_EarlyYMonAM__c=false;
		opp1.TECH_EarlyYMonPM__c=false;
		opp1.TECH_EarlyYTuesAM__c=false;
		opp1.TECH_EarlyYTuesPM__c=false;
		opp1.TECH_EarlyYWedAM__c=false;
		opp1.TECH_EarlyYWedPM__c=false;
		opp1.TECH_EarlyYThurAM__c=false;
		opp1.TECH_EarlyYThurPM__c=false;
		opp1.TECH_EarlyYFriAM__c=false;
		opp1.TECH_EarlyYFriPM__c=false;
		opp1.TECH_EarlyYSunAM__c=true;
		opp1.TECH_EarlyYSunPM__c=true;
		opp1.SchoolOfInterest__c=sch.id;
        opp1.StageName='acceptance';
        opp1.CloseDate=date.today().addMonths(2);
        
		list<Opportunity> lstopp = new list<Opportunity>();
		list <Opportunity> lstopp1= new list<Opportunity>();
		lstopp.add(opp);

		if(lstopp.size()>0){
			insert lstopp;
		}
		opp.TECH_EarlyYSunPM__c =true;

		LC11_PreNurseryTable.saveDetails(opp);

		Opportunity op =[select id,Name from Opportunity where name='text'];
		LC11_PreNurseryTable.saveDetails(opp1);

	LC11_PreNurseryTable.saveDetails(opp);
           lstopp1.add(LC11_PreNurseryTable.getDetails(opp.Id));
           lstopp1.add(LC11_PreNurseryTable.getDetails(op.Id));
           system.debug('lstopp1' + lstopp1);
	}
}