public with sharing class Ucl_UpdateLegalAdvisorStatus {
  public void updateLegalAdvisorStatus(Map<String, Ucl_LegalAdvisor> fetchedData) {
    List<String> disabledAccountNumbers = new List<String>();
    List<Legal_Advisor__c> legalAdvisorsToUpdate = new List<Legal_Advisor__c>();

    for (Ucl_LegalAdvisor advisor : fetchedData.values()) {
      if (advisor.accountStatus == 'Disabled') {
        disabledAccountNumbers.add(advisor.accountNumber);
      }
    }

    if (!disabledAccountNumbers.isEmpty()) {
      String soslFindClause = '{' + String.join(disabledAccountNumbers, ' OR ') + '}';
      List<Legal_Advisor__c> searchList = [
        SELECT Id, Account_Number__c, Account_Status__c
        FROM Legal_Advisor__c
        WHERE Account_Number__c IN :disabledAccountNumbers
          AND Account_Status__c = 'Enabled'
      ];

      for (Legal_Advisor__c legalAdvisor : searchList) {
        legalAdvisor.Account_Status__c = 'Disabled';
        legalAdvisorsToUpdate.add(legalAdvisor);
      }

      if (!legalAdvisorsToUpdate.isEmpty()) {
        try {
          update legalAdvisorsToUpdate;
        } catch (DmlException e) {
          Ucl_ErrorLogManager errorLogManager = new Ucl_ErrorLogManager();
          errorLogManager.logError('Exception', 'Exception: ' + e.getMessage(), 'Ucl_UpdateLegalAdvisorStatus > updateLegalAdvisorStatus()');

          Ucl_EmailNotificationManager.sendErrorEmail(
            'Exception: in updateLegalAdvisorStatus',
            'Exception: ' + e.getMessage()
          );
        }
      }
    }
  }
}