import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import 'utility.dart';
import 'views/cors_header_widget.dart';
import 'views/header_widget.dart';
import 'views/load_url_widget.dart';
import 'views/page_content_widget.dart';
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
                        child: LoadUrlWidget(),
                      ),
                    ),
                  ],
                ),
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

  void _loadPage(String url) async {
    try {
      http.Response response = await http.get(
        Uri.parse(formatUrl(url)),
      );
      if (response.statusCode == 200) {
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
      setState(() {
        pageContent = 'Page could not be loaded';
      });
    }
  }
}
