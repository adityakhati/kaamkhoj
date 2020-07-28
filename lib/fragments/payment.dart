import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:kaamkhoj/paytmPayment/PaymentPaytmPage.dart';

class PaymentPage extends StatelessWidget {

  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[_column(context)]),
                ))),
      ),
    );
  }

  Widget _column(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(margin: EdgeInsets.only(top: 10)),
              Center(
                child: Text('Payment Section',
                    style: font1, textAlign: TextAlign.justify),
              ),
              Container(margin: EdgeInsets.only(top: 10)),
              Text('Hi ,', style: font2, textAlign: TextAlign.justify),
              Text('Greetings from Kaamkhoj!',
                  style: font2, textAlign: TextAlign.justify),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              Text(
                  'The complete team at Kaamkhoj would be honoured to serve you and have you as one of our esteemed customer.',
                  style: font2,
                  textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'Kaamkhoj charges a registration fee of Rs. 1000 before the screening process.',
                  style: font2,
                  textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'This amount is completely adjustable against our consultancy charges and "refundable" if we do not provide you with the services required by you.',
                  style: font2,
                  textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Thank you', style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Alisha Rai', style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Customer Loyalty Executive',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('022-66661323', style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              _button(context)
            ]));
  }

  _button(BuildContext context) {
    return Padding(
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
                  MaterialPageRoute(builder: (context) => PaytmPaymentPage()),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Pay Now',
                style: GoogleFonts.karla(
                    color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              elevation: 7,
              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
        ),
      ),
    );
  }
}
