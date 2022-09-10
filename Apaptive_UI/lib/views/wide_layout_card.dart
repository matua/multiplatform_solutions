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
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(21.0),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width / 3 * 0.3,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firstName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                lastName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
            ],
          ),
          Text(email),
        ],
      ),
    );
  }
}
