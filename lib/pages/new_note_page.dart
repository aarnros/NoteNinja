import 'package:flutter/material.dart';
import 'package:note_ninja/pages/saved_notes_page.dart';
import '../widgets/note.dart';
import 'package:note_ninja/pages/home_page.dart';

class NewNotePage extends StatefulWidget {
  _NewNotePage createState() => _NewNotePage();
}

class _NewNotePage extends State<NewNotePage> {
  String noteTitle = '';
  String noteBody = '';

  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _bodyTextController = TextEditingController();

  void titleTextChange() {
    setState(() {
      noteTitle = _titleTextController.text.trim();
    });
  }

  void bodyTextChange() {
    setState(() {
      noteBody = _bodyTextController.text.trim();
    });
  }

  @override
  void initState() {
    super.initState();
    _titleTextController.addListener(titleTextChange);
    _bodyTextController.addListener(bodyTextChange);
  }

  @override
  void dispose() {
    _bodyTextController.dispose();
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedNotesPage(),
                ))
          },
        ),
        title: NoteTitleEntry(_titleTextController),
      ),
      body: NoteEntry(_bodyTextController),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Save Note',
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          }),
    ));
  }
}

class NoteTitleEntry extends StatelessWidget {
  final _textFieldController;

  NoteTitleEntry(this._textFieldController);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textFieldController,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(0),
        counter: null,
        counterText: "",
        hintText: 'Title',
        hintStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          height: 1.5,
        ),
      ),
      maxLength: 31,
      maxLines: 1,
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        height: 1.5,
        color: Color(0xFFFDFFFC),
      ),
      textCapitalization: TextCapitalization.words,
    );
  }
}

class NoteEntry extends StatelessWidget {
  final _textFieldController;

  NoteEntry(this._textFieldController);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        controller: _textFieldController,
        maxLines: null,
        textCapitalization: TextCapitalization.sentences,
        decoration: null,
        style: TextStyle(
          fontSize: 19,
          height: 1.5,
        ),
      ),
    );
  }
}
