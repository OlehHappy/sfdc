//@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
//    @HttpGet
//    global static Account getAccount() {
//        RestRequest req = RestContext.request;
//        String accountId = req.requestURI.substringBetween('Accounts/', '/contacts');
//
//        return [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id = :accountId LIMIT 1];
//    }
}