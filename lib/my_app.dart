import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app_platform.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final Completer<WebViewController> controller;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController textEditingController = TextEditingController();
  String? corsHeader = '';
  String? title = '';
  int loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: const Text('App'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Title: $title',
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'CORS Header:',
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      WebView(
                                        initialUrl: 'https://flutter.dev',
                                        onWebViewCreated: (WebViewController
                                            webViewController) {
                                          widget.controller
                                              .complete(webViewController);
                                        },
                                        onPageStarted: (String url) {
                                          setState(() {
                                            loadingPercentage = 0;
                                          });
                                        },
                                        onProgress: (int progress) {
                                          setState(() {
                                            loadingPercentage = progress;
                                          });
                                        },
                                        onPageFinished: (String url) {
                                          setState(() {
                                            loadingPercentage = 100;
                                          });
                                        },
                                        navigationDelegate:
                                            (NavigationRequest navigation) {
                                          final String host =
                                              Uri.parse(navigation.url).host;
                                          if (host.contains('youtube.com')) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Blocking navigation to $host',
                                                ),
                                              ),
                                            );
                                            return NavigationDecision.prevent;
                                          }
                                          return NavigationDecision.navigate;
                                        },
                                        javascriptMode:
                                            JavascriptMode.unrestricted,
                                      ),
                                      if (loadingPercentage < 100)
                                        LinearProgressIndicator(
                                          value: loadingPercentage / 100.0,
                                          minHeight: 30,
                                        ),
                                    ],
                                  ))),
                        ],
                      )),
                      FutureBuilder<WebViewController>(
                        future: widget.controller.future,
                        builder: (BuildContext context,
                            AsyncSnapshot<WebViewController> controller) {
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  onSubmitted: (String url) {
                                    controller.data!.loadUrl(
                                        _formatUrl(textEditingController.text));
                                  },
                                  keyboardAppearance: Brightness.dark,
                                  controller: textEditingController,
                                  decoration: const InputDecoration(
                                    labelText: 'URL',
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.data!.loadUrl(
                                      _formatUrl(textEditingController.text));
                                  setState(() {
                                    title =
                                        controller.data?.getTitle().toString();
                                    print('title: $title');
                                  });
                                },
                                child: const SizedBox(
                                  height: 25,
                                  width: 50,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'LOAD',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Application running on ${AppPlatform.platform}',
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  String _formatUrl(String text) {
    if (!text.startsWith('https://')) {
      return 'https://' + text;
    }
    return text;
  }
}
