import 'package:flutter/material.dart';
import 'package:note_ninja/widgets/note.dart';
import 'package:provider/provider.dart';
import '../widgets/note_card.dart';
import '../pages/new_note_page.dart';
import '../widgets/note_data.dart';

class SavedNotesPage extends StatefulWidget {
  //List that the grid uses to generate, index is the number of notes
  const SavedNotesPage({super.key});

  @override
  State<SavedNotesPage> createState() => _savedNotesPage();
}

class _savedNotesPage extends State<SavedNotesPage> {
  final noteList = NoteData();

  Note createNewNote() {
    Note newNote =
        Note(noteId: noteList.getNoteList().length, body: '', title: 'Title');
    noteList.addNewNote(newNote);
    return newNote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Your Notes"),
      ),
      body: ListView.builder(
        itemCount: noteList.getLength(),
        itemBuilder: (context, index) {
              return NoteCard(
            note: noteList.getNoteList()[index],
          );
            },
          ),
                floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                    builder: (context) =>
                        NewNotePage(note: createNewNote(), isNew: true)));
            setState(
                () {}); //The cards will not update unless the state is updated
          }),
      );
  }
}
