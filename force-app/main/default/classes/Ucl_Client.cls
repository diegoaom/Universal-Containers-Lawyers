public with sharing class Ucl_Client {
    public String firstName;
    public String lastName;
    public String email;
    public String phone;
    public String address;
    public String clientNumber;

    public Ucl_Client(Map<String, Object> data) {

        this.firstName = (String) data.get('FirstName');
        this.lastName = (String) data.get('LastName');
        this.email = (String) data.get('Email');
        this.phone = (String) data.get('Phone');
        this.address = (String) data.get('Address');
        this.clientNumber = (String) data.get('ClientNumber');
    }
}