public with sharing class Ucl_LegalAdvisor {
  public String accountNumber;
  public String accountName;
  public String accountStatus;
  public Date asOfDate;
  public List<Ucl_Client> clients;

  public Ucl_LegalAdvisor(Map<String, Object> advisorData) {
      String key = (String) advisorData.get('AccountNumber');

      List<Object> clientsData = (List<Object>) advisorData.get('Clients');
      clients = new List<Ucl_Client>(); 

      for (Object clientData : clientsData) {
          clients.add(new Ucl_Client((Map<String, Object>) clientData));
      }

      accountNumber = (String) advisorData.get('AccountNumber');
      accountName = (String) advisorData.get('AccountName');
      accountStatus = (String) advisorData.get('AccountStatus');
      String asOfDateString = (String) advisorData.get('AsOfDate');

      List<String> dateParts = asOfDateString.split('/');
      String formattedDate = dateParts[2] + '-' + dateParts[0] + '-' + dateParts[1];
      asOfDate = Date.valueOf(formattedDate);
  }
}
