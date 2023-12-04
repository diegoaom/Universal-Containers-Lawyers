public with sharing class Ucl_Client {
    public String firstName;
    public String lastName;
    public String email;
    public String phone;
    public String address;
    public String clientNumber;

    public Ucl_Client(Map<String, Object> data) {

        firstName = (String) data.get('FirstName');
        lastName = (String) data.get('LastName');
        email = (String) data.get('Email');
        phone = (String) data.get('Phone');
        address = (String) data.get('Address');
        clientNumber = (String) data.get('ClientNumber');
    }
}