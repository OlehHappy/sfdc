public class backend {

    @AuraEnabled
    public static Map<String, String> init() {
        Map<String, String> result = new Map<String, String>();
        result.put('Id', '12312312312312');
        result.put('Request_Type__c', 'New Vendor');
        result.put('Title__c', 'Test Title');
        result.put('Name', 'M - 00001');
        
        return result;
    }

}