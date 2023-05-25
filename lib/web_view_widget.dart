import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatelessWidget {
  final String url;
  late WebViewController webViewController;

  WebViewExample({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController web) {
                webViewController = web;
              },
            )));
  }
}