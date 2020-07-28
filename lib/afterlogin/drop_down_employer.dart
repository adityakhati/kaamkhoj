import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/test/employee_form1.dart';
import 'package:kaamkhoj/test/employer_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';
import 'package:toast/toast.dart';

class ChooseYourWorkEmployer extends StatefulWidget {
  String type, phoneNo;


    ChooseYourWorkEmployer(String work, String phoneNo) {
      this.type = work;
      this.phoneNo = phoneNo;
    }
  @override
  ChooseYourWorkState createState() => ChooseYourWorkState(type,phoneNo);
}

class User {
  int userId;
  String firstName;

  User({this.userId, this.firstName = ""});

  static List<User> getUsers() {
    return <User>[
      User(userId: 1, firstName: "Babysitter/बेबीसिटर"),
      User(userId: 2, firstName: "Cook/रसोइया"),
      User(userId: 3, firstName: "Domestic Helper/घरेलू सहायक"),
      User(userId: 4, firstName: "Housemaid/नौकरानी"),
      User(userId: 5, firstName: "Home Tutions/घर ट्यूशन"),
      User(userId: 6, firstName: "Japa Maid/जापा नौकरानी"),
      User(userId: 7, firstName: "Nanny/दाई "),
      User(userId: 8, firstName: "Patient Care/रोगी की देखभाल "),
      User(userId: 9, firstName: "Office Boy/पीअन"),
      User(userId: 10, firstName: "Carpenter/बढ़ई"),
      User(userId: 11, firstName: "Computer Operator/कंप्यूटर ऑपरेटर"),
      User(userId: 12, firstName: "Couple/युगल"),
      User(userId: 13, firstName: "Data Entry Operator/तथ्य दाखिला प्रचालक"),
      User(userId: 14, firstName: "Delivery Boy/वितरण लड़का"),
      User(userId: 15, firstName: "Driver/चालक"),
      User(userId: 16, firstName: "Electrician/बिजली मिस्त्री"),
      User(userId: 17, firstName: "Helper/सहायक"),
      User(userId: 18, firstName: "House Boy/घर लड़का"),
      User(userId: 19, firstName: "House Supervisor/घर पर्यवेक्षक"),
      User(userId: 20, firstName: "Mason/मकान बनाने वाला"),
      User(userId: 21, firstName: "Nurse/नर्स"),
      User(userId: 22, firstName: "Office Assistant/कार्यालय सहायक"),
      User(userId: 23, firstName: "Painter/पेंटर"),
      User(userId: 24, firstName: "Peon/चपरासी"),
      User(userId: 25, firstName: "Plumber/नलसाज"),
      User(userId: 26, firstName: "Salesman/विक्रेता"),
      User(userId: 27, firstName: "Security Guard/सुरक्षा कर्मी"),
    ];
  }
}

Widget _buildTitle(String type) {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          (type == "Employer"
              ? Text(
                  'Do you want an Employee? \nSelect one of the following',
                  style: font1,
                  textAlign: TextAlign.center,
                )
              : Text('Do you need any job? \nSelect one of the following',
                  style: font1, textAlign: TextAlign.center)),
        ],
      ));
}

class ChooseYourWorkState extends State<ChooseYourWorkEmployer> {
  List<User> users;
  User selectedUser;
  int selectedRadio;
  int selectedRadioTile;

  String type, phoneNo;

  bool circularProgress = false;

  String errorMsg = "";

  ChooseYourWorkState(String type,String phoneNo) {
    this.type = type;
    this.phoneNo = phoneNo;
  }

  @override
  void initState() {
    super.initState();
//    getStringValuesSF();
    selectedRadio = 0;
    selectedRadioTile = 0;
    users = User.getUsers();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    phoneNo = prefs.getString('Login');
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setSelectedUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }

  List<Widget> createRadioListUsers() {
    var font2 = GoogleFonts.sourceSansPro(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
    List<Widget> widgets = [];
    for (User user in users) {
      widgets.add(
        RadioListTile(
          value: user,
          groupValue: selectedUser,
          title: Text(user.firstName, style: font2),
          onChanged: (currentUser) {
            setSelectedUser(currentUser);
          },
          selected: selectedUser == user,
          activeColor: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    var font1 = GoogleFonts.openSans(
        color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
        fontSize: 18,
        fontWeight: FontWeight.bold);
    var font2 = GoogleFonts.sourceSansPro(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
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
            body: Container(
              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildTitle(type),
                    Container(
                      padding: EdgeInsets.all(20.0),
                    ),
                    Column(
                      children: createRadioListUsers(),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(children: <Widget>[
                  (errorMsg != ''
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                          child: Text(
                            errorMsg,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Container()),
                  (circularProgress
                      ? Center(
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(0xff, 0x88, 0x02, 0x0b))))
                      : _button()),
                ]))),
      ),
    );
  }

  _button() {
    return ButtonTheme(
        height: 40,
        minWidth: MediaQuery.of(context).size.width - 10,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
              onPressed: () {
                if (selectedUser == null) {
                  Toast.show("Please Select A Job", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                } else {
                  if (type == "Employer") {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EmployerForm(selectedUser.firstName, phoneNo)),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EmployeeForm(selectedUser.firstName, phoneNo)),
                    );
                  }
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
