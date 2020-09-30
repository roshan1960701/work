import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:work/navigate.dart';

class WebViewContainer extends StatefulWidget {
  final url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  var result;
  var result1;
  final _links = ['https://www.flipkart.com/'];
  bool connectionStatus = false;
  String filepath = 'asset/check.html';
  WebViewController _webViewController;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  DateTime backbuttonpressedTime;

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
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    checkInternet();
    // _checkInternetConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  _WebViewContainerState(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: connectionStatus
            ? WebView(
                initialUrl: '',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webviewcontroller) {
                  _webViewController = webviewcontroller;
                  _loadHTMLFromAssets();
                },
              )
            : WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _url,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        onPressed: () {
          checkInternet();
          switch (connectionStatus) {
            case false:
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => navigate()));
              }
              break;
            default:
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewContainer(_url)));
              }
              break;
          }
        },
        tooltip: "Refresh",
        child: Icon(
          Icons.refresh,
          color: Colors.white,
          size: 25.0,
        ),
        backgroundColor: Colors.green,
        focusElevation: 10.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _loadHTMLFromAssets() async {
    String fileHtmlContects = await rootBundle.loadString(filepath);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContects,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  _checkInternetConnectivity() async {
    var url = "https://www.flipkart.com/";

    result1 = await Connectivity().checkConnectivity();

    if (result1 == ConnectivityResult.none) {
      return Text("Hello");
    } else if (result1 == ConnectivityResult.mobile ||
        result1 == ConnectivityResult.wifi) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: Expanded(
            child: WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _url)),
      );
    }
  }
}
