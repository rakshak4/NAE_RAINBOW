<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Check_Monthly_Tuition</fullName>
        <field>Monthly_Tuition__c</field>
        <literalValue>1</literalValue>
        <name>Check Monthly Tuition</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Fee_Type</fullName>
        <description>Copies the fee type so that it can be used as a filter in an opportunity roll-up summary field</description>
        <field>Copy_Fee_Type__c</field>
        <formula>Fee_Type__c</formula>
        <name>Copy Fee Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Tuition_Fee_Frequency_To_Student</fullName>
        <field>Payment_Frequency_Tuition__c</field>
        <formula>TEXT(Product2.Fee_Frequency__c)</formula>
        <name>Copy Tuition Fee Frequency To Student</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Monthly_Tuition</fullName>
        <field>Monthly_Tuition__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Monthly Tuition</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Copy Tuition Fee Frequency To Student</fullName>
        <actions>
            <name>Copy_Tuition_Fee_Frequency_To_Student</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.Current__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>OpportunityLineItem.Fee_Type__c</field>
            <operation>equals</operation>
            <value>Tuition</value>
        </criteriaItems>
        <description>Copies the tuition fee frequency from the most recently created or edited, current, tuition fee to the opportunity record</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Monthly Tuition</fullName>
        <actions>
            <name>Check_Monthly_Tuition</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.Invoicing_Term__c</field>
            <operation>equals</operation>
            <value>Monthly</value>
        </criteriaItems>
        <criteriaItems>
            <field>OpportunityLineItem.Tuition__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Fee Assignment Created</fullName>
        <actions>
            <name>Copy_Fee_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.Fee_Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Not Monthly Tuition</fullName>
        <actions>
            <name>Uncheck_Monthly_Tuition</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.Invoicing_Term__c</field>
            <operation>notEqual</operation>
            <value>Monthly</value>
        </criteriaItems>
        <criteriaItems>
            <field>OpportunityLineItem.Tuition__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
