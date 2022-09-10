import 'package:adaptive_ui/views/wide_layouta_card.dart';
import 'package:flutter/material.dart';

import '../data/model/person.dart';

class WideLayout extends StatelessWidget {
  const WideLayout({Key? key, required this.persons}) : super(key: key);

  final List<Person> persons;

  @override
  Widget build(BuildContext context) {
    print(persons);
    return ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          return WideLayoutCard(
            imageUrl: persons[index].imageUrl,
            firstName: persons[index].firstName,
            lastName: persons[index].lastName,
            email: persons[index].email,
          );
        });
  }
}
