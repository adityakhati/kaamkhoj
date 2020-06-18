import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamkhoj/NavigatorPages/navigatorPage.dart';

class RateCard extends StatelessWidget {
  var font1 = GoogleFonts.openSans(
      color: Color.fromARGB(0xff, 0x88, 0x02, 0x0b),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  var font2 = GoogleFonts.sourceSansPro(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);

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
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: ListView.builder(

          itemBuilder: (context, i) {
            if (i >= data.length) return null;
            return ExpansionTile(
                title: Text(
                  '${data[i].title}',
                  style: font1,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 3.0, 20.0, 3.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '${data[i].children[0].title}',
                                style: font2)
                          ])),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '${data[i].children[1].title}',
                              style: font2)
                        ])),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 3.0, 20.0, 3.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '${data[i].children[2].title}',
                                style: font2)
                          ])),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '${data[i].children[3].title}',
                              style: font2)
                        ])),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 3.0, 20.0, 3.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '${data[i].children[4].title}',
                                style: font2)
                          ])),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '${data[i].children[5].title}',
                              style: font2)
                        ])),
                      ],
                    ),
                  ),


//              RichText(
//                text: TextSpan(
//                  children: <TextSpan>[
//                    TextSpan(text: 'hello', style: TextStyle(color: Colors.red)),
//                    TextSpan(text: ' world', style: TextStyle(color: Colors.blue)),
//                  ],
//                ),
//              ),
////              Text('firstname: ${data[i].children[0].title}'),
//              Text('firstname: ${data[i].children[1].title}'),
//        ]
                ]);
          },
          itemCount: data.length,
        ),
      )),
    );
  }
}

class Entry {
  const Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

class ExpansionTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Expansion List'),
        // ),
        body: Column(
          children: [
            ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => EntryItem(
                data[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0,0),
              child: Text("The above rate card in only a rough indication and totally depends on the skill sets of the employee, work timings, experience, age  and the city of the employment so we have to keep all this in mind when negotiating the salary of the employees."),

            )
          ],
        ),
      ),
    );
  }
}

// This is the entire multi-level list displayed by this app
final List<Entry> data = <Entry>[
  Entry(
    'HouseMaid',
    <Entry>[
      Entry('8 Hours'),
      Entry('₹ 10000'),
      Entry('10 Hours'),
      Entry('₹ 12000'),
      Entry('24 Hours'),
      Entry('₹ 15000'),
    ],
  ),
  Entry(
    'Babysitting',
    <Entry>[
      Entry('8 Hours'),
      Entry('₹ 10000'),
      Entry('10 Hours'),
      Entry('₹ 12000'),
      Entry('24 Hours'),
      Entry('₹ 15000'),
    ],
  ),
  Entry('Cooking', <Entry>[
    Entry('8 Hours'),
    Entry('₹ 10000'),
    Entry('10 Hours'),
    Entry('₹ 12000'),
    Entry('24 Hours'),
    Entry('₹ 15000'),
  ]),
  Entry('Elder Care', <Entry>[
    Entry('8 Hours'),
    Entry('₹ 12000'),
    Entry('10 Hours'),
    Entry('₹ 14000'),
    Entry('24 Hours'),
    Entry('₹ 18000'),
  ]),
  Entry(
    'Driving',
    <Entry>[
      Entry('8 Hours'),
      Entry('₹ 14000'),
      Entry('10 Hours'),
      Entry('₹ 16000'),
      Entry('24 Hours'),
      Entry('₹ 18000'),
    ],
  ),
  Entry('Patient Care', <Entry>[
    Entry('8 Hours'),
    Entry('₹ 14000'),
    Entry('10 Hours'),
    Entry('₹ 16000'),
    Entry('24 Hours'),
    Entry('₹ 18000'),
  ]),
];

// Create the Widget for the row
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  // This function recursively creates the multi-level list rows.
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
