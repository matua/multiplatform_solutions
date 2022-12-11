import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webviewx/webviewx.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController textEditingController = TextEditingController();
  String operatingSystem = kIsWeb ? 'web' : Platform.operatingSystem;
  String webViewUrl = '';
  late WebViewXController<dynamic> webViewController;

  @override
  void dispose() {
    webViewController.dispose();
    super.dispose();
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Builder(builder: (context) {
                      return WebViewX(
                        onWebViewCreated: (WebViewXController<dynamic> controller) => webViewController = controller,
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardAppearance: Brightness.dark,
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          labelText: 'URL',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        webViewController.loadContent(textEditingController.text, SourceType.urlBypass);
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
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Application running on $operatingSystem',
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
