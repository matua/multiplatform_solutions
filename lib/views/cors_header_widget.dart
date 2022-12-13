import 'package:flutter/material.dart';

class CorsHeaderWidget extends StatelessWidget {
  const CorsHeaderWidget({
    Key? key,
    required this.corsHeader,
  }) : super(key: key);

  final String? corsHeader;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        'CORS Header: $corsHeader',
        style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }
}
