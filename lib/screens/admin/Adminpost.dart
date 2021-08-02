import 'dart:collection';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class AdminPost extends StatefulWidget {
  final Map<String, dynamic> list;
  final FirebaseUser user;

  const AdminPost({Key key, this.list, this.user}) : super(key: key);

  @override
  _AdminPostState createState() => _AdminPostState(list, user);
}

class _AdminPostState extends State<AdminPost> {
  final db = Firestore.instance;
  int updatedateflag = 0;
  int i;
  Map<String, String> bl = HashMap<String, String>();
  Map<String, String> sl = HashMap<String, String>();
  TextEditingController bn = TextEditingController();
  TextEditingController cn = TextEditingController();
  TextEditingController sn = TextEditingController();
  TextEditingController compn = TextEditingController();
  TextEditingController mrpn = TextEditingController();
  TextEditingController mrname = TextEditingController();
  TextEditingController mrnum = TextEditingController();
  TextEditingController quan = TextEditingController();
  TextEditingController placen = TextEditingController();
  String formvalue;
  int tap = 0;
  File _image1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String url1;
  int updateflag = 0;
  var uuid = Uuid();
  String date;
  DateTime selectedDate = DateTime.now();
  Map<String, dynamic> list;
  Map<String, dynamic> data = HashMap<String, dynamic>();
  final FirebaseUser user;
  _AdminPostState(this.list, this.user);

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        final String formatted = formatter.format(selectedDate);
        date = formatted;
      });
  }

  updatedata() {
    List<String> slist = List<String>();
    // ignore: deprecated_member_use
    List<String> blist = List<String>();
    data['brand'] = bn.text;
    data['contain'] = cn.text;
    for (String key in sl.keys) {
      slist.add(sl[key]);
    }
    data['uuid'] = list['uuid'];
    data['form'] = formvalue;
    data['strength'] = sn.text;
    data['company'] = compn.text;
    data['mrp'] = mrpn.text;
    data['mrname'] = mrname.text;
    data['mrnumber'] = mrnum.text;
    data['date'] = date;
    data['quantity'] = quan.text;
    data['place'] = placen.text;

    if (url1 != null)
      data['cimage'] = url1;
    else
      data['cimage'] = list['cimage'];

    db
        .collection("users")
        .document(user.uid)
        .collection("posts")
        .document(data['uuid'])
        .updateData(data);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  uploadImage() async {
    //  print('////////////////////////////////////////// netreed');

    final StorageReference postImageRef = FirebaseStorage.instance
        .ref()
        .child('gs://placementapp-b2e98.appspot.com');

    var timeKey = new DateTime.now();

    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".jpg").putFile(_image1);

    // ignore: non_constant_identifier_names

    var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    url1 = ImageUrl.toString();
    data['cimage'] = url1;
    tap++;
    if (updateflag == 0) {
      db
          .collection('users')
          .document(user.uid)
          .collection('posts')
          .document(data['uuid'])
          .setData(data);
    }
  }

  uploaddata() {
    print('@@@@///// URL1 image url ${data['cimage']} ${url1}');
    // ignore: deprecated_member_use
    List<String> slist = List<String>();
    // ignore: deprecated_member_use
    List<String> blist = List<String>();
    data['brand'] = bn.text;
    data['contain'] = cn.text;
    for (String key in sl.keys) {
      slist.add(sl[key]);
    }

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(selectedDate);

    data['uuid'] = uuid.v1();
    data['form'] = formvalue;
    data['strength'] = sn.text;
    data['company'] = compn.text;
    data['mrp'] = mrpn.text;
    data['mrname'] = mrname.text;
    data['mrnumber'] = mrnum.text;
    data['date'] = formatted;
    data['quantity'] = quan.text.toString();
    data['place'] = placen.text;

    print('URL:------- ${data['cimage']} ${url1}');
  }

  // ignore: deprecated_member_use
  List<Map<String, double>> rolepackage = List<HashMap<String, double>>();

  Future getImage1() async {
    // ignore: deprecated_member_use
    final Image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 75);
    setState(() {
      _image1 = Image;
    });
  }

  Future getImagecamera() async {
    final Image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 60);
    setState(() {
      _image1 = Image;
    });
  }

  Widget form() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(children: <Widget>[
          Text(" FORM ",
              style: TextStyle(
                fontSize: 23,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    //color: Colors.blue[100],
                    border: Border.all(
                      width: 0.3,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(0),
                    shadowColor: Colors.green,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 5.0, top: 5.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    DropdownButton(
                                      items: [
                                        DropdownMenuItem(
                                            value: "susp",
                                            child: Center(
                                              child: Text("SUSP",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        DropdownMenuItem(
                                            value: "tab",
                                            child: Center(
                                              child: Text("TAB",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        DropdownMenuItem(
                                            value: "drops",
                                            child: Center(
                                              child: Text("DROPS",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        DropdownMenuItem(
                                            value: "sup",
                                            child: Center(
                                              child: Text("SUP",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                        DropdownMenuItem(
                                            value: "inj",
                                            child: Center(
                                              child: Text("INJ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  )),
                                            )),
                                      ],
                                      onChanged: (_value) {
                                        setState(() {
                                          formvalue = _value;
                                          //csc.text = _value;
                                        });
                                      },
                                      hint: Text(" Select A FORM ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          )),
                                      // enabled: !_status,
                                      // autofocus: !_status,
                                    )
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Flexible(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                      ),
                                      child: new Text(
                                        '$formvalue',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      )),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )))
        ]));
  }

  showAlertDialog2(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      height: 50,
      child: Row(
        children: [
          Icon(Icons.camera_alt),
          Text("\t\tCamera", style: TextStyle(fontSize: 20)),
        ],
      ),
      onPressed: () {
        getImagecamera();
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      height: 50,
      child: Row(
        children: [
          Icon(Icons.image),
          Text("\t\tGallery", style: TextStyle(fontSize: 20)),
        ],
      ),
      onPressed: () async {
        getImage1();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          Icon(Icons.camera, color: Colors.yellow),
          Text(
            "\t\t\tUpload Image",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: cancelButton,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: continueButton,
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Delete"),
      onPressed: () async {
        await db
            .collection("users")
            .document(user.uid)
            .collection("posts")
            .document(list['uuid'])
            .delete();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          Icon(Icons.warning_rounded, color: Colors.yellow),
          Text(
            "Are You Sure to delete this Record?",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  initState() {
    super.initState();
    i = 0;
    if (list != null) {
      setState(() {
        formvalue = list['form'];
      });
      bn.text = list['brand'];
      cn.text = list['contain'];
      sn.text = list['strength'];
      compn.text = list['company'];
      mrpn.text = list['mrp'];
      mrname.text = list['mrname'];
      mrnum.text = list['mrnumber'];
      quan.text = list['quantity'];
      placen.text = list['place'];
      date = list['date'];
      updateflag = 1;
    }
  }

  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          floatingActionButton: Tooltip(
            message: 'add image',
            textStyle: TextStyle(fontSize: 15, color: Colors.white),
            child: new FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                if (tap == 0) {
                  showAlertDialog2(context);
                } else {
                  Fluttertoast.showToast(
                    msg: "only one image allowed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                }
              },
              child: const Icon(Icons.image, color: Colors.black54),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          bottomNavigationBar: new BottomAppBar(
            color: Colors.white,
          ),
          appBar: AppBar(
            //automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            title: Text(
              "Medicine Details",
              style: GoogleFonts.pattaya(fontSize: 30),
            ),
            centerTitle: true,
            elevation: 10,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: bn,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "Enter BRAND Name",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Brand cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: cn,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "CONTAIN",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "contain cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    /////////////////////////////////

                    SizedBox(height: 30),
                    //Branch(),
                    form(),

                    SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: sn,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "STRENGTH",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "strength cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: compn,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "COMPANY",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Company Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                      ),
                    ),

                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: mrpn,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "MRP",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "mrp Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: mrname,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "MR. Name",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "mrname Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: mrnum,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "MR's Number",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "mrnum Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                        child: _image1 == null
                            ? Container()
                            : Column(children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0, right: 5.0, top: 5.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              ' Image',
                                              style: TextStyle(
                                                fontSize: 23.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                // SizedBox(height: 5),
                                Container(
                                    padding: EdgeInsets.all(8),
                                    height: 350,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Image.file(
                                              _image1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.91,
                                              height: 350,
                                            ),
                                          ));
                                        })),
                              ])),

                    SizedBox(height: 30),
                    Text('Expiry Date:',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 30),
                    list != null
                        ? Text(
                            list['date'],
                            style: TextStyle(
                                fontSize: 55,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(
                                fontSize: 55,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(height: 15),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        "Select Ex. Date",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),

                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: quan,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "QUANTITY",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "quantity Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: TextFormField(
                        controller: placen,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: new InputDecoration(
                          labelText: "PLACE",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Place Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    updateflag == 1
                        ? Column(
                            children: [
                              Container(
                                width: 300,
                                height: 44,
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  onPressed: () {
                                    final FormState form =
                                        _formKey.currentState;

                                    if (form.validate()) {
                                      updatedata();
                                      Navigator.of(context).pop();
                                    } else {
                                      print('Form is invalid');
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.blue,
                                  child: Text(
                                    "UPDATE",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 300,
                                height: 44,
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.red,
                                  child: Text(
                                    "DELETE",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : Container(
                            width: 300,
                            height: 40,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              onPressed: () {
                                final FormState form = _formKey.currentState;
                                if (form.validate()) {
                                  uploadImage();
                                  uploaddata();
                                  Navigator.of(context).pop();
                                } else {
                                  print('Form is invalid');
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.blue,
                              child: Text(
                                "POST",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
