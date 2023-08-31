public class AutoConvertLeadHandler {
    public void autoConvertLeads(List<Lead> leads) {
        List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
        
        // Fetch the default converted status
        String convertedStatus = [SELECT MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1].MasterLabel;
        
        // Debug statement to print the value of convertedStatus
        System.debug('Converted Status: ' + convertedStatus);
        
        // Fetch existing accounts to match based on Flag Company ID or Domain Name
        Map<String, Id> flagCompanyIDToAccountMap = new Map<String, Id>();
        Map<String, Id> domainNameToAccountMap = new Map<String, Id>();
        
        for (Account acc : [SELECT Id, FlagCompanyId__c FROM Account WHERE FlagCompanyId__c != null]) {
            flagCompanyIDToAccountMap.put(acc.FlagCompanyId__c, acc.Id);
        }
        
        for (Property__c prop : [SELECT Account__c, DomainName__c FROM Property__c WHERE DomainName__c != null]) {
            domainNameToAccountMap.put(prop.DomainName__c, prop.Account__c);
        }
        
        for (Lead lead : leads) {
            if (lead.cbit__ClearbitReady__c == true) {
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(lead.Id);
                lc.setConvertedStatus(convertedStatus);  // Set the converted status here
                lc.setDoNotCreateOpportunity(true); // As per your requirement
                
                // Account matching logic
                if (flagCompanyIDToAccountMap.containsKey(lead.Flag_Company_ID__c)) {
                    lc.setAccountId(flagCompanyIDToAccountMap.get(lead.Flag_Company_ID__c));
                } else if (domainNameToAccountMap.containsKey(lead.Website)) {
                    lc.setAccountId(domainNameToAccountMap.get(lead.Website));
                }
                
                leadConverts.add(lc);
            }
        }
        
        if (!leadConverts.isEmpty()) {
            try {
                List<Database.LeadConvertResult> lcr = Database.convertLead(leadConverts);
                // Log successful conversions
                System.debug('Lead conversion successful: ' + lcr);
            } catch (Exception e) {
                // Log any exceptions
                System.debug('Lead conversion failed: ' + e.getMessage());
            }
        }
    }
}
