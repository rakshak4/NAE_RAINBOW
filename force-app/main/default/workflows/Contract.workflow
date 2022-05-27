<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Status_Signed_Not_Started</fullName>
        <field>Status</field>
        <literalValue>Signed-Not Started</literalValue>
        <name>Update Status Signed-Not Started</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Active</fullName>
        <description>Updates the Status field of a contract, to active once the starting date =Today</description>
        <field>Status</field>
        <literalValue>Active</literalValue>
        <name>Update to Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Expired</fullName>
        <description>Changes the status of a contract to Expired, once the contract End Date has arrived</description>
        <field>Status</field>
        <literalValue>Expired</literalValue>
        <name>Update to Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Checks Signed-Not Started</fullName>
        <actions>
            <name>Update_Status_Signed_Not_Started</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>Contract.StartDate</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Signed-Not Started</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Ensure the status of a contract is Signed-Not started, if its active but the start date is in the future</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status to Active%2FExpired</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Signed-Not Started</value>
        </criteriaItems>
        <description>Updates the status of a field once the start date has arrived, to active.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_to_Active</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.Contract_End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Update_to_Expired</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.StartDate</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
