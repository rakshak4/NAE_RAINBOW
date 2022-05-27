<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Health_Related_Pastoral_Notification_to_Form_Tutor</fullName>
        <description>Send Health Related Pastoral Notification to Form Tutor</description>
        <protected>false</protected>
        <recipients>
            <field>Staff_Member_to_Notify__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Health_Related_Pastoral_to_Form_Tutor</template>
    </alerts>
    <fieldUpdates>
        <fullName>Pastoral_Owner_Title</fullName>
        <description>populates owner title on pastoral</description>
        <field>Owner_Title__c</field>
        <formula>CreatedBy.Title</formula>
        <name>Pastoral - Owner Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Staff_Member_to_Notify_Field</fullName>
        <field>Staff_Member_to_Notify__c</field>
        <formula>Student_Name__r.Tutor_Group__r.Owner:User.Email</formula>
        <name>Populate Staff Member to Notify Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Pastoral - Populate Owner Title</fullName>
        <actions>
            <name>Pastoral_Owner_Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Conduct__c.Owner_Title__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>populates owner title on pastoral</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Staff Member to Notify Field</fullName>
        <actions>
            <name>Populate_Staff_Member_to_Notify_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Conduct__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Populates the &apos;staff member to notify&apos; field on the pastoral record with the email address of the user who is the form tutor of the relevant child. Required so that health related email notifications can be sent to form tutors on creation.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Health Related Pastoral Notification to Form Tutor</fullName>
        <actions>
            <name>Send_Health_Related_Pastoral_Notification_to_Form_Tutor</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Conduct__c.Health_Related__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
