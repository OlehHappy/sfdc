public class ContactSearch {
	
    public static Contact[] searchForContacts(String first, String second) {
        List<Contact> res = [SELECT ID,Name FROM Contact WHERE (LastName=:first AND MailingPostalCode=:second)];
        
        return res;
    }
}