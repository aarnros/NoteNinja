class Note {
  int noteId;
  String title;
  String body;

  Note({this.noteId = 0, this.title = "Note", this.body = 'Body'});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    if (noteId != 0) {
      data['noteId'] = noteId;
    }
    data['title'] = title;
    data['body'] = body;
    return data;
  }

  @override
  String toString() {
    return {
      'noteId': noteId,
      'title': title,
      'body': body,
    }.toString();
  }
}
