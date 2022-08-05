import 'package:flutter/material.dart';

class Info extends ChangeNotifier {
  String? title = 'None';
  String? corsHeader = 'None';

  void updateTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  void updateCorsHeader(String newCorsHeader) {
    corsHeader = newCorsHeader;
    notifyListeners();
  }
}
