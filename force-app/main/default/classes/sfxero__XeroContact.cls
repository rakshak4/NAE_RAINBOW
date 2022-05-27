/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroContact {
    global sfxero.XeroContact.XeroBalance accountsPayable {
        get;
        set;
    }
    global sfxero.XeroContact.XeroBalance accountsReceivable {
        get;
        set;
    }
    global String acctsPayableTaxType {
        get;
        set;
    }
    global String acctsReceivableTaxType {
        get;
        set;
    }
    global List<sfxero.XeroContact.XeroAddress> addresses {
        get;
        set;
    }
    global String bankAccountNum {
        get;
        set;
    }
    global sfxero.XeroContact.XeroBatchPayment batchPayments {
        get;
        set;
    }
    global String brandingTheme {
        get;
        set;
    }
    global String contactGroups {
        get;
        set;
    }
    global String contactID {
        get;
        set;
    }
    global String contactNumber {
        get;
        set;
    }
    global List<sfxero.XeroContact.XeroContactPerson> contactPersons {
        get;
        set;
    }
    global String contactStatus {
        get;
        set;
    }
    global static Map<String,sfxero.XeroContact.ContactStatus> contactStatusMap;
    global sfxero.XeroContact.ContactStatus contactStatusType {
        get;
        set;
    }
    global String defaultCurrency {
        get;
        set;
    }
    global Decimal discount {
        get;
        set;
    }
    global String emailAddress {
        get;
        set;
    }
    global String firstName {
        get;
        set;
    }
    global Boolean hasAttachments {
        get;
        set;
    }
    global Boolean isCustomer {
        get;
        set;
    }
    global Boolean isSupplier {
        get;
        set;
    }
    global String lastName {
        get;
        set;
    }
    global String orgName {
        get;
        set;
    }
    global sfxero.XeroContact.XeroPaymentTerms paymentTermsBills {
        get;
        set;
    }
    global static Map<String,sfxero.XeroContact.PaymentTermsType> paymentTermsMap;
    global sfxero.XeroContact.XeroPaymentTerms paymentTermsSales {
        get;
        set;
    }
    global List<sfxero.XeroContact.XeroPhone> phones {
        get;
        set;
    }
    global String skypeUserName {
        get;
        set;
    }
    global String taxNumber {
        get;
        set;
    }
    global Datetime updatedDateTimeUTC {
        get;
        set;
    }
    global String updatedDateUTC {
        get;
        set;
    }
    global List<String> validationErrors {
        get;
        set;
    }
    global List<String> warnings {
        get;
        set;
    }
    global String website {
        get;
        set;
    }
    global String xeroNetworkKey {
        get;
        set;
    }
    global XeroContact() {

    }
    global void addAddress(sfxero.XeroContact.XeroAddress address) {

    }
    global void addPhone(sfxero.XeroContact.XeroPhone phone) {

    }
global enum ContactStatus {ACTIVE, ARCHIVED}
global enum PaymentTermsType {DAYSAFTERBILLDATE, DAYSAFTERBILLMONTH, OFCURRENTMONTH, OFFOLLOWINGMONTH}
global class XeroAddress {
    global String addressLine1 {
        get;
        set;
    }
    global String addressLine2 {
        get;
        set;
    }
    global String addressLine3 {
        get;
        set;
    }
    global String addressLine4 {
        get;
        set;
    }
    global sfxero.XeroContact.XeroAddressType addressType {
        get;
        set;
    }
    global String attentionTo {
        get;
        set;
    }
    global String city {
        get;
        set;
    }
    global String country {
        get;
        set;
    }
    global String postalCode {
        get;
        set;
    }
    global String region {
        get;
        set;
    }
    global List<String> validationErrors {
        get;
        set;
    }
    global List<String> warnings {
        get;
        set;
    }
    global XeroAddress() {

    }
}
global enum XeroAddressType {POBOX, STREET}
global class XeroBalance {
    global Decimal outstanding {
        get;
        set;
    }
    global Decimal overdue {
        get;
        set;
    }
    global XeroBalance() {

    }
}
global class XeroBatchPayment {
    global String bankAccountName {
        get;
        set;
    }
    global String bankAccountNum {
        get;
        set;
    }
    global String details {
        get;
        set;
    }
    global XeroBatchPayment() {

    }
}
global class XeroContactPerson {
    global String emailAddress {
        get;
        set;
    }
    global String firstName {
        get;
        set;
    }
    global Boolean includeInEmails {
        get;
        set;
    }
    global String lastName {
        get;
        set;
    }
    global XeroContactPerson() {

    }
}
global class XeroPaymentTerms {
    global Integer day {
        get;
        set;
    }
    global sfxero.XeroContact.PaymentTermsType type {
        get;
        set;
    }
    global XeroPaymentTerms() {

    }
    global XeroPaymentTerms(sfxero.XeroContact.PaymentTermsType type, Integer day) {

    }
}
global class XeroPhone {
    global String areaCode {
        get;
        set;
    }
    global String countryCode {
        get;
        set;
    }
    global String phoneNumber {
        get;
        set;
    }
    global sfxero.XeroContact.XeroPhoneType phoneType {
        get;
        set;
    }
    global List<String> validationErrors {
        get;
        set;
    }
    global List<String> warnings {
        get;
        set;
    }
    global XeroPhone() {

    }
}
global enum XeroPhoneType {DDI, DEFAULTPHONE, FAX, MOBILE}
}
