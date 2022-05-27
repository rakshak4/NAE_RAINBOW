<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Design_Job_Due_Date_Change_Request</fullName>
        <description>Design Job - Due Date Change Request</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Design_Job_Due_Date_Change_Request</template>
    </alerts>
    <alerts>
        <fullName>Design_Job_Email_Reminder_to_rate</fullName>
        <description>Design Job Email Reminder to rate</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Design_Job_Completed_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Email_sent_to_notify_Design_Job_has_been_completed</fullName>
        <ccEmails>ashley.andrews@britishschools.co.uk</ccEmails>
        <description>Email sent to notify Design Job has been completed</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/DesignJobCompleted</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_New_Design_Job_Created</fullName>
        <ccEmails>ashley.andrews@britishschools.co.uk</ccEmails>
        <ccEmails>paul.collins@britishschools.co.uk</ccEmails>
        <description>Notify of New Design Job Created</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/DesignJobCreated</template>
    </alerts>
    <fieldUpdates>
        <fullName>Changes_Owner_to_Group_Design</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Changes Owner to Group Design</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Des_Update_Abbreviation_Text_Field</fullName>
        <field>Abbreviation_Text__c</field>
        <formula>CASE ( Work_For__c, &quot;King&apos;s College Beijing&quot;, &quot;KCB&quot;,  
&quot;The British College of Brazil&quot;, &quot;BCB&quot;,
&quot;The British School of Guangzhou&quot;, &quot;BSG&quot;, 
&quot;The British International School of Kuala Lumpur&quot;, &quot;BSKL&quot;,
&quot;The British School of Marbella&quot;, &quot;BSM&quot;,
&quot;The British School of Nanjing&quot;, &quot;Nanjing&quot;,
&quot;The British School of Navarra&quot;, &quot;BSN&quot;, 
&quot;The British School of Tashkent&quot;, &quot;BST&quot;, 
&quot;The International School of Moscow&quot;, &quot;ISM&quot;,
&quot;The King&apos;s School Manila&quot;, &quot;KSM&quot;,
&quot;BSF&quot; )</formula>
        <name>Grp/Des - Update Abbreviation Text Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Changes Owner to Group Design</fullName>
        <actions>
            <name>Changes_Owner_to_Group_Design</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Design_Job__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Due Date Change Request</fullName>
        <actions>
            <name>Design_Job_Due_Date_Change_Request</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Design_Job__c.Date_Completed__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Design_Job__c.Due_Date_Revision_Request__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Design_Job__c.Contact_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends an email to request a change of date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FDes - Abbreviation Update</fullName>
        <actions>
            <name>Grp_Des_Update_Abbreviation_Text_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Design_Job__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the abbreviation of the school which the design job is for</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify of New Task Created</fullName>
        <actions>
            <name>Notify_of_New_Design_Job_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.CreatedById</field>
            <operation>notEqual</operation>
            <value>Ashley Andrews</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Task Completed</fullName>
        <actions>
            <name>Email_sent_to_notify_Design_Job_has_been_completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Design_Job__c.Date_Completed__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Design_Job__c.No_Rating_Required__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Design_Job__c.Contact_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Design_Job__c.Rate_Satisfaction__c</field>
            <operation>equals</operation>
            <value>Not Rated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Design_Job_Email_Reminder_to_rate</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Design_Job__c.Date_Completed__c</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
