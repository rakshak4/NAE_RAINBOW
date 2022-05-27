/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroCreditNote {
    global List<sfxero.XeroAllocation> allocations {
        get;
        set;
    }
    global Decimal appliedAmount {
        get;
        set;
    }
    global String brandingThemeId {
        get;
        set;
    }
    global sfxero.XeroContact contact {
        get;
        set;
    }
    global Date created {
        get;
        set;
    }
    global String creditNoteID {
        get;
        set;
    }
    global String creditNoteNumber {
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
    global Date fullyPaidOnDate {
        get;
        set;
    }
    global Boolean hasAttachments {
        get;
        set;
    }
    global Date issuedDate {
        get;
        set;
    }
    global sfxero.XeroCreditNote.LineAmountType lineAmountType {
        get;
        set;
    }
    global List<sfxero.XeroLineItem> lineItems {
        get;
        set;
    }
    global sfxero.XeroCreditNote.NoteType noteType {
        get;
        set;
    }
    global String reference {
        get;
        set;
    }
    global Decimal remainingCredit {
        get;
        set;
    }
    global Boolean sentToContact {
        get;
        set;
    }
    global sfxero.XeroCreditNote.StatusCode statusCode {
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
    global List<String> validationErrors {
        get;
        set;
    }
    global List<String> warnings {
        get;
        set;
    }
    global XeroCreditNote() {

    }
global enum LineAmountType {Exclusive, Inclusive, NoTax}
global enum NoteType {ACCPAYCREDIT, ACCRECCREDIT}
global enum StatusCode {AUTHORISED, DELETED, DRAFT, PAID, SUBMITTED, VOIDED}
}
