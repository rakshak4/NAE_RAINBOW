/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroItem {
    global String itemCode {
        get;
        set;
    }
    global String itemDateUTC {
        get;
        set;
    }
    global String itemDescription {
        get;
        set;
    }
    global String itemId {
        get;
        set;
    }
    global sfxero.XeroItem.XeroPurchaseSale purchaseDetails {
        get;
        set;
    }
    global sfxero.XeroItem.XeroPurchaseSale saleDetails {
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
    global XeroItem() {

    }
global class XeroPurchaseSale {
    global String accountCode {
        get;
        set;
    }
    global sfxero.XeroAccount.TaxType taxType {
        get;
        set;
    }
    global Decimal unitPrice {
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
    global XeroPurchaseSale() {

    }
}
}
