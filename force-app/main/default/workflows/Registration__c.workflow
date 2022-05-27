<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_New_Student_Added_to_Student_Group_Owner</fullName>
        <description>Email New Student Added to Student Group Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Grp_Adm_New_Student_Added_to_Tutor_Group</template>
    </alerts>
    <fieldUpdates>
        <fullName>Check_Include_Parent_in_Chatter_Group</fullName>
        <field>Include_Parent_in_Chatter_Group__c</field>
        <literalValue>1</literalValue>
        <name>Check Include Parent in Chatter Group</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Starting_Date</fullName>
        <field>Starting_Date_Date_from_student__c</field>
        <formula>Starting_Date_from_contact__c</formula>
        <name>Copy Starting Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Is_Current_Year_Tutor_Group_Reg_FALSE</fullName>
        <field>Is_Current_Year_Tutor_Group_Registration__c</field>
        <literalValue>0</literalValue>
        <name>Is Current Year Tutor Group Reg FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Is_Current_Year_Tutor_Group_Reg_TRUE</fullName>
        <field>Is_Current_Year_Tutor_Group_Registration__c</field>
        <literalValue>1</literalValue>
        <name>Is Current Year Tutor Group Reg TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Include_in_Chatter_Group_Until</fullName>
        <field>Include_Parent_in_Chatter_Group_Until__c</field>
        <formula>Starting_Date_from_contact__c + 1</formula>
        <name>Populate Include in Chatter Group Until</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Registration_Deactivated_Date</fullName>
        <field>Registration_Deactivated_Date__c</field>
        <formula>IF(
   AND(
       Student__r.Admissions_File__r.Leaving_Date__c &lt; TODAY()-1, 
       NOT(ISBLANK(Student__r.Admissions_File__r.Leaving_Date__c))
       ), 
   Student__r.Admissions_File__r.Leaving_Date__c + 1, 
   TODAY()
   )</formula>
        <name>Populate Registration Deactivated Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Registration_Clear_Starting_Date_Value</fullName>
        <field>Starting_Date_Date_from_student__c</field>
        <name>Registration - Clear Starting Date Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Registration_Update_Active_to_False</fullName>
        <field>Active__c</field>
        <literalValue>0</literalValue>
        <name>Registration - Update Active to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Registration_Update_Active_to_True</fullName>
        <field>Active__c</field>
        <literalValue>1</literalValue>
        <name>Registration - Update Active to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Include_Parent_in_Chatter_Group</fullName>
        <field>Include_Parent_in_Chatter_Group__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Include Parent in Chatter Group</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Whole_School_Registration_to_True</fullName>
        <field>Is_Whole_School_Group_Registration__c</field>
        <literalValue>1</literalValue>
        <name>Whole School Registration to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Activate Student in Whole School Group</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND (4 OR (5 AND 6)) AND 7 AND 8 AND 9 AND 10 AND 11</booleanFilter>
        <criteriaItems>
            <field>Registration__c.Active__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Is_Whole_School_Group_Registration__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Group__c.Group_Type__c</field>
            <operation>equals</operation>
            <value>School Group</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Admission_Stage__c</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Admission_Stage__c</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Attending_School_From_student__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Starting_Date_Date_from_student__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Registration_School_Student_School__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.School__c</field>
            <operation>notEqual</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.School__c</field>
            <operation>notEqual</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.School__c</field>
            <operation>notEqual</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Registration_Update_Active_to_True</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Registration__c.Starting_Date_Date_from_student__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BCB - New Student Registration</fullName>
        <active>true</active>
        <description>If the registration of a student is inactive and the student is starting in the future this rule will fire</description>
        <formula>AND(  ISBLANK(Student__r.Tutor_Group__c),  Active__c = FALSE,  Starting_Date_Date_from_student__c &gt;= TODAY(),  TEXT(Group__r.Group_Type__c) = &quot;Tutor Group&quot;,  Registration_School_Student_School__c = TRUE,  Group__r.Is_Valid__c = TRUE,  Group__r.School__c = &quot;The British College of Brazil&quot;  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Registration_Update_Active_to_True</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Registration__c.Starting_Date_Date_from_student__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Check Include Parent in Chatter Group Field</fullName>
        <actions>
            <name>Check_Include_Parent_in_Chatter_Group</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND (4 OR (5 AND 6))</booleanFilter>
        <criteriaItems>
            <field>Registration__c.Group_Type__c</field>
            <operation>equals</operation>
            <value>Tutor Group</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Include_Parent_in_Chatter_Group_Until__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Include_Parent_in_Chatter_Group__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Attending_School_From_student__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Copy Starting Date</fullName>
        <actions>
            <name>Copy_Starting_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR (2 AND 3)</booleanFilter>
        <criteriaItems>
            <field>Registration__c.Admission_Stage__c</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Admission_Stage__c</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Attending_School_From_student__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Deactivate Student if not in School</fullName>
        <actions>
            <name>Registration_Clear_Starting_Date_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Registration_Update_Active_to_False</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2 OR 3 OR 4 OR 5 OR 6 OR (7 AND 8)</booleanFilter>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>W/List A/Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>W/List D/Paid</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>A/ Testing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>Left</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Stage_from_contact__c</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Attending_School_From_student__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Is Whole School Group Registration</fullName>
        <actions>
            <name>Whole_School_Registration_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Registration__c.Is_Whole_School_Group_Registration__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Group_Type__c</field>
            <operation>equals</operation>
            <value>School Group</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Student Registration</fullName>
        <active>true</active>
        <description>If the student does not have an active tutor group registration and they are starting in the future this rule will fire for any valid, inactive tutor group registrations. An Apex error will occur if multiple tutor group registration activations occur.</description>
        <formula>AND(  ISBLANK(Student__r.Tutor_Group__c),  Active__c = FALSE,  Starting_Date_Date_from_student__c &gt;= TODAY(),  TEXT(Group__r.Group_Type__c) = &quot;Tutor Group&quot;,  Registration_School_Student_School__c = TRUE,  Group__r.Is_Valid__c = TRUE,  Group__r.School__c != &quot;The British College of Brazil&quot;  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Registration_Update_Active_to_True</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Registration__c.Starting_Date_Date_from_student__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notify Student Group Owner of New Student</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Registration__c.Active__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Starting_Date_Date_from_student__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Group_Type__c</field>
            <operation>equals</operation>
            <value>Tutor Group</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_New_Student_Added_to_Student_Group_Owner</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Registration__c.Starting_Date_Date_from_student__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Populate Include in Chatter Group Until Date</fullName>
        <actions>
            <name>Populate_Include_in_Chatter_Group_Until</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(OR(Stage_from_contact__c = &apos;Enrolled&apos;, AND(Stage_from_contact__c = &apos;A/ Deposit&apos;,  Attending_School_From_student__c = TRUE)), Group_Type__c = &apos;Tutor Group&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Registration Deactivated Date</fullName>
        <actions>
            <name>Populate_Registration_Deactivated_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Registration__c.Active__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Is Current Year Tutor Group Registration FALSE</fullName>
        <actions>
            <name>Is_Current_Year_Tutor_Group_Reg_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     Is_Current_Year_Tutor_Group_Registration__c = TRUE,      OR(        Group__r.Current_Academic_Year__c != Group__r.Academic_Year__c,        TEXT(Group__r.Group_Type__c) != &quot;Tutor Group&quot;        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Is Current Year Tutor Group Registration TRUE</fullName>
        <actions>
            <name>Is_Current_Year_Tutor_Group_Reg_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     Group__r.Current_Academic_Year__c = Group__r.Academic_Year__c,     TEXT(Group__r.Group_Type__c) = &quot;Tutor Group&quot;     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Include Parent in Chatter Group Field</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Registration__c.Group_Type__c</field>
            <operation>equals</operation>
            <value>Tutor Group</value>
        </criteriaItems>
        <criteriaItems>
            <field>Registration__c.Include_Parent_in_Chatter_Group__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Uncheck_Include_Parent_in_Chatter_Group</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Registration__c.Include_Parent_in_Chatter_Group_Until__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
