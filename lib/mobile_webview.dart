import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'info_change_notifier.dart';
import 'utility.dart';

class CommonWebView extends StatefulWidget {
  CommonWebView({
    Key? key,
    required this.loadingPercentage,
    this.webViewControllerCompleter,
    this.controller,
  }) : super(key: key);

  late final int loadingPercentage;
  final Completer<WebViewController>? webViewControllerCompleter;
  final AsyncSnapshot<WebViewController>? controller;

  @override
  State<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
      onWebViewCreated: (WebViewController webViewController) {
        widget.webViewControllerCompleter?.complete(webViewController);
      },
      onPageStarted: (String url) async {
        String? corsHeader = await getCorsHeader(url);
        Provider.of<Info>(context, listen: false).updateCorsHeader(corsHeader!);
        setState(() {
          widget.loadingPercentage = 0;
        });
      },
      onProgress: (int progress) {
        setState(() {
          widget.loadingPercentage = progress;
        });
      },
      onPageFinished: (String url) async {
        String? title = await widget.controller?.data?.getTitle();
        Provider.of<Info>(
          context,
          listen: false,
        ).updateTitle(title!);
        setState(() {
          widget.loadingPercentage = 100;
        });
      },
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
