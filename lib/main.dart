import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/Mysharedpreference.dart';
import 'package:work/Splashscreen.dart';
import 'package:work/form.dart';
import 'package:work/loginform.dart';
import 'package:work/nextPage.dart';
import 'package:work/offline.dart';
import 'package:work/onboarding.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  // static const PrimaryColor = Color(0xFF69F0AE);
  final custom_color = const Color(0xFF69F0AE);
  // Colors _colors = Color(int.parse(0xFF00897B));
  // bool isFirstTimeOpen = false;

  // MyAppState() {
  //   MySharedPreferences.instance
  //       .getBooleanValue("firstTimeOpen")
  //       .then((value) => setState(() {
  //             isFirstTimeOpen = value;
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "1Aid",
      theme: ThemeData(
        primaryColor: Color(0xFF00897B),
        // primarySwatch: Colors.green,
      ),
      home: homepage(),
      //  isFirstTimeOpen ? onboarding() : Splashscreen(),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Splashscreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new onboarding()));
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    checkFirstSeen();
    return Scaffold();
  }
}
