@isTest
private class TestVerifyDate {

	@isTest
	static void CheckDates_Test_in30days() {
		Date date1 = Date.today();
		Date date2 = date1.addDays(29);

		Test.startTest();
		Date result = VerifyDate.CheckDates(date1, date2);
		Test.stopTest();

		System.assertEquals(date2, result, 'date2 should be the same as result.');
	}

	@isTest
	static void CheckDates_Test_out30days() {
		Date date1 = Date.today();
		Date date2 = date1.addDays(32);

		Test.startTest();
		Date result = VerifyDate.CheckDates(date1, date2);
		Test.stopTest();

        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);

        System.assertEquals(lastDay, result, 'The Dates should be the same.');
	}
}