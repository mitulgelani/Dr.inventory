import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/main.dart';
import 'package:flutter_auths/screens/admin/Adminhome.dart';
import 'package:flutter_auths/screens/admin/Adminportal.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class BillPost extends StatefulWidget {
  final List<Map<String, dynamic>> billlist;
  final String uid;

  const BillPost({Key key, this.billlist, this.uid}) : super(key: key);

  @override
  _BillPostState createState() => _BillPostState(billlist, uid);
}

class _BillPostState extends State<BillPost> {
  final List<Map<String, dynamic>> billlist;
  List<List<Map<String, dynamic>>> histortlist =
      // ignore: deprecated_member_use
      List<List<Map<String, dynamic>>>();
  final String uid;
  String name;
  initState() {
    super.initState();
    setState(() {
      print('/////');
      print(billlist);
      print('/////');
      if (billlist.length > 0) name = billlist[0]['mrname'];
    });
  }

  _BillPostState(this.billlist, this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              billlist.length != 0 ? Text(" \t\t$name's Bill") : Text('Bill'),
          actions: [
            GestureDetector(
              onTap: () {
                billlist.clear();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            uid: uid,
                          )),
                );
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 30,
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: billlist.length != 0
            ? Stack(
                children: [
                  ListView.builder(
                    itemCount: billlist.length ?? 0,
                    itemBuilder: (context, i) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: ListTile(
                            title: Column(
                          children: [
                            SizedBox(height: 0),
                            Text(
                              billlist[i]['brand'],
                              style: GoogleFonts.staatliches(
                                  fontSize: 35,
                                  textStyle: TextStyle(color: Colors.white)),
                            ),
                            Text(
                              'Quantity: ${billlist[i]['quantity']}',
                              style: GoogleFonts.dancingScript(
                                  fontSize: 18,
                                  textStyle: TextStyle(color: Colors.white)),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 15.0),
                                child: Divider(
                                  color: Colors.white54,
                                )),
                          ],
                        )),
                        secondaryActions: <Widget>[
                          new IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              setState(() {});
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 680),
                    // ignore: deprecated_member_use
                    child: Container(
                      width: 700,
                      height: 60,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                          color: Colors.green,
                          onPressed: () {
                            List<List<Map<String, dynamic>>> exquan =
                                // ignore: deprecated_member_use
                                List<List<Map<String, dynamic>>>();
                            for (int i = 0; i < billlist.length; i++) {
                              final Future<DocumentSnapshot> document =
                                  Firestore.instance
                                      .collection('users')
                                      .document(uid)
                                      .collection("posts")
                                      .document(billlist[i]['uuid'])
                                      .get();
                              document
                                  .then<dynamic>((DocumentSnapshot snapshot) {
                                exquan.add(List.from(snapshot.data['date']));
                              });
                            }
                            Timer(Duration(seconds: 3), () {
                              print("print after every 3 seconds");
                              print(exquan);
                              print('hahahahahahaha');

                              for (int i = 0; i < billlist.length; i++) {
                                String uuid = billlist[i]['uuid'];
                                print(billlist);
                                print('^^^^^^^^^^^^^^^^^');

                                double tmp =
                                    double.parse(billlist[i]['quantity']);
                                //   print('oo yeh : ${billlist[i]['exdate']}');

                                String key = billlist[i]['exdate'];
                                print('key : $key');

                                for (int j = 0; j < exquan.length; j++) {
                                  for (int i = 0; i < exquan[j].length; i++) {
                                    for (var entry in exquan[j][i].entries) {
                                      print('----%%------${exquan[j][i][key]}');
                                      if (entry.key == key) {
                                        double tmp2 =
                                            double.parse(exquan[j][i][key]) -
                                                tmp;
                                        exquan[j][i][key] = tmp2.toString();

                                        Timer(Duration(seconds: 2), () {
                                          print('---------------');
                                          print(exquan[j][i]);
                                          print('---------------');
                                          List<Map<String, dynamic>> extmp =
                                              List<Map<String, dynamic>>();

                                          for (int k = 0;
                                              k < exquan.length;
                                              k++) {
                                            for (int l = 0;
                                                l < exquan[k].length;
                                                l++) {
                                              for (var entry
                                                  in exquan[k][l].entries) {
                                                print('counter');
                                                Map<String, dynamic> tmp =
                                                    Map<String, dynamic>();
                                                tmp[entry.key] = entry.value;
                                                extmp.add(tmp);
                                              }
                                            }
                                          }
                                          print('+++++++++++++');
                                          print(extmp);
                                          print('+++++++++++++');

                                          Firestore.instance
                                              .collection("users")
                                              .document(uid)
                                              .collection("posts")
                                              .document(uuid)
                                              .updateData({'date': extmp});
                                        });
                                      }
                                    }
                                  }
                                }
                                Map<String, dynamic> histmp =
                                    Map<String, dynamic>();
                                histmp['history'] = billlist;
                                Firestore.instance
                                    .collection('users')
                                    .document(uid)
                                    .collection('history')
                                    .add(histmp);
                              }
                              billlist.clear();
                            });

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        uid: uid,
                                      )),
                            );
                          },
                          child: Text(
                            'Payment Clear',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  "No Item Added",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ));
  }
}
