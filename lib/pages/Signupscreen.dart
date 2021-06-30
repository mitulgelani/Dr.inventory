import 'package:flutter/material.dart';
import 'package:flutter_auths/controllers/authentications.dart';
import 'package:flutter_auths/main.dart';
import 'package:flutter_auths/pages/Loginscreen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:placementapp/main.dart';

class Signupscreen extends StatefulWidget {
  @override
  _SignupscreenState createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  String email, password;
  String name;
  final db = Firestore.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignUp() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signUp(email.trim(), password, context).then((user) async {
        if (user != null) {
          await db.collection('users').document(user.uid).setData({
            'name': name,
            'email': email,
            'uid': user.uid,
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(uid: user.uid),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[300],
        title: Text(
          "Placement App",
          style: GoogleFonts.pattaya(fontSize: 30),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "SignUp!",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Nick Name"),
                    onChanged: (val) {
                      name = val;
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email:"),
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return "Please fill up this field";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password:"),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "This is a Required Field"),
                          MinLengthValidator(6,
                              errorText: "Minimum 6 Characters are Required"),
                        ]),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 25.0),
                        child: SizedBox(
                          height: 50,
                          width: 100,
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: handleSignUp,
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("Already have an account?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0))),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Loginscreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
