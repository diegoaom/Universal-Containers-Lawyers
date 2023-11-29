public with sharing class Ucl_ErrorHandlingUtils {
  public static void sendErrorEmail(String subject, String body) {
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    String[] toAddresses = new List<String>{ 'diegoolivierivii@gmail.com' };
    email.setToAddresses(toAddresses);
    email.setSubject(subject);
    email.setPlainTextBody(body);

    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });
  }
}
