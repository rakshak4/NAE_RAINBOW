<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy_Staff_Member_Name</fullName>
        <field>Staff_Member_Copy__c</field>
        <formula>Person_Company__r.FirstName &amp;&quot; &quot;&amp;Person_Company__r.LastName</formula>
        <name>Copy Staff Member Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_copy_from_Created_Date</fullName>
        <field>Date__c</field>
        <formula>DATEVALUE( CreatedDate )</formula>
        <name>Date copy from Created Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Category_Admissins_Assessment</fullName>
        <field>Document_Category__c</field>
        <literalValue>Student Admissions</literalValue>
        <name>Update Category - Admissins Assessment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Category_Job_Description</fullName>
        <field>Document_Category__c</field>
        <literalValue>Job Description</literalValue>
        <name>Update Category - Job Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Category_Minutes</fullName>
        <field>Document_Category__c</field>
        <literalValue>Minutes of Meeting</literalValue>
        <name>Update Category - Minutes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Copy Staff Member Name</fullName>
        <actions>
            <name>Copy_Staff_Member_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Document__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Date copy from Created Date</fullName>
        <actions>
            <name>Date_copy_from_Created_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Document__c.Date_Field_Empty__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Category - Admissins Assessment</fullName>
        <actions>
            <name>Update_Category_Admissins_Assessment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Document__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Template - Admissions Assessment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Category - Job Description</fullName>
        <actions>
            <name>Update_Category_Job_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Document__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Template - Job Description</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Category - Minutes</fullName>
        <actions>
            <name>Update_Category_Minutes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Document__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Template - Minutes of Meeting</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
