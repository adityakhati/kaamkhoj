import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/loginresgiter/Register.dart';
class TermsConditionPage extends StatelessWidget {
  var font1 = GoogleFonts.sourceSansPro(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal);
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
            width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover
                )
              ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[_buildTitle(),_column(),_buildTitle1(),_column1()]
            ),
          ),
          )
        ),
      ),
    ) ;
  }
  Widget _buildTitle(){
    return Container(margin: EdgeInsets.only(top:10), 
    child: Center(
      child:Text('General Terms for Employee',style: GoogleFonts.openSans(
                      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
    ),);
  }
  Widget _column(){
    return Container(
      margin: EdgeInsets.all(16),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Before the selection by the employer it will be the sole responsibility of the employee to check the employers background, documents and references.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible for any misdeed committed by the employer or the employers family ,relation, friends, acquaintance etc in any manner whatsoever.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible in any manner whatsoever for any dispute that may arise between the employee and employer.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any loss, damage, misdeed committed by the employee will attract suitable legal action by the employer.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any advance payment or monetary transaction with employer will be at the employees risk.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Employees will be given two paid holidays per month. The employer & employee can decide when these holidays can to be taken.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in is not responsible to look into the matter of Employees like Annual Leave/Monthly Leave/Replacement of employee, Medical/Work Timings/ Type of job/ Salary/ increment of salary and any other miscellaneous issues. All these issues will be settled between the employer and the employee.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• kaamkhoj.co.in will not be responsible for any negligence of the employer in any manner whatsoever.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Under this agreement it is deemed that the employee has read, understood and agrees to all the terms and conditions mentioned in this Agreement.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),        
        Text('• Under this agreement it is deemed that the employee has read, understood and agrees to all the terms and conditions mentioned in this Agreement',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• All the documents submitted by the employee to the employer are true to the best of the employees knowledge.',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• The employee applying for a job should be above the age of eighteen',textAlign: TextAlign.justify,style: font1,),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any disputes that may arise will be settled in the courts at Mumbai.',textAlign: TextAlign.justify,style: font1,),
            
      ]
    )
    );
  }
  Widget _buildTitle1(){
    return Container(margin: EdgeInsets.only(top:10), 
    child: Center(
      child:Text('General Terms for Employer',style: GoogleFonts.openSans(
                      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
    ),);
  }
  Widget _column1(){
    return Container(
      margin: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text("• This page states the \"Terms of Use\" under which you (\"You\") may use kaamkhoj.co.in \' an online service to post and search employment opportunities and user resumes These Terms of use includes the kaamkhoj.co.in Privacy Policy which is incorporated in to the website . By using kaamkhoj.co.in, you are indicating your acceptance to be bound by these Terms of use, including the Kaamkhoj Privacy Policy. Please read this page carefully. If You do not accept the Terms of Use stated herein, do not use the website and its services by using kaamkhoj.co.in, you are indicating your acceptance to be bound by the provisions of these terms of Use (\"Kaamkhoj\" or the \"Company\") may revise these Terms of Use at any time by updating this posting. You should visit this page periodically to review the Terms of Use, because they are binding on You. The terms \"You\" and \"User\" as used herein refer to all individuals and/or entities accessing the website Kaamkhoj.co.in for any reason. Kaamkhoj may revise these Terms at any time by posting an updated version to this Web page. You should visit this page periodically review the most current Terms because they are binding on You.",style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• This document is published in accordance with the provisions of rule 3(1) of the information technology act (intermediary guidelines) rule 2011 that requires publishing the rules and regulations privacy policy and terms of use for access or usage of www.kaamkhoj.co.in website. Kaamkhoj.co.in only acts as an intermediary between the employer and the employee.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Kaamkhoj.co.in will charge one month salary of the employee plus taxes. Only in the case of drivers we charge Rupees Five thousand plus taxes.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Kaamkhoj.co.in will charge an amount of Rs.1000 as registration charges before sending the employee on a trial. The amount will be "refundable" incase if we do not provide you with the services. This amount is completely adjustable against our consultancy fee in case you select the employee. however the registration amount cannot be adjusted against the salary of the employee during the trail period. Kaamkhoj will send you a maximum of three employees against this registration charges.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• During the trial the employer has to pay the employee for the number of days they have worked .Kaamkhoj will offer other options however the employer has to pay the employee on a pro-rata basis for the number of days that the employee has worked.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• The trial period cannot be extended beyond two days and it will be deemed that the employer has hired the employee. If the trial continuous for more than 2 days the registration amount of Rs.1000 paid will automatically stand adjusted against the consultancy charges. If the employer does not select the employee after the trial of 2 days Kaamkhoj will offer other options',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Before the selection of the employee it will be the sole responsibility of the employer to collect and verify the employees documents. It is the responsibility of the employer to satisfy themselves of the suitability of the employee before hiring them. If required the employer may arrange medical examinations of the employee prior to hiring them.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Police verification of the employee will be the sole responsibility of the employer. This ensures that the employee is free of any criminal charges in the past. At any given point of time if there is any crime done by the employee (Civil or criminal), Kaamkhoj.co.in would not be responsible for the same.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• The employer has to give us the \'job description\' of the type of work the employee needs to do and the salary offered. The employer cannot make the Employee do anything outside the job description nor reduce the salary of the employee. If the employee leaves because the employer asked her/him to do anything outside the job description or due to reduction of the salary then Kaamkhoj.co.in will not replace the employee and neither refund the consultancy charges paid by the employer.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),        
        Text('• Kaamkhoj.co.in will offer a maximum of three free replacements within three months from the date the employee is hired. however the employer has to first pay the salary of the old employee for the number of days they have worked before a replacement is given. During the 3 months of replacement time, if you wish to cancel the contract for any reason, the consultancy charges paid to us will not be refunded. However if the employee leaves the job any time after three months we will offer you a 25% discount on your next registration with Kaamkhoj.co.in',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• In case if you do not like the current employee kindly give us a prior notice of 15 days before you release `the employee so that we can find another employee for you. The employee which has been sent for replacement cannot be offered less salary than the first employee. Also the job description or work required to do by the employee cannot be changed by the employer. In case if you wish to release the employee or the employee leaves the job and you wish to take a replacement then you need to clear the salary dues of the previous employee before a replacement is sent. If the salary of the previous employee is not cleared, we will not be sending a replacement.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Introduction should be kept strictly confidential. If Kaamkhoj.co.in introduces the employee that the employer then introduces to a third party, who hires the employee on either full time or part time, the employer agrees to pay Kaamkhoj.co.in the consultancy charges.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Kaamkhoj.co.in will not be responsible in any manner whatsoever for any dispute that may arise between the employer and employee.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any advance payment or monetary transaction with employees will be at the employer’s risk.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• The employer will check the bags, purse or any other thing that the maid is carrying before the maid enters the home and before the maid leaves the home.',style: font1,textAlign: TextAlign.justify),            
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Employees should be given two paid holidays per month. The employer & employee can decide when these holidays should to be taken.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Kaamkhoj.co.in is not responsible to look into the matter like Annual Leave/Medical/ /increment of Salary and any other miscellaneous issues all these issues will be settled between the employer and the employee.',style: font1,textAlign: TextAlign.justify),      
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Kaamkhoj.co.in does not authenticate any documents of the employee provided to the employer.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Kaamkhoj.co.in will not be responsible for any negligence of the employee in any manner whatsoever.',style: font1,textAlign: TextAlign.justify),        
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• The employer will be solely responsible for any misdeed committed by them or their family members, relations, friends or any person known to the employer',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• These services are not renewable so the employer does not have to pay Kaamkhoj.co.in any annual renewal charges.',style: font1,textAlign: TextAlign.justify),        
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• If any employee is recruited outside the country we will charge two month’s salary of the employee. However since we are only an intermediary we do not arrange any travel documents of the employee.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• If the employee leaves the job let us say after two months then the replacement period will continue only for the balance one month but if for any reason the employer wants to cancel the contract no refund will be made.',style: font1,textAlign: TextAlign.justify),        
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• We do not offer any kind of temporary replacement if the employee goes on leave.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• We advise our employers just as a precaution to keep your valuables in a safe place under lock and key and do not leave any valuables lying around.',style: font1,textAlign: TextAlign.justify),        
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• In case if you are hiring a driver Kaamkhoj will not be responsible for any mishap that may take place during the trial or during the employee tenure at work.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• In order to elevate our customer experience our office will also function on Sundays between 10.00 am to 6.00pm.',style: font1,textAlign: TextAlign.justify),        
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• For any grievances you can call our office 022-66661314 anytime between 10am to 8pm.',style: font1,textAlign: TextAlign.justify),
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Under this agreement it is deemed that you have read, understood and agreed to all the terms and conditions mentioned.',style: font1,textAlign: TextAlign.justify),        
        Container(margin: EdgeInsets.only(bottom: 10) ),
        Text('• Any disputes that may arise will be settled in the courts at Mumbai.',style: font1,textAlign: TextAlign.justify),        
        
        
        ]
    )
    );
  }

}
