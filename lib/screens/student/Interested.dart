import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'Studenthome.dart';
import 'package:expansion_card/expansion_card.dart';


class Interested extends StatefulWidget {
  

  @override
  _InterestedState createState() => _InterestedState();
}

class _InterestedState extends State<Interested> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "TCS",
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
            border: Border.all(
              width: 2,
              color: Colors.orange[300],
            ),
            borderRadius: BorderRadius.circular(20.0)
           ),
          child: Column(
            children:<Widget>[
              //SizedBox(height: 30),
                 Padding(
                    padding:EdgeInsets.only(top:15.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Full Name of the student:",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 25.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:5.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Shiladityasinh Bharatsinh Gohil",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,  
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:20.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Branch of the student:",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 25.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:5.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Information Technology",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,  
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:20.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Semester of the student:",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 25.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:5.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "6",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,  
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:20.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Email of the student:",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 25.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:5.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "18ituos090@ddu.ac.in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,  
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:20.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Contact details of the student:",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 25.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:5.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "6352996626",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,  
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:20.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "College ID of the student:",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 25.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:5.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "18ITUOS090",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,  
                      ),
                    )
                    ),
                  ),Padding(
                    padding:EdgeInsets.only(top:20.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Expected Year of Graduation:",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 25.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:5.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "2022",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,  
                      ),
                    )
                    ),
                  ),Padding(
                    padding:EdgeInsets.only(top:20.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "Permanent Address of the student:",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 25.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "C-1285, opp Sagwadi gate , Kaliyabid, Bhavnagar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,  
                      ),
                    )
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child:Align(
                      alignment: Alignment.center,
                      child:Text(
                        "*All the details are taken from those entered in the student profile, verify before submitting the details*",
                      style: TextStyle(
                        color: Colors.orange[200],
                        fontSize: 20.0,  
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    ),
                  ),
                 Padding(
                    padding:EdgeInsets.symmetric(horizontal:15.0, vertical: 15.0),
                    child: TextFormField(
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter the CPI upto the current/previous semester"),
                           validator: (val) {
                        if (val.length == 0) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                   Padding(
                    padding:EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: TextFormField(
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter the no. of Backlogs/Remedial (if any)"),
                           validator: (val) {
                        if (val.length == 0) {
                          return "Cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:20.0),
                  child:RaisedButton(
                  onPressed: (){},
                  color: Colors.yellow,
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                 ),
                ),
            ]
          ),
        ),
      ),
    );
  }
}