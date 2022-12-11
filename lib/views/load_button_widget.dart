import 'package:flutter/material.dart';

class LoadButtonWidget extends StatelessWidget {
  const LoadButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25,
      width: 50,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'LOAD',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
