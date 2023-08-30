@isTest
public class AutoConvertLeadHandlerTest {
    @isTest static void testAutoConvertLead() {
        // Create a test lead
        Lead testLead = new Lead(LastName='Doe', Company='TestCo', cbit__ClearbitReady__c=true);
        insert testLead;
        
        // Run the trigger or handler
        Test.startTest();
        AutoConvertLeadHandler handler = new AutoConvertLeadHandler();
        handler.autoConvertLeads(new List<Lead>{testLead});
        Test.stopTest();
        
        // Validate the lead was converted
        Lead convertedLead = [SELECT IsConverted FROM Lead WHERE Id = :testLead.Id];
        System.assert(convertedLead.IsConverted);
    }
}
