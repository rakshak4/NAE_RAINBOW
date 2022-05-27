/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroInvoice {
    global Decimal amountCredited {
        get;
        set;
    }
    global Decimal amountDue {
        get;
        set;
    }
    global Decimal amountPaid {
        get;
        set;
    }
    global String brandingThemeID {
        get;
        set;
    }
    global sfxero.XeroContact contact {
        get;
        set;
    }
    global List<sfxero.XeroCreditNote> creditNotes {
        get;
        set;
    }
    global String currencyCode {
        get;
        set;
    }
    global Decimal currencyRate {
        get;
        set;
    }
    global Date dueDate {
        get;
        set;
    }
    global List<String> errors {
        get;
        set;
    }
    global Date expectedPaymentDate {
        get;
        set;
    }
    global Date fullyPaidOnDate {
        get;
        set;
    }
    global Boolean hasAttachments {
        get;
        set;
    }
    global String invoiceId {
        get;
        set;
    }
    global String invoiceNumber {
        get;
        set;
    }
    global sfxero.XeroInvoice.XeroInvoiceType invoiceType {
        get;
        set;
    }
    global Date issuedDate {
        get;
        set;
    }
    global sfxero.XeroInvoice.XeroLineAmountType lineAmountTypes {
        get;
        set;
    }
    global List<sfxero.XeroLineItem> lineItems {
        get;
        set;
    }
    global List<sfxero.XeroPayment> payments {
        get;
        set;
    }
    global Date plannedPaymentDate {
        get;
        set;
    }
    global String rawResponse {
        get;
        set;
    }
    global String redirectURL {
        get;
        set;
    }
    global String reference {
        get;
        set;
    }
    global Boolean sentToContact {
        get;
        set;
    }
    global sfxero.XeroInvoice.XeroInvoiceStatus status {
        get;
        set;
    }
    global String statusMessage {
        get;
        set;
    }
    global Decimal subTotal {
        get;
        set;
    }
    global Boolean success {
        get;
        set;
    }
    global Decimal total {
        get;
        set;
    }
    global Decimal totalTax {
        get;
        set;
    }
    global String updatedDateUTC {
        get;
        set;
    }
    global String url {
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
    global XeroInvoice() {

    }
    global void addLineItem(sfxero.XeroLineItem lineItem) {

    }
    global void addPayment(sfxero.XeroPayment payment) {

    }
global enum XeroInvoiceStatus {AUTHORISED, AUTHORIZED, DELETED, DRAFT, PAID, SUBMITTED, UNSPECIFIED, VOIDED}
global enum XeroInvoiceType {ACCPAY, ACCREC, UNSPECIFIED}
global enum XeroLineAmountType {Exclusive, Inclusive, NoTax, UNSPECIFIED}
}
