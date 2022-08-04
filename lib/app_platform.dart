import 'dart:io';

import 'package:flutter/foundation.dart';

class AppPlatform {
  static const Map<String, CustomPlatform> _platformMap = {
    'android': CustomPlatform.android,
    'linux': CustomPlatform.linux,
    'macos': CustomPlatform.macos,
    'windows': CustomPlatform.windows,
    'ios': CustomPlatform.ios,
    'web': CustomPlatform.web,
  };

  static CustomPlatform _getPlatform() {
    if (kIsWeb) {
      return CustomPlatform.web;
    }
    return _platformMap[Platform.operatingSystem] ?? CustomPlatform.undefined;
  }

  static CustomPlatform get platform => _getPlatform();

  static bool get isMobile =>
      platform == CustomPlatform.ios || platform == CustomPlatform.android;
}

enum CustomPlatform {
  android,
  linux,
  macos,
  windows,
  ios,
  web,
  undefined,
}
