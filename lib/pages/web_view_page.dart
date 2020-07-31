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
  bool pageLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: Text(widget.title), actions: [
        pageLoading
            ? Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: new CircularProgressIndicator(backgroundColor: Colors.white,),
                ),
              )
            : IconButton(
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
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageStarted: (String url) {
          setState(() {
            pageLoading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            pageLoading = false;
          });
        },
      ),
    );
  }
}
