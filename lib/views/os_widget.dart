import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class osWidget extends StatelessWidget {
  const osWidget({required this.operatingSystem, Key? key}) : super(key: key);
  final String operatingSystem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Application running on $operatingSystem',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}

String getOperatingSystem() {
  return kIsWeb ? 'web' : Platform.operatingSystem;
}
