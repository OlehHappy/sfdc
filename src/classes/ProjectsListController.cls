public class ProjectsListController {
    
    @AuraEnabled
    public static List<Project__c> getProjectsList(Integer offSetVal) {
        try {
	        return new ProjectServices().getProjectList(offSetVal);            
        } catch (Exception ex) {
            System.debug('Exception in ProjectsListController.getProjectsList ERROR: ' + ex.getMessage());
            System.debug('ProjectsListController.getProjectsList Exception TRACE: ' + ex.getStackTraceString());

            AuraHandledException auraException = new AuraHandledException(ex.getMessage());
            auraException.setMessage(ex.getMessage());
            throw auraException;
        }
    }

    @AuraEnabled
    public static void changeProjectsOwner(List<Id> projectIds) {
        Set<Id> projectIdSet = new Set<Id>(projectIds);
        System.debug('olehdebug >>> projectIdSet: ' + projectIdSet);
    }

}