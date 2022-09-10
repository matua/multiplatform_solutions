import 'package:flutter/material.dart';

class WideLayoutCard extends StatelessWidget {
  const WideLayoutCard(
      {Key? key,
      required this.imageUrl,
      required this.firstName,
      required this.lastName,
      required this.email})
      : super(key: key);

  final String imageUrl;
  final String firstName;
  final String lastName;
  final String email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        children: [
          CircleAvatar(child: Image.network(imageUrl)),
          Row(
            children: [
              Text(
                firstName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                lastName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(email),
        ],
      ),
    );
  }
}
