public class AutoConvertLeadScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        // Query for Leads that are ready to be converted
        List<Lead> leadsToConvert = [
            SELECT Id, LastName, Company, cbit__ClearbitReady__c, Flag_Company_ID__c, Website
            FROM Lead
            WHERE cbit__ClearbitReady__c = true AND IsConverted = false
        ];

        if (!leadsToConvert.isEmpty()) {
            AutoConvertLeadHandler handler = new AutoConvertLeadHandler();
            handler.autoConvertLeads(leadsToConvert);
        }
    }
}
