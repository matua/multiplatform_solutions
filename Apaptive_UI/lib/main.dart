import 'dart:convert';

import 'package:adaptive_ui/views/narrow_layout.dart';
import 'package:adaptive_ui/views/wide_layout.dart';
import 'package:flutter/material.dart';

import 'data/model/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive & Adaptive design',
      home: SafeArea(
        child: Scaffold(
          body: FutureBuilder<String>(
            future: jsonToString(context, 'assets/people.json'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  var listOfPersonsFromJsonFile =
                      (jsonDecode(snapshot.data!) as List<dynamic>);
                  if (constraints.maxWidth < 720) {
                    return NarrowLayout(
                        key: const PageStorageKey<String>('list'),
                        persons: (listOfPersonsFromJsonFile
                            .map((dynamic person) =>
                                Person.fromJson(person as Map<String, dynamic>))
                            .toList()));
                  } else {
                    return WideLayout(
                        key: const PageStorageKey<String>('list'),
                        persons: (listOfPersonsFromJsonFile
                            .map((dynamic person) =>
                                Person.fromJson(person as Map<String, dynamic>))
                            .toList()));
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> jsonToString(BuildContext context, String url) async {
    return await DefaultAssetBundle.of(context).loadString(url);
  }
}
