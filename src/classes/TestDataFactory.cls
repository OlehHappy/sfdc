@isTest
public class TestDataFactory {
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();

        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;

        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;

        return accts;
    }

    public static List<Account> createAccountsWithContacts(Integer accountsNum, Integer contactsNum) {
        List<Account> accountsList = new List<Account>();
        for (Integer i = 0; i < accountsNum; i++) {
            Account a = new Account(Name='Test Account ' + i);
            accountsList.add(a);
        }

        insert accountsList;

        List<Contact> contactsList = new List<Contact>();
        for (Account a : accountsList) {
            for (Integer i = 0; i < contactsNum; i++) {
                Contact c = new Contact(AccountId = a.Id,
                                        LastName = a.Name,
                                        FirstName = 'Test' + i);
                contactsList.add(c);
            }
        }

        insert contactsList;

        return accountsList;
    }
}