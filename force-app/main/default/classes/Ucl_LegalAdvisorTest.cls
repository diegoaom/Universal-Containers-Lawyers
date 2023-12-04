@isTest
private class Ucl_LegalAdvisorTest {
  @isTest
  static void testUclLegalAdvisor() {
    Map<String, Object> advisorData = new Map<String, Object>{
      'AccountNumber' => '12345',
      'AccountName' => 'UCL',
      'AccountStatus' => 'Enabled',
      'AsOfDate' => '2/20/2022',
      'Clients' => new List<Object>{
        new Map<String, Object>{
            'FirstName' => 'Diego',
            'LastName' => 'Olivieri',
            'Email' => 'algo@gmail.com',
            'Phone' => '123456789',
            'Address' => 'Somewhere 123',
            'ClientNumber' => 'asdasd-123-asdasd'
          }
      }
    };

    Ucl_LegalAdvisor legalAdvisor = new Ucl_LegalAdvisor(advisorData);

    System.assertEquals('12345', legalAdvisor.accountNumber, 'Account Number does not match');
    System.assertEquals('UCL', legalAdvisor.accountName, 'Account Name does not match');
    System.assertEquals('Enabled', legalAdvisor.accountStatus, 'Account Status does not match');
    System.assertEquals(Date.valueOf('2022-02-20'), legalAdvisor.asOfDate, 'As of Date does not match');

    System.assertNotEquals(null, legalAdvisor.clients, 'Clients list should not be empty');
    System.assertEquals(1, legalAdvisor.clients.size(), 'Clients list should have only 1 element');

    Ucl_Client client = legalAdvisor.clients[0];
    System.assertEquals('Diego', client.firstName, 'First Name does not match');
    System.assertEquals('Olivieri', client.lastName, 'Last Name does not match');
    System.assertEquals('algo@gmail.com', client.email, 'Email does not match');
    System.assertEquals('123456789', client.phone, 'Phone does not match');
    System.assertEquals('Somewhere 123', client.address, 'Address does not match');
    System.assertEquals('asdasd-123-asdasd', client.clientNumber,'ClientNumber does not match');
  }
}
