public class ProjectServices {
    
    public List<Project__c> getProjectList(Integer offSetVal) {
        
        return [SELECT Name, Priority__c, OwnerId 
                FROM Project__c 
                LIMIT 20 
                OFFSET :offSetVal];
    }

}