import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Forgotpassword extends StatelessWidget {
  TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Forgot password"),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  controller: editController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter the registered email",
                    border: OutlineInputBorder(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: RaisedButton(
                    onPressed: () {
                      resetPassword(context);
                    },
                    color: Colors.blue,
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void resetPassword(BuildContext context) async {
    if (editController.text.length == 0 || !editController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid email");
      return;
    }

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: editController.text);
    Fluttertoast.showToast(
        msg:
            "Reset password link has sent your mail please use it to change the password.");
    Navigator.pop(context);
  }
}
