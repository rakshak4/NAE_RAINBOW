<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Appraisal_Review_Reminder</fullName>
        <description>Appraisal Review Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Line_Manager_s_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Staff_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>X2nd_Person_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Appraisal_Objective_Review_Reminder</template>
    </alerts>
    <fieldUpdates>
        <fullName>Copy_Manager_s_Email</fullName>
        <field>Line_Manager_s_Email__c</field>
        <formula>Copy_Manager_s_Email__c</formula>
        <name>Copy Manager&apos;s Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Staff_Email</fullName>
        <field>Staff_Email__c</field>
        <formula>Copy_Staff_Email__c</formula>
        <name>Copy Staff Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Copy Emails</fullName>
        <actions>
            <name>Copy_Manager_s_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Staff_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Appraisal_Objectives__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Review Reminder</fullName>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Appraisal_Objectives__c.Expected_Md_Year_Reveiew_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Appraisal_Objectives__c.Expected_End_of_Year_Review_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Sends an email reminding of an upcoming review of an Appraisal</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Appraisal_Review_Reminder</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Appraisal_Objectives__c.Mid_Year_Review_Date__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Appraisal_Review_Reminder</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Appraisal_Objectives__c.Expected_End_of_Year_Review_Date__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
