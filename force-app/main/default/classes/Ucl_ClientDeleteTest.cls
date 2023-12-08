@isTest
private class Ucl_ClientDeleteTest {

    @isTest
    static void testClientDelete() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getJsonData');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        StaticResourceCalloutMock secondMock = new StaticResourceCalloutMock();
        secondMock.setStaticResource('getJsonDataWithoutAmi');
        secondMock.setStatusCode(200);
        secondMock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, secondMock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMapWithoutAmi = Ucl_RestCallout.getData();

        Ucl_UpsertManager upsertManager = new Ucl_UpsertManager();
        Map<String, List<Ucl_Client>> clientsByLegalAdvisor = upsertManager.upsertLegalAdvisors(legalAdvisorMap);
        upsertManager.upsertClients(clientsByLegalAdvisor);

        Ucl_ClientDelete deleteManager = new Ucl_ClientDelete();
        deleteManager.clientDelete(legalAdvisorMapWithoutAmi);

        List<Client__c> amiClient = [SELECT Id FROM Client__c WHERE Client_Key__c = 'a209ebbb-39c6-4852-8732-82237c0674fb055db4ba-992c-46bf-80fc-5c9f1cd35287'];
        System.assertEquals(0, amiClient.size(), 'Client should have been deleted');
    }

    @isTest
    static void testNoClientToDelete() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getJsonData');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        StaticResourceCalloutMock secondMock = new StaticResourceCalloutMock();
        secondMock.setStaticResource('getJsonDataWithAmiDuplicated');
        secondMock.setStatusCode(200);
        secondMock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, secondMock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorDuplicatedAmi = Ucl_RestCallout.getData();

        Ucl_UpsertManager upsertManager = new Ucl_UpsertManager();
        Map<String, List<Ucl_Client>> clientsByLegalAdvisor = upsertManager.upsertLegalAdvisors(legalAdvisorMap);
        upsertManager.upsertClients(clientsByLegalAdvisor);

        Ucl_ClientDelete deleteManager = new Ucl_ClientDelete();

        try {
            deleteManager.clientDelete(legalAdvisorDuplicatedAmi);
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('DUPLICATE_VALUE'), 'Expected DML exception for duplicate record');
        }

    }
}