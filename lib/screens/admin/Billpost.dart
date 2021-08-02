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
      List<List<Map<String, dynamic>>>();
  final String uid;
  String name;
  initState() {
    super.initState();
    setState(() {
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
                            setState(() {
                              for (int i = 0; i < billlist.length; i++) {
                                String uuid = billlist[i]['uuid'];
                                double quantmp;
                                double tmp =
                                    double.parse(billlist[i]['quantity']);
                                final Future<DocumentSnapshot> document =
                                    Firestore.instance
                                        .collection('users')
                                        .document(uid)
                                        .collection("posts")
                                        .document(billlist[i]['uuid'])
                                        .get();
                                document
                                    .then<dynamic>((DocumentSnapshot snapshot) {
                                  quantmp =
                                      double.parse(snapshot.data['quantity']);

                                  quantmp = quantmp - tmp;
                                  String tmp2 = quantmp.toString();

                                  Firestore.instance
                                      .collection("users")
                                      .document(uid)
                                      .collection("posts")
                                      .document(uuid)
                                      .updateData({'quantity': tmp2});
                                });
                              }
                              Map<String, dynamic> histmp =
                                  Map<String, dynamic>();
                              histmp['history'] = billlist;
                              Firestore.instance
                                  .collection('users')
                                  .document(uid)
                                  .collection('history')
                                  .add(histmp);
                            });
                            billlist.clear();

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
