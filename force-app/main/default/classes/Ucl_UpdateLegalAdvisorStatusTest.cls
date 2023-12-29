@isTest
private class Ucl_UpdateLegalAdvisorStatusTest {

    @isTest
    static void testUpdateLegalAdvisorStatus() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getJsonData');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Map<String, Ucl_LegalAdvisor> legalAdvisorMap = Ucl_RestCallout.getData();

        Legal_Advisor__c testLegalAdvisor = new Legal_Advisor__c(
            Account_Number__c = 'd0145909-0028-47a4-8f85-8f8b50e7c08e',
            Account_Status__c = 'Enabled',
            As_of_Date__c = Date.valueOf('2019-6-9')
        );
        insert testLegalAdvisor;

        Ucl_UpdateLegalAdvisorStatus updateManager = new Ucl_UpdateLegalAdvisorStatus();
        updateManager.updateLegalAdvisorStatus(legalAdvisorMap);

        Legal_Advisor__c updatedLegalAdvisor = [SELECT Id, Account_Status__c FROM Legal_Advisor__c WHERE Account_Number__c = 'd0145909-0028-47a4-8f85-8f8b50e7c08e'];
        System.assertEquals('Disabled', updatedLegalAdvisor.Account_Status__c, 'Legal Advisor Account Status should be Disabled');
    }
}