import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:work/webViewContainer.dart';

class navigate extends StatefulWidget {
  @override
  _navigateState createState() => _navigateState();
}

class _navigateState extends State<navigate> {
  String filepath = 'asset/check.html';
  WebViewController _webViewController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

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
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: WebView(
            initialUrl: '',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webviewcontroller) {
              _webViewController = webviewcontroller;
              _loadHTMLFromAssets();
            },
          )),

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
                        builder: (context) =>
                            WebViewContainer('https://www.flipkart.com/')));
              }
              break;
          }

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             WebViewContainer('https://www.flipkart.com/')));
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
      // floatingActionButton: FutureBuilder<WebViewController>(
      //     future: _controller.future,
      //     builder: (BuildContext context,
      //         AsyncSnapshot<WebViewController> controller) {
      //       if (controller.hasData) {
      //         return FloatingActionButton(
      //           onPressed: () async {
      //             controller.data.reload();
      //           },
      //           child: const Icon(Icons.refresh),
      //         );
      //       }
      //       return Container();
      //     }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Widget _urlButton(BuildContext context, String url) {
  //   return Container(
  //       padding: EdgeInsets.all(20.0),
  //       child: FloatingActionButton(
  //           elevation: 20.0,
  //           splashColor: Colors.pink,
  //           shape: StadiumBorder(),
  //           child: Icon(
  //             Icons.refresh,
  //             color: Colors.white,
  //           ),
  //           onPressed: () => _checkInternetConnectivity()));
  // }

  _loadHTMLFromAssets() async {
    String fileHtmlContects = await rootBundle.loadString(filepath);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContects,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }

  _checkInternetConnectivity() async {
    var url = "https://www.flipkart.com/";
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return print("Hello");
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      _handleURLButtonPress(context, url);
    }
  }
}
