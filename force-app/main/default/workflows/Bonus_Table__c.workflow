<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Include_Academic_Year_to_Bonus_Name</fullName>
        <field>Name</field>
        <formula>Name &amp;&quot; (&quot; &amp;Academic_Year__c &amp;&quot;)&quot;</formula>
        <name>Include Academic Year to Bonus Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Student_Target_Achieved</fullName>
        <field>Resulting_Multiplier_Copy__c</field>
        <formula>Resulting_Multiplier_New__c</formula>
        <name>Update Student Target Achieved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Include Academic Year to Name of Bonus Table</fullName>
        <actions>
            <name>Include_Academic_Year_to_Bonus_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Bonus_Table__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Student Target Achieved</fullName>
        <actions>
            <name>Update_Student_Target_Achieved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Bonus_Table__c.Confirmed_Student_Numbers__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Used as a workaround for hitting the 5000 characters limit in formula</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
