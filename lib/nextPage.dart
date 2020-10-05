import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:work/webViewContainer.dart';
import 'package:work/form.dart';
import 'dart:async';
import 'dart:io';
import 'package:work/loginform.dart';

class nextPage extends StatefulWidget {
  @override
  _nextPageState createState() => _nextPageState();
}

class _nextPageState extends State<nextPage> {
  final _links = ['https://www.flipkart.com/'];
  var connectivityResult = new Connectivity().checkConnectivity();

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10.0,
          title: Text(
            "WebView",
          ),
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:
                    _links.map((link) => _urlButton(context, link)).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => form()));
                },
                color: Colors.green,
                minWidth: 140.0,
                height: 40.0,
                elevation: 10.0,
                shape: StadiumBorder(),
                child: Text(
                  "Form",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginform()));
                },
                color: Colors.green,
                minWidth: 140.0,
                height: 40.0,
                elevation: 10.0,
                shape: StadiumBorder(),
                child: Text(
                  "Login Form",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _urlButton(BuildContext context, String url) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: MaterialButton(
            elevation: 20.0,
            splashColor: Colors.pink,
            shape: StadiumBorder(),
            minWidth: 100.0,
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
            child: Text(
              url,
            ),
            onPressed: () => _checkInternetConnectivity()));
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }

  _checkInternetConnectivity() async {
    var url = "https://www.flipkart.com/";
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog("No Internet", "You are not connectec to a network");
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      _handleURLButtonPress(context, url);
    }
  }

  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }
}
