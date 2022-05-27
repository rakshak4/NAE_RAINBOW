<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Request_New_Translation</fullName>
        <description>Request New Translation</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Translator_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Translation_Request_Email</template>
    </alerts>
    <alerts>
        <fullName>Request_Updated_Translation</fullName>
        <description>Request Updated Translation</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Translator_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Translation_Update_Request_Email</template>
    </alerts>
    <alerts>
        <fullName>Translation_Complete_Notification</fullName>
        <description>Translation Complete Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Translation_Requestor_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>System_Messages/Translation_Complete_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Auto_Generate_Sidebar_Block_Title</fullName>
        <field>Name</field>
        <formula>IF(RecordType.DeveloperName = &quot;Standard_Sidebar_Block&quot;, 

TEXT(Sidebar_Block_Type__c) &amp; &quot; in &quot; &amp;  Related_to_Web_Content__r.Name, 

IF(RecordType.DeveloperName = &quot;Standalone_Sidebar_Block&quot;, 

TEXT(Sidebar_Block_Type__c) &amp; &quot; in &quot; &amp; 

IF(INCLUDES(Apply_to__c, &quot;Events&quot;), &quot;Events; &quot;, &quot;&quot;) &amp;
IF(INCLUDES(Apply_to__c, &quot;Staff Bios&quot;), &quot;S/Dir; &quot;, &quot;&quot;) &amp;
IF(INCLUDES(Apply_to__c, &quot;Job Postings&quot;), &quot;J/Posts; &quot;, &quot;&quot;) &amp;
IF(INCLUDES(Apply_to__c, &quot;Parent Testimonials&quot;), &quot;P/Testimonials; &quot;, &quot;&quot;) &amp;
IF(INCLUDES(Apply_to__c, &quot;Staff Testimonials&quot;), &quot;S/Testimonials; &quot;, &quot;&quot;) &amp;
IF(INCLUDES(Apply_to__c, &quot;News&quot;), &quot;News; &quot;, &quot;&quot;),

 &quot;&quot;))</formula>
        <name>Auto-Generate Sidebar Block Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_AB_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Announcement_Bar_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to AB Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_ANC_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Additional_Navigable_Content_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to ANC Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_G_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Groupable_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to G Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_HPPC_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Home_Page_Picture_Carousel_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to HPPC Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_MI_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Menu_Image_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to MI Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_NWC_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Normal_Web_Content_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to NWC Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_SP_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>School_Profile_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to SP Translation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Record_Type_to_WB_Translation</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Web_Block_Translation</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change Record Type to WB Translation</name>
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
        <fullName>Copy_SLC_to_SLCT</fullName>
        <field>Schools_List_Copy_Text__c</field>
        <formula>Schools_List_Copy__c</formula>
        <name>Copy SLC to SLCT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Web_Content_Id</fullName>
        <field>WebContentIdText__c</field>
        <formula>Id</formula>
        <name>Copy Web Content Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Generate_Announcement_Preview</fullName>
        <field>Announcement_Preview__c</field>
        <formula>IF(
   AND(
        RecordType.DeveloperName = &quot;Announcement_Bar_Translation&quot;,
       OR(
          CONTAINS(Name, &quot;TRANSLATION REQUIRED&quot;),
          CONTAINS(Main_Text__c, &quot;TRANSLATION REQUIRED&quot;)
          )
       ),
   &quot;* The preview will generate when the translation is complete *&quot;,
   UPPER(Name) &amp; &quot;: &quot;&amp; Main_Text__c
   )</formula>
        <name>Generate Announcement Preview</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notify_me_Trans_Complete_to_FALSE</fullName>
        <field>Notify_Me_When_Translation_is_Complete__c</field>
        <literalValue>0</literalValue>
        <name>Notify me Trans. Complete to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Assigned_Trans_for_S_Rule_WC</fullName>
        <field>Assigned_Translator_for_Sharing_Rule__c</field>
        <formula>IF(
   TEXT(Assigned_Translator__c) = &quot;&quot;, 
   &quot;&quot;,
   SUBSTITUTE(MID(TEXT(Assigned_Translator__c), FIND(&quot;(&quot;, TEXT(Assigned_Translator__c))+1, 20), &quot;)&quot;, &quot;&quot;)
   )</formula>
        <name>Populate Assigned Trans. for S.Rule (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Assigned_Translator_Email</fullName>
        <field>Assigned_Translator_Email__c</field>
        <formula>IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Spanish 1&quot;), &quot;laura.gonzalez@bsn.org.es&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Spanish 2&quot;), &quot;emma.watkins@bsm.org.es&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Spanish 3&quot;), &quot;alexandra.mostaza@britishschools.co.uk&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Spanish 4&quot;), &quot;sonia.fernandez@bsm.org.es&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Spanish 5&quot;), &quot;ben6@britishschools.co.uk&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Portuguese 1&quot;), &quot;tania.ramos@britishcollegebrazil.org&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Portuguese 2&quot;), &quot;ben.hails@britishschools.co.uk&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Portuguese 3&quot;), &quot;ben.hails@britishschools.co.uk&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Russian 1&quot;), &quot;elena.savtsova@britishschool.uz&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Russian 2&quot;), &quot;adminassistant@britishschool.uz&quot;,
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Russian 3&quot;), &quot;oksana.zueva@britishschool.uz&quot;, 
IF(CONTAINS(TEXT(Assigned_Translator__c), &quot;Test Translator&quot;), &quot;ben.hails@britishschools.co.uk&quot;, 
&quot;ben.hails@britishschools.co.uk&quot;))))))))))))</formula>
        <name>Populate Assigned Translator Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_1_Title_English</fullName>
        <field>Booklet_1_Title_English__c</field>
        <formula>English_Parent__r.Issuu_1_Title__c</formula>
        <name>Populate Booklet 1 Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_1_Title_WC</fullName>
        <field>Issuu_1_Title__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Issuu_1_Title__c != &quot;&quot;,
       Issuu_1_Title__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Update the link if not Eng.&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Booklet 1 Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_1_URL_WC</fullName>
        <field>Issuu_1_Script__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Issuu_1_Script__c != &quot;&quot;,
       Issuu_1_Script__c = &quot;&quot;
       ),
   English_Parent__r.Issuu_1_Script__c,
   &quot;&quot;
   )</formula>
        <name>Populate Booklet 1 URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_2_Title_English</fullName>
        <field>Booklet_2_Title_English__c</field>
        <formula>English_Parent__r.Issuu_2_Title__c</formula>
        <name>Populate Booklet 2 Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_2_Title_WC</fullName>
        <field>Issuu_2_Title__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Issuu_2_Title__c != &quot;&quot;,
       Issuu_2_Title__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Update the link if not Eng.&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Booklet 2 Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_2_URL_WC</fullName>
        <field>Issuu_2_Script__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Issuu_2_Script__c != &quot;&quot;,
       Issuu_2_Script__c = &quot;&quot;
       ),
   English_Parent__r.Issuu_2_Script__c,
   &quot;&quot;
   )</formula>
        <name>Populate Booklet 2 URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_3_Title_English</fullName>
        <field>Booklet_3_Title_English__c</field>
        <formula>English_Parent__r.Issuu_3_Title__c</formula>
        <name>Populate Booklet 3 Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_3_Title_WC</fullName>
        <field>Issuu_3_Title__c</field>
        <formula>IF( 
   AND( 
       English_Parent__r.Issuu_3_Title__c != &quot;&quot;, 
       Issuu_3_Title__c = &quot;&quot; 
       ), 
   &quot;TRANSLATION REQUIRED - Update the link if not Eng.&quot;, 
   &quot;&quot; 
   )</formula>
        <name>Populate Booklet 3 Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_3_URL_WC</fullName>
        <field>Issuu_3_Script__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Issuu_3_Script__c != &quot;&quot;,
       Issuu_3_Script__c = &quot;&quot;
       ),
   English_Parent__r.Issuu_3_Script__c,
   &quot;&quot;
   )</formula>
        <name>Populate Booklet 3 URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_4_Title_English</fullName>
        <field>Booklet_4_Title_English__c</field>
        <formula>English_Parent__r.Issuu_4_Title__c</formula>
        <name>Populate Booklet 4 Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_4_Title_WC</fullName>
        <field>Issuu_4_Title__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Issuu_4_Title__c != &quot;&quot;,
       Issuu_4_Title__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Update the link if not Eng.&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Booklet 4 Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Booklet_4_URL_WC</fullName>
        <field>Issuu_4_Script__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Issuu_4_Script__c != &quot;&quot;,
       Issuu_4_Script__c = &quot;&quot;
       ),
   English_Parent__r.Issuu_4_Script__c,
   &quot;&quot;
   )</formula>
        <name>Populate Booklet 4 URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Default_Menu_Image_Title</fullName>
        <field>Name</field>
        <formula>Parent_Item__r.Name &amp; &quot; Menu Image&quot;</formula>
        <name>Populate Default Menu Image Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Default_Menu_Image_Trans_Title</fullName>
        <field>Name</field>
        <formula>TEXT(Language__c) &amp; &quot; &quot;&amp; English_Parent__r.Parent_Item__r.Name &amp; &quot; Menu Image&quot;</formula>
        <name>Populate Default Menu Image Trans Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Fact_1_English</fullName>
        <field>Fact_1_English__c</field>
        <formula>English_Parent__r.Fact_1__c</formula>
        <name>Populate Fact 1 (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Fact_1_SP</fullName>
        <field>Fact_1__c</field>
        <formula>IF( 
AND( 
English_Parent__r.Fact_1__c != &quot;&quot;, 
Fact_1__c = &quot;&quot; 
), 
&quot;!TR!&quot;, 
&quot;&quot; 
)</formula>
        <name>Populate Fact 1 (SP)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Fact_1_Suffix_English</fullName>
        <field>Fact_1_Suffix_English__c</field>
        <formula>English_Parent__r.Fact_1_Suffix__c</formula>
        <name>Populate Fact 1 Suffix (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Fact_1_Suffix_SP</fullName>
        <field>Fact_1_Suffix__c</field>
        <formula>IF( 
AND( 
English_Parent__r.Fact_1_Suffix__c != &quot;&quot;, 
Fact_1_Suffix__c = &quot;&quot; 
), 
&quot;TRANSLATION REQUIRED&quot;, 
&quot;&quot; 
)</formula>
        <name>Populate Fact 1 Suffix (SP)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Fact_2_English</fullName>
        <field>Fact_2_English__c</field>
        <formula>English_Parent__r.Fact_2__c</formula>
        <name>Populate Fact 2 (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Fact_2_SP</fullName>
        <field>Fact_2__c</field>
        <formula>IF( 
AND( 
English_Parent__r.Fact_2__c != &quot;&quot;, 
Fact_2__c = &quot;&quot; 
), 
&quot;!TR!&quot;, 
&quot;&quot; 
)</formula>
        <name>Populate Fact 2 (SP)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Fact_2_Suffix_English</fullName>
        <field>Fact_2_Suffix_English__c</field>
        <formula>English_Parent__r.Fact_2_Suffix__c</formula>
        <name>Populate Fact 2 Suffix (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Fact_2_Suffix_SP</fullName>
        <field>Fact_2_Suffix__c</field>
        <formula>IF( 
AND( 
English_Parent__r.Fact_2_Suffix__c != &quot;&quot;, 
Fact_2_Suffix__c = &quot;&quot; 
), 
&quot;TRANSLATION REQUIRED&quot;, 
&quot;&quot; 
)</formula>
        <name>Populate Fact 2 Suffix (SP)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Google_Map_URL_WC</fullName>
        <field>Google_Map__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Google_Map__c != &quot;&quot;,
       Google_Map__c = &quot;&quot;
       ),
   English_Parent__r.Google_Map__c,
   &quot;&quot;
   )</formula>
        <name>Populate Google Map URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Google_Maps_URL_WC</fullName>
        <field>Google_Maps__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Google_Maps__c != &quot;&quot;,
       Google_Maps__c = &quot;&quot;
       ),
   English_Parent__r.Google_Maps__c,
   &quot;&quot;
   )</formula>
        <name>Populate Google Maps URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Issuu_Embed_Field_WC</fullName>
        <field>Issuu_Embed_Field__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Issuu_Embed_Field__c != &quot;&quot;,
       Issuu_Embed_Field__c = &quot;&quot;
       ),
   English_Parent__r.Issuu_Embed_Field__c,
   &quot;&quot;
   )</formula>
        <name>Populate Issuu Embed Field (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Link_Title_English</fullName>
        <field>Internal_Link_Title_English__c</field>
        <formula>English_Parent__r.Internal_Link_Title__c</formula>
        <name>Populate Link Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Link_Title_WC</fullName>
        <field>Internal_Link_Title__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Internal_Link_Title__c != &quot;&quot;,
       Internal_Link_Title__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Link Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Main_Text_SP</fullName>
        <field>Main_Text__c</field>
        <formula>IF( 
English_Parent__r.Main_Text__c != &quot;&quot;, 
English_Parent__r.Main_Text__c , 
&quot;&quot; 
)</formula>
        <name>Populate Main Text (SP)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Menu_Title_English</fullName>
        <field>Menu_Title_English__c</field>
        <formula>English_Parent__r.Name</formula>
        <name>Populate Menu Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Meta_Tag_Description_English</fullName>
        <field>Meta_Tag_Description_English__c</field>
        <formula>English_Parent__r.Meta_Tag_Description__c</formula>
        <name>Populate Meta Tag Description (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Meta_Tag_Description_WC</fullName>
        <field>Meta_Tag_Description__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Meta_Tag_Description__c != &quot;&quot;,
       Meta_Tag_Description__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Meta Tag Description (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Meta_Tag_Title_English</fullName>
        <field>Meta_Tag_Title_English__c</field>
        <formula>English_Parent__r.Meta_Tag_Title__c</formula>
        <name>Populate Meta Tag Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Meta_Tag_Title_WC</fullName>
        <field>Meta_Tag_Title__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Meta_Tag_Title__c != &quot;&quot;,
       Meta_Tag_Title__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Meta Tag Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Preview_Text_English</fullName>
        <field>Groupable_Preview_Text_English__c</field>
        <formula>English_Parent__r.Groupable_Preview_Text__c</formula>
        <name>Populate Preview Text (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Preview_Text_WC</fullName>
        <field>Groupable_Preview_Text__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Groupable_Preview_Text__c != &quot;&quot;,
       Groupable_Preview_Text__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Preview Text (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Recruitment_Intro_English</fullName>
        <field>Recruitment_Intro_English__c</field>
        <formula>English_Parent__r.Recruitment_Intro__c</formula>
        <name>Populate Recruitment Intro (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Recruitment_Intro_SP</fullName>
        <field>Recruitment_Intro__c</field>
        <formula>IF( 
AND( 
English_Parent__r.Recruitment_Intro__c != &quot;&quot;, 
Recruitment_Intro__c = &quot;&quot; 
), 
&quot;TRANSLATION REQUIRED&quot;, 
&quot;&quot; 
)</formula>
        <name>Populate Recruitment Intro (SP)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Subtitle_English</fullName>
        <field>Subtitle_English__c</field>
        <formula>English_Parent__r.Content_Subtitle__c</formula>
        <name>Populate Subtitle (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Subtitle_WC</fullName>
        <field>Content_Subtitle__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Content_Subtitle__c != &quot;&quot;,
       Content_Subtitle__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Subtitle (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Translation_Requestor_Email</fullName>
        <field>Translation_Requestor_Email__c</field>
        <formula>$User.Email</formula>
        <name>Populate Translation Requestor Email</name>
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
        <fullName>Populate_Video_1_Title_English</fullName>
        <field>Video_1_Title_English__c</field>
        <formula>English_Parent__r.Video_1_TITLE__c</formula>
        <name>Populate Video 1 Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_1_Title_WC</fullName>
        <field>Video_1_TITLE__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_1_TITLE__c != &quot;&quot;,
       Video_1_TITLE__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Update the link if not Eng.&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Video 1 Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_1_URL_WC</fullName>
        <field>Video_1_URL__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_1_URL__c != &quot;&quot;,
       Video_1_URL__c = &quot;&quot;
       ),
   English_Parent__r.Video_1_URL__c,
   &quot;&quot;
   )</formula>
        <name>Populate Video 1 URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_2_Title_English</fullName>
        <field>Video_2_Title_English__c</field>
        <formula>English_Parent__r.Video_2_TITLE__c</formula>
        <name>Populate Video 2 Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_2_Title_WC</fullName>
        <field>Video_2_TITLE__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_2_TITLE__c != &quot;&quot;,
       Video_2_TITLE__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Update the link if not Eng.&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Video 2 Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_2_URL_WC</fullName>
        <field>Video_2_URL__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_2_URL__c != &quot;&quot;,
       Video_2_URL__c = &quot;&quot;
       ),
   English_Parent__r.Video_2_URL__c,
   &quot;&quot;
   )</formula>
        <name>Populate Video 2 URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_3_Title_English</fullName>
        <field>Video_3_Title_English__c</field>
        <formula>English_Parent__r.Video_3_TITLE__c</formula>
        <name>Populate Video 3 Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_3_Title_WC</fullName>
        <field>Video_3_TITLE__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_3_TITLE__c != &quot;&quot;,
       Video_3_TITLE__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Update the link if not Eng.&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Video 3 Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_3_URL_WC</fullName>
        <field>Video_3_URL__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_3_URL__c != &quot;&quot;,
       Video_3_URL__c = &quot;&quot;
       ),
   English_Parent__r.Video_3_URL__c,
   &quot;&quot;
   )</formula>
        <name>Populate Video 3 URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_4_Title_English</fullName>
        <field>Video_4_Title_English__c</field>
        <formula>English_Parent__r.Video_4_TITLE__c</formula>
        <name>Populate Video 4 Title (English)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_4_Title_WC</fullName>
        <field>Video_4_TITLE__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_4_TITLE__c != &quot;&quot;,
       Video_4_TITLE__c = &quot;&quot;
       ),
   &quot;TRANSLATION REQUIRED - Update the link if not Eng.&quot;,
   &quot;&quot;
   )</formula>
        <name>Populate Video 4 Title (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Video_4_URL_WC</fullName>
        <field>Video_4_URL__c</field>
        <formula>IF(
   AND(
       English_Parent__r.Video_4_URL__c != &quot;&quot;,
       Video_4_URL__c = &quot;&quot;
       ),
   English_Parent__r.Video_4_URL__c,
   &quot;&quot;
   )</formula>
        <name>Populate Video 4 URL (WC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Publish_on_School_Site_to_TRUE</fullName>
        <field>Publish_on_School_Site__c</field>
        <literalValue>1</literalValue>
        <name>Publish on School Site to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Send_Update_Request_Email_to_FALSE</fullName>
        <field>Send_Update_Request_Email__c</field>
        <literalValue>0</literalValue>
        <name>Send Update Request Email to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Assigned_Translator_to_BLANK</fullName>
        <field>Assigned_Translator__c</field>
        <name>Set Assigned Translator to BLANK</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Translation_Status_to_Requested</fullName>
        <field>Translation_Status__c</field>
        <formula>&quot;Requested&quot;</formula>
        <name>Set Translation Status to Requested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Translation_Complete_to_FALSE</fullName>
        <field>Translation_Complete__c</field>
        <literalValue>0</literalValue>
        <name>Translation Complete to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Translation_Status_to_COMPLETE</fullName>
        <field>Translation_Status__c</field>
        <formula>&quot;Complete&quot;</formula>
        <name>Translation Status to COMPLETE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Request_Description_to_BLANK</fullName>
        <field>Update_Request_Description__c</field>
        <name>Update Request Description to BLANK</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Change Record Type to AB Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_AB_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     RecordType.DeveloperName = &quot;Translation_Request&quot;,     English_Parent__r.RecordType.DeveloperName = &quot;Announcement_Bar&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to ANC Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_ANC_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     RecordType.DeveloperName = &quot;Translation_Request&quot;,     English_Parent__r.RecordType.DeveloperName = &quot;Additional_Navigable_Content&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to G Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_G_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     RecordType.DeveloperName = &quot;Translation_Request&quot;,     English_Parent__r.RecordType.DeveloperName = &quot;Groupable&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to HPPC Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_HPPC_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     RecordType.DeveloperName = &quot;Translation_Request_Web_Block_With_Links&quot;,     English_Parent__r.RecordType.DeveloperName = &quot;Home_Page_Picture_Carrousel&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to MI Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_MI_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Default_Menu_Image_Trans_Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        RecordType.DeveloperName = &quot;Translation_Request&quot;,        RecordType.DeveloperName = &quot;Translation_Request_Web_Block_With_Links&quot;        ),     English_Parent__r.RecordType.DeveloperName = &quot;Menu_Image&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to NWC Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_NWC_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Translation_Status_to_Requested</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     RecordType.DeveloperName = &quot;Translation_Request&quot;,     English_Parent__r.RecordType.DeveloperName = &quot;Normal_Web_Content&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to SP Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_SP_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     RecordType.DeveloperName = &quot;Translation_Request&quot;,     English_Parent__r.RecordType.DeveloperName = &quot;School&quot;     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to WB Translation</fullName>
        <actions>
            <name>Change_Record_Type_to_WB_Translation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(     OR(        RecordType.DeveloperName = &quot;Translation_Request&quot;,        RecordType.DeveloperName = &quot;Translation_Request_Web_Block_With_Links&quot;        ),     English_Parent__r.RecordType.DeveloperName = &quot;Web_Block&quot;     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Copy Id</fullName>
        <actions>
            <name>Copy_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy SLC to SLCT</fullName>
        <actions>
            <name>Copy_SLC_to_SLCT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Schools_List_Copy__c != Schools_List_Copy_Text__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Web Content Id</fullName>
        <actions>
            <name>Copy_Web_Content_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.Order__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>School website rule</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Announcement Preview</fullName>
        <actions>
            <name>Generate_Announcement_Preview</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(    RecordType.DeveloperName = &quot;Announcement_Bar&quot;,    RecordType.DeveloperName = &quot;Announcement_Bar_Translation&quot;    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Sidebar Block Title</fullName>
        <actions>
            <name>Auto_Generate_Sidebar_Block_Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Standalone Sidebar Block,Standard Sidebar Block</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Assigned Translator Email</fullName>
        <actions>
            <name>Populate_Assigned_Translator_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.Assigned_Translator__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Assigned Translator for Sharing Rule</fullName>
        <actions>
            <name>Populate_Assigned_Trans_for_S_Rule_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Content on Translated Record On Create 1</fullName>
        <actions>
            <name>Populate_Google_Map_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Google_Maps_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Issuu_Embed_Field_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Link_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Meta_Tag_Description_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Meta_Tag_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Preview_Text_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Subtitle_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Content on Translated Record On Create 2</fullName>
        <actions>
            <name>Populate_Booklet_1_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_1_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_2_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_2_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_3_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_3_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_4_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_4_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Content on Translated Record On Create 3</fullName>
        <actions>
            <name>Populate_Video_1_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_1_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_2_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_2_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_3_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_3_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_4_Title_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_4_URL_WC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Content on Translated Record On Create 4</fullName>
        <actions>
            <name>Populate_Fact_1_SP</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Fact_1_Suffix_SP</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Fact_2_SP</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Fact_2_Suffix_SP</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Main_Text_SP</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Recruitment_Intro_SP</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>RecordTypeId = &quot;0126F000001hW0u&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Default Menu Image Title</fullName>
        <actions>
            <name>Populate_Default_Menu_Image_Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>RecordType.DeveloperName = &quot;Menu_Image&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Populate Translation Requestor Email</fullName>
        <actions>
            <name>Populate_Translation_Requestor_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.Notify_Me_When_Translation_is_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
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
        <fullName>Request New Translation</fullName>
        <actions>
            <name>Request_New_Translation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Translation Request Default,Translation Request Web Block With Links</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Request Updated Translation</fullName>
        <actions>
            <name>Request_Updated_Translation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.Send_Update_Request_Email__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Sync Content on SP Translated Record</fullName>
        <actions>
            <name>Populate_Fact_1_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Fact_1_Suffix_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Fact_2_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Fact_2_Suffix_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Recruitment_Intro_English</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync Content on Translated Record 1</fullName>
        <actions>
            <name>Populate_Booklet_1_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_2_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_3_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Booklet_4_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Link_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Menu_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Meta_Tag_Description_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Meta_Tag_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Preview_Text_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Subtitle_English</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Fires on create, on edit and whenever an English Parent record is updated (by means of a process)</description>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sync Content on Translated Record 2</fullName>
        <actions>
            <name>Populate_Video_1_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_2_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_3_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Video_4_Title_English</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Fires on create, on edit and whenever an English Parent record is updated (by means of a process)</description>
        <formula>CONTAINS(RecordType.DeveloperName, &quot;Translation&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Translation Complete Process %28Immediate 1%29</fullName>
        <actions>
            <name>Send_Update_Request_Email_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Assigned_Translator_to_BLANK</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Translation_Complete_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Translation_Status_to_COMPLETE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Request_Description_to_BLANK</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Web_Content__c.Translation_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Translation Complete Process %28Immediate 2%29</fullName>
        <actions>
            <name>Translation_Complete_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Notify_me_Trans_Complete_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Web_Content__c.Translation_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Web_Content__c.Notify_Me_When_Translation_is_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Translation Complete Process %28Immediate 3%29</fullName>
        <actions>
            <name>Publish_on_School_Site_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Translation_Complete__c = TRUE &amp;&amp;  English_Parent__r.Publish_on_School_Site__c = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
