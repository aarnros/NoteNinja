import 'package:flutter/material.dart';
import '../widgets/note_card.dart';

class SavedNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const NoteCard(),
                  const NoteCard(),
                  const NoteCard()
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'New Note',
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Notes'),
          backgroundColor: const Color.fromARGB(255, 255, 195, 177),
        ),
      ),
    );
  }
}
