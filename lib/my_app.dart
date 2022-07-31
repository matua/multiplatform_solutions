import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController textEditingController = TextEditingController();
  String operatingSystem = kIsWeb ? 'web' : Platform.operatingSystem;
  String? corsHeader = '';
  String webViewUrl = '';
  WebViewController? _controller;

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
                      webViewUrl == ''
                          ? Expanded(
                              child: Column(),
                            )
                          : FutureBuilder<http.Response>(
                              future: _loadPage(webViewUrl),
                              builder: (BuildContext context,
                                  AsyncSnapshot<http.Response> snapshot) {
                                http.Response? response = snapshot.data;
                                return (snapshot.hasData)
                                    ? Expanded(
                                        child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            response?.statusCode == 400
                                                ? 'None'
                                                : parse(response?.body)
                                                    .getElementsByTagName(
                                                        'title')[0]
                                                    .text
                                                    .trim(),
                                            style: TextStyle(
                                                fontSize: 27,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'CORS Header: ${response?.headers['access-control-allow-origin']}',
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: WebView(
                                                initialUrl: webViewUrl,
                                                onWebViewCreated:
                                                    (WebViewController
                                                        webViewController) {
                                                  _controller =
                                                      webViewController;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                    : Expanded(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                              }),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              onSubmitted: (String url) {
                                String formattedUrl =
                                    _formatUrl(textEditingController.text);
                                _loadUrl(formattedUrl);
                                setState(() {
                                  _controller?.loadUrl(formattedUrl);
                                });
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
                              String formattedUrl =
                                  _formatUrl(textEditingController.text);
                              _loadUrl(formattedUrl);
                              setState(() {
                                _controller?.loadUrl(formattedUrl);
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Application running on $operatingSystem',
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

  Future<void> _loadUrl(String userUrl) async {
    setState(() {
      webViewUrl = userUrl;
    });
  }

  Future<http.Response> _loadPage(String url) async {
    if (url.isNotEmpty) {
      try {
        http.Response response = await http.get(
          Uri.parse(url),
        );
        if (response.statusCode == 200) {
          corsHeader = response.headers['access-control-allow-origin'];
          corsHeader ??= 'None';
          return response;
        } else {
          return http.Response.bytes(
              utf8.encode('Page could not be loaded'), 400);
        }
      } catch (e) {
        return http.Response.bytes(
            utf8.encode('Page could not be loaded'), 400);
      }
    } else {
      return http.Response('Not loaded', 400);
    }
  }

  String _formatUrl(String text) {
    if (!text.startsWith('https://')) {
      return 'https://' + text;
    }
    return text;
  }
}
