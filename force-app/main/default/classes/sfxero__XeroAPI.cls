/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroAPI {
    global XeroAPI() {

    }
    global static sfxero.XeroContact convertAccountToXeroContact(Account account) {
        return null;
    }
    global static sfxero.XeroInvoice convertOpportunityToXeroInvoice(Opportunity opportunity) {
        return null;
    }
    global static sfxero.XeroInvoice convertOpportunityToXeroInvoice(Opportunity opportunity, String sortingKey, String sortOrder) {
        return null;
    }
    global static sfxero.XeroInvoice convertOpportunityToXeroInvoice(Opportunity opportunity, String sortingKey, String sortOrder, String nullsOrder) {
        return null;
    }
    global static System.HttpResponse get(String url, sfxero.XeroCredentials creds, Datetime modifiedAfter, String filter, String orderBy) {
        return null;
    }
    global static sfxero.XeroAccountResponse getAccountById(sfxero.XeroCredentials creds, String xeroAccountId) {
        return null;
    }
    global static sfxero.XeroAccountResponse getAccountByNumber(sfxero.XeroCredentials creds, String xeroAccountId) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroAccountResponse getAccounts(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroAccountResponse getAccountsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroBankTransactionResponse getBankTransactions(sfxero.XeroCredentials credentials, Datetime modifiedAfter, String filterCondition, String orderBy, String identifier) {
        return null;
    }
    global static sfxero.XeroBrandingThemeResponse getBrandingThemeById(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroBrandingThemeResponse getBrandingThemesAll(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    global static sfxero.XeroBrandingThemeResponse getBrandingThemesAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroContact getContactByContactNumber(sfxero.XeroCredentials creds, String contactNumber) {
        return null;
    }
    global static sfxero.XeroContactResponse getContactById(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroContact getContactByXeroId(sfxero.XeroCredentials creds, String xeroContactId) {
        return null;
    }
    global static sfxero.XeroContactResponse getContactsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroContactResponse getContactsWithResponse(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    @Deprecated
    global static List<sfxero.XeroContact> getContacts(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroCreditNotePDFResponse getCreditNoteAsPDF(sfxero.XeroCredentials creds, String xeroCreditNoteID) {
        return null;
    }
    global static sfxero.XeroCreditNoteResponse getCreditNoteById(sfxero.XeroCredentials creds, String xeroCreditNoteID) {
        return null;
    }
    global static sfxero.XeroCreditNoteResponse getCreditNoteByNumber(sfxero.XeroCredentials creds, String xeroCreditNoteNumber) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroCreditNoteResponse getCreditNotes(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroCreditNoteResponse getCreditNotesAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroCurrencyResponse getCurrency(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroCurrencyResponse getCurrencysAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroEmployeeResponse getEmployeeById(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, String identifier) {
        return null;
    }
    global static sfxero.XeroEmployeeResponse getEmployees(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy) {
        return null;
    }
    global static sfxero.XeroExpenseClaimResponse getExpenseClaimById(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    global static sfxero.XeroExpenseClaimResponse getExpenseClaimsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroInvoicePDFResponse getInvoiceAsPDF(sfxero.XeroCredentials creds, String xeroInvoiceId) {
        return null;
    }
    global static sfxero.XeroInvoiceResponse getInvoiceById(sfxero.XeroCredentials creds, String xeroInvoiceId) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroInvoice getInvoiceByInvoiceNumber(sfxero.XeroCredentials creds, String invoiceNumber) {
        return null;
    }
    global static sfxero.XeroInvoiceResponse getInvoiceByNumber(sfxero.XeroCredentials creds, String xeroInvoiceNumber) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroInvoice getInvoiceByXeroId(sfxero.XeroCredentials creds, String xeroInvoiceId) {
        return null;
    }
    global static sfxero.XeroInvoiceResponse getInvoicesAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    @Deprecated
    global static List<sfxero.XeroInvoice> getInvoices(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    @Deprecated
    global static List<sfxero.XeroInvoice> getInvoices(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy, String invoiceIdentifier) {
        return null;
    }
    global static sfxero.XeroItemResponse getItemsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroItemResponse getItemsByCode(sfxero.XeroCredentials creds, String code) {
        return null;
    }
    global static sfxero.XeroItemResponse getItemsById(sfxero.XeroCredentials creds, String id) {
        return null;
    }
    global static sfxero.XeroJournalResponse getJournalsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, Integer offset) {
        return null;
    }
    global static sfxero.XeroJournalResponse getJournalsById(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    global static sfxero.XeroJournalResponse getJournalsByNumber(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    global static sfxero.XeroManualJournalResponse getManualJournalById(sfxero.XeroCredentials creds, String id) {
        return null;
    }
    global static sfxero.XeroManualJournalResponse getManualJournalsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroOrganisationResponse getOrganisationsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroPaymentResponse getPaymentById(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    global static sfxero.XeroPaymentResponse getPaymentsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroReceiptResponse getReceiptById(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    global static sfxero.XeroReceiptResponse getReceiptsAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_AgedPayablesByContact(sfxero.XeroCredentials xc, Date optionalDate, Date fromDate, Date toDate, String contactId) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_AgedPayablesByContact(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date optionalDate, Date fromDate, Date toDate, String contactId) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_AgedReceivablesByContact(sfxero.XeroCredentials xc, Date optionalDate, Date fromDate, Date toDate, String contactId) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_AgedReceivablesByContact(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date optionalDate, Date fromDate, Date toDate, String contactId) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BASReport(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, String identifier) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_BASReportById(sfxero.XeroCredentials xc, String identifier) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BalanceSheet(sfxero.XeroCredentials xc, Date filterDate) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BalanceSheet(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date optionalDate) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_BalanceSheet(sfxero.XeroCredentials xc, Date optionalDate, String trackingOptionID, String trackingOptionID2, Boolean standardLayout) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BankStatement(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date fromDate, Date toDate, String bankAccountId) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_BankStatementByDate(sfxero.XeroCredentials xc, Date fromDate, Date toDate, String bankAccountId) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BankSummary(sfxero.XeroCredentials xc, Date fromDate, Date toDate) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BankSummary(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date fromDate, Date toDate) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_BankSummaryByDate(sfxero.XeroCredentials xc, Date fromDate, Date toDate) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BudgetSummary(sfxero.XeroCredentials xc) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BudgetSummary(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Integer periods, String timeframe) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_BudgetSummary(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date dateParam, Integer periods, String timeframe) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_BudgetSummaryByDate(sfxero.XeroCredentials xc, Date dateParam, Integer periods, String timeframe) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_ExecutiveSummary(sfxero.XeroCredentials xc) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_ExecutiveSummary(sfxero.XeroCredentials xc, Date optionalDate) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_ExecutiveSummary(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date optionalDate) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_GSTReport(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, String identifier) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_GSTReportById(sfxero.XeroCredentials xc, String identifier) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_ProfitAndLoss(sfxero.XeroCredentials xc, Date fromDate, Date toDate) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_ProfitAndLoss(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date fromDate, Date toDate) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_ProfitAndLoss(sfxero.XeroCredentials xc, Date fromDate, Date toDate, String trackingCategoryID, String trackingOptionID, String trackingCategoryID2, String trackingOptionID2, Boolean standardLayout) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_TenNinetyNine(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Integer reportYear) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_TenNinetyNineByYear(sfxero.XeroCredentials xc, Integer reportYear) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_TrackingSummary(sfxero.XeroCredentials xc, String accounts, String trackingCategoryName) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_TrialBalance(sfxero.XeroCredentials xc, Date filterDate) {
        return null;
    }
    @Deprecated
    global static sfxero.XeroReportResponse getReports_TrialBalance(sfxero.XeroCredentials xc, Date modifiedAfter, String whereFilter, String orderBy, Date filterDate, Boolean paymentOnly) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports_TrialBalanceByDate(sfxero.XeroCredentials xc, Date filterDate, Boolean paymentOnly) {
        return null;
    }
    global static sfxero.XeroReportResponse getReports(sfxero.XeroCredentials xc, String reportType, Map<String,Object> params) {
        return null;
    }
    global static sfxero.XeroTaxRateResponse getTaxRatesAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroTrackingCategoryResponse getTrackingCategoriesAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static sfxero.XeroUserResponse getUserById(sfxero.XeroCredentials creds, String identifier) {
        return null;
    }
    global static sfxero.XeroUserResponse getUsersAll(sfxero.XeroCredentials creds, Datetime modifiedAfter, String filterCondition, String orderBy) {
        return null;
    }
    global static System.HttpResponse post(String url, sfxero.XeroCredentials creds, String xmlBody) {
        return null;
    }
    global static sfxero.XeroBankTransactionResponse postBankTransactions(List<sfxero.XeroBankTransaction> bt, sfxero.XeroCredentials credentials, String id) {
        return null;
    }
    global static sfxero.XeroContactResponse postContacts(List<sfxero.XeroContact> contacts, sfxero.XeroCredentials creds) {
        return null;
    }
    global static sfxero.XeroCreditNoteResponse postCreditNotes(sfxero.XeroCredentials creds, List<sfxero.XeroCreditNote> xcn) {
        return null;
    }
    global static sfxero.XeroEmployeeResponse postEmployees(sfxero.XeroCredentials xc, List<sfxero.XeroEmployee> employees) {
        return null;
    }
    global static sfxero.XeroExpenseClaimResponse postExpenseClaims(List<sfxero.XeroExpenseClaim> expenseClaim, sfxero.XeroCredentials creds) {
        return null;
    }
    global static sfxero.XeroInvoiceResponse postInvoices(List<sfxero.XeroInvoice> invoices, sfxero.XeroCredentials creds) {
        return null;
    }
    global static sfxero.XeroItemResponse postItems(sfxero.XeroCredentials creds, List<sfxero.XeroItem> items) {
        return null;
    }
    global static sfxero.XeroManualJournalResponse postManualJournals(sfxero.XeroCredentials creds, List<sfxero.XeroManualJournal> journals) {
        return null;
    }
    global static sfxero.XeroReceiptResponse postReceipts(sfxero.XeroCredentials creds, List<sfxero.XeroReceipt> xr) {
        return null;
    }
    global static sfxero.XeroTaxRateResponse postTaxRates(sfxero.XeroCredentials creds, List<sfxero.XeroTaxRate> rates) {
        return null;
    }
    global static System.HttpResponse put(String url, sfxero.XeroCredentials creds, Datetime modifiedAfter, String filter, String orderBy, String xmlBody) {
        return null;
    }
    global static sfxero.XeroAccountResponse putAccount(sfxero.XeroCredentials credentials, sfxero.XeroAccount account) {
        return null;
    }
    global static sfxero.XeroAllocationResponse putAllocation(sfxero.XeroAllocation alloc, sfxero.XeroCredentials credentials, String creditNoteId) {
        return null;
    }
    global static sfxero.XeroBankTransactionResponse putBankTransactions(List<sfxero.XeroBankTransaction> bt, sfxero.XeroCredentials credentials) {
        return null;
    }
    global static sfxero.XeroContactResponse putContacts(List<sfxero.XeroContact> contacts, sfxero.XeroCredentials creds) {
        return null;
    }
    global static sfxero.XeroCreditNoteResponse putCreditNotes(sfxero.XeroCredentials creds, List<sfxero.XeroCreditNote> xcn) {
        return null;
    }
    global static sfxero.XeroEmployeeResponse putEmployees(sfxero.XeroCredentials xc, List<sfxero.XeroEmployee> employees) {
        return null;
    }
    global static sfxero.XeroExpenseClaimResponse putExpenseClaims(List<sfxero.XeroExpenseClaim> expenseClaim, sfxero.XeroCredentials creds) {
        return null;
    }
    global static sfxero.XeroInvoiceResponse putInvoices(List<sfxero.XeroInvoice> invoices, sfxero.XeroCredentials creds) {
        return null;
    }
    global static sfxero.XeroItemResponse putItems(sfxero.XeroCredentials creds, List<sfxero.XeroItem> items) {
        return null;
    }
    global static sfxero.XeroManualJournalResponse putManualJournals(sfxero.XeroCredentials creds, List<sfxero.XeroManualJournal> journals) {
        return null;
    }
    global static sfxero.XeroPaymentResponse putPayments(sfxero.XeroCredentials creds, List<sfxero.XeroPayment> payments) {
        return null;
    }
    global static sfxero.XeroReceiptResponse putReceipts(sfxero.XeroCredentials creds, List<sfxero.XeroReceipt> xr) {
        return null;
    }
    global static sfxero.XeroTaxRateResponse putTaxRates(sfxero.XeroCredentials creds, List<sfxero.XeroTaxRate> rates) {
        return null;
    }
    global static void startSummarizingErrors() {

    }
    global static void startTesting() {

    }
    global static void stopSummarizingErrors() {

    }
    global static void stopTesting() {

    }
}
