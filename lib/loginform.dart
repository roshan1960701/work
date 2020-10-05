import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginform extends StatefulWidget {
  @override
  _loginformState createState() => _loginformState();
}

class _loginformState extends State<loginform> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  // final username_controller = TextEditingController();
  // final password_controller = TextEditingController();

  SharedPreferences logindata;
  bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);

    if (newuser == false) {
      Navigator.pop(context);
    }

    // if (newuser == true) {
    //   show();
    // }
  }

  // void show() {
  //   WebviewScaffold(url: 'http://128.199.21.167/partner/dashboard');
  // }

  @override
  Widget build(BuildContext context) {
    String loginUrl = "http://128.199.21.167/partner/login";
    return WebviewScaffold(
      url: loginUrl,
    );
  }
}
