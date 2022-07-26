import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

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

  void _loadPage(String url) async {
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        setState(() {
          pageContent = response.body;
          siteHeader =
              parse(pageContent).getElementsByTagName('title')[0].text.trim();
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
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Text(
                      siteHeader,
                      style: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'CORS Header: $corsHeader',
                    style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Text(pageContent),
                    )),
                const Divider(color: Colors.grey),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: TextField(
                        keyboardAppearance: Brightness.dark,
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          labelText: 'URL',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          _loadPage(textEditingController.text);
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
                    )
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
}
