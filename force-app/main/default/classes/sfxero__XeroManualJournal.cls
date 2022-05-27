/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroManualJournal {
    global Boolean hasAttachments {
        get;
        set;
    }
    global Date journalDate {
        get;
        set;
    }
    global List<sfxero.XeroManualJournal.XeroManualJournalLine> journalLines {
        get;
        set;
    }
    global String lineAmountType {
        get;
        set;
    }
    global String manualJournalId {
        get;
        set;
    }
    global String narration {
        get;
        set;
    }
    global Boolean showOnCashBasisReports {
        get;
        set;
    }
    global String status {
        get;
        set;
    }
    global sfxero.XeroManualJournal.StatusCode statusCode {
        get;
        set;
    }
    global static Map<String,sfxero.XeroManualJournal.StatusCode> statusCodeMap;
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
    global XeroManualJournal() {

    }
global enum StatusCode {DELETED, DRAFT, POSTED, VOIDED}
global class XeroManualJournalLine {
    global String accountCode {
        get;
        set;
    }
    global String description {
        get;
        set;
    }
    global Decimal lineAmmount {
        get;
        set;
    }
    global Decimal lineAmount {
        get;
        set;
    }
    global Decimal taxAmount {
        get;
        set;
    }
    global sfxero.XeroAccount.TaxType taxType {
        get;
        set;
    }
    global List<sfxero.XeroTrackingCategory> tracking {
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
    global XeroManualJournalLine() {

    }
}
}
