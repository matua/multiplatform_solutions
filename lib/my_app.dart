import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiplatform_solutions/mobile_webview.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app_platform.dart';
import 'info_change_notifier.dart';
// import 'src/hw_none.dart' // Stub implementation
//     if (dart.library.io) 'src/mobile_webview.dart' // dart:io implementation
//     if (dart.library.html) 'src/hw_html.dart';

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);
  final Completer<WebViewController> webViewControllerCompleter =
      Completer<WebViewController>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController textEditingController = TextEditingController();
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
              child: FutureBuilder<WebViewController>(
                  future: widget.webViewControllerCompleter.future,
                  builder: (BuildContext context,
                      AsyncSnapshot<WebViewController> controller) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Title: ${Provider.of<Info>(
                                  context,
                                ).title}',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'CORS Header: ${Provider.of<Info>(
                                  context,
                                ).corsHeader}',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Expanded(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: Stack(
                                        children: <Widget>[
                                          CommonWebView(
                                            loadingPercentage:
                                                loadingPercentage,
                                            controller: controller,
                                            webViewControllerCompleter: widget
                                                .webViewControllerCompleter,
                                          ),
                                          if (loadingPercentage < 100)
                                            LinearProgressIndicator(
                                              value: loadingPercentage / 100,
                                              minHeight: 30,
                                            ),
                                        ],
                                      ))),
                            ],
                          )),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  onSubmitted: (String url) async {
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
                        ]);
                  }),
            ),
          ),
        ),
      ),
    );
  }

  String _formatUrl(String text) {
    if (!text.startsWith('https://')) {
      return 'https://' + text;
    }
    return text;
  }
}
