@isTest
private class AccountProcessorTest {

    @isTest
    static void countContacts_Test() {
        Integer contactsNum = 3;
        List<Account> accountsList = TestDataFactory.createAccountsWithContacts(2, contactsNum);
        List<Id> accountIds = new List<Id>();
        for (Account a : accountsList) {
            accountIds.add(a.Id);
        }

        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        List<Account> resultAccounts = [SELECT Id, Number_of_Contacts__c FROM Account];
        for (Account a : resultAccounts) {
            System.assertEquals(contactsNum, a.Number_of_Contacts__c, 'Contacts Number should be: ' + contactsNum);
        }
    }

//    @isTest
//    static void countContacts_TestNegative() {
//
//    }
}