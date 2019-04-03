public class ReasearchDbRollback {
    public void foo() {
        Account a1;
        Account a2;
        Contact c1;
        Contact c2;
        
        
        List<Account> accounts = new List<Account>{ a1, a2 };
        List<Contact> contacts = new List<Contact>{ c1, c2 };
        
            // Database.savepoint
            // Database.rollback
        update accounts;
        insert contacts;
    }
}