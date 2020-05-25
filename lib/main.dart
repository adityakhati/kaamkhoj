// import 'package:flutter/material.dart';
// import 'src/app.dart';
// void main(){
//     runApp(App());
// }
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   final appTitle = 'Kaamkhoj';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: appTitle,
//       home: MyHomePage(title: appTitle),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final String title;

//   MyHomePage({Key key, this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Center(child: Text('My Page!')),
//       drawer: Drawer(
//         // Add a ListView to the drawer. This ensures the user can scroll
//         // through the options in the drawer if there isn't enough vertical
//         // space to fit everything.
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text('Drawer Header'),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//             ),
//             ListTile(
//               title: Text('Item 1'),
//               onTap: () {
//                 // Update the state of the app
//                 // ...
//                 // Then close the drawer
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: Text('Item 2'),
//               onTap: () {
//                 // Update the state of the app
//                 // ...
//                 // Then close the drawer
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//import 'NavigatorPages/navigatorPage.dart';
//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'NavigationDrawer Demo',
//      theme: new ThemeData(
//        fontFamily:'OpenSans',
//        primarySwatch: Colors.blue,
//        textTheme: GoogleFonts.latoTextTheme(
//        Theme.of(context).textTheme,
//    ),
//        // textTheme: TextTheme(
//
//        //   body1: TextStyle(fontStyle: FontStyle.italic),
//
//        //  )
//      ),
//      home: new NavigatorPage(),
//    );
//  }
//}

//import 'package:flutter/material.dart';
//import 'dart:async';
//
////import OneSignal
//import 'package:onesignal_flutter/onesignal_flutter.dart';
//
//void main() => runApp(new MyApp());
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => new _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  String _debugLabelString = "";
//  String _emailAddress;
//  String _externalUserId;
//  bool _enableConsentButton = false;
//
//  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
//  bool _requireConsent = true;
//
//  @override
//  void initState() {
//    super.initState();
//    initPlatformState();
//  }
//
//  // Platform messages are asynchronous, so we initialize in an async method.
//  Future<void> initPlatformState() async {
//    if (!mounted) return;
//
//    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//
//    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
//
//    var settings = {
//      OSiOSSettings.autoPrompt: false,
//      OSiOSSettings.promptBeforeOpeningPushUrl: true
//    };
//
//    OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
//      this.setState(() {
//        _debugLabelString =
//        "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
//      });
//    });
//
//    OneSignal.shared
//        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//      this.setState(() {
//        _debugLabelString =
//        "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
//      });
//    });
//
//    OneSignal.shared
//        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
//      this.setState(() {
//        _debugLabelString =
//        "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
//      });
//    });
//
//    OneSignal.shared
//        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
//      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
//    });
//
//    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
//      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
//    });
//
//    OneSignal.shared.setEmailSubscriptionObserver(
//            (OSEmailSubscriptionStateChanges changes) {
//          print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
//        });
//
//    // NOTE: Replace with your own app ID from https://www.onesignal.com
//    await OneSignal.shared
//        .init("981fc4a2-48e3-4186-b18f-7a52d3ad217f", iOSSettings: settings);
//
//    OneSignal.shared
//        .setInFocusDisplayType(OSNotificationDisplayType.notification);
//
//    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();
//
//    this.setState(() {
//      _enableConsentButton = requiresConsent;
//    });
//
//    // Some examples of how to use In App Messaging public methods with OneSignal SDK
//    oneSignalInAppMessagingTriggerExamples();
//
//    // Some examples of how to use Outcome Events public methods with OneSignal SDK
//    oneSignalOutcomeEventsExamples();
//  }
//
//  void _handleGetTags() {
//    OneSignal.shared.getTags().then((tags) {
//      if (tags == null) return;
//
//      setState((() {
//        _debugLabelString = "$tags";
//      }));
//    }).catchError((error) {
//      setState(() {
//        _debugLabelString = "$error";
//      });
//    });
//  }
//
//  void _handleSendTags() {
//    print("Sending tags");
//    OneSignal.shared.sendTag("test2", "val2").then((response) {
//      print("Successfully sent tags with response: $response");
//    }).catchError((error) {
//      print("Encountered an error sending tags: $error");
//    });
//  }
//
//  void _handlePromptForPushPermission() {
//    print("Prompting for Permission");
//    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//      print("Accepted permission: $accepted");
//    });
//  }
//
//  void _handleGetPermissionSubscriptionState() {
//    print("Getting permissionSubscriptionState");
//    OneSignal.shared.getPermissionSubscriptionState().then((status) {
//      this.setState(() {
//        _debugLabelString = status.jsonRepresentation();
//      });
//    });
//  }
//
//  void _handleSetEmail() {
//    if (_emailAddress == null) return;
//
//    print("Setting email");
//
//    OneSignal.shared.setEmail(email: _emailAddress).whenComplete(() {
//      print("Successfully set email");
//    }).catchError((error) {
//      print("Failed to set email with error: $error");
//    });
//  }
//
//  void _handleLogoutEmail() {
//    print("Logging out of email");
//    OneSignal.shared.logoutEmail().then((v) {
//      print("Successfully logged out of email");
//    }).catchError((error) {
//      print("Failed to log out of email: $error");
//    });
//  }
//
//  void _handleConsent() {
//    print("Setting consent to true");
//    OneSignal.shared.consentGranted(true);
//
//    print("Setting state");
//    this.setState(() {
//      _enableConsentButton = false;
//    });
//  }
//
//  void _handleSetLocationShared() {
//    print("Setting location shared to true");
//    OneSignal.shared.setLocationShared(true);
//  }
//
//  void _handleDeleteTag() {
//    print("Deleting tag");
//    OneSignal.shared.deleteTag("test2").then((response) {
//      print("Successfully deleted tags with response $response");
//    }).catchError((error) {
//      print("Encountered error deleting tag: $error");
//    });
//  }
//
//  void _handleSetExternalUserId() {
//    print("Setting external user ID");
//    OneSignal.shared.setExternalUserId(_externalUserId).then((results) {
//      if (results == null) return;
//
//      this.setState(() {
//        _debugLabelString = "External user id set: $results";
//      });
//    });
//  }
//
//  void _handleRemoveExternalUserId() {
//    OneSignal.shared.removeExternalUserId().then((results) {
//      if (results == null) return;
//
//      this.setState(() {
//        _debugLabelString = "External user id removed: $results";
//      });
//    });
//  }
//
//  void _handleSendNotification() async {
//    var status = await OneSignal.shared.getPermissionSubscriptionState();
//
//    var playerId = status.subscriptionStatus.userId;
//
//    var imgUrlString =
//        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";
//
//    var notification = OSCreateNotification(
//        playerIds: [playerId],
//        content: "this is a test from OneSignal's Flutter SDK",
//        heading: "Test Notification",
//        iosAttachments: {"id1": imgUrlString},
//        bigPicture: imgUrlString,
//        buttons: [
//          OSActionButton(text: "test1", id: "id1"),
//          OSActionButton(text: "test2", id: "id2")
//        ]);
//
//    var response = await OneSignal.shared.postNotification(notification);
//
//    this.setState(() {
//      _debugLabelString = "Sent notification with response: $response";
//    });
//  }
//
//  void _handleSendSilentNotification() async {
//    var status = await OneSignal.shared.getPermissionSubscriptionState();
//
//    var playerId = status.subscriptionStatus.userId;
//
//    var notification = OSCreateNotification.silentNotification(
//        playerIds: [playerId], additionalData: {'test': 'value'});
//
//    var response = await OneSignal.shared.postNotification(notification);
//
//    this.setState(() {
//      _debugLabelString = "Sent notification with response: $response";
//    });
//  }
//
//  oneSignalInAppMessagingTriggerExamples() async {
//    /// Example addTrigger call for IAM
//    /// This will add 1 trigger so if there are any IAM satisfying it, it
//    /// will be shown to the user
//    OneSignal.shared.addTrigger("trigger_1", "one");
//
//    /// Example addTriggers call for IAM
//    /// This will add 2 triggers so if there are any IAM satisfying these, they
//    /// will be shown to the user
//    Map<String, Object> triggers = new Map<String, Object>();
//    triggers["trigger_2"] = "two";
//    triggers["trigger_3"] = "three";
//    OneSignal.shared.addTriggers(triggers);
//
//    // Removes a trigger by its key so if any future IAM are pulled with
//    // these triggers they will not be shown until the trigger is added back
//    OneSignal.shared.removeTriggerForKey("trigger_2");
//
//    // Get the value for a trigger by its key
//    Object triggerValue = await OneSignal.shared.getTriggerValueForKey("trigger_3");
//    print("'trigger_3' key trigger value: " + triggerValue);
//
//    // Create a list and bulk remove triggers based on keys supplied
//    List<String> keys = new List<String>();
//    keys.add("trigger_1");
//    keys.add("trigger_3");
//    OneSignal.shared.removeTriggersForKeys(keys);
//
//    // Toggle pausing (displaying or not) of IAMs
//    OneSignal.shared.pauseInAppMessages(false);
//  }
//
//  oneSignalOutcomeEventsExamples() async {
//    // Await example for sending outcomes
//    outcomeAwaitExample();
//
//    // Send a normal outcome and get a reply with the name of the outcome
//    OneSignal.shared.sendOutcome("normal_1");
//    OneSignal.shared.sendOutcome("normal_2").then((outcomeEvent) {
//      print(outcomeEvent.jsonRepresentation());
//    });
//
//    // Send a unique outcome and get a reply with the name of the outcome
//    OneSignal.shared.sendUniqueOutcome("unique_1");
//    OneSignal.shared.sendUniqueOutcome("unique_2").then((outcomeEvent) {
//      print(outcomeEvent.jsonRepresentation());
//    });
//
//    // Send an outcome with a value and get a reply with the name of the outcome
//    OneSignal.shared.sendOutcomeWithValue("value_1", 3.2);
//    OneSignal.shared.sendOutcomeWithValue("value_2", 3.9).then((outcomeEvent) {
//      print(outcomeEvent.jsonRepresentation());
//    });
//  }
//
//  Future<void> outcomeAwaitExample() async {
//    var outcomeEvent = await OneSignal.shared.sendOutcome("await_normal_1");
//    print(outcomeEvent.jsonRepresentation());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//          appBar: new AppBar(
//            title: const Text('OneSignal Flutter Demo'),
//            backgroundColor: Color.fromARGB(255, 212, 86, 83),
//          ),
//          body: Container(
//            padding: EdgeInsets.all(10.0),
//            child: SingleChildScrollView(
//              child: new Table(
//                children: [
//                  new TableRow(children: [
//                    new OneSignalButton(
//                        "Get Tags", _handleGetTags, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton(
//                        "Send Tags", _handleSendTags, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton("Prompt for Push Permission",
//                        _handlePromptForPushPermission, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton(
//                        "Print Permission Subscription State",
//                        _handleGetPermissionSubscriptionState,
//                        !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new TextField(
//                      textAlign: TextAlign.center,
//                      decoration: InputDecoration(
//                          hintText: "Email Address",
//                          labelStyle: TextStyle(
//                            color: Color.fromARGB(255, 212, 86, 83),
//                          )),
//                      onChanged: (text) {
//                        this.setState(() {
//                          _emailAddress = text == "" ? null : text;
//                        });
//                      },
//                    )
//                  ]),
//                  new TableRow(children: [
//                    Container(
//                      height: 8.0,
//                    )
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton(
//                        "Set Email", _handleSetEmail, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton("Logout Email", _handleLogoutEmail,
//                        !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton("Provide GDPR Consent", _handleConsent,
//                        _enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton("Set Location Shared",
//                        _handleSetLocationShared, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton(
//                        "Delete Tag", _handleDeleteTag, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton("Post Notification",
//                        _handleSendNotification, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton("Post Silent Notification",
//                        _handleSendSilentNotification, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new TextField(
//                      textAlign: TextAlign.center,
//                      decoration: InputDecoration(
//                          hintText: "External User ID",
//                          labelStyle: TextStyle(
//                            color: Color.fromARGB(255, 212, 86, 83),
//                          )),
//                      onChanged: (text) {
//                        this.setState(() {
//                          _externalUserId = text == "" ? null : text;
//                        });
//                      },
//                    )
//                  ]),
//                  new TableRow(children: [
//                    Container(
//                      height: 8.0,
//                    )
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton(
//                        "Set External User ID", _handleSetExternalUserId, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new OneSignalButton(
//                        "Remove External User ID", _handleRemoveExternalUserId, !_enableConsentButton)
//                  ]),
//                  new TableRow(children: [
//                    new Container(
//                      child: new Text(_debugLabelString),
//                      alignment: Alignment.center,
//                    )
//                  ]),
//                ],
//              ),
//            ),
//          )),
//    );
//  }
//}
//
//typedef void OnButtonPressed();
//
//class OneSignalButton extends StatefulWidget {
//  final String title;
//  final OnButtonPressed onPressed;
//  final bool enabled;
//
//  OneSignalButton(this.title, this.onPressed, this.enabled);
//
//  State<StatefulWidget> createState() => new OneSignalButtonState();
//}
//
//class OneSignalButtonState extends State<OneSignalButton> {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return new Table(
//      children: [
//        new TableRow(children: [
//          new FlatButton(
//            disabledColor: Color.fromARGB(180, 212, 86, 83),
//            disabledTextColor: Colors.white,
//            color: Color.fromARGB(255, 212, 86, 83),
//            textColor: Colors.white,
//            padding: EdgeInsets.all(8.0),
//            child: new Text(widget.title),
//            onPressed: widget.enabled ? widget.onPressed : null,
//          )
//        ]),
//        new TableRow(children: [
//          Container(
//            height: 8.0,
//          )
//        ]),
//      ],
//    );
//  }
//}
//*************************************
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/fragments/choose_work.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';
import 'package:kaamkhoj/test1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:kaamkhoj/fragments/about_us.dart';

import 'NavigatorPages/navigatorPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('Login');
  print(token);

  runApp(
    MaterialApp(
        theme: new ThemeData(
          primaryColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        ),
//      home: token == null ? LoginPage() : MyApp()),
        home: token == null ? MyApp1("Login") : MyApp1("Navigator")),
  );
}


class MyApp1 extends StatefulWidget {
  String type;

  MyApp1(String type) {
    this.type = type;
  }

  @override
  _MyAppState createState() => new _MyAppState(type);
}

class _MyAppState extends State<MyApp1> {
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

//    FocusScope.of(context).requestFocus(new FocusNode());

    _startTimer();
  }

  _startTimer() {
    _counter = 5;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          if (type == "Login") {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NavigatorPage()));
          }
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

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Nabigator Page',
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/splashscreen.png")),
          ),
        ),
      ),
      theme: new ThemeData(
        primaryColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      ),
    );
  }
}

