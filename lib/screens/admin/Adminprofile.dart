import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/pages/Loginscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'Adminhome.dart';
//import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Adminprofile extends StatefulWidget {
  final FirebaseUser user;
 

  const Adminprofile({Key key, this.user}) : super(key: key);
  @override
  _AdminprofileState createState() => _AdminprofileState(user);
}

class _AdminprofileState extends State<Adminprofile> {
  final FirebaseUser user;
  File _image1;
  String uid;
  _AdminprofileState(this.user);
  bool _status = true;
  final db = Firestore.instance;
/*Map<String, dynamic> data2;
Future<DocumentSnapshot> document;*/


Future getImage1() async {
    final image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 60);
    setState(() {
      _image1 = image;
    });
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();
  TextEditingController fnc = TextEditingController();
  TextEditingController lnc = TextEditingController();
  TextEditingController ec = TextEditingController();
  TextEditingController mc = TextEditingController();
  TextEditingController bc = TextEditingController();
  TextEditingController ac = TextEditingController();
  TextEditingController dc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return; //getdata();
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text(
          "Profile",
          style: GoogleFonts.pattaya(fontSize: 30),
        ),
        centerTitle: true,
        elevation: 10,
      ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                 Container(
                child: _image1 == null
                  ? Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(
                        fit: StackFit.loose,
                        children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: new ExactAssetImage(
                                          'assets/profile.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      getImage1();
                                    },
                                    child: new CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  :
                  Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(
                        fit: StackFit.loose,
                        children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: new ExactAssetImage('_image1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 90.0, right: 100.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      getImage1();
                                    },
                                    child: new CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )),      
                Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 25.0, top: 10.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Personal Information',
                              style: TextStyle(
                                  fontSize: 27.0,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // _status ? _getEditIcon() : new Container(),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
                    //autovalidate: true,
                    child: new Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        //color: Colors.blue[100],
                        border: Border.all(
                          width: 0.5,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(10),
                        shadowColor: Colors.blue,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'First Name',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 0.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          controller: fnc,
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your First Name",
                                          ),
                                          keyboardType: TextInputType.name,
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.orange[300],
                                            ),
                                          ),
                                          autofocus: !_status,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    " This Field Is Required"),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Last Name',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 0.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          controller: lnc,
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your Last Name",
                                          ),
                                          keyboardType: TextInputType.name,
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.orange[300],
                                            ),
                                          ),
                                          autofocus: !_status,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    " This Field Is Required"),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Email ID',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.blue[500],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 0.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          controller: ec,
                                          decoration: const InputDecoration(
                                            hintText: "Email Id",
                                          ),
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.orange[300],
                                            ),
                                          ),
                                          autofocus: !_status,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    " This Field Is Required"),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Mobile Number',
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 0.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: mc,
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your mobile number",
                                        ),
                                        keyboardType: TextInputType.phone,
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.orange[300],
                                          ),
                                        ),
                                        autofocus: !_status,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  " This Field Is Required"),
                                          MinLengthValidator(10,
                                              errorText: ' 10 Digits Required'),
                                          MaxLengthValidator(10,
                                              errorText: ' Only 10 Digits')
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Branch',
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 0.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: bc,
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your Branch",
                                        ),
                                        keyboardType: TextInputType.number,
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.orange[300],
                                          ),
                                        ),
                                        autofocus: !_status,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  " This Field Is Required"),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Designation',
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 0.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: dc,
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your Designation",
                                        ),
                                        keyboardType: TextInputType.number,
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.orange[300],
                                          ),
                                        ),
                                        autofocus: !_status,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  " This Field Is Required"),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Address',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.blue[500],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 0.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          maxLines: null,
                                          controller: ac,
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your Address",
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.orange[300],
                                            ),
                                          ),
                                          autofocus: !_status,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    " This Field Is Required"),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )),
                                  Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 45.0,
                                      top: 35.0,
                                      bottom: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          RaisedButton(
                                            onPressed: () {},
                                            color: Colors.blue,
                                            splashColor: Colors.amber,
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 75.0,
                                      right: 25.0,
                                      top: 35.0,
                                      bottom: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          RaisedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Loginscreen()));
                                            },
                                            color: Colors.blue,
                                            splashColor: Colors.amber,
                                            child: Text(
                                              "Logout",
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                              //!_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ],
            ),    
            ),
          ),
        ),
    );
  }
}
