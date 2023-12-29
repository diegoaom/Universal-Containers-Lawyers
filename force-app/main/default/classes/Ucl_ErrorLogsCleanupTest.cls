@isTest
private class Ucl_ErrorLogsCleanupTest {
    
    @isTest
    static void testErrorLogsCleanup() {
        Error_Log__c testErrorLog = new Error_Log__c(
            Name = 'Test Error',
            Timestamp__c = System.today().addMonths(-1).addDays(-1) 
        );
        insert testErrorLog;

        Date oneMonthAgo = System.today().addMonths(-1);

        List<Error_Log__c> initialErrorLogs = [SELECT Id FROM Error_Log__c WHERE Timestamp__c < :oneMonthAgo];
        System.assertEquals(false, initialErrorLogs.isEmpty(), 'There should by at least one error log from one month ago');

        Test.startTest();

        Ucl_ErrorLogsCleanup  sch = new Ucl_ErrorLogsCleanup ();
        sch.execute(null);

        Test.stopTest();

        List<Error_Log__c> finalErrorLogs = [SELECT Id FROM Error_Log__c WHERE Timestamp__c < :oneMonthAgo];
        System.assertEquals(0, finalErrorLogs.size(), 'There should not be any error log from one month ago');
    }
}
