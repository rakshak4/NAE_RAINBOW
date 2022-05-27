<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_on_Submit</fullName>
        <description>Email Alert on Submit</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Parent_Questionnaire_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Email_Assessor</fullName>
        <description>Email Assessor</description>
        <protected>false</protected>
        <recipients>
            <field>Email_of_Assessor__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Admissions_Assessment_Scheduled</template>
    </alerts>
    <alerts>
        <fullName>New_Teacher_Recommendation_Received</fullName>
        <description>New Teacher Recommendation Received</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Teacher_Recommendation_Received</template>
    </alerts>
    <alerts>
        <fullName>Send_Request_Cancellation</fullName>
        <description>Send Request Cancellation</description>
        <protected>false</protected>
        <recipients>
            <field>Teachers_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Teacher_Recommendation_Request_Cancellation</template>
    </alerts>
    <alerts>
        <fullName>Send_Teacher_Recommendation_Request_Generic</fullName>
        <description>Send Teacher Recommendation Request (Generic)</description>
        <protected>false</protected>
        <recipients>
            <field>Teachers_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Teacher_Recommendation_Request_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Teacher_Recommendation_Request_NYIS</fullName>
        <description>Send Teacher Recommendation Request (NYIS)</description>
        <protected>false</protected>
        <recipients>
            <field>Teachers_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Teacher_Recommendation_Request_NYIS</template>
    </alerts>
    <fieldUpdates>
        <fullName>Copy_Email_of_Assessor</fullName>
        <field>Email_of_Assessor__c</field>
        <formula>Staff_Doing_Assessment__r.Email</formula>
        <name>Copy Email of Assessor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Request_Sent_Date</fullName>
        <field>Request_Sent__c</field>
        <formula>NOW()</formula>
        <name>Populate Request Sent Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Response_Received_Date</fullName>
        <field>Response_Received__c</field>
        <formula>NOW()</formula>
        <name>Populate Response Received Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Teacher_Rec_Special_Cons</fullName>
        <field>Special_Considerations_Detail__c</field>
        <formula>Student_Name__r.Special_Considerations_Detail__c</formula>
        <name>Populate Teacher Rec. Special Cons.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type_Admissions_Questionnaire</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Questionnaire</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type Admissions Questionnaire</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Email Alert on Online Submit</fullName>
        <actions>
            <name>Email_Alert_on_Submit</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Record_Type_Admissions_Questionnaire</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Submitted_Online__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Email Assessor</fullName>
        <actions>
            <name>Email_Assessor</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Copy_Email_of_Assessor</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Email_Assesor_on_Save__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Sends an email to the staff member doing the assessment</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Teacher Recommendation Received</fullName>
        <actions>
            <name>New_Teacher_Recommendation_Received</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Submitted_Online__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.RecordTypeId</field>
            <operation>contains</operation>
            <value>Teacher Recommendation</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Request Sent Date</fullName>
        <actions>
            <name>Populate_Request_Sent_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Send_Teacher_Recommendation_Request__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Response Received Date</fullName>
        <actions>
            <name>Populate_Response_Received_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Submitted_Online__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Teacher Recommendation Special Considerations</fullName>
        <actions>
            <name>Populate_Teacher_Rec_Special_Cons</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Request Cancellation Email</fullName>
        <actions>
            <name>Send_Request_Cancellation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Send_Teacher_Recommendation_Request__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Send_Request_Cancellation__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Teacher Recommendation Request %28Generic%29</fullName>
        <actions>
            <name>Send_Teacher_Recommendation_Request_Generic</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Send_Teacher_Recommendation_Request__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.School__c</field>
            <operation>notEqual</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Teacher Recommendation Request %28NYIS%29</fullName>
        <actions>
            <name>Send_Teacher_Recommendation_Request_NYIS</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.Send_Teacher_Recommendation_Request__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Admissions_Questionnaire__c.School__c</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
