import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaamkhoj/Mail/send_mail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'savepdf.dart';

class PdfGenerator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final pdf = pw.Document();
  writeOnPdf() async {
    // final pw.Document doc =
    // pw.Document(title: 'My Résumé', author: 'David PHAM-VAN');

    final PdfImage profileImage = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load('assets/images/logo2.png'))
          .buffer
          .asUint8List(),
    );
    final PdfImage signature = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load('assets/images/Capture.png'))
          .buffer
          .asUint8List(),
    );
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Column(children: [
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          child: pw.Column(children: [
                        pw.Container(
                          height: 100,
                          padding: const pw.EdgeInsets.only(left: 20),
                          alignment: pw.Alignment.topLeft,
                          child: pw.Image(profileImage),
                        ),
                        pw.Container(
                            padding: const pw.EdgeInsets.only(left: 20),
                            alignment: pw.Alignment.topLeft,
                            child: pw.Text(
                              "Kaamkhoj",
                            ))
                      ])),
                      pw.Expanded(
                          child: pw.Container(
                        padding: const pw.EdgeInsets.only(left: 20),
                        alignment: pw.Alignment.topRight,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("54, mamta A wing"),
                            pw.Text("A.M. Marg"),
                            pw.Text("Prabhadevi"),
                            pw.Text("Mumbai-400025"),
                            pw.Text("Tel:022-66661414/022-66661314"),
                            pw.Text("Website:www.kaamkhoj.co.in"),
                            pw.Text("Email:info@kaamkhoj.co.in"),
                          ],
                        ),
                      ))
                    ]),
                pw.Container(
                    alignment: pw.Alignment.topLeft,
                    padding: const pw.EdgeInsets.only(top: 20),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Date:"),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 10, bottom: 20),
                            child: pw.Text("Invoice No."),
                          ),
                          pw.Text("To,"),
                          pw.Text("   Mrs name"),
                          pw.Text("   City"),
                          pw.Padding(padding: pw.EdgeInsets.only(top: 20)),
                          pw.Table.fromTextArray(
                              context: context,
                              data: const <List<String>>[
                                <String>['Sr No', 'DESCRIPTION', ' ', 'AMOUNT'],
                                <String>['1', 'Registration fee', ' ', '1000'],
                                <String>[
                                  ' ',
                                  'Amount paid',
                                  'SUBTOTAL',
                                  '1000'
                                ],
                                <String>[' ', 'Amount in words', ' ', ' '],
                              ]),
                          pw.Padding(padding: pw.EdgeInsets.only(top: 10)),
                          pw.Text(
                              "The payee of this bill agrees to all the terms and conditions given on the mobile application/website of www.kaamkhoj.in"),
                          pw.Text("Bank Details"),
                          pw.Text("Account Type:- Current Account"),
                          pw.Text("Account No.:045183800000388"),
                          pw.Text("IFSC Code: YESB0000451"),
                          pw.Text("Bank Name: Yes Bank"),
                          pw.Text("Beneficiary Name: kaamkhojin"),
                          pw.Text("Branch: Parel( Mumbai)"),
                          // pw.Container(
                          //   height: 100,
                          //   // padding: const pw.EdgeInsets.only(top: 10),
                          //   alignment: pw.Alignment.topLeft,
                          //   child: pw.Image(signature),
                          // ),
                        ]))
              ]))
        ];
        // <pw.Widget>[
        //   pw.Header(level: 0, child: pw.Text("Easy Approach Document")),
        //   pw.Paragraph(
        //       text:
        //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        //   pw.Paragraph(
        //       text:
        //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        //   pw.Header(level: 1, child: pw.Text("Second Heading")),
        //   pw.Paragraph(
        //       text:
        //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        //   pw.Paragraph(
        //       text:
        //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        //   pw.Paragraph(
        //       text:
        //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        // ];
      },
    ));
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());

    print("Iniside Aditya");

    // sendMailReceipt("kuldeep.c@somaiya.edu", file);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Flutter"),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "PDF TUTORIAL",
              style: TextStyle(fontSize: 34),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          writeOnPdf();
          await savePdf();

          Directory documentDirectory =
              await getApplicationDocumentsDirectory();

          String documentPath = documentDirectory.path;

          String fullPath = "$documentPath/example.pdf";

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PdfPreviewScreen(
                        path: fullPath,
                      )));
        },
        child: Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
