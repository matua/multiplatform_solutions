import 'package:adaptive_ui/views/narrow_layout_card.dart';
import 'package:flutter/material.dart';

import '../data/model/person.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({Key? key, required this.persons}) : super(key: key);

  final List<Person> persons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          child: const Center(
            child: Text(
              'Adaptive App',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                return NarrowLayoutCard(
                  imageUrl: persons[index].imageUrl,
                  firstName: persons[index].firstName,
                  lastName: persons[index].lastName,
                  email: persons[index].email,
                );
              }),
        ),
      ],
    );
  }
}
