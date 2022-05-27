<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy_Group_Website_Id</fullName>
        <field>GroupIdText__c</field>
        <formula>Id</formula>
        <name>Copy Group Website Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Translation_UID</fullName>
        <field>Only_1_Translation_Per_Language_Allowed__c</field>
        <formula>English_Parent__r.Id&amp;TEXT(Language__c)</formula>
        <name>Populate Translation UID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Copy Group Website Id</fullName>
        <actions>
            <name>Copy_Group_Website_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Group_Website__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Translation UID</fullName>
        <actions>
            <name>Populate_Translation_UID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
