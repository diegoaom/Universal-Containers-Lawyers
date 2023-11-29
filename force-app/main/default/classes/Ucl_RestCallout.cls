public with sharing class Ucl_RestCallout {

    public List<Ucl_LegalAdvisor> getData() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        request.setMethod('GET');

        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                System.debug(Ucl_LegalAdvisor.parse(response.getBody()));
                return Ucl_LegalAdvisor.parse(response.getBody());
            } else {
                System.debug('Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
                System.debug('Response: ' + response.getBody());
                Ucl_ErrorHandlingUtils.sendErrorEmail('Error: ' + response.getStatusCode() + ' - ' + response.getStatus(), 'Response: ' + response.getBody());

            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
            Ucl_ErrorHandlingUtils.sendErrorEmail('Excepction', 'Exception: ' + e.getMessage());
        }

        return new List<Ucl_LegalAdvisor>();
    }
}