import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

Text webTitle(Response? response) => Text(
      response?.statusCode == 400 ? 'None' : parse(response?.body).getElementsByTagName('title')[0].text.trim(),
      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
    );

Text corsHeader(Response? response) {
  String? corsHeader = response?.headers['access-control-allow-origin'] == null
      ? 'None'
      : response?.headers['access-control-allow-origin'];
  return Text(
    'CORS Header: $corsHeader',
    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.red),
  );
}
