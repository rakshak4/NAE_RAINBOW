<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Assessment_Owner_Title_Created_By</fullName>
        <description>updates assessment owner title to Assessment_Folder__r.CreatedBy.Title. Required so that if a person&apos;s job title changes historical report job titles do not change.</description>
        <field>Owner_Title__c</field>
        <formula>CreatedBy.Title</formula>
        <name>Assessment - Owner Title (Created By)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mid_Term_Report</fullName>
        <description>Inputs Yes if dates of assessment is a mid-term report</description>
        <field>Mid_Term_Report__c</field>
        <formula>IF(AND(MONTH(Assessment_Date__c )&gt;7,(OR(MONTH(Assessment_Date__c )&lt;11,(AND(MONTH(Assessment_Date__c )=11,DAY(Assessment_Date__c )&lt;5))))),&quot;YES&quot;,

IF(AND(MONTH(Assessment_Date__c )&gt;=1,(OR(MONTH(Assessment_Date__c )&lt;2,(AND(MONTH(Assessment_Date__c )=2,DAY(Assessment_Date__c )&lt;16))))),&quot;YES&quot;,

IF(OR(AND(MONTH(Assessment_Date__c)=4,DAY(Assessment_Date__c)&gt;19),         AND(MONTH(Assessment_Date__c )=5,DAY(Assessment_Date__c)&lt;16) ),&quot;YES&quot;,&quot;&quot;)))</formula>
        <name>Mid Term Report</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Assessment_Year_Group</fullName>
        <field>Year_Group_Grade__c</field>
        <formula>Contact_Year_Group__c</formula>
        <name>Populate Assessment Year Group</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Exam_Title</fullName>
        <field>Title__c</field>
        <formula>TEXT(Exam_Type__c) &amp;&quot; &quot;&amp; TEXT(Grade_Type__c)</formula>
        <name>Populate Exam Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Owner_Order_Copy</fullName>
        <field>Owner_Order_Copy__c</field>
        <formula>Owner_Order__c</formula>
        <name>Populate Owner Order Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Term_Copy</fullName>
        <field>Term_Copy__c</field>
        <formula>Term__c</formula>
        <name>Populate Term Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Assessment - Populate Title</fullName>
        <actions>
            <name>Assessment_Owner_Title_Created_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Assesment__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>populates assessment&apos;s owner title</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Mid Term Report</fullName>
        <actions>
            <name>Mid_Term_Report</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Assesment__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Assessment Year Group</fullName>
        <actions>
            <name>Populate_Assessment_Year_Group</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Assesment__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Assessment Record</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Exam Title</fullName>
        <actions>
            <name>Populate_Exam_Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Assesment__c.Type__c</field>
            <operation>equals</operation>
            <value>Examination</value>
        </criteriaItems>
        <criteriaItems>
            <field>Assesment__c.Exam_Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Assesment__c.Grade_Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the exam title text field based on the values in the exam type and grade type picklists.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Order Text Fields %28On Create %26 Edit%29</fullName>
        <actions>
            <name>Populate_Term_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Assesment__c.Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Triggers whenever an assessment folder is created or the details are edited, copies formula values to text fields to be used in &apos;Order__c&apos; formula (Required because of 5000 character limit)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Order Text Fields %28On Create Only%29</fullName>
        <actions>
            <name>Populate_Owner_Order_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Assesment__c.Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Triggers whenever an assessment folder is created, copies formula values to text fields to be used in &apos;Order__c&apos; formula (Required because of 5000 character limit)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
