/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class XeroCredentials {
    global sfxero.XeroCredentials.AcceptType acceptHeader {
        get;
        set;
    }
    global String authorisationLink {
        get;
        set;
    }
    global String consumerKey {
        get;
        set;
    }
    global String consumerSecret {
        get;
        set;
    }
    global sfxero.XeroCredentials.XeroCredentialType credentialType {
        get;
        set;
    }
    global String namedCredential {
        get;
        set;
    }
    global Boolean oAuth2 {
        get;
        set;
    }
    global String oauthCallback {
        get;
        set;
    }
    global String oauthToken {
        get;
        set;
    }
    global String oauthTokenSecret {
        get;
        set;
    }
    global String oauthVerifier {
        get;
        set;
    }
    global String privateKey {
        get;
        set;
    }
    global static Integer REQ_TIMEOUT;
    global String xeroTenantId {
        get;
        set;
    }
    global XeroCredentials() {

    }
    global XeroCredentials(String ck, String pk) {

    }
    global XeroCredentials(String consumerKey, String consumerSecret, String privateKey) {

    }
    global XeroCredentials(String namedCredential, String xeroTenantId, sfxero.XeroCredentials.AuthVersion authVersion) {

    }
    global XeroCredentials(String consumerKey, String consumerSecret, String oauthToken, String oauthVerifier) {

    }
    global void generateRequestTokens() {

    }
    global Integer getTimeout() {
        return null;
    }
    global static String getXeroTenantIds(String namedCredential) {
        return null;
    }
    global Boolean isOauth2() {
        return null;
    }
    global void swapVerifier() {

    }
    @Deprecated
    global String swapVerifierForAccessToken() {
        return null;
    }
    global Boolean validatePublicCredentials() {
        return null;
    }
global enum AcceptType {DEFAULT_VALUE, JSON, XML}
global enum AuthVersion {OAUTH_2}
global enum XeroCredentialType {XeroPrivate, XeroPublic}
global class XeroCredentialsException extends Exception {
}
}
