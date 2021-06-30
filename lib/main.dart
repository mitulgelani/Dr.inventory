//hello world
import 'package:flutter/material.dart';
import 'package:flutter_auths/pages/loginScreen.dart';
import 'package:flutter_auths/screens/admin/Adminhome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

const String boxname = '';
Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Placement App",
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: GoogleFonts.darkerGrotesqueTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.darkerGrotesqueTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
    /*AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Placement App',
        theme: theme,
        darkTheme: darkTheme,
        home: HomePage(),
      ),
    );*/
  }
}

class HomePage extends StatefulWidget {

  
  final String uid;
  const HomePage({Key key, this.uid}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(uid);
}

class _HomePageState extends State<HomePage> {
  final String uid;
  _HomePageState(this.uid);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data;
            return Adminhome(user: user);
          } else {
            return Loginscreen();
          }
        });
  }
}
