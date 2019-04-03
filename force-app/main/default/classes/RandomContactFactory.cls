public class RandomContactFactory {
	public static List<Contact> generateRandomContacts(Integer numAccs, String sLastName) {
		List<Contact> contactList = new List<Contact>();

		for (Integer i = 0; i < numAccs; i++) {
			Contact c = new Contact(LastName = sLastName, FirstName = 'Test ' + i);
			contactList.add(c);
		}

		return contactList;
	}
}