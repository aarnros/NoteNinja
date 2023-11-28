import 'note.dart';

class NoteData {
  List<Note> noteList = [
    Note(noteId: 0, body: "Body", title: "Test"),
    Note(noteId: 1, body: "Body", title: "Title 2"),
    Note(noteId: 2, body: "Body", title: "362 Notes"),
    Note(noteId: 3, body: "Body", title: "340 Notes")
  ];

  List<Note> getNoteList() {
    return noteList;
  }

  void addNewNote(Note note) {
    noteList.add(note);
  }

  int getLength() {
    return noteList.length;
  }

  void updateNote(Note note, String body, String title) {
    for (int i = 0; i < noteList.length; i++) {
      if (noteList[i].noteId == note.noteId) {
        noteList[i].body = body;
        noteList[i].title = title;
      }
    }
  }

  void deleteNote(Note note) {
    noteList.remove(note);
  }
}
