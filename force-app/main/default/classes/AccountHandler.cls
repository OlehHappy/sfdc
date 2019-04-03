public class AccountHandler {

    public static Account insertNewAccount(String param) {
        try {
        	Account acc = new Account(Name=param);
        	insert acc;
            
            return acc;
        } catch (DmlException e) {
            System.debug('A DML exception has occurred: ' + e.getMessage());
            return null;
        }
        
        
    }
}