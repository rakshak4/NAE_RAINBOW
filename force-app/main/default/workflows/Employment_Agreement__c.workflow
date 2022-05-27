<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>BSKL_Holidays_exceeded_allowance_notice</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Holidays exceeded allowance notice</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>BSKL_s_Email_Templates/BSKL_Holidays_exceeded_Allowance_Notice</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Sick_Days_exceeded_allowance_notice</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Sick Days exceeded allowance notice</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>BSKL_s_Email_Templates/BSKL_Sick_Leave_exceeded_Allowance_Notice</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_reminder_about_contract_expiry_date</fullName>
        <ccEmails>ruslan.pryadun@britishschool.uz</ccEmails>
        <description>BST Email reminder about contract expiry date</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Contract_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Abacare_Dependent</fullName>
        <ccEmails>corporatebj@abacare.com</ccEmails>
        <description>Email to Abacare (Dependent)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Add_to_Insurance_Plan_Dependent</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Abacare_Employee</fullName>
        <ccEmails>corporatebj@abacare.com</ccEmails>
        <description>Email to Abacare (Employee)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Add_to_Insurance_Plan_Employee</template>
    </alerts>
    <alerts>
        <fullName>Emp_Agr_Email_First_Approver_on_Approval_Rejection</fullName>
        <description>Emp/Agr - Email First Approver on Approval/Rejection</description>
        <protected>false</protected>
        <recipients>
            <field>First_Approver__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Reply_to_Contract_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Emp_Agr_Email_Initial_Submitter_on_Approval_Rejection</fullName>
        <description>Emp/Agr - Email Initial Submitter on Approval/Rejection</description>
        <protected>false</protected>
        <recipients>
            <field>Initial_Submitter__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Reply_to_Contract_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Emp_Agr_Email_Initial_Submitter_on_Approval_Rejection_BSNJ</fullName>
        <description>Emp/Agr - Email Initial Submitter on Approval/Rejection (BSNJ)</description>
        <protected>false</protected>
        <recipients>
            <field>Initial_Submitter__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Reply_to_Contract_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Emp_Agr_Email_Second_Approver_on_Approval</fullName>
        <description>Emp/Agr - Email Second Approver on Approval</description>
        <protected>false</protected>
        <recipients>
            <field>Second_Approver__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Inform_Second_Approver_about_First_Approval</template>
    </alerts>
    <alerts>
        <fullName>Emp_Agr_Recall_Notification_to_First_Approver</fullName>
        <description>Emp/Agr - Recall Notification to First Approver</description>
        <protected>false</protected>
        <recipients>
            <field>First_Approver__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Recall_Contract_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Emp_Agr_S1_Email_Initial_Submitter_on_Approval_Rejection</fullName>
        <description>Emp/Agr S1 - Email Initial Submitter on Approval/Rejection</description>
        <protected>false</protected>
        <recipients>
            <field>Initial_Submitter__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Reply_to_Contract_Approval_Request_Stage_1</template>
    </alerts>
    <alerts>
        <fullName>Emp_Agr_S2_Email_Initial_Submitter_on_Approval_Rejection</fullName>
        <description>Emp/Agr S2 - Email Initial Submitter on Approval/Rejection</description>
        <protected>false</protected>
        <recipients>
            <field>Initial_Submitter__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Reply_to_Contract_Approval_Request_Stage_2</template>
    </alerts>
    <fieldUpdates>
        <fullName>Additional_Clause_Empty</fullName>
        <description>Add the words &quot;None&quot; if the additional clause field is left empty</description>
        <field>Additional_Clause_s__c</field>
        <formula>IF(TEXT(Staff_Member__r.School_Controlling_Picklist__c)=&quot;The British Schools Foundation&quot;, &quot;&quot;, &quot;None&quot;)</formula>
        <name>Additional Clause Empty</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Changed_from_On_to_Off_in_Triggered</fullName>
        <field>Trigger__c</field>
        <name>Changed from On to Off in Triggered</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copies_Termination_Date_to_End_Date</fullName>
        <field>End_Date__c</field>
        <formula>Termination_Date__c</formula>
        <name>Copies Termination Date to End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Resulting_Bonus</fullName>
        <field>Copy_Resulting_Bonus_Seperator__c</field>
        <formula>Perfomance_Bonus_Achieved__c</formula>
        <name>Copy Resulting Bonus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Delete_Early_Termination_Date</fullName>
        <description>Deletes Early Termination Date</description>
        <field>Termination_Date__c</field>
        <name>Delete Early Termination Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Emp_Agr_Status_to_Draft</fullName>
        <description>Change the status of an employment agreement to draft</description>
        <field>Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Emp/Agr - Status to Draft</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Erases_Signed_Date_if_contract_not_appro</fullName>
        <field>Signed_Agreed_Date__c</field>
        <name>Erases Signed Date if contract not appro</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Contract_Text_Additional_Clause</fullName>
        <field>Contract_Text_Additional_Clauses__c</field>
        <formula>Additional_Clause_s__c</formula>
        <name>Populate Contract Text Additional Clause</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_First_Approver_Email_Address</fullName>
        <field>First_Approver__c</field>
        <formula>CASE( 
Staff_Member__r.Company_School__c, 
&quot;The British International School of Kuala Lumpur&quot;, &quot;emma.cleary@britishschool.edu.my&quot;, 
&quot;The International School of Moscow&quot;, &quot;maria.ezhova@internationalschool.ru&quot;, 
&quot;The British College of Brazil&quot;, &quot;renata.capelucci@britishcollegebrazil.org&quot;,  
&quot;Nord Anglia International School Manila&quot;, &quot;david.kirkham@kings.org.ph&quot;, 
&quot;The British School of Nanjing&quot;, &quot;matthew.shephard@bsn.org.cn&quot;, 
&quot;The British School of Tashkent&quot;, &quot;adrian.macaulay@britishschool.uz&quot;, 
&quot;The British School Yangon&quot;, &quot;adam.johnson@britishschoolyangon.org&quot;, 
&quot;nae.migration@britishschools.co.uk&quot; 
)</formula>
        <name>Populate First Approver Email Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Initial_Submitter_Email_Address</fullName>
        <field>Initial_Submitter__c</field>
        <formula>$User.Email</formula>
        <name>Populate Initial Submitter Email Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Second_Approver_Email_Address</fullName>
        <field>Second_Approver__c</field>
        <formula>CASE( 
Staff_Member__r.Company_School__c, 
&quot;The British International School of Marbella&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;The British School of Navarra&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;The British International School of Kuala Lumpur&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;The International School of Moscow&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;The British College of Brazil&quot;, &quot;nae.migration@britishcollegebrazil.org&quot;, 
&quot;The British School of Brasilia&quot;, &quot;headteacher@britishschoolbrasilia.org&quot;, 
&quot;The King&apos;s School Manila&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;The British School of Nanjing&quot;, &quot;desmond.lee@britishschools.co.uk&quot;, 
&quot;The British School of Tashkent&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;The British School Yangon&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;Ukraine International School&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;The New York International School&quot;, &quot;nae.migration@britishschools.co.uk&quot;, 
&quot;nae.migration@britishschools.co.uk&quot; 
)</formula>
        <name>Populate Second Approver Email Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Health_Insurance_Amount</fullName>
        <field>Cost_of_Health_Insurance__c</field>
        <formula>IF(Health_Insurance_Currency__c = Secondary_Currency_Code__c,  Cost_of_Health_Insurance_New__c / Exchange_Rate__c, Cost_of_Health_Insurance_New__c)</formula>
        <name>Populate/Sync EA Health Insurance Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Housing_Amount</fullName>
        <field>Cost_of_Housing__c</field>
        <formula>IF(Housing_Currency__c = Secondary_Currency_Code__c,  Cost_of_Housing_New__c / Exchange_Rate__c, Cost_of_Housing_New__c)</formula>
        <name>Populate/Sync EA Housing Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Other_Benefits_Amount</fullName>
        <field>Cost_of_Other_Benefits__c</field>
        <formula>IF(Other_Benefits_Currency__c = Secondary_Currency_Code__c,  Cost_of_Other_Benefits_New__c / Exchange_Rate__c, Cost_of_Other_Benefits_New__c)</formula>
        <name>Populate/Sync EA Other Benefits Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Perf_Bonus_Amount</fullName>
        <field>Performance_Bonus__c</field>
        <formula>IF(Performance_Bonus_Currency__c = Secondary_Currency_Code__c, Performance_Bonus_New__c / Exchange_Rate__c, Performance_Bonus_New__c)</formula>
        <name>Populate/Sync EA Perf. Bonus Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Probation_Salary_Amount</fullName>
        <field>Monthly_Salary_During_Probation__c</field>
        <formula>IF(Salary_Currency__c = Secondary_Currency_Code__c,  Monthly_Salary_During_Probation_New__c / Exchange_Rate__c, Monthly_Salary_During_Probation_New__c)</formula>
        <name>Populate/Sync EA Probation Salary Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Reloc_Allowance_Amount</fullName>
        <field>Cost_of_Relocation__c</field>
        <formula>IF(Relocation_Allowance_Currency__c = Secondary_Currency_Code__c, Cost_of_Relocation_New__c / Exchange_Rate__c, Cost_of_Relocation_New__c)</formula>
        <name>Populate/Sync EA Reloc. Allowance Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Retention_Bonus_Amount</fullName>
        <field>Retention_Bonus__c</field>
        <formula>IF(Retention_Bonus_Currency__c = Secondary_Currency_Code__c, Retention_Bonus_New__c / Exchange_Rate__c, Retention_Bonus_New__c)</formula>
        <name>Populate/Sync EA Retention Bonus Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Salary_Amount</fullName>
        <field>Salary__c</field>
        <formula>IF(Salary_Currency__c = Secondary_Currency_Code__c, Salary_New__c / Exchange_Rate__c, Salary_New__c)</formula>
        <name>Populate/Sync EA Salary Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Taxes_Paid_Amount</fullName>
        <field>Taxes_Paid_by_School__c</field>
        <formula>IF(Taxes_Paid_by_School_Currency__c = Secondary_Currency_Code__c, Taxes_Paid_by_School_New__c / Exchange_Rate__c, Taxes_Paid_by_School_New__c)</formula>
        <name>Populate/Sync EA Taxes Paid Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Travel_Allowance_Amount</fullName>
        <field>Cost_of_Travel_Allowance__c</field>
        <formula>IF(Travel_Allowance_Currency__c = Secondary_Currency_Code__c,  Cost_of_Travel_Allowance_New__c / Exchange_Rate__c, Cost_of_Travel_Allowance_New__c)</formula>
        <name>Populate/Sync EA Travel Allowance Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Sync_EA_Visa_Costs_Amount</fullName>
        <field>Visa_Costs_Amount__c</field>
        <formula>IF(Visa_Costs_Currency__c = Secondary_Currency_Code__c,  Visa_Costs_Amount_New__c / Exchange_Rate__c, Visa_Costs_Amount_New__c)</formula>
        <name>Populate/Sync EA Visa Costs Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type_Unlocked_Snr</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Employment_Agreement_UNLOCKED_PRIVATE</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type Unlocked (Snr)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type_Unlocked_Std</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Employee_Agreement_UNLOCKED</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type Unlocked (Std)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Retrigger_to_On</fullName>
        <description>Rule created to re-trigger time dependent workflows, even if the record is edited.</description>
        <field>Trigger__c</field>
        <literalValue>On</literalValue>
        <name>Retrigger to On</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Default_Exchange_Rate_1</fullName>
        <description>EUR, BRL, CNY, GBP, MMK, MYR</description>
        <field>Exchange_Rate__c</field>
        <formula>IF(TEXT(CurrencyIsoCode) = &quot;EUR&quot;, 
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 4.37766,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 7.95584,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.88937,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 1697.76,
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 4.74084,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 61.8501,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 73.3811,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 1.16626,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 9095.61, 1
      ))))))))),

IF(TEXT(CurrencyIsoCode) = &quot;BRL&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 0.22841,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 1.81757,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.20308,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 387.798,
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 1.08280,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 14.1292,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 16.7712,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 0.26638,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 2076.82, 1
      ))))))))),

IF(TEXT(CurrencyIsoCode) = &quot;CNY&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 0.12566,
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 0.55012,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.11172,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 213.378,
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 0.59582,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 7.77369,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 9.23408,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 0.14658,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 1142.91, 1
      ))))))))),

IF(TEXT(CurrencyIsoCode) = &quot;GBP&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 1.12460,
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 4.92254,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 8.94890,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 1909.72,
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 5.33269,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 69.5685,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 82.6551,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 1.31190,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 10228.68, 1
      ))))))))),

IF(TEXT(CurrencyIsoCode) = &quot;MMK&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 0.000588,
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 0.002578,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 0.004685,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.000524,
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 0.002792,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 0.036422,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 0.043310,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 0.000687,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 5.355340, 1
      ))))))))),

IF(TEXT(CurrencyIsoCode) = &quot;MYR&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 0.21094,
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 0.92318,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 1.67862,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.18759,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 358.108,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 13.0448,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 15.5086,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 0.24598,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 1917.65, 1
      ))))))))),

   1))))))</formula>
        <name>Set Default Exchange Rate 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Default_Exchange_Rate_2</fullName>
        <description>PHP, RUB, USD, UZS</description>
        <field>Exchange_Rate__c</field>
        <formula>IF(TEXT(CurrencyIsoCode) = &quot;PHP&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 0.0161,
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 0.0707,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 0.1286,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.01437,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 27.4527, 
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 0.0766,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 1.1858,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 0.0189,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 147.083, 1
      ))))))))),

IF(TEXT(CurrencyIsoCode) = &quot;RUB&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 0.0136,
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 0.0597,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 0.1084,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.0121,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 23.1547, 
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 0.0646,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 0.8434,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 0.0159,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 123.982, 1
      ))))))))),

IF(TEXT(CurrencyIsoCode) = &quot;USD&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 0.8572,
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 3.7523,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 6.8201,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.7622,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 1455.8200, 
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 4.0651,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 53.0310,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 62.8770,
   IF(Secondary_Currency_Code__c = &quot;UZS&quot;, 7793.2100, 1
      ))))))))),

IF(TEXT(CurrencyIsoCode) = &quot;UZS&quot;, 
   IF(Secondary_Currency_Code__c = &quot;EUR&quot;, 0.000110,
   IF(Secondary_Currency_Code__c = &quot;BRL&quot;, 0.000481,
   IF(Secondary_Currency_Code__c = &quot;CNY&quot;, 0.000875,
   IF(Secondary_Currency_Code__c = &quot;GBP&quot;, 0.000098,
   IF(Secondary_Currency_Code__c = &quot;MMK&quot;, 0.186722, 
   IF(Secondary_Currency_Code__c = &quot;MYR&quot;, 0.000521,
   IF(Secondary_Currency_Code__c = &quot;PHP&quot;, 0.006801,
   IF(Secondary_Currency_Code__c = &quot;RUB&quot;, 0.008068,
   IF(Secondary_Currency_Code__c = &quot;USD&quot;, 0.000128, 1
      ))))))))),
   
   1))))</formula>
        <name>Set Default Exchange Rate 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Exchange_Rate_to_Blank</fullName>
        <field>Exchange_Rate__c</field>
        <formula>null</formula>
        <name>Set Exchange Rate to Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Trigger_Edit_of_Related_Account</fullName>
        <field>Edit_Staff_Member_on_EA_Update__c</field>
        <formula>IF(OR(Staff_Member__r.Edit_Staff_Member_on_EA_Update__c = &quot;&quot;, Staff_Member__r.Edit_Staff_Member_on_EA_Update__c = &quot;FALSE&quot;), &quot;TRUE&quot;, &quot;FALSE&quot;)</formula>
        <name>Trigger Edit of Related Account</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Staff_Member__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Trigger_to_Off</fullName>
        <description>Rule created to re-trigger time dependent workflows, even if the record is edited.</description>
        <field>Trigger__c</field>
        <literalValue>Off</literalValue>
        <name>Trigger to Off</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Approvals_to_Field_to_Approved</fullName>
        <field>Approvals__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Approvals to Field to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_to_Locked_Snr</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Employment_Agreement_LOCKED_PRIVATE</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record Type to Locked (Snr)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_to_Locked_Std</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Employee_Agreement_LOCKED</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record Type to Locked (Std)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Early_Termination</fullName>
        <field>Status__c</field>
        <literalValue>Expired</literalValue>
        <name>Update Status Early Termination</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Approved_Not_Signed</fullName>
        <field>Status__c</field>
        <literalValue>Approved-Not Signed</literalValue>
        <name>Update to Approved- Not Signed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Approval_Stage_to_Signed</fullName>
        <field>Approvals__c</field>
        <literalValue>Signed</literalValue>
        <name>Updates Approval Stage to Signed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Approval_to_Submitted</fullName>
        <field>Approvals__c</field>
        <literalValue>Submitted</literalValue>
        <name>Updates Approval to Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Status_to_Active</fullName>
        <field>Status__c</field>
        <literalValue>Active</literalValue>
        <name>Updates Status to Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Status_to_Approved_Not_Signed</fullName>
        <field>Status__c</field>
        <literalValue>Approved-Not Signed</literalValue>
        <name>Updates Status to Approved- Not Signed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Status_to_Draft</fullName>
        <field>Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Updates Status to Draft</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Status_to_Expired</fullName>
        <field>Status__c</field>
        <literalValue>Expired</literalValue>
        <name>Updates Status to Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Status_to_Signed_Not_Started</fullName>
        <field>Status__c</field>
        <literalValue>Signed- Not Started</literalValue>
        <name>Updates Status to Signed- Not Started</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_to_Awaiting_Approval</fullName>
        <field>Status__c</field>
        <literalValue>Awaiting Approval</literalValue>
        <name>Updates to Awaiting Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Add to Insurance Plan %28Dependent%29</fullName>
        <actions>
            <name>Email_to_Abacare_Dependent</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Signed- Not Started,Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Health_Insurance__c</field>
            <operation>equals</operation>
            <value>International</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Children_Health_Insurance__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends an email to Abacare to add a Dependent to the plan</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Add to Insurance Plan %28Employee%29</fullName>
        <actions>
            <name>Email_to_Abacare_Employee</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Signed- Not Started,Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Health_Insurance__c</field>
            <operation>equals</operation>
            <value>International</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Sends an email to Abacare to add an Employee to the plan</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Exceeded Holidays Allowance</fullName>
        <actions>
            <name>BSKL_Holidays_exceeded_allowance_notice</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send an email when the Holidays allowance is exceeded</description>
        <formula>AND ( Staff_Member__r.School__c  = &quot;The British International School of Kuala Lumpur&quot;,  TEXT (Status__c) = &quot;Active&quot;,  TEXT(Holidays_Admin_Support_Staff__c) &lt;&gt; &quot;&quot;,  Holidays_Taken__c &gt;= Holidays_Admin_Support_Staff__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Exceeded Sick Leaves Allowance</fullName>
        <actions>
            <name>BSKL_Sick_Days_exceeded_allowance_notice</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send an email when the Sick Days allowance is exceeded</description>
        <formula>AND ( Staff_Member__r.School__c  = &quot;The British International School of Kuala Lumpur&quot;,  TEXT (Status__c) = &quot;Active&quot;,  Sick_Leave_Taken__c &gt;= Sick_Days__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BST Checks Contract expiration date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Termination_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Type__c</field>
            <operation>equals</operation>
            <value>Contract</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.End_Date_Text__c</field>
            <operation>notContain</operation>
            <value>14/08</value>
        </criteriaItems>
        <description>Sends an email 1 month before the contact expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BST_Email_reminder_about_contract_expiry_date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.End_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Additional Clause Empty</fullName>
        <actions>
            <name>Additional_Clause_Empty</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Additional_Clause_s__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Includes the word &quot;None&quot; or leaves the field blank if the additional clause field is left empty</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Copy Resulting Bonus</fullName>
        <actions>
            <name>Copy_Resulting_Bonus</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Perfomance_Bonus_Achieved__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Press Signed Not Approved</fullName>
        <actions>
            <name>Erases_Signed_Date_if_contract_not_appro</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Approvals__c</field>
            <operation>notEqual</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Approvals__c</field>
            <operation>notEqual</operation>
            <value>Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Signed_Agreed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Re-Trigger 1</fullName>
        <actions>
            <name>Retrigger_to_On</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Rule created to re-trigger time dependent workflows, even if the record is edited.</description>
        <formula>ISCHANGED( LastModifiedDate )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Re-Trigger 2</fullName>
        <actions>
            <name>Trigger_to_Off</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Trigger__c</field>
            <operation>equals</operation>
            <value>On</value>
        </criteriaItems>
        <description>Rule created to re-trigger time dependent workflows, even if the record is edited.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Record Type back to unlocked %28Snr%29</fullName>
        <actions>
            <name>Record_Type_Unlocked_Snr</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Employment_Agreement__c.Approvals__c</field>
            <operation>equals</operation>
            <value>Not Submitted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Employment Agreement LOCKED PRIVATE</value>
        </criteriaItems>
        <description>Changes the record back to unlocked if the approval stage is switched back to &quot;Not Submitted&quot; for senior/private employee records</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Record Type back to unlocked %28Std%29</fullName>
        <actions>
            <name>Record_Type_Unlocked_Std</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Employment_Agreement__c.Approvals__c</field>
            <operation>equals</operation>
            <value>Not Submitted</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Employee Agreement LOCKED</value>
        </criteriaItems>
        <description>Changes the record back to unlocked if the approval stage is switched back to &quot;Not Submitted&quot; for standard employee records</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Restores Status to Active</fullName>
        <actions>
            <name>Updates_Status_to_Active</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Expired</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Termination_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.End_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.End_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Restores the status of a contract to active after the Early Termination Date is deleted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Employment_Agreement__c.End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Update Status if Signed Date is deleted</fullName>
        <actions>
            <name>Delete_Early_Termination_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Approvals_to_Field_to_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Updates_Status_to_Approved_Not_Signed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3 OR 4) AND 5</booleanFilter>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Signed- Not Started</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Expired</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Early Termination</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Signed_Agreed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Changes the status to Approved not Signed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Update Status to Active from Signed-Not Started</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Signed- Not Started</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Updates_Status_to_Active</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.Start_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Approval Stage to Signed</fullName>
        <actions>
            <name>Updates_Approval_Stage_to_Signed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Signed_Agreed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Status Early Termination</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Termination_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Changes the Status of a contract if a date is introduced in the Early Termination Date Field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Copies_Termination_Date_to_End_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Updates_Status_to_Expired</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.Termination_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Status introduce End Date</fullName>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3) AND 4</booleanFilter>
        <criteriaItems>
            <field>Employment_Agreement__c.Signed_Agreed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Signed- Not Started</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Updates_Status_to_Expired</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Updates_Status_to_Active</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.Start_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Status to Approved- Not Signed</fullName>
        <actions>
            <name>Updates_Status_to_Approved_Not_Signed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Approvals__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Status to Awaiting Approval</fullName>
        <actions>
            <name>Updates_to_Awaiting_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Approvals__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Status to Draft</fullName>
        <actions>
            <name>Updates_Status_to_Draft</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Approvals__c</field>
            <operation>equals</operation>
            <value>Not Submitted</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Status to expired from Active</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Signed_Agreed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Updates_Status_to_Expired</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Status with End Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Signed_Agreed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved-Not Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Updates_Status_to_Expired</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Updates_Status_to_Active</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.Start_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Status without End Date</fullName>
        <actions>
            <name>Updates_Status_to_Signed_Not_Started</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 4) AND 3</booleanFilter>
        <criteriaItems>
            <field>Employment_Agreement__c.Signed_Agreed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved-Not Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.End_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Status__c</field>
            <operation>equals</operation>
            <value>Expired</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Updates_Status_to_Active</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employment_Agreement__c.Start_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Emp%2FAgr - Updates Trigger from Off to On</fullName>
        <actions>
            <name>Changed_from_On_to_Off_in_Triggered</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(  Date_Edited__c  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr Populate Default Exchange Rate 1</fullName>
        <actions>
            <name>Set_Default_Exchange_Rate_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>EUR, BRL, CNY, GBP, MMK, MYR</description>
        <formula>OR(    AND(        ISBLANK(Exchange_Rate__c),         TEXT(Secondary_Currency__c) &lt;&gt; &quot;&quot;,        OR(TEXT(CurrencyIsoCode) = &quot;EUR&quot;,           TEXT(CurrencyIsoCode) = &quot;BRL&quot;,           TEXT(CurrencyIsoCode) = &quot;CNY&quot;,           TEXT(CurrencyIsoCode) = &quot;GBP&quot;,           TEXT(CurrencyIsoCode) = &quot;MMK&quot;,           TEXT(CurrencyIsoCode) = &quot;MYR&quot;           )        ),    AND(        OR(           ISCHANGED(Secondary_Currency__c),            ISCHANGED(CurrencyIsoCode)           ),        NOT(ISCHANGED(Exchange_Rate__c)),        TEXT(Secondary_Currency__c) &lt;&gt; &quot;&quot;,        OR(TEXT(CurrencyIsoCode) = &quot;EUR&quot;,           TEXT(CurrencyIsoCode) = &quot;BRL&quot;,           TEXT(CurrencyIsoCode) = &quot;CNY&quot;,           TEXT(CurrencyIsoCode) = &quot;GBP&quot;,           TEXT(CurrencyIsoCode) = &quot;MMK&quot;,           TEXT(CurrencyIsoCode) = &quot;MYR&quot;           )        )    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emp%2FAgr Populate Default Exchange Rate 2</fullName>
        <actions>
            <name>Set_Default_Exchange_Rate_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>PHP, RUB, USD, UZS</description>
        <formula>OR(     AND(         ISBLANK(Exchange_Rate__c),         TEXT(Secondary_Currency__c) &lt;&gt; &quot;&quot;,         OR(TEXT(CurrencyIsoCode) = &quot;PHP&quot;,            TEXT(CurrencyIsoCode) = &quot;RUB&quot;,            TEXT(CurrencyIsoCode) = &quot;USD&quot;,            TEXT(CurrencyIsoCode) = &quot;UZS&quot;             )         ),     AND(         OR(            ISCHANGED(Secondary_Currency__c),            ISCHANGED(CurrencyIsoCode)            ),            NOT(ISCHANGED(Exchange_Rate__c)),            TEXT(Secondary_Currency__c) &lt;&gt; &quot;&quot;,            OR(TEXT(CurrencyIsoCode) = &quot;PHP&quot;,               TEXT(CurrencyIsoCode) = &quot;RUB&quot;,               TEXT(CurrencyIsoCode) = &quot;USD&quot;,               TEXT(CurrencyIsoCode) = &quot;UZS&quot;               )         )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Contract Text Additional Clauses</fullName>
        <actions>
            <name>Populate_Contract_Text_Additional_Clause</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Additional_Clause_s__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Additional_Clause_s__c</field>
            <operation>notEqual</operation>
            <value>None</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate%2FSync EA Component Amounts for Reporting 1</fullName>
        <actions>
            <name>Populate_Sync_EA_Health_Insurance_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Housing_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Other_Benefits_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Perf_Bonus_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Reloc_Allowance_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Retention_Bonus_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Salary_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Taxes_Paid_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Travel_Allowance_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Sync_EA_Visa_Costs_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Populates the original (pre-Feb 2015) employment agreement CURRENCY amount fields with the amount from the newly created NUMBER amount fields, applying an exchange rate multiplier, if required</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate%2FSync EA Component Amounts for Reporting 2</fullName>
        <actions>
            <name>Populate_Sync_EA_Probation_Salary_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Populates the original (pre-Feb 2015) employment agreement CURRENCY amount fields with the amount from the newly created NUMBER amount fields, applying an exchange rate multiplier, if required</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Exchange Rate to Blank if No Secondary Currency</fullName>
        <actions>
            <name>Set_Exchange_Rate_to_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Secondary_Currency__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employment_Agreement__c.Exchange_Rate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Staff Member Edit on EA Status Update</fullName>
        <actions>
            <name>Trigger_Edit_of_Related_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Required to trigger an edit to the related staff member record when the &apos;Status&apos; of an employment agreement is updated so that the a-sync job on account can update the relevant &apos;Status&apos; in the staff directory which can define website visibility</description>
        <formula>ISCHANGED(Status__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
