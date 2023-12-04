@isTest
private class Ucl_ClientTest {

    @isTest
    static void testUclClient() {
        Map<String, Object> testClient = new Map<String, Object>{
            'FirstName' => 'Diego',
            'LastName' => 'Olivieri',
            'Email' => 'algo@gmail.com',
            'Phone' => '123456789',
            'Address' => 'Somewhere 123',
            'ClientNumber' => 'asdasd-123-asdasd'
        };

        Ucl_Client uclClient = new Ucl_Client(testClient);

        System.assertEquals('Diego', uclClient.firstName, 'First Name does not match');
        System.assertEquals('Olivieri', uclClient.lastName, 'Last Name does not match');
        System.assertEquals('algo@gmail.com', uclClient.email, 'Email does not match');
        System.assertEquals('123456789', uclClient.phone, 'Phone does not match');
        System.assertEquals('Somewhere 123', uclClient.address, 'Address does not match');
        System.assertEquals('asdasd-123-asdasd', uclClient.clientNumber, 'ClientNumber does not match');
    }
}