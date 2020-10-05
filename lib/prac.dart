import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class prac extends StatefulWidget {
  @override
  _pracState createState() => _pracState();
}

class _pracState extends State<prac> {
  bool connectionStatus = true;
  final _key = UniqueKey();

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectionStatus = true;
      }
    } on SocketException catch (_) {
      connectionStatus = false;
    }
  }

  @override
  void initState() {
    // check();
    // _checkInternetConnectivity();
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkInternet();
    return Scaffold(
      body: SafeArea(
          child: WebviewScaffold(
        url: 'http://128.199.21.167/partner/login',
        withZoom: false,
        key: UniqueKey(),
        withJavascript: true,
        withLocalStorage: true,
      )),
    );
  }
}
