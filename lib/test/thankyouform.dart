import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class ThankyouPage extends StatefulWidget {
  String phoneNo;

  ThankyouPage(String phoneNo) {
    this.phoneNo = phoneNo;
  }

  @override
  ThankyouPageState createState() => new ThankyouPageState(phoneNo);
}

class ThankyouPageState extends State<ThankyouPage> {
  int _counter;
  Timer _timer;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final databaseReference = Firestore.instance;

  String phoneNo;

  ThankyouPageState(String phoneNo) {
    this.phoneNo = phoneNo;
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    _showNotificationWithoutSound();
  }

  Future onSelectNotification(String payload) async {
    return true;
  }

  Future _showNotificationWithoutSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Thank You',
      'We will contact you shortly or you can contact us on 022-66661314',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }

  _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => NavigatorPage()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(0xff, 0xf5, 0xea, 0xea),
        body: Center(
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
                      height: 275,
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
                          'Thank You\nWe will contact you shortly or you can contact us on 022-66661314',
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
    );
  }
}
