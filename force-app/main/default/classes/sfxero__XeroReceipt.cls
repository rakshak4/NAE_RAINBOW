/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroReceipt {
    global sfxero.XeroContact contact {
        get;
        set;
    }
    global Boolean hasAttachments {
        get;
        set;
    }
    global sfxero.XeroReceipt.LineAmountType lineAmountType {
        get;
        set;
    }
    global List<sfxero.XeroLineItem> lineItems {
        get;
        set;
    }
    global Date receiptDate {
        get;
        set;
    }
    global String receiptId {
        get;
        set;
    }
    global String receiptNumber {
        get;
        set;
    }
    global String reference {
        get;
        set;
    }
    global sfxero.XeroReceipt.StatusCode status {
        get;
        set;
    }
    global Decimal subTotal {
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
    global Date updatedDateUTC {
        get;
        set;
    }
    global String url {
        get;
        set;
    }
    global sfxero.XeroUser user {
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
    global XeroReceipt() {

    }
    global void addLineItem(sfxero.XeroLineItem item) {

    }
global enum LineAmountType {Exclusive, Inclusive, NoTax}
global enum StatusCode {AUTHORISED, DELETED, DRAFT, PAID, SUBMITTED, VOIDED}
}
