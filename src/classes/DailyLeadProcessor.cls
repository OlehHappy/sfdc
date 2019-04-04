global class DailyLeadProcessor implements Schedulable {
    @TestVisible private final String DREAMFORCE_STR = 'Dreamforce';

    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [SELECT LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
        List<Lead> leadsToUpdate = new List<Lead>();

        for (Lead l : leads) {
            l.LeadSource = DREAMFORCE_STR;
            leadsToUpdate.add(l);
        }
        update leadsToUpdate;
    }

}