import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class form extends StatefulWidget {
  @override
  _formState createState() => _formState();
}

class _formState extends State<form> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'https://upload.photobox.com/en/',
      withZoom: false,
      key: UniqueKey(),
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}
