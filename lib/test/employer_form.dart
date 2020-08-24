import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/Mail/send_mail.dart';
import 'package:kaamkhoj/Mail/sms_.dart';
import 'package:kaamkhoj/fragments/payment.dart';
import 'package:kaamkhoj/internetconnection/checkInternetConnection.dart';
import 'package:kaamkhoj/pincode/pincode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

class EmployerForm extends StatelessWidget {
  String work;
  String phoneNo;

  EmployerForm(String work, String phoneNo) {
    this.work = work;
    this.phoneNo = phoneNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Radiobutton(work, phoneNo),
      ),
    );
  }
}

class Radiobutton extends StatefulWidget {
  String work, phoneNo;

  Radiobutton(String work, String phoneNo) {
    this.work = work;
    this.phoneNo = phoneNo;
  }

  @override
  RadioButtonWidget createState() => RadioButtonWidget(work, phoneNo);
}

class RadioButtonWidget extends State {
  String radioItemHrs = '';
  String radioItemReligion = '';
  String work, phoneNo;
  String errorGender = '';
  String city = '';
  String code = '';
  String email = '';
  String errorCity = '';
  String errorCode = '';
  String errorEmail = '';
  String radioItemGender = "";

  bool circularProgress = false;

  final databaseReference = Firestore.instance;

  String areaName = "", cityName = "";

  int _counter;
  Timer _timer;

  RadioButtonWidget(String work, String phoneNo) {
    this.work = work;
    this.phoneNo = phoneNo;
  }

  void createRecord() async {
    print("createRecord" + phoneNo);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM yyyy').format(now);
    final databaseReference = Firestore.instance;

    final snapShot = await Firestore.instance
        .collection("data")
        .document(phoneNo)
        .collection("Employer")
        .document("0")
        .get();

    if (snapShot == null || !snapShot.exists) {
      await databaseReference
          .collection("data")
          .document(phoneNo)
          .collection("Employer")
          .document("0")
          .setData({
        'Hrs': radioItemHrs,
        'Religion': radioItemReligion,
        'Work': work,
        'Code': code,
        'Email': email,
        'Gender': radioItemGender,
        'Date': formattedDate,
        'area': areaName,
        'city': cityName,
      });
    } else {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection("data")
          .document(phoneNo)
          .collection("Employer")
          .getDocuments();
      var list = querySnapshot.documents;

      await databaseReference
          .collection("data")
          .document(phoneNo)
          .collection("Employer")
          .document(list.length.toString())
          .setData({
        'Hrs': radioItemHrs,
        'Religion': radioItemReligion,
        'Work': work,
        'Email': email,
        'Code': code,
        'Gender': radioItemGender,
        'Date': formattedDate,
        'area': areaName,
        'city': cityName,
      });
    }
    getMail(phoneNo);
    makeSmsRequest(phoneNo);
    addStringToSF(email);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(),
        ));
  }

  addStringToSF(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Email', email);
  }

  void getMail(String phoneNo1) {
    DocumentReference documentReference =
        databaseReference.collection("data").document(phoneNo1);
    documentReference.get().then((datasnapshot) {
      sendMail(email, datasnapshot.data['Name'].toString());
      sendMailEmployerAdmin(
          datasnapshot.data['Name'].toString(),
          datasnapshot.data['Gender'].toString(),
          phoneNo1,
          datasnapshot.data['city'].toString(),
          radioItemHrs,
          radioItemReligion,
          work,
          cityName,
          areaName,
          email,
          radioItemGender);
    });
  }

  bool valid() {
    if (email == '' || (code == "")) {
      setState(() {
        circularProgress = false;
      });
      String errorblank = "Please fill this field";
      if (email == "") {
        setState(() {
          errorEmail = errorblank;
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
      if (errorEmail == "" && errorCode == "") {
        return true;
      } else {
        Toast.show("Please fill all the fields correctly", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
    return false;
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
          if (errorCode == "") {
            createRecord();
          } else {
            setState(() {
              circularProgress = false;
            });
          }
        }
      });
    });
  }

  Widget build(BuildContext context) {
    var font1 = GoogleFonts.openSans(
        color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        fontSize: 18,
        fontWeight: FontWeight.bold);
    var font2 = GoogleFonts.sourceSansPro(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 60, bottom: 60, right: 23, left: 23),
                child: Container(
                  padding:
                      EdgeInsets.only(top: 40, bottom: 20, right: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.png"),
                          fit: BoxFit.cover)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select Employee Gender',
                            style: font1,
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: 10),
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
                                  });
                                },
                              ),
                              new Text("Female", style: font2),
                            ],
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: 10),
                          child: new Row(
                            children: <Widget>[
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemGender,
                                value: 'Any',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemGender = val;
                                  });
                                },
                              ),
                              new Container(
                                  margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: new Text("Any", style: font2)),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select Hours',
                            style: font1,
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: 10),
                          child: new Row(
                            children: <Widget>[
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemHrs,
                                value: '4 Hours',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemHrs = val;
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
                                child: new Text("4 Hours", style: font2),
                              ),
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemHrs,
                                value: '8 Hours',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemHrs = val;
                                  });
                                },
                              ),
                              new Text("8 Hours", style: font2),
                            ],
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: 10),
                          child: new Row(
                            children: <Widget>[
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemHrs,
                                value: '12 Hours',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemHrs = val;
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
                                child: new Text("12 Hours", style: font2),
                              ),
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemHrs,
                                value: '24 Hours',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemHrs = val;
                                  });
                                },
                              ),
                              new Text("24 Hours", style: font2),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select Employee Religion',
                            style: font1,
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: 10),
                          child: new Row(
                            children: <Widget>[
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemReligion,
                                value: 'Hindu',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemReligion = val;
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
                                child: new Text("Hindu", style: font2),
                              ),
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemReligion,
                                value: 'Christian',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemReligion = val;
                                  });
                                },
                              ),
                              new Text("Christian", style: font2),
                            ],
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: 10),
                          child: new Row(
                            children: <Widget>[
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemReligion,
                                value: 'Muslim',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemReligion = val;
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
                                child: new Text("Muslim", style: font2),
                              ),
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemReligion,
                                value: 'Jain',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemReligion = val;
                                  });
                                },
                              ),
                              new Text("Jain", style: font2),
                            ],
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: 10),
                          child: new Row(
                            children: <Widget>[
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemReligion,
                                value: 'Sikh',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemReligion = val;
                                  });
                                },
                              ),
                              new Container(
                                margin: EdgeInsets.fromLTRB(1, 0, 10, 0),
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 100),
                                child: new Text("Sikh", style: font2),
                              ),
                              new Radio(
                                activeColor:
                                    Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                                groupValue: radioItemReligion,
                                value: 'Any',
                                onChanged: (val) {
                                  setState(() {
                                    radioItemReligion = val;
                                  });
                                },
                              ),
                              new Text("Any", style: font2),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
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
                                    prefixIcon: Icon(Icons.email),
                                    hintText: 'Email ID'),
                                onChanged: (value) {
                                  this.email = value.trim();
                                  // valid();
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
                          padding: EdgeInsets.only(top: 15, bottom: 10),
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
                                left: 55, top: 10, right: 35, bottom: 10),
                            child: Text(
                              "Area : " + areaName,
                              style: GoogleFonts.poppins(
                                  color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                                  fontSize: 16),
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 55, right: 35, bottom: 10),
                            child: Text(
                              "City : " + cityName,
                              style: GoogleFonts.poppins(
                                  color: Color.fromARGB(0xff, 0x1d, 0x22, 0x26),
                                  fontSize: 16),
                            )),
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
                      ]),
                ),
              ),
            ),
          )),
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
                if (valid()) {
                  check_internet().then((intenet) {
                    if (intenet != null && intenet) {
                      if (radioItemHrs == '' ||
                          radioItemReligion == '' ||
                          radioItemGender == '') {
                        Toast.show("Please fill all the fields", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      } else {
                        setState(() {
                          circularProgress = true;
                        });
                        _startTimer();
                      }
                    } else {
                      Toast.show(
                          "No Internet!\nCheck your Connection or Try Again",
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM);
                    }
                  });
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Submit',
                style: GoogleFonts.karla(
                    color: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              elevation: 7,
              color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b)),
        ));
  }
}
