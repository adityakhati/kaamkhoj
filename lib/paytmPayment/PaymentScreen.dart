import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/Mail/send_mail.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:number_to_words_spelling/number_to_words_spelling.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Constants.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:intl/intl.dart';

import 'PaymentPaytmPage.dart';

class PaymentScreen extends StatefulWidget {
  final String amount;

  PaymentScreen({this.amount});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController _webController;
  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;
  String orderId, amt;

  String _loadHTML() {
    return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='$PAYMENT_URL'><input type='hidden' name='orderID' value='ORDER_${DateTime.now().millisecondsSinceEpoch}'/>" +
        "<input  type='hidden' name='custID' value='${ORDER_DATA["custID"]}' />" +
        "<input  type='hidden' name='amount' value='${widget.amount}' />" +
        "<input type='hidden' name='custEmail' value='${ORDER_DATA["custEmail"]}' />" +
        "<input type='hidden' name='custPhone' value='${ORDER_DATA["custPhone"]}' />" +
        "</form> </body> </html>";
  }

  void getData() {
    _webController.evaluateJavascript("document.body.innerText").then((data) {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      final checksumResult = responseJSON["status"];
      final paytmResponse = responseJSON["data"];
      if (paytmResponse["STATUS"] == "TXN_SUCCESS") {
        if (checksumResult == 0) {
          _responseStatus = STATUS_SUCCESSFUL;
          orderId = paytmResponse['ORDERID'];
          amt = paytmResponse['TXNAMOUNT'];
        } else {
          _responseStatus = STATUS_CHECKSUM_FAILED;
        }
      } else if (paytmResponse["STATUS"] == "TXN_FAILURE") {
        _responseStatus = STATUS_FAILED;
      }
      this.setState(() {});
    });
  }

  Widget getResponseScreen() {
    switch (_responseStatus) {
      case STATUS_SUCCESSFUL:
        return PaymentSuccessfulScreen(orderId, amt);
      case STATUS_CHECKSUM_FAILED:
        return CheckSumFailedScreen();
      case STATUS_FAILED:
        return PaymentFailedScreen();
    }
    return PaymentSuccessfulScreen(orderId, amt);
  }

  @override
  void dispose() {
    _webController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WebView(
              debuggingEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _webController = controller;
                _webController.loadUrl(
                    new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                        .toString());
              },
              onPageFinished: (page) {
                if (page.contains("/process")) {
                  if (_loadingPayment) {
                    this.setState(() {
                      _loadingPayment = false;
                    });
                  }
                }
                if (page.contains("/paymentReceipt")) {
                  getData();
                }
              },
            ),
          ),
          (_loadingPayment)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(),
          (_responseStatus != STATUS_LOADING)
              ? Center(child: getResponseScreen())
              : Center()
        ],
      )),
    );
  }
}

class PaymentSuccessfulScreen extends StatefulWidget {
  String orderId, amt;

  PaymentSuccessfulScreen(String orderId, String amt) {
    this.orderId = orderId;
    this.amt = amt;
  }

  @override
  PaymentSuccessfulScreenState createState() =>
      new PaymentSuccessfulScreenState(orderId, amt);
}

class PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  String phoneNo;
  String email;
  String orderId, amt;

  String gender,name,city,abb;

  PaymentSuccessfulScreenState(String orderId, String amt) {
    this.orderId = orderId;
    this.amt = amt;
  }

  @override
  void initState() {
    getStringValuesSF();
  }

  final pdf = pw.Document();

  writeOnPdf(String formattedDate) async {
    final PdfImage profileImage = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load('assets/images/pdflogo.png'))
          .buffer
          .asUint8List(),
    );
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Column(children: [
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          child: pw.Column(children: [
                        pw.Container(
                          height: 100,
                          padding: const pw.EdgeInsets.only(left: 20),
                          alignment: pw.Alignment.topLeft,
                          child: pw.Image(profileImage),
                        ),
                        pw.Container(
                            padding: const pw.EdgeInsets.only(left: 20),
                            alignment: pw.Alignment.topLeft,
                            child: pw.Text(
                              "",
                            ))
                      ])),
                      pw.Expanded(
                          child: pw.Container(
                        padding: const pw.EdgeInsets.only(left: 20),
                        alignment: pw.Alignment.topRight,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("54, mamta A wing"),
                            pw.Text("A.M. Marg"),
                            pw.Text("Prabhadevi"),
                            pw.Text("Mumbai-400025"),
                            pw.Text("Tel:022-66661414/022-66661314"),
                            pw.Text("Website:www.kaamkhoj.co.in"),
                            pw.Text("Email:info@kaamkhoj.co.in"),
                          ],
                        ),
                      ))
                    ]),
                pw.Container(
                    alignment: pw.Alignment.topLeft,
                    padding: const pw.EdgeInsets.only(top: 20),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Date:" + formattedDate),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 10, bottom: 20),
                            child: pw.Text("Invoice No." + orderId),
                          ),
                          pw.Text("To,"),
                          pw.Text("   "+abb+" "+name),
                          pw.Text("   "+city),
                          pw.Padding(padding: pw.EdgeInsets.only(top: 20)),
                          pw.Table.fromTextArray(
                              context: context,
                              data: <List<String>>[
                                <String>['Sr No', 'DESCRIPTION', ' ', 'AMOUNT'],
                                <String>['1', 'Registration fee', ' ', amt],
                                <String>[' ', 'Amount paid', 'SUBTOTAL', amt],
                                <String>[
                                  ' ',
                                  "Rupees " +
                                      NumberWordsSpelling.toWord(
                                          amt.substring(0, amt.length - 3),
                                          'en_US') +
                                      " only",
                                  ' ',
                                  ' '
                                ],
                              ]),
                          pw.Padding(padding: pw.EdgeInsets.only(top: 10)),
                          pw.Text(
                              "The payee of this bill agrees to all the terms and conditions given on the mobile application/website of www.kaamkhoj.in"),
                          pw.Text("Bank Details"),
                          pw.Text("Account Type:- Current Account"),
                          pw.Text("Account No.:045183800000388"),
                          pw.Text("IFSC Code: YESB0000451"),
                          pw.Text("Bank Name: Yes Bank"),
                          pw.Text("Beneficiary Name: kaamkhojin"),
                          pw.Text("Branch: Parel( Mumbai)"),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 10),
                          ),
                        ]))
              ]))
        ];
      },
    ));
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/receipt.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  void createRecord(String phoneNo, String formattedDate) async {
    final databaseReference = Firestore.instance;
    final snapShot = await Firestore.instance
        .collection("data")
        .document(phoneNo)
        .collection("Payment")
        .document("0")
        .get();

    if (snapShot == null || !snapShot.exists) {
      await databaseReference
          .collection("data")
          .document(phoneNo)
          .collection("Payment")
          .document("0")
          .setData({
        'Time': formattedDate,
        'Status': "done",
        'OrderId': orderId,
        'Amount': amt
      });
    } else {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection("data")
          .document(phoneNo)
          .collection("Payment")
          .getDocuments();
      var list = querySnapshot.documents;

      await databaseReference
          .collection("data")
          .document(phoneNo)
          .collection("Payment")
          .document(list.length.toString())
          .setData({
        'Time': formattedDate,
        'Status': "done",
        'OrderId': orderId,
        'Amount': amt
      });
    }
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNo =  prefs.getString('Login');
    email =  prefs.getString('Email');
    gender =  prefs.getString('Gender');
    city =  prefs.getString('City');
    name =  prefs.getString('Name');

    if(gender=="Male"){
      abb="Mr.";
    }
    else{
      abb="Mrs.";
    }

    print(phoneNo);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM yyyy').format(now);
    createRecord(phoneNo, formattedDate);


    writeOnPdf(formattedDate);
    await savePdf();

    sendMail(phoneNo, formattedDate, email);
  }

  Future<void> sendMail(
      String phoneNo, String formattedDate, String email) async {
    final databaseReference = Firestore.instance;

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/receipt.pdf");

    DocumentReference documentReference =
        databaseReference.collection("data").document(phoneNo);
    documentReference.get().then((datasnapshot) {
      sendMailPaymentAdmin(
          datasnapshot.data['Name'].toString(),
          phoneNo,
          datasnapshot.data['city'].toString(),
          orderId,
          amt,
          formattedDate,
          file);
      sendMailPaymentCust(
          datasnapshot.data['Name'].toString(),
          phoneNo,
          datasnapshot.data['city'].toString(),
          orderId,
          amt,
          formattedDate,
          file,
          email);
    });
  }

  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 28,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 22, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigatorPage()),
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[_column()]))),
      ),
    );
  }

  Widget _column() {
    return Container(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 35)),
                Center(
                  child: Icon(
                    Icons.verified_user,
                    size: 150,
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 10)),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text('Success',
                      style: font1, textAlign: TextAlign.justify),
                )),
                Center(
                  child: Text('Your Payment has been confirmed.',
                      style: font2, textAlign: TextAlign.justify),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                ),
                Center(
                    child: Text('Check your email for details.',
                        style: font2, textAlign: TextAlign.justify)),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                      'We will contact you shortly or you can contact us on 022-66661314',
                      style: font2,
                      textAlign: TextAlign.center),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ButtonTheme(
                    height: 40,
                    minWidth: 290,
                    child: Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigatorPage(),
                                ));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            'OK',
                            style: GoogleFonts.karla(
                                color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          textColor: Colors.white,
                          elevation: 7,
                          color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                    ),
                  ),
                ),
              ]),
        ));
  }
}

class PaymentFailedScreen extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 28,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 22, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigatorPage()),
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[_column(context)]))),
      ),
    );
  }

  Widget _column(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 35)),
                Center(
                  child: Icon(
                    Icons.report,
                    size: 150,
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 10)),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child:
                      Text('OOPS!', style: font1, textAlign: TextAlign.center),
                )),
                Center(
                  child: Text('Your Transaction has been failed.',
                      style: font2, textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ButtonTheme(
                        height: 40,
                        minWidth: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaytmPaymentPage()),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                'Retry',
                                style: GoogleFonts.karla(
                                    color:
                                        Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              textColor: Colors.white,
                              elevation: 7,
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: ButtonTheme(
                        height: 40,
                        minWidth: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavigatorPage()),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                'Close',
                                style: GoogleFonts.karla(
                                    color:
                                        Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              textColor: Colors.white,
                              elevation: 7,
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}

class CheckSumFailedScreen extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 28,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 22, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigatorPage()),
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[_column(context)]))),
      ),
    );
  }

  Widget _column(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 35)),
                Center(
                  child: Icon(
                    Icons.report,
                    size: 150,
                    color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 10)),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child:
                      Text('OOPS!', style: font1, textAlign: TextAlign.center),
                )),
                Center(
                  child: Text(
                      "Problem Verifying Payment, If you balance is deducted please contact our customer support and get your payment verified!",
                      style: font2,
                      textAlign: TextAlign.center),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ButtonTheme(
                        height: 40,
                        minWidth: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaytmPaymentPage()),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                'Retry',
                                style: GoogleFonts.karla(
                                    color:
                                        Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              textColor: Colors.white,
                              elevation: 7,
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: ButtonTheme(
                        height: 40,
                        minWidth: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavigatorPage()),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                'Close',
                                style: GoogleFonts.karla(
                                    color:
                                        Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              textColor: Colors.white,
                              elevation: 7,
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
