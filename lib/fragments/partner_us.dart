import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/Mail/send_mail.dart';
import 'package:kaamkhoj/Mail/sms_.dart';
import 'package:kaamkhoj/internetconnection/checkInternetConnection.dart';
import 'package:kaamkhoj/pincode/pincode.dart';
import 'package:kaamkhoj/test/thankyouform.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:validators/validators.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class PartnerUsPage extends StatefulWidget {
  String phoneNo;

  PartnerUsPage(String phoneNo) {
    this.phoneNo = phoneNo;
  }

  @override
  _PartnerUsPageState createState() => _PartnerUsPageState(phoneNo);
}

class _PartnerUsPageState extends State<PartnerUsPage> {
  String phoneNo = "", name = "", email = "", code = "";
  String phoneNo1;
  final databaseReference = Firestore.instance;

  String errorName = '';
  String errorEmail = '';
  String errorMobile = '';
  String errorCity = '';
  String errorCode = '';
  String smsOTP, type;
  String verificationId;
  String errorMsg = '';

  int _counter;
  Timer _timer;

  bool circularProgress = false;

  String cityName = "";

  String areaName = "";

  _PartnerUsPageState(String phoneNo1) {
    this.phoneNo1 = phoneNo1;
  }

  createRecord() async{


    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM yyyy').format(now);

    await databaseReference
        .collection("data")
        .document(phoneNo1)
        .collection("Partner")
        .document("data")
        .setData({
      'Number': phoneNo,
      'Name': name,
      'email': email,
      'pincode': code,
      'area': areaName,
      'city': cityName,
      'Date': formattedDate,

    });

    getMail(phoneNo1);
    makeSmsRequest(phoneNo1);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThankyouPage(phoneNo1)),
    );
  }

  void getMail(String phoneNo1) {
    DocumentReference documentReference =
        databaseReference.collection("data").document(phoneNo1);
    documentReference.get().then((datasnapshot) {
      sendMail(email, datasnapshot.data['Name'].toString());
      sendMailPartnerUsAdmin(
          datasnapshot.data['Name'].toString(),
          phoneNo1,
          datasnapshot.data['city'].toString(),
          phoneNo,
          name,
          email,
          cityName,
          areaName);
    });
  }

  void valid() {
    if ((name == "") || (email == "") || (phoneNo == "") || (code == "")) {
      setState(() {
        circularProgress = false;
      });
      String errorblank = "Please fill this field";
      if (name == "") {
        setState(() {
          errorName = errorblank;
        });
      }
      if (email == "") {
        setState(() {
          errorEmail = errorblank;
        });
      }
      if (phoneNo == "") {
        setState(() {
          errorMobile = errorblank;
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
          errorEmail == "" &&
          errorMobile == "" &&
          errorCode == "") {
        _startTimer();
      } else {
        setState(() {
          circularProgress = false;
        });
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  _startTimer() {
    _counter = 02;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          createRecord();
        }
      });
    });
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
          backgroundColor: Color(0xfff7e9e9),
          body: SingleChildScrollView(
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Partner Registration Form',
                      style: GoogleFonts.ptSans(
                          color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
                  child: Center(
                    child: Container(
                      height: 55,
                      child: TextField(
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.poppins(
                                color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
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
                            hintText: 'Name of Individual/Agency'),
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
                  padding:
                      EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
                  child: Center(
                    child: Container(
                      height: 55,
                      child: TextField(
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.poppins(
                                color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
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
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Agency Email ID'),
                        onChanged: (value) {
                          this.email = value.trim();
                          if (EmailValidator.validate(this.email)) {
                            setState(() {
                              errorEmail = "";
                            });
                          } else {
                            setState(() {
                              errorEmail = "Invalid Email Address";
                            });
                          }
                        },
                        // validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                        // onSaved: (email)=> _email = email,
                      ),
                    ),
                  ),
                ),
                (errorEmail != ''
                    ? Padding(
                        padding: const EdgeInsets.only(left: 85.0),
                        child: Text(
                          errorEmail,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Container()),
                Padding(
                  padding:
                      EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
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
                                color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
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
                            hintText: 'Agency Mobile No.'),
                        onChanged: (value) {
                          this.phoneNo = "+91" + value;
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
                  padding:
                      EdgeInsets.only(left: 35, top: 15, right: 35, bottom: 10),
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
                                color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
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
                              if (arr[1] == "Please Enter a Valid Pincode") {
                                setState(() {
                                  errorCode = "Please Enter a Valid Pincode";
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
                    padding: EdgeInsets.only(left: 85, right: 35, bottom: 10),
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
                              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                              fontSize: 12),
                        ),
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
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      )
                    : Container()),
                (circularProgress
                    ? Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                            child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b)))),
                      )
                    : _button()),
              ],
            )),
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
              'Submit',
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
