import 'package:flutter/material.dart';

class Info extends ChangeNotifier {
  String? title = 'None';
  String? headers = 'None';

  void updateInfo(String newTitle) {
    title = newTitle;
    notifyListeners();
  }
}
