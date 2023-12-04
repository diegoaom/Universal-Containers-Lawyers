@isTest
private class Ucl_ScheduledDataProcessorTest {

    @isTest
    static void testScheduledDataProcessor() {
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getJsonData');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();

        Ucl_ScheduledDataProcessor sch = new Ucl_ScheduledDataProcessor();
        sch.execute(null);

        Test.stopTest();

        List<Legal_Advisor__c> resultRecords = [SELECT Id FROM Legal_Advisor__c LIMIT 2];
        System.assertEquals(false, resultRecords.isEmpty(), 'Legal Advisors records should not be empty');

    }
}
