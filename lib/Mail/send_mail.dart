import 'dart:io';
import 'package:mailer2/mailer.dart';

void sendMail(String tomail, String name) {
  var options = new GmailSmtpOptions()
    ..username = 'Customercarekaamkhoj@gmail.com'
    ..password =
        'kaamkhoj123456'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'Customercare@kaamkhoj.co.in'
    ..recipients.add(tomail)
    ..subject = 'Welcome to Kaamkhoj'
//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = 'This is a cool email message. Whats up?'
    ..html =
        '<h2>Hi $name,</h2><p>The complete team at kaamkhoj are pleased to receive your inquiry and look forward to serve you in future.We will get in touch with you shortly.</p> <h3>Thanks</h3> <h3>Alisha Rai</h3> <h3>Customer Loyalty Executive</h3> <h3>022-66661314</h3>';

  // Email it.
  emailTransport
      .send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

void sendMailPartnerUsAdmin(
    String name,
    String phoneNo,
    String city,
    String agencyPhoneNo,
    String agencyName,
    String agencyEmail,
    String agencyCity,
    String areaName) {
//  print(emailData.name);
  var options = new GmailSmtpOptions()
    ..username = 'Customercarekaamkhoj@gmail.com'
    ..password =
        'kaamkhoj123456'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'Customercarekaamkhoj@gmail.com'
    ..recipients.add('Clopes024@gmail.com')
//    ..recipients.add('Clopes024@gmail.com')

    ..subject = 'Partner Us Details'
//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text =
        '<h2>Hello Admin,</h2><p>This is the data of agency who has applied for PartnerUs:</p><p> Name: $name </p><p> City: $city </p><p> Phone Number: $phoneNo </p>'
    ..html =
        '<h2>Hello Admin,</h2><p>This is the data of agency who has applied for PartnerUs:</p><p>User Name: $name </p><p>User City: $city </p><p>User Phone Number: $phoneNo </p><p>Agency Name: $agencyName </p><p>Agency City: $agencyCity </p><p>Agency Area: $areaName </p><p>Agency Email: $agencyEmail </p><p>Agency Phone Number: $agencyPhoneNo </p>';

  // Email it.
  emailTransport
      .send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

void sendMailEmployerAdmin(
    String name,
    String gender,
    String phoneNo,
    String city,
    String area,
    String radioItemHrs,
    String radioItemReligion,
    String work,
    String employerCity,
    String employerEmail,
    String radioItemGender) {
//  print(emailData.name);
  var options = new GmailSmtpOptions()
    ..username = 'Customercarekaamkhoj@gmail.com'
    ..password =
        'kaamkhoj123456'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'Customercarekaamkhoj@gmail.com'
    ..recipients.add('Clopes024@gmail.com')
//    ..recipients.add('Clopes024@gmail.com')

    ..subject = 'Employer Details'
//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text =
        '<h2>Hello Admin,</h2><p>This is the data of user who has applied for Employer:</p><p> Name: $name </p><p> City: $city </p><p> Email: $employerEmail </p><p> Phone Number: $phoneNo </p>'
    ..html =
        '<h2>Hello Admin,</h2><p>This is the data of user who has filled Employer Form(Who want a employee):</p><p>User Name: $name </p><p>User Phone Number: $phoneNo </p><p>User Gender: $gender </p><p>User City: $city </p><p>User Area: $area </p><p>User Email: $employerEmail </p><p>Religion: $radioItemReligion </p><p>Work Required: $work </p><p>Gender Required: $radioItemGender </p><p>Hours Rquired: $radioItemHrs </p><p>Employer City: $employerCity </p>';

  // Email it.
  emailTransport
      .send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

void sendMailEmployeeAdmin(
    String name,
    String gender,
    String age,
    String phoneNo,
    String city,
    String area,
    String radioItemHrs,
    String radioItemReligion,
    String work) {
  var options = new GmailSmtpOptions()
    ..username = 'Customercarekaamkhoj@gmail.com'
    ..password =
        'kaamkhoj123456'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'Customercarekaamkhoj@gmail.com'
    ..recipients.add('Clopes024@gmail.com')
//    ..recipients.add('Clopes024@gmail.com')

    ..subject = 'Employee Details'
//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text =
        '<h2>Hello Admin,</h2><p>This is the data of user who has applied for Employee:</p><p> Name: $name </p><p> City: $city </p> <p> Phone Number: $phoneNo </p>'
    ..html =
        '<h2>Hello Admin,</h2><p>This is the data of user who has filled Employee Form(Who want a job):</p><p>User Name: $name </p><p>User Phone Number: $phoneNo </p><p>User Age: $age </p><p>User Gender: $gender </p><p>User City: $city </p><p>User Area: $area </p><p>Religion: $radioItemReligion </p><p>Work Required: $work </p><p>Hours Rquired: $radioItemHrs </p>';

  // Email it.
  emailTransport
      .send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

void sendMailContacts(String tomail, File file1) {
  var options = new GmailSmtpOptions()
    ..username = 'Customercarekaamkhoj@gmail.com'
    ..password =
        'kaamkhoj123456'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'Customercarekaamkhoj@gmail.com'
    ..recipients.add(tomail)
    ..subject = 'Contacts of User from Kaamkhoj App'
    ..attachments.add(new Attachment(file: file1))
    ..text = 'This is a cool email message. Whats up?'
    ..html =
        '<h2>Hi Admin, </h2> <p>This is the mail of contacts of User from Kaamkhoj App</p>';

  // Email it.
  emailTransport
      .send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

void sendMailReceipt(String tomail, File file1) {
  print(tomail);
  var options = new GmailSmtpOptions()
    ..username = 'Customercarekaamkhoj@gmail.com'
    ..password =
        'kaamkhoj123456'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'Customercarekaamkhoj@gmail.com'
    ..recipients.add(tomail)
    ..subject = 'Contacts of User from Kaamkhoj App'
    ..attachments.add(new Attachment(file: file1))
    ..text = ''
    ..html = '<h2>Hi Admin, </h2> <p>this is the mail has receipt of 1000</p>';

  // Email it.
  emailTransport
      .send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

void sendMailPaymentAdmin(String name, String phoneNo, String city,
    String orderId, String amt, String date, File file1) {
//void sendMailPaymentAdmin(String name, String phoneNo,String city,String orderId, String amt,String date) {

//  print(emailData.name);
  var options = new GmailSmtpOptions()
    ..username = 'Customercarekaamkhoj@gmail.com'
    ..password =
        'kaamkhoj123456'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'Customercarekaamkhoj@gmail.com'
    ..recipients.add('Clopes024@gmail.com')
//    ..recipients.add('Clopes024@gmail.com')

    ..subject = 'Employer Details'
    ..attachments.add(new Attachment(file: file1))

//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = '<h2>Hello Admin,</h2>'
    ..html =
        '<h2>Hello Admin,</h2><p>This is the data of user who has made a payment,</p><p>User Name: $name </p><p>User Phone Number: $phoneNo </p><p>User City: $city </p><p>OrderId: $orderId </p><p>Amount: $amt </p><p>Payemnt Date: $date </p>';

  // Email it.
  emailTransport
      .send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}

void sendMailPaymentCust(String name, String phoneNo, String city,
    String orderId, String amt, String date, File file1, String tomail) {
  var options = new GmailSmtpOptions()
    ..username = 'Customercarekaamkhoj@gmail.com'
    ..password =
        'kaamkhoj123456'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'Customercarekaamkhoj@gmail.com'
    ..recipients.add(tomail)
    ..subject = 'Payment Successful'
    ..attachments.add(new Attachment(file: file1))

//    ..attachments.add(new Attachment(file: new File('path/to/file')))
    ..text = '<h2>Dear $name,</h2>'
    ..html =
        '<h2>Dear $name,</h2><p>Thank you for the recent payment you have made to us. I hereby acknowledge receipt of payment which has been set against the following invoices.</p>';

  // Email it.
  emailTransport
      .send(envelope)
      .then((envelope) => print('Email sent!'))
      .catchError((e) => print('Error occurred: $e'));
}
