import 'dart:async';

import 'package:dailyfactsng/widgets/general/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  WebViewPage({this.title, this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: Text(widget.title), actions: [
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _controller?.reload();
            }),
        IconButton(
            icon: Icon(Icons.web),
            onPressed: () {
              launch(widget.url);
            })
      ]),
      body: WebView(
        initialUrl: 'http://'+'www.google.com',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
      ),
    );
  }
}
