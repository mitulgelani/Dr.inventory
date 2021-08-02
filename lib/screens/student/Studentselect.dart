import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Studenthome.dart';


class Studentselect extends StatefulWidget {
  final FirebaseUser user;

  const Studentselect({Key key, this.user}) : super(key: key);
  @override
  _StudentselectState createState() => _StudentselectState();
}

class _StudentselectState extends State<Studentselect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Companies",
          style: GoogleFonts.itim(
            textStyle: TextStyle(
              fontSize: 29,
              color: Colors.orange[300],
            ),
          ),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Hi"),
          ],
        ),
      ),
    );
  }
}
