<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Grant_Review_Submitted_Old</fullName>
        <ccEmails>ben.hails@britishschools.co.uk</ccEmails>
        <description>Grant Review Submitted (Old)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Grant_Review_Notification</template>
    </alerts>
    <rules>
        <fullName>Grant Review Submitted %28Old%29</fullName>
        <actions>
            <name>Grant_Review_Submitted_Old</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Grant_Review__c.Submitted_Online__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Grant_Application__c.Is_New_Form__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>160330: Temporary requirement to allow Ben to monitor any old form submissions and ensure the information is passed to Salesforce correctly</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
