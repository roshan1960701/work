import 'dart:async';
import 'package:flutter/material.dart';
import 'package:work/form.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void completed() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => form()));
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: new BorderRadius.circular(10.0),
                child: Image.asset(
                  "asset/1aidlogo.png",
                  width: 100,
                  height: 100,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.asset(
                "asset/heartbeat.gif",
                width: 120,
              ),
            )
          ],
        ),
      ),
    );
  }
}
