<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approval_Rejection_Notice</fullName>
        <description>Approval/Rejection Notice</description>
        <protected>false</protected>
        <recipients>
            <field>Submissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/Grant_Approval_Notice</template>
    </alerts>
    <alerts>
        <fullName>Fin_App_Recall_Notice</fullName>
        <description>Fin/App - Recall Notice</description>
        <protected>false</protected>
        <recipients>
            <field>First_Approver__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/Recall_Financial_Aid_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Grant_Application_Submitted</fullName>
        <description>Grant Application Submitted</description>
        <protected>false</protected>
        <recipients>
            <field>Submissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Grant_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Grant_Application_Submitted_Old</fullName>
        <ccEmails>ben.hails@britishschools.co.uk</ccEmails>
        <description>Grant Application Submitted (Old)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Grant_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Notify_Sys_Admin_about_Financial_Aid_for_a_Rainbow_school_parent</fullName>
        <description>Notify Sys. Admin about Financial Aid for a Rainbow school parent</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/Rainbow_Grant_Application_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Populate_First_Approver_Email</fullName>
        <field>First_Approver__c</field>
        <formula>IF(
   Is_Staff_Member_FA__c != TRUE,
   IF(
      Parent_Record__r.School__c = &quot;The British International School of Kuala Lumpur&quot;,
      &quot;janet.brock@britishschool.edu.my&quot;,
      IF(
         OR(
            Parent_Record__r.School__c = &quot;The British School Yangon&quot;,
            Parent_Record__r.School__c = &quot;Nord Anglia International School Manila&quot;
            ),
         &quot;shaun.williams@nordanglia.com&quot;,
         IF(
            OR(
               Parent_Record__r.School__c = &quot;The British School of Tashkent&quot;,
               Parent_Record__r.School__c = &quot;The International School of Moscow&quot;
               ),
            &quot;george.ghantous@nordanglia.com&quot;,
            IF(
               Parent_Record__r.School__c = &quot;The British School of Nanjing&quot;,
               &quot;mike.embley@nordanglia.com&quot;,
               IF(
                  Parent_Record__r.School__c = &quot;The British College of Brazil&quot;,
                  &quot;ann.mcphee@nordanglia.com&quot;,
                  &quot;ben.hails@britishschools.co.uk&quot;
                  )
               )
            )
         )
      ),
   IF(
      OR(
         Parent_Record__r.School__c = &quot;The British International School of Kuala Lumpur&quot;,
         Parent_Record__r.School__c = &quot;The British School Yangon&quot;,
         Parent_Record__r.School__c = &quot;Nord Anglia International School Manila&quot;
         ),
      &quot;annie.gale@nordanglia.com&quot;,
      IF(
         OR(
            Parent_Record__r.School__c = &quot;The British School of Tashkent&quot;,
            Parent_Record__r.School__c = &quot;The International School of Moscow&quot;
            ),
         &quot;lauriane.mounard@nordanglia.com&quot;,
         IF(
            Parent_Record__r.School__c = &quot;The British School of Nanjing&quot;,
            &quot;michelle.zhang@nordanglia.com&quot;,
            IF(
               Parent_Record__r.School__c = &quot;The British College of Brazil&quot;,
               &quot;sara.padilla@nordanglia.com&quot;,
               &quot;ben.hails@britishschools.co.uk&quot;
               )
            )
         )
      )
   )</formula>
        <name>Populate First Approver Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Submissions_Notification_Email</fullName>
        <field>Submissions_Notifications_Email__c</field>
        <formula>CASE(
     Parent_Record__r.School__c, 
     &quot;The British International School of Marbella&quot;, &quot;admissions@bsm.org.es&quot;, 
     &quot;The British School of Navarra&quot;, &quot;admissions@bsn.org.es&quot;, 
     &quot;The British International School of Kuala Lumpur&quot;, &quot;admissions@britishschool.edu.my&quot;,  
     &quot;The International School of Moscow&quot;, &quot;admissions@internationalschool.ru&quot;, 
     &quot;The British College of Brazil&quot;, &quot;admissions@britishcollegebrazil.org&quot;, 
     &quot;The British School of Brasilia&quot;, &quot;admissions@britishschoolbrasilia.org&quot;, 
     &quot;Nord Anglia International School Manila&quot;, &quot;admissions@kings.org.ph&quot;, 
     &quot;The British School of Nanjing&quot;, &quot;admissions@bsn.org.cn&quot;, 
     &quot;The British School of Tashkent&quot;, &quot;admissions@britishschool.uz&quot;, 
     &quot;The British School Yangon&quot;, &quot;admissions@britishschoolyangon.org&quot;, 
     &quot;The New York International School&quot;, &quot;admissions@nyis.org&quot;, 
     &quot;ben.hails@britishschools.co.uk&quot; 
     )</formula>
        <name>Populate Submissions Notification Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RT_to_Financial_Aid_Application</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Financial_Aid</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>RT to Financial Aid Application</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RT_to_Financial_Aid_Application_Locked</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Financial_Aid_Application_Locked</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>RT to Financial Aid Application Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RT_to_Financial_Aid_Review</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Financial_Aid_Review</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>RT to Financial Aid Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RT_to_Financial_Aid_Review_Locked</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Financial_Aid_Review_Locked</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>RT to Financial Aid Review Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_is_Locked_to_FALSE</fullName>
        <field>Record_is_Locked__c</field>
        <literalValue>0</literalValue>
        <name>Record is Locked to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_is_Locked_to_TRUE</fullName>
        <field>Record_is_Locked__c</field>
        <literalValue>1</literalValue>
        <name>Record is Locked to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Decision_Field_Approved</fullName>
        <field>Decision_Text__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Decision Field Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Decision_Field_Pending</fullName>
        <field>Decision_Text__c</field>
        <literalValue>Pending Approval/Rejection</literalValue>
        <name>Update Decision Field Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Decision_Field_Reject</fullName>
        <field>Decision_Text__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Decision Field Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Grant Application Submitted</fullName>
        <actions>
            <name>Grant_Application_Submitted</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Grant_Application__c.Submitted_Online__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Grant_Application__c.Is_New_Form__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Grant Application Submitted %28Old%29</fullName>
        <actions>
            <name>Grant_Application_Submitted_Old</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Grant_Application__c.Submitted_Online__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Grant_Application__c.Is_New_Form__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>160330: Temporary requirement to allow Ben to monitor any old form submissions and ensure the information is passed to Salesforce correctly</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate First Approver %26 Submissions Notification Email</fullName>
        <actions>
            <name>Populate_First_Approver_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Submissions_Notification_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Grant_Application__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
