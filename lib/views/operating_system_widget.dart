import 'package:flutter/material.dart';

class OperatingSystemWidget extends StatelessWidget {
  const OperatingSystemWidget({
    Key? key,
    required this.operatingSystem,
  }) : super(key: key);

  final String operatingSystem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Application running on $operatingSystem',
        style: TextStyle(
          fontSize: 21.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
