<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change_Subject_Field_Attendance_Update</fullName>
        <field>Subject</field>
        <formula>text(Status__c)</formula>
        <name>Change Subject Field Attendance Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Subject_to_Subject_Copy_Auth_Abs</fullName>
        <field>Attendance_Category__c</field>
        <literalValue>Authorised Absence</literalValue>
        <name>Copy Subject to Subject Copy (Auth.Abs)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Subject_to_Subject_Copy_Ex_Act</fullName>
        <field>Attendance_Category__c</field>
        <literalValue>External Activity</literalValue>
        <name>Copy Subject to Subject Copy (Ex.Act.)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Subject_to_Subject_Copy_Late</fullName>
        <field>Attendance_Category__c</field>
        <literalValue>Late</literalValue>
        <name>Copy Subject to Subject Copy (Late)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Subject_to_Subject_Copy_Partial</fullName>
        <field>Attendance_Category__c</field>
        <literalValue>Partial</literalValue>
        <name>Copy Subject to Subject Copy (Partial)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Subject_to_Subject_Copy_Present</fullName>
        <field>Attendance_Category__c</field>
        <literalValue>Present</literalValue>
        <name>Copy Subject to Subject Copy (Present)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Subject_to_Subject_Copy_Un_Abs</fullName>
        <field>Attendance_Category__c</field>
        <literalValue>Unauthorised Absence</literalValue>
        <name>Copy Subject to Subject Copy (Un. Abs.)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_only_1_first_time_visit_allowed</fullName>
        <field>Only_1_first_time_visit_allowed__c</field>
        <formula>IF(
   Repeat_Visit__c = TRUE,
   Related_Enquiry__r.Id&amp;&quot;-&quot;&amp;Id,
   Related_Enquiry__r.Id
   )</formula>
        <name>Populate only 1 first time visit allowed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Copy Subject to Subject Copy %28Authorised Absence%29</fullName>
        <actions>
            <name>Copy_Subject_to_Subject_Copy_Auth_Abs</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Event.Subject</field>
            <operation>equals</operation>
            <value>Absent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Subject</field>
            <operation>equals</operation>
            <value>Authorised Absence</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Subject to Subject Copy %28External Activity%29</fullName>
        <actions>
            <name>Copy_Subject_to_Subject_Copy_Ex_Act</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Subject</field>
            <operation>equals</operation>
            <value>External Activity</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Subject to Subject Copy %28Late%29</fullName>
        <actions>
            <name>Copy_Subject_to_Subject_Copy_Late</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Subject</field>
            <operation>equals</operation>
            <value>Late</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Subject to Subject Copy %28Partial%29</fullName>
        <actions>
            <name>Copy_Subject_to_Subject_Copy_Partial</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Subject</field>
            <operation>equals</operation>
            <value>Partial</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Subject to Subject Copy %28Present%29</fullName>
        <actions>
            <name>Copy_Subject_to_Subject_Copy_Present</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Subject</field>
            <operation>equals</operation>
            <value>Present</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Subject to Subject Copy %28Unauthorised Absence%29</fullName>
        <actions>
            <name>Copy_Subject_to_Subject_Copy_Un_Abs</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Subject</field>
            <operation>equals</operation>
            <value>Unauthorised Absence</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Email to Parent when Child is absent</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Event.RecordTypeId</field>
            <operation>equals</operation>
            <value>Attendance</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Subject</field>
            <operation>equals</operation>
            <value>Absent</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate %27only 1 first time visit allowed%27</fullName>
        <actions>
            <name>Populate_only_1_first_time_visit_allowed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.RecordTypeId</field>
            <operation>equals</operation>
            <value>School Visit (Complete)</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Subject for Attendance</fullName>
        <actions>
            <name>Change_Subject_Field_Attendance_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Status__c), TEXT(Status__c) &lt;&gt; &quot;&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
