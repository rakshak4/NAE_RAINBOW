<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Checks_if_Expired</fullName>
        <field>Expired__c</field>
        <literalValue>1</literalValue>
        <name>Checks if Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Checks_if_Started</fullName>
        <field>Started__c</field>
        <literalValue>1</literalValue>
        <name>Checks if Started</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Rsp%2FPnt - Checks if Expired</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Responsibility_Points__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Checks_if_Expired</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Responsibility_Points__c.End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Rsp%2FPnt - Checks if Started</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Responsibility_Points__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Checks_if_Started</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Responsibility_Points__c.Start_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
