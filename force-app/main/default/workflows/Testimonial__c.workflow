<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_to_First_Approver_on_Recall</fullName>
        <description>Email to First Approver on Recall</description>
        <protected>false</protected>
        <recipients>
            <field>First_Approver__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_Testimonial_Publish_Recall</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Initial_Submitter_on_Approval</fullName>
        <description>Email to Initial Submitter on Approval</description>
        <protected>false</protected>
        <recipients>
            <field>Initial_Submitter__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_Testimonial_Publish_Approved</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Initial_Submitter_on_Rejection</fullName>
        <description>Email_to_Initial_Submitter_on_Rejection</description>
        <protected>false</protected>
        <recipients>
            <field>Initial_Submitter__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_Testimonial_Publish_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Notify_Testimonial_Published</fullName>
        <description>Notify Testimonial Published</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Notify_Testimonial_Published</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_RT_to_Parent_Testimonial_Trans</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Parent_Testimonial_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change RT to Parent Testimonial Trans.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_RT_to_Staff_Testimonial_Trans</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Staff_Testimonial_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change RT to Staff Testimonial Trans.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Assigned_Trans_for_S_Rule_TL</fullName>
        <field>Assigned_Translator_for_Sharing_Rule__c</field>
        <formula>IF(
   TEXT(Assigned_Translator__c) = &quot;&quot;, 
   &quot;&quot;,
   SUBSTITUTE(MID(TEXT(Assigned_Translator__c), FIND(&quot;(&quot;, TEXT(Assigned_Translator__c))+1, 20), &quot;)&quot;, &quot;&quot;)
   )</formula>
        <name>Populate Assigned Trans. for S.Rule (TL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_First_Approver_Email_Address</fullName>
        <field>First_Approver__c</field>
        <formula>&quot;hanna.ward@britishschools.co.uk&quot;</formula>
        <name>Populate First Approver Email Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Initial_Submitter_Email_Address</fullName>
        <field>Initial_Submitter__c</field>
        <formula>$User.Email</formula>
        <name>Populate Initial Submitter Email Address</name>
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
        <fullName>Publish_on_School_Website</fullName>
        <field>Publish_on_School_Site__c</field>
        <literalValue>1</literalValue>
        <name>Publish on School Website</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Change RT to Parent Testimonial Translation</fullName>
        <actions>
            <name>Change_RT_to_Parent_Testimonial_Trans</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(      RecordType.DeveloperName = &quot;New_Translation&quot;,      English_Parent__r.RecordType.DeveloperName = &quot;Parent_Testimonial&quot;      )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change RT to Staff Testimonial Translation</fullName>
        <actions>
            <name>Change_RT_to_Staff_Testimonial_Trans</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(      RecordType.DeveloperName = &quot;New_Translation&quot;,      English_Parent__r.RecordType.DeveloperName = &quot;Staff_Testimonial&quot;      )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Inform of New Testimonial Published</fullName>
        <actions>
            <name>Notify_Testimonial_Published</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND(OR(Publish_on_Group_Site__c = TRUE, Publish_on_School_Site__c = TRUE),  PRIORVALUE(Publish_on_Group_Site__c) = FALSE, PRIORVALUE(Publish_on_School_Site__c) = FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Assigned Translator for Sharing Rule</fullName>
        <actions>
            <name>Populate_Assigned_Trans_for_S_Rule_TL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Testimonial__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>12/11/2015: Currently not in use as this sharing method is not being used</description>
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
    <rules>
        <fullName>Testimonial Notification</fullName>
        <active>false</active>
        <booleanFilter>1 or 2</booleanFilter>
        <criteriaItems>
            <field>Testimonial__c.Can_be_publicly_shared__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Testimonial__c.Can_be_publicly_shared__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>BH: Sends email when new staff testimonial is received</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
