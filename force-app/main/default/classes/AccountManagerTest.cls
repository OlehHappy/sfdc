@IsTest
private class AccountManagerTest {
    private final static String ACC_NAME = 'Test Account';

    @IsTest
    private static void test_getAccount() {
        Id accountId = createTestAccount();
        RestRequest req = new RestRequest();
        req.requestURI = 'https://crashdb-dev-ed.salesforce.com/services/apexrest/Accounts/' + accountId + '/contacts';
        req.httpMethod = 'GET';
        RestContext.request = req;

        Test.startTest();
        // Account testAccount = AccountManager.getAccount();
        Test.stopTest();

        // System.assert(testAccount != null);
        // System.assertEquals(ACC_NAME, testAccount.Name);
        System.debug('olehdebug >>>> test3');
    }

    static Id createTestAccount() {
        Account accountTest = new Account(
                Name = ACC_NAME
        );
        insert accountTest;

        return accountTest.Id;
    }

}