<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Add_User_to_territory_Notification</fullName>
        <description>Add User to territory Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Add_to_Territory_Notification</template>
    </alerts>
    <alerts>
        <fullName>Default_Staff_Directory_Positioning_Alert</fullName>
        <ccEmails>directory-notifications@britishschools.co.uk</ccEmails>
        <description>Default Staff Directory Positioning Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>rainbow.integration@nordanglia.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>no-reply@britishschools.co.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>System_Messages/Default_Staff_Directory_Positioning_Alert</template>
    </alerts>
    <alerts>
        <fullName>Notify_of_Error_in_Portal_User_Sync</fullName>
        <description>Notify of Error in Portal User Sync</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Sys_Adm_Portal_User_Sync_Error</template>
    </alerts>
    <alerts>
        <fullName>Send_Chatter_Free_User_Link_Error_Notification</fullName>
        <description>Send Chatter Free User Link Error Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Chatter_Free_User_Link_Error_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Staff_Directory_Info_Received_Notification</fullName>
        <description>Send Staff Directory Info Received Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Staff_Directory_Notification_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Staff_Directory_Info_Received_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Generate_Staff_Directory_Positioning_1</fullName>
        <description>Defines the directory positioning of subject HODs and any SMT/SLT member</description>
        <field>S_Dir_Positioning__c</field>
        <formula>IF(OR(Title = &quot;Headteacher&quot;, Title = &quot;Headmaster&quot;, Title = &quot;Headmistress&quot;, Title = &quot;Head of School&quot;), 1000, 
IF(CONTAINS(Title, &quot;Deputy Headteacher&quot;), 1010,
IF(Title = &quot;Head of Secondary&quot;, 1020,
IF(CONTAINS(Title, &quot;Head of Middle&quot;), 1030,
IF(Title = &quot;Head of Primary&quot;, 1040,
IF(OR(CONTAINS(Title, &quot;Head of Upper School&quot;), CONTAINS(Title, &quot;Head of Upper Campus&quot;)), 1050,
IF(OR(CONTAINS(Title, &quot;Head of Lower School&quot;), CONTAINS(Title, &quot;Head of Lower Campus&quot;)), 1060,
IF(AND(CONTAINS(Title, &quot;Head of&quot;), CONTAINS(Title, &quot;Campus&quot;)), 1070,
IF(OR(Title = &quot;Head of Administration&quot;, Title = &quot;Director of Administration&quot;, Title = &quot;Administration Director&quot;), 1080,
IF(CONTAINS(Title, &quot;Deputy Head of Secondary&quot;), 1090, 
IF(CONTAINS(Title, &quot;Deputy Head of Primary&quot;), 1100,
IF(AND(OR(CONTAINS(Title, &quot;Sixth Form Leader&quot;), CONTAINS(Title, &quot;A-Level&quot;), CONTAINS(Title, &quot;A-level&quot;), CONTAINS(Title, &quot;KS5&quot;), CONTAINS(Title, &quot;Key Stage 5&quot;)), OR(CONTAINS(Title, &quot;Leader&quot;), CONTAINS(Title, &quot;Coordinator&quot;), CONTAINS(Title, &quot;Head of&quot;))), 2000,
IF(AND(OR(CONTAINS(Title, &quot;GCSE&quot;), CONTAINS(Title, &quot;IGCSE&quot;), CONTAINS(Title, &quot;KS4&quot;), CONTAINS(Title, &quot;Key Stage 4&quot;)), OR(CONTAINS(Title, &quot;Leader&quot;), CONTAINS(Title, &quot;Coordinator&quot;), CONTAINS(Title, &quot;Head of&quot;))), 2010,
IF(AND(OR(CONTAINS(Title, &quot;KS3&quot;), CONTAINS(Title, &quot;Key Stage 3&quot;)), 
OR(CONTAINS(Title, &quot;Leader&quot;), CONTAINS(Title, &quot;Coordinator&quot;), CONTAINS(Title, &quot;Head of&quot;))), 2020,
IF(AND(OR(CONTAINS(Title, &quot;KS2&quot;), CONTAINS(Title, &quot;Key Stage 2&quot;), CONTAINS (Title, &quot;Upper Primary&quot;), CONTAINS (Title, &quot;Middle&quot;)), 
OR(CONTAINS(Title, &quot;Leader&quot;), CONTAINS(Title, &quot;Coordinator&quot;), CONTAINS(Title, &quot;Head of&quot;))), 2030,
IF(AND(OR(CONTAINS(Title, &quot;KS1&quot;), CONTAINS (Title, &quot;Lower Primary&quot;), CONTAINS(Title, &quot;Key Stage 1&quot;)), 
OR(CONTAINS(Title, &quot;Leader&quot;), CONTAINS(Title, &quot;Coordinator&quot;), CONTAINS(Title, &quot;Head of&quot;))), 2040,
IF(AND(OR(CONTAINS(Title, &quot;EYFS&quot;), CONTAINS(Title, &quot;Foundation Stage&quot;), CONTAINS(Title, &quot;Early Years&quot;)), OR(CONTAINS(Title, &quot;Leader&quot;), CONTAINS(Title, &quot;Coordinator&quot;), CONTAINS(Title, &quot;Head of&quot;))), 2050,
IF(AND(OR(CONTAINS(Title, &quot;Head of&quot;), CONTAINS(Title, &quot;Director of&quot;), CONTAINS(Title, &quot;Coordinator&quot;)), NOT(CONTAINS(Title, &quot;Head of Year&quot;))),
   IF(CONTAINS(Title, &quot;English&quot;), 3000,
   IF(OR(CONTAINS(Title, &quot;Maths&quot;), CONTAINS(Title, &quot;Math&quot;), CONTAINS(Title, &quot;Mathematics&quot;)), 3010,
   IF(CONTAINS(Title, &quot;Science&quot;), 3020,
   IF(CONTAINS(Title, &quot;Humanities&quot;), 3030,
   IF(CONTAINS(Title, &quot;Geography&quot;), 4031,
   IF(CONTAINS(Title, &quot;History&quot;), 4032,
   IF(CONTAINS(Title, &quot;ICT&quot;), 3040,
   IF(OR(CONTAINS(Title, &quot;P.E.&quot;), CONTAINS(Title, &quot;PE&quot;)), 3050,
   IF(OR(CONTAINS(Title, &quot;Languages&quot;), CONTAINS (Title, &quot;MFL&quot;)), 3060,
   IF(AND(OR(CONTAINS(Title, &quot;Chinese&quot;), CONTAINS(Title, &quot;Mandarin&quot;)), CONTAINS(Title, &quot;Secondary&quot;)), 3070,
   IF(AND(OR(CONTAINS(Title, &quot;Chinese&quot;), CONTAINS(Title, &quot;Mandarin&quot;)), CONTAINS(Title, &quot;Primary&quot;)), 3071,
   IF(OR(CONTAINS(Title, &quot;Chinese&quot;), CONTAINS(Title, &quot;Mandarin&quot;)), 3072,
   IF(CONTAINS(Title, &quot;Russian&quot;), 3080,
   IF(CONTAINS(Title, &quot;Bahasa&quot;), 3090,
   IF(CONTAINS(Title, &quot;Portuguese&quot;), 3100,
   IF(CONTAINS(Title, &quot;Spanish&quot;), 3100,
   IF(OR(CONTAINS(Title, &quot;Arts&quot;), CONTAINS(Title, &quot;Drama&quot;)), 3110,
   IF(CONTAINS(Title, &quot;Music&quot;), 3120, 
   IF(OR(CONTAINS(Title, &quot;Learning Support&quot;), CONTAINS (Title, &quot;SEN&quot;)), 3130, 
   IF(CONTAINS(Title, &quot;EAL&quot;), 3140, 2)))))))))))))))))))),
2 
))))))))))))))))))</formula>
        <name>Generate Staff Directory Positioning 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Staff_Directory_Positioning_2</fullName>
        <description>Defines the directory positioning of teachers and TAs/ATs who specialise in a specific subject</description>
        <field>S_Dir_Positioning__c</field>
        <formula>IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Specialist&quot;)), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 

   IF(CONTAINS(Title, &quot;English&quot;), 4000,
   IF(OR(CONTAINS(Title, &quot;Maths&quot;), CONTAINS(Title, &quot;Math&quot;), CONTAINS(Title, &quot;Mathematics&quot;)), 4010,
   IF(CONTAINS(Title, &quot;Science&quot;), 4020,
   IF(CONTAINS(Title, &quot;Physics&quot;), 4021,
   IF(CONTAINS(Title, &quot;Chemistry&quot;), 4022,
   IF(CONTAINS(Title, &quot;Biology&quot;), 4023,
   IF(CONTAINS(Title, &quot;Humanities&quot;), 4030,
   IF(CONTAINS(Title, &quot;Geography&quot;), 4031,
   IF(CONTAINS(Title, &quot;History&quot;), 4032,
   IF(CONTAINS(Title, &quot;ICT&quot;), 4040,
   IF(OR(CONTAINS(Title, &quot;P.E.&quot;), CONTAINS(Title, &quot;PE&quot;), CONTAINS(Title, &quot;Physical Education&quot;)), 4050,
   IF(CONTAINS(Title, &quot;Swimming&quot;), 4051,
   IF(OR(CONTAINS(Title, &quot;Media Studies&quot;), CONTAINS(Title, &quot;media&quot;)), 4060,
   IF(CONTAINS(Title, &quot;Business Studies&quot;), 4070,
   IF(CONTAINS(Title, &quot;Economics&quot;), 4080,
   IF(OR(CONTAINS(Title, &quot;Languages&quot;), CONTAINS(Title, &quot;MFL&quot;)), 4090,
   IF(OR(CONTAINS(Title, &quot;Chinese&quot;), CONTAINS(Title, &quot;Mandarin&quot;)), 4100,
   IF(CONTAINS(Title, &quot;Russian&quot;), 4110,
   IF(CONTAINS(Title, &quot;Bahasa&quot;), 4120,
   IF(CONTAINS(Title, &quot;Portuguese&quot;), 4130,
   IF(CONTAINS(Title, &quot;Spanish&quot;), 4140,
   IF(CONTAINS(Title, &quot;Uzbek&quot;), 4150,
   IF(CONTAINS(Title, &quot;French&quot;), 4160,
   IF(CONTAINS(Title, &quot;Dutch&quot;), 4170,
   IF(CONTAINS(Title, &quot;German&quot;), 4180,
   IF(OR(CONTAINS(Title, &quot;Expressive Arts&quot;), CONTAINS(Title, &quot;Drama&quot;)), 4190, 
   IF(CONTAINS(Title, &quot;Music&quot;), 4200,
   IF(OR(CONTAINS(Title, &quot;Art &amp; Design&quot;), CONTAINS(Title, &quot;Art&quot;)), 4210,
   IF(CONTAINS(Title, &quot;Graphic Design&quot;), 4220,
   IF(CONTAINS(Title, &quot;EAL&quot;), 4240,

3)))))))))))))))))))))))))))))),
 
IF(OR(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;Assistant&quot;)), CONTAINS(Title, &quot;Coach&quot;)), 

   IF(CONTAINS(Title, &quot;English&quot;), 4005,
   IF(OR(CONTAINS(Title, &quot;Maths&quot;), CONTAINS(Title, &quot;Math&quot;), CONTAINS(Title, &quot;Mathematics&quot;)), 4015,
   IF(CONTAINS(Title, &quot;Science&quot;), 4025,
   IF(CONTAINS(Title, &quot;Physics&quot;), 4026,
   IF(CONTAINS(Title, &quot;Chemistry&quot;), 4027,
   IF(CONTAINS(Title, &quot;Biology&quot;), 4028,
   IF(CONTAINS(Title, &quot;Humanities&quot;), 4035,
   IF(CONTAINS(Title, &quot;Geography&quot;), 4036,
   IF(CONTAINS(Title, &quot;History&quot;), 4037,
   IF(CONTAINS(Title, &quot;ICT&quot;), 4045,
   IF(OR(CONTAINS(Title, &quot;P.E.&quot;), CONTAINS(Title, &quot;PE&quot;), CONTAINS(Title, &quot;Physical Education&quot;)), 4055,
   IF(CONTAINS(Title, &quot;Swimming&quot;), 4056,
   IF(OR(CONTAINS(Title, &quot;Media Studies&quot;), CONTAINS(Title, &quot;media&quot;)), 4065,
   IF(CONTAINS(Title, &quot;Business Studies&quot;), 4075,
   IF(CONTAINS(Title, &quot;Economics&quot;), 4085,
   IF(OR(CONTAINS(Title, &quot;Languages&quot;), CONTAINS(Title, &quot;MFL&quot;)), 4095,
   IF(OR(CONTAINS(Title, &quot;Chinese&quot;), CONTAINS(Title, &quot;Mandarin&quot;)), 4105,
   IF(CONTAINS(Title, &quot;Russian&quot;), 4115,
   IF(CONTAINS(Title, &quot;Bahasa&quot;), 4125,
   IF(CONTAINS(Title, &quot;Portuguese&quot;), 4135,
   IF(CONTAINS(Title, &quot;Spanish&quot;), 4145,
   IF(CONTAINS(Title, &quot;Uzbek&quot;), 4155,
   IF(CONTAINS(Title, &quot;French&quot;), 4165,
   IF(CONTAINS(Title, &quot;Dutch&quot;), 4175,
   IF(CONTAINS(Title, &quot;German&quot;), 4185,
   IF(OR(CONTAINS(Title, &quot;Expressive Arts&quot;), CONTAINS(Title, &quot;Drama&quot;)), 4195, 
   IF(CONTAINS(Title, &quot;Music&quot;), 4205,
   IF(OR(CONTAINS(Title, &quot;Art &amp; Design&quot;), CONTAINS(Title, &quot;Art&quot;)), 4215,
   IF(CONTAINS(Title, &quot;Graphic Design&quot;), 4225,
   IF(CONTAINS(Title, &quot;EAL&quot;), 4245,

3)))))))))))))))))))))))))))))),

3))</formula>
        <name>Generate Staff Directory Positioning 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Staff_Directory_Positioning_3</fullName>
        <description>Defines the directory positioning of teachers and TAs/ATs who DO NOT specialise in a specific subject</description>
        <field>S_Dir_Positioning__c</field>
        <formula>IF(CONTAINS(Title, &quot;13&quot;), 5010,
IF(CONTAINS(Title, &quot;12&quot;), 5020,
IF(CONTAINS(Title, &quot;11&quot;), 5030, 
IF(CONTAINS(Title, &quot;10&quot;), 5040, 
IF(CONTAINS(Title, &quot;9&quot;), 5050, 
IF(CONTAINS(Title, &quot;8&quot;), 5060,
IF(CONTAINS(Title, &quot;7&quot;), 5070, 

IF(OR(CONTAINS(Title, &quot;Year 6 Group Leader&quot;), CONTAINS(Title, &quot;Y6 Group Leader&quot;), CONTAINS(Title, &quot;Y6 Year Group Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;6&quot;))), 5080, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;6&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 5090, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;6&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 5100,

IF(OR(CONTAINS(Title, &quot;Year 5 Group Leader&quot;), CONTAINS(Title, &quot;Y5 Group Leader&quot;), CONTAINS(Title, &quot;Y5 Year Group Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;5&quot;))), 5110, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;5&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 5120, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;5&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 5130,

IF(OR(CONTAINS(Title, &quot;Year 4 Group Leader&quot;), CONTAINS(Title, &quot;Y4 Group Leader&quot;), CONTAINS(Title, &quot;Y4 Year Group Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;4&quot;))), 5140, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;4&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 5150, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;4&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 5160,

IF(OR(CONTAINS(Title, &quot;Year 3 Group Leader&quot;), CONTAINS(Title, &quot;Y3 Group Leader&quot;), CONTAINS(Title, &quot;Y3 Year Group Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;3&quot;))), 5170, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;3&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 5180, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;3&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 5190,

IF(OR(CONTAINS(Title, &quot;Year 2 Group Leader&quot;), CONTAINS(Title, &quot;Y2 Group Leader&quot;), CONTAINS(Title, &quot;Y2 Year Group Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;2&quot;))), 5200, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;2&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 5210, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;2&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 5220,

IF(OR(CONTAINS(Title, &quot;Year 1 Group Leader&quot;), CONTAINS(Title, &quot;Y1 Group Leader&quot;), CONTAINS(Title, &quot;Y1 Year Group Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;1&quot;))), 5230, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;1&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 5240, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;1&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 5250,

4)))))))))))))))))))))))))</formula>
        <name>Generate Staff Directory Positioning 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Staff_Directory_Positioning_4</fullName>
        <description>Defines the directory positioning of EYFS year group leaders, teachers, TAs/ATs, Librarians and other misc. academic positions</description>
        <field>S_Dir_Positioning__c</field>
        <formula>IF(OR(CONTAINS(Title, &quot;Year Reception Group Leader&quot;), CONTAINS(Title, &quot;Reception Group Leader&quot;), CONTAINS(Title, &quot;Reception Year Group Leader&quot;), CONTAINS(Title, &quot;Reception Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;Reception&quot;))), 6000, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Reception&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 6010, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;Reception&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 6020, 

IF(OR(CONTAINS(Title, &quot;Year Kindergarten Group Leader&quot;), CONTAINS(Title, &quot;Kindergarten Group Leader&quot;), CONTAINS(Title, &quot;Kindergarten Year Group Leader&quot;), CONTAINS(Title, &quot;Kindergarten Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;Kindergarten&quot;))), 6030, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Kindergarten&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 6040, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;Kindergarten&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 6050,

IF(OR(CONTAINS(Title, &quot;Year Pre-Kindergarten Group Leader&quot;), CONTAINS(Title, &quot;Pre-Kindergarten Group Leader&quot;), CONTAINS(Title, &quot;Pre-Kindergarten Year Group Leader&quot;), CONTAINS(Title, &quot;Pre-Kindergarten Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;Pre-Kindergarten&quot;))), 6060, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Pre-Kindergarten&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 6070, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;Pre-Kindergarten&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 6080,

IF(OR(CONTAINS(Title, &quot;Year Pre-K Group Leader&quot;), CONTAINS(Title, &quot;Pre-K Group Leader&quot;), CONTAINS(Title, &quot;Pre-K Year Group Leader&quot;), CONTAINS(Title, &quot;Pre-K Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;Pre-K&quot;))), 6090, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Pre-K&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 6100, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;Pre-K&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 6110,

IF(OR(CONTAINS(Title, &quot;Year Nursery Group Leader&quot;), CONTAINS(Title, &quot;Nursery Group Leader&quot;), CONTAINS(Title, &quot;Nursery Year Group Leader&quot;), CONTAINS(Title, &quot;Nursery Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;Nursery&quot;))), 6120, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Nursery&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 6130, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;Nursery&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 6140,

IF(OR(CONTAINS(Title, &quot;Year Pre-Nursery Group Leader&quot;), CONTAINS(Title, &quot;Pre-Nursery Group Leader&quot;), CONTAINS(Title, &quot;Pre-Nursery Year Group Leader&quot;), CONTAINS(Title, &quot;Pre-Nursery Leader&quot;), AND(CONTAINS(Title, &quot;Year Group Leader&quot;), CONTAINS(Title, &quot;Pre-Nursery&quot;))), 6150, 

IF(AND(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Pre-Nursery&quot;), NOT(CONTAINS(Title, &quot;Assistant&quot;))), 6160, 

IF(AND(OR(CONTAINS(Title, &quot;Teacher&quot;), CONTAINS(Title, &quot;Teaching&quot;)), CONTAINS(Title, &quot;Pre-Nursery&quot;), CONTAINS(Title, &quot;Assistant&quot;)), 6170,

IF(OR(CONTAINS(Title, &quot;Exams&quot;), CONTAINS(Title, &quot;Exam&quot;), CONTAINS(Title, &quot;Careers&quot;)), 6180,

IF(OR(CONTAINS(Title, &quot;Library&quot;), CONTAINS(Title, &quot;Librarian&quot;)), 6190,

5))))))))))))))))))))</formula>
        <name>Generate Staff Directory Positioning 4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Staff_Directory_Positioning_5</fullName>
        <description>Defines the directory positioning of admin staff</description>
        <field>S_Dir_Positioning__c</field>
        <formula>IF(AND(CONTAINS(Title, &quot;Learning Support&quot;), OR(CONTAINS(Title, &quot;Coordinator&quot;), CONTAINS(Title, &quot;Director&quot;), CONTAINS(Title, &quot;Leader&quot;))), 4230,
IF(CONTAINS(Title, &quot;Learning Support&quot;), 4235,

IF(OR(CONTAINS(Title, &quot;Head of Admissions&quot;), CONTAINS(Title, &quot;Director of Admissions&quot;)), 7010, 
IF(AND(CONTAINS(Title, &quot;Admissions&quot;), CONTAINS(Title, &quot;Senior&quot;)), 7015,
IF(Title = &quot;Admissions Officer&quot;, 7020,
IF(Title = &quot;Admissions Assistant&quot;, 7030, 
IF(CONTAINS(Title, &quot;Admissions&quot;), 7040,
IF(OR(CONTAINS(Title, &quot;Head of Finance&quot;), CONTAINS(Title, &quot;Director of Finance&quot;), CONTAINS(Title, &quot;Head of Accounting&quot;)), 7100,
IF(Title = &quot;Finance Manager&quot;, 7110,
IF(OR(Title = &quot;Head Accountant&quot;, Title = &quot;Senior Accountant&quot;), 7120,
IF(Title = &quot;Accountant&quot;, 7130,
IF(Title = &quot;Invoicing Manager&quot;, 7140,
IF(Title = &quot;Senior Finance Officer&quot;, 7150,
IF(Title = &quot;Finance Officer&quot;, 7160,
IF(Title = &quot;Cashier&quot;, 7170,
IF(OR(CONTAINS(Title, &quot;Finance&quot;), CONTAINS(Title, &quot;Accounts&quot;)), 7180,
IF(OR(CONTAINS(Title, &quot;Admin Manager&quot;), CONTAINS(Title, &quot;Administration Manager&quot;)), 7200,
IF(CONTAINS(Title, &quot;Deputy Head of Admin&quot;), 7210,
IF(OR(CONTAINS(Title, &quot;Head of HR&quot;), CONTAINS(Title, &quot;Head of Human Resources&quot;)), 7220,
IF(OR(CONTAINS(Title, &quot;HR Manager&quot;), CONTAINS(Title, &quot;Human Resources Manager&quot;), CONTAINS(Title, &quot;Human Resource Manager&quot;)), 7230,
IF(AND(CONTAINS(Title, &quot;Senior&quot;), OR(CONTAINS(Title, &quot;HR&quot;), CONTAINS(Title, &quot;Human Resources&quot;), CONTAINS(Title, &quot;Human Resource&quot;))), 7240,
IF(OR(CONTAINS(Title, &quot;HR&quot;), CONTAINS(Title, &quot;Human Resources&quot;), CONTAINS(Title, &quot;Payroll&quot;)), 7250,
IF(AND(CONTAINS(Title, &quot;Facilities&quot;), OR(CONTAINS(Title, &quot;Head of&quot;), CONTAINS(Title, &quot;Manager&quot;))), 7260,
IF(AND(CONTAINS(Title, &quot;Deputy&quot;), CONTAINS(Title, &quot;Facilities&quot;)), 7270,
IF(CONTAINS(Title, &quot;Facilities&quot;), 7280,
IF(OR(CONTAINS(Title, &quot;Head of IT&quot;), CONTAINS(Title, &quot;IT Manager&quot;), CONTAINS(Title, &quot;Head of ICT&quot;), CONTAINS(Title, &quot;ICT Manager&quot;)), 7300,
IF(AND(CONTAINS(Title, &quot;Senior&quot;), OR(CONTAINS(Title, &quot;IT&quot;), CONTAINS(Title, &quot;ICT&quot;))), 7310,
IF(OR(CONTAINS(Title, &quot;ICT Technician&quot;), CONTAINS(Title, &quot;IT Technician&quot;)), 7320,
IF(OR(CONTAINS(Title, &quot;ICT&quot;), CONTAINS(Title, &quot;IT&quot;)), 7330,
IF(OR(CONTAINS(Title, &quot;Marketing&quot;), CONTAINS(Title, &quot;Media&quot;), CONTAINS(Title, &quot;Communication&quot;), CONTAINS(Title, &quot;Design&quot;)), 7340,
IF(AND(CONTAINS(Title, &quot;Operations&quot;), CONTAINS(Title, &quot;Manager&quot;)), 7350,
IF(AND(CONTAINS(Title, &quot;Operations&quot;), CONTAINS(Title, &quot;Senior&quot;)), 7360,
IF(CONTAINS(Title, &quot;Operations&quot;), 7370,
IF(AND(CONTAINS(Title, &quot;Development&quot;), CONTAINS(Title, &quot;Manager&quot;)), 7380,
IF(AND(CONTAINS(Title, &quot;Development&quot;), CONTAINS(Title, &quot;Senior&quot;)), 7390,
IF(CONTAINS(Title, &quot;Development&quot;), 7400,
IF(AND(CONTAINS(Title, &quot;Services&quot;), CONTAINS(Title, &quot;Manager&quot;)), 7410,
IF(AND(CONTAINS(Title, &quot;Services&quot;), CONTAINS(Title, &quot;Senior&quot;)), 7420,
IF(CONTAINS(Title, &quot;Services&quot;), 7430,
IF(AND(CONTAINS(Title, &quot;Purchasing&quot;), CONTAINS(Title, &quot;Manager&quot;)), 7440,
IF(AND(CONTAINS(Title, &quot;Purchasing&quot;), CONTAINS(Title, &quot;Senior&quot;)), 7450,
IF(CONTAINS(Title, &quot;Purchasing&quot;), 7460,

IF(CONTAINS(Title, &quot;Administration&quot;), 7470,
IF(CONTAINS(Title, &quot;Office Manager&quot;), 7480,
IF(OR(CONTAINS(Title, &quot;Front Desk&quot;), CONTAINS(Title, &quot;Receptionist&quot;)), 7490,
IF(CONTAINS(Title, &quot;PA to&quot;), 7500,
IF(CONTAINS(Title, &quot;Enrichment&quot;), 7510,
IF(CONTAINS(Title, &quot;Nurse&quot;), 7520,
IF(CONTAINS(Title, &quot;Driver&quot;), 7530,

9999)))))))))))))))))))))))))))))))))))))))))))))))))</formula>
        <name>Generate Staff Directory Positioning 5</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_BCB</fullName>
        <field>School__c</field>
        <literalValue>The British College of Brazil</literalValue>
        <name>Populate Chatter Free User School (BCB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_BISM</fullName>
        <field>School__c</field>
        <literalValue>The British International School of Marbella</literalValue>
        <name>Populate Chatter Free User School (BISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_BSB</fullName>
        <field>School__c</field>
        <literalValue>The British School of Brasilia</literalValue>
        <name>Populate Chatter Free User School (BSB)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_BSKL</fullName>
        <field>School__c</field>
        <literalValue>The British International School of Kuala Lumpur</literalValue>
        <name>Populate Chatter Free User School (BSKL)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_BSNJ</fullName>
        <field>School__c</field>
        <literalValue>The British School of Nanjing</literalValue>
        <name>Populate Chatter Free User School (BSNJ)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_BSNV</fullName>
        <field>School__c</field>
        <literalValue>The British School of Navarra</literalValue>
        <name>Populate Chatter Free User School (BSNV)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_BST</fullName>
        <field>School__c</field>
        <literalValue>The British School of Tashkent</literalValue>
        <name>Populate Chatter Free User School (BST)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_BSY</fullName>
        <field>School__c</field>
        <literalValue>The British School Yangon</literalValue>
        <name>Populate Chatter Free User School (BSY)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_ISM</fullName>
        <field>School__c</field>
        <literalValue>The International School of Moscow</literalValue>
        <name>Populate Chatter Free User School (ISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_NAISM</fullName>
        <field>School__c</field>
        <literalValue>Nord Anglia International School Manila</literalValue>
        <name>Populate Chatter Free User School(NAISM)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_School_NYIS</fullName>
        <field>School__c</field>
        <literalValue>The New York International School</literalValue>
        <name>Populate Chatter Free User School (NYIS)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Chatter_Free_User_Title</fullName>
        <field>Title</field>
        <formula>IF(
   OR(
      CONTAINS(Email, &quot;@internationalschool.ru&quot;),
      CONTAINS(Username, &quot;@internationalschool.ru&quot;)
      ),
   &quot;Assistant Teacher&quot;, &quot;Teaching Assistant&quot;
   )</formula>
        <name>Populate Chatter Free User Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Has_Parent_Logged_in_Field</fullName>
        <field>Parent_Has_Logged_In__c</field>
        <literalValue>1</literalValue>
        <name>Populate Has Parent Logged in Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Personal_Interests_Not_Blank</fullName>
        <field>S_Dir_Personal_Interests_Not_Blank__c</field>
        <formula>IF(ISBLANK(S_Dir_Personal_Interests__c), &quot;False&quot;, &quot;True&quot;)</formula>
        <name>Populate Personal Interests Not Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_User_City</fullName>
        <field>City</field>
        <formula>CASE(TEXT(School__c), 

&quot;The International School of Moscow&quot;, &quot;Moscow&quot;,

&quot;The British College of Brazil&quot;, &quot;São Paulo&quot;,

&quot;The British School of Brasilia&quot;, &quot;Brasília&quot;,

&quot;The British School of Tashkent&quot;, &quot;Tashkent&quot;, 
 
&quot;The British International School of Marbella&quot;, &quot;Marbella&quot;, 

&quot;The British School of Navarra&quot;, &quot;Pamplona&quot;, 

&quot;The British School of Nanjing&quot;, &quot;Nanjing&quot;, 

&quot;The British International School of Kuala Lumpur&quot;, &quot;Selangor&quot;, 

&quot;Nord Anglia International School Manila&quot;, &quot;Paranaque City, Metro Manila&quot;, 

&quot;The British International School Yangon&quot;, &quot;Yangon&quot;, 

&quot;The New York International School&quot;, &quot;New York&quot;, &quot;&quot;)</formula>
        <name>Populate User City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_User_Country</fullName>
        <field>Country</field>
        <formula>CASE(TEXT(School__c), 

&quot;The International School of Moscow&quot;, &quot;Russia&quot;, 

&quot;The British College of Brazil&quot;, &quot;Brazil&quot;, 

&quot;The British School of Brasilia&quot;, &quot;Brazil&quot;, 

&quot;The British School of Tashkent&quot;, &quot;Uzbekistan&quot;, 

&quot;The British International School of Marbella&quot;, &quot;Spain&quot;, 

&quot;The British School of Navarra&quot;, &quot;Spain&quot;, 

&quot;The British School of Nanjing&quot;, &quot;China&quot;, 

&quot;The British International School of Kuala Lumpur&quot;, &quot;Malaysia&quot;, 

&quot;Nord Anglia International School Manila&quot;, &quot;Philippines&quot;, 

&quot;The British International School Yangon&quot;, &quot;Myanmar&quot;, 

&quot;The New York International School&quot;, &quot;United States&quot;, &quot;&quot;)</formula>
        <name>Populate User Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_User_Phone</fullName>
        <field>Phone</field>
        <formula>IF(AND(TEXT(School__c) = &quot;The International School of Moscow&quot;, OR(TEXT(Campus__c) = &quot;Krylatskoe&quot;, TEXT(Campus__c) = &quot;Cross-Campus&quot;)), &quot;+7 (499) 922 4400&quot;, 

IF(AND(TEXT(School__c) = &quot;The International School of Moscow&quot;, TEXT(Campus__c) = &quot;Rosinka&quot;), &quot;+7 (499) 922 4405&quot;, 

IF(AND(TEXT(School__c) = &quot;The British College of Brazil&quot;, OR(TEXT(Campus__c) = &quot;Chácara Flora&quot;, TEXT(Campus__c) = &quot;Cross-Campus&quot;)), &quot;+55 11 5523 5052&quot;, 

IF(AND(TEXT(School__c) = &quot;The British College of Brazil&quot;, TEXT(Campus__c) = &quot;Cidade Jardim&quot;), &quot;+55 11 3031 4697&quot;, 

IF(AND(TEXT(School__c) = &quot;The British School of Tashkent&quot;, OR(TEXT(Campus__c) = &quot;Upper Campus&quot;, TEXT(Campus__c) = &quot;Cross-Campus&quot;)), &quot;+99871-268-55-61/ +99871-268-55-62&quot;, 

IF(AND(TEXT(School__c) = &quot;The British School of Tashkent&quot;, TEXT(Campus__c) = &quot;Lower Campus&quot;), &quot;+99871-262-60-20&quot;, 

CASE(TEXT(School__c), 

&quot;The British School of Brasilia&quot;, &quot;+55 11 5523 5052&quot;, /*Phone number not available - needs updating*/

&quot;The British International School of Marbella&quot;, &quot;(+34) 952-779-264&quot;, 

&quot;The British School of Navarra&quot;, &quot;(+34) 948-242-826&quot;, 

&quot;The British School of Nanjing&quot;, &quot;+86 25 5210 8987&quot;, 

&quot;The British International School of Kuala Lumpur&quot;, &quot;+6 03 7727 7775&quot;, 

&quot;Nord Anglia International School Manila&quot;, &quot;+63 2 519 5799&quot;, 

&quot;The British International School Yangon&quot;, &quot;+95 (0) 9 250739873&quot;, 

&quot;The New York International School&quot;, &quot;&quot;, &quot;&quot;)))))))</formula>
        <name>Populate User Phone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_User_State_Province</fullName>
        <field>State</field>
        <formula>CASE(TEXT(School__c), 

&quot;The British School of Navarra&quot;, &quot;Navarra&quot;, 

&quot;The British School of Nanjing&quot;, &quot;Jiangning District&quot;, &quot;&quot;)</formula>
        <name>Populate User State/Province</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_User_Street</fullName>
        <field>Street</field>
        <formula>IF(AND(TEXT(School__c) = &quot;The International School of Moscow&quot;, OR(TEXT(Campus__c) = &quot;Krylatskoe&quot;, TEXT(Campus__c) = &quot;Cross-Campus&quot;)), &quot;Krylatskoe Campus&quot;&amp;BR()&amp;&quot;Buildings 5 &amp; 6, Krylatskaya Street 12, Krylatskoe&quot;, 

IF(AND(TEXT(School__c) = &quot;The International School of Moscow&quot;, TEXT(Campus__c) = &quot;Rosinka&quot;), &quot;Rosinka Campus&quot;&amp;BR()&amp;&quot;IRC Rosinka, Village Angelovo, Krasnogorsky Region&quot;,

IF(AND(TEXT(School__c) = &quot;The British College of Brazil&quot;, OR(TEXT(Campus__c) = &quot;Chácara Flora&quot;, TEXT(Campus__c) = &quot;Cross-Campus&quot;)), &quot;Campus Chácara Flora&quot;&amp;BR()&amp;&quot;Rua Alvares de Azevedo, n.50,&quot;&amp;BR()&amp;&quot;Chacara Flora&quot;,

IF(AND(TEXT(School__c) = &quot;The British College of Brazil&quot;, TEXT(Campus__c) = &quot;Cidade Jardim&quot;), &quot;Campus Cidade Jardim&quot;&amp;BR()&amp;&quot;Avenida Engenheiro Oscar Americano, 630,&quot;&amp;BR()&amp;&quot;Cidade Jardim - Morumbi&quot;,

IF(AND(TEXT(School__c) = &quot;The British School of Tashkent&quot;, OR(TEXT(Campus__c) = &quot;Upper Campus&quot;, TEXT(Campus__c) = &quot;Cross-Campus&quot;)), &quot;Upper Campus&quot;&amp;BR()&amp;&quot;Sayram Street Bld 30a,&quot;&amp;BR()&amp;&quot;Mirzo-Ulugbek District&quot;,

IF(AND(TEXT(School__c) = &quot;The British School of Tashkent&quot;, TEXT(Campus__c) = &quot;Lower Campus&quot;), &quot;Lower Campus&quot;&amp;BR()&amp;&quot;Yassi Street Bld 15,&quot;&amp;BR()&amp;&quot;Mirzo-Ulugbek District&quot;,

CASE(TEXT(School__c), 

&quot;The British School of Brasilia&quot;, &quot;EQS 708/907, Lote C,&quot;&amp;BR()&amp;&quot;Asa Sul&quot;, 

&quot;The British International School of Marbella&quot;, &quot;Calle Jacinto Benavente S/N&quot;, 

&quot;The British School of Navarra&quot;, &quot;Avenida Juan Pablo II, 1,&quot;, 

&quot;The British School of Nanjing&quot;, &quot;16 Han Fu Lu&quot;, 

&quot;The British International School of Kuala Lumpur&quot;, &quot;No. 1, Changkat Bukit Utama&quot;&amp;BR()&amp;&quot;Bandar Utama, Petaling Jaya&quot;,

&quot;Nord Anglia International School Manila&quot;, &quot;Bradco Avenue, Aseana Business Park&quot;, 

&quot;The British International School Yangon&quot;, &quot;2A Yangon-Insein Road,&quot;&amp;BR()&amp;&quot;Ward No. 9, Hlaing Township,&quot;, 

&quot;The New York International School&quot;, &quot;4 East 90th Street&quot;, &quot;&quot;)))))))</formula>
        <name>Populate User Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_User_Zip_Postal_Code</fullName>
        <field>PostalCode</field>
        <formula>IF(AND(TEXT(School__c) = &quot;The International School of Moscow&quot;, OR(TEXT(Campus__c) = &quot;Krylatskoe&quot;, TEXT(Campus__c) = &quot;Cross-Campus&quot;)), &quot;121552&quot;, 

IF(AND(TEXT(School__c) = &quot;The International School of Moscow&quot;, TEXT(Campus__c) = &quot;Rosinka&quot;), &quot;143442&quot;, 

IF(AND(TEXT(School__c) = &quot;The British College of Brazil&quot;, OR(TEXT(Campus__c) = &quot;Chácara Flora&quot;, TEXT(Campus__c) = &quot;Cross-Campus&quot;)), &quot;04662-002&quot;, 

IF(AND(TEXT(School__c) = &quot;The British College of Brazil&quot;, TEXT(Campus__c) = &quot;Cidade Jardim&quot;), &quot;05673-050&quot;, 

CASE(TEXT(School__c), 

&quot;The British School of Brasilia&quot;, &quot;70390-079&quot;, 

&quot;The British International School of Marbella&quot;, &quot;29601&quot;, 

&quot;The British School of Navarra&quot;, &quot;31004&quot;, 

&quot;The British School of Nanjing&quot;, &quot;211106&quot;, 

&quot;The British International School of Kuala Lumpur&quot;, &quot;47800&quot;, 

&quot;Nord Anglia International School Manila&quot;, &quot;1700&quot;, 

&quot;The British International School Yangon&quot;, &quot;11051&quot;, 

&quot;The New York International School&quot;, &quot;10128&quot;, &quot;&quot;)))))</formula>
        <name>Populate User Zip/Postal Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Is_US_Locale_to_FALSE</fullName>
        <field>Is_US_Locale__c</field>
        <literalValue>0</literalValue>
        <name>Set Is US Locale to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Is_US_Locale_to_TRUE</fullName>
        <field>Is_US_Locale__c</field>
        <literalValue>1</literalValue>
        <name>Set Is US Locale to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sync_S_Dir_Title_with_Standard_Title_Fie</fullName>
        <field>S_Dir_Title_New__c</field>
        <formula>Title</formula>
        <name>Sync S/Dir Title with Standard Title Fie</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sync_Standard_Title_with_S_Dir_Title_Fie</fullName>
        <field>Title</field>
        <formula>S_Dir_Title_New__c</formula>
        <name>Sync Standard Title with S/Dir Title Fie</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Synced_via_Apex</fullName>
        <field>Synced_Apex__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Synced via Apex</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>User_Check_Populate_Portal_User_Email</fullName>
        <field>Populate_Portal_User_Email__c</field>
        <literalValue>1</literalValue>
        <name>User - Check Populate Portal User Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Add to Territory Notification</fullName>
        <actions>
            <name>Add_User_to_territory_Notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4</booleanFilter>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Teacher</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Parent Portal User - High Volume</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Chatter Free User</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>School Nurse</value>
        </criteriaItems>
        <description>Send a notification to IT and Group Admin a notification after user creation about adding user to a Territory</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Default Staff Directory Positioning Alert</fullName>
        <active>true</active>
        <formula>AND(  OR(  S_Dir_Positioning__c = 2,  S_Dir_Positioning__c = 9999  ),  Override_Manually__c != TRUE,  IsActive = TRUE,  S_Dir_Profile_Approved_by_Admin__c = TRUE  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Default_Staff_Directory_Positioning_Alert</name>
                <type>Alert</type>
            </actions>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Generate Staff Directory Positioning 1</fullName>
        <actions>
            <name>Generate_Staff_Directory_Positioning_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(Override_Manually__c != TRUE, OR(ISCHANGED(Title), ISCHANGED(S_Dir_Positioning__c), S_Dir_Positioning__c = 1, ISCHANGED(Override_Manually__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Staff Directory Positioning 2</fullName>
        <actions>
            <name>Generate_Staff_Directory_Positioning_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Override_Manually__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.S_Dir_Positioning__c</field>
            <operation>equals</operation>
            <value>2</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Staff Directory Positioning 3</fullName>
        <actions>
            <name>Generate_Staff_Directory_Positioning_3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Override_Manually__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.S_Dir_Positioning__c</field>
            <operation>equals</operation>
            <value>3</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Staff Directory Positioning 4</fullName>
        <actions>
            <name>Generate_Staff_Directory_Positioning_4</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Override_Manually__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.S_Dir_Positioning__c</field>
            <operation>equals</operation>
            <value>4</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Staff Directory Positioning 5</fullName>
        <actions>
            <name>Generate_Staff_Directory_Positioning_5</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Override_Manually__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.S_Dir_Positioning__c</field>
            <operation>equals</operation>
            <value>5</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28BCB%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_BCB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@britishcollegebrazil.org</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@britishcollegebrazil.org</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28BISM%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_BISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@bsm.org.es</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@bsm.org.es</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28BSB%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_BSB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@britishschoolbrasilia.org</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@britishschoolbrasilia.org</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28BSKL%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_BSKL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@britishschool.edu.my</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@britishschool.edu.my</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28BSNJ%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_BSNJ</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@bsn.org.cn</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@bsn.org.cn</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28BSNV%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_BSNV</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@bsn.org.es</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@bsn.org.es</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28BST%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_BST</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@britishschool.uz</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@britishschool.uz</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28BSY%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_BSY</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@britishschoolyangon.org</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@britishschoolyangon.org</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28ISM%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_ISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@internationalschool.ru</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@internationalschool.ru</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28NAISM%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_NAISM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@kings.org.ph</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@kings.org.ph</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User School %28NYIS%29</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_School_NYIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>User.Email</field>
            <operation>contains</operation>
            <value>@nyis.org</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>contains</operation>
            <value>@nyis.org</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Chatter Free User Title</fullName>
        <actions>
            <name>Populate_Chatter_Free_User_Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>Chatter Free User</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Has Parent Logged in Field</fullName>
        <actions>
            <name>Populate_Has_Parent_Logged_in_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.LastLoginDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>Parent Portal User - High Volume</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Parent_Has_Logged_In__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Internal User Address Fields</fullName>
        <actions>
            <name>Populate_User_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_User_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_User_Phone</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_User_State_Province</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_User_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_User_Zip_Postal_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Parent Portal User - High Volume</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.School__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Populates the address fields of an internal user so that the details look correct in the parent portal/school hub</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Personal Interests Not Blank</fullName>
        <actions>
            <name>Populate_Personal_Interests_Not_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Parent Portal User - High Volume</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>Customer Community Plus User</value>
        </criteriaItems>
        <description>Populates Personal Interests Not Blank depending on the contents of the Personal Interests (long text area) field</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Portal User Email</fullName>
        <active>true</active>
        <criteriaItems>
            <field>User.IsPortalEnabled</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>User_Check_Populate_Portal_User_Email</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Portal Contact Sync Notification</fullName>
        <actions>
            <name>Notify_of_Error_in_Portal_User_Sync</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>User.Portal_Contact_Sync_Failed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Send an email notifying system admin when a contact is updated but the changes cannot be reflected in the related user record</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Chatter Free User Link Error Email</fullName>
        <actions>
            <name>Send_Chatter_Free_User_Link_Error_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Trigger_Chatter_Free_User_Created_Email__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Sends when a new chatter free (TA/AT) user is created that cannot be linked to a staff member record</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Staff Directory Received Notification</fullName>
        <actions>
            <name>Send_Staff_Directory_Info_Received_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Staff_Directory_Info_Received__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Is US Locale to FALSE</fullName>
        <actions>
            <name>Set_Is_US_Locale_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>User.LocaleSidKey</field>
            <operation>notEqual</operation>
            <value>English (United States)</value>
        </criteriaItems>
        <description>Do not deactivate and do not delete. Used for testing in sandboxes to debug the portal user creation error bug.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Is US Locale to TRUE</fullName>
        <actions>
            <name>Set_Is_US_Locale_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>User.LocaleSidKey</field>
            <operation>equals</operation>
            <value>English (United States)</value>
        </criteriaItems>
        <description>Do not deactivate and do not delete. Used for testing in sandboxes to debug the portal user creation error bug.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync S%2FDir Title with Standard Title Field</fullName>
        <actions>
            <name>Sync_S_Dir_Title_with_Standard_Title_Fie</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Required so that the title of a user can be changed on the user profile staff directory tab as well as directly on the user record.</description>
        <formula>AND(Profile.Name &lt;&gt; &quot;Parent Portal User - High Volume&quot;, OR(NOT(ISCHANGED(S_Dir_Title_New__c)), S_Dir_Title_New__c = &quot;&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync Standard Title with S%2FDir Title Field</fullName>
        <actions>
            <name>Sync_Standard_Title_with_S_Dir_Title_Fie</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Required so that the title of a user can be changed on the user profile staff directory tab as well as directly on the user record.</description>
        <formula>AND(Profile.Name &lt;&gt; &quot;Parent Portal User - High Volume&quot;, NOT(ISCHANGED(Title)), S_Dir_Title_New__c &lt;&gt; &quot;&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Synced via Apex</fullName>
        <actions>
            <name>Uncheck_Synced_via_Apex</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Synced_Apex__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Unchecks the Synced via Apex checkbox which is checked to bypass validation rules that stop direct editing of the user record when parent contact information is updated on the contact record and subsequently passed to the user record. Runs after trigger.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
