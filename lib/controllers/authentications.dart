import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
FirebaseAuth auth = FirebaseAuth.instance;

/* showErrDialog(BuildContext context, String err) {
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text(
        "Error",
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        err,
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
 */
Future<FirebaseUser> signIn(
    String email, String password, BuildContext context) async {
  try {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    // return Future.value(true);
    if (user != null) return Future.value(user);
  } catch (e) {
    print(e.code);
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
     //   showErrDialog(context, e.code);
        break;
      case 'ERROR_WRONG_PASSWORD':
      //  showErrDialog(context, e.code);
        break;
      case 'ERROR_USER_NOT_FOUND':
       // showErrDialog(context, e.code);
        break;
      case 'ERROR_USER_DISABLED':
     //  showErrDialog(context, e.code);
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
      //  showErrDialog(context, e.code);
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
       // showErrDialog(context, e.code);
        break;
    }
    return Future.value(null);
  }
}

Future<FirebaseUser> signUp(
    String email, String password, BuildContext context) async {
  try {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return Future.value(user);
  } catch (error) {
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
       // showErrDialog(context, "Email Already Exists");
        break;
      case 'ERROR_INVALID_EMAIL':
      //  showErrDialog(context, "Invalid Email Address");
        break;
      case 'ERROR_WEAK_PASSWORD':
      //  showErrDialog(context, "Please Choose a stronger password");
        break;
    }
    return Future.value(null);
  }
}

Future<bool> signOutUser() async {
  FirebaseUser user = await auth.currentUser();
  await auth.signOut();
  return Future.value(true);
}