import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/screens/student/Interested.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'Studenthome.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

class Studentportal extends StatefulWidget {
  final FirebaseUser user;

  const Studentportal({Key key, this.user}) : super(key: key);

  @override
  _StudentportalState createState() => _StudentportalState();
}

class _StudentportalState extends State<Studentportal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Companies",
          style: GoogleFonts.courgette(
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
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            //gradient: FlutterGradients.newYork(),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: ImageSlideshow(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.width * 0.45,
                        initialPage: 0,
                        indicatorColor: Colors.orange[300],
                        indicatorBackgroundColor: Colors.white,
                        children: [
                          ClipRect(
                            child: Image.asset(
                              'assets/tcs.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          ClipRect(
                            child: Image.asset(
                              'assets/mg.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          ClipRect(
                            child: Image.asset(
                              'assets/ril.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          ClipRect(
                            child: Image.asset(
                              'assets/lnt.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          ClipRect(
                            child: Image.asset(
                              'assets/worley.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ],
                        autoPlayInterval: 3000,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    gradient: FlutterGradients.leCocktail(), //flyingLemon(),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      "\t\t\t\t\t\t \t\tRecent Posts",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //ui of post
                        ListTile(
                          title: Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: MediaQuery.of(context).size.width * 0.50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage("assets/tcs.png"),
                              ),
                            ),
                          ),
                          subtitle: ExpansionTile(
                            expandedAlignment: Alignment.center,
                            //backgroundColor: Colors.amber,
                            title: Text(
                              'Tata Consultancy Services',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25.0,
                              ),
                            ),
                            subtitle: Text(
                              "Mon 10 Jun 2021",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15.0,
                              ),
                            ),

                            children: <Widget>[
                              Text(
                                'TCS and its 67 subsidiaries provide a wide range of information technology-related products and services including application development, business process outsourcing, capacity planning, consulting, enterprise software, hardware sizing, payment processing, software management, and technology education services.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Branch:  Information Technology, Computer Engineering",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 25.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Students who can apply:  Semester 5,6",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 25.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Role(s) on offer: Software developer, Quality Assurance",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(top: 25.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Salary Packages for respective role(s) : 4LPA, 3LPA",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(top: 25.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Criteria: Only the students above 7.0 CPI should apply\nNo backlogs or Remedials",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Interested()),
                                    );
                                  },
                                  color: Colors.yellow,
                                  child: Text(
                                    "Interested",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
