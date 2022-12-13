import 'package:flutter/material.dart';

class PageContentWidget extends StatelessWidget {
  const PageContentWidget({
    Key? key,
    required this.pageContent,
  }) : super(key: key);

  final String pageContent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: SingleChildScrollView(
          child: Text(pageContent),
        ));
  }
}
