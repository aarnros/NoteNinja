import 'package:flutter/material.dart';
import '../widgets/note.dart';
import '../widgets/note_data.dart';

class NewNotePage extends StatelessWidget {
  Note note;
  bool isNew;
  NewNotePage({super.key, required this.note, required this.isNew});
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
  }

  void updateOnBack() {
    note.updateBody(_bodyController.text);
    note.updateTitle(_titleController.text);
  }

  void updateTextFields() {
    _titleController = TextEditingController(text: note.title);
    _bodyController = TextEditingController(text: note.body);
  }

  @override
  Widget build(BuildContext context) {
    updateTextFields();
    return Scaffold(
      appBar: AppBar(
        title: TitleEntry(_titleController),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => {
            updateOnBack(),
            Navigator.popUntil(context, (route) => route.isFirst)
          },
        ),
      ),
      body: NoteEntry(_bodyController),
    );
  }
}

class TitleEntry extends StatelessWidget {
  final __textFieldController;

  TitleEntry(this.__textFieldController);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: __textFieldController,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(0),
        counter: null,
        counterText: "",
      ),
      maxLength: 31,
      maxLines: 1,
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        height: 1.5,
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
