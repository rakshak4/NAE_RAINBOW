/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroReport {
    global String id {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global Date reportDate {
        get;
        set;
    }
    global List<sfxero.XeroReport.XeroReportField> reportFields {
        get;
        set;
    }
    global List<String> reportTitles {
        get;
        set;
    }
    global String reportType {
        get;
        set;
    }
    global List<sfxero.XeroReport.XeroReportRow> rows {
        get;
        set;
    }
    global String updatedDateUTC {
        get;
        set;
    }
    global XeroReport() {

    }
global class XeroReportAttribute {
    global String id {
        get;
        set;
    }
    global String value {
        get;
        set;
    }
    global XeroReportAttribute() {

    }
}
global class XeroReportCell {
    global List<sfxero.XeroReport.XeroReportAttribute> attributes {
        get;
        set;
    }
    global String value {
        get;
        set;
    }
    global XeroReportCell() {

    }
}
global class XeroReportField {
    global String description {
        get;
        set;
    }
    global String fieldId {
        get;
        set;
    }
    global String value {
        get;
        set;
    }
    global XeroReportField() {

    }
}
global class XeroReportRow {
    global List<sfxero.XeroReport.XeroReportCell> cells {
        get;
        set;
    }
    global List<sfxero.XeroReport.XeroReportRow> rows {
        get;
        set;
    }
    global String rowTitle {
        get;
        set;
    }
    global String rowType {
        get;
        set;
    }
    global XeroReportRow() {

    }
}
}
