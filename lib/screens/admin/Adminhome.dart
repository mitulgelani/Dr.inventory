import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/pages/loginScreen.dart';
import 'package:flutter_auths/screens/admin/Adminprofile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Adminhome extends StatefulWidget {
  final FirebaseUser user;

  const Adminhome({Key key, this.user}) : super(key: key);
  @override
  _AdminhomeState createState() => _AdminhomeState(user);
}

class _AdminhomeState extends State<Adminhome> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  String name, email;
  _AdminhomeState(this.user);
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
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[300],
        title: Text(
          "Placement App-Admin",
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
            onTap: () {},
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
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          //Adminhome(),
          //Status(),
          Adminprofile(),
        ],
        onPageChanged: (pageIndex) {
          setState(() {
            currentIndex = pageIndex;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
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
      ),
    );
    
  }
}
