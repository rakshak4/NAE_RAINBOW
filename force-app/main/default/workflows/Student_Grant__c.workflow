<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Grp_Adm_Email_informing_of_Change_in_Financial_Aid_Conditions</fullName>
        <description>Grp/Adm - Email informing of Change in Financial Aid Conditions</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_informing_change_of_financial_aid_conditions</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_informing_of_Change_in_Financial_Aid_Decision</fullName>
        <description>Grp/Adm - Email informing of Change in Financial Aid Decision</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Grp_Adm_Email_informing_change_of_financial_aid_decision</template>
    </alerts>
    <fieldUpdates>
        <fullName>Create_Child_Order</fullName>
        <field>Child_Order__c</field>
        <formula>Grant_Application__r.Students_With_Grants_1__c</formula>
        <name>Create Child Order</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_1_Name</fullName>
        <field>Child_1_Name__c</field>
        <formula>IF( Child_Order__c =1, Student_Full_Name__c , Grant_Application__r.Child_1_Name__c )</formula>
        <name>Update Child 1 Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_1_Summary</fullName>
        <field>Child_1_Grant_Summary__c</field>
        <formula>IF( Child_Order__c &lt;&gt;1,  Grant_Application__r.Child_1_Grant_Summary__c , 

(IF( Tuition_Reduction__c &gt;0, &quot;Tuition Fees - &quot;&amp;TEXT(Tuition_Reduction__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp;

IF(  Lunch_Granted__c  &gt;0, &quot;Lunch Fees - &quot;&amp;TEXT(Lunch_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp;

IF(  Bus_Granted__c  &gt;0, &quot;Bus Fees - &quot;&amp;TEXT(Bus_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp;

IF(  Enrolment_Fees__c  &gt;0, &quot;Enrolment Fees - &quot;&amp;TEXT(Enrolment_Fees__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp;

IF(  Other_Benefits__c  &lt;&gt;&quot;&quot;, &quot;Other Benefits - &quot;&amp; Other_Benefits__c ,&quot;&quot;)))</formula>
        <name>Update Child 1 Summary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_2_Name</fullName>
        <field>Child_2_Name__c</field>
        <formula>IF( Child_Order__c =2, Student_Full_Name__c , Grant_Application__r.Child_2_Name__c )</formula>
        <name>Update Child 2 Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_2_Summary</fullName>
        <field>Child_2_Grant_Summary__c</field>
        <formula>IF( Child_Order__c &lt;&gt;2, Grant_Application__r.Child_2_Grant_Summary__c , 

(IF( Tuition_Reduction__c &gt;0, &quot;Tuition Fees - &quot;&amp;TEXT(Tuition_Reduction__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Lunch_Granted__c &gt;0, &quot;Lunch Fees - &quot;&amp;TEXT(Lunch_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Bus_Granted__c &gt;0, &quot;Bus Fees - &quot;&amp;TEXT(Bus_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Enrolment_Fees__c &gt;0, &quot;Enrolment Fees - &quot;&amp;TEXT(Enrolment_Fees__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp;

IF(  Other_Benefits__c  &lt;&gt;&quot;&quot;, &quot;Other Benefits - &quot;&amp; Other_Benefits__c ,&quot;&quot;)))</formula>
        <name>Update Child 2 Summary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_3_Name</fullName>
        <field>Child_3_Name__c</field>
        <formula>IF( Child_Order__c =3, Student_Full_Name__c , Grant_Application__r.Child_3_Name__c )</formula>
        <name>Update Child 3 Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_3_Summary</fullName>
        <field>Child_3_Grant_Summary__c</field>
        <formula>IF( Child_Order__c &lt;&gt;3, Grant_Application__r.Child_3_Grant_Summary__c , 

(IF( Tuition_Reduction__c &gt;0, &quot;Tuition Fees - &quot;&amp;TEXT(Tuition_Reduction__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Lunch_Granted__c &gt;0, &quot;Lunch Fees - &quot;&amp;TEXT(Lunch_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Bus_Granted__c &gt;0, &quot;Bus Fees - &quot;&amp;TEXT(Bus_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Enrolment_Fees__c &gt;0, &quot;Enrolment Fees - &quot;&amp;TEXT(Enrolment_Fees__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp;

IF(  Other_Benefits__c  &lt;&gt;&quot;&quot;, &quot;Other Benefits - &quot;&amp; Other_Benefits__c ,&quot;&quot;)))</formula>
        <name>Update Child 3 Summary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_4_Name</fullName>
        <field>Child_4_Name__c</field>
        <formula>IF( Child_Order__c =4, Student_Full_Name__c , Grant_Application__r.Child_4_Name__c )</formula>
        <name>Update Child 4 Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_4_Summary</fullName>
        <field>Child_4_Grant_Summary__c</field>
        <formula>IF( Child_Order__c &lt;&gt;4, Grant_Application__r.Child_4_Grant_Summary__c , 

(IF( Tuition_Reduction__c &gt;0, &quot;Tuition Fees - &quot;&amp;TEXT(Tuition_Reduction__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Lunch_Granted__c &gt;0, &quot;Lunch Fees - &quot;&amp;TEXT(Lunch_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Bus_Granted__c &gt;0, &quot;Bus Fees - &quot;&amp;TEXT(Bus_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Enrolment_Fees__c &gt;0, &quot;Enrolment Fees - &quot;&amp;TEXT(Enrolment_Fees__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp;

IF(  Other_Benefits__c  &lt;&gt;&quot;&quot;, &quot;Other Benefits - &quot;&amp; Other_Benefits__c ,&quot;&quot;)))</formula>
        <name>Update Child 4 Summary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_5_Name</fullName>
        <field>Child_5_Name__c</field>
        <formula>IF( Child_Order__c =5, Student_Full_Name__c , Grant_Application__r.Child_5_Name__c )</formula>
        <name>Update Child 5 Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Child_5_Summary</fullName>
        <field>Child_5_Grant_Summary__c</field>
        <formula>IF( Child_Order__c &lt;&gt;5, Grant_Application__r.Child_5_Grant_Summary__c , 

(IF( Tuition_Reduction__c &gt;0, &quot;Tuition Fees - &quot;&amp;TEXT(Tuition_Reduction__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Lunch_Granted__c &gt;0, &quot;Lunch Fees - &quot;&amp;TEXT(Lunch_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Bus_Granted__c &gt;0, &quot;Bus Fees - &quot;&amp;TEXT(Bus_Granted__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp; 

IF( Enrolment_Fees__c &gt;0, &quot;Enrolment Fees - &quot;&amp;TEXT(Enrolment_Fees__c*100)&amp;&quot;%&quot; &amp;BR(),&quot;&quot;)&amp;

IF(  Other_Benefits__c  &lt;&gt;&quot;&quot;, &quot;Other Benefits - &quot;&amp; Other_Benefits__c ,&quot;&quot;)))</formula>
        <name>Update Child 5 Summary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Grant_Application__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Grp%2FAdm - Change in Financial Aid Conditions %231</fullName>
        <actions>
            <name>Grp_Adm_Email_informing_of_Change_in_Financial_Aid_Conditions</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Triggers when an edit is made to one of the percentage fields in the student financial aid record and the decision of the financial aid grant equals &apos;Approved&apos;</description>
        <formula>AND ( Decision__c = &quot;Approved&quot; , OR ( ISCHANGED(Bus_Granted__c) , ISCHANGED(Enrolment_Fees__c), ISCHANGED(Lunch_Granted__c), ISCHANGED(Tuition_Reduction__c) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Change in Financial Aid Conditions %232</fullName>
        <actions>
            <name>Grp_Adm_Email_informing_of_Change_in_Financial_Aid_Decision</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Triggers when an edit is made to the decision field in the student financial aid record</description>
        <formula>OR ( Decision__c = &quot;Financial Aid Ended&quot;, Decision__c = &quot;Approved&quot; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Grant Application Child Info</fullName>
        <actions>
            <name>Update_Child_1_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_1_Summary</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_2_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_2_Summary</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_3_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_3_Summary</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_4_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_4_Summary</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_5_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Child_5_Summary</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Student_Grant__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Grant Application Order</fullName>
        <actions>
            <name>Create_Child_Order</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Student_Grant__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
