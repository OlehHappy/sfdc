public class ProjectServices {
    
    public List<Project__c> getProjectList(Integer offSetVal) {
        
        return [SELECT Name, Priority__c, User__r.Name,  User__c 
                FROM Project__c 
                LIMIT 20 
                OFFSET :offSetVal];
    }

    public void updateProjects(List<Project__c> projectList) {
        update projectList;
    }
}