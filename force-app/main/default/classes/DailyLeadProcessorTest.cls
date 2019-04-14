@IsTest
private class DailyLeadProcessorTest {
    final static String CRON_EXP = '0 0 0 15 3 ? 2022';
    final static Integer RECORDS_NUMBER = 200;

    @TestSetup
    static void setup() {
        List<Lead> testLeads = new List<Lead>();

        for (Integer i = 0; i < RECORDS_NUMBER; i++) {
            testLeads.add(new Lead(
                    Email = 'testemail' + i + '@mail.com',
                    LastName = 'Test' + i,
                    Company = 'Company Test' + i)
            );
        }
        insert testLeads;
    }

    @IsTest
    private static void testScheduledJob() {
        DailyLeadProcessor dailyLeadProcessor = new DailyLeadProcessor();

        Test.startTest();
        String jobId = System.schedule('ScheduleApexTest', CRON_EXP, dailyLeadProcessor);
        Test.stopTest();

        Integer leadsProcessed = [SELECT count() FROM Lead WHERE LeadSource = :DailyLeadProcessor.DREAMFORCE_STR];
        System.assert(jobId != null, 'We expect to get some Id, in case job is processed.');
        System.assertEquals(RECORDS_NUMBER, leadsProcessed, 'We expecting same number of processed records.');
    }
}