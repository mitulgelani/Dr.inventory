import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/screens/admin/Adminpost.dart';
import 'package:flutter_auths/screens/admin/Billpost.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../main.dart';

class AdminPortal extends StatefulWidget {
  final int deletebillflag;
  final FirebaseUser user;
  const AdminPortal({Key key, this.user, this.deletebillflag})
      : super(key: key);

  @override
  _AdminPortalState createState() => _AdminPortalState(user, deletebillflag);
}

class _AdminPortalState extends State<AdminPortal> {
  final FirebaseUser user;
  final int deletebillflag;
  _AdminPortalState(this.user, this.deletebillflag);

  SearchBar searchBar;
  List<Map<String, dynamic>> billlist = List<Map<String, dynamic>>();
  final db = Firestore.instance;
  List<DocumentSnapshot> documents;
  List<DocumentSnapshot> friends;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name, uid;
  List<Map<String, dynamic>> finallist = List<Map<String, dynamic>>();
  TextEditingController _searchQueryController = TextEditingController();
  TextEditingController mrname = TextEditingController();
  TextEditingController quan = TextEditingController();
  TextEditingController exd = TextEditingController();
  String brandforbill, uuidforbill;
  bool _isSearching = false, _show = false;
  String searchQuery = "Search query";
  List<Map<String, dynamic>> totalexq = List<Map<String, dynamic>>();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Try [Ex.Date:" dd-mm-yyyy " ]',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 26.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  void initState() {
    super.initState();
    getdata();
    setState(() {
      totalexq;
    });
    if (deletebillflag == 1) {
      billlist.clear();
    }
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            /*   if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              friends.clear();
              return;
            } */
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      _show = true;
      searchQuery = newQuery;
      postlist();
      print("form value ${finallist}");
    });
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
      postlist();
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  Future postlist() async {
    finallist.clear();

    for (var item in doc) {
      int searchflag = 0;
      List<String> dateseprate = List<String>();
      List<String> datesearch = List<String>();

      datesearch = _searchQueryController.text.split('-');

      if (datesearch.length > 1) {
        for (int z = 0; z < item['date'].length; z++) {
          for (var entry in item['date'][z].entries) {
            print('+++++++++');
            print('${entry.key}');
            print('+++++++++');

            dateseprate = entry.key.split('-');

            print('2+++++++++');
            print(dateseprate);
            print('+++++++++');

            if (int.parse(dateseprate[1]) == int.parse(datesearch[1])) {
              if (int.parse(dateseprate[0]) == int.parse(datesearch[0])) {
                searchflag = 1;
              } else if (int.parse(dateseprate[0]) < int.parse(datesearch[0])) {
                searchflag = 1;
              }
            } else if (int.parse(dateseprate[1]) < int.parse(datesearch[1])) {
              searchflag = 1;
            }
          }
        }
      }

      if (searchflag == 1 ||
          item['brand'].toLowerCase().contains(_searchQueryController.text) ||
          item['company'].toLowerCase().contains(_searchQueryController.text) ||
          item['contain'].toLowerCase().contains(_searchQueryController.text) ||
          item['form'].contains(_searchQueryController.text) ||
          item['mrname'].toLowerCase().contains(_searchQueryController.text) ||
          item['mrnumber'].contains(_searchQueryController.text) ||
          item['mrp'].contains(_searchQueryController.text) ||
          item['place'].toLowerCase().contains(_searchQueryController.text) ||
          item['strength']
              .toLowerCase()
              .contains(_searchQueryController.text)) {
        Map<String, dynamic> tmp = Map<String, dynamic>();
        tmp['cimage'] = item['cimage'];
        tmp['uuid'] = item['uuid'];
        tmp['brand'] = item['brand'];
        tmp['company'] = item['company'];
        tmp['contain'] = item['contain'];
        tmp['date'] = item['date'];
        tmp['quantity'] = item['quantity'];
        tmp['form'] = item['form'];
        tmp['mrname'] = item['mrname'];
        tmp['mrnumber'] = item['mrnumber'];
        tmp['mrp'] = item['mrp'];
        tmp['place'] = item['place'];
        tmp['strength'] = item['strength'];
        finallist.add(tmp);
      }
    }
  }

  Future getdata() async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('posts')
        .getDocuments();
    doc = result.documents;
    return doc;
  }

  List<DocumentSnapshot> doc;

  showAlertDialog(BuildContext context) {
    // set up the button
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                billlist.length > 0
                    ? Container()
                    : Padding(
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
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            labelText: "PATIENT NAME",
                            fillColor: Colors.black,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: TextFormField(
                    controller: exd,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    decoration: new InputDecoration(
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      labelText: "EX.  DATE",
                      hintText: 'MM-YY',
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(color: Colors.amber),
                      ),
                      //fillColor: Colors.green
                    ),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: TextFormField(
                    controller: quan,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    decoration: new InputDecoration(
                      prefixIcon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      labelText: "QUANTITY",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(color: Colors.amber),
                      ),
                      //fillColor: Colors.green
                    ),
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
                  padding: const EdgeInsets.all(2.0),
                  child: Text('\t\t\t\t\tEx.Date : Quantity',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                for (int i = 0; i < totalexq.length; i++)
                  for (String key in totalexq[i].keys)
                    Text(' ${key} : ${totalexq[i][key]}',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
      actions: [
        // ignore: deprecated_member_use
        Center(
          child: Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                final FormState form = _formKey.currentState;
                int flag = 1;
                if (form.validate()) {
                  DateTime selectedDate = DateTime.now();
                  final DateFormat formatter = DateFormat('dd-MM-yyyy');
                  final String formatted = formatter.format(selectedDate);
                  Map<String, dynamic> tmp = Map<String, dynamic>();
                  tmp['mrname'] = mrname.text;
                  tmp['exdate'] = exd.text;
                  tmp['quantity'] = quan.text;
                  tmp['brand'] = brandforbill;
                  tmp['uuid'] = uuidforbill;
                  tmp['date'] = formatted;
                  billlist.add(tmp);
                  quan.clear();
                  print(' adminportal :-- ');
                  print(billlist);
                  if (billlist.length == 0) mrname.clear();
                  Navigator.of(context).pop();
                }
              },
              child: billlist.length > 0
                  ? Text('ADD TO BILL')
                  : Text("MAKE A NEW BILL"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20)
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

  @override
  Widget build(BuildContext context) {
    var constraints;
    return RefreshIndicator(
      onRefresh: () async {
        final QuerySnapshot result = await Firestore.instance
            .collection('users')
            .document(user.uid)
            .collection('posts')
            .getDocuments();
        setState(() {
          doc = result.documents;
          totalexq;
        });
        return;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            leading: _isSearching
                // ignore: deprecated_member_use
                ? FlatButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                      });
                    },
                    child: Icon(Icons.arrow_back))
                : Container(),
            title:
                _isSearching ? _buildSearchField() : Text('Search Medicines'),
            actions: _buildActions(),
          ),
          floatingActionButton: FloatingActionButton(
              heroTag: 'hero1',
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        BillPost(billlist: billlist, uid: user.uid)));
              },
              child: Icon(
                Icons.sticky_note_2_rounded,
                color: Colors.white60,
              )),
          bottomNavigationBar: new BottomAppBar(
            color: Colors.white,
          ),
          body: Stack(
            children: [
              GridView.builder(
                itemCount: finallist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  String url = finallist[index]['cimage'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        brandforbill = finallist[index]['brand'];
                        uuidforbill = finallist[index]['uuid'];
                        totalexq = List.from(finallist[index]['date']);
                        //  print('${finallist[index]['date']}');
                      });
                      showAlertDialog(context);
                    },
                    onLongPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AdminPost(list: finallist[index], user: user)));
                    },
                    child: new Card(
                      child: new GridTile(
                          //  footer: new Text(finallist[index]['company']),
                          child: Card(
                        elevation: 5,
                        child: Stack(
                          children: <Widget>[
                            url == null
                                ? Container()
                                : Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(url,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.33,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.33,
                                          fit: BoxFit.fill),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.33,
                                      width: MediaQuery.of(context).size.width *
                                          0.33,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              stops: [
                                            0.09,
                                            1
                                          ],
                                              colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ])),
                                    ),
                                  ]),
                            Column(
                              children: [
                                SizedBox(height: 66),
                                Center(
                                  child: Container(
                                    child:
                                        Text('${finallist[index]["brand"]}\n',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.righteous(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: .5),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                            )),
                                  ),
                                ),
                                /*   Container(
                                  child: Text('Company Details:\n',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                          color: Colors.white)),
                                ), */
                              ],
                            )
                          ],
                        ),
                      ) //just for testing, will fill with image later
                          ),
                    ),
                  );
                },
              ),
              Container(
                child: Tooltip(
                  message: 'add Task',
                  textStyle: TextStyle(fontSize: 15, color: Colors.white),
                  child: new FloatingActionButton(
                    heroTag: 'hero2',
                    backgroundColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminPost(user: user)),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
          /* ListView.builder(
              itemCount: finallist.length,
              itemBuilder: (context, i) {
                return finallist.length == 0
                    ? Container()
                    : Text(
                        finallist[i]['brand'],
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      );
              },
            ) */

          /*  FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    /*       String cname = snapshot.data[i]['cname'];
                    String cdetail = snapshot.data[i]['cdetails'];
                    // ignore: deprecated_member_use
                    List<dynamic> semlist = List<dynamic>();
                    // ignore: deprecated_member_use
                    List<dynamic> branchlist = List<dynamic>();
                    semlist = snapshot.data[i]['sem'];
                    branchlist = snapshot.data[i]['branch']; */
                    String url = snapshot.data[i]['cimage'];
          
                    return Card(
                      elevation: 5,
                      child: Stack(
                        children: <Widget>[
                          url == null
                              ? Container()
                              : Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(url,
                                        height: MediaQuery.of(context).size.height *
                                            0.3,
                                        width:
                                            MediaQuery.of(context).size.width * 1,
                                        fit: BoxFit.fill),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.3,
                                    width: MediaQuery.of(context).size.width * 1,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            stops: [
                                          0.09,
                                          1
                                        ],
                                            colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ])),
                                  ),
                                ]),
                          Column(
                            children: [
                              SizedBox(height: 100),
                              Container(
                                child: Text('Company:\n',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white)),
                              ),
                              Container(
                                child: Text('Company Details:\n',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20,
                                        color: Colors.white)),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ) */
        ),
      ),
    );
  }
}
