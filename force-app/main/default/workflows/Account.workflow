<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>BSKL_Email_Reminder_about_Visa_Expiration</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Email Reminder about Visa Expiration</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_Reminder_about_Work_Permit_Expiration</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Email Reminder about Work Permit Expiration</description>
        <protected>false</protected>
        <senderAddress>admin@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_reminder_about_passport_expiry_date</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Email reminder about passport expiry date</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_reminder_about_passport_expiry_date_2nd</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Email reminder about passport expiry date 2nd</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_2nd</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_reminder_about_passport_expiry_date_to_staff_member</fullName>
        <description>BSKL Email reminder about passport expiry date to staff member</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Staff_Member_Notice</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_reminder_about_passport_expiry_date_to_staff_member_2nd</fullName>
        <description>BSKL Email reminder about passport expiry date to staff member 2nd</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Staff_Member_Notice_2nd</template>
    </alerts>
    <alerts>
        <fullName>BSM_Auto_reply_to_Employment_Application</fullName>
        <description>BSM - Auto-reply to Employment Application</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Employment_Enquiry_Response_BSM</template>
    </alerts>
    <alerts>
        <fullName>BSNJ_Auto_reply_to_Employment_Application</fullName>
        <description>BSNJ - Auto-reply to Employment Application</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Employment_Enquiry_Response_BSNJ</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_Reminder_about_Visa_Expiration</fullName>
        <ccEmails>ruslan.pryadun@britishschool.uz</ccEmails>
        <description>BST Email Reminder about Visa Expiration</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_Reminder_about_Work_Permit_Expiration</fullName>
        <ccEmails>ruslan.pryadun@britishschool.uz</ccEmails>
        <description>BST Email Reminder about Work Permit Expiration</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_reminder_about_passport_expiry_date</fullName>
        <ccEmails>ruslan.pryadun@britishschool.uz</ccEmails>
        <description>BST Email reminder about passport expiry date</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_reminder_about_passport_expiry_date_2nd</fullName>
        <ccEmails>ruslan.pryadun@britishschool.uz</ccEmails>
        <description>BST Email reminder about passport expiry date 2nd</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_2nd</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_reminder_about_passport_expiry_date_to_staff_member</fullName>
        <description>BST Email reminder about passport expiry date to staff member</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Staff_Member_Notice</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_reminder_about_passport_expiry_date_to_staff_member_2nd</fullName>
        <description>BST Email reminder about passport expiry date to staff member 2nd</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Staff_Member_Notice_2nd</template>
    </alerts>
    <alerts>
        <fullName>Calendar_View_Reminder_Email_Account_Alternate</fullName>
        <description>Calendar View Reminder Email (Account Alternate)</description>
        <protected>false</protected>
        <recipients>
            <field>Copy_Alternate_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Calendar_Check_Reminder_Account</template>
    </alerts>
    <alerts>
        <fullName>Calendar_View_Reminder_Email_Account_Main</fullName>
        <description>Calendar View Reminder Email (Account Main)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Calendar_Check_Reminder_Account</template>
    </alerts>
    <alerts>
        <fullName>F_Info_Not_Yet_Received_First_Notification</fullName>
        <description>F/Info Not Yet Received First Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_No_F_Info_Form_Received_First_Notification</template>
    </alerts>
    <alerts>
        <fullName>F_Info_Not_Yet_Received_Second_Notification</fullName>
        <description>F/Info Not Yet Received Second Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_No_F_Info_Form_Received_Second_Notification</template>
    </alerts>
    <alerts>
        <fullName>F_Info_Request_English</fullName>
        <description>F/Info Request (English)</description>
        <protected>false</protected>
        <recipients>
            <field>Related_Contact_Record_P2__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/EN_Parent_Financial_Info_Service_Request_Old</template>
    </alerts>
    <alerts>
        <fullName>F_Info_Request_Portuguese</fullName>
        <description>F/Info Request (Portuguese)</description>
        <protected>false</protected>
        <recipients>
            <field>Related_Contact_Record_P2__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/BR_Parent_Financial_Info_Service_Request</template>
    </alerts>
    <alerts>
        <fullName>Failed_to_Update_Xero_Contact_ID_Notification</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>Failed to Update Xero Contact ID Notification</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Failed_to_Update_Xero_Contact_ID_Notification</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_Reminder_about_Visa_Expiration</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email Reminder about Visa Expiration</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_Reminder_about_Work_Permit_Expiration</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email Reminder about Work Permit Expiration</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_reminder_about_medical_book_expiry_date</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email reminder about medical book expiry date</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Medical_Book_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_reminder_about_passport_expiry_date</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email reminder about passport expiry date</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_reminder_about_passport_expiry_date_2nd</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email reminder about passport expiry date 2nd</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_2nd</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_reminder_about_passport_expiry_date_to_staff_member</fullName>
        <description>ISM Email reminder about passport expiry date to staff member</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Staff_Member_Notice</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_reminder_about_passport_expiry_date_to_staff_member_2nd</fullName>
        <description>ISM Email reminder about passport expiry date to staff member 2nd</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Staff_Member_Notice_2nd</template>
    </alerts>
    <alerts>
        <fullName>ISM_Sends_Email_1_month_before_Medical_Book_Expiration_Date</fullName>
        <ccEmails>aneta.kolosovskaya@internationalschool.ru</ccEmails>
        <description>ISM Sends Email 1 month before Medical Book Expiration Date</description>
        <protected>false</protected>
        <recipients>
            <field>Copy_Alternate_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>ISM_s_Template_Emails/Medical_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>ISM_Sends_email_7_days_before_Registration_Expiry_Date</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Sends email 7 days before Registration Expiry Date</description>
        <protected>false</protected>
        <recipients>
            <field>Copy_Alternate_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Registration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>Kompanion_User_Needs_Reactivating</fullName>
        <description>Kompanion User Needs Reactivating</description>
        <protected>false</protected>
        <recipients>
            <recipient>rainbow.integration@nordanglia.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Sys_Adm_Kompanion_User_Needs_Reactivating</template>
    </alerts>
    <alerts>
        <fullName>NAISM_Auto_reply_to_Employment_Application</fullName>
        <description>NAISM - Auto-reply to Employment Application</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Responses/EN_Employment_Enquiry_Response_KSM</template>
    </alerts>
    <alerts>
        <fullName>New_Account_with_Address_Alert</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>New Account with Address Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_Account_with_Address_Notification</template>
    </alerts>
    <alerts>
        <fullName>New_Employment_Application_Notification</fullName>
        <description>New Employment Application Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Staff_Notification_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_Employment_Application_Notification</template>
    </alerts>
    <alerts>
        <fullName>Notification_for_Removal_from_Health_Insurance_Policy</fullName>
        <description>Notification for Removal from Health Insurance Policy</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Notification_of_Health_Insurance_Expiry</template>
    </alerts>
    <alerts>
        <fullName>Notify_Admissions_of_Account_Status_Changed_from_Inactive_to_Active_1</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>Notify Admissions of Account Status Changed from Inactive to Active 1</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Sys_Adm_Inform_Admissions_of_Inactive_Account_Reactivated_1</template>
    </alerts>
    <alerts>
        <fullName>Notify_Admissions_of_Account_Status_Changed_from_Inactive_to_Active_2</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>Notify Admissions of Account Status Changed from Inactive to Active 2</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Sys_Adm_Inform_Admissions_of_Inactive_Account_Reactivated_2</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_Error_in_Portal_User_Creation_Account</fullName>
        <description>Notify of Error in Portal User Creation</description>
        <protected>false</protected>
        <recipients>
            <field>IT_Notifications_Email_Account__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/Sys_Adm_Portal_User_Creation_Error_Account</template>
    </alerts>
    <alerts>
        <fullName>Reminder_about_contract_expiry_date_30_days</fullName>
        <description>Reminder about contract expiry date 30 days</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Contract_Expiration_Date_Notice_30_Days</template>
    </alerts>
    <alerts>
        <fullName>Reminder_about_contract_expiry_date_75_days</fullName>
        <description>Reminder about contract expiry date 75 days</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Contract_Expiration_Date_Notice_75_Days</template>
    </alerts>
    <alerts>
        <fullName>Resend_Kompanion_Login_Info_Email_Account</fullName>
        <description>Resend Kompanion Login Info Email (Account)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Parent_Portal_Emails/BSF_Parent_App_Resend_Login_Info_Email_Account</template>
    </alerts>
    <alerts>
        <fullName>Send_Automated_Event_Notification_Email_Within_2_Weeks_Alternate</fullName>
        <description>Send Automated Event Notification Email (Within 2 Weeks Alternate)</description>
        <protected>false</protected>
        <recipients>
            <field>Copy_Alternate_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Date_Reminder_Email_Within_next_2_Weeks_Account</template>
    </alerts>
    <alerts>
        <fullName>Send_Automated_Event_Notification_Email_Within_2_Weeks_Main</fullName>
        <description>Send Automated Event Notification Email (Within 2 Weeks Main)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Date_Reminder_Email_Within_next_2_Weeks_Account</template>
    </alerts>
    <alerts>
        <fullName>Send_Kompanion_Welcome_Email_Account</fullName>
        <ccEmails>parent.app@britishschools.co.uk</ccEmails>
        <description>Send Kompanion Welcome Email (Account)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Parent_Portal_Emails/BSF_Parent_App_Welcome_Email_Account</template>
    </alerts>
    <alerts>
        <fullName>Send_Portal_Login_Info_Account</fullName>
        <description>Send Portal Login Info (Account)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>support@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Parent_Portal_Emails/Parent_Portal_Login_Info_Account</template>
    </alerts>
    <alerts>
        <fullName>Send_Portal_Welcome_Email_Account</fullName>
        <description>Send Portal Welcome Email (Account)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>support@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Parent_Portal_Emails/Parent_Portal_Welcome_Email_Account</template>
    </alerts>
    <alerts>
        <fullName>Send_Staff_Directory_Info_Request_Email_New_Website</fullName>
        <description>Send Staff Directory Info Request Email (New Website)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_1__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Staff_Directory_Info_Request_Email_New_Website</template>
    </alerts>
    <alerts>
        <fullName>Warn_of_Mixed_House_Family</fullName>
        <description>Warn of Mixed House Family</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Grp_Adm_Warn_of_Different_Houses_in_One_Family</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_BCB</fullName>
        <description>Sets the company account owner to the BCB user with the role &quot;Record Owner (Company)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>carla.basile@britishcollegebrazil.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_BISM</fullName>
        <description>Sets the company account owner to the BISM user with the role &quot;Record Owner (Company)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_BSB</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_BSKL</fullName>
        <description>Sets the company account owner to the BSKL user with the role &quot;Record Owner (Company)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>bskl.invoicing@britishschool.edu.my</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_BSNJ</fullName>
        <description>Sets the company account owner to the BSNJ user with the role &quot;Record Owner (Company)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_BSNV</fullName>
        <description>Sets the company account owner to the BSNV user with the role &quot;Record Owner (Company)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_BST</fullName>
        <description>Sets the company account owner to the BST user with the role &quot;Record Owner (Company)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>bst.invoicing@britishschool.uz</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_BSY</fullName>
        <field>OwnerId</field>
        <lookupValue>zinnwe.oo@britishschoolyangon.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_ISM</fullName>
        <description>Sets the company account owner to the ISM user with the role &quot;Record Owner (Company)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>maria.ezhova@internationalschool.ru</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_NAISM</fullName>
        <field>OwnerId</field>
        <lookupValue>tj.torres@naismanila.edu.ph</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_NYIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Company_Record_Owner_UIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Company Record Owner (UIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_BCB</fullName>
        <description>Sets the parent account owner to the BCB user with the role &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>carla.basile@britishcollegebrazil.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_BISM</fullName>
        <description>Sets the parent account owner to the BISM user with the role &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_BSB</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_BSKL</fullName>
        <description>Sets the parent account owner to the BSKL user with the role &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>admissions@britishschool.edu.my</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_BSNJ</fullName>
        <description>Sets the parent account owner to the BSNJ user with the role &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_BSNV</fullName>
        <description>Sets the parent account owner to the BSNV user with the role &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_BST</fullName>
        <description>Sets the parent account owner to the BST user with the role &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>elena.savtsova@britishschool.uz</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_BSY</fullName>
        <field>OwnerId</field>
        <lookupValue>carolyn.bickerton@britishschoolyangon.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_ISM</fullName>
        <description>Sets the parent account owner to the ISM user with the role &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>maria.ezhova@internationalschool.ru</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_NAISM</fullName>
        <field>OwnerId</field>
        <lookupValue>tj.torres@naismanila.edu.ph</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_NYIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Parent_Record_Owner_UIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Parent Record Owner (UIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BCB</fullName>
        <field>OwnerId</field>
        <lookupValue>carla.basile@britishcollegebrazil.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BISM</fullName>
        <description>Sets the company account owner to the BISM user with the role &quot;Record Owner (Staff Member)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BSB</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BSG</fullName>
        <description>Sets the staff member account owner to the BSG HR user</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BSG)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BSKL</fullName>
        <description>Sets the company account owner to the BSKL user with the role &quot;Record Owner (Staff Member)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>bskl.invoicing@britishschool.edu.my</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BSNJ</fullName>
        <description>Sets the company account owner to the BSNJ user with the role &quot;Record Owner (Staff Member)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BSNV</fullName>
        <description>Sets the company account owner to the BSNV user with the role &quot;Record Owner (Staff Member)&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BST</fullName>
        <description>Sets the staff member account owner to the BST HR user</description>
        <field>OwnerId</field>
        <lookupValue>bst.invoicing@britishschool.uz</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_BSY</fullName>
        <field>OwnerId</field>
        <lookupValue>carolyn.bickerton@britishschoolyangon.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_Group</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (Group)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_ISM</fullName>
        <description>Sets the staff member account owner to the ISM HR user</description>
        <field>OwnerId</field>
        <lookupValue>maria.ezhova@internationalschool.ru</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_NAISM</fullName>
        <description>Sets the staff member account owner to the NAISM Head of Admin</description>
        <field>OwnerId</field>
        <lookupValue>tj.torres@naismanila.edu.ph</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_NYIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Staff_Member_Record_Owner_UIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Staff Member Record Owner (UIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BCB_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British College of Brazil</literalValue>
        <name>BCB Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BISM_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British International School of Marbella</literalValue>
        <name>BISM Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BISY_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School Yangon</literalValue>
        <name>BISY Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BR_Parent_Survey_URL_Update_Account</fullName>
        <field>Text_Parent_Survey_URL_BR__pc</field>
        <formula>Parent_Survey_URL_BR_Account__c</formula>
        <name>BR Parent Survey URL Update (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BSB_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Brasilia</literalValue>
        <name>BSB Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BSF_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British Schools Foundation</literalValue>
        <name>BSF Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BSG_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Guangzhou</literalValue>
        <name>BSG Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BSKL_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British International School of Kuala Lumpur</literalValue>
        <name>BSKL Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BSNJ_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Nanjing</literalValue>
        <name>BSNJ Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BSNV_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Navarra</literalValue>
        <name>BSNV Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BST_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Tashkent</literalValue>
        <name>BST Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Resend_Portal_Login_to_False</fullName>
        <field>Resend_Portal_Login_Info__pc</field>
        <literalValue>0</literalValue>
        <name>Change Resend Portal Login to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Portal_User_Created_Field_Account</fullName>
        <field>Portal_User_Created__pc</field>
        <literalValue>1</literalValue>
        <name>Check Portal User Created Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Alt_C_Code_PL_to_Alt_C_Code_Acc</fullName>
        <field>Contact_Alternate_Phone_Country_Code__pc</field>
        <formula>IF(
   ISBLANK(TEXT(PersonContact.Contact_Alternate_Phone_Country_CodePL__c)),
   &quot;&quot;,
   MID(
       TEXT(PersonContact.Contact_Alternate_Phone_Country_CodePL__c), 
       FIND(&quot;+&quot;, TEXT(PersonContact.Contact_Alternate_Phone_Country_CodePL__c))+1, 
       LEN(TEXT(PersonContact.Contact_Alternate_Phone_Country_CodePL__c))-(FIND(&quot;+&quot;, TEXT(PersonContact.Contact_Alternate_Phone_Country_CodePL__c))+1)
       )
   )</formula>
        <name>Copy Alt C/Code PL to Alt C/Code (Acc)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_C_Code_to_SMS_C_Code_Account</fullName>
        <field>xsms__Mobile_Phone_Country_Code__pc</field>
        <formula>IF(
   ISBLANK(TEXT(PersonContact.Contact_Mobile_Main_Phone_Country_CodePL__c)),
   &quot;&quot;,
   MID(
       TEXT(PersonContact.Contact_Mobile_Main_Phone_Country_CodePL__c), 
       FIND(&quot;+&quot;, TEXT(PersonContact.Contact_Mobile_Main_Phone_Country_CodePL__c))+1, 
       LEN(TEXT(PersonContact.Contact_Mobile_Main_Phone_Country_CodePL__c))-(FIND(&quot;+&quot;, TEXT(PersonContact.Contact_Mobile_Main_Phone_Country_CodePL__c))+1)
       )
   )</formula>
        <name>Copy C/Code to SMS C/Code (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Contract_Number</fullName>
        <description>Copies autonumber contract number to text field contract number</description>
        <field>Contract_Number__c</field>
        <formula>Contract_Autonumber__c</formula>
        <name>Copy Contract Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Manager_s_Email</fullName>
        <field>Manager_s_Email__c</field>
        <formula>Line_Manager_s_Email__c</formula>
        <name>Copy Manager&apos;s Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_UsernameFormula</fullName>
        <field>Username__c</field>
        <formula>UsernameFormula__c</formula>
        <name>Copy UsernameFormula</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Create_Portal_User_Password_Account</fullName>
        <field>Portal_User_Password__pc</field>
        <formula>IF(
   NOT(CONTAINS(LOWER(PersonEmail), LOWER(LEFT(LastName, 1))&amp;LOWER(LEFT(FirstName, 1)))),
   UPPER(LEFT(LastName, 1))&amp;UPPER(LEFT(FirstName, 1))&amp;&quot;hub&quot;&amp;RIGHT(PersonContact.Staff_Member_Parent_Number_Formula__c, 4),
   &quot;ZZhub&quot;&amp;RIGHT(PersonContact.Staff_Member_Parent_Number_Formula__c, 4)
   )</formula>
        <name>Create Portal User Password</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EN_Parent_Survey_URL_Update_Account</fullName>
        <field>Text_Parent_Survey_URL_EN__pc</field>
        <formula>Parent_Survey_URL_EN_Account__c</formula>
        <name>EN Parent Survey URL Update (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ES_Parent_Survey_URL_Update_Account</fullName>
        <field>Text_Parent_Survey_URL_ES__pc</field>
        <formula>Parent_Survey_URL_ES_Account__c</formula>
        <name>ES Parent Survey URL Update (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Error_Message_Null</fullName>
        <field>Error_Message__c</field>
        <name>Error Message - Null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>F_Info_A_Response</fullName>
        <description>Changes the value of the field which triggers an email to be sent to the financial-info@ email address notifying the user that a financial information response has not been submitted after a given amount of time.</description>
        <field>F_Info_Response_Status__c</field>
        <literalValue>are awaiting the</literalValue>
        <name>F/Info A/Response</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>F_Info_Email_Sent</fullName>
        <field>F_Info_Request_Status__c</field>
        <literalValue>Sent</literalValue>
        <name>F/Info Email Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>F_Info_Request_Date_Time_Update</fullName>
        <field>F_Info_Request_Date_Time__c</field>
        <formula>NOW()</formula>
        <name>F/Info Request Date/Time  Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Failed_to_Update_Xero_Contact_ID_FALSE</fullName>
        <field>Failed_to_Update_Xero_Id__c</field>
        <literalValue>0</literalValue>
        <name>Failed to Update Xero Contact ID - FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Kompanion_User_P_word_Account</fullName>
        <field>School_Kompanion_Password__pc</field>
        <formula>/*IF(
   NOT(CONTAINS(LOWER(PersonEmail), LOWER(LEFT(LastName, 1))&amp;LOWER(LEFT(FirstName, 1)))),
   UPPER(LEFT(LastName, 1))&amp;UPPER(LEFT(FirstName, 1))&amp;&quot;app5624&quot;,
   &quot;ZZapp5624&quot;
   )*/

IF(
   NOT(CONTAINS(LOWER(PersonEmail), LOWER(LEFT(LastName, 1))&amp;LOWER(LEFT(FirstName, 1)))),
   UPPER(LEFT(LastName, 1))&amp;UPPER(LEFT(FirstName, 1))&amp;&quot;app&quot;,
   &quot;ZZapp&quot;
   )</formula>
        <name>Generate Kompanion User P/word (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Kompanion_Username_Account</fullName>
        <field>School_Kompanion_Username__pc</field>
        <formula>IF(
   ISBLANK(School_Kompanion_Username__pc),
   PersonEmail,
   School_Kompanion_Username__pc
   )</formula>
        <name>Generate Kompanion Username (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ISM_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The International School of Moscow</literalValue>
        <name>ISM Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KCB_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>King&apos;s College Beijing</literalValue>
        <name>KCB Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NAISM_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>Nord Anglia International School Manila</literalValue>
        <name>NAISM Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NYIS_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The New York International School</literalValue>
        <name>NYIS Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_F_Info_Email_Copy_Field</fullName>
        <field>F_Info_Email_Copy__c</field>
        <formula>IF(AND(F_Info_Email__c != null,F_Info_Email__c != &apos;&apos;) , F_Info_Email__c , null)</formula>
        <name>Populate F/Info Email Copy Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_IT_Notifications_Email_Account</fullName>
        <field>IT_Notifications_Email_Account__c</field>
        <formula>IF(OR(SchoolText__pc = &quot;The British International School of Kuala Lumpur&quot;, Company_School__c = &quot;The British International School of Kuala Lumpur&quot;), &quot;it-notifications@britishschool.edu.my&quot;, 

IF(OR(SchoolText__pc = &quot;The International School of Moscow&quot;, Company_School__c = &quot;The International School of Moscow&quot;), &quot;it-notifications@internationalschool.ru&quot;,

IF(OR(SchoolText__pc = &quot;The British School of Nanjing&quot;, Company_School__c = &quot;The British School of Nanjing&quot;), &quot;it-notifications@bsn.org.cn&quot;,

IF(OR(SchoolText__pc = &quot;The British International School of Marbella&quot;, Company_School__c = &quot;The British International School of Marbella&quot;), &quot;it-notifications@bsm.org.es&quot;,

IF(OR(SchoolText__pc = &quot;The British School of Navarra&quot;, Company_School__c = &quot;The British School of Navarra&quot;), &quot;it-notifications@bsn.org.es&quot;,

IF(OR(SchoolText__pc = &quot;The British School of Tashkent&quot;, Company_School__c = &quot;The British School of Tashkent&quot;), &quot;it-notifications@britishschool.uz&quot;,

IF(OR(SchoolText__pc = &quot;Nord Anglia International School Manila&quot;, Company_School__c = &quot;Nord Anglia International School Manila&quot;), &quot;it-notifications@kings.org.ph&quot;,

IF(OR(SchoolText__pc = &quot;The British School Yangon&quot;, Company_School__c = &quot;The British School Yangon&quot;), &quot;it-notifications@britishschoolyangon.org&quot;,

IF(OR(SchoolText__pc = &quot;The British College of Brazil&quot;, Company_School__c = &quot;The British College of Brazil&quot;), &quot;it-notifications@britishcollegebrazil.org&quot;,

IF(OR(SchoolText__pc = &quot;The British School of Brasilia&quot;, Company_School__c = &quot;The British School of Brasilia&quot;), &quot;it-notifications@britishschoolbrasilia.org&quot;,

IF(OR(SchoolText__pc = &quot;The New York International School&quot;, Company_School__c = &quot;The New York International School&quot;), &quot;it-notifications@nyis.org&quot;,

&quot;it-notifications@britishschools.co.uk&quot;)))))))))))</formula>
        <name>Populate IT Notifications Email(Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_P1_Alternate_Email_on_Create</fullName>
        <field>Contact_Alternate_Email__pc</field>
        <formula>Parent_1_Alternate_Email_from_Lead__c</formula>
        <name>Populate P1 Alternate Email on Create</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_P1_Main_Email_on_Create</fullName>
        <field>PersonEmail</field>
        <formula>Parent_1_Main_Email_from_Lead__c</formula>
        <name>Populate P1 Main Email on Create</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_P1_Mobile_Number_on_Create</fullName>
        <field>PersonMobilePhone</field>
        <formula>Phone</formula>
        <name>Populate P1 Mobile Number on Create</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Staff_Directory_Info_Email_Sent</fullName>
        <field>Staff_Directory_Info_Request_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Populate Staff Directory Info Email Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Username_must_be_unique_Acc</fullName>
        <field>School_Kompanion_Username_UID__pc</field>
        <formula>IF(
   ISBLANK(School_Kompanion_Username__pc),
   &quot;&quot;,
   SchoolText__pc&amp;&quot;-&quot;&amp;School_Kompanion_Username__pc
   )</formula>
        <name>Populate &apos;Username must be unique!&apos;(Acc)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RU_Parent_Survey_URL_Update_Account</fullName>
        <field>Text_Parent_Survey_URL_RU__pc</field>
        <formula>Parent_Survey_URL_RU_Account__c</formula>
        <name>RU Parent Survey URL Update (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Related_Event_Trigger_Email_1_to_FALSE</fullName>
        <field>Related_Event_Trigger_First_Email_Send__pc</field>
        <literalValue>0</literalValue>
        <name>Related Event Trigger Email 1 to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_App_Login_Info_Sent_to_TRUE_Acc</fullName>
        <field>School_Kompanion_App_Login_Info_Sent__pc</field>
        <literalValue>1</literalValue>
        <name>Set App Login Info Sent to TRUE (Acc)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SK_Resend_Login_Info_to_FALSE_Acc</fullName>
        <field>School_Kompanion_Resend_Login_Info__pc</field>
        <literalValue>0</literalValue>
        <name>Set SK Resend Login Info to FALSE (Acc)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Send_SK_Outbound_to_FALSE_Account</fullName>
        <field>Send_School_Kompanion_Outbound_Message__c</field>
        <literalValue>0</literalValue>
        <name>Set Send SK Outbound to FALSE (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Send_SK_Outbound_to_TRUE_Account</fullName>
        <field>Send_School_Kompanion_Outbound_Message__c</field>
        <literalValue>1</literalValue>
        <name>Set Send SK Outbound to TRUE (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Time_Based_K_Send_to_FALSE_Account</fullName>
        <field>Trigger_Time_Based_Send_to_Kompanion__pc</field>
        <literalValue>0</literalValue>
        <name>Set Time-Based K Send to FALSE (Account)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Source_Lead_Has_Second_Parent_to_FALSE</fullName>
        <field>Source_Lead_Has_Second_Parent__c</field>
        <literalValue>0</literalValue>
        <name>Source Lead Has Second Parent to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Trigger_Parent_User_Creation</fullName>
        <description>Performs a simple edit of the account record to trigger the portal user creation based on other fields and the trigger criteria</description>
        <field>Trigger_Parent_User_Creation_Checkbox__c</field>
        <literalValue>1</literalValue>
        <name>Trigger Parent User Creation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UIS_Update_School_Controlling_Picklist</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>Ukraine International School</literalValue>
        <name>UIS Update School Controlling Picklist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Alternate_Email_Copy</fullName>
        <field>Copy_Alternate_Email__c</field>
        <formula>Contact_Alternate_Email__pc</formula>
        <name>Update Alternate Email Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Main_Email_Copy</fullName>
        <description>Updates/copies the value of the main email (standard field) in to the Copy Email field</description>
        <field>Email_1__c</field>
        <formula>PersonEmail</formula>
        <name>Update Main Email Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Preferred_Language_Source</fullName>
        <description>Updates the &apos;Preferred Language Source&apos; field to manual whenever it is changed from the initial value</description>
        <field>Preferred_Language_Defined_by_Web_Form__c</field>
        <literalValue>Manually Updated</literalValue>
        <name>Update Preferred Language Source</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Account_to_School_Kompanion</fullName>
        <apiVersion>36.0</apiVersion>
        <endpointUrl>https://schoolkompanion.co.uk/IncomingMessages/Salesforce.php</endpointUrl>
        <fields>Address_Accommodation_Type__pc</fields>
        <fields>Address_Apartment_Condominium_or_Communi__pc</fields>
        <fields>Address_Apartment_Unit_Number__pc</fields>
        <fields>Address_City__pc</fields>
        <fields>Address_Country__pc</fields>
        <fields>Address_House_Building_Number__pc</fields>
        <fields>Address_Line_2__pc</fields>
        <fields>Address_State_Province__pc</fields>
        <fields>Address_Street_Name__pc</fields>
        <fields>Address_Zip_Postal_Code__pc</fields>
        <fields>Alternate_Phone_Combined__pc</fields>
        <fields>Contact_Alternate_Email__pc</fields>
        <fields>Contact_Alternate_Phone_Country_CodePL__pc</fields>
        <fields>Contact_Alternate_Phone__pc</fields>
        <fields>Contact_Employer__pc</fields>
        <fields>Contact_Employment_Sector__pc</fields>
        <fields>Contact_Mobile_Main_Phone_Country_CodePL__pc</fields>
        <fields>Contact_Nationality__pc</fields>
        <fields>Contact_Relationship__pc</fields>
        <fields>Contact_UID__c</fields>
        <fields>Family_Name__c</fields>
        <fields>Family_UID__c</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>Is_Primary_Contact__c</fields>
        <fields>LastName</fields>
        <fields>Main_Phone_Combined__pc</fields>
        <fields>PersonEmail</fields>
        <fields>PersonMobilePhone</fields>
        <fields>SK_App_Only_Experience__pc</fields>
        <fields>Salutation</fields>
        <fields>School_Kompanion_Allow_App_Login__pc</fields>
        <fields>School_Kompanion_Can_Edit_Address__pc</fields>
        <fields>School_Kompanion_Password__pc</fields>
        <fields>School_Kompanion_Realm__c</fields>
        <fields>School_Kompanion_Username__pc</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>nae.migration@britishschools.co.uk</integrationUser>
        <name>Account to School Kompanion</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Create_bsghub_user</fullName>
        <apiVersion>25.0</apiVersion>
        <description>Create a bsghub user when a new account record is created in SF</description>
        <endpointUrl>http://www.bsghub.net/sf_notifications/endpoint</endpointUrl>
        <fields>Enrolled__c</fields>
        <fields>Family_Status__c</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>PrimaryContactEmail__c</fields>
        <fields>Record_Type__c</fields>
        <fields>Salutation</fields>
        <fields>SchoolText__pc</fields>
        <fields>School_Department__c</fields>
        <fields>Status__c</fields>
        <fields>Username__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>nae.migration@britishschools.co.uk</integrationUser>
        <name>Create bsghub USER</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Update_bsghub_PARENTS</fullName>
        <apiVersion>25.0</apiVersion>
        <description>Update bsghub.net´s parents wit new information from sf</description>
        <endpointUrl>http://www.bsghub.net/sf_notifications/endpoint</endpointUrl>
        <fields>Enrolled__c</fields>
        <fields>Family_Status__c</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>PrimaryContactEmail__c</fields>
        <fields>Salutation</fields>
        <fields>SchoolText__pc</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>nae.migration@britishschools.co.uk</integrationUser>
        <name>Update bsghub PARENTS</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Update_bsghub_staff</fullName>
        <apiVersion>25.0</apiVersion>
        <description>Update bsghub staff with the new information on its paired sf account</description>
        <endpointUrl>http://www.bsghub.net/sf_notifications/endpoint</endpointUrl>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>PrimaryContactEmail__c</fields>
        <fields>Salutation</fields>
        <fields>School_Department__c</fields>
        <fields>Status__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>nae.migration@britishschools.co.uk</integrationUser>
        <name>Update bsghub STAFF</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Account Copy Email</fullName>
        <actions>
            <name>Update_Alternate_Email_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Main_Email_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Account.PersonEmail</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.PersonEmail</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates/copies the value of the main email (standard field) in to the Copy Email field</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BCB Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BCB_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BISM - Employment Application Auto-Reply</fullName>
        <actions>
            <name>BSM_Auto_reply_to_Employment_Application</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.Applied_via_Website__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <description>An auto-reply sent when someone submits a new employment application via the website</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>BISM Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BISM_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BSB Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BSB_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BSF Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BSF_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BSG Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BSG_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Checks Passport Expiration Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 180 days before passport expiration date + second notification 90 days before expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Email_reminder_about_passport_expiry_date</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>BSKL_Email_reminder_about_passport_expiry_date_to_staff_member</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Passport_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Email_reminder_about_passport_expiry_date_2nd</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>BSKL_Email_reminder_about_passport_expiry_date_to_staff_member_2nd</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Passport_Expiration_Date__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL Checks Visa%2FWork Permit Expiration Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 120 days before a visa/work permit expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Email_Reminder_about_Visa_Expiration</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Visa_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Email_Reminder_about_Work_Permit_Expiration</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Work_Permit_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BSKL_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BSNJ - Employment Application Auto-Reply</fullName>
        <actions>
            <name>BSNJ_Auto_reply_to_Employment_Application</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.Applied_via_Website__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <description>An auto-reply sent when someone submits a new employment application via the website</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>BSNJ Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BSNJ_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BSNV Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BSNV_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BST Checks Passport Expiration Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 180 days before passport expiration date + second notification 90 days before expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BST_Email_reminder_about_passport_expiry_date_2nd</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>BST_Email_reminder_about_passport_expiry_date_to_staff_member_2nd</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Passport_Expiration_Date__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>BST_Email_reminder_about_passport_expiry_date</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>BST_Email_reminder_about_passport_expiry_date_to_staff_member</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Passport_Expiration_Date__c</offsetFromField>
            <timeLength>180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BST Checks Visa%2FWork Permit Expiration Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 180 days before a visa/work permit expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BST_Email_Reminder_about_Visa_Expiration</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Visa_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>BST_Email_Reminder_about_Work_Permit_Expiration</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Work_Permit_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BST Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BST_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BSY Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>BISY_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Checks Medical Book Expiration Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 1 month before a registration expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Sends_Email_1_month_before_Medical_Book_Expiration_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Medical_Book_Expiry_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Checks Passport Expiration Date</fullName>
        <active>false</active>
        <booleanFilter>(1 OR 2)</booleanFilter>
        <criteriaItems>
            <field>Account.OwnerId</field>
            <operation>equals</operation>
            <value>Administration ISM</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.OwnerId</field>
            <operation>equals</operation>
            <value>Directors ISM</value>
        </criteriaItems>
        <description>Sends an email 6 months before a passport expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Account.Passport_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Clear Failed to Update Xero ID %26 Error Message</fullName>
        <actions>
            <name>Error_Message_Null</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Failed_to_Update_Xero_Contact_ID_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>Account.Xero_Contact_ID__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Failed_to_Update_Xero_Id__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Error_Message__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Fires when a Xero Contact ID is added by system admin or by sending an invoice successfully to Xero so that the Xero Contact ID is populated automatically.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contract Expiration Date Notification %2830 Days%29</fullName>
        <active>false</active>
        <formula>AND(  INCLUDES(Notify_me__c, &quot;30 days before contract expiration&quot;),  NOT(ISNULL(Staff_Member_End_Date__c))  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Reminder_about_contract_expiry_date_30_days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Staff_Member_End_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Contract Expiration Date Notification %2875 Days%29</fullName>
        <active>true</active>
        <formula>AND(  INCLUDES(Notify_me__c, &quot;75 days before contract expiration&quot;),  NOT(ISNULL(Staff_Member_End_Date__c))  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Reminder_about_contract_expiry_date_75_days</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Staff_Member_End_Date__c</offsetFromField>
            <timeLength>-75</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Copy Alt C%2FCode PL to Alt C%2FCode %28Account%29</fullName>
        <actions>
            <name>Copy_Alt_C_Code_PL_to_Alt_C_Code_Acc</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     RecordType.DeveloperName != &quot;Company_Account&quot;,     OR(        ISNEW(),        ISCHANGED(Contact_Alternate_Phone_Country_CodePL__pc)        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy C%2FCode to SMS C%2FCode %28Account%29</fullName>
        <actions>
            <name>Copy_C_Code_to_SMS_C_Code_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(          RecordType.DeveloperName != &quot;Company_Account&quot;,     RecordType.DeveloperName != &quot;Organization&quot;,     OR(        ISNEW(),        ISCHANGED(Contact_Mobile_Main_Phone_Country_CodePL__pc)        )          )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Contract Number</fullName>
        <actions>
            <name>Copy_Contract_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Contract_Autonumber__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Copies the autonumber filed to a text field, to allow editing</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Copy Manager%27s Email</fullName>
        <actions>
            <name>Copy_Manager_s_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Username Formula</fullName>
        <actions>
            <name>Copy_UsernameFormula</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.LastName</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Create bsghub USER</fullName>
        <actions>
            <name>Create_bsghub_user</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <description>When a new record is created in SF send an outbound message to bsghub.net to create a paired user, can be staff or parent.</description>
        <formula>NOT($User.Username = &apos;directors@britishschools.co.uk&apos;) &amp;&amp; Record_Type__c  = &apos;Parent&apos;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>F%2FInfo Not Received Notification</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.F_Info_Request_Status__c</field>
            <operation>equals</operation>
            <value>Sent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.F_Info_Response_Status__c</field>
            <operation>equals</operation>
            <value>are awaiting the</value>
        </criteriaItems>
        <description>Trigger to send a notification to the financial-info@ email address when no response to a financial information form has been received within a certain timeframe.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>F_Info_Not_Yet_Received_First_Notification</name>
                <type>Alert</type>
            </actions>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>F_Info_Not_Yet_Received_Second_Notification</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Generate Kompanion Login %28Account%29</fullName>
        <actions>
            <name>Generate_Kompanion_User_P_word_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Generate_Kompanion_Username_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(     TEXT(School_Kompanion_Contact_Created__pc) = &quot;Yes&quot;,      Allow_App_Login__pc = TRUE,     PersonContact.School_Kompanion_Allow_App_Login__c = TRUE,     OR(        NOT(ISBLANK(PersonEmail)),        NOT(ISBLANK(School_Kompanion_Username__pc))        ),     OR(        ISBLANK(School_Kompanion_Username__pc),        ISBLANK(School_Kompanion_Password__pc)        )     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Health Insurance Notificaiton TEST</fullName>
        <active>false</active>
        <formula>AND(TEXT(First_Date_of_Health_Insurance_Coverage__c) &lt;&gt; &quot;&quot;, TEXT(PRIORVALUE(First_Date_of_Health_Insurance_Coverage__c)) = &quot;&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ISM Checks Medical record date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 60 days before medical book expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_reminder_about_medical_book_expiry_date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Medical_Book_Expiry_Date__c</offsetFromField>
            <timeLength>-60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ISM Checks Passport Expiration Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 180 days before passport expiration date + second notification 90 days before expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_reminder_about_passport_expiry_date</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>ISM_Email_reminder_about_passport_expiry_date_to_staff_member</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Passport_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_reminder_about_passport_expiry_date_2nd</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>ISM_Email_reminder_about_passport_expiry_date_to_staff_member_2nd</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Passport_Expiration_Date__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ISM Checks Registration Expiration Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School__pc</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 7 days before a registration expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Sends_email_7_days_before_Registration_Expiry_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Registration_Expiry_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ISM Checks Visa%2FWork Permit Expiration Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Local_Other_nationality__c</field>
            <operation>notEqual</operation>
            <value>Local</value>
        </criteriaItems>
        <description>Sends an email 180 days before a visa/work permit expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_Reminder_about_Visa_Expiration</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Visa_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_Reminder_about_Work_Permit_Expiration</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Work_Permit_Expiration_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ISM Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>ISM_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>KCB Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>KCB_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>King&apos;s College Beijing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>King&apos;s College Beijing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>King&apos;s College Beijing</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Kompanion User Activation Reminder</fullName>
        <active>false</active>
        <description>Reminds system admin to activate a Kompanion user in cases where a parent user has been created and subsequently deactivated (because of starting date being pushed back) or where an old account is reactivated i.e. Rejected/Terminated or Left to In School</description>
        <formula>AND(  TEXT(School_Kompanion_Contact_Created__pc) = &quot;Yes&quot;,  Allow_App_Login__pc = FALSE,  School_Kompanion_App_Login_Info_Sent__pc = FALSE,  Enrolled__c = &quot;Yes&quot;  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Kompanion_User_Needs_Reactivating</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Starting_Date__c</offsetFromField>
            <timeLength>-14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>NAISM - Employment Application Auto-Reply</fullName>
        <actions>
            <name>NAISM_Auto_reply_to_Employment_Application</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.Applied_via_Website__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Auto_reply_Language__c</field>
            <operation>equals</operation>
            <value>English</value>
        </criteriaItems>
        <description>An auto-reply sent when someone submits a new employment application via the website</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>NAISM Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>NAISM_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NYIS Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>NYIS_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Account with Address Notification</fullName>
        <actions>
            <name>New_Account_with_Address_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>A notification to inform system admin to check and correct the addresses for a newly created account from an old enquiry that still used the old Main_Address__c field.</description>
        <formula>AND(     RecordType.DeveloperName = &quot;PersonAccount&quot;,     NOT(ISBLANK(Main_Address__c))     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28BCB%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the BCB user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28BISM%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_BISM</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the BISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28BSB%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>BSB Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the BSB user with the &quot;BSB Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28BSKL%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the BSKL user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28BSNJ%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the BSNJ user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28BSNV%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the BSNV user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28BST%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the BST user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28BSY%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the BSY user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28ISM%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the ISM user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28NAISM%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the NAISM user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28NYIS%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the NYIS user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Company Owner Assignment %28UIS%29</fullName>
        <actions>
            <name>Assign_Company_Record_Owner_UIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Company)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>Ukraine International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Company</value>
        </criteriaItems>
        <description>Triggers a field update when a company account is created to assign the account to the UIS user with the &quot;Record Owner (Company)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Employment Application Notification</fullName>
        <actions>
            <name>New_Employment_Application_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Applied_via_Website__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Triggers an email to be sent to the relevant user when a new employment application is received</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28BCB%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the BCB user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28BISM%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_BISM</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the BISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28BSB%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the BSB user with the &quot;BSB Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28BSKL%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_BSKL</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the BSKL user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28BSNJ%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_BSNJ</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the BSNJ user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28BSNV%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_BSNV</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the BSNV user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28BST%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_BST</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the BST user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28BSY%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_BSY</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the BSY user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28ISM%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_ISM</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the ISM user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28NAISM%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_NAISM</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the NAISM user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28NYIS%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_NYIS</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the NYIS user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Parent Owner Assignment %28UIS%29</fullName>
        <actions>
            <name>Assign_Parent_Record_Owner_UIS</name>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Triggers a field update when a parent account is created to assign the account to the UIS user with the &quot;Record Owner (Students, Parents, Contacts, Enquiries)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BCB%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the BCB HR user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BISM%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 4) AND 3</booleanFilter>
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
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the BISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BSB%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the relevant BSB Record Owner</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BSG%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BSG</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the BSG HR user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BSKL%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 4) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Staff Member)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the BSKL user with the &quot;Record Owner (Staff Member)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BSNJ%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 4) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Staff Member)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the BSNJ user with the &quot;Record Owner (Staff Member)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BSNV%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 4) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.UserRoleId</field>
            <operation>notContain</operation>
            <value>Record Owner (Staff Member)</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the BSNV user with the &quot;Record Owner (Staff Member)&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BST%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the BST HR user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28BSY%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the BSY HR user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28Group%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_Group</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member - Group Level</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the person responsible for managing group level staff members</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28ISM%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the ISM HR user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28NAISM%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the NAISM HR user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28NYIS%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the NYIS HR user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Staff Member Owner Assignment %28UIS%29</fullName>
        <actions>
            <name>Assign_Staff_Member_Record_Owner_UIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>Ukraine International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>Ukraine International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Staff Member</value>
        </criteriaItems>
        <description>Triggers a field update when a staff member account is created to assign the account to the UIS HR user</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Old Account Re-Activated 1</fullName>
        <actions>
            <name>Notify_Admissions_of_Account_Status_Changed_from_Inactive_to_Active_1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notification to update contact and address details (old contact field data available in Excel spreadsheet)</description>
        <formula>AND(     DATEVALUE(CreatedDate) &lt;= DATE(2014,03,29),      ISCHANGED(Family_Status__c),      OR(        PRIORVALUE(Family_Status__c) = &quot;Left&quot;,         PRIORVALUE(Family_Status__c) = &quot;Rejected/Terminated&quot;        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Old Account Re-Activated 2</fullName>
        <actions>
            <name>Notify_Admissions_of_Account_Status_Changed_from_Inactive_to_Active_2</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notification to update address details</description>
        <formula>AND(     DATEVALUE(CreatedDate) &lt;= DATE(2016,05,31),      DATEVALUE(CreatedDate) &gt; DATE(2014,03,29),      ISCHANGED(Family_Status__c),      OR(        PRIORVALUE(Family_Status__c) = &quot;Left&quot;,         PRIORVALUE(Family_Status__c) = &quot;Rejected/Terminated&quot;        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate %27Username must be unique%21%27 %28Account%29</fullName>
        <actions>
            <name>Populate_Username_must_be_unique_Acc</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Populates the &apos;Account.School_Kompanion_Username_UID__pc&apos; field (which is a text field that only accepts unique values) with the school name and contact username to ensure that it is unique for that school</description>
        <formula>ISCHANGED(School_Kompanion_Username__pc)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate F%2FInfo Email Copy Field</fullName>
        <actions>
            <name>Populate_F_Info_Email_Copy_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.F_Info_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate IT Notifications Email %28Account%29</fullName>
        <actions>
            <name>Populate_IT_Notifications_Email_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.IT_Notifications_Email_Account__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate P1 Emails on Create</fullName>
        <actions>
            <name>Populate_P1_Alternate_Email_on_Create</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_P1_Main_Email_on_Create</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Enquiry_ID__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Parent_1_Main_Email_from_Lead__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Parent_1_Alternate_Email_from_Lead__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Copies the values from the &apos;Parent 1 Email from Lead&apos; temp fields (which originate from the lead) to the relevant field of the first parent on the account. Required to meet validation issues caused by the standard convert function on the &apos;Email&apos; field.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate P1 Mobile Number on Create</fullName>
        <actions>
            <name>Populate_P1_Mobile_Number_on_Create</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Phone</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <description>Copies the value from the &apos;Phone&apos; field (which originates from the lead via the standard convert function but is hidden on the account page layout) to the mobile number field on the account contact for use when sending SMS</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Parent Survey URL Text Fields %28Account%29</fullName>
        <actions>
            <name>BR_Parent_Survey_URL_Update_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>EN_Parent_Survey_URL_Update_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ES_Parent_Survey_URL_Update_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>RU_Parent_Survey_URL_Update_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Company</value>
        </criteriaItems>
        <description>See notes on the Contact.Text_Parent_Survey_URL_EN__c for explanation of use</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Preferred Language Changed Manually</fullName>
        <actions>
            <name>Update_Preferred_Language_Source</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED (  Preferred_Language_for_Correspondence__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Resend Kompanion Login Info %28Account%29</fullName>
        <actions>
            <name>Resend_Kompanion_Login_Info_Email_Account</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Set_SK_Resend_Login_Info_to_FALSE_Acc</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(     School_Kompanion_App_Login_Info_Sent__pc = TRUE,     School_Kompanion_Resend_Login_Info__pc = TRUE,     TEXT(School_Kompanion_Contact_Created__pc) = &quot;Yes&quot;,     PersonContact.School_Kompanion_Allow_App_Login__c = TRUE,     NOT(ISBLANK(School_Kompanion_Username__pc)),     NOT(ISBLANK(School_Kompanion_Password__pc)),     NOT(ISBLANK(PersonEmail))     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Reset %26 Resend Portal Login Info %28Account%29</fullName>
        <actions>
            <name>Send_Portal_Login_Info_Account</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Change_Resend_Portal_Login_to_False</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Create_Portal_User_Password_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Resend_Portal_Login_Info__pc</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Automated Event Notification Email %28Next 2 Weeks Event%29 %28Account Alternate%29</fullName>
        <actions>
            <name>Send_Automated_Event_Notification_Email_Within_2_Weeks_Alternate</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.Related_Event_Trigger_First_Email_Send__pc</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Contact_Alternate_Email_Opt_Out__pc</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Contact_Alternate_Email__pc</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends a date notification to the alternate email address of all related parents (account) when the event falls within the next 2 weeks</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Automated Event Notification Email %28Next 2 Weeks Event%29 %28Account Main%29</fullName>
        <actions>
            <name>Send_Automated_Event_Notification_Email_Within_2_Weeks_Main</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.Related_Event_Trigger_First_Email_Send__pc</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.PersonHasOptedOutOfEmail</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.PersonEmail</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends a date notification to the main email address of all related parents (account) when the event falls within the next 2 weeks</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Calendar View Reminder Email %28Account Alternate%29</fullName>
        <actions>
            <name>Calendar_View_Reminder_Email_Account_Alternate</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.No_Calendar_View_Last_7_Days__pc</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Send_Calendar_View_Reminder_Email__pc</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Contact_Alternate_Email_Opt_Out__pc</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Contact_Alternate_Email__pc</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Triggered via a batch job that runs every Sunday, sends a generic reminder email to the alternate email address of all parents (accounts) that have not viewed the school calendar in the last 7 days</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Calendar View Reminder Email %28Account Main%29</fullName>
        <actions>
            <name>Calendar_View_Reminder_Email_Account_Main</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.No_Calendar_View_Last_7_Days__pc</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Send_Calendar_View_Reminder_Email__pc</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.PersonHasOptedOutOfEmail</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.PersonEmail</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Triggered via a batch job that runs every Sunday, sends a generic reminder email to the main email address of all parents (accounts) that have not viewed the school calendar in the last 7 days</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send F%2FInfo Email %28English%29</fullName>
        <actions>
            <name>F_Info_Request_English</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>F_Info_A_Response</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>F_Info_Email_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>F_Info_Request_Date_Time_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.F_Info_Request_Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Preferred_Language_for_Correspondence__c</field>
            <operation>notEqual</operation>
            <value>Portuguese</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send F%2FInfo Email %28Portuguese%29</fullName>
        <actions>
            <name>F_Info_Request_Portuguese</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>F_Info_A_Response</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>F_Info_Email_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>F_Info_Request_Date_Time_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.F_Info_Request_Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Preferred_Language_for_Correspondence__c</field>
            <operation>equals</operation>
            <value>Portuguese</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Health Insurance Expiry Email</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.Last_Date_of_Health_Insurance_Coverage__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends an email to inform that account owner that a staff member needs to be removed from the medical insurance policy in line with the &quot;Last Date of Health Insurance Coverage&quot; field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notification_for_Removal_from_Health_Insurance_Policy</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Account.Last_Date_of_Health_Insurance_Coverage__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Send Kompanion Welcome Email %28Account%29</fullName>
        <actions>
            <name>Send_Kompanion_Welcome_Email_Account</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Set_App_Login_Info_Sent_to_TRUE_Acc</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Setting School_Kompanion_App_Login_Info_Sent__pc to TRUE and PersonContact.School_Kompanion_Allow_App_Login__c to TRUE at the same time will allow a user to be generated without the email being sent to the contact.</description>
        <formula>AND(     TEXT(School_Kompanion_Contact_Created__pc) = &quot;Yes&quot;,     School_Kompanion_App_Login_Info_Sent__pc = FALSE,     PersonContact.School_Kompanion_Allow_App_Login__c = TRUE,     NOT(ISBLANK(School_Kompanion_Username__pc)),     NOT(ISBLANK(School_Kompanion_Password__pc)),     NOT(ISBLANK(PersonEmail))     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Portal Welcome Email %28Account%29</fullName>
        <actions>
            <name>Send_Portal_Welcome_Email_Account</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Check_Portal_User_Created_Field_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Create_Portal_User_Password_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2 AND 3)</booleanFilter>
        <criteriaItems>
            <field>Account.User__pc</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Portal_User_Created__pc</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Record_Type__c</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send Staff Directory Information Request %28New Website%29</fullName>
        <actions>
            <name>Send_Staff_Directory_Info_Request_Email_New_Website</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Populate_Staff_Directory_Info_Email_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(     RecordType.DeveloperName = &quot;Staff_Account&quot;,      User__pc != null,      User__pr.Staff_Directory_Info_Received__c != True,       Staff_Directory_Info_Request_Sent__c != True,      User__pr.Publish_on_School_Site__c != True,     TEXT(User__pr.School__c) != &quot;The British Schools Foundation&quot;     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Send SK Outbound Message to FALSE %28Account%29</fullName>
        <actions>
            <name>Set_Send_SK_Outbound_to_FALSE_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Send_School_Kompanion_Outbound_Message__c = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Trigger Notification Email Send to FALSE %28Account%29</fullName>
        <actions>
            <name>Related_Event_Trigger_Email_1_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Related_Event_Trigger_First_Email_Send__pc</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Changes the value of the &apos;Related Event Trigger First Email Send&apos; field to false, immediately after it&apos;s changed to true, so that future emails can be sent.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Source Lead Has Second Parent to FALSE</fullName>
        <actions>
            <name>Source_Lead_Has_Second_Parent_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(Related_Contact_Record_P2__c != &quot;&quot;,  Source_Lead_Has_Second_Parent__c = True)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Trigger Parent User Creation</fullName>
        <active>true</active>
        <booleanFilter>(1 AND (2 OR 3))</booleanFilter>
        <criteriaItems>
            <field>Account.User__pc</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Family_Status__c</field>
            <operation>equals</operation>
            <value>In School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Family_Status__c</field>
            <operation>equals</operation>
            <value>Future Enrolment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Trigger_Parent_User_Creation</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Account.Starting_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Trigger School Kompanion Account Update</fullName>
        <actions>
            <name>Account_to_School_Kompanion</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <formula>AND(     OR(        SchoolText__pc = &quot;The British School of Brasilia&quot;,        SchoolText__pc = &quot;The British International School of Kuala Lumpur&quot;,        CONTAINS(TEXT(Test_Account_Type__c), &quot;School Kompanion&quot;)        ),     Family_UID__c != null,     RecordType.DeveloperName = &quot;PersonAccount&quot;,     OR(        ISNEW(),        ISCHANGED(Send_School_Kompanion_Outbound_Message__c),         ISCHANGED(Salutation),        ISCHANGED(LastName),        ISCHANGED(FirstName),        ISCHANGED(PersonEmail),        ISCHANGED(Contact_Alternate_Email__pc),        ISCHANGED(Contact_Nationality__pc),        ISCHANGED(Contact_Relationship__pc),        ISCHANGED(Contact_Employment_Sector__pc),        ISCHANGED(Contact_Employer__pc),        ISCHANGED(Contact_Mobile_Main_Phone_Country_CodePL__pc),        ISCHANGED(Contact_Alternate_Phone_Country_CodePL__pc),        ISCHANGED(PersonMobilePhone),        ISCHANGED(Contact_Alternate_Phone__pc),        ISCHANGED(Address_Accommodation_Type__pc),        ISCHANGED(Address_Apartment_Unit_Number__pc),        ISCHANGED(Address_Apartment_Condominium_or_Communi__pc),        ISCHANGED(Address_House_Building_Number__pc),        ISCHANGED(Address_Street_Name__pc),        ISCHANGED(Address_Line_2__pc),        ISCHANGED(Address_City__pc),        ISCHANGED(Address_State_Province__pc),        ISCHANGED(Address_Zip_Postal_Code__pc),        ISCHANGED(Address_Country__pc),        ISCHANGED(Primary_Contact__c),        ISCHANGED(SK_App_Only_Experience__pc),        ISCHANGED(Allow_App_Login__pc),        ISCHANGED(School_Kompanion_Username__pc),         ISCHANGED(School_Kompanion_Password__pc),         AND(            PersonContact.School_Kompanion_Allow_App_Login__c = TRUE,            OR(               AND(                   ISCHANGED(School_Kompanion_Username__pc),                   NOT(ISBLANK(School_Kompanion_Username__pc))                   ),               AND(                   ISCHANGED(School_Kompanion_Password__pc),                   NOT(ISBLANK(School_Kompanion_Password__pc))                   )               )            ),        AND(            PersonContact.School_Kompanion_Allow_App_Login__c = FALSE,            OR(               ISCHANGED(School_Kompanion_Username__pc),               ISCHANGED(School_Kompanion_Password__pc)                  )            )        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Trigger Time-Based Send to Kompanion %28Account%29</fullName>
        <active>true</active>
        <formula>AND(  RecordType.DeveloperName = &quot;PersonAccount&quot;,  Trigger_Time_Based_Send_to_Kompanion__pc = TRUE  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Set_Send_SK_Outbound_to_TRUE_Account</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Set_Time_Based_K_Send_to_FALSE_Account</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>UIS Sync School Controlling Picklist Value</fullName>
        <actions>
            <name>UIS_Update_School_Controlling_Picklist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>Ukraine International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Company_School__c</field>
            <operation>equals</operation>
            <value>Ukraine International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>Ukraine International School</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School Controlling Picklist&apos; field to be used as a controlling field for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update bsghub PARENTS</fullName>
        <actions>
            <name>Update_bsghub_PARENTS</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <description>When account-parent is updated in sf, create an outbound message to update the paired user in bsghub.net</description>
        <formula>NOT($User.Username = &apos;directors@britishschools.co.uk&apos;) &amp;&amp; Record_Type__c  = &apos;Parent&apos; &amp;&amp; NOT(ISNEW())</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update bsghub STAFF</fullName>
        <actions>
            <name>Update_bsghub_staff</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <description>Every time an account is updated, send an outbound message to bsghub and update its paired user on the web.</description>
        <formula>NOT($User.Username = &apos;directors@britishschools.co.uk&apos;) &amp;&amp; Record_Type__c  = &apos;Staff Member&apos; &amp;&amp; NOT(ISNEW())</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>User Creation Error %28Account%29</fullName>
        <actions>
            <name>Notify_of_Error_in_Portal_User_Creation_Account</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(     ISCHANGED(Portal_User_Creation_Error__c),      Portal_User_Creation_Error__c = TRUE     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Warn of Mixed House Family</fullName>
        <actions>
            <name>Warn_of_Mixed_House_Family</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>BSKL Only</description>
        <formula>AND(     SchoolText__pc = &quot;The British International School of Kuala Lumpur&quot;,     OR(        AND(            Enrolled_Normans_Students_in_Family__c &gt; 0,            OR(               Enrolled_Romans_Students_in_Family__c &gt; 0,               Enrolled_Saxons_Students_in_Family__c &gt; 0,               Enrolled_Vikings_Students_in_Family__c &gt; 0               )            ),        AND(            Enrolled_Romans_Students_in_Family__c &gt; 0,            OR(               Enrolled_Normans_Students_in_Family__c &gt; 0,               Enrolled_Saxons_Students_in_Family__c &gt; 0,               Enrolled_Vikings_Students_in_Family__c &gt; 0               )            ),        AND(            Enrolled_Saxons_Students_in_Family__c &gt; 0,            OR(               Enrolled_Normans_Students_in_Family__c &gt; 0,               Enrolled_Romans_Students_in_Family__c &gt; 0,               Enrolled_Vikings_Students_in_Family__c &gt; 0               )            ),        AND(            Enrolled_Vikings_Students_in_Family__c &gt; 0,            OR(               Enrolled_Normans_Students_in_Family__c &gt; 0,               Enrolled_Romans_Students_in_Family__c &gt; 0,               Enrolled_Saxons_Students_in_Family__c &gt; 0               )            )        )    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Xero Contact ID Update Error</fullName>
        <actions>
            <name>Failed_to_Update_Xero_Contact_ID_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Failed_to_Update_Xero_Id__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Sends an email to system admin when a SF account cannot be populated with a Xero Contact ID because the same ID already exists on another SF account.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
