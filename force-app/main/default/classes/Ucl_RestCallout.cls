public with sharing class Ucl_RestCallout {
  @AuraEnabled
  public static Map<String, Ucl_LegalAdvisor> getData() {
    Map<String, Ucl_LegalAdvisor> legalAdvisorMap = new Map<String, Ucl_LegalAdvisor>();

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(
      'https://altimetrik-bootcamp.herokuapp.com/LegalAccounts'
    );
    request.setMethod('GET');

    try {
      HttpResponse response = http.send(request);
      if (response.getStatusCode() == 200) {
        List<Object> results = (List<Object>) JSON.deserializeUntyped(
          response.getBody()
        );

        for (Object result : results) {
          Ucl_LegalAdvisor advisor = new Ucl_LegalAdvisor(
            (Map<String, Object>) result
          );

          legalAdvisorMap.put(advisor.accountNumber, advisor);
        }
        return legalAdvisorMap;
      } else {
        Ucl_ErrorLogManager errorLogManager = new Ucl_ErrorLogManager();
        errorLogManager.logError('Error', 'Error: ' + response.getStatusCode() + ' - ' + response.getStatus(), 'Ucl_RestCallout > getData()');

        Ucl_EmailNotificationManager.sendErrorEmail(
          'Error: ' + response.getStatusCode() + ' - ' + response.getStatus(),
          'Response: ' + response.getBody()
        );

      }
    } catch (Exception e) {
      Ucl_ErrorLogManager errorLogManager = new Ucl_ErrorLogManager();
      errorLogManager.logError('Exception', 'Exception: ' + e.getMessage(), 'Ucl_RestCallout > getData()');

      Ucl_EmailNotificationManager.sendErrorEmail(
        'Exception',
        'Exception: ' + e.getMessage()
      );
    }

    return legalAdvisorMap;
  }
}
