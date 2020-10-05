import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class offline extends StatefulWidget {
  @override
  _offlineState createState() => _offlineState();
}

class _offlineState extends State<offline> {
  bool connectionStatus;

  // checkInternet() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       connectionStatus = true;
  //     }
  //   } on SocketException catch (_) {
  //     connectionStatus = false;
  //   }
  // }

  @override
  void initState() {
    // check();
    // _checkInternetConnectivity();
    // checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //checkInternet();
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Builder(
          builder: (BuildContext context) {
            return OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity != ConnectivityResult.none;
                connectionStatus = connected;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      height: 24.0,
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
              child: connectionStatus
                  ? Stack(
                      children: <Widget>[
                        Text(
                          "Connection iS Avilable",
                          style: TextStyle(color: Colors.green),
                        )
                      ],
                    )
                  : Stack(
                      children: <Widget>[
                        Text(
                          "Connection iS Not Avilable",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
            );
          },
        ));
  }
}
