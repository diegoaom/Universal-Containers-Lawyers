@isTest
private class Ucl_ErrorLogManagerTest {

    @isTest
    static void testLogError() {

        Ucl_ErrorLogManager errorLogManager = new Ucl_ErrorLogManager();
        errorLogManager.logError('Test Exception', 'Test error message', 'Test Location');

        List<Error_Log__c> errorLogs = [SELECT Id FROM Error_Log__c WHERE Name = 'Test Exception'];
        System.assertEquals(1, errorLogs.size(), 'Error Log record should be inserted');
    }
}
