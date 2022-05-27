/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroAccount {
    global sfxero.XeroAccount.AccountClass accountClass {
        get;
        set;
    }
    global String accountID {
        get;
        set;
    }
    global sfxero.XeroAccount.AccountType accountType {
        get;
        set;
    }
    global String bankAccountNumber {
        get;
        set;
    }
    global String code {
        get;
        set;
    }
    global String currencyCode {
        get;
        set;
    }
    global String description {
        get;
        set;
    }
    global Boolean enablePayments {
        get;
        set;
    }
    global Boolean hasAttachments {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global String reportCode {
        get;
        set;
    }
    global String reportCodeName {
        get;
        set;
    }
    global Boolean showInExpenseClaims {
        get;
        set;
    }
    global String status {
        get;
        set;
    }
    global String systemAccount {
        get;
        set;
    }
    global sfxero.XeroAccount.SystemAccountType systemAccountType {
        get;
        set;
    }
    global sfxero.XeroAccount.TaxType taxType {
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
    global XeroAccount() {

    }
global enum AccountClass {ASSET, EQUITY, EXPENSE, LIABILITY, REVENUE}
global enum AccountType {BANK, CURRENT, CURRLIAB, DEPRECIATN, DIRECTCOSTS, EQUITY, EXPENSE, FIXED, INVENTORY, LIABILITY, NONCURRENT, OTHERINCOME, OVERHEADS, PAYGLIABILITY, PREPAYMENT, REVENUE, SALES, SUPERANNUATIONEXPENSE, SUPERANNUATIONLIABILITY, TERMLIAB, WAGESEXPENSE, WAGESPAYABLELIABILITY}
global enum SystemAccountType {ACCOUNTS_PAYABLE_800, ACCOUNTS_RECEIVABLE_610, BANK_REVALUATIONS_497, BANKCURRENCYGAIN, CREDITORS, DEBTORS, GST, GST_820, GST_ON_IMPORTS_821, GSTONIMPORTS, HISTORICAL, HISTORICAL_ADJUSTMENT_840, REALISED_CURRENCY_GAINS_499, REALISEDCURRENCYGAIN, RETAINED_EARNINGS_960, RETAINEDEARNINGS, ROUNDING, ROUNDING_860, TRACKING_TRANSFERS_877, TRACKINGTRANSFERS, UNPAID_EXPENSE_CLAIMS_801, UNPAIDEXPCLM, UNREALISED_CURRENCY_GAINS_498, UNREALISEDCURRENCYGAIN, WAGEPAYABLES}
global enum TaxType {BASEXCLUDED, CAPEXINPUT, CAPEXINPUT2, CAPEXOUTPUT, CAPEXOUTPUT2, CAPEXSRINPUT, CAPEXSROUTPUT, ECZRINPUT, ECZROUTPUT, ECZROUTPUTSERVICES, EXEMPTCAPITAL, EXEMPTEXPENSES, EXEMPTEXPORT, EXEMPTINPUT, EXEMPTOUTPUT, GSTONCAPIMPORTS, GSTONIMPORTS, INPUT, INPUT2, INPUTTAXED, NONE, OUTPUT, OUTPUT2, RRINPUT, RROUTPUT, SRINPUT, SROUTPUT, ZERORATEDINPUT, ZERORATEDOUTPUT}
}
