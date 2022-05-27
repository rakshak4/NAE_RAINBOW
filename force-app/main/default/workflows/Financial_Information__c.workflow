<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy_Related_To_to_Related_To_Text</fullName>
        <field>Related_To_Text__c</field>
        <formula>IF(
   RecordType.DeveloperName = &quot;Company_Financial_Information&quot;,
   Related_to__r.Name,
   IF(
      RecordType.DeveloperName = &quot;Parent_Financial_Information&quot;,
      Related_to__r.FirstName &amp;&quot; &quot;&amp; Related_to__r.LastName,
      &quot;&quot;
      )
   )</formula>
        <name>Copy Related To to Related To Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>F_Info_R_Received</fullName>
        <description>Changes to indicate that a response has been received. Controls the workflow sending a reminder email when a response has not been received.</description>
        <field>F_Info_Response_Status__c</field>
        <literalValue>have already received</literalValue>
        <name>F/Info R/Received</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Related_to__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Bank_Details</fullName>
        <field>Bank_Details__c</field>
        <formula>Bank_Details__c</formula>
        <name>Update Bank Details</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Related_to__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Bank_Details_Local_Language</fullName>
        <field>Bank_Details_Local_Language__c</field>
        <formula>Bank_Details_Local_Language__c</formula>
        <name>Update Bank Details Local Language</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Related_to__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Copy Related To to Related To Text</fullName>
        <actions>
            <name>Copy_Related_To_to_Related_To_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(    RecordType.DeveloperName = &quot;Company_Financial_Information&quot;,    RecordType.DeveloperName = &quot;Parent_Financial_Information&quot;    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>F%2FInfo Added%2FUpdated %28Triggers Account Update%29</fullName>
        <actions>
            <name>F_Info_R_Received</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Financial_Information__c.Fees_Responsible_For__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Financial_Information__c.Fees_Responsible_For__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Triggers when a new financial information record is created or an update is made to any field within a financial information record</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Bank Details</fullName>
        <actions>
            <name>Update_Bank_Details</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Bank_Details_Local_Language</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Financial_Information__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
