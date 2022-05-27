<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Adjust_Calculated_Discount</fullName>
        <field>Unit_Price__c</field>
        <formula>ROUND(Unit_Price__c + ((VALUE(LEFT(Description__c, FIND(&quot;%&quot;, Description__c)-1))/100)*232),0)</formula>
        <name>Adjust Calculated Discount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Apply_Discount_to_Unit_Price</fullName>
        <field>Unit_Price__c</field>
        <formula>Unit_Price__c - 232</formula>
        <name>Apply Discount to Unit Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Company_Tracking_Category_to_C002</fullName>
        <field>Tracking_1__c</field>
        <formula>&quot;C002&quot;</formula>
        <name>Change Company Tracking Category to C002</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Invoice_Date</fullName>
        <field>Invoice_Date_Text_from_statement__c</field>
        <formula>Invoice_Statement__r.Invoice_Date__c</formula>
        <name>Copy Invoice Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Xero_Invoice_Status</fullName>
        <field>Xero_Invoice_Status_from_statement_text__c</field>
        <formula>Invoice_Statement__r.Xero_Invoice_Status__c</formula>
        <name>Copy Xero Invoice Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Audit_Value</fullName>
        <field>Audit_Value_Text_Terms__c</field>
        <formula>IF(
   AND(
       OR(
          TEXT(Student__r.Manually_Audited_To_Date__c)=&quot;&quot;, 
          Student__r.Manually_Audited_To_Date__c &lt;= Invoice_Statement__r.First_Date_of_Relevant_Term__c
          ), 
       Invoice_Statement__r.First_Date_of_Relevant_Term__c &gt;= Student__r.Auto_Audit_Start_Date_Copy__c, 
       Invoice_Statement__r.Xero_Invoice_Status__c != &quot;Voided&quot;, 
       Invoice_Statement__r.Xero_Invoice_Status__c != &quot;Deleted&quot;, 
       Invoice_Statement__r.Xero_Invoice_Status__c != &quot;ERROR&quot;
       ),
    IF(
       AND(
           Unit_Price__c &gt;= 0, 
           CONTAINS(Description__c , &quot;Yearly&quot;)
           ), 
       3, 
       IF(
          AND(
              Unit_Price__c &gt;= 0, 
              CONTAINS(Description__c , &quot;Termly&quot;)
              ),
          1,
          IF(
             AND(
                 Unit_Price__c &gt;= 0, 
                 CONTAINS(Description__c , &quot;Monthly&quot;),  
                 School__c = &quot;The British College of Brazil&quot;,  
                 MONTH(Student__r.CloseDate)=MONTH(Invoice_Statement__r.Invoice_Date__c),    
                 YEAR(Student__r.CloseDate)=YEAR(Invoice_Statement__r.Invoice_Date__c)
                 ), 
             Audit_Value_Terms_From_Months__c + CASE(MONTH(Student__r.CloseDate), 2, 1/3, 3, 2/3, 5, 0.25, 6, 0.5, 7, 0.75, 9, 0.2, 10, 0.4, 11, 0.6, 12, 0.8, 0),
             IF(
                AND(
                    Unit_Price__c &gt;= 0, 
                    CONTAINS(Description__c , &quot;Monthly&quot;), 
                    School__c != &quot;The British College of Brazil&quot;, 
                    MONTH(Student__r.CloseDate)=MONTH(Invoice_Statement__r.Invoice_Date__c), 
                    YEAR(Student__r.CloseDate)=YEAR(Invoice_Statement__r.Invoice_Date__c)
                    ), 
                Audit_Value_Terms_From_Months__c + CASE(MONTH(Student__r.CloseDate), 2, 1/3, 3, 2/3, 5, 1/3, 6, 2/3, 10, 0.25, 11, 0.50, 12, 0.75, 0),
                IF(
                   AND(
                       Unit_Price__c &gt;= 0, 
                       CONTAINS(Description__c , &quot;Monthly&quot;), 
                       School__c = &quot;The British College of Brazil&quot;
                       ), 
                   Audit_Value_Terms_From_Months__c,
                   IF(
                      AND(
                          Unit_Price__c &gt;= 0, 
                          CONTAINS(Description__c , &quot;Monthly&quot;), 
                          School__c != &quot;The British College of Brazil&quot;
                          ),
                      Audit_Value_Terms_From_Months__c,
                      0
                      )
                   )
                )
             )
          )
       ),
      0
   )</formula>
        <name>Generate Audit Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NYIS_Change_Description_to_Financial_Aid</fullName>
        <field>Description__c</field>
        <formula>IF(
   CONTAINS(Description__c, &quot;Termly&quot;),
   &quot;Termly Financial Aid Deduction&quot;,
   IF(
      CONTAINS(Description__c, &quot;Yearly&quot;),
      &quot;Yearly Financial Aid Deduction&quot;,
      &quot;&quot;
      )
   )</formula>
        <name>NYIS Change Description to Financial Aid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Fee_Description</fullName>
        <field>Description__c</field>
        <formula>Description__c &amp; &quot; [Founding Parent]&quot;</formula>
        <name>Update Fee Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Is_Campus_1_Student_to_TRUE</fullName>
        <field>Is_Campus_1_Student_Copy__c</field>
        <literalValue>1</literalValue>
        <name>Update Is Campus 1 Student to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Is_Campus_2_Student_to_TRUE</fullName>
        <field>Is_Campus_2_Student_Copy__c</field>
        <literalValue>1</literalValue>
        <name>Update Is Campus 2 Student to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Copy Audit Formula Values to Text Fields</fullName>
        <actions>
            <name>Copy_Invoice_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Xero_Invoice_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Generate_Audit_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Line_Item__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Copies the calculated values from the formula fields or invoice statement so that they can be used in a roll up summary field,or filter for the same, on the opportunity object</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Is Student Campus 1 Value</fullName>
        <actions>
            <name>Update_Is_Campus_1_Student_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Line_Item__c.Is_Campus_1_Student__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Copy Is Student Campus 2 Value</fullName>
        <actions>
            <name>Update_Is_Campus_2_Student_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Line_Item__c.Is_Campus_2_Student__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>ISM Change Bus Fee Tracking Category to C002</fullName>
        <actions>
            <name>Change_Company_Tracking_Category_to_C002</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes the company tracking category for ISM bus fees to C002 as this is typically the company which bus fees and costs are managed through.</description>
        <formula>AND(TEXT(Fee_Type__c) = &quot;Bus&quot;, Invoice_Statement__r.School__c = &quot;Moscow A&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>NYIS Change Description to Financial Aid</fullName>
        <actions>
            <name>NYIS_Change_Description_to_Financial_Aid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Changes the Description of Discounted Lines to &apos;Financial Aid&apos;</description>
        <formula>AND(     CONTAINS(Description__c, &quot;Discount on&quot;),      Invoice_Statement__r.School__c = &quot;New York&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Process BSB Founding Parent Discount Adjustment</fullName>
        <actions>
            <name>Adjust_Calculated_Discount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>14/12/2016: Old logic pending deletion</description>
        <formula>AND(     ISBLANK(Invoice_Statement__r.Xero_Id__c),     Invoice_Statement__r.School__c = &quot;Brasilia&quot;,     TEXT(Fee_Type__c) = &quot;Tuition&quot;,     CONTAINS(Description__c, &quot;Monthly&quot;),     CONTAINS(Description__c, &quot;Discount&quot;),     Description__c != &quot;Founding Parent Monthly Discount&quot;,     Student__r.Account.Is_Founding_Parent__c = TRUE     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Process BSB Founding Parent Tuition Adjustment</fullName>
        <actions>
            <name>Apply_Discount_to_Unit_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Fee_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>14/12/2016: Old logic pending deletion</description>
        <formula>AND(     ISBLANK(Invoice_Statement__r.Xero_Id__c),     Invoice_Statement__r.School__c = &quot;Brasilia&quot;,     TEXT(Fee_Type__c) = &quot;Tuition&quot;,     CONTAINS(Description__c, &quot;Monthly&quot;),     NOT(CONTAINS(Description__c, &quot;Discount&quot;)),     Student__r.Account.Is_Founding_Parent__c = TRUE     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
