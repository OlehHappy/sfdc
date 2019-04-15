public class ProjectsListController {
    private static ProjectServices services = new ProjectServices();
    
    @AuraEnabled
    public static List<Project__c> getProjectsList(Integer offSetVal) {
        try {
	        return services.getProjectList(offSetVal);            
        } catch (Exception ex) {
            System.debug('Exception in ProjectsListController.getProjectsList ERROR: ' + ex.getMessage());
            System.debug('ProjectsListController.getProjectsList Exception TRACE: ' + ex.getStackTraceString());

            AuraHandledException auraException = new AuraHandledException(ex.getMessage());
            auraException.setMessage(ex.getMessage());
            throw auraException;
        }
    }

    @AuraEnabled
    public static List<Project__c> changeProjectsOwner(List<Id> projectIds, Id userId, Integer offSetVal) {
        Set<Id> projectIdSet = new Set<Id>(projectIds);
        List<Project__c> projectList = new List<Project__c>();
        for (Id projectId : projectIdSet) {
            Project__c proj = new Project__c();
            proj.Id = projectId;
            proj.User__c = userId;

            projectList.add(proj);
        }

        try {
	        services.updateProjects(projectList);            

            return services.getProjectList(offSetVal);
        } catch (Exception ex) {
            System.debug('Exception in ProjectsListController.getProjectsList ERROR: ' + ex.getMessage());
            System.debug('ProjectsListController.getProjectsList Exception TRACE: ' + ex.getStackTraceString());

            AuraHandledException auraException = new AuraHandledException(ex.getMessage());
            auraException.setMessage(ex.getMessage());
            throw auraException;
        }
    }
}