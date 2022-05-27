<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Job_Signup_Notification_Email_Alert</fullName>
        <description>Volunteer Job Signup Notification Email Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Job_Signup_Notification</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Job_Signup_Thank_You_Email_Alert</fullName>
        <description>Volunteer Job Signup Thank You Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>GW_Volunteers__Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Job_Signup_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Shift_Reminder_Email_Alert</fullName>
        <description>Volunteer Shift Reminder Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>GW_Volunteers__Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Hours_Reminder_Email</template>
    </alerts>
    <fieldUpdates>
        <fullName>GW_Volunteers__Set_End_Date</fullName>
        <description>Set End Date to Start Date</description>
        <field>GW_Volunteers__End_Date__c</field>
        <formula>GW_Volunteers__Start_Date__c</formula>
        <name>Set End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GW_Volunteers__Set_Volunteer_Hours_Planned_Start_Date</fullName>
        <description>If the Planned Start Date &amp; Time is empty, set it to the shift&apos;s Start Date &amp; Time</description>
        <field>GW_Volunteers__Planned_Start_Date_Time__c</field>
        <formula>GW_Volunteers__Shift_Start_Date_Time__c</formula>
        <name>Set Volunteer Hours Planned Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>GW_Volunteers__Volunteer Hours - Set End Date</fullName>
        <actions>
            <name>GW_Volunteers__Set_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>GW_Volunteers__Volunteer_Hours__c.GW_Volunteers__End_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If End Date is empty, set it to Start Date.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GW_Volunteers__Volunteer Hours - Set Planned Start Date %26 Time</fullName>
        <actions>
            <name>GW_Volunteers__Set_Volunteer_Hours_Planned_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>GW_Volunteers__Volunteer_Hours__c.GW_Volunteers__Planned_Start_Date_Time__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If Planned Start Date &amp; Time is empty, set it to the Shift&apos;s Start Date &amp; Time</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GW_Volunteers__Volunteer Hours Reminder Email</fullName>
        <active>false</active>
        <description>TEMPLATE TO CLONE, for a time based workflow rule to send a Contact an email reminding them of their upcoming Job Shift.</description>
        <formula>(ISPICKVAL(GW_Volunteers__Status__c, &quot;Confirmed&quot;) ||  ISPICKVAL(GW_Volunteers__Status__c, &quot;Completed&quot;)) &amp;&amp; NOT(ISBLANK(GW_Volunteers__Contact__r.Email)) &amp;&amp; NOT(GW_Volunteers__Contact__r.GW_Volunteers__Volunteer_Auto_Reminder_Email_Opt_Out__c) &amp;&amp; GW_Volunteers__Start_Date__c &gt;= TODAY()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GW_Volunteers__Volunteer Job Signup</fullName>
        <actions>
            <name>GW_Volunteers__Volunteer_Job_Signup_Notification_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Job_Signup_Thank_You_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>GW_Volunteers__Volunteer_Hours__c.GW_Volunteers__Status__c</field>
            <operation>equals</operation>
            <value>Web Sign Up</value>
        </criteriaItems>
        <description>When a person signs up for a Job from the VolunteersJobListing(FS) page, thank them and notify the volunteer manager.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
