<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>BSG_Add_to_Register</fullName>
        <ccEmails>jean@bsg.org.cn</ccEmails>
        <ccEmails>admissions@bsg.org.cn</ccEmails>
        <description>BSG Add to Register</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Add_to_Register</template>
    </alerts>
    <alerts>
        <fullName>BSG_ISM_BST_BSY_Email_informing_of_A_Deposit_or_W_List_A_Deposit</fullName>
        <description>BSG/ISM/BST/BSY - Email informing of A/Deposit or W/List A/Deposit</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_to_Accounting_for_A_Deposit_or_W_List_A_Deposit</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_informing_of_A_Deposit_or_W_List_A_Deposit</fullName>
        <description>BSKL- Email informing of A/Deposit or W/List A/Deposit</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Email_to_Accounting_for_A_Deposit_or_W_List_A_Deposit</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_informing_of_Deposit_Paid</fullName>
        <description>BSKL- Email informing of Deposit Paid</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_Informing_of_Stage_Changed_to_Enrolled</template>
    </alerts>
    <alerts>
        <fullName>BSKL_New_Student_Starting</fullName>
        <ccEmails>secondary.frontdesk@britishschool.edu.my</ccEmails>
        <ccEmails>primary.frontdesk@britishschool.edu.my</ccEmails>
        <ccEmails>admissions@britishschool.edu.my</ccEmails>
        <ccEmails>service@britishschool.edu.my</ccEmails>
        <description>BSKL New Student Starting</description>
        <protected>false</protected>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BSKL_s_Email_Templates/BSKL_New_Student_Starting_in_30_Days</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Notification_about_Student_Left_W_No_Notice</fullName>
        <ccEmails>admissions@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.it@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.library@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.finance@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.nurse@britishschool.edu.my</ccEmails>
        <description>BSKL Notification about Student Left W/No Notice</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/BSKL_Student_Has_Left_W_No_Notice</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Student_Leaving_Procedure</fullName>
        <ccEmails>admissions@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.it@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.library@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.finance@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.nurse@britishschool.edu.my</ccEmails>
        <description>BSKL Student Leaving Procedure</description>
        <protected>false</protected>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/BSKL_NYIS_Student_Leaving_Procedure_Reminder</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Student_Passport_Expiration_Notice</fullName>
        <ccEmails>bskl.frontdesk@britishschool.edu.my</ccEmails>
        <description>BSKL Student Passport Expiration Notice</description>
        <protected>false</protected>
        <senderAddress>admissions@britishschool.edu.my</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BSKL_s_Email_Templates/BSKL_Student_Passport_Expiration_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Student_Visa_Permit_Expiration_Notice</fullName>
        <ccEmails>emma.cleary@britishschool.edu.my</ccEmails>
        <ccEmails>admissions@britishschool.edu.my</ccEmails>
        <ccEmails>bskl.frontdesk@britishschool.edu.my</ccEmails>
        <description>BSKL Student Visa/Permit Expiration Notice</description>
        <protected>false</protected>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BSKL_s_Email_Templates/BSKL_Student_Visa_Permit_Expiry_Date_Notice</template>
    </alerts>
    <alerts>
        <fullName>BST_New_student_for_local_authorities</fullName>
        <description>BST New student for local authorities</description>
        <protected>false</protected>
        <recipients>
            <recipient>BST_Head_of_Specialist_Staff</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BST_s_Email_Templates/BST_Local_notification_Enrolled</template>
    </alerts>
    <alerts>
        <fullName>BST_New_student_for_local_authorities_Left</fullName>
        <description>BST New student for local authorities (Left)</description>
        <protected>false</protected>
        <recipients>
            <recipient>BST_Head_of_Specialist_Staff</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BST_s_Email_Templates/BST_Local_notification_Left</template>
    </alerts>
    <alerts>
        <fullName>Change_of_Start_Date_within_30_Days_of_Start_Notification</fullName>
        <ccEmails>ben.hails@britishschools.co.uk</ccEmails>
        <description>Change of Start Date within 30 Days of Start Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Remove_Student_from_Student_Groups</template>
    </alerts>
    <alerts>
        <fullName>Check_student_visa_application</fullName>
        <ccEmails>admissions@britishschool.edu.my</ccEmails>
        <description>Check student visa application</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Check_Student_Visa_Application</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Add_Student_to_Tutor_Group</fullName>
        <description>Grp/Adm - Add Student to Tutor Group</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Add_Student_to_Tutor_Group</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_Change_in_EAL_Dates</fullName>
        <description>Grp/Adm - Email Change in EAL Dates</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_informing_change_in_EAL</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_Change_in_Leaving_Date</fullName>
        <description>Grp/Adm - Email Change in Leaving Date</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_informing_change_of_leaving_date</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_Change_in_Start_Date</fullName>
        <description>Grp/Adm - Email Change in Start Date</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_informing_change_of_starting_date</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_Change_in_Year_Group</fullName>
        <description>Grp/Adm - Email Change in Year Group</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_informing_change_of_year_group_or_h_day_field</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_Informing_that_a_bus_price_tier_needs_to_be_assigned</fullName>
        <description>Grp/Adm - Email Informing that a bus price tier needs to be assigned</description>
        <protected>false</protected>
        <recipients>
            <field>Bus_Coordinator_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Assign_Bus_Service_Price_Tier</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_informing_of_A_Deposit_or_W_List_A_Deposit_Status_of_F_Info_Reques</fullName>
        <description>Grp/Adm - Email informing of A/Deposit or W/List A/Deposit + Status of F/Info Request</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_Informing_of_Stage_Changed_to_A_Deposit_and_F_Info_Request_Status</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_informing_of_Assessment_Fee_payment</fullName>
        <description>Grp/Adm - Email informing of Assessment Fee payment</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Grp_Adm_Email_informing_of_Application_Fee_Paid</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_informing_of_Change_in_Bus_Service_or_Price_Tier</fullName>
        <description>Grp/Adm - Email informing of Change in Bus Service or Price Tier</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Change_in_Bus_Service_or_Bus_Service_Price_Tier</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_informing_of_Deposit_Paid_Enrolled</fullName>
        <description>Grp/Adm - Email informing of Deposit Paid (Enrolled)</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_Informing_of_Stage_Changed_to_Enrolled</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_informing_of_Deposit_Paid_W_List</fullName>
        <description>Grp/Adm - Email informing of Deposit Paid (W/List)</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_Informing_of_Stage_Changed_to_W_List_D_Paid</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_informing_of_Left_Cancelled_Rejected</fullName>
        <description>Grp/Adm - Email informing of Left/Cancelled/Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Email_to_Accounting_for_Left_Cancelled_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_requesting_application_fee_invoice</fullName>
        <description>Grp/Adm - Email requesting application fee invoice</description>
        <protected>false</protected>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Create_Application_Fee_Invoice</template>
    </alerts>
    <alerts>
        <fullName>Grp_Adm_Email_requesting_assignment_of_bus_service</fullName>
        <description>Grp/Adm - Email requesting assignment of bus service</description>
        <protected>false</protected>
        <recipients>
            <field>Bus_Coordinator_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/Grp_Adm_Assign_Bus_Service</template>
    </alerts>
    <alerts>
        <fullName>Invalid_Student_Email_Notification_Opp</fullName>
        <description>Invalid Student Email Notification</description>
        <protected>false</protected>
        <recipients>
            <field>IT_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BISM_s_Email_Templates/Invalid_Email_Address_Notification_Opp</template>
    </alerts>
    <alerts>
        <fullName>Kompanion_User_s_Needs_Deactivating</fullName>
        <description>Kompanion User(s) Needs Deactivating</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Sys_Adm_Kompanion_User_Needs_Deactivating</template>
    </alerts>
    <alerts>
        <fullName>Leaving_Notice_Submitted_Email_sent_to_Admissions_Officer</fullName>
        <description>Leaving Notice Submitted- Email sent to Admissions Officer</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/Student_Leaving_Notice_Submitted</template>
    </alerts>
    <alerts>
        <fullName>NYIS_Student_Leaving_Procedure</fullName>
        <ccEmails>admin@nyis.org</ccEmails>
        <description>NYIS Student Leaving Procedure</description>
        <protected>false</protected>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Admissions_Procedure_Notifications/BSKL_NYIS_Student_Leaving_Procedure_Reminder</template>
    </alerts>
    <alerts>
        <fullName>New_Email_Account_required_for_Student</fullName>
        <ccEmails>itdepartment@britishschool.edu.my</ccEmails>
        <description>New Email Account required for Student</description>
        <protected>false</protected>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/New_Email_Account_required_for_Student</template>
    </alerts>
    <alerts>
        <fullName>New_Student_Created_Manually_Notification</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>New Student Created Manually Notification</description>
        <protected>false</protected>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Sys_Adm_New_Student_Created_Manually_Notification</template>
    </alerts>
    <alerts>
        <fullName>New_Student_Created_With_Possible_Duplicates_Notification</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>New Student Created With Possible Duplicates Notification</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Sys_Adm_New_Student_Created_With_Possible_Duplicates_Notification</template>
    </alerts>
    <alerts>
        <fullName>New_Student_Renumbering_Exception_Notification</fullName>
        <description>New Student Renumbering Exception Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Sys_Adm_New_Student_Renumbering_Exception_Notification</template>
    </alerts>
    <alerts>
        <fullName>New_asset_required_for_secondary_student_KRY</fullName>
        <description>New asset required for secondary student KRY</description>
        <protected>false</protected>
        <recipients>
            <recipient>rainbow.integration@nordanglia.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_Asset_required_for_Secondary_student_KRY</template>
    </alerts>
    <alerts>
        <fullName>New_asset_required_for_secondary_student_ROS</fullName>
        <description>New asset required for secondary student ROS</description>
        <protected>false</protected>
        <recipients>
            <recipient>rainbow.integration@nordanglia.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_Asset_required_for_Secondary_student_ROS</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_Enrolled_Student_with_Invalid_Student_Number</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>Notify of Enrolled Student with Invalid Student Number</description>
        <protected>false</protected>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Sys_Adm_Inform_of_Invalid_Student_Number</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_Enrolled_Student_without_Academic_File</fullName>
        <ccEmails>anton.simanikhin@britishschools.co.uk</ccEmails>
        <description>Notify of Enrolled Student without Academic File</description>
        <protected>false</protected>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Sys_Adm_Inform_of_Enrolled_Student_without_Academic_File</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_Invalid_Student_in_Kompanion</fullName>
        <description>Notify of Invalid Student in Kompanion</description>
        <protected>false</protected>
        <recipients>
            <recipient>rainbow.integration@nordanglia.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/Sys_Adm_Kompanion_Records_Need_Deleting</template>
    </alerts>
    <alerts>
        <fullName>Send_notification_about_A_Deposit_Attending_School_student_30_days_after_startin</fullName>
        <description>Send notification about A/Deposit &amp; Attending School student 30 days after starting date</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Invoicing_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/Grp_Adm_A_Deposit_Attending_School_more_than_30_days</template>
    </alerts>
    <alerts>
        <fullName>Special_Considerations_Notification</fullName>
        <description>Special Considerations Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>BSKL_School_Nurse</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>admissions@britishschool.edu.my</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BSKL_s_Email_Templates/New_Student_Medical_Needs</template>
    </alerts>
    <alerts>
        <fullName>Student_Email_needs_to_be_suspended</fullName>
        <ccEmails>bskl.it@britishschool.edu.my</ccEmails>
        <description>Student Email needs to be suspended</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Student_Email_Needs_to_be_Suspended</template>
    </alerts>
    <alerts>
        <fullName>Student_Starting_Date_Change_Count_4_Notification</fullName>
        <description>Student Starting Date Change Count = 4 Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Student_Starting_Date_Change_Count_4</template>
    </alerts>
    <alerts>
        <fullName>Sys_Adm_Student_Starting_Tomorrow</fullName>
        <description>Sys/Adm - Student Starting Tomorrow</description>
        <protected>false</protected>
        <recipients>
            <field>Admissions_Notifications_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>notifications@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>All_School_Templates/Grp_Adm_Email_for_Academic_Preparation</template>
    </alerts>
    <alerts>
        <fullName>Year_Group_Grade_Discrepancy_Warning</fullName>
        <description>Year Group / Grade Discrepancy Warning</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Year_Group_Grade_Discrepancy_Warning</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_BCB</fullName>
        <description>Sets the opportunity owner to the BCB user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>carla.basile@britishcollegebrazil.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_BISM</fullName>
        <description>Sets the opportunity owner to the BISM user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_BSB</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_BSKL</fullName>
        <description>Sets the opportunity owner to the BSKL user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>admissions@britishschool.edu.my</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_BSNJ</fullName>
        <description>Sets the opportunity owner to the BSNJ user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_BSNV</fullName>
        <description>Sets the opportunity owner to the BSNV user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_BST</fullName>
        <description>Sets the opportunity owner to the BST user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>elena.savtsova@britishschool.uz</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_BSY</fullName>
        <field>OwnerId</field>
        <lookupValue>carolyn.bickerton@britishschoolyangon.org</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_ISM</fullName>
        <description>Sets the opportunity owner to the ISM user with the role &quot;Record Owner&quot;</description>
        <field>OwnerId</field>
        <lookupValue>maria.ezhova@internationalschool.ru</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_NAISM</fullName>
        <field>OwnerId</field>
        <lookupValue>tj.torres@naismanila.edu.ph</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_NYIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Opportunity_Record_Owner_UIS</fullName>
        <field>OwnerId</field>
        <lookupValue>nae.migration@britishschools.co.uk</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Assign Opportunity Record Owner (UIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BCB_Update_App_Fee_Paid_to_TRUE</fullName>
        <field>Assessment_Fee__c</field>
        <literalValue>1</literalValue>
        <name>BCB Update App Fee Paid to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_April_Starter_to_False</fullName>
        <field>April_Starter__c</field>
        <literalValue>0</literalValue>
        <name>Change April Starter to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_April_Starter_to_True</fullName>
        <field>April_Starter__c</field>
        <literalValue>1</literalValue>
        <name>Change April Starter to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_Left</fullName>
        <field>StageName</field>
        <literalValue>Left</literalValue>
        <name>Change to Left</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_to_Left_Next_Day</fullName>
        <field>StageName</field>
        <literalValue>Left</literalValue>
        <name>Change to Left (Next Day)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Brazilian</fullName>
        <field>Brazilian__c</field>
        <literalValue>1</literalValue>
        <name>Check Brazilian</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Filipino</fullName>
        <field>Filipino__c</field>
        <literalValue>1</literalValue>
        <name>Check Filipino</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Has_Been_Enrolled_Field</fullName>
        <field>Has_Been_Enrolled__c</field>
        <literalValue>1</literalValue>
        <name>Check Has_Been_Enrolled__c Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Hong_Kong</fullName>
        <field>Hong_Kong__c</field>
        <literalValue>1</literalValue>
        <name>Check Hong Kong</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Korean</fullName>
        <field>Korean__c</field>
        <literalValue>1</literalValue>
        <name>Check Korean</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Malaysian</fullName>
        <field>Malaysian__c</field>
        <literalValue>1</literalValue>
        <name>Check Malaysian</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Myanmar</fullName>
        <field>Myanmar__c</field>
        <literalValue>1</literalValue>
        <name>Check Myanmar</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Russian</fullName>
        <field>Russian__c</field>
        <literalValue>1</literalValue>
        <name>Check Russian</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Spanish</fullName>
        <field>Spanish__c</field>
        <literalValue>1</literalValue>
        <name>Check Spanish</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Trigger_30_Day_Admissions_Notific</fullName>
        <field>Trigger_30_Day_Admissions_Notification__c</field>
        <literalValue>1</literalValue>
        <name>Check Trigger 30 Day Admissions Notific.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_US_Year_Group_Control_Opp</fullName>
        <field>US_Year_Group_Control__c</field>
        <literalValue>1</literalValue>
        <name>Check US Year Group Control (Opp)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Uzbek</fullName>
        <field>Uzbek__c</field>
        <literalValue>1</literalValue>
        <name>Check Uzbek</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Attending_School_value</fullName>
        <field>Add_to_Register__c</field>
        <name>Clear &apos;Attending School&apos; value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_FTE_Value_Adjustment</fullName>
        <field>FTE_Value_Adjustment__c</field>
        <name>Clear FTE Value Adjustment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_FTE_Value_Adjustment_Date</fullName>
        <field>FTE_Value_Adjustment_Date__c</field>
        <name>Clear FTE Value Adjustment Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Half_Day_Value_if_Invalid</fullName>
        <field>Half_Day_PN_N__c</field>
        <name>Clear Half Day Value if Invalid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Starting_Date_for_KPIs_Value</fullName>
        <field>Starting_Date_for_KPIs__c</field>
        <name>Clear Starting Date (for KPIs) Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Class_N_Yr_to_Class_N_Yr_Copy</fullName>
        <field>Class_Next_Year_Copy__c</field>
        <formula>IF(
   CONTAINS(TEXT(Class_Next_Year__c), &quot;Pending&quot;),
   &quot;**&quot;&amp;TEXT(Class_Next_Year__c)&amp;&quot;**&quot;,
   TEXT(Class_Next_Year__c)
   )</formula>
        <name>Copy Class N.Yr to Class N.Yr Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Class_to_Class_Copy</fullName>
        <field>Class_Copy__c</field>
        <formula>IF(
   CONTAINS(TEXT(Class__c), &quot;Pending&quot;),
   &quot;**&quot;&amp;TEXT(Class__c)&amp;&quot;**&quot;,
   TEXT(Class__c)
   )</formula>
        <name>Copy Class to Class Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_House_N_Yr_to_House_N_Yr_Copy</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>IF(
   TEXT(House_Next_Year__c)=&quot;Pending&quot;,
   &quot;**Pending**&quot;,
   TEXT(House_Next_Year__c)
   )</formula>
        <name>Copy House N.Yr to House N.Yr Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_House_to_House_Copy</fullName>
        <field>House_Copy__c</field>
        <formula>IF(
   TEXT(House__c)=&quot;Pending&quot;,
   &quot;**Pending**&quot;,
   TEXT(House__c)
   )</formula>
        <name>Copy House to House Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EAL_Class_List_Checkbox_Check</fullName>
        <field>EAL__c</field>
        <literalValue>1</literalValue>
        <name>EAL Class List Checkbox Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EAL_Class_List_Checkbox_Uncheck</fullName>
        <field>EAL__c</field>
        <literalValue>0</literalValue>
        <name>EAL Class List Checkbox Uncheck</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>F_Info_Bus_Service_Required_Acc_Upd2</fullName>
        <field>F_Info_Bus_Service__c</field>
        <literalValue>0</literalValue>
        <name>F/Info Bus Service Required (Acc Upd2)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>F_Info_Bus_Service_Required_Opp_Update</fullName>
        <description>Updates bus service required field when a new financial information form is submitted by the parent with the relevant field checked.</description>
        <field>Bus_Service_Required__c</field>
        <literalValue>1</literalValue>
        <name>F/Info Bus Service Required (Opp Update)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>F_Info_Required</fullName>
        <description>Updates the relevant field in account to pending in order to trigger the f/info email to be sent</description>
        <field>F_Info_Request_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>F/Info Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Student_Email_Opp</fullName>
        <field>Student_Email__c</field>
        <formula>IF(TEXT(Owner.School__c) = &quot;The British School of Nanjing&quot;, LOWER(SUBSTITUTE(Student_Name__c,&quot; &quot;,&quot;&quot;)) &amp;&quot;.&quot;&amp; LOWER(SUBSTITUTE(Student_Surname__c,&quot; &quot;,&quot;&quot;)) &amp; &quot;@students.bsn.org.cn&quot;, 

LOWER(SUBSTITUTE(Student_Name__c,&quot; &quot;,&quot;&quot;)) &amp;&quot;.&quot;&amp; LOWER(SUBSTITUTE(Student_Surname__c,&quot; &quot;,&quot;&quot;))&amp;Owner.Email_Domain_Extension__c)</formula>
        <name>Generate Student Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Student_Full_Name</fullName>
        <field>Name</field>
        <formula>Student_Surname__c &amp;&quot;, &quot;&amp; Student_Name__c</formula>
        <name>Generate Student Full Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Student_Password</fullName>
        <field>Student_Email_Password__c</field>
        <formula>IF(
   OR(
      TEXT(Year_Group__c)=&quot;Y1&quot;, 
      TEXT(Year_Group__c)=&quot;Y2&quot;, 
      TEXT(Year_Group__c)=&quot;Y3&quot;, 
      TEXT(Year_Group__c)=&quot;K&quot;,
      TEXT(Year_Group__c)=&quot;G1&quot;,
      TEXT(Year_Group__c)=&quot;G2&quot;),
      Graduation_Year__c&amp;&quot;ict&quot;&amp; LOWER(Owner.School_Abbreviation__c), 

      IF(
         OR(
            TEXT(Year_Group__c)=&quot;Y4&quot;, 
            TEXT(Year_Group__c)=&quot;Y5&quot;, 
            TEXT(Year_Group__c)=&quot;Y6&quot;,
            TEXT(Year_Group__c)=&quot;G3&quot;,
            TEXT(Year_Group__c)=&quot;G4&quot;,
            TEXT(Year_Group__c)=&quot;G5&quot;),
            LOWER(LEFT(Student_Name__c, 1))&amp;LOWER(LEFT(Student_Surname__c, 1))&amp;&quot;0&quot;&amp;RIGHT(Student_Number_New__c, 6),

            IF(
               OR(
                  TEXT(Year_Group__c)=&quot;Y7&quot;, 
                  TEXT(Year_Group__c)=&quot;Y8&quot;, 
                  TEXT(Year_Group__c)=&quot;Y9&quot;, 
                  TEXT(Year_Group__c)=&quot;Y10&quot;, 
                  TEXT(Year_Group__c)=&quot;Y11&quot;, 
                  TEXT(Year_Group__c)=&quot;Y12&quot;, 
                  TEXT(Year_Group__c)=&quot;Y13&quot;, 
                  TEXT(Year_Group__c)=&quot;G6&quot;,
                  TEXT(Year_Group__c)=&quot;G7&quot;,
                  TEXT(Year_Group__c)=&quot;G8&quot;,
                  TEXT(Year_Group__c)=&quot;G9&quot;,
                  TEXT(Year_Group__c)=&quot;G10&quot;,
                  TEXT(Year_Group__c)=&quot;G11&quot;,
                  TEXT(Year_Group__c)=&quot;G12&quot;),
                  LEFT(TEXT(DAY(CloseDate)), 2)&amp;LOWER(LEFT(Student_Name__c, 1))&amp;LOWER(LEFT(Student_Surname__c, 1))&amp;RIGHT(Student_Number_New__c, 3)&amp;LOWER(LEFT(Account.FirstName, 1))&amp;LOWER(LEFT(Account.LastName, 1)),

&quot;&quot;)))</formula>
        <name>Generate Student Password (Opportunity)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Bus_Price_Tier_Assignment_Sent</fullName>
        <description>Checks a box when the bus price tier assignment email is sent to prevent repeat emails being sent relevant to the same student.</description>
        <field>Assign_Bus_Tier_Email_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Grp/Adm - Bus Price Tier Assignment Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Enrolled_Email_Sent</fullName>
        <description>Prevents an enrolled email being sent more than once when the opportunity product &apos;school&apos; field is updated</description>
        <field>Enrolled_Email_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Grp/Adm - Enrolled Email Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Pop_Prior_EAL_Classification</fullName>
        <field>EAL_Classification_Prior_Value__c</field>
        <formula>TEXT(PRIORVALUE(EAL_Classification__c))</formula>
        <name>Grp/Adm - Pop. Prior EAL Classification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_B_Serv_Required</fullName>
        <field>Bus_Service_Required_Prior_Value__c</field>
        <formula>IF ( PRIORVALUE ( Bus_Service_Required__c ) = TRUE, &quot;TRUE&quot;, &quot;FALSE&quot; )</formula>
        <name>Grp/Adm - Populate Prior B/Serv Required</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_EAL_End_Date</fullName>
        <field>EAL_End_Date_Prior_Value__c</field>
        <formula>PRIORVALUE( EAL_End_Date__c )</formula>
        <name>Grp/Adm - Populate Prior EAL End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_EAL_Start_Date</fullName>
        <field>EAL_Start_Date_Prior_Value__c</field>
        <formula>PRIORVALUE( EAL_Start_Date__c )</formula>
        <name>Grp/Adm - Populate Prior EAL Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_H_Day_Value</fullName>
        <field>Half_Day_Prior_Value__c</field>
        <formula>TEXT ( PRIORVALUE ( Half_Day_PN_N__c ) )</formula>
        <name>Grp/Adm - Populate Prior H/Day Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_Leaving_Date</fullName>
        <field>Leaving_Date_Prior_Value__c</field>
        <formula>PRIORVALUE( Leaving_Date__c )</formula>
        <name>Grp/Adm - Populate Prior Leaving Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_Price_Tier</fullName>
        <field>Bus_Service_Price_Tier_Prior_Value__c</field>
        <formula>TEXT ( PRIORVALUE ( Bus_Service_Price_Tier__c ) )</formula>
        <name>Grp/Adm - Populate Prior Price Tier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_Stage</fullName>
        <field>Stage_Prior_Value__c</field>
        <formula>TEXT(PRIORVALUE(StageName))</formula>
        <name>Grp/Adm - Populate Prior Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_Start_Date</fullName>
        <field>Start_Date_Prior_Value__c</field>
        <formula>PRIORVALUE( CloseDate )</formula>
        <name>Grp/Adm - Populate Prior Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grp_Adm_Populate_Prior_Year_Group</fullName>
        <field>Year_Group_Prior_Value__c</field>
        <formula>TEXT( PRIORVALUE( Year_Group__c ) )</formula>
        <name>Grp/Adm - Populate Prior Year Group</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Leaving_Notice_Date</fullName>
        <description>Updates leaving notice date field with date which online form was submitted</description>
        <field>Leaving_Notice_Date__c</field>
        <formula>Today()</formula>
        <name>Leaving Notice Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Application_Date_Adjusted</fullName>
        <field>Application_Date_Adjusted__c</field>
        <formula>TODAY()</formula>
        <name>Populate Application Date (Adjusted)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Application_Date_Initial</fullName>
        <field>Application_Date__c</field>
        <formula>TODAY()</formula>
        <name>Populate Application Date (Initial)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Auto_Audit_Start_Date_Copy</fullName>
        <field>Auto_Audit_Start_Date_Copy__c</field>
        <formula>Auto_Audit_Start_Date__c</formula>
        <name>Populate Auto-Audit Start Date Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Campus_Text</fullName>
        <field>Campus_Text__c</field>
        <formula>IF(AND(School__c = &quot;The British College of Brazil&quot;, OR(TEXT(Class__c) = &quot;I&quot;, TEXT(Class__c) = &quot;J&quot;, TEXT(Class__c) = &quot;K&quot;, TEXT(Class__c) = &quot;L&quot;, TEXT(Class__c) = &quot;M&quot;, TEXT(Class__c) = &quot;N&quot;, TEXT(Class__c) = &quot;O&quot;, TEXT(Class__c) = &quot;P&quot;, TEXT(Class__c) = &quot;Pending (Campus 2: I-P)&quot;)), &quot;Campus Cidade Jardim&quot;, 

IF(AND(School__c = &quot;The British College of Brazil&quot;, OR(TEXT(Class__c) = &quot;A&quot;, TEXT(Class__c) = &quot;B&quot;, TEXT(Class__c) = &quot;C&quot;, TEXT(Class__c) = &quot;D&quot;, TEXT(Class__c) = &quot;E&quot;, TEXT(Class__c) = &quot;F&quot;, TEXT(Class__c) = &quot;G&quot;, TEXT(Class__c) = &quot;H&quot;, TEXT(Class__c) = &quot;Pending (Campus 1: A-H)&quot;)), &quot;Campus Chácara Flora&quot;, 


IF(AND(School__c = &quot;The International School of Moscow&quot;, OR(TEXT(Class__c) = &quot;I&quot;, TEXT(Class__c) = &quot;J&quot;, TEXT(Class__c) = &quot;K&quot;, TEXT(Class__c) = &quot;L&quot;, TEXT(Class__c) = &quot;M&quot;, TEXT(Class__c) = &quot;N&quot;, TEXT(Class__c) = &quot;O&quot;, TEXT(Class__c) = &quot;P&quot;, TEXT(Class__c) = &quot;Pending (Campus 2: I-P)&quot;)), &quot;Rosinka Campus&quot;, 


IF(AND(School__c = &quot;The International School of Moscow&quot;, OR(TEXT(Class__c) = &quot;A&quot;, TEXT(Class__c) = &quot;B&quot;, TEXT(Class__c) = &quot;C&quot;, TEXT(Class__c) = &quot;D&quot;, TEXT(Class__c) = &quot;E&quot;, TEXT(Class__c) = &quot;F&quot;, TEXT(Class__c) = &quot;G&quot;, TEXT(Class__c) = &quot;H&quot;, TEXT(Class__c) = &quot;Pending (Campus 1: A-H)&quot;)), &quot;Krylatskoe Campus&quot;, &quot;&quot;))))</formula>
        <name>Populate Campus Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Date_Confirmed_Paid</fullName>
        <field>Date_Confirmed_Paid__c</field>
        <formula>TODAY()</formula>
        <name>Populate Date Confirmed Paid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Deposit_Paid_Date</fullName>
        <field>Deposit_Paid_Date__c</field>
        <formula>TODAY()</formula>
        <name>Populate Deposit Paid Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_FTE_Value_Adjustment</fullName>
        <field>FTE_Value_Adjustment__c</field>
        <formula>IF(
   AND(                                      /* Custom FTE Value changed from blank to non-blank AND half day value changed */
       ISCHANGED(Custom_FTE_Value__c),
       ISBLANK(PRIORVALUE(Custom_FTE_Value__c)),
       ISCHANGED(Half_Day_PN_N__c)           /* change will be from morning/afternoon to blank or vice versa as */
       ),                                    /*   enforced in the workflow rule, thus changing the FTE value  */   
   IF(
      AND( 
          ISBLANK(PRIORVALUE(Half_Day_PN_N__c)),
          NOT(ISBLANK(TEXT(Half_Day_PN_N__c))) 
          ),
      Custom_FTE_Value__c - 1,
      Custom_FTE_Value__c - 0.5
      ),
   
   IF(
      AND(                                      /* Custom FTE Value changed from non-blank to blank AND half day value changed */
          ISCHANGED(Custom_FTE_Value__c),  
          ISBLANK(Custom_FTE_Value__c),
          ISCHANGED(Half_Day_PN_N__c)           /* change will be from morning/afternoon to blank or vice versa as */ 
          ),                                    /* enforced in the workflow rule, thus changing the FTE value  */   
      IF(
         AND( 
             ISBLANK(PRIORVALUE(Half_Day_PN_N__c)),
             NOT(ISBLANK(TEXT(Half_Day_PN_N__c))) 
             ),
         0.5 - PRIORVALUE(Custom_FTE_Value__c),
         1 - PRIORVALUE(Custom_FTE_Value__c)
         ),
      IF(
         AND(                                   /* Custom FTE Value changed from one value to another i.e. neither blank */
             ISCHANGED(Custom_FTE_Value__c),
             NOT(ISBLANK(Custom_FTE_Value__c)),
             NOT(ISBLANK(PRIORVALUE(Custom_FTE_Value__c)))
             ),
         Custom_FTE_Value__c - PRIORVALUE(Custom_FTE_Value__c),
         IF(
            AND(                                /* Custom FTE Value changed AND half day value not changed */
                ISCHANGED(Custom_FTE_Value__c),
                NOT(ISCHANGED(Half_Day_PN_N__c))
                ),
            IF(
               ISBLANK(PRIORVALUE(Custom_FTE_Value__c)),
               IF(
                  NOT(ISBLANK(TEXT(Half_Day_PN_N__c))),
                  Custom_FTE_Value__c - 0.5,
                  Custom_FTE_Value__c - 1.0
                  ),
               IF(                              /* Only possible else scenario = ISBLANK(Custom_FTE_Value__c) */
                  NOT(ISBLANK(TEXT(Half_Day_PN_N__c))),
                  0.5 - PRIORVALUE(Custom_FTE_Value__c),
                  1.0 - PRIORVALUE(Custom_FTE_Value__c)
                  )
               ),                                         
            IF(
               AND(                             /* Half day value changed from blank to non-blank and custom FTE value not changed (i.e. else) */
                   ISCHANGED(Half_Day_PN_N__c), 
                   ISBLANK(PRIORVALUE(Half_Day_PN_N__c)), 
                   NOT(ISBLANK(TEXT(Half_Day_PN_N__c))),
                   NOT(ISCHANGED(Custom_FTE_Value__c))
                   ),
               -0.5,
               IF(
                  AND(                          /* Half day value changed from non-blank to blank and custom FTE value not changed (i.e. else) */
                      ISCHANGED(Half_Day_PN_N__c), 
                      NOT(ISBLANK(PRIORVALUE(Half_Day_PN_N__c))), 
                      ISBLANK(TEXT(Half_Day_PN_N__c)),
                      NOT(ISCHANGED(Custom_FTE_Value__c))
                      ),
                  0.5,
                  null
                  ) 
               )
            ) 
         )
      )
   )


/*

1) The final &apos;null&apos; value should never occur and is just included as the final &apos;else&apos; so that the actual logic test and value if true can be illustrated on the line above 

*/</formula>
        <name>Populate FTE Value Adjustment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_FTE_Value_Adjustment_Date</fullName>
        <field>FTE_Value_Adjustment_Date__c</field>
        <formula>IF(
   FTE_Value_Adjustment__c &lt; 0,
   TODAY() - CASE(WEEKDAY(TODAY()), 2,0, 3,1, 4,2, 5,3, 6,4, 7,5, 6),
   IF(
      TODAY() &lt; Related_School__r.Start_Date_T1_TY__c,
      Related_School__r.Start_Date_T1_TY__c - CASE(WEEKDAY(Related_School__r.Start_Date_T1_TY__c), 2,0, 3,1, 4,2, 5,3, 6,4, 7,5, 6),
      IF(
         AND(
             TODAY() &gt;= Related_School__r.Start_Date_T1_TY__c,
             TODAY() &lt;= Related_School__r.Financial_Year_Cut_Off_Date_TY_NAE__c
             ),
         TODAY() - CASE(WEEKDAY(TODAY()), 2,0, 3,1, 4,2, 5,3, 6,4, 7,5, 6),
         IF(
            TODAY() &gt; Related_School__r.Financial_Year_Cut_Off_Date_TY_NAE__c,
            Related_School__r.Start_Date_T1_NY__c - CASE(WEEKDAY(Related_School__r.Start_Date_T1_NY__c), 2,0, 3,1, 4,2, 5,3, 6,4, 7,5, 6),
            null
            )
         )
      )
   )
  
/* 

1) We always set the &apos;FTE Value Adjustment Date&apos; to the Monday of any given week so that the &apos;FTE Adjustment Value&apos; can be removed exactly 2 weeks later by means of time-based workflow

2) The final &apos;null&apos; value should never occur and is just included as the final &apos;else&apos; so that the actual logic test and value if true can be illustrated on the line above

*/</formula>
        <name>Populate FTE Value Adjustment Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Has_Attended_School_Date_Conf</fullName>
        <field>Has_Attended_School_Date_Confirmed__c</field>
        <formula>IF(
   Has_Attended_School__c = TRUE,
   TODAY(),
   null
   )</formula>
        <name>Populate Has Attended School (Date Conf)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_IT_Notifications_Email_Opp</fullName>
        <field>IT_Notifications_Email__c</field>
        <formula>CASE( Owner_School__c ,

&quot;The British International School of Kuala Lumpur&quot;, &quot;it-notifications@britishschool.edu.my&quot;,

&quot;The International School of Moscow&quot;, &quot;it-notifications@internationalschool.ru&quot;,

&quot;The British School of Nanjing&quot;, &quot;it-notifications@bsn.org.cn&quot;,

&quot;The British International School of Marbella&quot;, &quot;it-notifications@bsm.org.es&quot;,

&quot;The British School of Navarra&quot;, &quot;it-notifications@bsn.org.es&quot;,

&quot;The British School of Tashkent&quot;, &quot;it-notifications@britishschool.uz&quot;,

&quot;Nord Anglia International School Manila&quot;, &quot;it-notifications@kings.org.ph&quot;,

&quot;The British School Yangon&quot;, &quot;it-notifications@britishschoolyangon.org&quot;,

&quot;The British College of Brazil&quot;, &quot;it-notifications@britishcollegebrazil.org&quot;,

&quot;The British School of Brasilia&quot;, &quot;it-notifications@britishschoolbrasilia.org&quot;,

&quot;The New York International School&quot;, &quot;it-notifications@nyis.org&quot;,

&quot;it-notifications@britishschools.co.uk&quot;)</formula>
        <name>Populate IT Notifications Email(Opp)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Last_SK_Outbound_Message_Sent</fullName>
        <field>Last_SK_Outbound_Message_Sent__c</field>
        <formula>NOW()</formula>
        <name>Populate Last SK Outbound Message Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Latest_A_Deposit_Date</fullName>
        <field>A_Deposit_Date__c</field>
        <formula>TODAY()</formula>
        <name>Populate Latest A/ Deposit Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Leaving_Date_for_KPIs</fullName>
        <field>Leaving_Date_for_KPIs__c</field>
        <formula>IF(
   AND(
       OR(
          PRIORVALUE(Leaving_Date__c) &gt;= TODAY(),
          ISBLANK(PRIORVALUE(Leaving_Date__c))
          ),
       Leaving_Date__c &gt;= TODAY()
       ),
   Leaving_Date__c,
   IF(
      AND(
          OR(
             PRIORVALUE(Leaving_Date__c) &gt;= TODAY(),
             ISBLANK(PRIORVALUE(Leaving_Date__c))
             ),
          Leaving_Date__c &lt; TODAY()
          ),
      TODAY(),
      IF(
         AND(
             PRIORVALUE(Leaving_Date__c) &gt;= TODAY(),
             ISBLANK(Leaving_Date__c)
             ),
         null,
         Leaving_Date_for_KPIs__c
         )
      )
   )</formula>
        <name>Populate Leaving Date (for KPIs)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Manually_Audited_By_ID</fullName>
        <field>Manually_Audited_By_ID__c</field>
        <formula>IF(TEXT(Manually_Audited_To_Date__c) &lt;&gt; &quot;&quot;, $User.Id, &quot;&quot;)</formula>
        <name>Populate Manually Audited By ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Manually_Audited_By_Name</fullName>
        <field>Manually_Audited_by_Name__c</field>
        <formula>IF(TEXT(Manually_Audited_To_Date__c) &lt;&gt; &quot;&quot;, $User.FirstName &amp; &quot; &quot; &amp; $User.LastName, &quot;&quot;)</formula>
        <name>Populate Manually Audited By Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Manually_Audited_On_Date</fullName>
        <field>Manually_Audited_On_Date__c</field>
        <formula>IF(TEXT(Manually_Audited_To_Date__c) &lt;&gt; &quot;&quot;, TODAY(), null)</formula>
        <name>Populate Manually Audited On Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Obligatory_Local_Language</fullName>
        <field>SK_Obligatory_Local_Language__c</field>
        <formula>IF(
   TEXT(SK_Obligatory_Local_Language_Override__c) = &quot;Additional Learning&quot;,
   &quot;&quot;,
   IF(
      AND(
          School__c = &quot;The British International School of Kuala Lumpur&quot;,
          TEXT(Year_Group__c) != &quot;Y12&quot;,
          TEXT(Year_Group__c) != &quot;Y13&quot;,
          TEXT(Year_Group__c) != &quot;Y1&quot;,
          TEXT(Year_Group__c) != &quot;R&quot;,
          TEXT(Year_Group__c) != &quot;N&quot;,
          TEXT(Year_Group__c) != &quot;PN&quot;,
          TEXT(Year_Group__c) != &quot;PN1&quot;
          ),
       IF(
          OR(
             TEXT(SK_Obligatory_Local_Language_Override__c) = &quot;Inclusion&quot;,
             AND(
                 TEXT(Nationality__c) = &quot;Malaysian&quot;,
                 ISBLANK(TEXT(SK_Obligatory_Local_Language_Override__c))
                 )
             ),
          &quot;Bah&quot;,
          &quot;Stu&quot;
          ),
       IF(
          AND(
              School__c = &quot;The British School of Brasilia&quot;,
              TEXT(SK_Obligatory_Local_Language_Override__c) != &quot;Complete&quot;,
              TEXT(SK_Obligatory_Local_Language_Override__c) != &quot;Exclusion&quot;,
              OR( 
                 TEXT(Year_Group__c) != &quot;PN&quot;,
                 TEXT(SK_Obligatory_Local_Language_Override__c) = &quot;Inclusion&quot;
                 )
              ),      
          &quot;Por&quot;,
          &quot;&quot;
          )
       )
   )</formula>
        <name>Populate Obligatory Local Language</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Starting_Date_for_KPIs</fullName>
        <field>Starting_Date_for_KPIs__c</field>
        <formula>IF(  
   OR(
      TODAY() &lt; Related_School__r.First_Day_of_This_Fiscal_Year__c,
      TODAY() &lt; Related_School__r.Start_Date_T1_TY__c
      ),
   IF(
      Related_School__r.Start_Date_T1_TY__c &gt;= Related_School__r.First_Day_of_This_Fiscal_Year__c,
      Related_School__r.Start_Date_T1_TY__c,
      Related_School__r.First_Day_of_This_Fiscal_Year__c
      ),
   IF(
      AND(
          TODAY() &gt; Related_School__r.Financial_Year_Cut_Off_Date_TY_NAE__c,
          TODAY() &lt; Related_School__r.First_Day_of_Next_Fiscal_Year__c /* This will always be true */
          ),
      IF(
         Related_School__r.Start_Date_T1_NY__c &gt;= Related_School__r.First_Day_of_Next_Fiscal_Year__c,      
         Related_School__r.Start_Date_T1_NY__c,
         Related_School__r.First_Day_of_Next_Fiscal_Year__c
         ),
      TODAY()
      )
   )


/* THE BELOW FORMULA CAN BE USED FOR TESTING THE LOGIC WITH A FLEXIBLE &apos;TODAY&apos; */ 

/*IF(  
   OR(
      Today_Test__c &lt; Related_School__r.First_Day_of_This_Fiscal_Year__c,
      Today_Test__c &lt; Related_School__r.Start_Date_T1_TY__c
      ),
   IF(
      Related_School__r.Start_Date_T1_TY__c &gt;= Related_School__r.First_Day_of_This_Fiscal_Year__c,
      Related_School__r.Start_Date_T1_TY__c,
      Related_School__r.First_Day_of_This_Fiscal_Year__c
      ),
   IF(
      AND(
          Today_Test__c &gt; Related_School__r.Financial_Year_Cut_Off_Date_TY_NAE__c,
          Today_Test__c &lt; Related_School__r.First_Day_of_Next_Fiscal_Year__c
          ),
      IF(
         Related_School__r.Start_Date_T1_NY__c &gt;= Related_School__r.First_Day_of_Next_Fiscal_Year__c,      
         Related_School__r.Start_Date_T1_NY__c,
         Related_School__r.First_Day_of_Next_Fiscal_Year__c
         ),
      Today_Test__c
      )
   )*/


/* BELOW IS THE OLD LOGIC PRE INFO FROM PHILEAS ON 31ST JAN */

/*IF(  
   TODAY() &lt; Related_School__r.First_Day_of_This_Fiscal_Year__c,
   Related_School__r.First_Day_of_This_Fiscal_Year__c,
   IF(
      AND(
          TODAY() &gt; Related_School__r.Financial_Year_Cut_Off_Date_TY_NAE__c,
          TODAY() &lt; Related_School__r.First_Day_of_Next_Fiscal_Year__c
          ),
      Related_School__r.First_Day_of_Next_Fiscal_Year__c,
      TODAY()
      )
   )*/</formula>
        <name>Populate Starting Date (for KPIs)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Probablity_to_0</fullName>
        <field>Probability</field>
        <formula>0</formula>
        <name>% Probablity to 0%</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Probablity_to_100</fullName>
        <field>Probability</field>
        <formula>1</formula>
        <name>% Probablity to 100%</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Probablity_to_70</fullName>
        <field>Probability</field>
        <formula>0.7</formula>
        <name>% Probablity to 70%</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Default_April_Starter_Term</fullName>
        <description>Sets the default April starter term to &apos;Term 3 / Summer Term&apos; although this can be changed to &apos;Term 2 / Spring Term&apos; later if required to correct student invoice auditing issues</description>
        <field>April_Starter_Term__c</field>
        <literalValue>Term 3 / Summer Term</literalValue>
        <name>Set Default April Starter Term</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Delayed_Batch_SendKompanion_to_FALSE</fullName>
        <field>Delayed_Batch_SendKompanionOutbound__c</field>
        <literalValue>0</literalValue>
        <name>Set Delayed_Batch_SendKompanion to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Delayed_Batch_SendKompanion_to_TRUE</fullName>
        <field>Delayed_Batch_SendKompanionOutbound__c</field>
        <literalValue>1</literalValue>
        <name>Set Delayed_Batch_SendKompanion to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_Copy_to_Jaguars</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>&quot;Jaguars&quot;</formula>
        <name>Set House Next Year Copy to Jaguars</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_Copy_to_Lions</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>&quot;Lions&quot;</formula>
        <name>Set House Next Year Copy to Lions</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_Copy_to_Normans</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>&quot;Normans&quot;</formula>
        <name>Set House Next Year Copy to Normans</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_Copy_to_Panthers</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>&quot;Panthers&quot;</formula>
        <name>Set House Next Year Copy to Panthers</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_Copy_to_Romans</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>&quot;Romans&quot;</formula>
        <name>Set House Next Year Copy to Romans</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_Copy_to_Saxons</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>&quot;Saxons&quot;</formula>
        <name>Set House Next Year Copy to Saxons</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_Copy_to_Tigers</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>&quot;Tigers&quot;</formula>
        <name>Set House Next Year Copy to Tigers</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_Copy_to_Vikings</fullName>
        <field>House_Next_Year_Copy__c</field>
        <formula>&quot;Vikings&quot;</formula>
        <name>Set House Next Year Copy to Vikings</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_to_Jaguars</fullName>
        <field>House_Next_Year__c</field>
        <literalValue>Jaguars</literalValue>
        <name>Set House Next Year to Jaguars</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_to_Lions</fullName>
        <field>House_Next_Year__c</field>
        <literalValue>Lions</literalValue>
        <name>Set House Next Year to Lions</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_to_Normans</fullName>
        <field>House_Next_Year__c</field>
        <literalValue>Normans</literalValue>
        <name>Set House Next Year to Normans</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_to_Panthers</fullName>
        <field>House_Next_Year__c</field>
        <literalValue>Panthers</literalValue>
        <name>Set House Next Year to Panthers</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_to_Romans</fullName>
        <field>House_Next_Year__c</field>
        <literalValue>Romans</literalValue>
        <name>Set House Next Year to Romans</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_to_Saxons</fullName>
        <field>House_Next_Year__c</field>
        <literalValue>Saxons</literalValue>
        <name>Set House Next Year to Saxons</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_to_Tigers</fullName>
        <field>House_Next_Year__c</field>
        <literalValue>Tigers</literalValue>
        <name>Set House Next Year to Tigers</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_House_Next_Year_to_Vikings</fullName>
        <field>House_Next_Year__c</field>
        <literalValue>Vikings</literalValue>
        <name>Set House Next Year to Vikings</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Include_in_Reports_if_Left_to_FALSE</fullName>
        <field>Include_in_Reports_if_Left__c</field>
        <literalValue>0</literalValue>
        <name>Set Include in Reports if Left to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SK_Student_Created_to_TRUE</fullName>
        <field>School_Kompanion_Student_Created__c</field>
        <literalValue>1</literalValue>
        <name>Set SK Student Created to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Send_SK_Outbound_to_FALSE_Student</fullName>
        <field>Send_School_Kompanion_Outbound_Message__c</field>
        <literalValue>0</literalValue>
        <name>Set Send SK Outbound to FALSE (Student)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Trigger_Batch_SendKompanion_to_FALSE</fullName>
        <field>Trigger_Batch_SendKompanionOutbound__c</field>
        <literalValue>0</literalValue>
        <name>Set Trigger_Batch_SendKompanion to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Trigger_Batch_SendKompanion_to_TRUE</fullName>
        <field>Trigger_Batch_SendKompanionOutbound__c</field>
        <literalValue>1</literalValue>
        <name>Set Trigger_Batch_SendKompanion to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Starting_Date_Change_Count_1</fullName>
        <field>Starting_Date_Change_Count__c</field>
        <formula>IF(ISBLANK(Starting_Date_Change_Count__c), 1,  Starting_Date_Change_Count__c + 1)</formula>
        <name>Starting Date Change Count + 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Starting_Date_Prior_Value</fullName>
        <description>Change the starting date from the automatically changed date of today, to the prior value</description>
        <field>CloseDate</field>
        <formula>PRIORVALUE( CloseDate )</formula>
        <name>Starting Date Prior Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Trigger_T_Year_to_N_Year_Copy</fullName>
        <description>Triggers the values in house and class this year to be copied to house and class next year</description>
        <field>Copy_This_Year_values_to_Next_Year_field__c</field>
        <literalValue>1</literalValue>
        <name>Trigger T/Year to N/Year Copy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Brazilian</fullName>
        <field>Brazilian__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Brazilian</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Filipino</fullName>
        <field>Filipino__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Filipino</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Hong_Kong</fullName>
        <field>Hong_Kong__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Hong Kong</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Korean</fullName>
        <field>Korean__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Korean</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Malaysian</fullName>
        <field>Malaysian__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Malaysian</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Russian</fullName>
        <field>Russian__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Russian</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Spanish</fullName>
        <field>Spanish__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Spanish</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Trigger_30_Day_Admissions_Notif</fullName>
        <field>Trigger_30_Day_Admissions_Notification__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Trigger 30 Day Admissions Notif.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Uzbek</fullName>
        <field>Uzbek__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Uzbek</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BCB</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British College of Brazil</literalValue>
        <name>Update School Control Picklist1 (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BISM</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British International School of Marbella</literalValue>
        <name>Update School Control Picklist1 (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BSB</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British School of Brasilia</literalValue>
        <name>Update School Control Picklist1 (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BSF</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British Schools Foundation</literalValue>
        <name>Update School Control Picklist1 (BSF)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BSKL</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British International School of Kuala Lumpur</literalValue>
        <name>Update School Control Picklist1 (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BSNJ</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British School of Nanjing</literalValue>
        <name>Update School Control Picklist1 (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BSNV</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British School of Navarra</literalValue>
        <name>Update School Control Picklist1 (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BST</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British School of Tashkent</literalValue>
        <name>Update School Control Picklist1 (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_BSY</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The British School Yangon</literalValue>
        <name>Update School Control Picklist1 (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_ISM</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The International School of Moscow</literalValue>
        <name>Update School Control Picklist1 (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_NAISM</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>Nord Anglia International School Manila</literalValue>
        <name>Update School Control Picklist1 (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist1_NYIS</fullName>
        <field>School_Controlling_Picklist1__c</field>
        <literalValue>The New York International School</literalValue>
        <name>Update School Control Picklist1 (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BCB</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British College of Brazil</literalValue>
        <name>Update School Control Picklist2 (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BISM</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British International School of Marbella</literalValue>
        <name>Update School Control Picklist2 (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BSB</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British School of Brasilia</literalValue>
        <name>Update School Control Picklist2 (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BSF</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British Schools Foundation</literalValue>
        <name>Update School Control Picklist2 (BSF)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BSKL</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British International School of Kuala Lumpur</literalValue>
        <name>Update School Control Picklist2 (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BSNJ</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British School of Nanjing</literalValue>
        <name>Update School Control Picklist2 (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BSNV</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British School of Navarra</literalValue>
        <name>Update School Control Picklist2 (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BST</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British School of Tashkent</literalValue>
        <name>Update School Control Picklist2 (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_BSY</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The British School Yangon</literalValue>
        <name>Update School Control Picklist2 (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_ISM</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The International School of Moscow</literalValue>
        <name>Update School Control Picklist2 (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_NAISM</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>Nord Anglia International School Manila</literalValue>
        <name>Update School Control Picklist2 (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist2_NYIS</fullName>
        <field>School_Controlling_Picklist2__c</field>
        <literalValue>The New York International School</literalValue>
        <name>Update School Control Picklist2 (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BCB</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British College of Brazil</literalValue>
        <name>Update School Control Picklist (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BISM</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British International School of Marbella</literalValue>
        <name>Update School Control Picklist (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BSB</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Brasilia</literalValue>
        <name>Update School Control Picklist (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BSF</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British Schools Foundation</literalValue>
        <name>Update School Control Picklist (BSF)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BSKL</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British International School of Kuala Lumpur</literalValue>
        <name>Update School Control Picklist (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BSNJ</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Nanjing</literalValue>
        <name>Update School Control Picklist (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BSNV</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Navarra</literalValue>
        <name>Update School Control Picklist (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BST</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School of Tashkent</literalValue>
        <name>Update School Control Picklist (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_BSY</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The British School Yangon</literalValue>
        <name>Update School Control Picklist (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_ISM</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The International School of Moscow</literalValue>
        <name>Update School Control Picklist (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_NAISM</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>Nord Anglia International School Manila</literalValue>
        <name>Update School Control Picklist (NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_School_Control_Picklist_NYIS</fullName>
        <field>School_Controlling_Picklist__c</field>
        <literalValue>The New York International School</literalValue>
        <name>Update School Control Picklist (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Student_P_word_Gen_Y1_3_K_G2</fullName>
        <field>Student_Password_Generated_Y1Y3_K_G2_Opp__c</field>
        <literalValue>1</literalValue>
        <name>Update Student P/word Gen. (Y1-3/K-G2)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Student_P_word_Gen_Y4_6_G3_G5</fullName>
        <field>Student_Password_Generated_Y4Y6_G3G5_Op__c</field>
        <literalValue>1</literalValue>
        <name>Update Student P/word Gen. (Y4-6/G3-G5)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Student_P_word_Gen_Y7_G6</fullName>
        <field>Student_Password_Generated_Y7_G6_Opp__c</field>
        <literalValue>1</literalValue>
        <name>Update Student P/word Gen. (Y7+/G6+)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Waiting_List_Qualification_Date_Update</fullName>
        <description>Updates the Waiting List Qualification Date in the student record for the purposes of creating an ordered waiting list</description>
        <field>Waiting_List_Qualification_Date__c</field>
        <formula>TODAY()</formula>
        <name>Waiting List Qualification Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Send_Student_Stage</fullName>
        <apiVersion>25.0</apiVersion>
        <description>Send the stage field to bsghub.net</description>
        <endpointUrl>http://www.bsghub.net/sf_notifications/endpoint</endpointUrl>
        <fields>Id</fields>
        <fields>Starting_Date__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>nae.migration@britishschools.co.uk</integrationUser>
        <name>Send Student Stage</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Student_to_School_Kompanion</fullName>
        <apiVersion>36.0</apiVersion>
        <endpointUrl>https://schoolkompanion.co.uk/IncomingMessages/Salesforce.php</endpointUrl>
        <fields>Bus_Service_Text__c</fields>
        <fields>Class_T_Yr__c</fields>
        <fields>Class__c</fields>
        <fields>CloseDate</fields>
        <fields>Day_of_Birth__c</fields>
        <fields>EAL_Status__c</fields>
        <fields>Family_Name__c</fields>
        <fields>Family_UID__c</fields>
        <fields>Half_Day_PN_N__c</fields>
        <fields>House__c</fields>
        <fields>Id</fields>
        <fields>Kompanion_Keep_On_Roll_Formula__c</fields>
        <fields>Language_Option_Notes__c</fields>
        <fields>Learning_Support_Provided__c</fields>
        <fields>Leaving_Date__c</fields>
        <fields>Month_of_Birth__c</fields>
        <fields>Nationality__c</fields>
        <fields>Next_School__c</fields>
        <fields>SK_A_Level_Block_A_Grouping__c</fields>
        <fields>SK_A_Level_Block_A_Option__c</fields>
        <fields>SK_A_Level_Block_B_Grouping__c</fields>
        <fields>SK_A_Level_Block_B_Option__c</fields>
        <fields>SK_A_Level_Block_C_Grouping__c</fields>
        <fields>SK_A_Level_Block_C_Option__c</fields>
        <fields>SK_A_Level_Block_D_Grouping__c</fields>
        <fields>SK_A_Level_Block_D_Option__c</fields>
        <fields>SK_A_Level_Block_E_Grouping__c</fields>
        <fields>SK_A_Level_Block_E_Option__c</fields>
        <fields>SK_A_Level_Block_F_Grouping__c</fields>
        <fields>SK_A_Level_Block_F_Option__c</fields>
        <fields>SK_Additional_Learning_1_Grouping_Period__c</fields>
        <fields>SK_Additional_Learning_1__c</fields>
        <fields>SK_Additional_Learning_2_Grouping_Period__c</fields>
        <fields>SK_Additional_Learning_2__c</fields>
        <fields>SK_Additional_Learning_3_Grouping_Period__c</fields>
        <fields>SK_Additional_Learning_3__c</fields>
        <fields>SK_English_Grouping__c</fields>
        <fields>SK_GCSE_Block_A_Grouping__c</fields>
        <fields>SK_GCSE_Block_A_Option__c</fields>
        <fields>SK_GCSE_Block_B_Grouping__c</fields>
        <fields>SK_GCSE_Block_B_Option__c</fields>
        <fields>SK_GCSE_Block_C_Grouping__c</fields>
        <fields>SK_GCSE_Block_C_Option__c</fields>
        <fields>SK_GCSE_Block_D_Grouping__c</fields>
        <fields>SK_GCSE_Block_D_Option__c</fields>
        <fields>SK_GCSE_Block_E_Grouping__c</fields>
        <fields>SK_GCSE_Block_E_Option__c</fields>
        <fields>SK_GCSE_Block_F_Grouping__c</fields>
        <fields>SK_GCSE_Block_F_Option__c</fields>
        <fields>SK_GCSE_Science_Grouping__c</fields>
        <fields>SK_GCSE_Science_Option_Formula__c</fields>
        <fields>SK_GCSE_Science_Option__c</fields>
        <fields>SK_Learning_Support_Folder_Link__c</fields>
        <fields>SK_Learning_Support_Needs__c</fields>
        <fields>SK_MFL_1_Grouping__c</fields>
        <fields>SK_MFL_1_Option__c</fields>
        <fields>SK_MFL_2_Grouping__c</fields>
        <fields>SK_MFL_2_Option__c</fields>
        <fields>SK_MFL_3_Grouping__c</fields>
        <fields>SK_MFL_3_Option__c</fields>
        <fields>SK_MFL_Block__c</fields>
        <fields>SK_Mathematics_Grouping__c</fields>
        <fields>SK_Obligatory_Local_Language_Grouping__c</fields>
        <fields>SK_Obligatory_Local_Language_Override__c</fields>
        <fields>SK_Obligatory_Local_Language__c</fields>
        <fields>SK_Sports_PE_Grouping__c</fields>
        <fields>SK_Swimming_Grouping__c</fields>
        <fields>School_Kompanion_Auto_Assign__c</fields>
        <fields>School_Kompanion_Gender__c</fields>
        <fields>School_Kompanion_On_Roll__c</fields>
        <fields>School_Kompanion_Realm__c</fields>
        <fields>School_Kompanion_Student_First_Name__c</fields>
        <fields>School_Kompanion_Student_ID__c</fields>
        <fields>School_Kompanion_Teaching_Group__c</fields>
        <fields>School_Kompanion_Year_Group__c</fields>
        <fields>Special_Considerations_Detail__c</fields>
        <fields>Special_Considerations__c</fields>
        <fields>Student_Email_Password__c</fields>
        <fields>Student_Email__c</fields>
        <fields>Student_Name__c</fields>
        <fields>Student_Number_New__c</fields>
        <fields>Student_Surname__c</fields>
        <fields>Year_of_Birth__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>nae.migration@britishschools.co.uk</integrationUser>
        <name>Student to School Kompanion</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>BCB Student Deposit %26 App Fee Paid</fullName>
        <actions>
            <name>BCB_Update_App_Fee_Paid_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>W/List D/Paid,Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <description>Updates the &apos;Application Fee Paid&apos; check box to TRUE when the stage of a BCB student is changed to Enrolled or W/List D/Paid</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSG Add to Class Register %287 days%29</fullName>
        <active>false</active>
        <booleanFilter>1 AND (2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>Admissions BSG</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>Sends an email to the Register Officer requesting a student be added to a register.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSG_Add_to_Register</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Copy_Starting_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSG%2FISM%2FBST%2FBSY - A%2FDeposit or W%2FList A%2FDeposit to Accounting %28Immediate%29</fullName>
        <actions>
            <name>BSG_ISM_BST_BSY_Email_informing_of_A_Deposit_or_W_List_A_Deposit</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3 AND (4 OR 5 OR 6 OR 7) AND 8</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>W/List A/Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British International School Yangon</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Test_Student_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Triggers when a stage is updated to A/ Deposit or W/List A/Deposit</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Checks Student Passport Expiration Date</fullName>
        <active>true</active>
        <booleanFilter>1 AND (2 OR (3 AND 4)) AND (5 AND 6)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Passport_Doc__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Passport_Expiry_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends an email 90 days before student&apos;s passport expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Student_Passport_Expiration_Notice</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Passport_Expiry_Date__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL Checks Student Visa%2FPermit Expiry Date</fullName>
        <active>true</active>
        <booleanFilter>1 AND (2 OR (3 AND 4)) AND (5 AND 6)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Visa_Permit_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Visa_Permit_Expiry_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sends an email 90 days before student&apos;s Visa/permit expiry date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Student_Visa_Permit_Expiration_Notice</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Visa_Permit_Expiry_Date__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL New Student Starting Procedure</fullName>
        <active>true</active>
        <description>Sends an email to various departments 21 days prior to the starting date of the student.</description>
        <formula>AND(  
    OR(
       TEXT(StageName)= &quot;Enrolled&quot;,  
       AND(
           TEXT(StageName)= &quot;A/ Deposit&quot;,  
           TEXT(Add_to_Register__c)=&quot;Yes&quot;
           )  
       ),  
    ISBLANK(TEXT(Test_Student_Type__c)),
    Trigger_30_Day_Admissions_Notification__c = FALSE,  
    School__c = &quot;The British International School of Kuala Lumpur&quot;  
    )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>New_Email_Account_required_for_Student</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Special_Considerations_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL Notification about Student Left W%2FNo Notice</fullName>
        <actions>
            <name>BSKL_Notification_about_Student_Left_W_No_Notice</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notification about students that have left the school at short or no notice</description>
        <formula>AND(     Leaving_Date__c &lt; TODAY(),      NOT(ISPICKVAL(StageName, &quot;Left&quot;)),     School__c = &quot;The British International School of Kuala Lumpur&quot;     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BSKL Notify Front Desk 30 Days Before Student Start Date</fullName>
        <active>true</active>
        <booleanFilter>(1 OR (2 AND 3)) AND 4 AND 5 AND 6 AND 7</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Trigger_30_Day_Admissions_Notification__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Test_Student_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Test_Account_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>To notify Front desk 30 days before the student start date to make an ID tag.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_New_Student_Starting</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL Student Email Needs to be Suspended</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>notEqual</operation>
            <value>PN1,PN,N,R</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Leaving_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Send an email to IT Team 1 day after the leaving date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Student_Email_needs_to_be_suspended</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Leaving_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL Student Leaving Procedure Reminder</fullName>
        <active>true</active>
        <booleanFilter>1 AND (2 OR (3 AND 4)) AND (5 AND 6)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Leaving_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Leaving_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>This rule sends an email to Admissions, IT, Finance, Librarian about a student leaving 7 days before the leaving date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Student_Leaving_Procedure</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Leaving_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL Student Visa follow up</fullName>
        <active>true</active>
        <booleanFilter>1 AND (2 OR (3 AND 4))</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>This rule send an email to BSKL admissions chase up the progress with the student&apos;s visa application.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Check_student_visa_application</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Starting_Date__c</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL- Student A%2FDeposit or W%2FList A%2FDeposit</fullName>
        <actions>
            <name>BSKL_Email_informing_of_A_Deposit_or_W_List_A_Deposit</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>W/List A/Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <description>Sends an email confirming that the deposit for a student needs to be paid</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BSKL- Student Deposit Paid</fullName>
        <actions>
            <name>BSKL_Email_informing_of_Deposit_Paid</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>W/List D/Paid</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <description>Sends an email confirming a student&apos;s deposit has been paid</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BST New student for local authorities</fullName>
        <actions>
            <name>BST_New_student_for_local_authorities</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>BST New student for local authorities %28Left%29</fullName>
        <actions>
            <name>BST_New_student_for_local_authorities_Left</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Left</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change %25 Probability to 0 when Left after Attending School</fullName>
        <actions>
            <name>Probablity_to_0</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Required to set the probability to 0% in the following scenario:
1 Student Stage = &quot;A /Deposit&quot; &amp; Attending School? = &quot;Yes&quot;
2 Stage gets changed to &apos;Left&apos; by means of a workflow rule based on the leaving date
3 WF evaluation also triggers prob to 100%</description>
        <formula>TEXT(StageName) = &quot;Left&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change %25 Probablity to 100 with Attending School%3F</fullName>
        <actions>
            <name>Probablity_to_100</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change %25 Probablity to 70 with Not Attending School%3F</fullName>
        <actions>
            <name>Probablity_to_70</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change of Start Date within 30 Days of Start Notification</fullName>
        <actions>
            <name>Change_of_Start_Date_within_30_Days_of_Start_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(CloseDate), PRIORVALUE(CloseDate)-30 &lt; TODAY(), CloseDate-60 &gt; TODAY(), OR(TEXT(StageName) = &quot;Enrolled&quot;, AND(TEXT(StageName) = &quot;A/ Deposit&quot;, TEXT(Add_to_Register__c) = &quot;Yes&quot;)), OR(PRIORVALUE(StageName) = &quot;Enrolled&quot;, AND(PRIORVALUE(StageName) = &quot;A/ Deposit&quot;, PRIORVALUE(Add_to_Register__c) = &quot;Yes&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change to Left %28Leaving Date Past%29</fullName>
        <actions>
            <name>Change_to_Left</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes the student stage to left if a leaving date has been entered and is already in the past</description>
        <formula>AND(Leaving_Date__c &lt; TODAY(), NOT(ISPICKVAL(StageName, &quot;Left&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change to Left %28Next Day%29</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>notEqual</operation>
            <value>Left</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Leaving_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Changes the &quot;stage&quot; of a student to &quot;Left&quot; the day after the leaving date passes</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Change_to_Left_Next_Day</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Opportunity.Leaving_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Check April Starter Field As Required</fullName>
        <actions>
            <name>Change_April_Starter_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Default_April_Starter_Term</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(April_Starter__c = FALSE, MONTH(CloseDate)=4, CloseDate&gt;DATE(2012,08,01))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Brazilian</fullName>
        <actions>
            <name>Check_Brazilian</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>Brazilian</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Filipino</fullName>
        <actions>
            <name>Check_Filipino</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>Filipino</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Has_Been_Enrolled%5F%5Fc</fullName>
        <actions>
            <name>Check_Has_Been_Enrolled_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR (2 AND 3)) AND 4</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Has_Been_Enrolled__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Check Hong Kong</fullName>
        <actions>
            <name>Check_Hong_Kong</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>Chinese - Hong Kong</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Korean</fullName>
        <actions>
            <name>Check_Korean</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>South Korean</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Malaysian</fullName>
        <actions>
            <name>Check_Malaysian</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>Malaysian</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Myanmar</fullName>
        <actions>
            <name>Check_Myanmar</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>Myanmarese</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Russian</fullName>
        <actions>
            <name>Check_Russian</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>Russian</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Spanish</fullName>
        <actions>
            <name>Check_Spanish</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>Spanish</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Trigger 30 Day Admissions Notification</fullName>
        <actions>
            <name>Check_Trigger_30_Day_Admissions_Notific</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(CloseDate), OR(TEXT(StageName) = &quot;Enrolled&quot;, AND(TEXT(StageName) = &quot;A/ Deposit&quot;, TEXT(Add_to_Register__c) = &quot;Yes&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check US Year Group Control</fullName>
        <actions>
            <name>Check_US_Year_Group_Control_Opp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Checks the US Year Group Control Checkbox on the opportunity record when it belongs to a US school e.g. NYIS</description>
        <formula>AND(US_Year_Group_Control__c = FALSE,  Owner.Is_US_School_User__c = TRUE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check Uzbek</fullName>
        <actions>
            <name>Check_Uzbek</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>equals</operation>
            <value>Uzbekistani</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Check for Year Group %2F Grade Discrepancy</fullName>
        <actions>
            <name>Year_Group_Grade_Discrepancy_Warning</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Checks for a discrepancy between the year group/grade on the enquiry and the calculated year group on the student record</description>
        <formula>AND(     TEXT(Year_Group__c) != Year_Group_Grade_from_Enquiry_Trimmed__c,     NOT(ISBLANK(TEXT(Year_Group_Grade_from_Enquiry__c))),     TEXT(Year_Group_Grade_from_Enquiry__c) != &quot;Not Sure&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Clear %27Attending School%27 value</fullName>
        <actions>
            <name>Clear_Attending_School_value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>notEqual</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>Clear&apos;s the value in the &apos;Attending School?&apos; field when the stage is not &apos;A/ Deposit&apos;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Clear FTE Value Adjustment and Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.FTE_Value_Adjustment_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Clear_FTE_Value_Adjustment</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Clear_FTE_Value_Adjustment_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Opportunity.FTE_Value_Adjustment_Date__c</offsetFromField>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Clear Half Day Value if Invalid</fullName>
        <actions>
            <name>Clear_Half_Day_Value_if_Invalid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>notEqual</operation>
            <value>PN1,PN,N</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Half_Day_PN_N__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Clear Starting Date %28for KPIs%29</fullName>
        <actions>
            <name>Clear_Starting_Date_for_KPIs_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Has_Attended_School__c = FALSE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Copy Auto-Audit Start Date</fullName>
        <actions>
            <name>Populate_Auto_Audit_Start_Date_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Auto_Audit_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Class%2FHouse T%2EYr%2FN%2EYr to Text Fields</fullName>
        <actions>
            <name>Copy_Class_N_Yr_to_Class_N_Yr_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Class_to_Class_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_House_N_Yr_to_House_N_Yr_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_House_to_House_Copy</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Required to copy values from picklist fields to text fields for use in formulas where otherwise the 5000 character limit would be exceeded.</description>
        <formula>OR(    ISNEW(),    ISCHANGED(Class__c),    ISCHANGED(House__c),    ISCHANGED(Class_Next_Year__c),    ISCHANGED(House_Next_Year__c)    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Current EAL</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.EAL_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Test_Student_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>EAL_Class_List_Checkbox_Check</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Opportunity.EAL_Start_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Deactivate Include in Reports if Left</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Left</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Include_in_Reports_if_Left__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Automatically set the value of this field to FALSE 90 days after the student leaving date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Set_Include_in_Reports_if_Left_to_FALSE</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Opportunity.Leaving_Date__c</offsetFromField>
            <timeLength>90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Delayed Batch_SendKompanionOutboundMessage</fullName>
        <active>false</active>
        <description>Required to delay the evaluation of criteria on the student record because of the troublesome auto-update of the closedate when a student is first enrolled. A middle step in the whole process.</description>
        <formula>Delayed_Batch_SendKompanionOutbound__c = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Set_Delayed_Batch_SendKompanion_to_FALSE</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Set_Trigger_Batch_SendKompanion_to_TRUE</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>F%2FInfo Now Required</fullName>
        <actions>
            <name>F_Info_Required</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.F_Info_Request_Status__c</field>
            <operation>notEqual</operation>
            <value>Sent,Pending</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.F_Info_Response_Status__c</field>
            <operation>notEqual</operation>
            <value>have already received</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Finishing EAL</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.EAL_End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>EAL_Class_List_Checkbox_Uncheck</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Opportunity.EAL_End_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Generate Student Email</fullName>
        <actions>
            <name>Generate_Student_Email_Opp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Student_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Student Password Y1-Y3 %2F K-G2</fullName>
        <actions>
            <name>Generate_Student_Password</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Student_P_word_Gen_Y1_3_K_G2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Generates a password for Y1-Y3 and K-G2 Students</description>
        <formula>AND(Student_Password_Generated_Y1Y3_K_G2_Opp__c=FALSE, OR(  TEXT(Year_Group__c)=&quot;Y1&quot;,  TEXT(Year_Group__c)=&quot;Y2&quot;,  TEXT(Year_Group__c)=&quot;Y3&quot;, TEXT(Year_Group__c)=&quot;K&quot;, TEXT(Year_Group__c)=&quot;G1&quot;, TEXT(Year_Group__c)=&quot;G2&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Student Password Y4-Y6 %2F G3-G5</fullName>
        <actions>
            <name>Generate_Student_Password</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Student_P_word_Gen_Y4_6_G3_G5</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Generates a password for Y4-Y6 and G3-G5 students</description>
        <formula>AND(Student_Password_Generated_Y4Y6_G3G5_Op__c=FALSE, OR(  TEXT(Year_Group__c)=&quot;Y4&quot;,  TEXT(Year_Group__c)=&quot;Y5&quot;,  TEXT(Year_Group__c)=&quot;Y6&quot;, TEXT(Year_Group__c)=&quot;G3&quot;, TEXT(Year_Group__c)=&quot;G4&quot;, TEXT(Year_Group__c)=&quot;G5&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Student Password Y7%2B %2F G6%2B</fullName>
        <actions>
            <name>Generate_Student_Password</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Student_P_word_Gen_Y7_G6</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Generates a password for Y7+ and G6+ students</description>
        <formula>AND(Student_Password_Generated_Y7_G6_Opp__c=FALSE, OR(  TEXT(Year_Group__c)=&quot;Y7&quot;,  TEXT(Year_Group__c)=&quot;Y8&quot;,  TEXT(Year_Group__c)=&quot;Y9&quot;,  TEXT(Year_Group__c)=&quot;Y10&quot;,  TEXT(Year_Group__c)=&quot;Y11&quot;,  TEXT(Year_Group__c)=&quot;Y12&quot;, TEXT(Year_Group__c)=&quot;Y13&quot;, TEXT(Year_Group__c)=&quot;G6&quot;,  TEXT(Year_Group__c)=&quot;G7&quot;,  TEXT(Year_Group__c)=&quot;G8&quot;,  TEXT(Year_Group__c)=&quot;G9&quot;,  TEXT(Year_Group__c)=&quot;G10&quot;,  TEXT(Year_Group__c)=&quot;G11&quot;, TEXT(Year_Group__c)=&quot;G12&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - A%2FDeposit %26 F%2FInfo Request Status</fullName>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4 OR 5 OR 6 OR 7)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>W/List A/Deposit,A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The King&apos;s School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <description>Sends an email to the invoicing-notifications@ email address informing the recipient that a student stage has been changed to a/deposit and whether or not a request for financial information has been sent</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Grp_Adm_Email_informing_of_A_Deposit_or_W_List_A_Deposit_Status_of_F_Info_Reques</name>
                <type>Alert</type>
            </actions>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Application Fee Paid</fullName>
        <actions>
            <name>Grp_Adm_Email_informing_of_Assessment_Fee_payment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4 OR 6 OR 8 OR 9) AND 5 AND 7</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Assessment_Fee__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Test_Student_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <description>Triggers an email alert informing the admissions department that the application fee has been paid.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Bus Price Tier Assignment Required</fullName>
        <actions>
            <name>Grp_Adm_Email_Informing_that_a_bus_price_tier_needs_to_be_assigned</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Grp_Adm_Bus_Price_Tier_Assignment_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Bus_Service_Required__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.F_Info_Response_Status_from_account__c</field>
            <operation>equals</operation>
            <value>have already received</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Bus_Service_Price_Tier__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Assign_Bus_Tier_Email_Sent__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Triggers an email alert to inform the bus coordinator to assign a bus price tier when an invoicing information form is received from a parent and the bus service required checkbox is ticked.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Cancelled%2FLeft%2FRejected to Accounting Office %26 Admissions</fullName>
        <actions>
            <name>Grp_Adm_Email_informing_of_Left_Cancelled_Rejected</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_Stage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4 OR 5 OR 6 OR 7 OR 8 OR 9 OR 10 OR 11)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Cancelled,Left,Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Test_Student_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The King&apos;s School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <description>Send a notification to Admissions &amp; Accounting when the stage of a student is changed to &quot;Left&quot;, &quot;Cancelled&quot; or &quot;Rejected&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Change in Bus Service or Bus Service Price Tier</fullName>
        <actions>
            <name>Grp_Adm_Email_informing_of_Change_in_Bus_Service_or_Price_Tier</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_B_Serv_Required</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_Price_Tier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers when the value in the bus service checkbox of an enrolled student changes or the bus service price tier is changed</description>
        <formula>AND(      
    OR(
       TEXT(StageName) = &quot;Enrolled&quot;,
       AND(
           TEXT(StageName) = &quot;A/ Deposit&quot;,
           TEXT(Add_to_Register__c) = &quot;Yes&quot;
           )
       ), 
    OR( 
       ISCHANGED(Bus_Service_Price_Tier__c),
       ISCHANGED(Bus_Service_Required__c)
       ),
       OR(
          ISPICKVAL($User.School__c,&quot;The British School of Nanjing&quot;),
          ISPICKVAL($User.School__c,&quot;The International School of Moscow&quot;),
          ISPICKVAL($User.School__c,&quot;The British School Yangon&quot;),
          ISPICKVAL($User.School__c,&quot;The King&apos;s School Manila&quot;),
          ISPICKVAL($User.School__c,&quot;Nord Anglia International School Manila&quot;)
          )
      )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Change in EAL Status</fullName>
        <actions>
            <name>Grp_Adm_Email_Change_in_EAL_Dates</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Grp_Adm_Pop_Prior_EAL_Classification</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_EAL_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_EAL_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers when the &apos;EAL Start Date&apos;, &apos;EAL End Date&apos; or &apos;EAL Classification&apos; of a student changes</description>
        <formula>AND(
    OR( 
       TEXT(StageName) = &quot;Enrolled&quot;,
       AND(
           TEXT(StageName) = &quot;A/ Deposit&quot;,
           TEXT(Add_to_Register__c) = &quot;Yes&quot;
           )
       ),
    OR(
       ISCHANGED(EAL_Start_Date__c),
       ISCHANGED(EAL_End_Date__c),
       ISCHANGED(EAL_Classification__c)
       ),
    OR(
       ISPICKVAL($User.School__c, &quot;The British International School of Kuala Lumpur&quot;),
       ISPICKVAL($User.School__c, &quot;The British School of Nanjing&quot;),
       ISPICKVAL($User.School__c, &quot;The British School of Tashkent&quot;),
       ISPICKVAL($User.School__c, &quot;The British College of Brazil&quot;),
       ISPICKVAL($User.School__c, &quot;The British School of Brasilia&quot;),
       ISPICKVAL($User.School__c, &quot;The International School of Moscow&quot;),
       ISPICKVAL($User.School__c, &quot;The King&apos;s School Manila&quot;),
       ISPICKVAL($User.School__c, &quot;Nord Anglia International School Manila&quot;)
       )
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Change in Leaving Date</fullName>
        <actions>
            <name>Grp_Adm_Email_Change_in_Leaving_Date</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_Leaving_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers when the leaving date of a student changes and the student stage is enrolled or a/deposit</description>
        <formula>AND(
    OR(
       ISPICKVAL (StageName, &quot;Enrolled&quot;),
       ISPICKVAL (StageName, &quot;A/ Deposit&quot;)
       ),
    ISCHANGED( Leaving_Date__c ),
    OR(
       ISPICKVAL($User.School__c,&quot;The British School of Guangzhou&quot;),
       ISPICKVAL($User.School__c,&quot;The British International School of Kuala Lumpur&quot;),
       ISPICKVAL($User.School__c,&quot;The British School of Nanjing&quot;),
       ISPICKVAL($User.School__c,&quot;The British School of Tashkent&quot;),
       ISPICKVAL($User.School__c,&quot;The British College of Brazil&quot;),
       ISPICKVAL($User.School__c,&quot;The British School of Brasilia&quot;),
       ISPICKVAL($User.School__c,&quot;The International School of Moscow&quot;),
       ISPICKVAL($User.School__c,&quot;The King&apos;s School Manila&quot;),
       ISPICKVAL($User.School__c,&quot;Nord Anglia International School Manila&quot;)
       )
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Change in Start Date</fullName>
        <actions>
            <name>Grp_Adm_Email_Change_in_Start_Date</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers when the start date of a student changes and the student stage is enrolled or a/deposit</description>
        <formula>AND(
    OR(
       AND(
           ISPICKVAL(StageName, &quot;Enrolled&quot;),
           Has_Been_Enrolled__c = TRUE
           ),
       ISPICKVAL (StageName, &quot;A/ Deposit&quot;)
       ),
     ISCHANGED(CloseDate),
     OR(
        ISPICKVAL($User.School__c,&quot;The British International School of Kuala Lumpur&quot;),
        ISPICKVAL($User.School__c,&quot;The British School of Nanjing&quot;),
        ISPICKVAL($User.School__c,&quot;The British School of Tashkent&quot;),
        ISPICKVAL($User.School__c,&quot;The British School of Brasilia&quot;),
        ISPICKVAL($User.School__c,&quot;The British College of Brazil&quot;),
        ISPICKVAL($User.School__c,&quot;The International School of Moscow&quot;),
        ISPICKVAL($User.School__c,&quot;The King&apos;s School Manila&quot;),
        ISPICKVAL($User.School__c,&quot;Nord Anglia International School Manila&quot;)
        )
     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Change in Year Group or H%2FDay Field</fullName>
        <actions>
            <name>Grp_Adm_Email_Change_in_Year_Group</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_H_Day_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Grp_Adm_Populate_Prior_Year_Group</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Triggers when the year group of an enrolled student changes or the half day option is selected</description>
        <formula>AND(
    ISPICKVAL (StageName, &quot;Enrolled&quot;),
    OR(
       ISCHANGED( Year_Group__c ),
       ISCHANGED( Half_Day_PN_N__c )
       ),
    OR(
       ISPICKVAL($User.School__c,&quot;The British School of Guangzhou&quot;),
       ISPICKVAL($User.School__c,&quot;The British International School of Kuala Lumpur&quot;),
       ISPICKVAL($User.School__c,&quot;The British School of Nanjing&quot;),
       ISPICKVAL($User.School__c,&quot;The British School of Tashkent&quot;),
       ISPICKVAL($User.School__c,&quot;The British School of Brasilia&quot;),
       ISPICKVAL($User.School__c,&quot;The British College of Brazil&quot;),
       ISPICKVAL($User.School__c,&quot;The International School of Moscow&quot;),
       ISPICKVAL($User.School__c,&quot;The King&apos;s School Manila&quot;),
       ISPICKVAL($User.School__c,&quot;Nord Anglia International School Manila&quot;)
       )
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - New Student Created</fullName>
        <actions>
            <name>Grp_Adm_Email_requesting_application_fee_invoice</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <description>Sends an email to the invoicing manager when a new student is created asking them to send an invoice for the application fee.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Notify Admissions 30 Days Before Student Start Date</fullName>
        <active>true</active>
        <formula>AND(  OR(  TEXT(StageName)=&quot;Enrolled&quot;,  AND(  TEXT(StageName)=&quot;A/ Deposit&quot;,  TEXT(Add_to_Register__c)=&quot;Yes&quot;  )  ),  Trigger_30_Day_Admissions_Notification__c = FALSE,  School__c != &quot;The British School of Guangzhou&quot;,  School__c != &quot;The British Schools Foundation&quot;,  School__c != &quot;The Ukraine International School&quot;,  School__c != &quot;King&apos;s College Beijing&quot;,  School__c != &quot;The British International School of Kuala Lumpur&quot;,  School__c != &quot;The British School of Brasilia&quot;  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Grp_Adm_Add_Student_to_Tutor_Group</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Reminder to Assign Bus Service</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND (4 OR 5 OR 6 OR 7 OR 8 OR 10) AND 9</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Bus_Service_Required__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Bus_Service__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The King&apos;s School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Test_Student_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <description>Sends an email before the starting date of a student reminding that a bus service needs to be assigned when one has not been already.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Grp_Adm_Email_requesting_assignment_of_bus_service</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Student Deposit Paid %28Enrolled%29</fullName>
        <actions>
            <name>Grp_Adm_Email_informing_of_Deposit_Paid_Enrolled</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Grp_Adm_Enrolled_Email_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4 OR 5 OR 6 OR 7 OR 8 OR 9 OR 10 OR 12 OR 13) AND 11</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The King&apos;s School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Test_Student_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <description>Sends an email confirming a student&apos;s deposit has been paid and they are now enrolled at the school</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Grp%2FAdm - Student Deposit Paid %28W%2FList%29</fullName>
        <actions>
            <name>Grp_Adm_Email_informing_of_Deposit_Paid_W_List</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4 OR 5 OR 6 OR 7 OR 8 OR 9 OR 10 OR 11)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>W/List D/Paid</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Guangzhou</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The King&apos;s School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Owner_School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <description>Sends an email confirming a student&apos;s deposit has been paid and they can be added to the waiting list</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Kompanion User%28s%29 Need Deactivating</fullName>
        <actions>
            <name>Kompanion_User_s_Needs_Deactivating</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Reminds system admin that they need to deactivate the Kompanion user(s) in cases where a parent user has been created but the starting date of a student is then moved to more than 30 days in the future</description>
        <formula>AND(     OR(        TEXT(StageName) = &quot;Enrolled&quot;,        AND(            TEXT(StageName) = &quot;A/ Deposit&quot;,            TEXT(Add_to_Register__c) = &quot;Yes&quot;            )        ),     ISCHANGED(CloseDate),     CloseDate &gt; TODAY()+30,     Account.Starting_Date__c &gt; TODAY()+30,     TEXT(Account.PersonContact.School_Kompanion_Contact_Created__c) = &quot;Yes&quot;,     Account.PersonContact.Allow_App_Login__c = TRUE,     Account.PersonContact.School_Kompanion_App_Login_Info_Sent__c = TRUE     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Leaving Notice Provided</fullName>
        <actions>
            <name>Leaving_Notice_Submitted_Email_sent_to_Admissions_Officer</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Leaving_Notice_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Leaving_Notice_Submitted_Online__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Triggers when a new online notice of leaving has been submitted.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>NYIS Student Leaving Procdure Reminder</fullName>
        <active>true</active>
        <booleanFilter>1 AND (2 OR (3 AND 4)) AND (5 AND 6)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Leaving_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Leaving_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Sends an email to Admin about a student leaving 7 days before the leaving date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>NYIS_Student_Leaving_Procedure</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Leaving_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>New Asset for a new secondary student %28ISM KRY%29</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4 OR 5 OR 6 OR 7) AND 8</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y7</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y8</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y9</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y11</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Class__c</field>
            <operation>equals</operation>
            <value>Pending (Campus 1: A-H),Pending,A,B,C,D,E,F,G,H</value>
        </criteriaItems>
        <description>Send an email to IT Manager 7days prior to the starting date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>New_asset_required_for_secondary_student_KRY</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Starting_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>New Asset for a new secondary student %28ISM ROS%29</fullName>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4 OR 5 OR 6 OR 7) AND 8</booleanFilter>
        <criteriaItems>
            <field>Account.SchoolText__pc</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y7</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y8</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y9</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Year_Group__c</field>
            <operation>equals</operation>
            <value>Y11</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Class__c</field>
            <operation>equals</operation>
            <value>Pending (Campus 2: I-P),I,J,K,L,M,N,O,P</value>
        </criteriaItems>
        <description>Send an email to IT Manager 7 days prior to the starting date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>New_asset_required_for_secondary_student_ROS</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.Starting_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>New Opportunity Created Manually</fullName>
        <actions>
            <name>New_Student_Created_Manually_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Possible_Duplicate_Opportunities__c = &quot;Unknown - not created through lead convert process&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Created with Possible Duplicates</fullName>
        <actions>
            <name>New_Student_Created_With_Possible_Duplicates_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(     Possible_Duplicate_Opportunities__c != &quot;Unknown - not created through lead convert process&quot;,     NOT(ISBLANK(Possible_Duplicate_Opportunities__c))     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Created with Renumbering Exception</fullName>
        <actions>
            <name>New_Student_Renumbering_Exception_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>&apos;Student Renumbering Exception&apos; field is checked by the before insert trigger (e.g. when twins are inserted and the logic doesn&apos;t know which student number to update as they both match based on the trigger criteria of DOB and name)</description>
        <formula>Student_Renumbering_Exception__c  = TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28BCB%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_BCB</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the BCB user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28BISM%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_BISM</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the BISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28BSB%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_BSB</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the BSB user with the &quot;BSB Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28BSKL%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_BSKL</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the BSKL user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28BSNJ%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_BSNJ</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the BSNJ user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28BSNV%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_BSNV</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the BSNV user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28BST%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_BST</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the BST user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28BSY%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_BSY</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the BSY user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28ISM%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_ISM</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the ISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28NAISM%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_NAISM</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the NAISM user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28NYIS%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_NYIS</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the NYIS user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Opportunity Owner Assignment %28UIS%29</fullName>
        <actions>
            <name>Assign_Opportunity_Record_Owner_UIS</name>
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
        <description>Triggers a field update when an opportunity is created to assign the opportunity to the UIS user with the &quot;Record Owner&quot; role</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify of Enrolled Student with Invalid Student Number</fullName>
        <active>true</active>
        <booleanFilter>(1 OR (2 AND 3)) AND 4</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Student_Number_Override__c</field>
            <operation>contains</operation>
            <value>-</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notify_of_Enrolled_Student_with_Invalid_Student_Number</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notify of Enrolled Student without Academic File</fullName>
        <actions>
            <name>Notify_of_Enrolled_Student_without_Academic_File</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(  School__c != &quot;The British School of Brasilia&quot;,  OR(  TEXT(StageName) = &quot;Enrolled&quot;,  AND(  TEXT(StageName) = &quot;A/ Deposit&quot;,  TEXT(Add_to_Register__c) = &quot;Yes&quot;  )  ),  NOT(CONTAINS(Student_Number_Override__c, &quot;-0&quot;)),  Student_Academic_File__r.Admissions_File__r.Id != Id  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify of Invalid Student in Kompanion</fullName>
        <actions>
            <name>Notify_of_Invalid_Student_in_Kompanion</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Triggers a notification to system admin when a student has been created in Kompanion that shouldn&apos;t exist there because their stage doesn&apos;t qualify</description>
        <formula>AND(  School_Kompanion_Student_Created__c = TRUE,  OR(  TEXT(StageName) = &quot;Cancelled&quot;,  TEXT(StageName) = &quot;Rejected&quot;,  TEXT(StageName) = &quot;W/List D/Paid&quot;,  TEXT(StageName) = &quot;W/List A/Deposit&quot;,  TEXT(StageName) = &quot;A/ Testing&quot;,  AND(  TEXT(StageName) = &quot;A/ Deposit&quot;,  TEXT(Add_to_Register__c) != &quot;Yes&quot;  )  )  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Parent%2FCompany F%2FInfo Updated %28Opp Updates%29</fullName>
        <actions>
            <name>F_Info_Bus_Service_Required_Acc_Upd2</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>F_Info_Bus_Service_Required_Opp_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.F_Info_Bus_Service__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Triggers when a new financial information form is received and the submitter has indicated that a bus service is required.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Application Date %28Adjusted%29</fullName>
        <actions>
            <name>Populate_Application_Date_Adjusted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        AND(            ISPICKVAL(PRIORVALUE(StageName), &quot;Cancelled&quot;),            ISPICKVAL(PRIORVALUE(Reason_Cancelled_Rejected__c), &quot;Pending Application&quot;)            ),        ISPICKVAL(PRIORVALUE(StageName), &quot;Rejected&quot;)        ),     TEXT(StageName) != &quot;Cancelled&quot;,     TEXT(StageName) != &quot;Rejected&quot;     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Application Date %28Initial%29</fullName>
        <actions>
            <name>Populate_Application_Date_Initial</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Populates the application date when it&apos;s blank</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Campus Text</fullName>
        <actions>
            <name>Populate_Campus_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Populates the Campus Text field based on the class and, in some cases, the year group of the student.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Date Confirmed Paid</fullName>
        <actions>
            <name>Populate_Date_Confirmed_Paid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled,W/List D/Paid</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Date_Confirmed_Paid__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>See field update target field for full details of usage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Deposit Paid Date</fullName>
        <actions>
            <name>Populate_Deposit_Paid_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>W/List D/Paid</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Deposit_Paid_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Records the date when the stage of the first student in a family is first changed to enrolled or W/List D/Paid. To be used when auditing/comparing with Xero as the date on which a deposit was received.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate FTE Adjustment Value</fullName>
        <actions>
            <name>Populate_FTE_Value_Adjustment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     
    /*$User.Id = &quot;0056F000008tfhZ&quot;,*/     
    TODAY() &gt;= Starting_Date_for_KPIs__c + CASE(WEEKDAY(Starting_Date_for_KPIs__c), 2,7, 3,6, 4,5, 5,4, 6,3, 7,2, 1),
    OR(
       TODAY() &lt; Leaving_Date_for_KPIs__c - CASE(WEEKDAY(Leaving_Date_for_KPIs__c), 2,0, 3,1, 4,2, 5,3, 6,4, 7,5, 6),        ISBLANK(Leaving_Date_for_KPIs__c)        ),     OR(        ISCHANGED(Custom_FTE_Value__c),        AND(            ISCHANGED(Half_Day_PN_N__c),            OR(               AND(                   ISBLANK(PRIORVALUE(Half_Day_PN_N__c)),                   NOT(ISBLANK(TEXT(Half_Day_PN_N__c)))                   ),               AND(                   NOT(ISBLANK(PRIORVALUE(Half_Day_PN_N__c))),                   ISBLANK(TEXT(Half_Day_PN_N__c))                   )               )            )         )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate FTE Value Adjustment Date</fullName>
        <actions>
            <name>Populate_FTE_Value_Adjustment_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(FTE_Value_Adjustment__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Has Attended School %28Date Confirmed%29</fullName>
        <actions>
            <name>Populate_Has_Attended_School_Date_Conf</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Has_Attended_School__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate IT Notifications Email %28Opportunity%29</fullName>
        <actions>
            <name>Populate_IT_Notifications_Email_Opp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.IT_Notifications_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Latest A%2F Deposit Date</fullName>
        <actions>
            <name>Populate_Latest_A_Deposit_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <description>For use in the &apos;Decision_Due__c&apos; formula field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Leaving Date %28for KPIs%29</fullName>
        <actions>
            <name>Populate_Leaving_Date_for_KPIs</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(    AND(        ISNEW(),        NOT(ISBLANK(Leaving_Date__c))        ),     ISCHANGED(Leaving_Date__c)     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Manually Audited By Fields</fullName>
        <actions>
            <name>Populate_Manually_Audited_By_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Manually_Audited_By_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Manually_Audited_On_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(    AND(        TEXT(Manually_Audited_To_Date__c) &lt;&gt; &quot;&quot;,        TEXT(PRIORVALUE(Manually_Audited_To_Date__c)) = &quot;&quot;        ),          ISCHANGED(Manually_Audited_To_Date__c)    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Obligatory Local Language</fullName>
        <actions>
            <name>Populate_Obligatory_Local_Language</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(    ISNEW(),    ISCHANGED(Year_Group__c),    ISCHANGED(SK_Obligatory_Local_Language_Override__c),    ISCHANGED(Nationality__c)    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Starting Date %28for KPIs%29</fullName>
        <actions>
            <name>Populate_Starting_Date_for_KPIs</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     Has_Attended_School__c = TRUE,     OR(        TEXT(StageName) = &quot;Enrolled&quot;,        AND(            TEXT(StageName) = &quot;A/ Deposit&quot;,            TEXT(Add_to_Register__c) = &quot;Yes&quot;            )        )     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Delayed_Batch_SendKompanionOutbound%5F%5Fc to TRUE</fullName>
        <actions>
            <name>Set_Delayed_Batch_SendKompanion_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Deals with the special scenario removed from the student outbound message workflow where newly enrolled students would otherwise be sent to Kompanion, regardless of their closedate, as that is always evaluated as today when they are first enrolled.</description>
        <formula>AND(     ISCHANGED(CloseDate),     ISCHANGED(StageName)     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set House Next Year to Jaguars</fullName>
        <actions>
            <name>Set_House_Next_Year_Copy_to_Jaguars</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_House_Next_Year_to_Jaguars</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(House_Next_Year__c) = &quot;&quot;,        TEXT(House_Next_Year__c) = &quot;Pending&quot;        ),     TEXT(House__c) = &quot;Jaguars&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set House Next Year to Lions</fullName>
        <actions>
            <name>Set_House_Next_Year_Copy_to_Lions</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_House_Next_Year_to_Lions</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(House_Next_Year__c) = &quot;&quot;,        TEXT(House_Next_Year__c) = &quot;Pending&quot;        ),     TEXT(House__c) = &quot;Lions&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set House Next Year to Normans</fullName>
        <actions>
            <name>Set_House_Next_Year_Copy_to_Normans</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_House_Next_Year_to_Normans</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(House_Next_Year__c) = &quot;&quot;,        TEXT(House_Next_Year__c) = &quot;Pending&quot;        ),     TEXT(House__c) = &quot;Normans&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set House Next Year to Panthers</fullName>
        <actions>
            <name>Set_House_Next_Year_Copy_to_Panthers</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_House_Next_Year_to_Panthers</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(House_Next_Year__c) = &quot;&quot;,        TEXT(House_Next_Year__c) = &quot;Pending&quot;        ),     TEXT(House__c) = &quot;Panthers&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set House Next Year to Romans</fullName>
        <actions>
            <name>Set_House_Next_Year_Copy_to_Romans</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_House_Next_Year_to_Romans</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(House_Next_Year__c) = &quot;&quot;,        TEXT(House_Next_Year__c) = &quot;Pending&quot;        ),     TEXT(House__c) = &quot;Romans&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set House Next Year to Saxons</fullName>
        <actions>
            <name>Set_House_Next_Year_Copy_to_Saxons</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_House_Next_Year_to_Saxons</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(House_Next_Year__c) = &quot;&quot;,        TEXT(House_Next_Year__c) = &quot;Pending&quot;        ),     TEXT(House__c) = &quot;Saxons&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set House Next Year to Tigers</fullName>
        <actions>
            <name>Set_House_Next_Year_Copy_to_Tigers</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_House_Next_Year_to_Tigers</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(House_Next_Year__c) = &quot;&quot;,        TEXT(House_Next_Year__c) = &quot;Pending&quot;        ),     TEXT(House__c) = &quot;Tigers&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set House Next Year to Vikings</fullName>
        <actions>
            <name>Set_House_Next_Year_Copy_to_Vikings</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_House_Next_Year_to_Vikings</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(House_Next_Year__c) = &quot;&quot;,        TEXT(House_Next_Year__c) = &quot;Pending&quot;        ),     TEXT(House__c) = &quot;Vikings&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Send SK Outbound Message to FALSE %28Student%29</fullName>
        <actions>
            <name>Set_Send_SK_Outbound_to_FALSE_Student</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>Send_School_Kompanion_Outbound_Message__c = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Trigger_Batch_SendKompanionOutbound%5F%5Fc to FALSE</fullName>
        <actions>
            <name>Set_Trigger_Batch_SendKompanion_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Trigger_Batch_SendKompanionOutbound__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Reverts TRUE to FALSE so that future batch sends can be processed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Starting Date Change</fullName>
        <actions>
            <name>Starting_Date_Prior_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Stop the starting date from switching to today&apos;s date when status is changed to enrolled</description>
        <formula>AND(  TEXT(StageName) = &quot;Enrolled&quot;,  CloseDate = TODAY()/*,  $User.Id != &quot;0056F000008tfhZ&quot;*/  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Starting Date Change Count %3D 4 Notification</fullName>
        <actions>
            <name>Student_Starting_Date_Change_Count_4_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Starting_Date_Change_Count__c</field>
            <operation>equals</operation>
            <value>4</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Student A%2FDeposit %26 Attending School for 30 days</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>Sends a notification to admissions and finance about students that have been A/Deposit + Attending School for more than 30 days</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_notification_about_A_Deposit_Attending_School_student_30_days_after_startin</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Student Full Name</fullName>
        <actions>
            <name>Generate_Student_Full_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Student_Surname__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Generates Student Full Name</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Student Start Date Updates</fullName>
        <active>true</active>
        <formula>AND(  OR(  TEXT(StageName) = &quot;Enrolled&quot;,  AND(  TEXT(StageName) = &quot;A/ Deposit&quot;,  TEXT(Add_to_Register__c) = &quot;Yes&quot;  )  ),  CloseDate &gt;= TODAY(),  ISBLANK(TEXT(Test_Student_Type__c))  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Trigger_T_Year_to_N_Year_Copy</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BCB%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British College of Brazil</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BISM%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British International School of Marbella</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BSB%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Brasilia</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BSF%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BSF</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BSF</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BSF</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British Schools Foundation</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BSKL%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BSNJ%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Nanjing</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BSNV%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Navarra</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BST%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School of Tashkent</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28BSY%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The British School Yangon</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28ISM%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28NAISM%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>Nord Anglia International School Manila</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync School Controlling Picklist Value %28NYIS%29</fullName>
        <actions>
            <name>Update_School_Control_Picklist1_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist2_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_School_Control_Picklist_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School_Controlling_Picklist__c</field>
            <operation>notEqual</operation>
            <value>The New York International School</value>
        </criteriaItems>
        <description>Syncs the value in the &apos;School_Controlling_Picklist&apos;, &quot;School_Controlling_Picklist1__c&quot; and &quot;School_Controlling_Picklist2__c&quot; fields to be used as controlling fields for picklist values in other dependent fields.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sys%2FAdm - Student Starting Tomorrow</fullName>
        <active>true</active>
        <booleanFilter>(1 OR (2 AND 3)) AND 4 AND 5</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A/ Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Add_to_Register__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Test_Student_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.School__c</field>
            <operation>equals</operation>
            <value>The British International School of Kuala Lumpur</value>
        </criteriaItems>
        <description>Informs the relevant people that a student is starting tomorrow</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Sys_Adm_Student_Starting_Tomorrow</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Trigger Batch_SendKompanionOutboundMessage</fullName>
        <actions>
            <name>Set_Trigger_Batch_SendKompanion_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Deals with cases where the CloseDate is changed for an Enrolled student. This is important to ensure that if the CloseDate is moved forward the Parents get sent to Kompanion as well as the Student. Other Outbound message criteria are still considered.</description>
        <formula>OR(    AND(        OR(           TEXT(StageName) = &quot;Enrolled&quot;,           AND(               TEXT(StageName) = &quot;A/ Deposit&quot;,                            TEXT(Add_to_Register__c) = &quot;Yes&quot;               )           ),        ISCHANGED(CloseDate),             NOT(ISCHANGED(StageName))        ),        AND(        TEXT(StageName) = &quot;A/ Deposit&quot;,                     TEXT(Add_to_Register__c) = &quot;Yes&quot;,        OR(           ISCHANGED(StageName),           ISCHANGED(Add_to_Register__c)           )        )    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Trigger School Kompanion Student Update</fullName>
        <actions>
            <name>Populate_Last_SK_Outbound_Message_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_SK_Student_Created_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Student_to_School_Kompanion</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <formula>AND(     Qualifies_for_SK_Outbound_Message__c = TRUE,     OR(        Send_School_Kompanion_Outbound_Message__c = TRUE,        AND(            ISCHANGED(CloseDate),            NOT(ISCHANGED(StageName))            ),        AND(            NOT(ISCHANGED(CloseDate)),            ISCHANGED(StageName)            ),        ISCHANGED(Kompanion_Keep_On_Roll__c),        ISCHANGED(Make_Off_Roll_In_Kompanion__c),        ISCHANGED(Student_Number_Override__c),        ISCHANGED(AccountId),        ISCHANGED(Student_Name__c),        ISCHANGED(Student_Surname__c),        ISCHANGED(Nickname__c),        ISCHANGED(Gender__c),        ISCHANGED(Nationality__c),        ISCHANGED(Birth_Date__c),        ISCHANGED(Special_Considerations__c),        ISCHANGED(Special_Considerations_Detail__c),        ISCHANGED(Add_to_Register__c),        ISCHANGED(Leaving_Date__c),        ISCHANGED(Next_School__c),        ISCHANGED(Half_Day_PN_N__c),        ISCHANGED(Year_Group__c),        ISCHANGED(Test_Student_Type__c),        ISCHANGED(Class__c),        ISCHANGED(House__c),        ISCHANGED(Teaching_Group__c),        ISCHANGED(Language_Option_Notes__c),        ISCHANGED(EAL_Classification__c),        ISCHANGED(Bus_Service__c),        ISCHANGED(Student_Email__c),        ISCHANGED(Student_Email_Password__c),        ISCHANGED(Disable_Kompanion_Auto_Assign__c),        ISCHANGED(SK_Sports_PE_Grouping__c),        ISCHANGED(SK_Swimming_Grouping__c),        ISCHANGED(SK_Mathematics_Grouping__c),        ISCHANGED(SK_English_Grouping__c),        ISCHANGED(SK_Obligatory_Local_Language_Grouping__c),        ISCHANGED(SK_Obligatory_Local_Language_Override__c),        ISCHANGED(SK_Obligatory_Local_Language__c),        ISCHANGED(SK_MFL_Block__c),        ISCHANGED(SK_MFL_1_Option__c),        ISCHANGED(SK_MFL_2_Option__c),        ISCHANGED(SK_MFL_3_Option__c),        ISCHANGED(SK_MFL_1_Grouping__c),        ISCHANGED(SK_MFL_2_Grouping__c),        ISCHANGED(SK_MFL_3_Grouping__c),        ISCHANGED(SK_GCSE_Science_Option__c),        ISCHANGED(SK_GCSE_Science_Grouping__c),        ISCHANGED(SK_GCSE_Block_A_Option__c),        ISCHANGED(SK_GCSE_Block_B_Option__c),        ISCHANGED(SK_GCSE_Block_C_Option__c),        ISCHANGED(SK_GCSE_Block_D_Option__c),        ISCHANGED(SK_GCSE_Block_E_Option__c),        ISCHANGED(SK_GCSE_Block_F_Option__c),        ISCHANGED(SK_GCSE_Block_A_Grouping__c),        ISCHANGED(SK_GCSE_Block_B_Grouping__c),        ISCHANGED(SK_GCSE_Block_C_Grouping__c),        ISCHANGED(SK_GCSE_Block_D_Grouping__c),        ISCHANGED(SK_GCSE_Block_E_Grouping__c),        ISCHANGED(SK_GCSE_Block_F_Grouping__c),        ISCHANGED(SK_A_Level_Block_A_Option__c),        ISCHANGED(SK_A_Level_Block_B_Option__c),        ISCHANGED(SK_A_Level_Block_C_Option__c),        ISCHANGED(SK_A_Level_Block_D_Option__c),        ISCHANGED(SK_A_Level_Block_E_Option__c),        ISCHANGED(SK_A_Level_Block_F_Option__c),        ISCHANGED(SK_A_Level_Block_A_Grouping__c),        ISCHANGED(SK_A_Level_Block_B_Grouping__c),        ISCHANGED(SK_A_Level_Block_C_Grouping__c),        ISCHANGED(SK_A_Level_Block_D_Grouping__c),        ISCHANGED(SK_A_Level_Block_E_Grouping__c),        ISCHANGED(SK_A_Level_Block_F_Grouping__c),        ISCHANGED(SK_Additional_Learning_1__c),        ISCHANGED(SK_Additional_Learning_2__c),        ISCHANGED(SK_Additional_Learning_3__c),        ISCHANGED(SK_Additional_Learning_1_Grouping_Period__c),        ISCHANGED(SK_Additional_Learning_2_Grouping_Period__c),        ISCHANGED(SK_Additional_Learning_3_Grouping_Period__c),        ISCHANGED(Learning_Support_Provided__c),        ISCHANGED(SK_Learning_Support_Needs__c),        ISCHANGED(SK_Learning_Support_Folder_Link__c)        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UnCheck Korean</fullName>
        <actions>
            <name>Uncheck_Korean</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>notEqual</operation>
            <value>South Korean</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck April Starter Field As Required</fullName>
        <actions>
            <name>Change_April_Starter_to_False</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(AND(April_Starter__c = TRUE, MONTH(CloseDate)&lt;&gt;4), CloseDate&lt;DATE(2012,08,01))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Brazilian</fullName>
        <actions>
            <name>Uncheck_Brazilian</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>notEqual</operation>
            <value>Brazilian</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Filipino</fullName>
        <actions>
            <name>Uncheck_Filipino</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>notEqual</operation>
            <value>Filipino</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Hong Kong</fullName>
        <actions>
            <name>Uncheck_Hong_Kong</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>notEqual</operation>
            <value>Chinese - Hong Kong</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Malaysian</fullName>
        <actions>
            <name>Uncheck_Malaysian</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>notEqual</operation>
            <value>Malaysian</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Russian</fullName>
        <actions>
            <name>Uncheck_Russian</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>notEqual</operation>
            <value>Russian</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Spanish</fullName>
        <actions>
            <name>Uncheck_Spanish</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>notEqual</operation>
            <value>Spanish</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Trigger 30 Day Admissions Notification</fullName>
        <actions>
            <name>Uncheck_Trigger_30_Day_Admissions_Notif</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Trigger_30_Day_Admissions_Notification__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Uzbek</fullName>
        <actions>
            <name>Uncheck_Uzbek</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Nationality__c</field>
            <operation>notEqual</operation>
            <value>Uzbekistani</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Starting Date Change Count</fullName>
        <actions>
            <name>Starting_Date_Change_Count_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Counts the number of times that the starting date of a student is changed to identify any students where there is a possibility of tampering to circumvent auto-auditing</description>
        <formula>AND(     $Profile.Name != &quot;System Administrator&quot;,     ISCHANGED(CloseDate),      OR(        ISPICKVAL(StageName, &quot;Enrolled&quot;),        AND(            ISPICKVAL(StageName, &quot;A/ Deposit&quot;),            ISPICKVAL(Add_to_Register__c, &quot;Yes&quot;)            )        )     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Waiting List Qualification Date</fullName>
        <actions>
            <name>Waiting_List_Qualification_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>W/List D/Paid</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Waiting_List_Qualification_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update bsghub student</fullName>
        <actions>
            <name>Send_Student_Stage</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <description>Update student nodes in bsghub.net when students change in sf</description>
        <formula>NOT($User.Username = &apos;directors@britishschools.co.uk&apos;) &amp;&amp; ISCHANGED( Starting_Date__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Validate Email Address %28Opportunity%29</fullName>
        <actions>
            <name>Invalid_Student_Email_Notification_Opp</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        TEXT(StageName)=&quot;Enrolled&quot;,         TEXT(StageName)=&quot;A/ Deposit&quot;,         TEXT(StageName)=&quot;A/ Testing&quot;,         TEXT(StageName)=&quot;W/List A/Deposit&quot;,         TEXT(StageName)=&quot;W/List D/Paid&quot;        ),      Student_Email__c &lt;&gt; &quot;&quot;,     NOT(REGEX(Student_Email__c, &quot;^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z0-9]{2,4}$&quot;))     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>birthday</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
