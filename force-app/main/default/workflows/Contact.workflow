<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Calendar_View_Reminder_Email_Contact_Alternate</fullName>
        <description>Calendar View Reminder Email (Contact Alternate)</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Alternate_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Calendar_Check_Reminder_Contact</template>
    </alerts>
    <alerts>
        <fullName>Calendar_View_Reminder_Email_Contact_Main</fullName>
        <description>Calendar View Reminder Email (Contact Main)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Calendar_Check_Reminder_Contact</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Signup_Notification_Email_Alert_Contact</fullName>
        <description>Volunteer Signup Notification Email Alert - Contact</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Signup_Notification</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Signup_Thank_You_Email_Alert_Contact</fullName>
        <description>Volunteer Signup Thank You Email Alert - Contact</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Signup_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_Error_in_Portal_User_Creation_Contact</fullName>
        <description>Notify of Error in Portal User Creation</description>
        <protected>false</protected>
        <recipients>
            <field>IT_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/Sys_Adm_Portal_User_Creation_Error_Contact</template>
    </alerts>
    <alerts>
        <fullName>Resend_Kompanion_Login_Info_Email_Contact</fullName>
        <description>Resend Kompanion Login Info Email (Contact)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Parent_Portal_Emails/BSF_Parent_App_Resend_Login_Info_Email_Contact</template>
    </alerts>
    <alerts>
        <fullName>Send_Automated_Event_Notification_Email_Within_2_Weeks_Alternate</fullName>
        <description>Send Automated Event Notification Email (Within 2 Weeks Alternate)</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Alternate_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Date_Reminder_Email_Within_next_2_Weeks_Contact</template>
    </alerts>
    <alerts>
        <fullName>Send_Automated_Event_Notification_Email_Within_2_Weeks_Main</fullName>
        <description>Send Automated Event Notification Email (Within 2 Weeks Main)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Date_Reminder_Email_Within_next_2_Weeks_Contact</template>
    </alerts>
    <alerts>
        <fullName>Send_Kompanion_Welcome_Email_Contact</fullName>
        <ccEmails>parent.app@britishschools.co.uk</ccEmails>
        <description>Send Kompanion Welcome Email (Contact)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Parent_Portal_Emails/BSF_Parent_App_Welcome_Email_Contact</template>
    </alerts>
    <alerts>
        <fullName>Send_Portal_Login_Info_Contact</fullName>
        <description>Send Portal Login Info (Contact)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>support@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Parent_Portal_Emails/Parent_Portal_Login_Info_Contact</template>
    </alerts>
    <alerts>
        <fullName>Send_Portal_Welcome_Email_Contact</fullName>
        <description>Send Portal Welcome Email (Contact)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>support@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Parent_Portal_Emails/Parent_Portal_Welcome_Email_Contact</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_BCB</fullName>
        <description>Sets the contact owner to the BCB user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>carla.basile@britishcollegebrazil.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_BISM</fullName>
        <description>Sets the contact owner to the BISM user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_BSB</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_BSKL</fullName>
        <description>Sets the contact owner to the BSKL user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>admissions@britishschool.edu.my</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_BSNJ</fullName>
        <description>Sets the contact owner to the BSNJ user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_BSNV</fullName>
        <description>Sets the contact owner to the BSNV user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_BST</fullName>
        <description>Sets the contact owner to the BST user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>elena.savtsova@britishschool.uz</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_BSY</fullName>
        <field>OwnerId</field>
        <lookupValue>carolyn.bickerton@britishschoolyangon.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_ISM</fullName>
        <description>Sets the contact owner to the ISM user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>maria.ezhova@internationalschool.ru</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_NAISM</fullName>
        <field>OwnerId</field>
        <lookupValue>tj.torres@naismanila.edu.ph</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_NYIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Contact_Record_Owner_UIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Contact Record Owner (UIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BR_Parent_Survey_URL_Update</fullName>
        <field>Text_Parent_Survey_URL_BR__c</field>
        <formula>Parent_Survey_URL_BR__c</formula>
        <name>BR Parent Survey URL Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Resend_Portal_Login_to_False</fullName>
        <field>Resend_Portal_Login_Info__c</field>
        <literalValue>0</literalValue>
        <name>Change Resend Portal Login to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Portal_User_Created_Field_Contact</fullName>
        <field>Portal_User_Created__c</field>
        <literalValue>1</literalValue>
        <name>Check Portal User Created Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Alt_C_Code_PL_to_Alt_C_Code_Con</fullName>
        <field>Contact_Alternate_Phone_Country_Code__c</field>
        <formula>IF(
   ISBLANK(TEXT(Contact_Alternate_Phone_Country_CodePL__c)),
   &quot;&quot;,
   MID(
       TEXT(Contact_Alternate_Phone_Country_CodePL__c), 
       FIND(&quot;+&quot;, TEXT(Contact_Alternate_Phone_Country_CodePL__c))+1, 
       LEN(TEXT(Contact_Alternate_Phone_Country_CodePL__c))-(FIND(&quot;+&quot;, TEXT(Contact_Alternate_Phone_Country_CodePL__c))+1)
       )
   )</formula>
        <name>Copy Alt C/Code PL to Alt C/Code (Con)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_C_Code_to_SMS_C_Code_Contact</fullName>
        <field>xsms__Mobile_Phone_Country_Code__c</field>
        <formula>IF(
   ISBLANK(TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c)),
   &quot;&quot;,
   MID(
       TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c), 
       FIND(&quot;+&quot;, TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c))+1, 
       LEN(TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c))-(FIND(&quot;+&quot;, TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c))+1)
       )
   )</formula>
        <name>Copy C/Code to SMS C/Code (Contact)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Main_C_Code_PL_to_Main_C_Code_Con</fullName>
        <field>Contact_Mobile_Main_Ph_CountryC_Text__c</field>
        <formula>IF(
   ISBLANK(TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c)),
   &quot;&quot;,
   MID(
       TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c), 
       FIND(&quot;+&quot;, TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c))+1, 
       LEN(TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c))-(FIND(&quot;+&quot;, TEXT(Contact_Mobile_Main_Phone_Country_CodePL__c))+1)
       )
   )</formula>
        <name>Copy Main C/Code PL to Main C/Code (Con)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Create_Portal_User_Password_Contact</fullName>
        <field>Portal_User_Password__c</field>
        <formula>IF(
   NOT(CONTAINS(LOWER(Email), LOWER(LEFT(LastName, 1))&amp;LOWER(LEFT(FirstName, 1)))),
   UPPER(LEFT(LastName, 1))&amp;UPPER(LEFT(FirstName, 1))&amp;&quot;hub&quot;&amp;RIGHT(Staff_Member_Parent_Number_Formula__c, 4),
   &quot;ZZhub&quot;&amp;RIGHT(Staff_Member_Parent_Number_Formula__c, 4)
   )</formula>
        <name>Create Portal User Password</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EN_Parent_Survey_URL_Update</fullName>
        <field>Text_Parent_Survey_URL_EN__c</field>
        <formula>Parent_Survey_URL_EN__c</formula>
        <name>EN Parent Survey URL Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_Parent_Survey_URL_Update</fullName>
        <field>Text_Parent_Survey_URL_ES__c</field>
        <formula>Parent_Survey_URL_ES__c</formula>
        <name>ES Parent Survey URL Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Kompanion_User_P_word_Contact</fullName>
        <field>School_Kompanion_Password__c</field>
        <formula>/*IF(
   NOT(CONTAINS(LOWER(Email), LOWER(LEFT(LastName, 1))&amp;LOWER(LEFT(FirstName, 1)))),
   UPPER(LEFT(LastName, 1))&amp;UPPER(LEFT(FirstName, 1))&amp;&quot;app5624&quot;,
   &quot;ZZapp5624&quot;
   )*/

IF(
   NOT(CONTAINS(LOWER(Email), LOWER(LEFT(LastName, 1))&amp;LOWER(LEFT(FirstName, 1)))),
   UPPER(LEFT(LastName, 1))&amp;UPPER(LEFT(FirstName, 1))&amp;&quot;app&quot;,
   &quot;ZZapp&quot;
   )</formula>
        <name>Generate Kompanion User P/word (Contact)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Kompanion_Username_Contact</fullName>
        <field>School_Kompanion_Username__c</field>
        <formula>IF(
   ISBLANK(School_Kompanion_Username__c),
   Email,
   School_Kompanion_Username__c
   )</formula>
        <name>Generate Kompanion Username (Contact)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_IT_Notifications_Email_Contact</fullName>
        <field>IT_Notifications_Email__c</field>
        <formula>IF(SchoolText__c = &quot;The British International School of Kuala Lumpur&quot;, &quot;it-notifications@britishschool.edu.my&quot;, 

IF(SchoolText__c = &quot;The International School of Moscow&quot;, &quot;it-notifications@internationalschool.ru&quot;,

IF(SchoolText__c = &quot;The British School of Nanjing&quot;, &quot;it-notifications@bsn.org.cn&quot;,

IF(SchoolText__c = &quot;The British International School of Marbella&quot;, &quot;it-notifications@bsm.org.es&quot;,

IF(SchoolText__c = &quot;The British School of Navarra&quot;, &quot;it-notifications@bsn.org.es&quot;,

IF(SchoolText__c = &quot;The British School of Tashkent&quot;, &quot;it-notifications@britishschool.uz&quot;,

IF(SchoolText__c = &quot;Nord Anglia International School Manila&quot;, &quot;it-notifications@kings.org.ph&quot;,

IF(SchoolText__c = &quot;The British School Yangon&quot;, &quot;it-notifications@britishschoolyangon.org&quot;,

IF(SchoolText__c = &quot;The British College of Brazil&quot;, &quot;it-notifications@britishcollegebrazil.org&quot;,

IF(SchoolText__c = &quot;The British School of Brasilia&quot;, &quot;it-notifications@britishschoolbrasilia.org&quot;,

IF(SchoolText__c = &quot;The New York International School&quot;, &quot;it-notifications@nyis.org&quot;,

&quot;it-notifications@britishschools.co.uk&quot;)))))))))))</formula>
        <name>Populate IT Notifications Email(Contact)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_SchoolText_Field</fullName>
        <field>SchoolText__c</field>
        <formula>CSchool__c</formula>
        <name>Populate SchoolText Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Student_Academic_File_UID</fullName>
        <field>Only_1_Academic_File_Per_Student_Allowed__c</field>
        <formula>Admissions_File__r.Id</formula>
        <name>Populate Student Academic File UID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Username_must_be_unique_Con</fullName>
        <field>School_Kompanion_Username_UID__c</field>
        <formula>IF(
   ISBLANK(School_Kompanion_Username__c),
   &quot;&quot;,
   SchoolText__c&amp;&quot;-&quot;&amp;School_Kompanion_Username__c
   )</formula>
        <name>Populate &apos;Username must be unique!&apos;(Con)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RU_Parent_Survey_URL_Update</fullName>
        <field>Text_Parent_Survey_URL_RU__c</field>
        <formula>Parent_Survey_URL_RU__c</formula>
        <name>RU Parent Survey URL Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Related_Event_Trigger_Email_1_to_FALSE</fullName>
        <field>Related_Event_Trigger_First_Email_Send__c</field>
        <literalValue>0</literalValue>
        <name>Related Event Trigger Email 1 to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_App_Login_Info_Sent_to_TRUE_Con</fullName>
        <field>School_Kompanion_App_Login_Info_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Set App Login Info Sent to TRUE (Con)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SK_Resend_Login_Info_to_FALSE_Con</fullName>
        <field>School_Kompanion_Resend_Login_Info__c</field>
        <literalValue>0</literalValue>
        <name>Set SK Resend Login Info to FALSE (Con)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Send_SK_Outbound_to_FALSE_Contact</fullName>
        <field>Send_School_Kompanion_Outbound_Message__c</field>
        <literalValue>0</literalValue>
        <name>Set Send SK Outbound to FALSE (Contact)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Send_SK_Outbound_to_TRUE_Contact</fullName>
        <field>Send_School_Kompanion_Outbound_Message__c</field>
        <literalValue>1</literalValue>
        <name>Set Send SK Outbound to TRUE (Contact)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Time_Based_K_Send_to_FALSE_Contact</fullName>
        <field>Trigger_Time_Based_Send_to_Kompanion__c</field>
        <literalValue>0</literalValue>
        <name>Set Time-Based K Send to FALSE (Contact)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Contact_to_School_Kompanion</fullName>
        <apiVersion>36.0</apiVersion>
        <endpointUrl>https://schoolkompanion.co.uk/IncomingMessages/Salesforce.php</endpointUrl>
        <fields>Address_Accommodation_Type__c</fields>
        <fields>Address_Apartment_Condominium_or_Communi__c</fields>
        <fields>Address_Apartment_Unit_Number__c</fields>
        <fields>Address_City__c</fields>
        <fields>Address_Country__c</fields>
        <fields>Address_House_Building_Number__c</fields>
        <fields>Address_Line_2__c</fields>
        <fields>Address_State_Province__c</fields>
        <fields>Address_Street_Name__c</fields>
        <fields>Address_Zip_Postal_Code__c</fields>
        <fields>Alternate_Phone_Combined__c</fields>
        <fields>Contact_Alternate_Email__c</fields>
        <fields>Contact_Alternate_Phone_Country_CodePL__c</fields>
        <fields>Contact_Alternate_Phone__c</fields>
        <fields>Contact_Employer__c</fields>
        <fields>Contact_Employment_Sector__c</fields>
        <fields>Contact_Mobile_Main_Phone_Country_CodePL__c</fields>
        <fields>Contact_Nationality__c</fields>
        <fields>Contact_Relationship__c</fields>
        <fields>Contact_UID__c</fields>
        <fields>Email</fields>
        <fields>Family_Name__c</fields>
        <fields>Family_UID__c</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>Is_Primary_Contact__c</fields>
        <fields>LastName</fields>
        <fields>Main_Phone_Combined__c</fields>
        <fields>MobilePhone</fields>
        <fields>SK_App_Only_Experience__c</fields>
        <fields>Salutation</fields>
        <fields>School_Kompanion_Allow_App_Login__c</fields>
        <fields>School_Kompanion_Can_Edit_Address__c</fields>
        <fields>School_Kompanion_Password__c</fields>
        <fields>School_Kompanion_Realm__c</fields>
        <fields>School_Kompanion_Username__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>nae.migration@britishschools.co.uk</integrationUser>
        <name>Contact to School Kompanion</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Copy Alt C%2FCode PL to Alt C%2FCode %28Contact%29</fullName>
        <actions>
            <name>Copy_Alt_C_Code_PL_to_Alt_C_Code_Con</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(    ISNEW(),    ISCHANGED(Contact_Alternate_Phone_Country_CodePL__c)    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy C%2FCode to SMS C%2FCode %28Contact%29</fullName>
        <actions>
            <name>Copy_C_Code_to_SMS_C_Code_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(    ISNEW(),    ISCHANGED(Contact_Mobile_Main_Phone_Country_CodePL__c)    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Main C%2FCode PL to MainC%2FCode %28Contact%29</fullName>
        <actions>
            <name>Copy_Main_C_Code_PL_to_Main_C_Code_Con</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(  ISNEW(),  ISCHANGED(Contact_Mobile_Main_Phone_Country_CodePL__c)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GW_Volunteers__Volunteer Signup - Contact</fullName>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Notification_Email_Alert_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Thank_You_Email_Alert_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Thank_You_Sent_Contact</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>When a contact is updated or created from VolunteersSignup(FS) or VolunteersJobListing(FS), thank them and notify the volunteer manager.  Note if you are not using VolunteersSignup(FS), you can de-activate this rule to avoid multiple emails being sent.</description>
        <formula>GW_Volunteers__Volunteer_Last_Web_Signup_Date__c =  TODAY()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Generate Kompanion Login %28Contact%29</fullName>
        <actions>
            <name>Generate_Kompanion_User_P_word_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Generate_Kompanion_Username_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(     TEXT(School_Kompanion_Contact_Created__c) = &quot;Yes&quot;,      School_Kompanion_Allow_App_Login__c = TRUE,     OR(        NOT(ISBLANK(Email)),        NOT(ISBLANK(School_Kompanion_Username__c))        ),     OR(        ISBLANK(School_Kompanion_Username__c),        ISBLANK(School_Kompanion_Password__c)        )     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28BCB%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the BCB user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28BISM%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_BISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the BISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28BSB%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>BSB Record Owner</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the BSB user with the &quot;BSB Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28BSKL%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the BSKL user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28BSNJ%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the BSNJ user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28BSNV%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the BSNV user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28BST%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the BST user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28BSY%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the BSY user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28ISM%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the ISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28NAISM%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the NAISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28NYIS%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the NYIS user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Contact Owner Assignment %28UIS%29</fullName>
        <actions>
            <name>Assign_Contact_Record_Owner_UIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Students,Parents,Contacts,Enquiries)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>Ukraine International School</value>
        </criteriaItems>
        <description>Triggers a field update when a contact is created to assign the contact to the UIS user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate %27Username must be unique%21%27 %28Contact%29</fullName>
        <actions>
            <name>Populate_Username_must_be_unique_Con</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Populates the &apos;Contact.School_Kompanion_Username_UID__c&apos; field (which is a text field that only accepts unique values) with the school name and contact username to ensure that it is unique for that school</description>
        <formula>ISCHANGED(School_Kompanion_Username__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate IT Notifications Email %28Contact%29</fullName>
        <actions>
            <name>Populate_IT_Notifications_Email_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.IT_Notifications_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Parent Survey URL Text Fields</fullName>
        <actions>
            <name>BR_Parent_Survey_URL_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>EN_Parent_Survey_URL_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ES_Parent_Survey_URL_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_SchoolText_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>RU_Parent_Survey_URL_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>See notes on the Contact.Text_Parent_Survey_URL_EN__c for explanation of use</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Student Academic File UID</fullName>
        <actions>
            <name>Populate_Student_Academic_File_UID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     RecordType.DeveloperName = &quot;Student&quot;,     OR(        ISBLANK(Only_1_Academic_File_Per_Student_Allowed__c),        ISCHANGED(Admissions_File__c),        ISBLANK(Admissions_File__c)        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Resend Kompanion Login Info %28Contact%29</fullName>
        <actions>
            <name>Resend_Kompanion_Login_Info_Email_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Set_SK_Resend_Login_Info_to_FALSE_Con</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(     School_Kompanion_App_Login_Info_Sent__c = TRUE,     School_Kompanion_Resend_Login_Info__c = TRUE,     TEXT(School_Kompanion_Contact_Created__c) = &quot;Yes&quot;,     School_Kompanion_Allow_App_Login__c = TRUE,     NOT(ISBLANK(School_Kompanion_Username__c)),     NOT(ISBLANK(School_Kompanion_Password__c)),     NOT(ISBLANK(Email))     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Reset %26 Resend Portal Login Info %28Contact%29</fullName>
        <actions>
            <name>Send_Portal_Login_Info_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Change_Resend_Portal_Login_to_False</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Create_Portal_User_Password_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Resend_Portal_Login_Info__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Automated Event Notification Email %28Next 2 Weeks Event%29 %28Contact Alternate%29</fullName>
        <actions>
            <name>Send_Automated_Event_Notification_Email_Within_2_Weeks_Alternate</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Contact.Related_Event_Trigger_First_Email_Send__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Alternate_Email_Opt_Out__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Alternate_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends a date notification to the alternate email address of all related parents (contacts) when the event falls within the next 2 weeks</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Automated Event Notification Email %28Next 2 Weeks Event%29 %28Contact Main%29</fullName>
        <actions>
            <name>Send_Automated_Event_Notification_Email_Within_2_Weeks_Main</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Contact.Related_Event_Trigger_First_Email_Send__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.HasOptedOutOfEmail</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends a date notification to the main email address of all related parents (contacts) when the event falls within the next 2 weeks</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Calendar View Reminder Email %28Contact Alternate%29</fullName>
        <actions>
            <name>Calendar_View_Reminder_Email_Contact_Alternate</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.No_Calendar_View_Last_7_Days__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Send_Calendar_View_Reminder_Email__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Alternate_Email_Opt_Out__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Alternate_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Triggered via a batch job that runs every Sunday, sends a generic reminder email to the alternate email address of all parents (contacts) that have not viewed the school calendar in the last 7 days</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Calendar View Reminder Email %28Contact Main%29</fullName>
        <actions>
            <name>Calendar_View_Reminder_Email_Contact_Main</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.No_Calendar_View_Last_7_Days__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Send_Calendar_View_Reminder_Email__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.HasOptedOutOfEmail</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Triggered via a batch job that runs every Sunday, sends a generic reminder email to the main email address of all parents (contacts) that have not viewed the school calendar in the last 7 days</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Kompanion Welcome Email %28Contact%29</fullName>
        <actions>
            <name>Send_Kompanion_Welcome_Email_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Set_App_Login_Info_Sent_to_TRUE_Con</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Setting School_Kompanion_App_Login_Info_Sent__c to TRUE and School_Kompanion_Allow_App_Login__c to TRUE at the same time will allow a user to be generated without the email being sent to the contact.</description>
        <formula>AND(     TEXT(School_Kompanion_Contact_Created__c) = &quot;Yes&quot;,     School_Kompanion_App_Login_Info_Sent__c = FALSE,     School_Kompanion_Allow_App_Login__c = TRUE,     NOT(ISBLANK(School_Kompanion_Username__c)),     NOT(ISBLANK(School_Kompanion_Password__c)),     NOT(ISBLANK(Email))     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Portal Welcome Email %28Contact%29</fullName>
        <actions>
            <name>Send_Portal_Welcome_Email_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Check_Portal_User_Created_Field_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Create_Portal_User_Password_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2 AND 3)</booleanFilter>
        <criteriaItems>
            <field>Contact.User__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Portal_User_Created__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Additional Parent</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Send SK Outbound Message to FALSE %28Contact%29</fullName>
        <actions>
            <name>Set_Send_SK_Outbound_to_FALSE_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>Send_School_Kompanion_Outbound_Message__c = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Trigger Notification Email Send to FALSE %28Contact%29</fullName>
        <actions>
            <name>Related_Event_Trigger_Email_1_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Related_Event_Trigger_First_Email_Send__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Changes the value of the &apos;Related Event Trigger First Email Send&apos; field to false, immediately after it&apos;s changed to true, so that future emails can be sent.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Trigger School Kompanion Contact Update</fullName>
        <actions>
            <name>Contact_to_School_Kompanion</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <formula>AND(     OR(        SchoolText__c = &quot;The British School of Brasilia&quot;,        SchoolText__c = &quot;The British International School of Kuala Lumpur&quot;,        CONTAINS(TEXT(Test_Contact_Type__c), &quot;School Kompanion&quot;)        ),     Family_UID__c != null,     RecordType.DeveloperName = &quot;Additional_Parent&quot;,     OR(        ISNEW(),        ISCHANGED(Send_School_Kompanion_Outbound_Message__c),         ISCHANGED(Main_Parent_File__c),        ISCHANGED(Salutation),        ISCHANGED(LastName),        ISCHANGED(FirstName),        ISCHANGED(Email),        ISCHANGED(Contact_Alternate_Email__c),        ISCHANGED(Contact_Nationality__c),        ISCHANGED(Contact_Relationship__c),        ISCHANGED(Contact_Employment_Sector__c),        ISCHANGED(Contact_Employer__c),        ISCHANGED(Contact_Mobile_Main_Phone_Country_CodePL__c),        ISCHANGED(Contact_Alternate_Phone_Country_CodePL__c),        ISCHANGED(MobilePhone),        ISCHANGED(Contact_Alternate_Phone__c),        ISCHANGED(Address_Accommodation_Type__c),        ISCHANGED(Address_Apartment_Unit_Number__c),        ISCHANGED(Address_Apartment_Condominium_or_Communi__c),        ISCHANGED(Address_House_Building_Number__c),        ISCHANGED(Address_Street_Name__c),        ISCHANGED(Address_Line_2__c),        ISCHANGED(Address_City__c),        ISCHANGED(Address_State_Province__c),        ISCHANGED(Address_Zip_Postal_Code__c),        ISCHANGED(Address_Country__c),        ISCHANGED(SK_App_Only_Experience__c),        ISCHANGED(Allow_App_Login__c),        AND(            School_Kompanion_Allow_App_Login__c = TRUE,            OR(               AND(                   ISCHANGED(School_Kompanion_Username__c),                   NOT(ISBLANK(School_Kompanion_Username__c))                   ),               AND(                   ISCHANGED(School_Kompanion_Password__c),                   NOT(ISBLANK(School_Kompanion_Password__c))                   )               )            ),        AND(            School_Kompanion_Allow_App_Login__c = FALSE,            OR(               ISCHANGED(School_Kompanion_Username__c),               ISCHANGED(School_Kompanion_Password__c)                  )            )        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Trigger Time-Based Send to Kompanion %28Contact%29</fullName>
        <active>false</active>
        <formula>AND(  RecordType.DeveloperName = &quot;Additional_Parent&quot;,  Trigger_Time_Based_Send_to_Kompanion__c = TRUE  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Set_Send_SK_Outbound_to_TRUE_Contact</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Set_Time_Based_K_Send_to_FALSE_Contact</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>User Creation Error %28Contact%29</fullName>
        <actions>
            <name>Notify_of_Error_in_Portal_User_Creation_Contact</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(      ISCHANGED(Contact_Portal_User_Creation_Error__c),      Contact_Portal_User_Creation_Error__c = TRUE      )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>GW_Volunteers__Volunteer_Signup_Thank_You_Sent_Contact</fullName>
        <assignedToType>owner</assignedToType>
        <description>An automatic thank you email has been sent to the contact for signing up to be a volunteer.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Volunteer Signup Thank You Sent - Contact</subject>
    </tasks>
</Workflow>
