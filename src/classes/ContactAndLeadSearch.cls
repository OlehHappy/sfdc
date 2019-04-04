public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(String param) {
        List<List<sObject>> res = [FIND :param IN ALL FIELDS RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName)];
        
        return res;
    }
}