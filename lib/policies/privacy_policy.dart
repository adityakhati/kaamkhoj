import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:kaamkhoj/loginresgiter/Register.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
  var font3 = GoogleFonts.sourceSansPro(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
       fontSize: 16, fontWeight: FontWeight.normal);
  var font4 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  
  @override
  Widget build(BuildContext context) {
  Future<bool> _onBackPressed() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[_column()]),
                ))),
      ),
    );
  }


  _launchURL() async {
    String url = "http://www.kaamkhoj.co.in/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  _launchURLEmail() async {
    String url="mailto:customercare@kaamkhoj.co.in?subject=&body=";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
  Widget _column() {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: Text('Privacy Policy', style: font1, textAlign: TextAlign.justify)),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'Effective date: October 02, 2018',
                  style: font2,
                  textAlign: TextAlign.justify),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      'Kaamkhoj ("us", "we", or "our") operates the',
                  style: font2,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' http://kaamkhoj.co.in/',
                        style: font3,
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => {_launchURL()},
                        ),
                    TextSpan(
                        text:
                            ' website and the Kaamkhoj mobile application (the "Service").',style: font2,),
                   ],
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Service and the choices you have associated with that data. Our Privacy Policy for Kaamkhoj is managed through Free Privacy Policy.',
                  style: font2,
                  textAlign: TextAlign.justify),
               Container(margin: EdgeInsets.only(bottom: 10)),
              Text('We use your data to provide and improve the Service. By using the Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.',
                  style: font2, textAlign: TextAlign.justify),
                  Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
                  Text('Information Collection And Use', style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('We collect several different types of information for various purposes to provide and improve our Service to you.',
                  style: font2, textAlign: TextAlign.justify),
               Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
                  Text('Types of Data Collected', style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Center(
                child: Text('Personal Data',
                    style: font4, textAlign: TextAlign.justify),
              ),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you ("Personal Data"). Personally identifiable information may include, but is not limited to:',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Email address',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  '• First name and last name',
                  style: font2,
                  textAlign: TextAlign.justify),
                  Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Phone number',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Address, State, Province, ZIP/Postal code, City',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• Cookies and Usage Data',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Center(
                child: Text(
                    'Usage Data',
                    style: font4,
                    textAlign: TextAlign.justify),
              ),
                  Container(margin: EdgeInsets.only(bottom: 10)),
              Text('We may also collect information that your browser sends whenever you visit our Service or when you access the Service by or through a mobile device ("Usage Data").',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('This Usage Data may include information such as your computer\'s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that you visit, the time and date of your visit, the time spent on those pages, unique device identifiers and other diagnostic data.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('When you access the Service by or through a mobile device, this Usage Data may include information such as the type of mobile device you use, your mobile device unique ID, the IP address of your mobile device, your mobile operating system, the type of mobile Internet browser you use, unique device identifiers and other diagnostic data.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Center(
                child: Text(
                    'Tracking & Cookies Data',
                    style: font4,
                    textAlign: TextAlign.justify),
              ),
                  Container(margin: EdgeInsets.only(bottom: 10)),
              Text('We use cookies and similar tracking technologies to track the activity on our Service and hold certain information.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Cookies are files with small amount of data which may include an anonymous unique identifier. Cookies are sent to your browser from a website and stored on your device. Tracking technologies also used are beacons, tags, and scripts to collect and track information and to improve and analyze our Service.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our Service.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'Examples of Cookies we use:',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      '• Session Cookies.',
                  style: font4,
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            ' We use Session Cookies to operate our Service.',
                        style: font2),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10)),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      '• Preference Cookies.',
                  style: font4,
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            ' We use Preference Cookies to remember your preferences and various settings.',
                        style: font2),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10)),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      '• Security Cookies.',
                  style: font4,
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            ' We use Security Cookies for security purposes.',
                        style: font2),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
              Text('Use of Data',
                  style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Kaamkhoj uses the collected data for various purposes:',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  '• To provide and maintain the Service',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• To notify you about changes to our Service',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• To allow you to participate in interactive features of our Service when you choose to do so',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  '• To provide customer care and support',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• To provide analysis or valuable information so that we can improve the Service',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• To monitor the usage of the Service',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  '• To detect, prevent and address technical issues',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
              Text('Transfer Of Data',
                  style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Your information, including Personal Data, may be transferred to — and maintained on — computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from your jurisdiction.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'If you are located outside India and choose to provide information to us, please note that we transfer the data, including Personal Data, to India and process it there.',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Your consent to this Privacy Policy followed by your submission of such information represents your agreement to that transfer.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Kaamkhoj will take all steps reasonably necessary to ensure that your data is treated securely and in accordance with this Privacy Policy and no transfer of your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of your data and other personal information.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10,top: 10)),
              Text(
                  'Disclosure of Data \nLegal Requirements',
                  style: font1,
                  textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'Kaamkhoj may disclose your Personal Data in the good faith belief that such action is necessary to:',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• To comply with a legal obligation',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• To protect and defend the rights or property of Kaamkhoj',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  '• To prevent or investigate possible wrongdoing in connection with the Service',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• To protect the personal safety of users of the Service or the public',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('• To protect against legal liability',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10,top: 10)),
              Text(
                  'Security Of Data',
                  style: font1,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('The security of your data is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
              Text('Service Providers',
                  style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'We may employ third party companies and individuals to facilitate our Service ("Service Providers"), to provide the Service on our behalf, to perform Service-related services or to assist us in analyzing how our Service is used.',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('These third parties have access to your Personal Data only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
              Text('Links To Other Sites',
                  style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'Our Service may contain links to other sites that are not operated by us. If you click on a third party link, you will be directed to that third party\'s site. We strongly advise you to review the Privacy Policy of every site you visit.',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
              Text('Children\'s Privacy',
                  style: font1, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'Our Service does not address anyone under the age of 18 ("Children").',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('We do not knowingly collect personally identifiable information from anyone under the age of 18. If you are a parent or guardian and you are aware that your Children has provided us with Personal Data, please contact us. If we become aware that we have collected Personal Data from children without verification of parental consent, we take steps to remove that information from our servers.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('Changes To This Privacy Policy',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text(
                  'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
                  style: font2,
                  textAlign: TextAlign.justify),
            Container(margin: EdgeInsets.only(bottom: 10)),
              Text('We will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and update the "effective date" at the top of this Privacy Policy.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(bottom: 10)),
              Text('You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
                  style: font2, textAlign: TextAlign.justify),
              Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
              Text(
                  'Contact Us',
                  style: font1,
                  textAlign: TextAlign.justify),
                  Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
                  RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      'By email:',
                  style: font2,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' customercare@kaamkhoj.co.in',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {_launchURLEmail()}
                        ),
                    
                  ],
                ),
              ),
                Container(margin: EdgeInsets.only(top: 10,bottom: 10)),
                  RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      'By phone number:',
                  style: font2,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' 022-66661414',
                        style: font3,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => {launch("tel://02266661414")}
                        ),
                    
                  ],
                ),
              ),
                        ]));
  }
}
