import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  final String uid;
  const History({Key key, this.uid}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState(uid);
}

class _HistoryState extends State<History> {
  final String uid;
  String date;
  List<DocumentSnapshot> doc;
  List<dynamic> list = List<dynamic>();
  _HistoryState(this.uid);

  Future<dynamic> getdata() async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('history')
        .getDocuments();
    doc = result.documents;

    //  print('Doc:--${doc[1]['history']}');
    list.clear();
    for (int i = 0; i < doc.length; i++) {
      for (int j = 0; j < doc[i]['history'].length; j++) {
        Map<String, dynamic> tmp = Map<String, dynamic>();
        tmp['mrname'] = doc[i]['history'][j]['mrname'];
        tmp['quantity'] = doc[i]['history'][j]['quantity'];
        tmp['brand'] = doc[i]['history'][j]['brand'];
        tmp['date'] = doc[i]['history'][j]['date'];
        list.add(tmp);
      }
    }
    print('$list');
    return doc;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  int nameflag = 1;
  String namecheck;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          doc;
        });
        return getdata();
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text('\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Bill History'),
          ),
          body: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext ctxt, int index) {
                if (index == 0) {
                  namecheck = list[index]['mrname'];
                  date = list[index]['date'];

                  nameflag = 1;
                } else {
                  if (namecheck == list[index]['mrname']) {
                    nameflag = 0;
                  } else {
                    nameflag = 1;
                    namecheck = list[index]['mrname'];
                    date = list[index]['date'];
                  }
                }
                return Column(
                  children: [
                    nameflag == 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 15.0),
                                  child: Divider(
                                    thickness: 5,
                                    height: 0,
                                    color: Colors.white54,
                                  )),
                            ],
                          )
                        : Container(),
                    nameflag == 1
                        ? Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              '${list[index]['mrname'].toUpperCase()}',
                              style: GoogleFonts.prompt(
                                  fontSize: 28,
                                  textStyle:
                                      TextStyle(color: Colors.amberAccent)),
                            ),
                          )
                        : Container(),
                    nameflag == 1
                        ? Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              '$date',
                              style: GoogleFonts.prompt(
                                  fontSize: 20,
                                  textStyle:
                                      TextStyle(color: Colors.lightGreen)),
                            ),
                          )
                        : Container(),
                    Row(
                      children: [
                        Text(
                          '\t\t${list[index]['brand']}',
                          style: GoogleFonts.staatliches(
                              fontSize: 28,
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 200),
                        Text(
                          'Quantity: ${list[index]['quantity']}',
                          style: GoogleFonts.dancingScript(
                              fontSize: 18,
                              textStyle: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 25.0),
                        child: Divider(
                          height: 0,
                          color: Colors.white54,
                        )),
                  ],
                );
              })),
    );
  }
}
