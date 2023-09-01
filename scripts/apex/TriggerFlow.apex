// Generate a unique timestamp
String uniqueTimestamp = DateTime.now().format('yyyyMMddHHmmss');

// Create a new Lead record
Lead newLead = new Lead(
    LastName = 'Doe' + uniqueTimestamp,
    Company = 'TestCo' + uniqueTimestamp
);
insert newLead;

// Fetch the default converted status
String convertedStatus = [SELECT MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1].MasterLabel;

// Prepare for lead conversion
Database.LeadConvert lc = new Database.LeadConvert();
lc.setLeadId(newLead.Id);
lc.setConvertedStatus(convertedStatus);
lc.setDoNotCreateOpportunity(true);

// Convert the lead
Database.LeadConvertResult lcr = Database.convertLead(lc);
