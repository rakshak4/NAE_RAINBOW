<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>BSKL_Email_Reminder_about_Visa_Expiration_Dependent</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Email Reminder about Visa Expiration Dependent</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice_Dependent</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_reminder_about_dependent_passport</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Email reminder about dependent passport</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_Dependent</template>
    </alerts>
    <alerts>
        <fullName>BSKL_Email_reminder_about_dependent_passport_2nd</fullName>
        <ccEmails>hr@britishschool.edu.my</ccEmails>
        <description>BSKL Email reminder about dependent passport 2nd</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_Dependent_2nd</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_Reminder_about_Visa_Expiration_Dependent</fullName>
        <ccEmails>ruslan.pryadun@britishschool.uz</ccEmails>
        <description>BST Email Reminder about Visa Expiration Dependent</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice_Dependent</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_reminder_about_dependent_passport</fullName>
        <ccEmails>ruslan.pryadun@britishschool.uz</ccEmails>
        <description>BST Email reminder about dependent passport</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_Dependent</template>
    </alerts>
    <alerts>
        <fullName>BST_Email_reminder_about_dependent_passport_2nd</fullName>
        <ccEmails>ruslan.pryadun@britishschool.uz</ccEmails>
        <description>BST Email reminder about dependent passport 2nd</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_Dependent_2nd</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_Reminder_about_Visa_Expiration_Dependent</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email Reminder about Visa Expiration Dependent</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Visa_Work_Permit_Expiration_Date_Notice_Dependent</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_reminder_about_dependent_passport</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email reminder about dependent passport</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_Dependent</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_reminder_about_dependent_passport_2nd</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email reminder about dependent passport 2nd</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Passport_Expiration_Date_Notice_Dependent_2nd</template>
    </alerts>
    <alerts>
        <fullName>ISM_Email_reminder_about_medical_book_dependent</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Email reminder about medical book dependent</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Medical_Book_Expiration_Date_Notice_Dependent</template>
    </alerts>
    <alerts>
        <fullName>ISM_Sends_email_7_days_before_Registration_Expiry_Date_Dependent</fullName>
        <ccEmails>hr@internationalschool.ru</ccEmails>
        <ccEmails>hr.assistant@internationalschool.ru</ccEmails>
        <description>ISM Sends email 7 days before Registration Expiry Date Dependent</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>All_School_Templates/HR_Registration_Date_Notice_Dependent</template>
    </alerts>
    <rules>
        <fullName>BSKL Checks Passport Expiration Date Dependent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_School_Text__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Local_Other_Nationality_Dependent__c</field>
            <operation>notEqual</operation>
            <value>Local</value>
        </criteriaItems>
        <description>Sends an email 180 days before dependent&apos;s passport expiration date + second notification 90 days before expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Email_reminder_about_dependent_passport</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Passport_Expiry_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Email_reminder_about_dependent_passport_2nd</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Passport_Expiry_Date__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BSKL Checks Visa%2FWork Permit Expiration Date Dependent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_School_Text__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Local_Other_Nationality_Dependent__c</field>
            <operation>notEqual</operation>
            <value>Local</value>
        </criteriaItems>
        <description>Sends an email 180 days before dependent&apos;s visa/work permit expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BSKL_Email_Reminder_about_Visa_Expiration_Dependent</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Visa_Expiry_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BST Checks Passport Expiration Date Dependent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_School_Text__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Local_Other_Nationality_Dependent__c</field>
            <operation>notEqual</operation>
            <value>Local</value>
        </criteriaItems>
        <description>Sends an email 180 days before dependent&apos;s passport expiration date + second notification 90 days before expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BST_Email_reminder_about_dependent_passport</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Passport_Expiry_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>BST_Email_reminder_about_dependent_passport_2nd</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Passport_Expiry_Date__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BST Checks Visa%2FWork Permit Expiration Date Dependent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_School_Text__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Local_Other_Nationality_Dependent__c</field>
            <operation>notEqual</operation>
            <value>Local</value>
        </criteriaItems>
        <description>Sends an email 180 days before dependent&apos;s visa/work permit expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>BST_Email_Reminder_about_Visa_Expiration_Dependent</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Visa_Expiry_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ISM Checks Medical record date Dependent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_School_Text__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <description>Sends an email 60 days before dependent&apos;s medical book expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_reminder_about_medical_book_dependent</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Medical_Book_Expiry_Date__c</offsetFromField>
            <timeLength>-60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ISM Checks Passport Expiration Date Dependent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_School_Text__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Local_Other_Nationality_Dependent__c</field>
            <operation>notEqual</operation>
            <value>Local</value>
        </criteriaItems>
        <description>Sends an email 180 days before dependent&apos;s passport expiration date + second notification 90 days before expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_reminder_about_dependent_passport</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Passport_Expiry_Date__c</offsetFromField>
            <timeLength>-180</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_reminder_about_dependent_passport_2nd</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Passport_Expiry_Date__c</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ISM Checks Registration Expiration Date Dependent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_School_Text__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Local_Other_Nationality_Dependent__c</field>
            <operation>notEqual</operation>
            <value>Local</value>
        </criteriaItems>
        <description>Sends an email 7 days before a registration expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Sends_email_7_days_before_Registration_Expiry_Date_Dependent</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Registration_Expiry_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ISM Checks Visa%2FWork Permit Expiration Date Dependent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_School_Text__c</field>
            <operation>equals</operation>
            <value>The International School of Moscow</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Staff_Member_Status__c</field>
            <operation>equals</operation>
            <value>Employed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Dependent__c.Local_Other_Nationality_Dependent__c</field>
            <operation>notEqual</operation>
            <value>Local</value>
        </criteriaItems>
        <description>Sends an email 180 days before dependent&apos;s visa/work permit expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ISM_Email_Reminder_about_Visa_Expiration_Dependent</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Dependent__c.Visa_Expiry_Date__c</offsetFromField>
            <timeLength>-80</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
