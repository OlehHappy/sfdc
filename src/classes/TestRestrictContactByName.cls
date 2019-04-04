@isTest
private class TestRestrictContactByName {

	@isTest
	static void TestRestrictedContactName() {
		Contact c = new Contact(LastName='INVALIDNAME');

		Test.startTest();
		Database.SaveResult result = Database.insert(c, false);
		Test.stopTest();

		System.assert(!result.isSuccess(), 'Result should n\'t be SUCCESS');
		System.assert(result.getErrors().size() > 0);
		System.assertEquals('The Last Name "'+c.LastName+'" is not allowed for DML',
							 result.getErrors()[0].getMessage());

	}
}