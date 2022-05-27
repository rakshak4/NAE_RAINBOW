/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroBankTransaction {
    global sfxero.XeroBankAccount bankAccount {
        get;
        set;
    }
    global Date bankTransactionDate {
        get;
        set;
    }
    global Datetime bankTransactionDatetime {
        get;
        set;
    }
    global String bankTransactionId {
        get;
        set;
    }
    global sfxero.XeroContact contact {
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
    global Boolean hasAttachments {
        get;
        set;
    }
    global Boolean isReconciled {
        get;
        set;
    }
    global sfxero.XeroBankTransaction.LineAmountType LineAmountType {
        get;
        set;
    }
    global static Map<String,sfxero.XeroBankTransaction.LineAmountType> lineAmountTypeMap;
    global List<sfxero.XeroLineItem> lineItems {
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
    global sfxero.XeroBankTransaction.StatusCode statusCode {
        get;
        set;
    }
    global static Map<String,sfxero.XeroBankTransaction.StatusCode> statusCodeMap;
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
    global static Map<String,sfxero.XeroBankTransaction.TransactionType> transactionTypeMap;
    global static Map<sfxero.XeroBankTransaction.TransactionType,String> transactionTypeReverseMap;
    global sfxero.XeroBankTransaction.TransactionType transType {
        get;
        set;
    }
    global String type {
        get;
        set;
    }
    global Datetime updatedDateTimeUTC {
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
    global XeroBankTransaction() {

    }
global enum LineAmountType {Exclusive, Inclusive, NoTax}
global enum StatusCode {AUTHORISED, DELETED}
global enum TransactionType {RECEIVE, RECEIVEOVERPAYMENT, RECEIVEPREPAYMENT, RECEIVETRANSFER, SPEND, SPENDOVERPAYMENT, SPENDPREPAYMENT, SPENDTRANSFER}
}
