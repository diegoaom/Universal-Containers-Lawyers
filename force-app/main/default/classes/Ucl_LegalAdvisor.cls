public class Ucl_LegalAdvisor {
  public String accountNumber;
  public String accountName;
  public String accountStatus;
  public String asOfDate;
  public List<Clients> clients;

  public class Clients {
    public String firstName;
    public String lastName;
    public String email;
    public String phone;
    public String address;
    public String clientNumber;
  }

  public static List<Ucl_LegalAdvisor> parse(String json) {
    return (List<Ucl_LegalAdvisor>) System.JSON.deserialize(
      json,
      List<Ucl_LegalAdvisor>.class
    );
  }
}
