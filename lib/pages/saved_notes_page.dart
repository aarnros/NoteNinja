import 'package:flutter/material.dart';
import '../widgets/note_card.dart';
import '../pages/new_note_page.dart';

class SavedNotesPage extends StatelessWidget {
  //List that the grid uses to generate, index is the number of notes
  final List<Map> myNotes =
      List.generate(1000, (index) => {"id": index, "name": "Note $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            //This creates a Grid that has a scroll function
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemCount: myNotes.length,
            itemBuilder: (_, index) {
              return NoteCard();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'New Note',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewNotePage()),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(title: Text('Notes')),
      ),
    );
  }
}
