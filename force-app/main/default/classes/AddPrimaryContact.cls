public class AddPrimaryContact implements Queueable {
    private Contact cont;
    private String state;

    public AddPrimaryContact(Contact cont, String state) {
        this.cont = cont;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Account a : accounts) {
            Contact newContact = cont.clone(false, false, false, false);
            newContact.AccountId = a.Id;

            contactsToUpdate.add(newContact);
        }

        if (!contactsToUpdate.isEmpty()) {
            insert contactsToUpdate;
        }
    }

}