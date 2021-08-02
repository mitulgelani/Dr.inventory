import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/pages/About.dart';
import 'package:flutter_auths/pages/Loginscreen.dart';
import 'package:flutter_auths/screens/admin/Adminportal.dart';
import 'package:flutter_auths/screens/admin/Adminprofile.dart';
import 'package:flutter_auths/screens/admin/History.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Adminhome extends StatefulWidget {
  final FirebaseUser user;
  final int deletebillflag;

  const Adminhome({Key key, this.user, this.deletebillflag}) : super(key: key);
  @override
  _AdminhomeState createState() => _AdminhomeState(user, deletebillflag);
}

class _AdminhomeState extends State<Adminhome> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  String name, email;
  final int deletebillflag;

  _AdminhomeState(this.user, this.deletebillflag);
  final db = Firestore.instance;
  Future<DocumentSnapshot> document;
  String tmp;

  Future<void> getdata() async {
    document =
        Firestore.instance.collection('userdata').document(user.uid).get();
    document.then<dynamic>((DocumentSnapshot snapshot) async {
      if (mounted) {
        setState(() {
          name = snapshot.data['name'];
          email = user.email;
          tmp = name[0];
        });
      }
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => History(uid: user.uid)));
            },
            child: Icon(
              Icons.list_alt_rounded,
            ),
          ),
          SizedBox(width: 20)
        ],
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        title: Text(
          "Dr-Inventory",
          style: GoogleFonts.pattaya(fontSize: 30),
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
                "$tmp",
                style: TextStyle(
                  fontSize: 27,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          /*  ListTile(
            title: Text(
              "Generate PDF",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.analytics_outlined,
              color: Colors.blueAccent,
            ),
            onTap: () {},
          ), */
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => About()));
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
          /* ListTile(
              title: Text(
                "Student Section",
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
                    MaterialPageRoute(builder: (context) => Studenthome()));
              }),*/
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
      body: Stack(children: [
        AdminPortal(
          user: user,
        ),
      ]),
      /* PageView(
        controller: _pageController,
        children: <Widget>[
          AdminPortal(),
          //  AdminPortal(),
          Adminprofile(),
        ],
        onPageChanged: (pageIndex) {
          setState(() {
            currentIndex = pageIndex;
          });
        },
      ), */
      /* bottomNavigationBar: BottomNavyBar(
        animationDuration: Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        curve: Curves.easeInCubic,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.add_box),
            title: Text("add"),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),
          /*BottomNavyBarItem(
            icon: Icon(Icons.timer),
            title: Text("status"),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),*/
          BottomNavyBarItem(
            icon: Icon(Icons.account_box),
            title: Text("profile"),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),
        ],
      ), */
    );
  }
}
