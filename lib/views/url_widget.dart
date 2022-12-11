import 'package:flutter/material.dart';

class UrlWidget extends StatelessWidget {
  const UrlWidget({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardAppearance: Brightness.dark,
        controller: textEditingController,
        decoration: const InputDecoration(
          labelText: 'URL',
        ),
      ),
    );
  }
}
