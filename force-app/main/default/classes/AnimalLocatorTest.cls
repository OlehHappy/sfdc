@isTest
public class AnimalLocatorTest {

	@isTest
	static void testGetCallout() {
		Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

		String res = AnimalLocator.getAnimalNameById(1);

		System.assert(String.isNotBlank(res), 'Result should not be empty');
		System.assertEquals('chicken', res, 'Result value should be the same');
	}
}