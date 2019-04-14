public class NewCaseListController {

    public List<Case> getNewCases() {

        return [SELECT CaseNumber FROM Case WHERE Status = 'New'];
    }
}