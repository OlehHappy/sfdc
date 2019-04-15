public class UserLookupController {

    @AuraEnabled(cacheable=true) 
    public static List<RecordWrapper> getUsersByName(String searchString) {
        List<RecordWrapper> recordsDataList = new List<RecordWrapper>();

        try {
	        String query = 'SELECT Id, Name'
                        + ' FROM User'
                        + ' WHERE Name'
                        + ' LIKE ' + '\'' + String.escapeSingleQuotes(searchString.trim()) + '%\'' + ' LIMIT 50000';

	        for(SObject s : Database.query(query)){
	            RecordWrapper recordData = new RecordWrapper();
	            recordData.userId = String.valueOf(s.get('Id'));
	            recordData.userName = String.valueOf(s.get('Name'));
	            recordsDataList.add(recordData);
	        } 
	    } catch (Exception ex) {
	    	if (String.isNotBlank(ex.getMessage()) && ex.getMessage().contains( 'error:' )) {
                throw new AuraHandledException(ex.getMessage().split('error:')[1].split(':')[0] + '.');
            } else {
                throw new AuraHandledException(ex.getMessage());
            }
	    }
        
        return recordsDataList;
    }

    public class RecordWrapper {
        @AuraEnabled public String userId {get;set;}
        @AuraEnabled public String userName {get;set;}
    }
}