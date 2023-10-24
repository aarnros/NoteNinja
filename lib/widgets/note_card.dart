import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blueAccent,
          //Clicking Function
          onTap: () {
            debugPrint('Note Tapped');
          },
          child: const SizedBox(
            width: 200,
            height: 100,
            child: Text(
              'Your Note Here',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
