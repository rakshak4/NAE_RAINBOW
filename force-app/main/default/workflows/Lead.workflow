<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>BISM_Email_Informing_of_Enquiry_Created</fullName>
        <description>BISM - Email Informing of Enquiry Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Email_Informing_of_Enquiry_Created</template>
    </alerts>
    <alerts>
        <fullName>BSNV_Email_Informing_of_Enquiry_Created</fullName>
        <description>BSNV - Email Informing of Enquiry Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Email_Informing_of_Enquiry_Created</template>
    </alerts>
    <alerts>
        <fullName>Enquiry_Child_1_Assessment_Fee_Paid</fullName>
        <description>Enquiry Child 1 Assessment Fee Paid</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_informing_of_Assessment_Fee_Paid_Enquiry_Child_1</template>
    </alerts>
    <alerts>
        <fullName>Enquiry_Child_2_Assessment_Fee_Paid</fullName>
        <description>Enquiry Child 2 Assessment Fee Paid</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_informing_of_Assessment_Fee_Paid_Enquiry_Child_2</template>
    </alerts>
    <alerts>
        <fullName>Enquiry_Child_3_Assessment_Fee_Paid</fullName>
        <description>Enquiry Child 3 Assessment Fee Paid</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_informing_of_Assessment_Fee_Paid_Enquiry_Child_3</template>
    </alerts>
    <alerts>
        <fullName>Enquiry_Child_4_Assessment_Fee_Paid</fullName>
        <description>Enquiry Child 4 Assessment Fee Paid</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_informing_of_Assessment_Fee_Paid_Enquiry_Child_4</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Signup_Notification_Email_Alert_Lead</fullName>
        <description>Volunteer Signup Notification Email Alert - Lead</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Signup_Notification</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Signup_Thank_You_Email_Alert_Lead</fullName>
        <description>Volunteer Signup Thank You Email Alert - Lead</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Signup_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>Notify_Sys_Admin_about_Empty_School_Value_on_Submission</fullName>
        <description>Notify Sys. Admin about Empty School Value on Submission</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Notification_about_Blank_School_Value</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Auto_Response_BCB</fullName>
        <description>Send Admissions Enquiry Auto-Response (BCB)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>admissions@britishcollegebrazil.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Auto_Responses/Status_Admissions_Enq_Auto_Response_EN</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Auto_Response_BSKL</fullName>
        <description>Send Admissions Enquiry Auto-Response (BSKL)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>admissions@britishschool.edu.my</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Auto_Responses/Status_Admissions_Enq_Auto_Resp_BST_KL</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Auto_Response_BSNJ</fullName>
        <description>Send Admissions Enquiry Auto-Response (BSNJ)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>admissions@bsn.org.cn</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Auto_Responses/Status_Admissions_Enq_Auto_Response_EN</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Auto_Response_BST</fullName>
        <description>Send Admissions Enquiry Auto-Response (BST)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>admissions@britishschool.uz</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Auto_Responses/Status_Admissions_Enq_Auto_Resp_BST_KL</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Auto_Response_BSY</fullName>
        <description>Send Admissions Enquiry Auto-Response (BSY)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>admissions@britishschoolyangon.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Auto_Responses/Status_Admissions_Enq_Auto_Res_BSY_NAISM</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Auto_Response_ISM</fullName>
        <description>Send Admissions Enquiry Auto-Response (ISM)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>admissions@internationalschool.ru</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Auto_Responses/Status_Admissions_Enq_Auto_Response_EN</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Auto_Response_NAISM</fullName>
        <description>Send Admissions Enquiry Auto-Response (NAISM)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>admissions@naismanila.edu.ph</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Auto_Responses/Status_Admissions_Enq_Auto_Res_BSY_NAISM</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Notification_BCB_CF_General</fullName>
        <ccEmails>admissions-bcb@britishcollegebrazil.org</ccEmails>
        <description>Send Admissions Enquiry Notification (BCB - CF &amp; General)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Status_Admissions_Enquiry_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Notification_BCB_CJ</fullName>
        <ccEmails>admissions-bcb@britishcollegebrazil.org</ccEmails>
        <description>Send Admissions Enquiry Notification (BCB - CJ)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Status_Admissions_Enquiry_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Notification_BSKL</fullName>
        <ccEmails>admissions@britishschool.edu.my</ccEmails>
        <description>Send Admissions Enquiry Notification (BSKL)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Status_Admissions_Enquiry_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Notification_BSNJ</fullName>
        <ccEmails>admissions@bsn.org.cn</ccEmails>
        <description>Send Admissions Enquiry Notification (BSNJ)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Status_Admissions_Enquiry_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Notification_BST</fullName>
        <ccEmails>admissions@britishschool.uz</ccEmails>
        <description>Send Admissions Enquiry Notification (BST)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Status_Admissions_Enquiry_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Notification_BSY</fullName>
        <ccEmails>admissions@britishschoolyangon.org</ccEmails>
        <description>Send Admissions Enquiry Notification (BSY)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Status_Admissions_Enquiry_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Notification_ISM</fullName>
        <ccEmails>admissions@internationalschool.ru</ccEmails>
        <description>Send Admissions Enquiry Notification (ISM)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Status_Admissions_Enquiry_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Admissions_Enquiry_Notification_NAISM</fullName>
        <ccEmails>admissions@naismanila.edu.ph</ccEmails>
        <ccEmails>admissions@kings.org.ph</ccEmails>
        <description>Send Admissions Enquiry Notification (NAISM)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Status_Admissions_Enquiry_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_BCB</fullName>
        <ccEmails>admissions@britishcollegebrazil.org</ccEmails>
        <description>Send Online Application Admissions Notification (BCB)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_BISM</fullName>
        <ccEmails>admissions@bsm.org.es</ccEmails>
        <description>Send Online Application Admissions Notification (BISM)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_BSB</fullName>
        <ccEmails>admissions@britishschoolbrasilia.org</ccEmails>
        <description>Send Online Application Admissions Notification (BSB)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_BSKL</fullName>
        <ccEmails>admissions@britishschool.edu.my</ccEmails>
        <description>Send Online Application Admissions Notification (BSKL)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_BSNJ</fullName>
        <ccEmails>admissions@bsn.org.cn</ccEmails>
        <description>Send Online Application Admissions Notification (BSNJ)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_BSNV</fullName>
        <ccEmails>admissions@bsn.org.es</ccEmails>
        <description>Send Online Application Admissions Notification (BSNV)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_BST</fullName>
        <ccEmails>admissions@britishschool.uz</ccEmails>
        <description>Send Online Application Admissions Notification (BST)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_BSY</fullName>
        <ccEmails>admissions@britishschoolyangon.org</ccEmails>
        <description>Send Online Application Admissions Notification (BSY)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_ISM</fullName>
        <ccEmails>admissions@internationalschool.ru</ccEmails>
        <description>Send Online Application Admissions Notification (ISM)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_NAISM</fullName>
        <ccEmails>admissions@kings.org.ph</ccEmails>
        <description>Send Online Application Admissions Notification (NAISM)</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Admissions_Notification_NYIS</fullName>
        <ccEmails>admissions@nyis.org</ccEmails>
        <description>Send Online Application Admissions Notification (NYIS)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_Online_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BCB_English</fullName>
        <description>Send Online Application Auto-Response (BCB) (English)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BCB_Portuguese</fullName>
        <description>Send Online Application Auto-Response (BCB) (Portuguese)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/BR_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BISM_English</fullName>
        <description>Send Online Application Auto-Response (BISM) (English)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BISM_Spanish</fullName>
        <description>Send Online Application Auto-Response (BISM) (Spanish)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/ES_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BSB_English</fullName>
        <description>Send Online Application Auto-Response (BSB) (English)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BSB_Portuguese</fullName>
        <description>Send Online Application Auto-Response (BSB) (Portuguese)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/BR_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BSKL</fullName>
        <description>Send Online Application Auto-Response (BSKL)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BSNJ</fullName>
        <description>Send Online Application Auto-Response (BSNJ)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BSNV_English</fullName>
        <description>Send Online Application Auto-Response (BSNV) (English)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BSNV_Spanish</fullName>
        <description>Send Online Application Auto-Response (BSNV) (Spanish)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/ES_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BST_English</fullName>
        <description>Send Online Application Auto-Response (BST) (English)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BST_Russian</fullName>
        <description>Send Online Application Auto-Response (BST) (Russian)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/RU_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_BSY</fullName>
        <description>Send Online Application Auto-Response (BSY)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_ISM</fullName>
        <description>Send Online Application Auto-Response (ISM)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_KSM</fullName>
        <description>Send Online Application Auto-Response (KSM)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_Generic</template>
    </alerts>
    <alerts>
        <fullName>Send_Online_Application_Auto_Response_NYIS</fullName>
        <description>Send Online Application Auto-Response (NYIS)</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Online_Application_First_Response_Headed_New_York</template>
    </alerts>
    <fieldUpdates>
        <fullName>Application_Date_Update</fullName>
        <description>Update application date to today</description>
        <field>Application_Date__c</field>
        <formula>TODAY()</formula>
        <name>Application Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_BCB</fullName>
        <description>Sets the enquiry owner to the BCB user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>carla.basile@britishcollegebrazil.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_BISM</fullName>
        <description>Sets the enquiry owner to the BISM user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_BSB</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_BSKL</fullName>
        <description>Sets the enquiry owner to the BSKL user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>admissions@britishschool.edu.my</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_BSNJ</fullName>
        <description>Sets the enquiry owner to the BSNJ user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_BSNV</fullName>
        <description>Sets the enquiry owner to the BSNV user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_BST</fullName>
        <field>OwnerId</field>
        <lookupValue>elena.savtsova@britishschool.uz</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_BSY</fullName>
        <field>OwnerId</field>
        <lookupValue>carolyn.bickerton@britishschoolyangon.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_ISM</fullName>
        <description>Sets the enquiry owner to the ISM user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>maria.ezhova@internationalschool.ru</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_NAISM</fullName>
        <field>OwnerId</field>
        <lookupValue>tj.torres@naismanila.edu.ph</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Enquiry_Record_Owner_NYIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Enquiry Record Owner (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Quick_to_Full_Enquiry</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Full_Enquiry</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Quick to Full Enquiry</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Quick_to_Full_NAE_Enquiry</fullName>
        <field>RecordTypeId</field>
        <lookupValue>NAE_Admissions_Enquiry</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Quick to Full NAE Enquiry</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Child_1_DOB</fullName>
        <description>Populates child 1 DOB field with combination of day/month/year as submitted via website</description>
        <field>DateOfBirthFirstChild__c</field>
        <formula>DATE(Child_1_DOB_Year__c, Child_1_DOB_Month__c, Child_1_DOB_Day__c)</formula>
        <name>Child 1 DOB</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Child_2_DOB</fullName>
        <description>Populates child 2 DOB field with combination of day/month/year as submitted via website</description>
        <field>DateOfBirthSecondChild__c</field>
        <formula>DATE(Child_2_DOB_Year__c, Child_2_DOB_Month__c, Child_2_DOB_Day__c)</formula>
        <name>Child 2 DOB</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Child_3_DOB</fullName>
        <description>Populates child 3 DOB field with combination of day/month/year as submitted via website</description>
        <field>DateOfBirthThirdChild__c</field>
        <formula>DATE(Child_3_DOB_Year__c, Child_3_DOB_Month__c, Child_3_DOB_Day__c)</formula>
        <name>Child 3 DOB</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Child_4_DOB</fullName>
        <description>Populates child 4 DOB field with combination of day/month/year as submitted via website</description>
        <field>DateOfBirthFourthChild__c</field>
        <formula>DATE(Child_4_DOB_Year__c, Child_4_DOB_Month__c, Child_4_DOB_Day__c)</formula>
        <name>Child 4 DOB</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Company_to_Blank</fullName>
        <field>Company</field>
        <name>Lead Company to Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Enquiry_Date_for_KPIs</fullName>
        <field>Enquiry_Date_for_KPIs__c</field>
        <formula>TODAY()</formula>
        <name>Populate Enquiry Date (for KPIs)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Preferred_Language_Source</fullName>
        <field>Preferred_Language_Defined_by_Web_Form__c</field>
        <literalValue>Web Form</literalValue>
        <name>Populate Preferred Language Source</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Code_Field_BCB</fullName>
        <field>School_Code__c</field>
        <literalValue>BCB</literalValue>
        <name>Populate School Code Field (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Code_Field_BSKL</fullName>
        <field>School_Code__c</field>
        <literalValue>BKL</literalValue>
        <name>Populate School Code Field (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Code_Field_BSNJ</fullName>
        <field>School_Code__c</field>
        <literalValue>BNJ</literalValue>
        <name>Populate School Code Field (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Code_Field_BST</fullName>
        <field>School_Code__c</field>
        <literalValue>BST</literalValue>
        <name>Populate School Code Field (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Code_Field_BSY</fullName>
        <field>School_Code__c</field>
        <literalValue>BSG</literalValue>
        <name>Populate School Code Field (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Code_Field_ISM</fullName>
        <field>School_Code__c</field>
        <literalValue>ISM</literalValue>
        <name>Populate School Code Field (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Code_Field_NAISM</fullName>
        <field>School_Code__c</field>
        <literalValue>KSM</literalValue>
        <name>Populate School Code Field (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_BCB</fullName>
        <field>School__c</field>
        <literalValue>The British College of Brazil</literalValue>
        <name>Populate School Name Field (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_BISM</fullName>
        <field>School__c</field>
        <literalValue>The British International School of Marbella</literalValue>
        <name>Populate School Name Field (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_BSB</fullName>
        <field>School__c</field>
        <literalValue>The British School of Brasilia</literalValue>
        <name>Populate School Name Field (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_BSKL</fullName>
        <field>School__c</field>
        <literalValue>The British International School of Kuala Lumpur</literalValue>
        <name>Populate School Name Field (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_BSNJ</fullName>
        <field>School__c</field>
        <literalValue>The British School of Nanjing</literalValue>
        <name>Populate School Name Field (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_BSNV</fullName>
        <field>School__c</field>
        <literalValue>The British School of Navarra</literalValue>
        <name>Populate School Name Field (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_BST</fullName>
        <field>School__c</field>
        <literalValue>The British School of Tashkent</literalValue>
        <name>Populate School Name Field (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_BSY</fullName>
        <field>School__c</field>
        <literalValue>The British School Yangon</literalValue>
        <name>Populate School Name Field (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_ISM</fullName>
        <field>School__c</field>
        <literalValue>The International School of Moscow</literalValue>
        <name>Populate School Name Field (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_NAISM</fullName>
        <field>School__c</field>
        <literalValue>Nord Anglia International School Manila</literalValue>
        <name>Populate School Name Field (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_School_Name_Field_NYIS</fullName>
        <field>School__c</field>
        <literalValue>The New York International School</literalValue>
        <name>Populate School Name Field (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Starting_Date_from_Expected</fullName>
        <field>Starting_Date__c</field>
        <formula>IF(
   OR(
      TEXT(ExpectedStartMonth__c) = &quot;Not sure&quot;,
      ISBLANK(TEXT(ExpectedStartMonth__c)),
      TEXT(ExpectedStartYear__c) = &quot;Not sure&quot;,
      ISBLANK(TEXT(ExpectedStartYear__c))
      ),
   null,
   DATE(
        VALUE(TEXT(ExpectedStartYear__c)), 
        CASE(
             ExpectedStartMonth__c,
             &quot;January&quot;, 1,
             &quot;February&quot;, 2,
             &quot;March&quot;, 3,
             &quot;April&quot;, 4,
             &quot;May&quot;, 5,
             &quot;June&quot;, 6,
             &quot;July&quot;, 7,
             &quot;August&quot;, 8,
             &quot;September&quot;, 9,
             &quot;October&quot;, 10,
             &quot;November&quot;, 11,
             &quot;December&quot;, 12,
             1
             ),
        IF(
           OR(
              ISBLANK(TEXT(ExpectedStartDay__c)),
              TEXT(ExpectedStartDay__c) = &quot;Not sure&quot;
              ),
           1,
           VALUE(TEXT(ExpectedStartDay__c))
           )
        )
   )</formula>
        <name>Populate Starting Date from Expected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Enquiry_Status_to_Qualified</fullName>
        <field>Status</field>
        <literalValue>Qualified</literalValue>
        <name>Set Enquiry Status to Qualified</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Primary_Contact_to_First_Parent</fullName>
        <field>Primary_Contact__c</field>
        <literalValue>First Parent</literalValue>
        <name>Set Primary Contact to First Parent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sync_Primary_Email</fullName>
        <field>Email</field>
        <formula>IF(
   AND(
       TEXT(Primary_Contact__c) = &quot;First Parent&quot;, 
       Main_Email__c != &quot;&quot;
       ), 
   Main_Email__c, 
   IF(
      AND(
          TEXT(Primary_Contact__c) = &quot;First Parent&quot;, 
          Alternate_Email__c != &quot;&quot;, 
          Main_Email__c = &quot;&quot;
          ), 
      Alternate_Email__c, 
      IF(
         AND(
             TEXT(Primary_Contact__c) = &quot;Second Parent&quot;, 
             Parent_2_Email_1__c != &quot;&quot;
             ), 
         Parent_2_Email_1__c, 
         IF(
            AND(
                TEXT(Primary_Contact__c) = &quot;Second Parent&quot;, 
                Parent_2_Email_2__c != &quot;&quot;, 
                Parent_2_Email_1__c = &quot;&quot;
                ), 
            Parent_2_Email_2__c,
            &quot;&quot;
            )
         )
      )
   )</formula>
        <name>Sync Primary Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sync_SMS_Country_Code</fullName>
        <field>xsms__Mobile_Phone_Country_Code__c</field>
        <formula>IF(
   AND(
       TEXT(Primary_Contact__c) = &quot;First Parent&quot;,  
       TEXT(Mobile_Main_Phone_Country_CodePL__c) != &quot;&quot;, 
       Phone != &quot;&quot;
       ), 
   MID(
       TEXT(Mobile_Main_Phone_Country_CodePL__c), 
       FIND(&quot;+&quot;, TEXT(Mobile_Main_Phone_Country_CodePL__c))+1, 
       LEN(TEXT(Mobile_Main_Phone_Country_CodePL__c))-(FIND(&quot;+&quot;, TEXT(Mobile_Main_Phone_Country_CodePL__c))+1)
       ),
   IF(
      AND(
          TEXT(Primary_Contact__c) = &quot;First Parent&quot;,  
          TEXT(Alternate_Phone_Country_CodePL__c) != &quot;&quot;, 
          Parent_1_Phone_2__c != &quot;&quot;,
          OR(
             TEXT(Mobile_Main_Phone_Country_CodePL__c) = &quot;&quot;, 
             Phone = &quot;&quot;
             )
          ), 
      MID(
          TEXT(Alternate_Phone_Country_CodePL__c), 
          FIND(&quot;+&quot;, TEXT(Alternate_Phone_Country_CodePL__c))+1, 
          LEN(TEXT(Alternate_Phone_Country_CodePL__c))-(FIND(&quot;+&quot;, TEXT(Alternate_Phone_Country_CodePL__c))+1)
          ),
      IF(
         AND(
             TEXT(Primary_Contact__c) = &quot;Second Parent&quot;,  
             TEXT(Mobile_Main_Phone_Country_CodePL_P2__c) != &quot;&quot;, 
             Parent_2_Phone_1__c != &quot;&quot;
             ), 
         MID(
             TEXT(Mobile_Main_Phone_Country_CodePL_P2__c), 
             FIND(&quot;+&quot;, TEXT(Mobile_Main_Phone_Country_CodePL_P2__c))+1, 
             LEN(TEXT(Mobile_Main_Phone_Country_CodePL_P2__c))-(FIND(&quot;+&quot;, TEXT(Mobile_Main_Phone_Country_CodePL_P2__c))+1)
             ),
         IF(
            AND(
                TEXT(Primary_Contact__c) = &quot;Second Parent&quot;,   
                TEXT(Alternate_Phone_Country_CodePL_P2__c) != &quot;&quot;, 
                Parent_2_Phone_2__c != &quot;&quot;, 
                OR(
                   TEXT(Mobile_Main_Phone_Country_CodePL_P2__c) = &quot;&quot;, 
                   Parent_2_Phone_1__c = &quot;&quot;
                   )
                ), 
            MID(
                TEXT(Alternate_Phone_Country_CodePL_P2__c), 
                FIND(&quot;+&quot;, TEXT(Alternate_Phone_Country_CodePL_P2__c))+1, 
                LEN(TEXT(Alternate_Phone_Country_CodePL_P2__c))-(FIND(&quot;+&quot;, TEXT(Alternate_Phone_Country_CodePL_P2__c))+1)
                ),
            &quot;&quot;
            )
         )
      )
   )</formula>
        <name>Sync SMS Country Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sync_SMS_Phone_Number</fullName>
        <field>MobilePhone</field>
        <formula>IF(
   AND(
       TEXT(Primary_Contact__c) = &quot;First Parent&quot;,  
       TEXT(Mobile_Main_Phone_Country_CodePL__c) != &quot;&quot;, 
       Phone != &quot;&quot;
       ), 
   Phone, 
   IF(
      AND(
          TEXT(Primary_Contact__c) = &quot;First Parent&quot;,  
          TEXT(Alternate_Phone_Country_CodePL__c) != &quot;&quot;, 
          Parent_1_Phone_2__c != &quot;&quot;, 
          OR(
             TEXT(Mobile_Main_Phone_Country_CodePL__c) = &quot;&quot;, 
             Phone = &quot;&quot;
             )
          ), 
      Parent_1_Phone_2__c, 
      IF(
         AND(
             TEXT(Primary_Contact__c) = &quot;Second Parent&quot;,   
             TEXT(Mobile_Main_Phone_Country_CodePL_P2__c) != &quot;&quot;, 
             Parent_2_Phone_1__c != &quot;&quot;
             ),
         Parent_2_Phone_1__c, 
         IF(
            AND(
                TEXT(Primary_Contact__c) = &quot;Second Parent&quot;,  
                TEXT(Alternate_Phone_Country_CodePL_P2__c) != &quot;&quot;, 
                Parent_2_Phone_2__c != &quot;&quot;, 
                OR(
                   TEXT(Mobile_Main_Phone_Country_CodePL_P2__c) = &quot;&quot;, 
                   Parent_2_Phone_1__c = &quot;&quot;
                   )
                ), 
            Parent_2_Phone_2__c,
            &quot;&quot;
            )
         )
      )
   )</formula>
        <name>Sync SMS Phone Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Online_App_T_C_s_to_Accepted</fullName>
        <field>Online_App_T_Cs_Accepted__c</field>
        <literalValue>1</literalValue>
        <name>Update Online App T&amp;C&apos;s to Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Application Date</fullName>
        <actions>
            <name>Application_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <description>Triggers when the website a new online application is submitted or the &apos;Enquiry Type&apos; field is manually changed to &apos;Online Application&apos; in order to record the correct application date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BISM Enquiry Created</fullName>
        <actions>
            <name>BISM_Email_Informing_of_Enquiry_Created</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>emma.watkins@bsm.org.es</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>directors@britishschools.co.uk</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Child 1 App%2E Fee Paid</fullName>
        <actions>
            <name>Enquiry_Child_1_Assessment_Fee_Paid</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Child_1_Application_Fee_Paid__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Sends an email to the BSKL admissions team informing them that the application fee of the first child is marked as paid in the enquiry record</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Child 2 App%2E Fee Paid</fullName>
        <actions>
            <name>Enquiry_Child_2_Assessment_Fee_Paid</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Child_2_Application_Fee_Paid__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Sends an email to the BSKL admissions team informing them that the application fee of the second child is marked as paid in the enquiry record</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Child 3 App%2E Fee Paid</fullName>
        <actions>
            <name>Enquiry_Child_3_Assessment_Fee_Paid</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Child_3_Application_Fee_Paid__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Sends an email to the BSKL admissions team informing them that the application fee of the third child is marked as paid in the enquiry record</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Child 4 App%2E Fee Paid</fullName>
        <actions>
            <name>Enquiry_Child_4_Assessment_Fee_Paid</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Child_4_Application_Fee_Paid__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Sends an email to the BSKL admissions team informing them that the application fee of the fourth child is marked as paid in the enquiry record</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSNV Enquiry Created</fullName>
        <actions>
            <name>BSNV_Email_Informing_of_Enquiry_Created</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>laura.gonzalez@bsn.org.es</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>directors@britishschools.co.uk</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change NAE Admissions Enquiry to Full Enquiry</fullName>
        <actions>
            <name>Change_Quick_to_Full_Enquiry</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>NAE Admissions Enquiry</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Quick to Full NAE Enquiry</fullName>
        <actions>
            <name>Change_Quick_to_Full_NAE_Enquiry</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Enquiry_Status_to_Qualified</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Quick Enquiry</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>notEqual</operation>
            <value>Online Application</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check %27Online App T%26Cs Accepted%27</fullName>
        <actions>
            <name>Update_Online_App_T_C_s_to_Accepted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <description>Rule is triggered when a new online application is received via the website</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Clear Company Field on New NAE Enquiry</fullName>
        <actions>
            <name>Lead_Company_to_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Company</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GW_Volunteers__Volunteer Signup - Lead</fullName>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Notification_Email_Alert_Lead</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Thank_You_Email_Alert_Lead</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Thank_You_Sent_Lead</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.GW_Volunteers__Volunteer_Status__c</field>
            <operation>equals</operation>
            <value>New Sign Up</value>
        </criteriaItems>
        <description>When a new lead is created from a volunteer signup, send a thank you and notify the volunteer manager</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28BCB%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Code_Field_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the BCB user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <formula>OR(
   TEXT(School_Drupal_UID__c) = &quot;saopaulo1&quot;,
   TEXT(School_Code__c) = &quot;BCB&quot;,
   AND(
       ISNEW(),
       TEXT($User.School__c) = &quot;The British College of Brazil&quot;
       )
   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28BISM%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_BISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_BISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>marbella1</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the BISM user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28BSB%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>brasilia1</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the BSB user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28BSKL%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Code_Field_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the BSKL user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <formula>OR(
   TEXT(School_Drupal_UID__c) = &quot;kualalumpur1&quot;,
   TEXT(School_Code__c) = &quot;BKL&quot;,
   AND(
       ISNEW(),
       TEXT($User.School__c) = &quot;The British International School of Kuala Lumpur&quot;
       )
   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28BSNJ%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Code_Field_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the BSNJ user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <formula>OR(
   TEXT(School_Drupal_UID__c) = &quot;nanjing1&quot;,
   TEXT(School_Code__c) = &quot;BNJ&quot;,
   AND(
       ISNEW(),
       TEXT($User.School__c) = &quot;The British School of Nanjing&quot;
       )
   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28BSNV%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>navarra1</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the BSNV user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28BST%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Code_Field_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the BST user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <formula>OR(
   TEXT(School_Drupal_UID__c) = &quot;tashkent1&quot;,
   TEXT(School_Code__c) = &quot;BST&quot;,
   AND(
       ISNEW(),
       TEXT($User.School__c) = &quot;The British School of Tashkent&quot;
       )
   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28BSY%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Code_Field_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the BSY user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <formula>OR(
   TEXT(School_Drupal_UID__c) = &quot;yangon1&quot;,
   TEXT(School_Code__c) = &quot;BSG&quot;,
   AND(
       ISNEW(),
       TEXT($User.School__c) = &quot;The British School Yangon&quot;
       )
   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28ISM%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Code_Field_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the ISM user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <formula>OR(
   TEXT(School_Drupal_UID__c) = &quot;moscow1&quot;,
   TEXT(School_Code__c) = &quot;ISM&quot;,
   AND(
       ISNEW(),
       TEXT($User.School__c) = &quot;The International School of Moscow&quot;
       )
   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28NAISM%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Code_Field_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the NAISM user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <formula>OR(
   TEXT(School_Drupal_UID__c) = &quot;manila1&quot;,
   TEXT(School_Code__c) = &quot;KSM&quot;,
   AND(
       ISNEW(),
       TEXT($User.School__c) = &quot;Nord Anglia International School Manila&quot;
       )
   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28NYIS%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>newyork1</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <description>Triggers field updates when an enquiry is created to assign the enquiry to the NYIS user with the &quot;Record Owner&quot; role and set the value in the &apos;School&apos; field.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Enquiry Owner%2FSchool Assignment %28TEMP%29</fullName>
        <actions>
            <name>Assign_Enquiry_Record_Owner_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Code_Field_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_School_Name_Field_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>A temp rule only used during the school name change procedure</description>
        <formula>OR(
   TEXT(School_Drupal_UID__c) = &quot;manila1&quot;,
   TEXT(School_Code__c) = &quot;KSM&quot;,
   AND(
       ISNEW(),
       OR(
          TEXT($User.School__c) = &quot;The King&apos;s School Manila&quot;,
          TEXT($User.School__c) = &quot;Nord Anglia International School Manila&quot;
          )
       )
   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify Sys%2EAdmin - School Value is Missing on Submission</fullName>
        <actions>
            <name>Notify_Sys_Admin_about_Empty_School_Value_on_Submission</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Applying__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>bsf1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Child 1 DOB</fullName>
        <actions>
            <name>Child_1_DOB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.FirstNameFirstChild__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Child_1_DOB_Day__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Child 2 DOB</fullName>
        <actions>
            <name>Child_2_DOB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.FirstNameSecondChild__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Child_2_DOB_Day__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Child 3 DOB</fullName>
        <actions>
            <name>Child_3_DOB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.FirstNameThirdChild__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Child_3_DOB_Day__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Child 4 DOB</fullName>
        <actions>
            <name>Child_4_DOB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.FirstNameFourthChild__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Child_4_DOB_Day__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Enquiry Date %28for KPIs%29</fullName>
        <actions>
            <name>Populate_Enquiry_Date_for_KPIs</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>notEqual</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>notEqual</operation>
            <value>Unqualified</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Preferred Language Source</fullName>
        <actions>
            <name>Populate_Preferred_Language_Source</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Preferred_Language_Defined_by_Web_Form__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Primary Contact for Online Application</fullName>
        <actions>
            <name>Set_Primary_Contact_to_First_Parent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Primary_Contact__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Populates the primary contact field with &apos;First Parent&apos; if an online application is submitted with only one parent i.e. the primary contact field not completed</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Starting Date from Expected Fields</fullName>
        <actions>
            <name>Populate_Starting_Date_from_Expected</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>RecordType.DeveloperName = &quot;NAE_Admissions_Enquiry&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Register First Online</fullName>
        <actions>
            <name>First_Online_Contact</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Online Enquiry</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Register First Phone Call</fullName>
        <actions>
            <name>First_Call</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Phone Call</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Register Walk-In</fullName>
        <actions>
            <name>Walk_In</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>Walk-In</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Admissions Enquiry Emails %28BCB - CF %26 General%29</fullName>
        <actions>
            <name>Send_Admissions_Enquiry_Auto_Response_BCB</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Admissions_Enquiry_Notification_BCB_CF_General</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    NOT(ISBLANK(Related_School__c)),
    TEXT(Lead_Origin__c) = &quot;AdmissionsStage1&quot;,
    TEXT(School_Code__c) = &quot;BCB&quot;,
    TEXT(Campus__c) != &quot;Cidade Jardim&quot;
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Admissions Enquiry Emails %28BCB - CJ%29</fullName>
        <actions>
            <name>Send_Admissions_Enquiry_Auto_Response_BCB</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Admissions_Enquiry_Notification_BCB_CJ</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    NOT(ISBLANK(Related_School__c)),
    TEXT(Lead_Origin__c) = &quot;AdmissionsStage1&quot;,
    TEXT(School_Code__c) = &quot;BCB&quot;,
    TEXT(Campus__c) = &quot;Cidade Jardim&quot;
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Admissions Enquiry Emails %28BSKL%29</fullName>
        <actions>
            <name>Send_Admissions_Enquiry_Auto_Response_BSKL</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Admissions_Enquiry_Notification_BSKL</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    NOT(ISBLANK(Related_School__c)),
    TEXT(Lead_Origin__c) = &quot;AdmissionsStage1&quot;,
    TEXT(School_Code__c) = &quot;BKL&quot;
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Admissions Enquiry Emails %28BSNJ%29</fullName>
        <actions>
            <name>Send_Admissions_Enquiry_Auto_Response_BSNJ</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Admissions_Enquiry_Notification_BSNJ</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    NOT(ISBLANK(Related_School__c)),
    TEXT(Lead_Origin__c) = &quot;AdmissionsStage1&quot;,
    TEXT(School_Code__c) = &quot;BNJ&quot;
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Admissions Enquiry Emails %28BST%29</fullName>
        <actions>
            <name>Send_Admissions_Enquiry_Auto_Response_BST</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Admissions_Enquiry_Notification_BST</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    NOT(ISBLANK(Related_School__c)),
    TEXT(Lead_Origin__c) = &quot;AdmissionsStage1&quot;,
    TEXT(School_Code__c) = &quot;BST&quot;
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Admissions Enquiry Emails %28BSY%29</fullName>
        <actions>
            <name>Send_Admissions_Enquiry_Auto_Response_BSY</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Admissions_Enquiry_Notification_BSY</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    NOT(ISBLANK(Related_School__c)),
    TEXT(Lead_Origin__c) = &quot;AdmissionsStage1&quot;,
    TEXT(School_Code__c) = &quot;BSG&quot;
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Admissions Enquiry Emails %28ISM%29</fullName>
        <actions>
            <name>Send_Admissions_Enquiry_Auto_Response_ISM</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Admissions_Enquiry_Notification_ISM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    NOT(ISBLANK(Related_School__c)),
    TEXT(Lead_Origin__c) = &quot;AdmissionsStage1&quot;,
    TEXT(School_Code__c) = &quot;ISM&quot;
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Admissions Enquiry Emails %28NAISM%29</fullName>
        <actions>
            <name>Send_Admissions_Enquiry_Auto_Response_NAISM</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Admissions_Enquiry_Notification_NAISM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    NOT(ISBLANK(Related_School__c)),
    TEXT(Lead_Origin__c) = &quot;AdmissionsStage1&quot;,
    TEXT(School_Code__c) = &quot;KSM&quot;
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BCB%29 %28English%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BCB</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>saopaulo1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BCB%29 %28Portuguese%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BCB</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>Portuguese</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>saopaulo1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BISM%29 %28English%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BISM</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Online_Application_Auto_Response_BISM_English</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>marbella1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BISM%29 %28Spanish%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BISM</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Online_Application_Auto_Response_BISM_Spanish</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>Spanish</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>marbella1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BSB%29 %28English%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BSB</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Online_Application_Auto_Response_BSB_English</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>brasilia1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BSB%29 %28Portuguese%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BSB</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Online_Application_Auto_Response_BSB_Portuguese</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>Portuguese</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>brasilia1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BSKL%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BSKL</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>kualalumpur1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BSNJ%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BSNJ</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>nanjing1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BSNV%29 %28English%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BSNV</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Online_Application_Auto_Response_BSNV_English</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>navarra1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BSNV%29 %28Spanish%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BSNV</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Online_Application_Auto_Response_BSNV_Spanish</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>Spanish</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>navarra1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BST%29 %28English%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BST</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>tashkent1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BST%29 %28Russian%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BST</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>Russian</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>tashkent1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28BSY%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_BSY</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>yangon1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28ISM%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_ISM</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Website_Form_Type__c</field>
            <operation>equals</operation>
            <value>NAE Admissions Enquiry</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Code__c</field>
            <operation>equals</operation>
            <value>ISM</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28NAISM%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_NAISM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>manila1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Online Application Emails %28NYIS%29</fullName>
        <actions>
            <name>Send_Online_Application_Admissions_Notification_NYIS</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Online_Application_Auto_Response_NYIS</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.School_Drupal_UID__c</field>
            <operation>equals</operation>
            <value>newyork1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Sync Main Email with Primary Parent Email Address</fullName>
        <actions>
            <name>Sync_Primary_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Syncs the email address of the primary parent with the &apos;Primary Email&apos; (standard) field on the lead object so that any communication at enquiry stage is sent to the correct parent</description>
        <formula>AND(
    RecordType.DeveloperName != &quot;NAE_Admissions_Enquiry&quot;,
    ISBLANK(TEXT(School_Code__c)),
    OR(
       ISCHANGED(Main_Email__c),
       ISCHANGED(Alternate_Email__c),
       ISCHANGED(Parent_2_Email_1__c),
       ISCHANGED(Parent_2_Email_2__c),
       ISCHANGED(Primary_Contact__c),
       DATEVALUE(CreatedDate) = TODAY()
       )
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync SMS Number with Primary Parent Phone Number</fullName>
        <actions>
            <name>Sync_SMS_Country_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Sync_SMS_Phone_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Syncs the phone number of the primary parent with the relevant fields required for sending SMS via XSMS on the lead object so that any communication at enquiry stage is sent to the correct parent</description>
        <formula>OR(    ISCHANGED(Primary_Contact__c),     ISCHANGED(Mobile_Main_Phone_Country_CodePL__c),     ISCHANGED(Phone),     ISCHANGED(Alternate_Phone_Country_CodePL__c),     ISCHANGED(Parent_1_Phone_2__c),     ISCHANGED(Mobile_Main_Phone_Country_CodePL_P2__c),     ISCHANGED(Parent_2_Phone_1__c),     ISCHANGED(Alternate_Phone_Country_CodePL_P2__c),     ISCHANGED(Parent_2_Phone_2__c),     DATEVALUE(CreatedDate) = TODAY()    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>First_Call</fullName>
        <assignedToType>owner</assignedToType>
        <description>First Contact: Phone Call</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Lead.Enquiry_Date__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>First Contact: Phone Call</status>
        <subject>First Contact: Phone Call Completed</subject>
    </tasks>
    <tasks>
        <fullName>First_Online_Contact</fullName>
        <assignedToType>owner</assignedToType>
        <description>First Contact: Online</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Lead.Enquiry_Date__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>First Contact: Online</status>
        <subject>First Contact: Online Enquiry Received</subject>
    </tasks>
    <tasks>
        <fullName>GW_Volunteers__Volunteer_Signup_Thank_You_Sent_Lead</fullName>
        <assignedToType>owner</assignedToType>
        <description>An automatic email has been sent to the lead thanking them for signing up to be a volunteer.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Volunteer Signup Thank You Sent - Lead</subject>
    </tasks>
    <tasks>
        <fullName>Walk_In</fullName>
        <assignedToType>owner</assignedToType>
        <description>Walk-In</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Lead.Enquiry_Date__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>First Contact: Walk-In</status>
        <subject>First Contact: Walk-In Received</subject>
    </tasks>
</Workflow>
