import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class ContactUsPage extends StatelessWidget {
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
            backgroundColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
            body: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 60, bottom: 60, right: 23, left: 23),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, right: 10, left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.cover)),
                      child: Column(children: <Widget>[
                        _buildTitle(),
                        _column(),
                        _buildTitle2()
                      ]),
                    ),
                  )),
            )),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: Text('Contact Info', style: font1),
      ),
    );
  }

  Widget _column() {
    return Container(
        margin: EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'Registered Office : 54, Mamta \'A\' wing, A.M. Marg, Prabhadevi, Mumbai- 400 025.',
                  style: font2,
                  textAlign: TextAlign.justify),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: 'Telephone: ',
                  style: font2,
                  children: <TextSpan>[
                    TextSpan(
                        text: '022-66661314/ ',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {launch("tel://02266661314")}),
                    TextSpan(
                        text: '022-66661414',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {launch("tel://02266661414")}),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10)),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: 'WhatsApp :',
                  style: font2,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' 08879392064',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {launchWhatsapp()}),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10)),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: 'Email :',
                  style: font2,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' customercare@kaamkhoj.co.in',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {_launchURLEmail()}),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10)),
              Center(child: Text('Social Media', style: font1)),
            ]));
  }

  launchWhatsapp() async {
    await launch(
//               "https://api.whatsapp.com/send?phone=+917977763205?text=Helo"),
        "https://wa.me/+919820108341?text=Hi");
  }

  _launchURLEmail() async {
    String url = "mailto:customercare@kaamkhoj.co.in?subject=&body=";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL(String urltype) async {
    String url;
    if (urltype == "facebook")
      url = 'http://facebook.com/kaamkhoj';
    else if (urltype == "twitter")
      url = 'http://twitter.com/kaamkhoj'; //working
    else if (urltype == "insta")
      url = 'http://www.instagram.com/kaamkhoj/'; //Working
    else if (urltype == "youtube")
      url =
          'https://www.youtube.com/channel/UCrDumaP5bEcs4keGj_hvaXg'; //Working
    else if (urltype == "linkedin")
      url = 'https://www.linkedin.com/in/kaamkhoj/'; //working

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildTitle2() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => _launchURL("facebook"),
              child: Container(
                margin: EdgeInsets.only(left: 16),
                //  alignment: Alignment.topLeft,
                // padding: const EdgeInsets.symmetric(horizontal: 2.0),
                width: 40,
                height: 40,
                child: Image(
                  image: AssetImage("assets/images/Facebook.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                  onTap: () => _launchURL("facebook"),
                  child: Text('Facebook', style: font2)),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => _launchURL("insta"),
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 16),
                //  alignment: Alignment.topLeft,
                // padding: const EdgeInsets.symmetric(horizontal: 2.0),
                width: 40,
                height: 40,
                child: Image(
                  image: AssetImage("assets/images/Instagram.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                  onTap: () => _launchURL("insta"),
                  child: Text('Instagram', style: font2)),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => _launchURL("linkedin"),
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 16),
                //  alignment: Alignment.topLeft,
                // padding: const EdgeInsets.symmetric(horizontal: 2.0),
                width: 40,
                height: 40,
                child: Image(
                  image: AssetImage("assets/images/Linkedin.png"),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () => _launchURL("linkedin"),
                  child: Text('LinkedIn', style: font2),
                )),
          ],
        ),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => _launchURL("youtube"),
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 16),
                //  alignment: Alignment.topLeft,
                // padding: const EdgeInsets.symmetric(horizontal: 2.0),
                width: 40,
                height: 40,
                child: Image(
                  image: AssetImage("assets/images/Youtube.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                  onTap: () => _launchURL("youtube"),
                  child: Text('Youtube', style: font2)),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => _launchURL("twitter"),
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 16),
                //  alignment: Alignment.topLeft,
                // padding: const EdgeInsets.symmetric(horizontal: 2.0),
                width: 40,
                height: 40,
                child: Image(
                  image: AssetImage("assets/images/Twitter.png"),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () => _launchURL("twitter"),
                  child: Text('Twitter', style: font2),
                )),
          ],
        ),
      ],
    );
  }
}
