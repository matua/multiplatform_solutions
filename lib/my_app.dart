import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import 'views/PageContentWidget.dart';
import 'views/cors_header_widget.dart';
import 'views/header_widget.dart';
import 'views/load_button_widget.dart';
import 'views/operating_system_widget.dart';
import 'views/url_widget.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController textEditingController = TextEditingController();
  String siteHeader = '';
  String? corsHeader = '';
  String pageContent = '';
  String operatingSystem = kIsWeb ? 'web' : Platform.operatingSystem;

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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                HeaderWidget(siteHeader: siteHeader),
                CorsHeaderWidget(corsHeader: corsHeader),
                PageContentWidget(pageContent: pageContent),
                const Divider(color: Colors.grey),
                Row(
                  children: <Widget>[
                    UrlWidget(textEditingController: textEditingController),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          _loadPage(textEditingController.text);
                        },
                        child: LoadButtonWidget(),
                      ),
                    ),
                  ],
                ),
                OperatingSystemWidget(operatingSystem: operatingSystem),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String _formatUrl(String text) {
    if (!text.startsWith('https://')) {
      return 'https://' + text;
    }
    return text;
  }

  void _loadPage(String url) async {
    try {
      http.Response response = await http.get(
        Uri.parse(_formatUrl(url)),
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        setState(() {
          pageContent = response.body;
          siteHeader = parse(pageContent).getElementsByTagName('title')[0].text.trim();
          corsHeader = response.headers['access-control-allow-origin'];
          corsHeader ??= 'None';
        });
      } else {
        setState(() {
          pageContent = 'Page could not be loaded';
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        pageContent = 'Page could not be loaded';
      });
    }
  }
}
