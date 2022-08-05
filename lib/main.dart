import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_change_notifier.dart';
import 'my_app.dart';

void main() {
  runApp(ChangeNotifierProvider<Info>(
      create: (BuildContext context) => Info(), child: MyApp()));
}
