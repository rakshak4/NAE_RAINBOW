/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroPayment {
    global sfxero.XeroAccount acc {
        get;
        set;
    }
    global String accountCode {
        get;
        set;
    }
    global String accountId {
        get;
        set;
    }
    global Decimal amount {
        get;
        set;
    }
    global sfxero.XeroCreditNote creditnote {
        get;
        set;
    }
    global Decimal currencyRate {
        get;
        set;
    }
    global List<String> errors {
        get;
        set;
    }
    global sfxero.XeroInvoice inv {
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
    global Boolean isReconciled {
        get;
        set;
    }
    global Date paymentDate {
        get;
        set;
    }
    global String paymentId {
        get;
        set;
    }
    global String paymentType {
        get;
        set;
    }
    global sfxero.XeroPayment.PaymentType paymentTypeAsEnum {
        get;
        set;
    }
    global static Map<String,sfxero.XeroPayment.PaymentType> paymentTypeMap;
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
    global String status {
        get;
        set;
    }
    global sfxero.XeroInvoice.XeroInvoiceStatus statusAsEnum {
        get;
        set;
    }
    global String statusMessage {
        get;
        set;
    }
    global Boolean success {
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
    global XeroPayment() {

    }
global enum PaymentType {ACCPAYPAYMENT, ACCRECPAYMENT}
}
