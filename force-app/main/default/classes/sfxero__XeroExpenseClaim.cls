/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroExpenseClaim {
    global Decimal amountDue {
        get;
        set;
    }
    global Decimal amountPaid {
        get;
        set;
    }
    global Date createdDateUTC {
        get;
        set;
    }
    global String expenseClaimId {
        get;
        set;
    }
    global Date paymentDueDate {
        get;
        set;
    }
    global List<sfxero.XeroReceipt> receipts {
        get;
        set;
    }
    global Date reportingDate {
        get;
        set;
    }
    global sfxero.XeroExpenseClaim.StatusCode status {
        get;
        set;
    }
    global Decimal total {
        get;
        set;
    }
    global Date updatedDateUTC {
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
    global XeroExpenseClaim() {

    }
global enum StatusCode {AUTHORISED, DELETED, DRAFT, PAID, SUBMITTED, VOIDED}
}
