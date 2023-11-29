public with sharing class Ucl_RestCallout {
  public Map<String, Ucl_LegalAdvisor> getData() {
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
        System.debug(legalAdvisorMap);
        return legalAdvisorMap;
      } else {
        System.debug(
          'Error: ' + response.getStatusCode() + ' - ' + response.getStatus()
        );
        System.debug('Response: ' + response.getBody());
        Ucl_ErrorHandlingUtils.sendErrorEmail(
          'Error: ' + response.getStatusCode() + ' - ' + response.getStatus(),
          'Response: ' + response.getBody()
        );
      }
    } catch (Exception e) {
      System.debug('Exception: ' + e.getMessage());
      Ucl_ErrorHandlingUtils.sendErrorEmail(
        'Exception',
        'Exception: ' + e.getMessage()
      );
    }

    return legalAdvisorMap;
  }
}
