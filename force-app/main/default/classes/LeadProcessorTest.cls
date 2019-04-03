@IsTest
private class LeadProcessorTest {
    @TestSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();

        for (Integer i = 0; i < 10; i++) {
            leads.add(new Lead(LastName = 'Test Lead ' + i, Company = 'Test Co.'));
        }
        insert leads;
    }

    @IsTest
    private static void batchTest() {
        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Database.executeBatch(leadProcessor);
        Test.stopTest();

        Integer result = [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(10, result, 'We expecting all 10 Leads has been updated.');
    }
}