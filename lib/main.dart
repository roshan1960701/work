import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:work/files/form.dart';
import 'package:work/webViewContainer.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WebView",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _links = ['https://www.flipkart.com/'];
  var connectivityResult = new Connectivity().checkConnectivity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          )
        ],
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
