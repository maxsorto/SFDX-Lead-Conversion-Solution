@isTest
public class AutoConvertLeadSchedulerTest {
    @isTest static void testAutoConvertLeadScheduler() {
        // Prepare test data: Create an account and property for matching
        Account testAccount = new Account(Name='Test Account', FlagCompanyId__c='12345');
        insert testAccount;

        Property__c testProperty = new Property__c(DomainName__c='testco.com', Account__c=testAccount.Id);
        insert testProperty;

        // Create a lead with ClearbitReady set to true and matching Flag Company ID
        Lead testLead = new Lead(LastName='Doe', Company='TestCo', cbit__ClearbitReady__c=true, Flag_Company_ID__c='12345', Website='testco.com');
        insert testLead;

        // Validate that the lead was inserted and is not converted
        System.assert(testLead.Id != null);
        System.assert(testLead.IsConverted == false);

        // Start the test context
        Test.startTest();

        // Schedule the job
        String cron = '0 0 * * * ?';
        AutoConvertLeadScheduler scheduler = new AutoConvertLeadScheduler();
        System.schedule('Test_Scheduler', cron, scheduler);

        // Stop the test context
        Test.stopTest();

        // Fetch the updated lead record from the database
        Lead convertedLead = [SELECT IsConverted, ConvertedAccountId FROM Lead WHERE Id = :testLead.Id];

        // Validate that the lead was successfully converted and matched to the correct account
        System.assert(convertedLead.IsConverted, 'The lead should be converted');
        System.assertEquals(testAccount.Id, convertedLead.ConvertedAccountId, 'The lead should be converted to the correct account');
    }
}
