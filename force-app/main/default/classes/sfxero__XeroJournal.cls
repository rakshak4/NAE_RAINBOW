/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroJournal {
    global String CreatedDateUTC {
        get;
        set;
    }
    global Date JournalDate {
        get;
        set;
    }
    global String JournalID {
        get;
        set;
    }
    global List<sfxero.XeroJournal.XeroJournalLine> JournalLines {
        get;
        set;
    }
    global String JournalNumber {
        get;
        set;
    }
    global String Reference {
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
    global XeroJournal() {

    }
global class XeroJournalLine {
    global String AccountCode {
        get;
        set;
    }
    global String AccountID {
        get;
        set;
    }
    global String AccountName {
        get;
        set;
    }
    global String AccountType {
        get;
        set;
    }
    global sfxero.XeroAccount.AccountType accountTypeAsEnum {
        get;
        set;
    }
    global Decimal GrossAmount {
        get;
        set;
    }
    global String JournalLineID {
        get;
        set;
    }
    global Decimal NetAmount {
        get;
        set;
    }
    global Decimal TaxAmount {
        get;
        set;
    }
    global String TaxName {
        get;
        set;
    }
    global String TaxType {
        get;
        set;
    }
    global sfxero.XeroAccount.TaxType taxTypeAsEnum {
        get;
        set;
    }
    global List<sfxero.XeroTrackingCategory> TrackingCategories {
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
    global XeroJournalLine() {

    }
}
}
