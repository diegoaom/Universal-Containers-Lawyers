@isTest
private class Ucl_RestCalloutTest {
    @isTest 
    static void testGetCallout() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getJsonData');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        system.assertEquals(21, legalAdvisorMap.size(), 'The map should contain 21 elements');
    }   

    @isTest
    static void testGetCalloutError() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getJsonData');
        mock.setStatusCode(400);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        system.assertEquals(0, legalAdvisorMap.size(), 'Failure should return an empty map');

        List<Error_Log__c> errorLogs = [SELECT Name, Location__c FROM Error_Log__c ORDER BY CreatedDate DESC LIMIT 1];
        System.assertEquals(1, errorLogs.size(), 'An error log should be created');
        
        Error_Log__c errorLog = errorLogs[0];
        System.assertEquals('Error', errorLog.Name, 'Error Name should be an error');
        System.assertEquals('Ucl_RestCallout > getData()', errorlog.Location__c, 'Error Location does not match');
    }

    @isTest
    static void testGetCalloutException() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('ExceptionForTesting');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        system.assertEquals(0, legalAdvisorMap.size(), 'Failure should return an empty map');

        List<Error_Log__c> errorLogs = [SELECT Name, Location__c FROM Error_Log__c ORDER BY CreatedDate DESC LIMIT 1];
        System.assertEquals(1, errorLogs.size(), 'An error log should be created');
        
        Error_Log__c errorLog = errorLogs[0];
        System.assertEquals('Exception', errorLog.Name, 'Error Name should be an exception');
        System.assertEquals('Ucl_RestCallout > getData()', errorlog.Location__c, 'Error Location does not match');
    }
}
