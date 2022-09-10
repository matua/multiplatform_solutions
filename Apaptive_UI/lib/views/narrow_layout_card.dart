import 'package:flutter/material.dart';

class NarrowLayoutCard extends StatelessWidget {
  const NarrowLayoutCard(
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lastName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 21),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  firstName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
