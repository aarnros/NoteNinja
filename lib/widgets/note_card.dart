import 'package:flutter/material.dart';
import 'package:note_ninja/widgets/note.dart';
import "../widgets/note_data.dart";
import '../pages/saved_notes_page.dart';
import '../pages/new_note_page.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blueAccent,
          //Clicking Function
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewNotePage(note: note, isNew: false)));
            ;
          },
          child: SizedBox(
            width: 1000,
            height: 100,
            child: Text(
              note.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
