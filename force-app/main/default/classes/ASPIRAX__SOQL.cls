/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@isTest
global abstract class SOQL {
    global SOQL() {

    }
    global static ASPIRAX.SOQL.ICriterion eq(String column, Object value) {
        return null;
    }
    global static String escape(ASPIRAX.SOQL.Operator operator) {
        return null;
    }
    global static String escape(Object value) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion ge(String column, Object value) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion gt(String column, Object value) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion le(String column, Object value) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion lt(String column, Object value) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion match(String column, String pattern) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion ne(String column, Object value) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion noneOf(String column, List<Id> values) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion noneOf(String column, List<Object> values) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion oneOf(String column, List<Id> values) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriterion oneOf(String column, List<Object> values) {
        return null;
    }
    @isTest(SeeAllData=false OnInstall=false)
    global static void testCriterion() {

    }
    @isTest(SeeAllData=false OnInstall=false)
    global static void testEscapeMethod() {

    }
    @isTest(SeeAllData=false OnInstall=false)
    global static void testQuery() {

    }
    global static ASPIRAX.SOQL.ICriteria useAND(ASPIRAX.SOQL.ICriterion a, ASPIRAX.SOQL.ICriterion b) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriteria useAND(List<ASPIRAX.SOQL.ICriterion> criteria) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriteria useOR(ASPIRAX.SOQL.ICriterion a, ASPIRAX.SOQL.ICriterion b) {
        return null;
    }
    global static ASPIRAX.SOQL.ICriteria useOR(List<ASPIRAX.SOQL.ICriterion> criteria) {
        return null;
    }
global class Criteria implements ASPIRAX.SOQL.ICriteria {
    global Criteria(List<ASPIRAX.SOQL.ICriterion> criteria, ASPIRAX.SOQL.Operator logic) {

    }
    global Criteria(ASPIRAX.SOQL.ICriterion a, ASPIRAX.SOQL.ICriterion b, ASPIRAX.SOQL.Operator logic) {

    }
    global ASPIRAX.SOQL.ICriteria add(ASPIRAX.SOQL.ICriterion criterion) {
        return null;
    }
    global String toSOQL() {
        return null;
    }
}
global class Criterion implements ASPIRAX.SOQL.ICriterion {
    global Criterion(String column, ASPIRAX.SOQL.Operator operator, List<Id> values) {

    }
    global Criterion(String column, ASPIRAX.SOQL.Operator operator, List<Object> values) {

    }
    global Criterion(String column, ASPIRAX.SOQL.Operator operator, Object value) {

    }
    global String toSOQL() {
        return null;
    }
}
global enum Direction {ASCENDING, DESCENDING}
global interface ICriteria extends ASPIRAX.SOQL.ICriterion {
    ASPIRAX.SOQL.ICriteria add(ASPIRAX.SOQL.ICriterion param0);
}
global virtual interface ICriterion {
    String toSOQL();
}
global enum Operator {EQUAL, GREATER_OR_EQUAL, GREATER_THAN, LESS_OR_EQUAL, LESS_THAN, LIKE_PATTERN, LOGICAL_AND, LOGICAL_OR, NONE_OF, NOT_EQUAL, ONE_OF}
global class Query {
    global Query() {

    }
    global ASPIRAX.SOQL.Query all() {
        return null;
    }
    global ASPIRAX.SOQL.Query exclude(String columns) {
        return null;
    }
    global ASPIRAX.SOQL.Query exclude(List<String> columns) {
        return null;
    }
    global ASPIRAX.SOQL.Query include(String columns) {
        return null;
    }
    global ASPIRAX.SOQL.Query include(List<String> columns) {
        return null;
    }
    global ASPIRAX.SOQL.Query joins(ASPIRAX.SOQL.Query query) {
        return null;
    }
    global ASPIRAX.SOQL.Query joins(List<ASPIRAX.SOQL.Query> queries) {
        return null;
    }
    global ASPIRAX.SOQL.Query lock() {
        return null;
    }
    global ASPIRAX.SOQL.Query meet(ASPIRAX.SOQL.ICriterion criteria) {
        return null;
    }
    global ASPIRAX.SOQL.Query nolimit() {
        return null;
    }
    global ASPIRAX.SOQL.Query nolock() {
        return null;
    }
    global ASPIRAX.SOQL.Query noorder() {
        return null;
    }
    global ASPIRAX.SOQL.Query orderASC(String columns) {
        return null;
    }
    global ASPIRAX.SOQL.Query orderASC(List<String> columns) {
        return null;
    }
    global ASPIRAX.SOQL.Query orderDESC(String columns) {
        return null;
    }
    global ASPIRAX.SOQL.Query orderDESC(List<String> columns) {
        return null;
    }
    global String toSOQL() {
        return null;
    }
    global ASPIRAX.SOQL.Query use(String objectName) {
        return null;
    }
    global ASPIRAX.SOQL.Query within(Integer limits) {
        return null;
    }
}
}
