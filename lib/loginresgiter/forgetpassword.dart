import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/internetconnection/checkInternetConnection.dart';
import 'package:kaamkhoj/loginresgiter/passwordchange.dart';
import 'package:toast/toast.dart';

import 'Login.dart';

class ForgetPassword extends StatefulWidget {
  final String lastPin;
  final int fields;
  final ValueChanged<String> onSubmit;
  final num fieldWidth;
  final num fontSize;
  final bool isTextObscure;
  final bool showFieldAsBox;

  ForgetPassword(
      {this.lastPin,
      this.fields: 6,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPassword> {
  String phoneNo = '', name, email, password, city;
  final databaseReference = Firestore.instance;

  String smsOTP, type;
  String verificationId;
  String errorMobile = '';
  String errorOtp = '';

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool circularProgress = false;
  bool circularProgressValid = false;

  //--------------------------OTP Handle Methods----------------//
  int _counter = 30;
  Color c = Colors.grey[700];
  Timer _timer;
  int resendotp = 0;

  void _startTimer() {
    _counter = 30;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          resendotp = 1;
          setState(() {
            c = Color.fromARGB(0xff, 0x88, 0x02, 0x0b);
          });
        }
      });
    });
  }

  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String>(widget.fields);
    _focusNodes = List<FocusNode>(widget.fields);
    _textControllers = List<TextEditingController>(widget.fields);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin.length; i++) {
            _pin[i] = widget.lastPin[i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context, i == 0);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context, [bool autofocus = false]) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin[i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    final String lastDigit = _textControllers[i].text;

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        autofocus: autofocus,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            // color: Colors.black,
            fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
            counterText: "",
            border: widget.showFieldAsBox
                ? OutlineInputBorder(borderSide: BorderSide(width: 2.0))
                : null),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i].unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  //---------------------------------------//

  checkExist() async {
    final snapShot =
        await Firestore.instance.collection('data').document(phoneNo).get();

    if (snapShot == null || !snapShot.exists) {
      setState(() {
        errorMobile = "User Doesn't Exist";
        circularProgressValid = false;
      });
      Toast.show("User Doesn't Exist", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      verifyPhone();
    }
  }

  void valid() {
    if ((phoneNo == "")) {
      String errorblank = "Please fill this field";
      if (phoneNo == "") {
        setState(() {
          errorMobile = errorblank;
          circularProgressValid = false;
        });
      }

      Toast.show("Please fill all the fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      if (errorMobile == "") {
        checkExist();
//        verifyPhone();
      } else {
        setState(() {
          circularProgressValid = false;
        });
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  _button() {
    return ButtonTheme(
        height: 40,
        minWidth: 290,
        child: Align(
          alignment: Alignment.center,
          child: RaisedButton(
              onPressed: () {
                setState(() {
                  circularProgress = true;
                });
                var concatenate = StringBuffer();

                _pin.forEach((item) {
                  concatenate.write(item);
                });

                if (concatenate.length == 6) {
                  signIn(concatenate.toString());
                  setState(() {
                    errorOtp = "";
                  });
                } else {
                  setState(() {
                    circularProgress = false;
                    errorOtp = "Please Fill OTP";
                  });
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Verify',
                style: GoogleFonts.karla(
                    color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              elevation: 7,
              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
        ));
  }

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      setState(() {
        otp = "1";
        circularProgressValid = false;
        c = Colors.grey[700];
        _startTimer();
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 30),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            _auth
                .signInWithCredential(phoneAuthCredential)
                .then((AuthResult result) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PasswordChangePage(phoneNo)));
            }).catchError((e) {});
          },
          verificationFailed: (AuthException exceptio) {});
    } catch (e) {
      setState(() {
        circularProgressValid = false;
        errorMobile = e.code;
      });
    }
  }

  signIn(smsotp1) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsotp1,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();

      assert(user.uid == currentUser.uid);
      _timer.cancel();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => PasswordChangePage(phoneNo)));
    } catch (e) {
      String error1 = "";
      switch (e.code) {
        case "ERROR_INVALID_VERIFICATION_CODE":
          error1 = "Invalid Otp";
          break;
        case "ERROR_SESSION_EXPIRED":
          error1 = "Time Limit Exceeded. Resend Otp";
          break;
        default:
          error1 = "Something Has Gone Worong";
      }
      setState(() {
        circularProgress = false;
        errorOtp = error1;
      });
    }
  }

  Future<bool> _onBackPressed() {
    if (otp != "0") {
      setState(() {
        otp = "0";
      });
      return Future.value(false);
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  String otp = "0";

  @override
  Widget build(BuildContext context) {
    return otp == "0"
        ? WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xfff7e9e9),
                resizeToAvoidBottomPadding: false,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage("assets/images/kaamkhoj_logo.png")),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 35, top: 20, right: 35, bottom: 5),
                      child: Center(
                        child: Container(
                          height: 55,
                          child: TextField(
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                    color:
                                        Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                                    fontSize: 14),
                                counterText: "",
                                focusedBorder: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white70,
                                    )),
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white70,
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'Mobile No.'),
                            onChanged: (value) {
                              this.phoneNo = "+91" + value;
                              if (value.length < 10) {
                                setState(() {
                                  errorMobile =
                                      "Mobile number contains 10 digits";
                                });
                              } else {
                                setState(() {
                                  errorMobile = "";
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    (errorMobile != ''
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                            child: Text(
                              errorMobile,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : Container()),
                    SizedBox(
                      height: 20,
                    ),
                    (circularProgressValid
                        ? Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                                child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Color.fromARGB(
                                                0xff, 0x88, 0x02, 0x0b)))),
                          )
                        : _buttonValid()),
                  ],
                ),
              ),
            ),
          )
        : WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xfff7e9e9),
                resizeToAvoidBottomPadding: false,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                AssetImage("assets/images/kaamkhoj_logo.png")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          'Enter OTP',
                          style: GoogleFonts.ptSans(
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    textfields,
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '00:$_counter',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: new GestureDetector(
                              onTap: () {
                                if (resendotp == 1) {
                                  resendotp = 0;
                                  verifyPhone();
                                }
                              },
                              child: new Text(
                                'Resend OTP',
                                style: GoogleFonts.ptSans(
                                    color: c,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (errorOtp != ''
                        ? Align(
                            alignment: Alignment.center,
                            child: Text(
                              errorOtp,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          )
                        : Container()),
                    SizedBox(
                      height: 10,
                    ),
                    (circularProgress
                        ? Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                                child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Color.fromARGB(
                                                0xff, 0x88, 0x02, 0x0b)))),
                          )
                        : _button()),
                  ],
                ),
              ),
            ),
          );
  }

  _buttonValid() {
    return ButtonTheme(
      height: 40,
      minWidth: 290,
      child: Align(
        alignment: Alignment.center,
        child: RaisedButton(
            onPressed: () {
              check_internet().then((intenet) {
                if (intenet != null && intenet) {
                  setState(() {
                    circularProgressValid = true;
                  });
                  valid();
                } else {
                  Toast.show("No Internet!\nCheck your Connection or Try Again",
                      context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              });
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Text(
              'Verify',
              style: GoogleFonts.karla(
                  color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            elevation: 7,
            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
      ),
    );
  }
}
