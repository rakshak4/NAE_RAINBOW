/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroOrganisation {
    global List<sfxero.XeroContact.XeroAddress> addresses {
        get;
        set;
    }
    global String APIKey {
        get;
        set;
    }
    global String baseCurrency {
        get;
        set;
    }
    global String countryCode {
        get;
        set;
    }
    global Datetime createdDateUTC {
        get;
        set;
    }
    global Date endOfYearLockDate {
        get;
        set;
    }
    global List<sfxero.XeroOrganisation.XeroExternalLink> externalLinks {
        get;
        set;
    }
    global Integer financialYearEndDay {
        get;
        set;
    }
    global Integer financialYearEndMonth {
        get;
        set;
    }
    global Boolean isDemoCompany {
        get;
        set;
    }
    global String legalName {
        get;
        set;
    }
    global String lineOfBusiness {
        get;
        set;
    }
    global static Map<String,sfxero.XeroOrganisation.LinkType> linkTypeMap;
    global String name {
        get;
        set;
    }
    global String organisationStatus {
        get;
        set;
    }
    global static Map<String,sfxero.XeroOrganisation.OrganisationType> organisationTypeMap;
    global Date organistaionCreation {
        get;
        set;
    }
    global String orgType {
        get;
        set;
    }
    global sfxero.XeroOrganisation.OrganisationType orgTypeAsEnum {
        get;
        set;
    }
    global String orgVersion {
        get;
        set;
    }
    global sfxero.XeroContact.XeroPaymentTerms paymentTermsBills {
        get;
        set;
    }
    global sfxero.XeroContact.XeroPaymentTerms paymentTermsSales {
        get;
        set;
    }
    global Boolean paysTax {
        get;
        set;
    }
    global Date periodLockDate {
        get;
        set;
    }
    global List<sfxero.XeroContact.XeroPhone> phones {
        get;
        set;
    }
    global String registrationNumber {
        get;
        set;
    }
    global sfxero.XeroOrganisation.SalesTaxBasis salesTaxBasis {
        get;
        set;
    }
    global static Map<String,sfxero.XeroOrganisation.SalesTaxBasis> salesTaxBasisTypeMap;
    global sfxero.XeroOrganisation.SalesTaxPeriod salesTaxPeriod {
        get;
        set;
    }
    global static Map<String,sfxero.XeroOrganisation.SalesTaxPeriod> salesTaxPeriodTypeMap;
    global String shortCode {
        get;
        set;
    }
    global String taxNumber {
        get;
        set;
    }
    global String timezone {
        get;
        set;
    }
    global List<String> validationErrors {
        get;
        set;
    }
    global Integer version {
        get;
        set;
    }
    global List<String> warnings {
        get;
        set;
    }
    global XeroOrganisation() {

    }
global enum LinkType {Facebook, GooglePlus, LinkedIn, Twitter, Website}
global enum OrganisationType {CHARITY, CLUBSOCIETY, COMPANY, PARTNERSHIP, PERSON, SOLETRADER, TRUST}
global enum SalesTaxBasis {ACCRUAL, ACCRUALS, CASH, FLATRATEACCRUAL, FLATRATECASH, INVOICE, NONE, PAYMENTS}
global enum SalesTaxPeriod {ANNUALLY, MONTHLY, MONTHLY1, MONTHLY2, MONTHLY3, MONTHLY6, ONEMONTHS, QUARTERLY, QUARTERLY1, QUARTERLY2, QUARTERLY3, SIXMONTHS, TWOMONTHS}
global class XeroExternalLink {
    global sfxero.XeroOrganisation.LinkType linkType {
        get;
        set;
    }
    global String url {
        get;
        set;
    }
    global XeroExternalLink() {

    }
}
}
