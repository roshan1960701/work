import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shared_preferences/shared_preferences.dart';

class form extends StatefulWidget {
  @override
  _formState createState() => _formState();
}

class _formState extends State<form> {
  SharedPreferences logindata;
  bool newuser;

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    if (newuser == false) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return OfflineBuilder(
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    height: 32.0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: connected ? null : Color(0xFFEE4400),
                      child: connected
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "OFFLINE",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                SizedBox(
                                  width: 12.0,
                                  height: 12.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              );
            },
            child: SafeArea(
                child: WebviewScaffold(
              url: 'http://128.199.21.167/partner/login',
              withZoom: false,
              key: UniqueKey(),
              withJavascript: true,
              withLocalStorage: true,
            )));
      },
    ));
  }
}
