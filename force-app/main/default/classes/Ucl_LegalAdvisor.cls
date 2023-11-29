public with sharing class Ucl_LegalAdvisor {
  public String accountNumber;
  public String accountName;
  public String accountStatus;
  public Date asOfDate;
  public List<Ucl_Client> clients;

  public Ucl_LegalAdvisor(Map<String, Object> advisorData) {
    String key = (String) advisorData.get('AccountNumber');

    List<Object> clientsData = (List<Object>) advisorData.get('Clients');
    List<Ucl_Client> clients = new List<Ucl_Client>();
    for (Object clientData : clientsData) {
      clients.add(new Ucl_Client((Map<String, Object>) clientData));
    }

    this.accountNumber = (String) advisorData.get('AccountNumber');
    this.accountName = (String) advisorData.get('AccountName');
    this.accountStatus = (String) advisorData.get('AccountStatus');
    String asOfDateString = (String) advisorData.get('AsOfDate');

    List<String> dateParts = asOfDateString.split('/');
    String formattedDate =
      dateParts[2] +
      '-' +
      dateParts[0] +
      '-' +
      dateParts[1];
    this.asOfDate = Date.valueOf(formattedDate);

    this.clients = clients;

  }
}
