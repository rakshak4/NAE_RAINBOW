<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ISM_News_Record_Published_Notification_Marketing_Manager</fullName>
        <description>ISM News Record Published Notification Marketing Manager</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_News_Published_Group_Designer</template>
    </alerts>
    <alerts>
        <fullName>News_Record_Published_Notification_Group_Designer</fullName>
        <description>News Record Published Notification Group Designer</description>
        <protected>false</protected>
        <recipients>
            <recipient>nae.migration@britishschools.co.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/New_News_Published_Group_Designer</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_Notification_Type_to_Edited</fullName>
        <field>Notification_Type__c</field>
        <literalValue>Edited</literalValue>
        <name>Change Notification Type to Edited</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Notification_Type_to_Standard</fullName>
        <field>Notification_Type__c</field>
        <literalValue>Standard</literalValue>
        <name>Change Notification Type to Standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_Event_Translatio</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Holiday_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to Event Translatio</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_Event_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Event_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to Event Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_News_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>News_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to News Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_Notice_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Notice_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to Notice Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_Term_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Term_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to Term Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Id</fullName>
        <field>IdText__c</field>
        <formula>Id</formula>
        <name>Copy Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_News_Id</fullName>
        <field>CopyNewsId__c</field>
        <formula>Id</formula>
        <name>Copy News Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Title_For_Term_Date</fullName>
        <field>Name</field>
        <formula>TEXT(Term_Date_Identifier__c) &amp;&quot; &quot;&amp; TEXT(Term__c)</formula>
        <name>Generate Title For Term Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Title_For_Translated_Term_Date</fullName>
        <field>Name</field>
        <formula>IF(TEXT(Language__c)=&quot;RU&quot;, 

IF(TEXT(English_Parent__r.Term_Date_Identifier__c) = &quot;First day of&quot;, &quot;Первый день &quot;, &quot;Последний день &quot;) &amp; 

CASE(TEXT(English_Parent__r.Term__c), &quot;Term One&quot;, &quot;1-ого триместра &quot;, &quot;Term Two&quot;, &quot;2-ого триместра &quot;, &quot;3-его триместра &quot;), 

IF(TEXT(Language__c)=&quot;ES&quot;, 

IF(TEXT(English_Parent__r.Term_Date_Identifier__c) = &quot;First day of&quot;, &quot;Primer día del &quot;, &quot;Ultimo día del &quot;) &amp; 

CASE(TEXT(English_Parent__r.Term__c), &quot;Term One&quot;, &quot;trimestre uno&quot;, &quot;Term Two&quot;, &quot;trimestre dos&quot;, &quot;trimestre tres&quot;), 

IF(TEXT(Language__c)=&quot;PT&quot;, 

IF(TEXT(English_Parent__r.Term_Date_Identifier__c) = &quot;First day of&quot;, &quot;Primeiro dia do &quot;, &quot;Ultimo dia do &quot;) &amp; 

CASE(TEXT(English_Parent__r.Term__c), &quot;Term One&quot;, &quot;Primeiro Quadrimestre&quot;, &quot;Term Two&quot;, &quot;Segundo Quadrimestre&quot;, &quot;Terceiro Quadrimestre&quot;), 

TEXT(English_Parent__r.Term_Date_Identifier__c) &amp;&quot; &quot;&amp; TEXT(English_Parent__r.Term__c))))</formula>
        <name>Generate Title For Translated Term Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>News_Events_Retry_Sending_Email</fullName>
        <description>Updates Retry Sending Email to true</description>
        <field>Retry_Sending_Email__c</field>
        <literalValue>1</literalValue>
        <name>News Events - Retry Sending Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Blog_Post_Preview</fullName>
        <field>Blog_Post_Preview__c</field>
        <formula>Event_Dates_Text_for_Email__c &amp; BR() &amp; BR() &amp; 
Event_Title_For_Email__c &amp; BR() &amp; BR() &amp; 
Subtitle__c &amp; BR() &amp; BR() &amp; 
Main_Text__c &amp; BR() &amp; BR()</formula>
        <name>Populate &apos;Blog Post Preview&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Ess_Info_Teaser_English_N_E</fullName>
        <field>Essential_Info_Teaser_English__c</field>
        <formula>English_Parent__r.Subtitle__c</formula>
        <name>Populate Ess.Info/Teaser (English) (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Ess_Info_Teaser_N_E</fullName>
        <field>Subtitle__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Subtitle__c != &quot;&quot;,
       Subtitle__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Ess.Info/Teaser (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Has_Error_Ids</fullName>
        <field>Has_Error_IDs__c</field>
        <formula>IF(ISBLANK(Error_Ids__c), &quot;No&quot;, &quot;Yes&quot;)</formula>
        <name>Populate Has Error Ids</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Meta_Tag_Desc_English_N_E</fullName>
        <field>Meta_Tag_Description_English__c</field>
        <formula>English_Parent__r.Meta_Tag_Description__c</formula>
        <name>Populate Meta Tag Desc. (English) (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Meta_Tag_Desc_N_E</fullName>
        <field>Meta_Tag_Description__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Meta_Tag_Description__c != &quot;&quot;,
       Meta_Tag_Description__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Meta Tag Desc. (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Meta_Tag_Title_English_N_E</fullName>
        <field>Meta_Tag_Title_English__c</field>
        <formula>English_Parent__r.Meta_Tag_Title__c</formula>
        <name>Populate Meta Tag Title (English) (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Meta_Tag_Title_N_E</fullName>
        <field>Meta_Tag_Title__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Meta_Tag_Title__c != &quot;&quot;,
       Meta_Tag_Title__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Meta Tag Title (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Notification_Edited_Field_Text</fullName>
        <field>Notification_Email_Edited_Fields_Text__c</field>
        <formula>IF(AND(
ISCHANGED(Event_Start_Date__c), 
ISCHANGED(Event_End_Date__c),
ISCHANGED(Name),
ISCHANGED(Subtitle__c)) 
, &quot;Start Date, End Date, Title and Essential Info&quot;,
IF(AND(
ISCHANGED(Event_Start_Date__c), 
ISCHANGED(Event_End_Date__c),
ISCHANGED(Name),
NOT(ISCHANGED(Subtitle__c))) 
, &quot;Start Date, End Date and Title&quot;,
IF(AND(
ISCHANGED(Event_Start_Date__c), 
ISCHANGED(Event_End_Date__c),
NOT(ISCHANGED(Name)),
NOT(ISCHANGED(Subtitle__c))) 
, &quot;Start and End Date&quot;,
IF(AND(
ISCHANGED(Event_Start_Date__c), 
ISCHANGED(Event_End_Date__c),
NOT(ISCHANGED(Name)),
ISCHANGED(Subtitle__c)) 
, &quot;Start Date, End Date and Essential Info&quot;,
IF(AND(
ISCHANGED(Event_Start_Date__c), 
NOT(ISCHANGED(Event_End_Date__c)),
ISCHANGED(Name),
ISCHANGED(Subtitle__c)) 
, &quot;Start Date, Title and Essential Info&quot;,
IF(AND(
ISCHANGED(Event_Start_Date__c), 
NOT(ISCHANGED(Event_End_Date__c)),
ISCHANGED(Name),
NOT(ISCHANGED(Subtitle__c)))  
, &quot;Start Date and Title&quot;,
IF(AND(
ISCHANGED(Event_Start_Date__c), 
NOT(ISCHANGED(Event_End_Date__c)),
NOT(ISCHANGED(Name)),
NOT(ISCHANGED(Subtitle__c))) 
, &quot;Start Date&quot;,
IF(AND(
ISCHANGED(Event_Start_Date__c), 
NOT(ISCHANGED(Event_End_Date__c)),
NOT(ISCHANGED(Name)),
ISCHANGED(Subtitle__c)) 
, &quot;Start Date and Essential Info&quot;,
IF(AND(
NOT(ISCHANGED(Event_Start_Date__c)), 
ISCHANGED(Event_End_Date__c),
ISCHANGED(Name),
ISCHANGED(Subtitle__c)) 
, &quot;End Date, Title and Essential Info&quot;,
IF(AND(
NOT(ISCHANGED(Event_Start_Date__c)), 
ISCHANGED(Event_End_Date__c),
ISCHANGED(Name),
NOT(ISCHANGED(Subtitle__c))) 
, &quot;End Date and Title&quot;,
IF(AND(
NOT(ISCHANGED(Event_Start_Date__c)), 
ISCHANGED(Event_End_Date__c),
NOT(ISCHANGED(Name)),
ISCHANGED(Subtitle__c)) 
, &quot;End Date and Essential Info&quot;,
IF(AND(
NOT(ISCHANGED(Event_Start_Date__c)), 
ISCHANGED(Event_End_Date__c),
NOT(ISCHANGED(Name)),
NOT(ISCHANGED(Subtitle__c)))
, &quot;End Date&quot;,
IF(AND(
NOT(ISCHANGED(Event_Start_Date__c)), 
NOT(ISCHANGED(Event_End_Date__c)),
ISCHANGED(Name),
ISCHANGED(Subtitle__c))  
, &quot;Title and Essential Info&quot;,
IF(AND(
NOT(ISCHANGED(Event_Start_Date__c)), 
NOT(ISCHANGED(Event_End_Date__c)),
ISCHANGED(Name),
NOT(ISCHANGED(Subtitle__c))) 
, &quot;Title&quot;,
IF(AND(
NOT(ISCHANGED(Event_Start_Date__c)), 
NOT(ISCHANGED(Event_End_Date__c)),
NOT(ISCHANGED(Name)),
ISCHANGED(Subtitle__c))  
, &quot;Essential Info&quot;,

&quot;&quot;)))))))))))))))</formula>
        <name>Populate 	Notification Edited Field Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Title_English_N_E</fullName>
        <field>Title_English__c</field>
        <formula>English_Parent__r.Name</formula>
        <name>Populate Title (English) (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Translation_UID</fullName>
        <field>Only_1_Translation_Per_Language_Allowed__c</field>
        <formula>English_Parent__r.Id&amp;TEXT(Language__c)</formula>
        <name>Populate Translation UID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_1_Title_English_N_E</fullName>
        <field>Video_1_Title_English__c</field>
        <formula>English_Parent__r.Video_1_TITLE__c</formula>
        <name>Populate Video 1 Title (English) (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_1_Title_N_E</fullName>
        <field>Video_1_TITLE__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_1_TITLE__c != &quot;&quot;,
       Video_1_TITLE__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Please update the link if different to the English&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Video 1 Title (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_1_URL_N_E</fullName>
        <field>Video_1_URL__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_1_URL__c != &quot;&quot;,
       Video_1_URL__c = &quot;&quot;
       ),
   English_Parent__r.Video_1_URL__c,
   &quot;&quot;
   )</formula>
        <name>Populate Video 1 URL (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_2_Title_English_N_E</fullName>
        <field>Video_2_Title_English__c</field>
        <formula>English_Parent__r.Video_2_TITLE__c</formula>
        <name>Populate Video 2 Title (English) (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_2_Title_N_E</fullName>
        <field>Video_2_TITLE__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_2_TITLE__c != &quot;&quot;,
       Video_2_TITLE__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Please update the link if different to the English&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Video 2 Title (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_2_URL_N_E</fullName>
        <field>Video_2_URL__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_2_URL__c != &quot;&quot;,
       Video_2_URL__c = &quot;&quot;
       ),
   English_Parent__r.Video_2_URL__c,
   &quot;&quot;
   )</formula>
        <name>Populate Video 2 URL (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_3_Title_English_N_E</fullName>
        <field>Video_3_Title_English__c</field>
        <formula>English_Parent__r.Video_3_TITLE__c</formula>
        <name>Populate Video 3 Title (English) (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_3_Title_N_E</fullName>
        <field>Video_3_TITLE__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_3_TITLE__c != &quot;&quot;,
       Video_3_TITLE__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Please update the link if different to the English&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Video 3 Title (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_3_URL_N_E</fullName>
        <field>Video_3_URL__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_3_URL__c != &quot;&quot;,
       Video_3_URL__c = &quot;&quot;
       ),
   English_Parent__r.Video_3_URL__c,
   &quot;&quot;
   )</formula>
        <name>Populate Video 3 URL (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_4_Title_English_N_E</fullName>
        <field>Video_4_Title_English__c</field>
        <formula>English_Parent__r.Video_4_TITLE__c</formula>
        <name>Populate Video 4 Title (English) (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_4_Title_N_E</fullName>
        <field>Video_4_TITLE__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_4_TITLE__c != &quot;&quot;,
       Video_4_TITLE__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Please update the link if different to the English&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Video 4 Title (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_4_URL_N_E</fullName>
        <field>Video_4_URL__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_4_URL__c != &quot;&quot;,
       Video_4_URL__c = &quot;&quot;
       ),
   English_Parent__r.Video_4_URL__c,
   &quot;&quot;
   )</formula>
        <name>Populate Video 4 URL (N&amp;E)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Send_Automated_Reminder_Email_to_True</fullName>
        <field>Send_Automated_Reminder_Email__c</field>
        <literalValue>1</literalValue>
        <name>Send Automated Reminder Email to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Notification_Type_to_Standard</fullName>
        <field>Notification_Type__c</field>
        <literalValue>Standard</literalValue>
        <name>Set Notification Type to Standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Show_as_Featured_News_Item_Until_to_Null</fullName>
        <field>Keep_in_News_Slideshow_Until_Override__c</field>
        <name>Show as Featured News Item Until to Null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sync_Chatter_Group_ID</fullName>
        <field>Related_Chatter_Group_ID_Text__c</field>
        <formula>Related_Chatter_Group_ID__c</formula>
        <name>Sync Chatter Group ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sync_First_Date_of_Term_3</fullName>
        <field>First_Date_of_Term_3_Copy__c</field>
        <formula>First_Date_of_Term_3__c</formula>
        <name>Sync First Date of Term 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sync_Start_Date_with_Date</fullName>
        <field>Event_Start_Date__c</field>
        <formula>Date__c</formula>
        <name>Sync Start Date with Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Change Notification Type to Standard</fullName>
        <actions>
            <name>Change_Notification_Type_to_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Changes the notification type back to standard if a cancelled event is re-published</description>
        <formula>OR(     AND(TEXT(Notification_Type__c) = &quot;Cancelled&quot;,          Publish_in_Portal_School_Hub__c = TRUE        ),    AND(PRIORVALUE(Publish_in_Portal_School_Hub__c) = FALSE,        Publish_in_Portal_School_Hub__c = TRUE        )    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Event Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_Event_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(      RecordType.DeveloperName = &quot;New_Translation&quot;,      English_Parent__r.RecordType.DeveloperName = &quot;Event&quot;      )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Holiday Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_Event_Translatio</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(      RecordType.DeveloperName = &quot;New_Translation&quot;,      English_Parent__r.RecordType.DeveloperName = &quot;Holiday&quot;      )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to News Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_News_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(      RecordType.DeveloperName = &quot;New_Translation&quot;,      English_Parent__r.RecordType.DeveloperName = &quot;News&quot;      )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Notice Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_Notice_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(      RecordType.DeveloperName = &quot;New_Translation&quot;,      English_Parent__r.RecordType.DeveloperName = &quot;Reminder&quot;      )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Term Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_Term_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(      RecordType.DeveloperName = &quot;New_Translation&quot;,      English_Parent__r.RecordType.DeveloperName = &quot;Term&quot;      )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Clear Featured Until Date from News Item</fullName>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.Keep_in_News_Slideshow_Until_Override__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Show_as_Featured_News_Item_Until_to_Null</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>News_Events__c.Keep_in_News_Slideshow_Until_Override__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Copy Id</fullName>
        <actions>
            <name>Copy_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy News Id</fullName>
        <actions>
            <name>Copy_News_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Id&lt;&gt;&quot;&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Blog Post Preview</fullName>
        <actions>
            <name>Populate_Blog_Post_Preview</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.Related_Class_Blog_Available__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Populates the long text area field &apos;Blog Post Preview&apos; based on other information available on the record.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Title For Term Date</fullName>
        <actions>
            <name>Generate_Title_For_Term_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Term</value>
        </criteriaItems>
        <description>Generates the term date title for display on the website / in the portal based on the picklist values provided.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Title For Translated Term Date</fullName>
        <actions>
            <name>Generate_Title_For_Translated_Term_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Term Translation</value>
        </criteriaItems>
        <description>Generates the term date title for display on the website / in the portal based on the picklist values provided on the &apos;English Parent&apos; record.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ISM News Record Notification Marketing Manager</fullName>
        <actions>
            <name>ISM_News_Record_Published_Notification_Marketing_Manager</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND (3 OR 4) AND 5</booleanFilter>
        <criteriaItems>
            <field>News_Events__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>News</value>
        </criteriaItems>
        <criteriaItems>
            <field>News_Events__c.Publish_on_School_Site__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>System Administrator</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>paul.collins@britishschools.co.uk</value>
        </criteriaItems>
        <criteriaItems>
            <field>News_Events__c.School__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <description>To notify ISM Marketing Manager about new News record published on the website</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>News Events - Retry Sending Email</fullName>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.Error_Ids__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>News_Events__c.Retry_Sending_Email__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>retry sending email to parents/additional contacts</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>News_Events_Retry_Sending_Email</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>News Record Notification Group Designer</fullName>
        <actions>
            <name>News_Record_Published_Notification_Group_Designer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>News_Events__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>News</value>
        </criteriaItems>
        <criteriaItems>
            <field>News_Events__c.Publish_on_School_Site__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>System Administrator</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Username</field>
            <operation>notEqual</operation>
            <value>paul.collins@britishschools.co.uk</value>
        </criteriaItems>
        <description>To notify Group Designer about new News record published on the website</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Content on Translated Record On Create 1</fullName>
        <actions>
            <name>Populate_Ess_Info_Teaser_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Meta_Tag_Desc_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Meta_Tag_Title_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_1_Title_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_2_Title_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_3_Title_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_4_Title_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Fires on create to populate values in all of the fields that require translation</description>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Content on Translated Record On Create 2</fullName>
        <actions>
            <name>Populate_Video_1_URL_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_2_URL_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_3_URL_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_4_URL_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Fires on create to populate values in all of the fields that require translation</description>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Fields on Event Edit</fullName>
        <actions>
            <name>Change_Notification_Type_to_Edited</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Notification_Edited_Field_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Populates fields with the relevant values when an event is edited which falls within the next 14 days (i.e. qualifies for an automatic reminder email)</description>
        <formula>AND(     OR(        ISCHANGED(Event_Start_Date__c),         ISCHANGED(Event_End_Date__c),         ISCHANGED(Name),         ISCHANGED(Subtitle__c)        ),      OR(        Qualifies_for_Automatic_Email_Reminder__c = TRUE,         PRIORVALUE(Qualifies_for_Automatic_Email_Reminder__c) = TRUE        ),      Disable_All_Email_Notifications__c = FALSE     )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Has Error Ids</fullName>
        <actions>
            <name>Populate_Has_Error_Ids</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Translation UID</fullName>
        <actions>
            <name>Populate_Translation_UID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Notification Type to Standard for New Event</fullName>
        <actions>
            <name>Set_Notification_Type_to_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.Notification_Type__c</field>
            <operation>notEqual</operation>
            <value>Standard</value>
        </criteriaItems>
        <description>Although the field default is &apos;Standard&apos;, this rule is required to change the value of a cloned event to &apos;Standard&apos; in case it is something else on the record that is originally cloned</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Sync Chatter Group ID</fullName>
        <actions>
            <name>Sync_Chatter_Group_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Syncs the chatter group ID formula field with the chatter group ID text field</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync Content on Translated Record</fullName>
        <actions>
            <name>Populate_Ess_Info_Teaser_English_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Meta_Tag_Desc_English_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Meta_Tag_Title_English_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Title_English_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_1_Title_English_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_2_Title_English_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_3_Title_English_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_4_Title_English_N_E</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Fires on create, on edit and whenever an English Parent record is updated (by means of a process)</description>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync First Date of Term 3</fullName>
        <actions>
            <name>Sync_First_Date_of_Term_3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>A straightforward copy from a formula field to a date field to bypass the 5000 character formula limit</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync Start Date on News%2C Term%2C Notice</fullName>
        <actions>
            <name>Sync_Start_Date_with_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>News_Events__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>News,Notice,Term</value>
        </criteriaItems>
        <description>Copies the value from the &apos;Date&apos; field to the &apos;Start Date&apos; field, the latter which is used in the portal and on the website, the former only on the page layouts where a &apos;Date&apos; is required that is neither a &apos;Start Date&apos; or an &apos;End Date&apos;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Trigger Automated Notification Email %28On Create%29</fullName>
        <actions>
            <name>Send_Automated_Reminder_Email_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>News_Events__c.Qualifies_for_Automatic_Email_Reminder__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>News_Events__c.Disable_All_Email_Notifications__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>notEqual</operation>
            <value>System Administrator</value>
        </criteriaItems>
        <description>Sends an automated reminder email when an event is created which falls within the next 14 days</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Trigger Automated Notification Email %28On Edit%2C Publish or Cancel%29</fullName>
        <actions>
            <name>Send_Automated_Reminder_Email_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sends an automated reminder email when an event is edited, published or cancelled which falls or previously fell (and was already published) within the next 14 days</description>
        <formula>OR(    AND(        OR(           ISCHANGED(Event_Start_Date__c),           ISCHANGED(Event_End_Date__c), ISCHANGED(Name),            ISCHANGED(Subtitle__c)           ),         Qualifies_for_Automatic_Email_Reminder__c = TRUE,          $Profile.Name != &quot;System Administrator&quot;,        Disable_All_Email_Notifications__c != TRUE          ),    AND(        OR(           AND(               ISCHANGED(Event_Start_Date__c),                PRIORVALUE(Event_Start_Date__c) &gt;= TODAY(),               PRIORVALUE(Event_Start_Date__c)-14 &lt;= TODAY()               ),           AND(               ISCHANGED(Event_End_Date__c),               PRIORVALUE(Event_End_Date__c) &gt;= TODAY(),               PRIORVALUE(Event_End_Date__c)-14 &lt;= TODAY()               )           ),         RecordType.DeveloperName != &quot;News&quot;,        Publish_in_Portal_School_Hub__c = TRUE,        $Profile.Name != &quot;System Administrator&quot;,        TEXT(Language__c) = &quot;EN&quot;,        Disable_All_Email_Notifications__c != TRUE        ),    AND(        PRIORVALUE(Publish_in_Portal_School_Hub__c) = FALSE,        Publish_in_Portal_School_Hub__c = TRUE,         Qualifies_for_Automatic_Email_Reminder__c = TRUE,          $Profile.Name != &quot;System Administrator&quot;,        Disable_All_Email_Notifications__c != TRUE        ),    AND(        RecordType.DeveloperName != &quot;News&quot;,        ISCHANGED(Notification_Type__c),         ISPICKVAL(Notification_Type__c, &quot;Cancelled&quot;),         Is_Next_14_Day_Event__c = TRUE,         $Profile.Name != &quot;System Administrator&quot;,        TEXT(Language__c) = &quot;EN&quot;,        Disable_All_Email_Notifications__c != TRUE        )    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
