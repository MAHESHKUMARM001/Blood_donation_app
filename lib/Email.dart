
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {

  static Future<void> sendEmail(String recipientEmail, String subject, String body) async {
    final String senderEmail = '953621104025@ritrjpm.ac.in'; // Replace with your email
    final String senderPassword = 'mahesh001M'; // Replace with your password

    final smtpServer = gmail(senderEmail, senderPassword);

    final message = Message()
      ..from = Address(senderEmail, 'Blood Donation App')
      ..recipients.add(recipientEmail)
      ..subject = subject
      ..text = body;

    try {
      await send(message, smtpServer);
      print('Email sent successfully');
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}