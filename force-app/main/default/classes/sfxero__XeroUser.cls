/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroUser {
    global String emailAddress {
        get;
        set;
    }
    global String firstName {
        get;
        set;
    }
    global Boolean isSubscriber {
        get;
        set;
    }
    global String lastName {
        get;
        set;
    }
    global sfxero.XeroUser.RoleType organisationRole {
        get;
        set;
    }
    global Date updatedDateUTC {
        get;
        set;
    }
    global String userId {
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
    global XeroUser() {

    }
global enum RoleType {CASHBOOKCLIENT, FINANCIALADVISER, INVOICEONLY, MANAGEDCLIENT, READONLY, STANDARD}
}
