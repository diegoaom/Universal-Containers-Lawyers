public with sharing class Ucl_EmailNotificationManager {
  public static void sendErrorEmail(String subject, String body) {
    List<User> systemAdminsEmails = [SELECT Email FROM User WHERE Profile.Name = 'System Administrator'];

    List<Messaging.SingleEmailMessage> emailsList = new List<Messaging.SingleEmailMessage>();

    for (User admin : systemAdminsEmails) {
      Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
      String[] toAddresses = new List<String>{ admin.Email };
      email.setToAddresses(toAddresses);
      email.setSubject(subject);
      email.setPlainTextBody(body);

      emailsList.add(email);
    }

    Messaging.sendEmail(emailsList);
  }
}
