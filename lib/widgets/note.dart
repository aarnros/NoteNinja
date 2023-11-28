class Note {
  int noteId;
  String title;
  String body;

  Note({required this.noteId, required this.body, required this.title});

  void updateTitle(String newTitle) {
    this.title = newTitle;
  }

  void updateBody(String newBody) {
    this.body = newBody;
  }

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
