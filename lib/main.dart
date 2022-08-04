import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'my_app.dart';

void main() {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  runApp(MyApp(
    controller: controller,
  ));
}
