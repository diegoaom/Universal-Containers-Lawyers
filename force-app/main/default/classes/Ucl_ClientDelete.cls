public with sharing class Ucl_ClientDelete {
  public void clientDelete(Map<String, Ucl_LegalAdvisor> fetchedData) {
    List<String> incomingClients = new List<String>();

    for (Ucl_LegalAdvisor legalAdvisor : fetchedData.values()) {
      if (legalAdvisor.accountStatus == 'Enabled') {
        for (Ucl_Client client : legalAdvisor.clients) {
            incomingClients.add(legalAdvisor.accountNumber + client.clientNumber);
        }
      }
    }

    List<Client__c> clientsToDelete = [SELECT Id FROM Client__c WHERE Client_Key__c NOT IN :incomingClients
     AND Created_by_Admin__c = false];

    if (!clientsToDelete.isEmpty()) {
      try {
        delete clientsToDelete;
      } catch (DmlException e) {
        Ucl_ErrorLogManager errorLogManager = new Ucl_ErrorLogManager();
        errorLogManager.logError('Exception', 'Exception: ' + e.getMessage(), 'Ucl_ClientDelete > clientDelete()');

        Ucl_EmailNotificationManager.sendErrorEmail(
          'Exception: in clientDelete',
          'Exception: ' + e.getMessage()
        );
        
      }
    }
  }
}

