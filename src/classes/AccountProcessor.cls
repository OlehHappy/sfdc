public with sharing class AccountProcessor {

    @future
    public static void countContacts(List<Id> accountIds) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Account a : [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN :accountIds]) {
            Integer contactsNum = [SELECT COUNT() FROM Contact WHERE AccountId = :a.Id];
            a.Number_of_Contacts__c = contactsNum;
            accountsToUpdate.add(a);
        }

//        try {
            update accountsToUpdate;
//        } catch (DmlException de) {
//            for (Integer i = 0; i < de.getNumDml(); i++) {
//                System.debug('There is an ERROR during update an Accounts in AccountProcessor.countContacts method.' +
//                        ' >>> ERROR: ' + de.getDmlMessage(i));
//                throw new DmlException(de.getDmlMessage(i));
//            }
//        }
    }

}