<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Reply_to_Staff_Member</fullName>
        <description>Email Result to Staff Member</description>
        <protected>false</protected>
        <recipients>
            <field>Staff_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Days_off_Email_to_Staff_with_Result</template>
    </alerts>
    <alerts>
        <fullName>Email_Result_to_Manager</fullName>
        <description>Email Result to Manager</description>
        <protected>false</protected>
        <recipients>
            <field>Initial_Submitter_Days_Off__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Line_Manager_s_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Days_off_Email_to_Manager_with_Result</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Manager</fullName>
        <description>Email to Manager Days Off Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>Line_Manager_s_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Days_off_Email_to_Manager_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Staff_Submitted</fullName>
        <description>Email to Staff Days Off Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>Staff_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Days_off_Email_to_Staff_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Reply_to_Sender</fullName>
        <description>Reply to Sender</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Reply_to_Contract_Approval_Request</template>
    </alerts>
    <fieldUpdates>
        <fullName>Copy_Manager_s_Email</fullName>
        <field>Line_Manager_s_Email__c</field>
        <formula>Manager_s_Email__c</formula>
        <name>Copy Manager&apos;s Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Staff_Email_Days_Off</fullName>
        <field>Staff_Email__c</field>
        <formula>Copy_Email_Staff__c</formula>
        <name>Copy Staff Email (Days Off)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Submitter_Email_Day_Off</fullName>
        <field>Initial_Submitter_Days_Off__c</field>
        <formula>$User.Email</formula>
        <name>Populate Submitter Email (Day Off)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Day_Type_to_Working_Days</fullName>
        <description>Mirror the contract, if the Day Type is &quot;Working Days&quot;</description>
        <field>Day_Type_in_Contract__c</field>
        <literalValue>Working Days</literalValue>
        <name>Update Day Type to Working Days</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Holidays_Left_After_Approval</fullName>
        <field>Holidays_Left_After_Approvala__c</field>
        <formula>IF( Text(Type__c )=&quot;Holidays&quot;,Holidays_in_Contract__c - Holidays_Taken__c - Days_Off__c,Holidays_in_Contract__c - Holidays_Taken__c )</formula>
        <name>Update Holidays Left After Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Holidays_Left_After_Rejection</fullName>
        <field>Holidays_Left_After_Approvala__c</field>
        <formula>Holidays_in_Contract__c - Holidays_Taken__c</formula>
        <name>Update Holidays Left After Rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sick_Days_Left_After_Approval</fullName>
        <field>Sick_Days_Left_After_Approval__c</field>
        <formula>IF( Text(Type__c )=&quot;Sick Leave&quot;, Sick_Days_in_Contract__c - Sick_Leave_Taken__c - Days_Off__c,Sick_Days_in_Contract__c - Sick_Leave_Taken__c )</formula>
        <name>Update Sick Days Left After Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sick_Days_Left_After_Rejection</fullName>
        <field>Sick_Days_Left_After_Approval__c</field>
        <formula>Sick_Days_in_Contract__c - Sick_Leave_Taken__c</formula>
        <name>Update Sick Days Left After Rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Approved</fullName>
        <field>Status_Picklist__c</field>
        <literalValue>Approved</literalValue>
        <name>Update to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Approved_Days_Off</fullName>
        <field>Status_Picklist__c</field>
        <literalValue>Approved</literalValue>
        <name>Update to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_Day_Type_to_Calendar_Days</fullName>
        <field>Day_Type_in_Contract__c</field>
        <literalValue>Calendar Days</literalValue>
        <name>Updates Day Type to Calendar Days</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updates_to_Rejected</fullName>
        <field>Status_Picklist__c</field>
        <literalValue>Rejected</literalValue>
        <name>Updates to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Automatic Approve Days Off BSG</fullName>
        <actions>
            <name>Update_to_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Days_Off__c.CreatedById</field>
            <operation>equals</operation>
            <value>Administration BSG</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy  Emails</fullName>
        <actions>
            <name>Copy_Manager_s_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Staff_Email_Days_Off</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Days_Off__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Day Type in Contract</fullName>
        <actions>
            <name>Updates_Day_Type_to_Calendar_Days</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Holidays_Day_Type__c</field>
            <operation>equals</operation>
            <value>Calendar Days</value>
        </criteriaItems>
        <description>Update the Day Type date, replicating the Day Type in the Contract Object</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Day Type to Working Day</fullName>
        <actions>
            <name>Update_Day_Type_to_Working_Days</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment_Agreement__c.Holidays_Day_Type__c</field>
            <operation>equals</operation>
            <value>Working Days</value>
        </criteriaItems>
        <description>Update the Day Type date, to Working Date to Mirror the contract</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Correct Working Days</fullName>
        <active>true</active>
        <description>Corrects a problem in the Days off calculation, whereby if the Start Date and End Date are equal and within a weekend, the Days off field is changed to 0</description>
        <formula>AND( Start_Date__c = End_Date__c, Working_Days_Off__c =5)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
