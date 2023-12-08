public with sharing class Ucl_UpsertManager {
    
  public Map<String, List<Ucl_Client>> upsertLegalAdvisors(Map<String, Ucl_LegalAdvisor> fetchedData) {
    List<Legal_Advisor__c> legalAdvisorsToUpsert = new List<Legal_Advisor__c>();
    Map<String, List<Ucl_Client>> clientsByLegalAdvisor = new Map<String, List<Ucl_Client>>();

    for (Ucl_LegalAdvisor advisor : fetchedData.values()) {
      if (advisor.accountStatus == 'Enabled') {
        Legal_Advisor__c legalAdvisor = new Legal_Advisor__c(
          Account_Number__c = advisor.accountNumber,
          Name = advisor.accountName,
          Account_Status__c = advisor.accountStatus,
          As_of_Date__c = advisor.asOfDate
        );
        legalAdvisorsToUpsert.add(legalAdvisor);
        clientsByLegalAdvisor.put(advisor.accountNumber, advisor.clients);
      }
    }

    try {
      upsert legalAdvisorsToUpsert Account_Number__c;
      return clientsByLegalAdvisor;
    } catch (DmlException e) {
      Ucl_ErrorLogManager errorLogManager = new Ucl_ErrorLogManager();
      errorLogManager.logError('Exception', 'Exception: ' + e.getMessage(), 'Ucl_UpsertManager > upsertLegalAdvisors()');

      Ucl_EmailNotificationManager.sendErrorEmail(
          'Exception: in upsertLegalAdvisors',
          'Exception: ' + e.getMessage()
        );

      return null;
    }
  }

  public void upsertClients(Map<String, List<Ucl_Client>> clientsEnabledMap) {
    List<Client__c> clientsToUpsert = new List<Client__c>();

    List<Legal_Advisor__c> legalAdvisorsUpserted = [SELECT Id, Account_Number__c FROM Legal_Advisor__c WHERE Account_Number__c IN :clientsEnabledMap.keySet()];

  Map<String, Id> externalIdToRecordIdMap = new Map<String, Id>();
  for (Legal_Advisor__c legalAdvisor : legalAdvisorsUpserted) {
      externalIdToRecordIdMap.put(legalAdvisor.Account_Number__c, legalAdvisor.Id);
  }

  for (String legalAdvisorExternalId : clientsEnabledMap.keySet()) {
      List<Ucl_Client> clients = clientsEnabledMap.get(legalAdvisorExternalId);

      for (Ucl_Client client : clients) {
          Id legalAdvisorRecordId = externalIdToRecordIdMap.get(legalAdvisorExternalId);
          Client__c clientRecord = new Client__c(
              Legal_Advisor__c = legalAdvisorRecordId,
              First_Name__c = client.firstName,
              Last_Name__c = client.lastName,
              Email__c = client.email,
              Phone__c = client.phone,
              Address__c = client.address,
              Client_Number__c = client.clientNumber,
              Name = client.firstName + ' ' + client.lastName,
              Client_Key__c = legalAdvisorExternalId + client.clientNumber
          );

          clientsToUpsert.add(clientRecord);
      }
  }

    try {
      upsert clientsToUpsert Client_Key__c;
    } catch (DmlException e) {
      
      Ucl_ErrorLogManager errorLogManager = new Ucl_ErrorLogManager();
      errorLogManager.logError('Exception', 'Exception: ' + e.getMessage(), 'Ucl_UpsertManager > upsertClients()');


      Ucl_EmailNotificationManager.sendErrorEmail(
          'Exception: in upsertClients',
          'Exception: ' + e.getMessage()
      );
    }
  }
}