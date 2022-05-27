public class AP05_MailChimpMember {
/**************************************************************************************
-- - Author        : Spoon Consulting
-- - Description   : MailChip Member object to be used when adding email to MailCHinp using REST API
--
-- Maintenance History: 
--
-- Date         Name  Version  Remarks 
-- -----------  ----  -------  -------------------------------------------------------
-- 16-APR-2018  RRAJ    1.0     Initial version
--------------------------------------------------------------------------------------
**************************************************************************************/
    public String email_address {get; set;}
    public Merge_fields merge_fields {get; set;}
    public String status {get; set;}
    public Map<String,Boolean> interests {get; set;}
    
    /**
     * Constructor method to create ne mailchimp member
     * @param  email_address Email assress
     * @param  FNAME         First Name
     * @param  LNAME         Last Name
     * @param  status        Status (Subscribed/Unsubscribed)
     * @param  interests     interests (group) of member
     * @return               New instance of AP05_MailChimpMember
     */
    public AP05_MailChimpMember(String email_address, String FNAME, String LNAME, Map<String,Boolean> interests){
        this.email_address = email_address;
        this.merge_fields = new Merge_fields(FNAME, LNAME);
        this.status = 'subscribed';
        this.interests = interests;
    }
    
    /**
     * Inner class for merge fields of mailchimp member
     */
    public class Merge_fields {
        public String FNAME {get; set;}
        public String LNAME {get; set;}
        
        public Merge_fields(String FNAME, String LNAME){
            this.FNAME = FNAME;
            this.LNAME = LNAME;
        }
    }
}