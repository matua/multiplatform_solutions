import 'package:adaptive_ui/views/narrow_layout_card.dart';
import 'package:flutter/material.dart';

import '../data/model/person.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({Key? key, required this.persons}) : super(key: key);

  final List<Person> persons;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          return NarrowLayoutCard(
            imageUrl: persons[index].imageUrl,
            firstName: persons[index].firstName,
            lastName: persons[index].lastName,
            email: persons[index].email,
          );
        });
  }
}
