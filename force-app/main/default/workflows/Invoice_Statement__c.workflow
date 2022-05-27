<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_of_Failure_to_send_invoice_to_Xero_Misc_Error</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>Notify of Failure to send invoice to Xero (Misc. Error)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Failed_to_Send_Invoice_to_Xero_Misc_Error</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_Failure_to_send_invoice_to_Xero_Same_Name_Target_Contact</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>Notify of Failure to send invoice to Xero (Same Name Target Contact)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Failed_to_Send_Invoice_to_Xero_Same_Name_Target_Contact</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_Failure_to_send_invoice_to_Xero_Target_Contact_Archived</fullName>
        <description>Notify of Failure to send invoice to Xero (Target Contact Archived)</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Failed_to_Send_Invoice_to_Xero_Target_Contact_Archived</template>
    </alerts>
    <fieldUpdates>
        <fullName>Copy_Act_Date</fullName>
        <field>Act_Date__c</field>
        <formula>IF( Contains_Yearly_Fee__c &gt;0, Xero_Key__r.Act_Date_Yearly__c , Xero_Key__r.Act_Date_Yearly__c )</formula>
        <name>Copy Act Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Appendix_Number</fullName>
        <description>Copies Appendix number from the Account to fix it in the invoice</description>
        <field>Appendix_Number_Copy__c</field>
        <formula>Payer__r.Appendix_Number__c+1</formula>
        <name>Copy Appendix Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Bank_Details</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>Bank_Details__c</field>
        <formula>Bank_Details_Formula__c</formula>
        <name>Copy Bank Details</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Bank_Details_Local_Language</fullName>
        <field>Bank_Details_Local_Language__c</field>
        <formula>Bank_Details_Local_Language_Formula__c</formula>
        <name>Copy Bank Details Local Language</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Exchange_Rate</fullName>
        <description>Copies Exchange Rate from Contract Setup</description>
        <field>Exchange_Rate_Copy__c</field>
        <formula>Xero_Key__r.Exchange_Rate__c</formula>
        <name>Copy Exchange Rate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Exchange_Rate_Date2</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>Exchange_Rate_Date_Copy__c</field>
        <formula>Xero_Key__r.Exchange_Rate_Date__c</formula>
        <name>Copy Exchange Rate Date2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Legal_Address</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>Legal_Address__c</field>
        <formula>Legal_Address_Formula__c</formula>
        <name>Copy Legal Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Legal_Address_Local_Language</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>Legal_Address_Local_Language__c</field>
        <formula>Legal_Address_Local_Language_Formula__c</formula>
        <name>Copy Legal Address Local Language</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Location_Address</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>Location_Address__c</field>
        <formula>Location_Address_Formula__c</formula>
        <name>Copy Location Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Location_Address_Local_Language</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>Location_Address_Local_Language__c</field>
        <formula>Location_Address_Local_Language_Formula__c</formula>
        <name>Copy Location Address Local Language</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Long_Reference_to_Short_Reference</fullName>
        <field>Reference_Short__c</field>
        <formula>LEFT(Reference__c, 255)</formula>
        <name>Copy Long Reference to Short Reference</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_School_Company_Name</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>School_Company_Name__c</field>
        <formula>School_Company_Name_Formula__c</formula>
        <name>Copy School Company Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_School_Company_Name_Local_Language</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>School_Company_Name_Local_Language__c</field>
        <formula>School_Company_Name_Local_Language_Formu__c</formula>
        <name>Copy School Company Name Local Language</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_School_Company_Name_Local_Short</fullName>
        <field>School_Company_Name_Local_Language_Short__c</field>
        <formula>IF( TEXT(Payer__r.School_Company__c)=&quot;A002&quot;, Xero_Key__r.Company_2_Short_Name_Local_Language__c ,Xero_Key__r.Company_1_Short_Name_Local_Language__c)</formula>
        <name>Copy School Company Name Local Short</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_School_Company_Name_Short</fullName>
        <field>School_Company_Name_Short__c</field>
        <formula>IF( TEXT(Payer__r.School_Company__c)=&quot;A002&quot;, Xero_Key__r.Company_2_Short_Name__c ,Xero_Key__r.Company_1_Short_Name__c)</formula>
        <name>Copy School Company Name Short</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_School_Legal_Rep</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>School_Legal_Rep__c</field>
        <formula>School_Legal_Rep_Formula__c</formula>
        <name>Copy School Legal Rep</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_School_Legal_Rep_Local_Language</fullName>
        <description>Used to Ensure the Field &quot;Sticks&quot; even if details are changed in Contract Setup</description>
        <field>School_Legal_Rep_Local_Language__c</field>
        <formula>School_Legal_Rep_Local_Language_Formula__c</formula>
        <name>Copy School Legal Rep Local Language</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Restore_Voided_Deleted_Invoice</fullName>
        <field>Voided_Deleted__c</field>
        <name>Restore Voided/Deleted Invoice</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_BST_Invoice_School</fullName>
        <field>School__c</field>
        <formula>&quot;Tashkent&quot;</formula>
        <name>Update BST Invoice School</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_BSY_Invoice_School_to_Default</fullName>
        <field>School__c</field>
        <formula>&quot;Yangon&quot;</formula>
        <name>Update BSY Invoice School to Default</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Invoice_Due_Date_Brazil</fullName>
        <description>Updates the invoice due date to coincide with the school&apos;s own policy, which differs from the group policy.</description>
        <field>Generated_Date__c</field>
        <formula>IF(
   AND(
       DAY(Invoice_Date__c)=15, 
       MONTH(Invoice_Date__c)=03
       ), 
   DATE(YEAR(Invoice_Date__c),02,25),
   IF(
      AND(
          DAY(Invoice_Date__c)=15, 
          MONTH(Invoice_Date__c)=12
          ), 
      DATE(YEAR(Invoice_Date__c),11,25),
      IF(
         AND(
             DAY(Invoice_Date__c)=01, 
             MONTH(Invoice_Date__c)=08, 
             OR(
                DAY(DATEVALUE(CreatedDate))=24, 
                DAY(DATEVALUE(CreatedDate))=25
                )
             ), 
         DATE(YEAR(Invoice_Date__c),06,25),
         IF(
            AND(
                DAY(Invoice_Date__c)=01, 
                MONTH(Invoice_Date__c)=08, 
                OR(
                   DAY(DATEVALUE(CreatedDate))=09, 
                   DAY(DATEVALUE(CreatedDate))=10
                   )
                ), 
            DATE(YEAR(Invoice_Date__c),05,25),
            DATE(YEAR(DATEVALUE(CreatedDate)), MONTH(DATEVALUE(CreatedDate)), 25)
            )
         )
      )
   )</formula>
        <name>Update Invoice Due Date (Brazil)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Invoice_Due_Date_New_York</fullName>
        <field>Generated_Date__c</field>
        <formula>IF(
   AND(
       DAY(Invoice_Date__c)=01, 
       MONTH(Invoice_Date__c)=08
       ), 
   DATE(YEAR(Invoice_Date__c),04,01), 
   IF(
      AND(
          DAY(Invoice_Date__c)=15, 
          MONTH(Invoice_Date__c)=12
          ), 
      DATE(YEAR(Invoice_Date__c),08,01),
      IF(
         AND(
             DAY(Invoice_Date__c)=15, 
             MONTH(Invoice_Date__c)=03
             ), 
         DATE(YEAR(Invoice_Date__c)-1,12,01),
         Generated_Date__c
         )
      )
   )</formula>
        <name>Update Invoice Due Date (New York)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Invoice_to_Deleted</fullName>
        <field>Voided_Deleted__c</field>
        <literalValue>Deleted</literalValue>
        <name>Update Invoice to Deleted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Invoice_to_Voided</fullName>
        <field>Voided_Deleted__c</field>
        <literalValue>Voided</literalValue>
        <name>Update Invoice to Voided</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_NAISM_Invoice_School</fullName>
        <field>School__c</field>
        <formula>&quot;Manila&quot;</formula>
        <name>Update NAISM Invoice School</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Terms_Covered</fullName>
        <field>Terms_Covered__c</field>
        <formula>Terms_Covered_Formula__c</formula>
        <name>Update Terms Covered</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Terms_Covered_Local_Language</fullName>
        <field>Terms_Covered_Local_Language__c</field>
        <formula>IF( OR( Payer__r.School__c  =&quot;The International School of Moscow&quot;,Payer__r.School__c=&quot;The British School of Tashkent&quot;),Terms_Covered_Russian__c &amp; Terms_Covered_Russian_Yearly_Fees__c,&quot;&quot;)</formula>
        <name>Update Terms Covered Local Language</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Copy Contract Setup</fullName>
        <actions>
            <name>Copy_Bank_Details</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Bank_Details_Local_Language</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_School_Company_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_School_Company_Name_Local_Language</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_School_Company_Name_Local_Short</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_School_Company_Name_Short</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_School_Legal_Rep</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_School_Legal_Rep_Local_Language</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Terms_Covered</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Terms_Covered_Local_Language</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Copies Relevant dates from Xero Keys to fix them at the date of creation</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Copy Contract Setup 2</fullName>
        <actions>
            <name>Copy_Act_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Appendix_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Exchange_Rate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Exchange_Rate_Date2</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Legal_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Legal_Address_Local_Language</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Location_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Location_Address_Local_Language</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Copies Relevant dates from Xero Keys to fix them at the date of creation</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Copy Long Reference to Short Reference Field</fullName>
        <actions>
            <name>Copy_Long_Reference_to_Short_Reference</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Failed to Send Invoice to Xero %28Misc%2E Error%29</fullName>
        <actions>
            <name>Notify_of_Failure_to_send_invoice_to_Xero_Misc_Error</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(     ISCHANGED(Error_Message__c),      Error_Message__c != &quot;&quot;,      OR(        NOT(CONTAINS(Error_Message__c, &quot;The existing contact with name&quot;)),         NOT(CONTAINS(Error_Message__c, &quot;cannot be updated to use new name&quot;)),        NOT(CONTAINS(Error_Message__c, &quot;There is an existing contact with that name.&quot;))        ),     Error_Message__c != &quot;The contact with the specified contact details has been archived. The contact must be un-archived before creating new invoices or credit notes.&quot;     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Invoice is Deleted</fullName>
        <actions>
            <name>Update_Invoice_to_Deleted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.Xero_Invoice_Status__c</field>
            <operation>equals</operation>
            <value>Deleted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Invoice is Restored</fullName>
        <actions>
            <name>Restore_Voided_Deleted_Invoice</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(Xero_Invoice_Status__c != &quot;Voided&quot;, Xero_Invoice_Status__c != &quot;Deleted&quot;, OR(TEXT(Voided_Deleted__c) = &quot;Voided&quot;, TEXT(Voided_Deleted__c) = &quot;Deleted&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Invoice is Voided</fullName>
        <actions>
            <name>Update_Invoice_to_Voided</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.Xero_Invoice_Status__c</field>
            <operation>equals</operation>
            <value>Voided</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify of Archived Xero Contact</fullName>
        <actions>
            <name>Notify_of_Failure_to_send_invoice_to_Xero_Target_Contact_Archived</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.Error_Message__c</field>
            <operation>equals</operation>
            <value>The contact with the specified contact details has been archived. The contact must be un-archived before creating new invoices or credit notes.</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify of Same Name Xero Contact</fullName>
        <actions>
            <name>Notify_of_Failure_to_send_invoice_to_Xero_Same_Name_Target_Contact</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.Error_Message__c</field>
            <operation>contains</operation>
            <value>The existing contact with name</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.Error_Message__c</field>
            <operation>contains</operation>
            <value>cannot be updated to use new name</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.Error_Message__c</field>
            <operation>contains</operation>
            <value>There is an existing contact with that name.</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update BST Invoice School</fullName>
        <actions>
            <name>Update_BST_Invoice_School</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.Invoice_Date__c</field>
            <operation>lessThan</operation>
            <value>8/1/2016</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.School__c</field>
            <operation>equals</operation>
            <value>Tashkent A</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.Xero_Id__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update BSY Invoice School</fullName>
        <actions>
            <name>Update_BSY_Invoice_School_to_Default</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.Xero_Id__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.School__c</field>
            <operation>equals</operation>
            <value>Yangon BL</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.Error_Message__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Invoice Due Date %28Brazil%29</fullName>
        <actions>
            <name>Update_Invoice_Due_Date_Brazil</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND (2 OR 3) AND 4)</booleanFilter>
        <criteriaItems>
            <field>Invoice_Statement__c.Xero_Id__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.School__c</field>
            <operation>equals</operation>
            <value>Sao Paulo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.School__c</field>
            <operation>equals</operation>
            <value>Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.Single_Invoice__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Updates the invoice due dates on create so that they adhere to the school&apos;s invoicing policy, which is different from the group&apos;s invoice policy. Only applies to invoices created automatically via fee assignments (not single invoices)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Invoice Due Date %28New York%29</fullName>
        <actions>
            <name>Update_Invoice_Due_Date_New_York</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Invoice_Statement__c.Xero_Id__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.School__c</field>
            <operation>equals</operation>
            <value>New York</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.Single_Invoice__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Updates the invoice due dates on create so that they adhere to the school&apos;s invoicing policy, which is different from the group&apos;s invoice policy. Only applies to invoices created automatically via fee assignments (not single invoices)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update NAISM Invoice School</fullName>
        <actions>
            <name>Update_NAISM_Invoice_School</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice_Statement__c.Invoice_Date__c</field>
            <operation>lessThan</operation>
            <value>8/1/2018</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.School__c</field>
            <operation>equals</operation>
            <value>Manila A</value>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice_Statement__c.Xero_Id__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
