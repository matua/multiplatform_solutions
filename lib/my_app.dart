import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiplatform_solutions/utility.dart';
import 'package:multiplatform_solutions/views/os_widget.dart';
import 'package:webviewx/webviewx.dart';

import 'views/load_button_widget.dart';
import 'views/url_widget.dart';

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
  bool isLoading = true;

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
                      return Stack(children: <Widget>[
                        WebViewX(
                          initialContent: 'https://skillbox.ru',
                          initialSourceType: SourceType.urlBypass,
                          onWebViewCreated: (WebViewXController<dynamic> controller) => webViewController = controller,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          onPageFinished: (String src) {
                            setState(() {
                              isLoading = false;
                            });
                          },
                          onPageStarted: (String src) {
                            setState(() {
                              isLoading = true;
                            });
                          },
                        ),
                        isLoading
                            ? LinearProgressIndicator(
                                minHeight: 10,
                              )
                            : Stack(),
                      ]);
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(children: <Widget>[
                    UrlWidget(textEditingController: textEditingController),
                    ElevatedButton(
                      onPressed: () {
                        webViewController.loadContent(formatUrl(textEditingController.text), SourceType.urlBypass);
                      },
                      child: LoadButtonWidget(),
                    ),
                  ]),
                ),
                osWidget(operatingSystem: operatingSystem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
