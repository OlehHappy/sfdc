@IsTest
private class AddPrimaryContactTest {
    private final static String STATE = 'CA';
    private final static Integer ACCOUNTS_NUM = 50;

    @TestSetup
    static void setup() {
        List<Account> accountsToInsert = new List<Account>();

        for (Integer i = 0; i < ACCOUNTS_NUM; i++) {
            accountsToInsert.add(new Account(Name = 'Test Name' + i, BillingState = STATE));
        }
        insert accountsToInsert;
    }

    @IsTest
    private static void testQueueable() {
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Some');
        insert testContact;

        AddPrimaryContact insertContacts = new AddPrimaryContact(testContact, STATE);

        Test.startTest();
        System.enqueueJob(insertContacts);
        Test.stopTest();

        Integer contactsNum = [SELECT count() FROM Contact WHERE Id != :testContact.Id];
        System.assertEquals(ACCOUNTS_NUM, contactsNum, 'We expecting same numbers of contacts will be created.');
    }
}