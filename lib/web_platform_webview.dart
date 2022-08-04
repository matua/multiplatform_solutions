import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class PlatformWebView extends StatelessWidget {
  PlatformWebView({
    Key? key,
    required this.link,
  }) : super(key: key);
  final String link;

  @override
  Widget build(BuildContext context) {
    final String id = Random().nextInt.toString();
    ui.platformViewRegistry
        .registerViewFactory(id, (int viewId) => IFrameElement()..src = link);
    return HtmlElementView(viewType: id);
  }
}
