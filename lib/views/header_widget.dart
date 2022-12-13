import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.siteHeader,
  }) : super(key: key);

  final String siteHeader;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        child: Text(
          siteHeader,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
