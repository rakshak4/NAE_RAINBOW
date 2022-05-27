/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroTaxRate {
    global Boolean canApplyToAssets {
        get;
        set;
    }
    global Boolean canApplyToEquity {
        get;
        set;
    }
    global Boolean canApplyToExpenses {
        get;
        set;
    }
    global Boolean canApplyToLiabilities {
        get;
        set;
    }
    global Boolean canApplyToRevenue {
        get;
        set;
    }
    global Decimal displayedRate {
        get;
        set;
    }
    global Integer displayTaxRate {
        get;
        set;
    }
    global Decimal effectiveRate {
        get;
        set;
    }
    global Integer effectiveTaxRate {
        get;
        set;
    }
    global String Name {
        get;
        set;
    }
    global sfxero.XeroTaxRate.ReportTaxType reportTaxType {
        get;
        set;
    }
    global static Map<String,sfxero.XeroTaxRate.ReportTaxType> reportTaxTypeMap;
    global sfxero.XeroTaxRate.TaxRateStatus status {
        get;
        set;
    }
    global List<sfxero.XeroTaxRate.XeroTaxComponent> taxComponents {
        get;
        set;
    }
    global static Map<String,sfxero.XeroTaxRate.TaxRateStatus> taxRateStatusMap;
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
    global XeroTaxRate() {

    }
global enum ReportTaxType {BASEXCLUDED, CAPITALEXPENSESINPUT, CAPITALSALESOUTPUT, ECINPUT, ECOUTPUT, ECOUTPUTSERVICES, EXEMPTEXPENSES, EXEMPTINPUT, EXEMPTOUTPUT, INPUT, INPUTTAXED, OUTPUT}
global enum TaxRateStatus {ACTIVE, DELETED}
global class XeroTaxComponent {
    global Boolean isCompound {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global Decimal rate {
        get;
        set;
    }
    global XeroTaxComponent() {

    }
}
}
