@isTest
private class Ucl_UpsertManagerTest {
  
    @isTest
    static void testUpsertLegalAdvisors() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getJsonData');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        Ucl_UpsertManager upsertManager = new Ucl_UpsertManager();
        Map<String, List<Ucl_Client>> clientsByLegalAdvisor = upsertManager.upsertLegalAdvisors(legalAdvisorMap);

        List<Legal_Advisor__c> legalAdvisorsUpserted = [SELECT Name, Account_Number__c, Account_Status__c FROM Legal_Advisor__c ORDER BY CreatedDate DESC LIMIT 1];
        Legal_Advisor__c legalAdvisor = legalAdvisorsUpserted[0];
        System.assertEquals('Riffpath', legalAdvisor.Name, 'Legal Advisor Name does not match');

        System.assertNotEquals(null, clientsByLegalAdvisor, 'Result should not be null');

    }

    @isTest
    static void testUpsertClients() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getJsonData');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        Ucl_UpsertManager upsertManager = new Ucl_UpsertManager();

        Map<String, List<Ucl_Client>> clientsByLegalAdvisor = upsertManager.upsertLegalAdvisors(legalAdvisorMap);

        upsertManager.upsertClients(clientsByLegalAdvisor);

        List<Client__c> clientsUpserted = [SELECT First_Name__c FROM Client__c ORDER BY First_Name__c LIMIT 1];
        Client__c client = clientsUpserted[0];
        System.assertEquals('Abbye', client.First_Name__c, 'Client First Name does not match');
    }



}