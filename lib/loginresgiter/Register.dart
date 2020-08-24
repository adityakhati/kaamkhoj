import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/internetconnection/checkInternetConnection.dart';
import 'package:kaamkhoj/loginresgiter/Login.dart';
import 'package:kaamkhoj/pincode/pincode.dart';
import 'package:kaamkhoj/policies/privacy_policy.dart';
import 'package:kaamkhoj/policies/terms_&_condition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:validators/validators.dart';
import '../main.dart';

import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  final String lastPin;
  final int fields;
  final ValueChanged<String> onSubmit;
  final num fieldWidth;
  final num fontSize;
  final bool isTextObscure;
  final bool showFieldAsBox;

  RegisterPage(
      {this.lastPin,
      this.fields: 6,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//  final formKey = GlobalKey<FormState>();
  String phoneNo = "",
      name = "",
      radioItemGender = "",
      email = "",
      password = "",
      city = "",
      code = "",
      otp = "0";
  int resendotp = 0;
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final databaseReference = Firestore.instance;
  String errorName = '';
  String errorEmail = '';
  String errorGender = '';
  String errorMobile = '';
  String errorPass = '';
  String errorCity = '';
  String errorCode = '';
  String errorMsg = '';
  String smsOTP, type;
  String verificationId;
  String errorMessage = '';

  int _counter1;
  Timer _timer1;

  FirebaseAuth _auth = FirebaseAuth.instance;

  //--------------------------OTP Handle Methods----------------//
  int _counter = 30;
  Color c = Colors.grey[700];
  Timer _timer;

  bool circularProgress = false;

  String errorOtp = "";

  bool circularProgressReg = false;

  String areaName = "";

  String cityName = "";

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

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      setState(() {
        circularProgressReg = false;
        otp = "1";
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
              createRecord();
//              Navigator.pushReplacement(context, MaterialPageRoute(
//                  builder: (context) => NavigatorPage()
//              ));
            }).catchError((e) {});
          },
          verificationFailed: (AuthException exceptio) {});
    } catch (e) {
      setState(() {
        circularProgressReg = false;
        errorMsg = e.code;
      });
    }
  }

  void createRecord() async {
    await databaseReference.collection("data").document(phoneNo).setData({
      'Number': phoneNo,
      'Name': name,
      'Gender': radioItemGender,
      'password': password,
      'pincode': code,
      'area': areaName,
      'city': cityName,
    });
//    addStringToSF();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp("Login")),
    );
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Login', phoneNo);
  }

  signIn(smsotp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsotp,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();

      assert(user.uid == currentUser.uid);
      createRecord();
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

  verify() async {
    final snapShot =
        await Firestore.instance.collection('data').document(phoneNo).get();

    if (snapShot == null || !snapShot.exists) {
      verifyPhone();
    } else {
      setState(() {
        errorMsg = "User Already Exist";
        circularProgressReg = false;
      });
      Toast.show("User Already Exist", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void valid() {
    if ((name == "") ||
        (radioItemGender == "") ||
        (phoneNo == "") ||
        (password == "") ||
        (code == "")) {
      setState(() {
        circularProgressReg = false;
      });
      String errorblank = "Please fill this field";
      if (name == "") {
        setState(() {
          errorName = errorblank;
        });
      }
      if (radioItemGender == "") {
        setState(() {
          errorGender = errorblank;
        });
      }
      if (phoneNo == "") {
        setState(() {
          errorMobile = errorblank;
        });
      }
      if (password == "") {
        setState(() {
          errorPass = errorblank;
        });
      }
      if (code == "") {
        setState(() {
          errorCode = errorblank;
        });
      }
      Toast.show("Please fill all the fields", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      if (errorName == "" &&
          errorMobile == "" &&
          errorPass == "" &&
          errorCode == "") {
        _startTimer1();

//        verify();
      } else {
        setState(() {
          circularProgressReg = false;
        });
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  _startTimer1() {
    _counter1 = 02;
    if (_timer1 != null) {
      _timer1.cancel();
    }
    _timer1 = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter1 > 0) {
          _counter1--;
        } else {
          _timer1.cancel();
          if (errorCode == "") {
            verify();
          } else {
            setState(() {
              circularProgress = false;
            });
          }
        }
      });
    });
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

  @override
  Widget build(BuildContext context) {
    var font1 = GoogleFonts.openSans(
        color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        fontSize: 18,
        fontWeight: FontWeight.bold);
    var font2 = GoogleFonts.sourceSansPro(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
    return otp == "0"
        ? WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xfff7e9e9),
                body: SingleChildScrollView(
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kaamkhoj_logo.png")),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Registration Form',
                          style: GoogleFonts.ptSans(
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 35, top: 15, right: 35, bottom: 10),
                        child: Center(
                          child: Container(
                            height: 55,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(
                                          0xff, 0x1d, 0x22, 0x26),
                                      fontSize: 14),
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
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'Full Name'),
                              onChanged: (value) {
                                this.name = value.trim();
                                // valid();
                                Pattern pattern =
                                    r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(name)) {
                                  setState(() {
                                    errorName = "Invalid Name";
                                  });
                                } else {
                                  setState(() {
                                    errorName = "";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      (errorName != ''
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                              child: Text(
                                errorName,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container()),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 35, top: 15, right: 35, bottom: 10),
                        child: Center(
                          child: Container(
                            height: 55,
                            child: TextField(
                              maxLength: 10,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(
                                          0xff, 0x1d, 0x22, 0x26),
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
                                // valid();
                                if (!isNumeric(value)) {
                                  setState(() {
                                    errorMobile = "Should Contain Only Digits";
                                  });
                                } else {
                                  setState(() {
                                    errorMobile = "";
                                  });
                                  if (value.length < 10) {
                                    setState(() {
                                      errorMobile =
                                          "Mobile number contains 10 digits";
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      (errorMobile != ''
                          ? Padding(
                              padding: const EdgeInsets.only(left: 85.0),
                              child: Text(
                                errorMobile,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container()),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 35, top: 15, right: 35, bottom: 10),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          'Gender',
                          style: font1,
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 50),
                        child: new Row(
                          children: <Widget>[
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemGender,
                              value: 'Male',
                              onChanged: (val) {
                                setState(() {
                                  radioItemGender = val;
                                  errorGender = "";
                                });
                              },
                            ),
                            new Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
                                child: new Text("Male", style: font2)),
                            new Radio(
                              activeColor:
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              groupValue: radioItemGender,
                              value: 'Female',
                              onChanged: (val) {
                                setState(() {
                                  radioItemGender = val;
                                  errorGender = "";
                                });
                              },
                            ),
                            new Text("Female", style: font2),
                          ],
                        ),
                      ),
                      (errorGender != ''
                          ? Padding(
                              padding: const EdgeInsets.only(left: 85.0),
                              child: Text(
                                errorGender,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container()),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 35, top: 15, right: 35, bottom: 10),
                        child: Center(
                          child: Container(
                            height: 55,
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(
                                          0xff, 0x1d, 0x22, 0x26),
                                      fontSize: 14),
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
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'Password (minimum 6 characters)'),
                              onChanged: (value) {
                                this.password = value;
                                // valid();
                                if (value.length < 6) {
                                  setState(() {
                                    errorPass =
                                        "Password must contain atleast 6 characters";
                                  });
                                } else {
                                  setState(() {
                                    errorPass = "";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      (errorPass != ''
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                              child: Text(
                                errorPass,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container()),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 35, top: 15, right: 35, bottom: 10),
                        child: Center(
                          child: Container(
                            height: 55,
                            child: TextField(
                              maxLength: 6,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(
                                          0xff, 0x1d, 0x22, 0x26),
                                      fontSize: 14),
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
                                  prefixIcon: Icon(Icons.my_location),
                                  hintText: 'Pin Code'),
                              onChanged: (value) {
                                this.code = value;
                                if (value.length < 6) {
                                  setState(() {
                                    errorCode = "Enter 6 digit pin code";
                                  });
                                } else {
                                  setState(() {
                                    errorCode = "";
                                  });
                                  getCityName(value).then((value1) {
                                    var arr = value1.split('+');
                                    if (arr[1] ==
                                        "Please Enter a Valid Pincode") {
                                      setState(() {
                                        errorCode =
                                            "Please Enter a Valid Pincode";
                                        cityName = "";
                                        areaName = "";
                                      });
                                    } else {
                                      setState(() {
                                        cityName = arr[1];
                                        areaName = arr[0];
                                      });
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      (errorCode != ''
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                              child: Text(
                                errorCode,
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container()),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 85, top: 10, right: 35, bottom: 10),
                          child: Text(
                            "Area : " + areaName,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                                fontSize: 16),
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 85, right: 35, bottom: 10),
                          child: Text(
                            "City : " + cityName,
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                                fontSize: 16),
                          )),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'By signing up, you agree with our ',
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(0xff, 0xa9, 0xa9, 0xa9),
                                fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Terms and conditions',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Color.fromARGB(
                                          0xff, 0x88, 0x02, 0x0b),
                                      fontSize: 12),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TermsConditionPage()))
                                        }),
                              TextSpan(
                                text: ' and ',
                                style: GoogleFonts.sourceSansPro(
                                    color:
                                        Color.fromARGB(0xff, 0xa9, 0xa9, 0xa9),
                                    fontSize: 12),
                              ),
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Color.fromARGB(
                                          0xff, 0x88, 0x02, 0x0b),
                                      fontSize: 12),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrivacyPolicyPage()))
                                        }),
                            ],
                          ),
                        ),
                      )
                          // padding: EdgeInsets.only(left:45,top:20,right: 35),

                          ),
                      (errorMsg != ''
                          ? Align(
                              alignment: Alignment.center,
                              child: Text(
                                errorMsg,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            )
                          : Container()),
                      (circularProgressReg
                          ? Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(
                                                  0xff, 0x88, 0x02, 0x0b)))),
                            )
                          : _buttonReg()),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already a user? ',
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(0xff, 0xa9, 0xa9, 0xa9),
                                fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login',
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        )
                                      },
                                style: GoogleFonts.sourceSansPro(
                                    color:
                                        Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      )
                          // padding: EdgeInsets.only(left:45,top:20,right: 35),
                          ),
                    ],
                  )),
                ),
              ),
            ),
          )
        : WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xfff7e9e9),
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
                    Center(
                      child: Text(
                        'Enter OTP',
                        style: GoogleFonts.ptSans(
                            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
                      height: 20,
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

  _button() {
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
                  } else {
                    Toast.show(
                        "No Internet!\nCheck your Connection or Try Again",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM);
                  }
                });
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

  _buttonReg() {
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
                    circularProgressReg = true;
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
              'Register',
              style: GoogleFonts.karla(
                  color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            textColor: Colors.white,
            elevation: 7,
            color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
      ),
    );
  }
}
