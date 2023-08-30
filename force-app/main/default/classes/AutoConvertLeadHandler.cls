public class AutoConvertLeadHandler {
    public void autoConvertLeads(List<Lead> leads) {
        List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
        
        for (Lead lead : leads) {
            if (lead.cbit__ClearbitReady__c == true) {
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(lead.Id);
                lc.setDoNotCreateOpportunity(true); // As per your requirement
                leadConverts.add(lc);
            }
        }
        
        if (!leadConverts.isEmpty()) {
            List<Database.LeadConvertResult> lcr = Database.convertLead(leadConverts);
            // Add error handling and logging here
        }
    }
}
