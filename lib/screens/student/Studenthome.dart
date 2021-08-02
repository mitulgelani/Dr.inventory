import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/pages/About.dart';
import 'package:flutter_auths/pages/Loginscreen.dart';
import 'package:flutter_auths/screens/student/Studentportal.dart';
import 'package:flutter_auths/screens/student/Studentprofile.dart';
import 'package:flutter_auths/screens/student/Studentselect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Studenthome extends StatefulWidget {
  final FirebaseUser user;

  const Studenthome({Key key, this.user}) : super(key: key);
  @override
  _StudenthomeState createState() => _StudenthomeState();
}

class _StudenthomeState extends State<Studenthome> {

  final PageController _pageController = PageController();
  String name, email;
  int currentindex = 0;
 /* _StudenthomeState(this.user);
  final db = Firestore.instance;
  Future<DocumentSnapshot> document;
  Future<void> getdata() async {
    document = Firestore.instance.collection('users').document(user.uid).get();
    document.then<dynamic>((DocumentSnapshot snapshot) async {
      if (mounted) {
        setState(() {
          name = snapshot.data['name'];
          email = user.email;
        });
      }
    });
    return;
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        title: Text(
          "Placement App-Student",
          style: GoogleFonts.courgette(                          //pacifico       
            textStyle: TextStyle(
                fontSize: 29,
                color: Colors.orange[300],
              ),
            ),       
        ),
        centerTitle: true,
        elevation: 10,
      ),
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              '$name',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            accountEmail: Text(
              '$email',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "S",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "About",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.info,
              color: Colors.blueAccent,
            ),
            onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About()),
              );
            },
          ),
          ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.logout,
                color: Colors.blueAccent,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Loginscreen()));
              }),
          InkWell(
            borderRadius: BorderRadius.circular(500),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.redAccent),
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentindex,
        backgroundColor: Colors.grey[900],
        onItemSelected: (index) {
          setState(() {
            currentindex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.orange[300]),
            ),
            activeColor: Colors.orange[300],
            inactiveColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.assistant_photo),
            title: Text(
              'Selected',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            activeColor: Colors.orange[300],
            inactiveColor: Colors.white,
          ),
         BottomNavyBarItem(
            icon: Icon(Icons.account_circle_rounded),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 20),
            ),
            activeColor: Colors.orange[300],
            inactiveColor: Colors.white,
          ),
        ],
      ),
      body: PageView(
        //allowImplicitScrolling: true,
        controller: _pageController,
        children: <Widget>[
          Studentportal(),
          Studentselect(),
          Studentprofile(),
        ],
        onPageChanged: (pageIndex) {
          setState(() {
            currentindex = pageIndex;
          });
        },
      )
     );
  }
}
