<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_school_list_copy</fullName>
        <field>Schools_List_Copy__c</field>
        <formula>School_List__c</formula>
        <name>Update school list copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Copy School list value MS</fullName>
        <actions>
            <name>Update_school_list_copy</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Micro_Site__c.School_List__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>School website rule . Gets the values of the Schools List field to the Schools List Copy field.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
