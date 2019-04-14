@IsTest
private class ParkLocatorTest {
    @IsTest
    private static void testCallout() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        Test.startTest();
        String[] result = ParkLocator.country('Germany');
        Test.stopTest();

        System.assertEquals(3, result.size(), 'We expect 3 in returning result.');
    }
}