import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class LiveChatPage extends StatefulWidget {
  @override
  LiveChatState createState() => new LiveChatState();
}

class LiveChatState extends State<LiveChatPage> {
  @override
  void initState() {
    super.initState();
    launchWhatsapp();
  }

  launchWhatsapp() async {
    await launch(
        "https://wa.me/+919820108341?text=Hi");
  }


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
          backgroundColor: Color.fromARGB(0xff, 0xf5, 0xea, 0xea),
          bottomNavigationBar: Container(
            height: 40,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ButtonTheme(
                height: 40,
                minWidth: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                      onPressed: () {
                        launchWhatsapp();
//                        _makeSmsRequest();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        'Chat Again',
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
          ),
          body:  Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                        child: Text('KaamKhoj',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                fontSize: 35,
                                fontWeight: FontWeight.bold))),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/logo.png")),
                        )),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                          child: Text(
                            'Thank You \n',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
