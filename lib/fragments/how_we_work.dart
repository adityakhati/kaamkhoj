import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:url_launcher/url_launcher.dart';

class HowWeWorkPage extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
  var font3 = GoogleFonts.sourceSansPro(
      color: Colors.blue[300], fontSize: 16, fontWeight: FontWeight.normal);

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
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                _carousel(context),
                _buildTitle(),
                _column()
              ]),
            ),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    String url = "http://www.kaamkhoj.co.in/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchWhatsapp() async {
    await launch(
//               "https://api.whatsapp.com/send?phone=+917977763205?text=Helo"),
        "https://wa.me/+919820108341?text=Hi");
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: Text('How we Work?', style: font1),
      ),
    );
  }

  Widget _carousel(BuildContext context) {
    return SizedBox(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        child: Carousel(
          images: [
            ExactAssetImage("assets/images/healthycooks copy1(work).jpg"),
            ExactAssetImage("assets/images/Baby-Sitter-(work).jpg"),
            ExactAssetImage("assets/images/movetomalaysia-maid copy(work).jpg"),
            ExactAssetImage("assets/images/nurse-appreciation copy(work).jpg"),
          ],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.lightGreenAccent,
          indicatorBgPadding: 5.0,
          boxFit: BoxFit.fill,
//      dotBgColor: Colors.transparent.withOpacity(0),
//      borderRadius: true,
          moveIndicatorFromBottom: 180.0,
//      noRadiusForIndicator: true,
        ));
  }

  Widget _column() {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      'An employer has to first create a login and password on KaamKhoj App or at',
                  style: font2,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' kaamkhoj.co.in',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {_launchURL()}),
                    TextSpan(
                        text:
                            ' and then fill up the employer registration form after which our call centre will get in touch with you. An employer can also call us on'),
                    TextSpan(
                        text: ' 022-66661314',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {launch("tel://02266661314")}),
                    TextSpan(
                        text:
                            ' from anywhere in the world and connect directly with our call centre and you can WhatsApp us anytime on ',
                        style: font2),
                    TextSpan(
                        text: '8879392064',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {launchWhatsapp()}),
                    TextSpan(
                        text:
                            '. For further information we also have a FAQ section on our website.',
                        style: font2),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              Center(
                child: Text('Value we deliver', style: font1),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
              ),
              Text('• A complete professional approach.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Sense of responsibility and care.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Affordable charges and Multiple payment Options.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Hassle free replacement-Sound management team.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• 24 x 7 call centre support.',
                  style: font2, textAlign: TextAlign.justify),
            ]));
  }
}
