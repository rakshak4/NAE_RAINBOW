<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Clean_Link_to_Document_1</fullName>
        <field>Link_to_Document__c</field>
        <formula>IF(
   AND(
       LEFT(Link_to_Document__c, 8) != &quot;https://&quot;,
       LEFT(Link_to_Document__c, 7) != &quot;http://&quot;
       ),
   &quot;http://&quot;&amp;Link_to_Document__c,   
   Link_to_Document__c
   )</formula>
        <name>Clean Link to Document 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clean_Link_to_Document_2</fullName>
        <field>Link_to_Document_2__c</field>
        <formula>IF(
   AND(
       LEFT(Link_to_Document_2__c, 8) != &quot;https://&quot;,
       LEFT(Link_to_Document_2__c, 7) != &quot;http://&quot;
       ),
   &quot;http://&quot;&amp;Link_to_Document_2__c,   
   Link_to_Document_2__c
   )</formula>
        <name>Clean Link to Document 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clean_Link_to_Document_3</fullName>
        <field>Link_to_Document_3__c</field>
        <formula>IF(
   AND(
       LEFT(Link_to_Document_3__c, 8) != &quot;https://&quot;,
       LEFT(Link_to_Document_3__c, 7) != &quot;http://&quot;
       ),
   &quot;http://&quot;&amp;Link_to_Document_3__c,   
   Link_to_Document_3__c
   )</formula>
        <name>Clean Link to Document 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clean_Link_to_Document_4</fullName>
        <field>Link_to_Document_4__c</field>
        <formula>IF(
   AND(
       LEFT(Link_to_Document_4__c, 8) != &quot;https://&quot;,
       LEFT(Link_to_Document_4__c, 7) != &quot;http://&quot;
       ),
   &quot;http://&quot;&amp;Link_to_Document_4__c,   
   Link_to_Document_4__c
   )</formula>
        <name>Clean Link to Document 4</name>
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
    <fieldUpdates>
        <fullName>Show_as_Feat_Job_Posting_Until_to_Null</fullName>
        <field>Show_as_Featured_Job_Posting_Until__c</field>
        <name>Show as Feat. Job Posting Until to Null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Clean Link to Document 1</fullName>
        <actions>
            <name>Clean_Link_to_Document_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Job_Posting__c.Link_to_Document__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Clean Link to Document 2</fullName>
        <actions>
            <name>Clean_Link_to_Document_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Job_Posting__c.Link_to_Document_2__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Clean Link to Document 3</fullName>
        <actions>
            <name>Clean_Link_to_Document_3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Job_Posting__c.Link_to_Document_3__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Clean Link to Document 4</fullName>
        <actions>
            <name>Clean_Link_to_Document_4</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Job_Posting__c.Link_to_Document_4__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Clear Featured Until Date from Job Posting</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Job_Posting__c.Show_as_Featured_Job_Posting_Until__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Show_as_Feat_Job_Posting_Until_to_Null</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Job_Posting__c.Show_as_Featured_Job_Posting_Until__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
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
