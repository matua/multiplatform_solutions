import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

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
    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          transitionDuration: const Duration(milliseconds: 150),
          bodyBuilder: (context) => const ListItems(),
          direction: PopoverDirection.right,
          width: MediaQuery.of(context).size.width / 9,
          height: MediaQuery.of(context).size.width / 6,
          arrowHeight: 10,
          arrowWidth: 200,
        );
      },
      child: Card(
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 21),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  lastName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ],
            ),
            Text(email),
          ],
        ),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: const Icon(Icons.person),
          title: const Text('View Profile'),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: const Icon(Icons.people),
          title: const Text('Friends'),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: const Icon(Icons.report),
          title: const Text('Report'),
        ),
      ],
    );
  }
}
